Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B1E9A75D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ymx-000820-9v; Tue, 24 Mar 2026 06:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ymv-00081J-UX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:15:05 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ymu-00048r-C6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:15:05 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79800183233so63311247b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774347303; cv=none;
 d=google.com; s=arc-20240605;
 b=kV76NH8EmVyOjpFmOsEOgagLybfmJcdXWlkiQg8KkVaeLL0fhSWe3dihe2gryNCn7I
 gG+AFdfSwF6/CPHoLE6su5u4cqqbgDDeBxxhw+DYAXAdlyTJtwVZX3N9az3DIaYWxJ88
 U1exb/Dp03GUL/WO6hdSSRoisy2wczonfFGd3RMYcxyUSKmD+ht0dgcumzp1FcHlO+mG
 3mufyOtha+PCEnECFRFsqaifrHzzomLHSBAC8FrjdfvLve7Vv+8sYO8B9I592uW/xjgD
 5TsjkQ+ZJSe0VlDU4DON7b5VUThSFRsLr03Y7ReG1yAZ381m3IJbxnD4nekJk51blGxe
 0rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DQVi0q+E57h9TLscD2BfXSjr7hY6v6cTKvicgNa5tqM=;
 fh=QKFMOxPwXZb/OLSTxPYIA/LZI7aXMd0hhZxdGRidgsQ=;
 b=bXtO6q59rMU9EWLHZkF4tfmcn4QauuyRqBbHbZcUlBIJE5Mw9fzx2ws6+O756YPebg
 ge69SkTVhtLKWIiM/H9LzPlwJPp1q14z+UyNpoeTccK+0q4sEzLHLM11PRtM9eHmAmXh
 IjNv5CPSgXgGZW+5cWddWQXB+QyMYCYh2ZCeAEcEIHvjm6WdetoGsNDXkSg99c5HP0RV
 xe4iknwQ4rHHcG2VFXkBvabSxHlNT+fRxf9Mnvd6vzhGhVcsai9QLdn4Hs4wF4YypfhX
 R+vRQ4DrBSu26yw4Lu4HDyQVafW5tKFNleAK4H81uymc7Ck2+QPA91QmtQjU5uSMQ5Gr
 6Zxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774347303; x=1774952103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DQVi0q+E57h9TLscD2BfXSjr7hY6v6cTKvicgNa5tqM=;
 b=ZaeQ7vAheagIiXBx8KaI32n5Rgjc0nr99OEHoDpxC6ITEmktEhVPaUgSgalnx/Px+h
 7WQYh9nGy3eulkDPL6GStFV+7na5pU3Y/JuDvcHEjO/YnT9MsgVg2bnfqFyTV/eAcaaq
 cyKDZL0IoRX6WlatfRwfbHUKTQFUJA7xmObuU2OH0+e1UH9b53g5CJmWmbkIPVbgeLsK
 qphjneArklvBP1/MHdoKxbSLKfiq0dZmzGqt8y0HOLfVAno0k7I20IRL0mvhq66WIgM7
 Is4EBxO+T/5w7YHzHV+HqpK8sV5r3HReqYcJ3Cc8lzNkGFMM1YEOrRfxrW6nlhf1MuZo
 D4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347303; x=1774952103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQVi0q+E57h9TLscD2BfXSjr7hY6v6cTKvicgNa5tqM=;
 b=sQkO0NpY4Xqo9WYyXJqtKLm4IuadXNtYEngJPR0aoCDbIG2w5p0EnPUmZlqNECYK42
 2mvG1QU5GkMt8txW98EBKpD1Y4FpIkAuC2iOyGdsHjEvnFI53NKNSl3VM4BpLLpA3gfs
 gJ2iVE1kTdZyQjb8DdW7TtRzYYSf2aa+wXlGu3nlyNfoOxfkebrx8+rsHwKMNs7DgPWD
 R7eFGFs0G9r6LViKfOBG80CydWoBiFULnxodtjCqu7cJfGoY9eR5SPyNGVux0iTKjxuu
 yoh+COpwVHi3vgEcnoA+Hm7+3pH9Mr4OMuQjQ3Hq/i+9v34ClCmPI3EK9PWev63AWgNH
 nx6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/iFGlpp/c0Sf8P6tWgu27+qdK4dr3EJTCsjyy9t/u9OEQGtI6YI0ahk/JVsCsgKUBubsUzkYDlLC@nongnu.org
X-Gm-Message-State: AOJu0Yz7zNEE6VsRjJlXAeZVSBhDbHH5aAisnJZIE0MLDH2ObBZjtm2h
 7Klmu+xf0MlSx50yaZoEtm6wwwRPtTwg1HsLu4PbZSMlz+KV0rlNbokgrk6lHvhTHI9b/o1uP2r
 8MiH4CYD/cIjxvuIycINn5zzUfDJdl680Z/cxT9UrDA==
X-Gm-Gg: ATEYQzxu5Y4wuxeknKsV/3Qs65dwZeEzJUgbxRzSRSRCKLy7cqZ/lbF7hT7tIxWO+dO
 LAercScQU9Q8hVOszk5eFah+uqJDpy9kzCGcgcjMDa/NyZIIp1/7zsJWzevpXmFrr1UunZgKrOk
 nTNSUdYFwRFEfiaQdlRvmAZqxq36Vvl4oeUQtVP2I7OVxSt3U8FukE4HhU+Kiue1p2RYME4x3XG
 8BjqK+5dYJT8Tvyp84AVmyvEUWLmBXqWomrC/PDeIzaGmXC92cNV+DjEyNaYxQLvdTetbt6cCmO
 ZpbTa5/rEn9VJlTEwiweWcAsN2oaY/4YbqZmjsSLW2RV+pNgz2ZIglp89ziVC3EwxNk=
X-Received: by 2002:a05:690c:34c9:b0:79a:3e64:c15d with SMTP id
 00721157ae682-79ac2f8e0f6mr26946687b3.31.1774347303044; Tue, 24 Mar 2026
 03:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <20260323231612.GA2637687@ax162>
 <8cde9a355050b306180f80e8d1340ec814c0876c.camel@linux.ibm.com>
In-Reply-To: <8cde9a355050b306180f80e8d1340ec814c0876c.camel@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 10:14:51 +0000
X-Gm-Features: AaiRm52U7XV8IZEgqBR3uKQLCstpKT6pRzqNDKwQrE3b6C1V3g1afClU0o8qyDM
Message-ID: <CAFEAcA-zJor6L=WFxjfPVhY-bCGHvJTht0yX37Gks_Ozk+PdZQ@mail.gmail.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, 
 npiggin@gmail.com, milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 24 Mar 2026 at 08:42, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>
> On Mon, 2026-03-23 at 16:16 -0700, Nathan Chancellor wrote:
> >
> > After this patch landed in QEMU master as commit a16d4c2f16
> > ("ppc/pnv:
> > fix dumpdtb option"), I am seeing a hang on shutdown. With the files
> > available at [1]:
> >
> >   $ qemu-system-ppc64 \
> >       -display none \
> >       -nodefaults \
> >       -device ipmi-bmc-sim,id=bmc0 \
> >       -device isa-ipmi-bt,bmc=bmc0,irq=10 \
> >       -machine powernv \
> >       -kernel zImage.epapr \
> >       -initrd rootfs.cpio \
> >       -m 2G \
> >       -serial mon:stdio
> >   ...
> >   [    1.308982][    T1] Run /init as init process
> >
> Hi Nathan,
>
>  I have root-casued this issue. During discussion for this bug [1], I
> made assumption about dtb not changing during between resets. To handle
> that I removed the dt_recreation logic from `pnv_init` code.
>
> But, As in your case the bmc details are provided from command line,
> the bmc device is not present during `pnv_init`. And later on during
> device initialization it gets filled with correct details. `pnv_reset`
> is also called to start the cpu also, So previously the correct bmc
> details were populated.
>
> To handle this case, I should add the dt recreation logic to the "bmc
> details found" case. [2].

You might also consider using qemu_add_machine_init_done_notifier()
to register a callback that happens after machine-init is complete
(i.e. all command-line created devices have been completed): if
I understand correctly that would be a valid place to create the DTB
(the machine-init-done hook is called after everything is created,
but before we process the dumpdtb option).

-- PMM


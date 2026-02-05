Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE32ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1oM-0006Rm-Ml; Thu, 05 Feb 2026 11:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo1oK-0006RB-7r
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:02:28 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo1oH-0000VU-2Q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:02:27 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-794baacdefcso10938497b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770307343; cv=none;
 d=google.com; s=arc-20240605;
 b=d4dMCmwtZVcZzMQk9Z1LK+0Qx6NUOR9kizhuNK/tDxRB5qD1wFkb7CMxgcDLjXNmTm
 7HleRqw6FBs5motv+NfHuozta41Et3YLLhgn8+wn3f4SBZ9uxJvQXZBCX695rvOfFrh0
 Gopet4hpHrpzRYeRNUwAygnNWaSkXc2LCWOdFNjHuhYO/+qc1BzZikF6yKGWVENwAsmb
 Nc1ArM6dcxeOi5JVPQZ9LGTI06cpjmLpiWzpWC2gw/48KVjbW1a2IRXisGXy9RJYPBIy
 7zhzno/20mKAMFyvu8ff0YEj9jlXSIBT6KIfY4/h0hVz5d7l5NqlhRMnam4ZUXHpaGaH
 sU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rGhMaRUQMWqDeVp6m6RSJekchnZbE32Xztw1Fe0jvPo=;
 fh=gMjfbdOkdsdyugoyuRb6DYWE7E1DjTHLX9jbWQ8ybu8=;
 b=J5OKPCa4eqBoanmx4uwDIfPt3BhBBVoftZHqAxcC320+Ligu3npyOWlKdPszWLTx/F
 6OxULd9IT0PKyROOify/cyfo6tptcVpqORhL6l6kxof14V+pNeXiXRLU9nYQHqhXJGd7
 KfLs9bprBCqd3nMsPaA5g5jPWV6l3/UH9vobvJic2INe2cYh7kwl37azuc7GN8eK4gfc
 EiXnSPk/cA7sg5vrSaKroP93nQhelsrhTHhP9eQn5RyAXg+8rwO6p1tJQNtR11OSQGmS
 sKZxUlq+bOw+JsCJGgc+JoLDEXq90bf/qyYbEs4PPQSFbWPcSFq5bbe2fW+MwaagDiDQ
 lRSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770307343; x=1770912143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGhMaRUQMWqDeVp6m6RSJekchnZbE32Xztw1Fe0jvPo=;
 b=FyIvrfc1wyIh8ym2Dh8mlYGUTSGAhUi81qsF0s6CyxIqlMDk9gF/W5kKi3+e83zyeU
 uJkymUuw1c6JmZJdKK0kpsUXFlM96uS6S3r2Mi8DXkJBmfuy+SzBn/lG/8hIWLFXUd+v
 RtgPZirpb+yHKv6eINTFOMthEiryHYZnaH5yJ3hxxgf2MDjws4DeY2z1db/ino2qneiY
 2TmcyMnFVwyzGWD+8axVp2QvUS43QwTP9gdJhF/ngZ/TVw0DlVMC8eSVKCwYnuMHnjuT
 9qP/02g9aCj1P9lrMOS6gFmCrUIL/541WoCTNlGbyZBmtxz+Ykc+UbUPaB0A05Xb8P4E
 sYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770307343; x=1770912143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGhMaRUQMWqDeVp6m6RSJekchnZbE32Xztw1Fe0jvPo=;
 b=azhmcVinUJdwxWaAAuK929LnrmWMzPk6nVg/eXwXkVbcD8+OLdv8sD2W9X+TUNy4en
 prTOjpTUTrysQZGMP52PDtBPcuMfUdNMHr78tj4Tt/DqQzAlYBnsLOiTdCSGon9Fve17
 t2GG+5rHMynC3jQZvhOZnrEQWfN5CU+xNKGmWTQXeWGVsuwYf+QyVd5XTRvObx1IIWSs
 PovskaYCyNNdegDxhj0iZ3TS1MxksFzgdduOv3lkTDzeVbw4c5ZTgqARFj2YHWRliFA8
 YLsR5A5orHc2h88HhIDE3ujv/jJpSqIqE3sWa37kX3B3+PupsTAklBxXnaNiwEWk2Qs9
 668Q==
X-Gm-Message-State: AOJu0Yzt5bL4y1KpPf7y3y5jVUcCknFzh9PFN6mkUBTcrulpDf7FLTsY
 +E6XddAI/r5Mc8vd6kR+m2J0JE4LZVztaxdNAbs/bgHKGND6EHC8PNQCJKwJ11rJr7E9ota3u6S
 M3W3bhk0EFbJomZ5+hWJG1dN+Vo/q2Pgs5+jzcgahqQ==
X-Gm-Gg: AZuq6aIJ8mODHk2GsKgvsGL9iur7HCs7w0gNnzC4qcgkgqbga04eVypfE9gylhA79el
 g17jIAtZDPgfUvqr8HkZTCAtSIE552YqJSiNzSaetg0iL+cNgMngSDpmGLqdmIXTBLYWLPfw2YL
 Mq2xqVjsjMQ0j9MaqIshIJ6BofOckLl/bI6rQ0TNuU29WMJgZPxHRgaoMIEhX93fm5TTKm3OYgk
 5MpEc+SW5r162ipS4b29Nf3yIAUiTarxLIhB/V7YK4snmNPTFL6JmuN8WOmupGgHs1aBw==
X-Received: by 2002:a05:690c:318:b0:794:f14c:462c with SMTP id
 00721157ae682-794fe68a22emr126699067b3.28.1770307342879; Thu, 05 Feb 2026
 08:02:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770231744.git.mst@redhat.com>
 <cover.1770293044.git.mst@redhat.com>
In-Reply-To: <cover.1770293044.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 16:02:10 +0000
X-Gm-Features: AZwV_QjTJEvVPoD8bgDVL6EADRMd921vDqRntjuKrurJv4QToa6fYH3nuj4zk_Q
Message-ID: <CAFEAcA8Dw8eoY=6owh4UZXM4nbnt2GAr9j8wmuMcpSLhaMS=nw@mail.gmail.com>
Subject: Re: [PULL v2 00/38] virtio,pci,pc: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 5 Feb 2026 at 12:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Dropped most cxl patches for now.
> Dropped WADT due to author's request.
>
> The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:
>
>   Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 25465c0e1fd74d2118dfec03912f2595eeb497d7:
>
>   hw/cxl: Take into account how many media operations are requested for param check (2026-02-05 05:06:46 -0500)
>
> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes
>
> intel_iommu:
>     SVM support
> vhost:
>     support for indirect descriptors in shadow virtqueue
> vhost-user:
>     vhost-user-spi support
>     vhost-user-blk inflight migration support
>     vhost-user-blk inflight migration support
>
> misc fixes in pci, vhost, virtio, acpi, cxl
> cleanups in acpi/ghes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


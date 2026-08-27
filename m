Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140A6C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSBQ-0003QC-Iw; Thu, 27 Aug 2026 00:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBO-0003Pq-SP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:57:46 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBN-0000qz-E7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:57:46 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b5607bd3b5so255807e87.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787806663; cv=none;
 d=google.com; s=arc-20260327;
 b=YuaSGk5HVSk1qHBe101hXhyPPP3qJijFm1lDtfPeRq8eaLCBeM5IEzg/7H997A5gzm
 TTUNnzaTP9IPbsCTbwgFmT5PU/79Mtm3+qZo1FEU+ek6pNfPvd3cYRf4y6I+9vrMF5fa
 8qv8VelmtByEHF7BhkzVU7ruHMypveZ2/J6iGcjfVGZwAEvHVAdswJot7nxvnte/3G58
 +1MYzv2RXfhJtH3AcIwvepEM8XbC69Qt9xYy8Rl1J0SPd15xpwWMFzBI6a8rGin3pc4h
 QKOh95ilvszkJ+dis521W/3MlcJlFPTUzW2nG8V6eULwgMAP9R+nKuydqsyvJmTlQb0+
 YELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Seb3vhzJlIYQ/MHQuyVgaOY8DcX1i+d21iokyG2SKpU=;
 fh=QVe/7zv5OrYmrprO28ljpRmhYeOlvvTBoRQtHWn+3sI=;
 b=QCIGfB+m0qnXjkQYxvinxWFyiW40HjcPh8umZ4ypjynTdiB2U5OjwmuTF2aJbt1CHU
 FGdeQye10VmelH+1uS5vb2euZf3QR3jmbuDmSzHXL9zuFj8T6ToUyUXAcoCkm96atjbe
 HShEmKWaOLoPka120imWvUOJmI7KfyZnJ7OpEuoA4HvQemBwlj6n+DzTP44MTCxY2dXY
 G6zQFKFGl+HscNxRz84icZiaZO1n9eMQ7CVJesY+flPNDHhVLxGq0jArn31iDM1vsVnv
 ZfZUZ1JSgD3kM7Bpd0DyVAjf2pb+Jj/JLdPxgaO3TgfAkQzAA4/J8N/GEDO45dzIwa+F
 o1iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806663; x=1788411463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Seb3vhzJlIYQ/MHQuyVgaOY8DcX1i+d21iokyG2SKpU=;
 b=LL6vupfJCmNHxDiMaB/0pzE32xdZ6amF1Ch1WKmUc/aIW3aqw+M9BitW3Jmai7QIwF
 PQ0zzZsIBOQnWYVApf46QhlhJuAg0MD2ygfZ130hb0TCrtlMXBskWP9femCHWa5FeREj
 Yxehu5a44BMpDST/YE7X0N6z3jP7w+fTbYbF2w8j6okfcdLl/Hf8gtZ/SrCljaSKtkRk
 Xco8w5BEy0kVQvEE/MZCU3ms2GGc4MEfiQiMY+sZKLvVtRNf9ZkMSRNn2SYrT38ycgCK
 rt3tUOp0QuQD1lnElNIEXgJKl/p2nSv3nOk3ZPdvBGrZYH8OqpUSscjHfH68WiGPXybb
 ZIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806663; x=1788411463;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Seb3vhzJlIYQ/MHQuyVgaOY8DcX1i+d21iokyG2SKpU=;
 b=sVEbOPBgOgxlVYnBOjpCbAZ2/N/AXZnWX927q3PfyDd9RvQL61zpiRnclJ4qjBV6TO
 XfAtRIw+k/dtsVoqaazT5+bkBSnYXR3Wwnxr2m+sSpYcoBvbToZrKi5u++Ff4MVvAlsW
 g9npUR5xGSZSHhV4zHzA/3bcRHrl5D6970p+F6u7kAj/ezUG72Ehq5CWPS8SpYeyX7nu
 kDBQDkqE7KjCtoLs5t1gdGJj1AnzFY7WfOumnZ1UsYMCLVDDQAxpUdUqabCNA149Z9U7
 UVVoOEcQEdN7un+i2Rup6uAOTUod4mTClCZIs2IvnJOhc0LcdBwXTaRfFdr4d4F7Edk7
 e0rw==
X-Gm-Message-State: AFuF++nEgPdOpvdlRqhFmNIujEm5k4TZu7Ds9/RthGgKqY1XiIzqmm3K
 8L4mwulr6w2/2l19kixzbLidCjW17ClPJAJ9VLJ7XEKEsbzReVUMt9dDI/r7kzmW/1Omjj/bDHc
 4iX01YbIvH7sQ5EtezHGhO0Jb56Vm9Lo=
X-Gm-Gg: AR+sD12uOOXmjdoe9ZV6y/8OPR5vYVzrNJUj9BOZH+i4+DHPwfgkEsgIA46CGsHZzTY
 3lejZBu1RDkQS2/91X9SFg2mNURCrPSOVyCu4/EDi67kreTyhccth6rDUh3eL9HfEjY4sRZOyqj
 47KnluO0NYY3uXHYJ1afQp0cN8olIHSH/ehy3MpXDO82DrpPScu13eXo6ieNu9m1MG2X+94RgWe
 ZO5TOtd4bz6RVP25Y+qULMNBuBvrC5NHX8fB9vxXyNGvMnweTpil2v7DwFgdDx+MJnwMpRHzclx
 /EIxAytXWzppNK20NLmco5lYkx6p5kFxiswdqMCow4NKWa0=
X-Received: by 2002:ac2:4a6a:0:b0:5b2:e947:b3de with SMTP id
 2adb3069b0e04-5b4a9029c3fmr3146336e87.7.1787806662732; Wed, 26 Aug 2026
 21:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-3-mattst88@gmail.com>
 <af70d3e6-9a71-4635-8b23-3d2a0e3d1ffc@linaro.org>
In-Reply-To: <af70d3e6-9a71-4635-8b23-3d2a0e3d1ffc@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 27 Aug 2026 00:57:29 -0400
X-Gm-Features: AcwNN1XIopytHlZpIlKDTk7MuCtXed1JqGXlaw5TeZiIwY0MGuClLgPX390sMbQ
Message-ID: <CAEdQ38G9hwKmF4SMPNoALaiWUuheQCP_YZnDSK2XD9o1pyHa5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] accel/tcg: enlarge the TB jump cache to 64K entries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@oss.qualcomm.com, 
 alex.bennee@linaro.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Aug 25, 2026 at 5:50=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/22/26 12:08, Matt Turner wrote:
> > The cost is memory: the cache grows from 64 KiB to 1 MiB per vCPU. That
> > is easy to justify for a single-vCPU linux-user process and less obviou=
s
> > for system emulation with many vCPUs, so this may want to be sized by
> > target or made tunable rather than raised unconditionally.
>
> Why do you believe linux-user processes are single-threaded?  I suppose
> when emulating /bin a fair few of them are, but...

I don't -- I'd conflated "one process" with "one CPUState". linux-user
creates a CPUState per guest thread, so a threaded guest pays the
megabyte per thread, just as system emulation pays it per vCPU. Commit
message fixed.

The sizing question stays open, which is why the patch says so. I
don't have a threaded workload where 64 KiB is the better trade and
would welcome one.


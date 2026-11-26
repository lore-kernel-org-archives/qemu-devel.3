Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73840606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Jn74EBfo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWPmc-0002tp-6v; Wed, 25 Nov 2026 22:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xWPmZ-0002sM-VW
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 22:04:24 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xWPmU-0008H4-Rf
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 22:04:23 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67db0791748so7570083d50.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795662257; cv=none;
 d=google.com; s=arc-20260327;
 b=EvvfxU0ZnDWdWlwZF7lWhS4A6o7r8d7mXH3R3qUU2YE1Iz7h2avJ6j5weRM3nVdVBC
 g0m3l55c/AKgo8rAS67SGDWT0+HJ+L66SLS1Q/qlhwA6urz3Vqq9RtfAlWxCk7YzZ8Ud
 KgDgcfk0rbmx/mav0bqt4JGjXg4Wv1lU1+pFi9EBgenlZLfM2ual7TulBor1b+lawZC6
 vLLwHnPauDrY4L8b2JTL1r5go/exg807lVy9/tc8LwPsds9UrzPXOp4IqcYOskXPUrf5
 xhX5tFpzj99NRG/YvnoEhh01/8X3q7LTO3VNq3GwCKzvkK6TWIpa7gOLoa2VbU/UGO1E
 TPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xlWHPFuqk5N+v92mFgbucowqaX2ho2OkoZHRJ2Idrh0=;
 fh=EhIY1LAwFSLhLIQoGHI9JMEAVCJtb3Q+OgsqX96X7u0=;
 b=F2JIicGPPJ9jpGQwCWrhORHY6yrjhm+uTSOODS1k4IJlM8FRyUDJ7VXkiazOquTwfk
 0hqL7yztKzl74GoA8VFWmz5Atc0jAx/YJrxjzFKmuC/KKFtpRyTYrvhGYWu4FLIVb0zj
 08cwL4UtIBFT9+6IUdk7EB5ALZoUz8jE7daki/RZTgIdgp9a9SZtORxxz2aoUCgzi7/q
 fFOwWMZnPbszaSif5MW3ngFGJYw/6jDNvGCw52mLq/gzU3f/mZtt90itusUITJeU56Xt
 s4ZL1lioLTUrU6tOta86NgTyfVRfV25ksF/VJOeSZvExIDtwe2SwRpFGQCztPuOM6PFU
 ULOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795662257; x=1796267057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xlWHPFuqk5N+v92mFgbucowqaX2ho2OkoZHRJ2Idrh0=;
 b=Jn74EBfo+XM/sTC16kn8R0ztb9GryD4kMnGDZPHDA95ST0dHzcEzdLRl5Ijnniw0J+
 L4KXj3IhAx8h+PGjkCweLAAW6TzOr1VBBQlbZOJaoCTyZ1vCzjbi04uu1HE7KDIDTeES
 ItFb0uoeMG7nXkIIhYHC5FIqOb4CjQtl0Tx3QoVCy81im/2k0mGx/0G3NBCTwaDwU/Dk
 3zHTFCg0YP+mL5hdJovAhEOsh9xjnLGEA7gN59bjDMbNCWlTHLw/eGWJJjihLvpGFWtB
 3GuPXpfsQk6hB3xIqqwjAuOc+NNvFWupRZlXHMQRvUSpNvq4sf69CtcIFtg0AUIjdkta
 gT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795662257; x=1796267057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xlWHPFuqk5N+v92mFgbucowqaX2ho2OkoZHRJ2Idrh0=;
 b=BlqdEC6xYvdkK7J+PHcCfeIv9XjN+W+04gHMLHASQsysrstZuA0tiGp1zAV0Dd1wdu
 fFkfLUvZzYdPWwvpEVRTjhFnLN4SIMMLDEx2KiCfrySD/ZE43RBKLyKVdmoc8dt4oP6l
 ptcA/Vu4HtWQFYq5n9Nf9im1CpxTu2YGuxLi+nZIY36yR16F7okN1Ayii5Q5rmMLVhTh
 IjsXAvxoCvzTyhX6g70Nxb0OeKoZncdZFVhiNGWJbexrdONFsvgNJ6f+3IXlxNZ8qy1P
 UbRIPs9VTu2EbXdrUtTKesIuyTslPMvVX7aYpdMTfuN4VZUn4J0YVLTl6h7NI45Fu3a1
 LNFA==
X-Gm-Message-State: APuU4Z9tdEP89lkJambj+teJeX4c44MABEKdQNCJVQ81EOFxWvvHDCC/
 8LD++gpblxNRJTaQFpiBmHkz7qaAt7jMnYqUIL+KbD9MnVqW3IcjR02onbla0VmjBCQoYflp3xL
 gqLSa/sOcZIbGou4lkk0lA8GtauAgeN2JGj2rFT3CGQ==
X-Gm-Gg: AZFdTZc1joHHrB6B34+wDP2E8ApFe38vcWnPiCPsGinksEBalPchyiItt2JwinbJDBd
 whZGzV8LcHhJy8yChDSfr+1f4D9fEEz9SURnCppphmGa+HWkc3w+Fw1OXxz5D1cweOzQWWk90V1
 vMa9mwEOA+u0tR6c2t2OhXEjXq5hGsmVDlvatLoexgkNVunAM9zpiyoBhgVA8Qw7Jl/PqcAS5BP
 5ceu2+xn92ghEGQLLZzdkQRhPh3ltENi7ftruQzKw2s15cXDONMjdcggtvs8yYC1TTCmjAsXUKU
 oOD7gn7olOTYB/qV4jVi+I1PBMoVwAXiw5uL/XmAQd6JEYLCTYL6e9fSQUDQjXO1zwEbs/DbOlE
 6+yPmGkRs8dI5IIYPkpfChTRInWquUVrG5fnp140zvorQ4+x7k0vLi/7vipJM0iz28JrAOrFiZ4
 oZxA48JRgxsTfSPVBy5gXDdm9BTlkbTUolU+FkljxZSLvFCGM=
X-Received: by 2002:a05:690e:144e:b0:67c:271e:c28f with SMTP id
 956f58d0204a3-67df43ce2bamr9482552d50.31.1795662257152; Wed, 25 Nov 2026
 19:04:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
 <CAEev2e9YBm-rA1+-mmw-qF-5dLw7uO0o=knHh30KAyDVepBsfQ@mail.gmail.com>
 <20261126023501.460848-1-w1355457260@gmail.com>
In-Reply-To: <20261126023501.460848-1-w1355457260@gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 25 Nov 2026 21:04:04 -0600
X-Gm-Features: Aa3M54qK8gsW2xmOFDckolhTpc2vnwjYp7Mvcoj9l9EJM2ALGF2hQOtl0pRWJBc
Message-ID: <CAEev2e88RWAx_FhZZZHY1vQs3KTNFS+S1R6G4qdEdzzaivZCSA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 0/8] Add Spacemit K3 Machine
To: Zixin Wang <w1355457260@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zixin,

On Wed, Nov 25, 2026 at 8:35=E2=80=AFPM Zixin Wang <w1355457260@gmail.com> =
wrote:
>
> Hi Anirudh,
>
> Thanks, that makes sense. I will hold my own model and focus on reviewing
> this series first; missing features and tests can be added after it is
> upstream.
>
> For the tests: I do not use tuxboot. The K3 SDK and image download entry
> point is SpacemiT's resource download center:
>
>   https://www.spacemit.com/community/resources-download
>
> K3 resources are available under the SDK and image sections there. My
> local test uses the K3 SDK Linux image and OpenSBI firmware from that
> SDK, together with a small initramfs and a QEMU-specific DTB. I pin the
> exact files with SHA-256 and boot them with:
>
>   -bios fw_dynamic.bin -kernel Image -initrd ... -dtb ...
>
> This avoids the tuxboot kernel/OpenSBI limitation entirely. The qtests do
> not need firmware; they run with:
>
>   -M k3-pico-itx -bios none
>
> The DTB I use is prepared for the Linux-first QEMU machine. If your memor=
y
> map differs, we can adapt the DTB and boot command to your machine model.
>
> For your NOR-flash test, the same K3 Image and DTB should be usable; you
> mainly need to prepare the NOR image/layout. I can share the
> qtest/functional test harness and help adapt it. I can also boot-test you=
r
> series with the K3 SDK images and provide a Tested-by tag if it passes.

I have written a functional test that test boots upstream linux v7.3.
I will include that when I send v2 (and some docs on how to boot linux
from u-boot). It loads in the kernel, dtb and initrd via -device
loader and uses booti in u-boot to boot into linux. You could also
build a UFS image containing linux and boot that (but I've kept the
test simple).

If you have any comments on v1 of this series, let me know.

>
> Thanks,
> Zixin


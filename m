Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA75CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaov-00045I-Mr; Mon, 08 Jun 2026 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaot-000444-VB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:19:16 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaos-0003t5-6r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:19:15 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6608c1a4215so5149049d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928353; cv=none;
 d=google.com; s=arc-20240605;
 b=YSCr1sHyRzcvg0OkqXpxTj3EqgEz2jRRG56N//deFYC6nU/gqJuChdeN4dT1OBYVNR
 ksDpzRfVUtIBpZnTAgdP3K/6aNRA1S3EuoBUxpKTqvAYjESLiwkqOcwywlqZhsnYYfOL
 ic1aynV0PkvBLRFmb6mtT7zC+IUVhCu3M5PsOZZZ5I/u/lSVdMzdxD9kMuseylzB8UP1
 UKhr0Q13XIeKHEqKYgymskdueJeBlQhLiJ07fJBcTiN6nwobnXy9990izq4J2nSRU0I+
 7Kds6E9Nzhy5WPpXLsHHoH7FzgtndV80/2ExN2xS3B3d56kYjVV6VWAE0U+8CdP5aeBI
 f3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=om0tzg0m4U5QCoIhM6Nq0tRE2axddiJx5RTHpKKTNqQ=;
 fh=EozbU2Dip7ihBuM+OpDpcROKl5e201y/O7KnKTMuldA=;
 b=TLondpP9bfKh472UlUh/EgZI1F1GkhMCclDzOtVJejQBvhUTYtf4nY1gx9N/6GlEGF
 /CiszyUrraK5f1caji31JXM55Z/CQ7KVUlyI4xRS/ttYKEy894NLv+NAR/2gG0KljTzn
 pWr35DD5we+IFGRH9APrERu2af7yfCrQLz8SBWMqjPwimkeVX1I+NvZu1BPsQpik/UTY
 qNfQpOIdSztGZMXKbuyGJGtxQB6gKa7GWjBIAVYY5w4VGXnFvRwl8PZSmGIi81ekgtyT
 gBV7/YYldxjbVOA02hjsTbGdnygCuROPXlIP3e6BJ2gB439QCPfUhRLEYhDDz+QO3NNg
 Cx9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780928353; x=1781533153; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=om0tzg0m4U5QCoIhM6Nq0tRE2axddiJx5RTHpKKTNqQ=;
 b=pjhINbRS2jYG3F5pQi8xNzUK+N1tI+mH/SWAiRQHFp1ADk83wEscE9UJoult/Zs4ii
 cqbXe1UJOjMc9ta+3ILnRkpcheAa5xWxX46g6DQFRzwkJA7R25I+JPjX1SXHuyOY2bIP
 pTUI78dwcIRcm6YD1LBKPFVf3TkWfQCNasaDPcxJMrwhrexBE+OjS6pv0wmHUnJcpF1n
 kKGYKhCNgy7wEhwLcaUaLzxDRWeBcBZGvGgY2bVWq4hg/FuTcZlmfU8mLFX0rbDb1rDs
 wSiUF32yCfg659gvSwAl522L5uAeaD/11TFmo8S30mAXcSVVczyOEeBtoIuRVreP+txA
 rh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928353; x=1781533153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=om0tzg0m4U5QCoIhM6Nq0tRE2axddiJx5RTHpKKTNqQ=;
 b=L66v9jFGjwwr3apXI1IkhfoVkMZ5Z73skOg+EIaXjfxntorpxyQAg2EZCTwb8S3XFb
 /2ip4m4gfHiJsnVVfymlGj2YGhXKgI3X02rr1CA3F5igLXOwSS065iJz9+3hztMTcNzh
 JV46kTPXNXz8GXslqycIoU5PO+sE3z9MgKDi1zrWOp3IS53wzzNfL6q/SqWSRIcF7tnk
 fFJViDSSFcNZj+FYKMfIHodJVNaHCfhvu8F6AxHkeS0533OzTlRHQes0oLeKyGyQSj7/
 uETOF3xD6t0ykkKm/+oviFjyuw8qSsc4MVWfbMTxXR+NiPbaqEngXgQOITHIa6M9zK4L
 XLYw==
X-Gm-Message-State: AOJu0YzwfSzEF/B/SFo3Zk07zXiE6y7I7EqDWVq3bWpmNzXg9o/4iFCj
 6YcnZykXOu/byoTKyGKWQI92atf0Eu6fxOXZ7AmVGwW5FnG2GS4Zffird6iSM9JDuowEjGD30oF
 yZ07yDX/LZFSF4BAtzVuTQ8tmI6mVS3J4XmAWc4yAfw==
X-Gm-Gg: Acq92OFAVMp0hx1a3fP8oR+iFX6o6VhjQT0REYziMMO19io5mrXU5QPDDAFRZpg5Kur
 g+0gak+uZukn1bw+VJTBjUAfw98T/FAYo/X59Jc6DTV+2w/jBa9yL6jzGTql//NJfuQkSoLda6E
 ZzpgbYE25msbstIIbawRstd4E6HZT9HgaH2U1qGDPY782CAmeXH3SKzZx4j0PseWOsJyQk5oH6j
 YV52cBQl4eFKomanJwUJcmH4V4O5dQjwOH3qYe5MT34lorJHKtoXlFpXhQ3aM/HwBL47SlqrzES
 RhtVrfzARsae51p7jMqbEFHr8fokFG0j2t5en8oc6Y/J6TKXteA2GUHhD4t55nCcNA1alQVKDjD
 qQD8et14hX1LD
X-Received: by 2002:a05:690e:43d0:b0:660:689b:1509 with SMTP id
 956f58d0204a3-6610a792c76mr7390839d50.29.1780928352815; Mon, 08 Jun 2026
 07:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260604134422.359214-1-kraxel@redhat.com>
In-Reply-To: <20260604134422.359214-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 15:19:01 +0100
X-Gm-Features: AVVi8Cff_dY1TE8lAoOpU9BdJH3uDvjH-ENKwuFiD2bnSV4UZyJjSx-SyH2d1sM
Message-ID: <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
Subject: Re: [PATCH] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 4 Jun 2026 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/system/linuxboot.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

Thanks for this patch; I've tried to expand it to make it
more comprehensible to people (like me ;-)) who aren't
very familiar with UEFI, but I may have made some errors in
the process.

> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> index f7573ab80aa2..72af18ce1b5e 100644
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>  give the kernel command line arguments. The ``-initrd`` option can be
>  used to provide an INITRD image.
>
> +The ``-shim`` option specifies the shim.efi binary.

``...`` around shim.efi (here and below).

>  This is needed

"when you are booting UEFI firmware and using the ``-kernel`` option to
tell UEFI to boot a specific kernel image, and the UEFI firmware you
are booting has UEFI secure boot enabled."

(Or is it when the kernel has UEFI secure boot enabled? Or both?)

> +when using direct kernel boot with UEFI secure boot enabled.

I think we could add here:

"When this option is specified, the guest UEFI firmware will
first load and run the shim binary, and then the shim binary will
run


> The
> +verification chain used by linux distros requires shim.efi.  Typically

"Linux" (here and below)

> +shim.efi is signed by micsosoft and verified by the firmware.  The

"Microsoft"

> +linux kernel is signed by the distro and is verified by shim.efi.  So
> +without shim.efi in the loop secure boot verification will not work.

What are the symptoms? Does the firmware refuse to start the kernel,
or does the kernel produce an error? If we can be specific about
the problem that adding a '-shim' argument is fixing, then users
may have some chance of finding out about the option when they
run into the error and are searching for the solution.

> +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> +distro install media.

I think the BOOT* names are a RedHat-ism -- my local Ubuntu box
has "shimx64.efi".

I think we could reasonably expand this to
"in the ``EFI/BOOT/`` directory on distro install media.
It might be named something like ``BOOTX64.EFI``, ``BOOTAA64.EFI``,
``shimx64.efi`` or `shimaa64.efi``, depending on your distro
and guest architecture."

Do we need to warn the user to make sure they use e.g. a matched
shim binary for the guest kernel they're trying to boot, or can
anybody's shim binary boot anybody's guest kernel ?

thanks
-- PMM


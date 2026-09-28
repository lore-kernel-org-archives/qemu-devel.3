Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96111CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFjT-00063d-DX; Mon, 28 Sep 2026 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBFjD-00062I-K9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:05:32 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBFjB-0003Y9-1e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:05:27 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-672f516c271so2911896d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618724; cv=none;
 d=google.com; s=arc-20260327;
 b=I+tlO8CH+Lv0gtJAR1Rd3MO3xSTHo4T0oNebGDFNzUtL3Z+ZyCB9VTgXut3gw7AXBC
 dbgCHKMqLMPGfhosicAaEbAyHLq6tWxRXURbttgXpvxMYToI8r1jIQEmzBh3JlO7tlO7
 QLyAbrPiolqHVH1aQso+EWn3Fx4y0CiKD+FCIQ9U4v4Bg6f6YwZkpzQy7x2kYTboUht1
 UQNOJy9X4i3o141XoE8QgIN3ph3qAN+h8G3G9A23+w/lcU9Qt4myenltQvBJrD81ZN7h
 4B9Wf1xeMA+FvSngJ0LyxQWypaPhQSmiJomXiIdAecK7R2OnzLziSnonpqbKHHkNhGlz
 RuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wAHj7yB6+hyjeccZw1OjSROT0wPZuQBNT+jUXfK3d40=;
 fh=1aI44e0p5XplGskc+UeFLoNCjn/8ANQtrjF8ujCp7vc=;
 b=RnACramOUM28Laa9c7MbUPH7uLSYfMixKwIgahONK+ki7JLZ7dOajezRbkPRxN++hj
 CbKMHXsjcbVfmUdpixZ1Ko5U08wylaCagy5+y5i4RyNyui01xn9Mhkwy70w5amOCvDLW
 i5RovHAuyPF3++S9MRwMvXZmwC64doRs0KLbrOvX1JrgYGVX8GsE+w87SLY6M8fmL8uI
 OM1WWU0SqvSuImmOB5Z568nj539jJ3vTlAkgjA9ai26MOTjvOBCA0zAjWfWcJL0bLByT
 nPthnPupteErchInkbqrikPwNbIpNvk0O2JB1R+2qS9SGCdKvyhBpZ1yr8MJb7isScDr
 0Bhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790618724; x=1791223524; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wAHj7yB6+hyjeccZw1OjSROT0wPZuQBNT+jUXfK3d40=;
 b=a0ge8zN1nfZR63f4HpTOPHFOPYWQMSR+edFnI+O1wNWYX2L9FaFdRsXXJ/tM6yED3m
 4mGcWhznpna9GAdALlgMpYUKZGexpCvnG5KKO466FYTWt6AspwrfvbBCUPwJnSV4r3v4
 oVy5KazZzKjiGyxmBrjVOtn4xAq5RfMVaTDRbCvqbV8XKofUdoqkGbRYwIB8LHM+j9SV
 vH3pxCSn6Il5KucNmd34t9cKg4wQudHrCUikk3B/ukb+w1pPAkJTb8hgE3i7LzpC8vbX
 SY/ujf99w0pF/f6jPpQ2LebB+uWrGrRw9IFlH0nFdbVp3V/oHJebwnpXJkcVPhX8pjvZ
 osLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618724; x=1791223524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wAHj7yB6+hyjeccZw1OjSROT0wPZuQBNT+jUXfK3d40=;
 b=MEZ/mVQSJMwMrKHa+C3xWaUEPJvkpobUFFKAxBn5yQp4b4GQkwY0YWPhcMInoh+uG+
 hRLnqSBrFwzWLzbZzSVq5ddyyYW5EoWzD8D5C2UJWw3iYwQu4o7vUWXylfoRQHdLmgpv
 iuOC9aUx5Rni8X2+HK0SN7FxJJfacIWySKT6uQB6gWqcKRntC+RNO8TlGIIH+CGyJZKZ
 /uMZM2G/o/4qETCPsvfItcJhSe3vBKoCKeZU6wr7jBaglEk5m0YM2U3O3HmJRZSypwUw
 VBIEDyto/HhV8rdkLz08MHEyZnkL4JaYVxhtd5vEBDfqZqJ1/icPjhJ+QOIHVE2IlpzD
 LvlA==
X-Gm-Message-State: AFq9FYKoZc7b4xqzBkQ9+4yE7AyI55oG8a1ZaYPbcWZxOdsrVEJZQWns
 3lIEv1fHbAGGCIZNlAqin9V6xNLv6Lceexejjftfqc3Hv5KxXblrs/QsvGHFcJ7ZTusXKYqC3GR
 p3rR62ax639jNBw2f1c8hpHeL8xD7ZSQBv1zyaZigLA==
X-Gm-Gg: AYBFou17xG1jbPJm+mbYEdDbHbzXSps9g2bLnb0uN5BSp4qZr8FRllxbadoUL+6kUFb
 dyxpWh555jhG0/GYUOKN3KAniVhITm8s1RfARs+p45qMREQBGwV7mHy0BcZxL46OVESEyJ2RgCL
 m/+QIhstCZ6IJeeWPyrXkVWg/w07mUGWzHVXP1UksrYOydmakn/UxUmGwRgAwqgoU2BjgErhdXW
 mDmoYe0r+r4e+MhzoF50dBX66UeKu7lz0+ad9wF2HGDtw/7NmihXU8hdAuYyP0nUMd2WIU02ebs
 /w2evdd8OLG9APgpHcFX0wlHaD0gZfGePmzJLuHRtxEPaReWfAarXdJ2Qbm3mz9O3Ncsdp0eG0+
 EAIxahLE/rPEgT9aIamhydvGu4JbNE1GBJN1gSEMP
X-Received: by 2002:a05:690e:810:20b0:671:541e:2bc7 with SMTP id
 956f58d0204a3-672ed42dc03mr4063259d50.58.1790618722901; Mon, 28 Sep 2026
 11:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-5-shentey@gmail.com>
In-Reply-To: <20260921214710.29422-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 19:05:11 +0100
X-Gm-Features: AclHuK-3d4xy9LTRK37sGYmfoU7UgCiFS38yARawsolNfdcvG6jtyI9B4aN-0RE
Message-ID: <CAFEAcA_+nmV0WvoD0OCExmJ7sQdY2T3dvd7ZipbkNuj-RuZQug@mail.gmail.com>
Subject: Re: [PATCH 04/42] hw/arm/mcimx7d-sabre: Ignore memory transaction
 failures
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <agraf@csgraf.de>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> When using mcimx7d-sabre with newer Linux versions such as 7.0, the
> machine fails to boot. This happens due to memory transaction failures
> since the address space is not fully covered with unimp devices. Fix
> booting by ignoring memory transaction failures in the machine.
>
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/mcimx7d-sabre.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> index 65fdb19c06..8d223fca6c 100644
> --- a/hw/arm/mcimx7d-sabre.c
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -83,6 +83,7 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
>      mc->max_cpus = FSL_IMX7_NUM_CPUS;
>      mc->default_ram_id = "mcimx7d-sabre.ram";
>      mc->auto_create_sdcard = true;
> +    mc->ignore_memory_transaction_failures = true;
>  }

This flag is in QEMU strictly to allow us to preserve
backwards compatibility of behaviour with the older QEMU
versions which pre-dated the suport of transaction failures
(and where therefore we expected that if we just enabled it
globally that we'd break previously-working user setups
because we were missing some devices). It should not be
newly set for any board model that isn't already setting it
(and in an ideal world we would eliminate it from all those
old board models, except that's a lot of work for mostly
ancient hardly used machine types).

Instead the fix here is to identify which devices we need
to provide as at least unimplemented-device stubs, and add
them to the board/SoC.

thanks
-- PMM


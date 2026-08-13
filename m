Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C41C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wubhe-0004tr-Uv; Thu, 13 Aug 2026 16:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wubhd-0004ti-J5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 16:07:01 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wubhb-0002c8-Bt
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 16:07:00 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81f3b227a4aso4588997b3.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 13:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786651618; cv=none;
 d=google.com; s=arc-20260327;
 b=FFtlfns/rRDcAenYM562ks7FQlklkey9G1knEm3t1DKsGwV+4ZvpUJC+VC3KnwsbzC
 mCBElFw6ixSTJzrEnh/GgfwxmKbMl6ujh8sNq5Fgb0qhyCpPisLnyTpi5bU9dPENs6Ar
 BD6+binciuVtoKURQs2LbWUscEzGuJH01vurh3bidd5vuxf5397TW8UtgwGUxK5lUXfY
 i29xBy7rWiEFr1jeQCGdfBp7890OuiIyg9KZdr6dWIaRBvoJNHgcTvC9+IubrYxu/1oX
 vV8/h/EcKtvZlwKo4wgxZ+aGXSpU+isJPbLVlikqLWPy+FSfSaKL5usQEQENPcfJUpYN
 BE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KHOgdoFsf+8CJ+0Rgi6BCfAS0yth824lzhfMBC7rq0U=;
 fh=3/HqoMUL958dxlf20leouQVYNacWzO7FmfKgXVQh2Sw=;
 b=iKGXwSMRtjma8Qa6LyoY+TL3G9D8K9QveSq9ldfv7HXOvmAH4C4yZpuCrCgrUeGOJx
 keWYvLnZu8d4Mal8XW342optZ+dhBCTBWm+Z3pgm5yQ6K+utLZX5yy8Azr7YD49pyJ+y
 eptYrzKDV8WZHCPBfsqqytMUn+gduF8XUjkd0wha6WZuRtkKharAnAcx/Yrxg13p7vz1
 d8DIqzeQXRh/37/Yls8e2ULX3RAImI3DVzuGJZKIuCzX9YlcW9gnTe0vszbWlFVOE4j3
 HI62da1PXy8dbRoCDM8aBVZWN3uJt7c44GIXlxShKygPbVzgKZndwxWOlx3vSNJ+37Qz
 qJhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786651618; x=1787256418; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KHOgdoFsf+8CJ+0Rgi6BCfAS0yth824lzhfMBC7rq0U=;
 b=Ck1iYoSZFr0Zi5zPqLQuVrND/y57wzK5D1scXH3fQAbW1881y9HSkCCmNjaWzCm5FD
 9fgq4AMTPU68j+yrzxwaEHKEzH7nmhpcFJKqEH5q6Mcg3gtwIoKiPrcrRhWhepqtxFRH
 ojFIaFGXP0fhV0nb3k8zxHrPRblp7UL1dpdZZ+StOkhiMSv/0iYysYSgdPRUQACJqp+B
 GbdxKQCpRXIYhuPYyG+ZBuDmMO/mg/NmmdCLvlJ6JC9KR6krIibyDvmQLr8IvxPnzSqL
 0jyDwZnEcwyBloYVTfgppx2a9YeH/kmnnYPNXF0ORmBruyAKqUsejyPaqQcepZDjrTVS
 zWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651618; x=1787256418;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KHOgdoFsf+8CJ+0Rgi6BCfAS0yth824lzhfMBC7rq0U=;
 b=KIHR8mLUhNJZy0Dbzfm7TqdyXJgFM4ymAumHjk3waSP6eTn7L4gmZdsScoA8lJzTNS
 rpKO6fTGEEu8ECd55yg5eHzstjcIg5uuQJlf6cKHdcQyQn1XxNfkUiBh5zyWfqUgcp0B
 bCt8ofblHqTXhtuaqUoEP4nt3MzSk0P4dwQa5WSUcBu8mf+qmcEyoTubHNRGDwEexU5n
 xUcId20Vjg4kand1kAKux9Pg+e4FalNvCGuUksxUkoDIYtH4Oqh7olUVpliVijxCJCEw
 lM0PhpsZbKHIc735YWNXm14oYWcn08+HoSiS7V4vF+XNYUIAJSEuaJO8PKZ1XoOCHhog
 kVQg==
X-Gm-Message-State: AOJu0YxPMXPyAbEWDtMP78sDJtVkN7pVfLMuc+NztnEMSSwz1lxLfrGw
 SZwj0okwDuU1FkX/q3SOW0ttb/+abQ/2aMTq+dzQ5qJh1cAXEsnf0U6rBkACLE9dDilTGKf372n
 f4Ed6gtp8BmiZ22gL9Gtd1t2ON/GIE1ba4t5G7grfvg==
X-Gm-Gg: AR+sD12CT0fVcRZi3EIv/Cgs/mAyCfclO0S8aRASk/SUok6duCUsDzgaOE3g0WdgDVV
 1ZsG3qiHdqcyNoVDDYUqjw0+GeuuvjSSE+rOcWa7AJHjhenAPqCxdhJebIGgsphrDHsgFNGv/t9
 IyoNJWVA7QIJ+EgQmoTSlBOwxePfCQYTT6DYCsDNbdCy9eriDE28huGZot+3fIhfPmvLaQjLWHy
 fJ5IsgGuo+Vjeae2oVkKF0QkF3YFNNDGDUEd9cVQi5gBBpkCLBCXbF5OXyHnfGtD4iHLv0/lR9P
 rXSb6umwa3wNrxMTc2huF/Hg7x7S5v6K2ZbmQM9a7Mt2guT54xJaytYXlU45TyZn7VRQIqDeWg8
 okfFzkvWOjj7sZ4XgQt16CP52WA5o
X-Received: by 2002:a05:690c:4987:b0:81e:3965:40b5 with SMTP id
 00721157ae682-83712ac4781mr3160807b3.28.1786651611521; Thu, 13 Aug 2026
 13:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
 <20260812154220.1029828-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260812154220.1029828-8-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Aug 2026 21:06:40 +0100
X-Gm-Features: AUfX_myJxvymJ6UBdzb6yCkuoAZlDyjZJhrVhlz5izfqLlu0Cq2rMMBIMefJNU8
Message-ID: <CAFEAcA_K46rbeDZb7adfLFpQnbd8FrBDanEv9xZ6423eBbgHZQ@mail.gmail.com>
Subject: Re: [PULL v2 07/41] hw/intc: Add l2vic interrupt controller
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Sid Manning <sidneym@quicinc.com>, 
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 12 Aug 2026 at 16:48, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Sid Manning <sidneym@quicinc.com>
>
> The Hexagon DSP requires an L2VIC to route up to 1024 external
> interrupt sources through 4 VID output groups into the core's 8
> interrupt inputs.  Add a device model for it.

Hi; Coverity spotted an issue in this commit. I have also a drive-by
observation or two since I was reading this patch anyway, which
you can feel free to ignore if you like. The actual bug is the last thing.

> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> new file mode 100644
> index 00000000000..f07ec850d49
> --- /dev/null
> +++ b/hw/intc/hex-l2vic.c
> @@ -0,0 +1,556 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a reference.

Side note: the pl190 model is very old code and I wouldn't
necessarily recommend using it as a reference for anything new.

> +static void bitmap32_write_word(uint32_t *bitmap, int word_offset, uint32_t val)
> +{
> +    bitmap[word_offset] = val;
> +}
> +
> +static void bitmap32_clear_word(uint32_t *bitmap, int word_offset,
> +                                uint32_t mask)
> +{
> +    bitmap[word_offset] &= ~mask;
> +}
> +
> +static void bitmap32_set_word(uint32_t *bitmap, int word_offset, uint32_t mask)
> +{
> +    bitmap[word_offset] |= mask;
> +}
> +
> +static uint32_t bitmap32_read_word(uint32_t *bitmap, int word_offset)
> +{
> +    return bitmap[word_offset];
> +}

You might also consider the approach the gicv3 takes for these
bitmap arrays, where we have a gic_bmp_ptr32() function that returns
a uint32_t* of the appropriate word in the bitmap. That lets you
write arbitrary operations like

   *gic_bmp_ptr32(bmp, irq) |= value;

   *gic_bmp_ptr32(bmp, irq) &= ~value;

etc

rather than having to write a function for every operation you want to do.

> +static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
> +                            unsigned size)
> +{
> +    if (offset == 0) {
> +        uint32_t cmd = (val >> 16) & 0x3;
> +        uint32_t irq = val & 0x3ff;
> +        uint32_t slice = (irq / 32) * 4;
> +        val = 1 << (irq % 32);

Anyway, this is the Coverity issue: this should be "1ULL << ...".
Otherwise the shift happens on "int", and if we shifted by 31 then
the value gets sign extended into val rather than zero extended
as you might have expected. This is CID 1685261.

thanks
-- PMM


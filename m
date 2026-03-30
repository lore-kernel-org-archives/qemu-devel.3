Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B5B1061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7H25-0004Op-K5; Mon, 30 Mar 2026 14:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7H1l-0004II-R5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:07:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7H1h-0002LX-KN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:07:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso39597775e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774894063; x=1775498863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=92b5QUB1yQCcsiShMBI2EDfqTplZvRI7/jv+VGujLys=;
 b=AbxrDA1Q4UEwTjbPrIS5UXHjwkgRNXgKpZ62KzIsyfrhSRZkevyivA2dBw/9VNG4A3
 1JMRXkOsdbZQmg/3IMCRNjpQfYoc9gCaO349cjcl5x1pmG2lXQFTdws3clYv6orpbFaV
 J3KsubFPXZb2CtdOdF0CGPPOOu/5pPAS9z0/oUmpDTq4ZpqxshR/Ir3YAuvudmK/Znc5
 FqLInHfCw/G0CPHcrb4jCK6BUXXR43HaEM5OHREqGIuM3VRF7QH7FZiQKiFHDt85iqiI
 7nRloywMkVdU9oQY8UZw90PXp8OKmBgLdDAtT4wjfShbV4cNcqDi0igceQlxGoFW/GuI
 h+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774894063; x=1775498863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92b5QUB1yQCcsiShMBI2EDfqTplZvRI7/jv+VGujLys=;
 b=Kvnir8W/D/6/mVkqIXraM5PWc36l0nLw9esBGhnCaq2L5DpOl9KwvAJr0YaF24Z4yH
 zv00GMs/F4j0QVGxjXn4IAW2D71yqYYPlC7gxHUAdBy5I/7MQsY6fURjmGAYVAd13hNE
 RFLd5jqlZo6k385cZ2CBonn4Z6TrkzwqyhKld4+cYjB0IA6Y5Msuro61giNEhCrFIG5D
 BOBz8Y2rTJyPB9N5jT8odUpiLpyHYSJkAPQun6pTBichES8BwwdA32TguTo6GtNK7hlz
 ii7gmzei7/SfesvCFqG9MOVHFbO98+MVoRvi91TV6ZZayvcQVOSEBQR00vTC2xFIZ37U
 CqfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLik4VBVEVDV2+vTt6pt5yGEXO/hV8vgllT0JpBqNEkW1T0pehPy8DCTnQG1OTCj25bgN4IYpjllFS@nongnu.org
X-Gm-Message-State: AOJu0Yx8GFQ5JglW7g3xTmfWjUgPGky38SgNUfTUEncsb3NosCX9vfwb
 qqSQUmrx0VsAWbZNJeiSWyHPZ9mXnmL7soYID4/M9p3pQ88g9++u8qmXScspvZeHy40=
X-Gm-Gg: ATEYQzzXJlEcQ9Eeh1kKIaiurkB6Khq2KuDwpYlSYSVzmADd74ssVpPGdCp23rYmneY
 dMMbyT+aKbblkQH/fDKlcIOjSLcfPYJnCcX1Dd4+IMQT8ny8LY1hdr/0UI6UD7kfsL++0+mPBDh
 Bt7c2s/aUgAW8e47qKpMIxEpGM7kg3C7nvXUkc6N+vVQt/D8RhpTNNjxw8Vcfh1xpffvu8EAyxc
 gT7JM2dhK40ryjxNxMC40CwT0kxvbTMtVEzTKpbMESl/j3M/y7qwdnIEJglP1+CEVQAtUFUvStN
 JjKEjOT0gDulR8TfE6G3nf86sukz2E2KQFbP8IWXFvZNEkpu1kGz4kUQ0VFxb1BHREJH9mBrVtk
 stTGghArdYm4g9jc5p3HGquUWrJy9wwa6wkuWcXtYLrr2ImEYjZZrMsrQrLJ8jaD/Eo49GQsUm0
 buOYA3PmNKhqB4DlFv5vCCnB29ud9kfzzDv9N4gRt5mgi8o7DD2Zy/3YuYxm1l8vITsw==
X-Received: by 2002:a05:600c:8207:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-48727ee4444mr233926475e9.29.1774894063231; 
 Mon, 30 Mar 2026 11:07:43 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48733c094dasm66077495e9.17.2026.03.30.11.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:07:42 -0700 (PDT)
Message-ID: <4e09e0d1-bbb8-4140-9246-71a12a3d68da@linaro.org>
Date: Mon, 30 Mar 2026 20:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cirrus-vga: Add property to set frame buffer
 endianness and make it default to little endian
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260330140655.31EC55968DE@zero.eik.bme.hu>
 <87mrzpgucz.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mrzpgucz.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/3/26 18:22, Fabiano Rosas wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> I've tried this but it does not seem to work and leaves default to
>> auto. Could somebody tell how this should work?
>>
> 
> This patch sets the hw_compat to "off" so when new code migrates to/from
> an old machine type, it will set the endianness to LE due to the
> conditional you added.
> 
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2
>    s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
> 
> overriding works:
> 
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=on
>    s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
>    
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -M pc-q35-10.2 -global cirrus-vga.x-big-endian-fb=off
>    s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
> 
> The default value is a separate thing, this patch sets it to "auto" so
> unless the hw_compat or the user overrides it, that's what you get.
> 
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus
>    s->big_endian_fb: 0
>    (s->vga.big_endian_fb: 0, unchanged)
>    
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=on
>    s->big_endian_fb: 1 --> s->vga.big_endian_fb: 1
>    
>    ./qemu-system-x86_64 -display none -nodefaults -vga cirrus -global cirrus-vga.x-big-endian-fb=off
>    s->big_endian_fb: 2 --> s->vga.big_endian_fb: 0
> 
> Maybe what you want is to say the old behavior is auto? Then set the
> default to off.

Probably better.

> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/core/machine.c                | 2 ++
>>   hw/display/cirrus_vga.c          | 6 ++++++
>>   hw/display/cirrus_vga_internal.h | 2 ++
>>   hw/display/cirrus_vga_isa.c      | 2 ++
>>   4 files changed, 12 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 0aa77a57e9..e573ef46bc 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,8 @@
>>   GlobalProperty hw_compat_10_2[] = {
>>       { "scsi-block", "migrate-pr", "off" },
>>       { "isa-cirrus-vga", "global-vmstate", "true" },
>> +    { "isa-cirrus-vga", "x-big-endian-fb", "off" },
>> +    { "cirrus-vga", "x-big-endian-fb", "off" },
>>   };
>>   const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>>   
>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>> index 629b34fc68..e379f125ae 100644
>> --- a/hw/display/cirrus_vga.c
>> +++ b/hw/display/cirrus_vga.c
>> @@ -2930,6 +2930,10 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
>>       s->vga.cursor_invalidate = cirrus_cursor_invalidate;
>>       s->vga.cursor_draw_line = cirrus_cursor_draw_line;
>>   
>> +    if (s->big_endian_fb != ON_OFF_AUTO_AUTO) {
>> +        s->vga.big_endian_fb = (s->big_endian_fb == ON_OFF_AUTO_ON);
>> +    }
>> +
>>       qemu_register_reset(cirrus_reset, s);
>>   }
>>   
>> @@ -2987,6 +2991,8 @@ static const Property pci_vga_cirrus_properties[] = {
>>                          cirrus_vga.vga.vram_size_mb, 4),
>>       DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
>>                        cirrus_vga.enable_blitter, true),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
>> +                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
>>   };
>>   
>>   static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
>> diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
>> index a78ebbd920..7c07201f18 100644
>> --- a/hw/display/cirrus_vga_internal.h
>> +++ b/hw/display/cirrus_vga_internal.h
>> @@ -26,6 +26,7 @@
>>   #ifndef CIRRUS_VGA_INTERNAL_H
>>   #define CIRRUS_VGA_INTERNAL_H
>>   
>> +#include "hw/core/qdev-properties.h"

"qapi/qapi-types-common.h" instead.

>>   #include "vga_int.h"
>>   
>>   /* IDs */
>> @@ -94,6 +95,7 @@ typedef struct CirrusVGAState {
>>       int real_vram_size; /* XXX: suppress that */
>>       int device_id;
>>       int bustype;
>> +    OnOffAuto big_endian_fb;
>>   } CirrusVGAState;
>>   
>>   void cirrus_init_common(CirrusVGAState *s, Object *owner,
>> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
>> index 76034a8860..c2b0b61476 100644
>> --- a/hw/display/cirrus_vga_isa.c
>> +++ b/hw/display/cirrus_vga_isa.c
>> @@ -75,6 +75,8 @@ static const Property isa_cirrus_vga_properties[] = {
>>                        cirrus_vga.enable_blitter, true),
>>       DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
>>                        cirrus_vga.vga.global_vmstate, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("x-big-endian-fb", struct PCICirrusVGAState,
> 
> s/PCICirrusVGAState/ISACirrusVGAState/
> 
>> +                            cirrus_vga.big_endian_fb, ON_OFF_AUTO_AUTO),
>>   };
>>   
>>   static void isa_cirrus_vga_class_init(ObjectClass *klass, const void
>>   *data)



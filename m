Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373BAE68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PVN-0004b8-0Q; Thu, 31 Oct 2024 03:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PVL-0004am-7Z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:22:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PVJ-0000RQ-AH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:22:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso472531f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730359320; x=1730964120;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+vCVdG01nVCL6ewv08nkx+w0ZPhuAMWeXO+duAdUmI=;
 b=tkLbt6/ruO8fKn2kCe8zDNkU3hbJvD0fA+mER6RYsBrk7S31OsIRKd1HIBSaGqYoCI
 UAYIZ0IirLvCjxI3Ln7SF9d0KLF0mTUNCh9SoI4+JV9C0IufdrXjwbNarZje9Yj6aB40
 3VX9nTIQ5KX+pWVZupeSWIt3lWvDZgAncK6azd+VoB+MIZUoEa5JjgJa/yMF0BjDa3k+
 0fTcu12St6hdYSh9kZkvQB/heICTrOtxpdHaMwe7tx7aOJTS1s8pEb/3wxNZo6MoCMqP
 tCv9soLjOL5JyJedVLmTjFyn6OGOYEz3kxRiQLY9sc/wHhDa7M6LD4gaKn1cfuMc0bff
 zM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730359320; x=1730964120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+vCVdG01nVCL6ewv08nkx+w0ZPhuAMWeXO+duAdUmI=;
 b=iiQLegzIvayaR+WOGbYMeWfH5N4uowaeMSu9vTU+40msjrPQOU3W/eBp5SpPl+y1Ak
 nCgC2q29HU7h8A8ZGVlgNf1uaMk1IQCcYIB1+U+caoEmmh773IpkO0Zj555OX1lX+KKG
 NpcReqrD5YuOBgZDOkzwtg6lXwlNJCe/R+sBPSDMOWgc2J9FZEr7WYSrB4LNcoiLlXlf
 W/FxGVTijGPItfHRNxHc4i86N18SZq2avvZqRj8uO64A6EWl+vORBhljfusn/KYVwUe8
 FXK+Lnj7ljyeum5Adw/l2uHziTzOTZXL16FFczL8EvVOc/d69NdfIcx1TfliIHwdGpaw
 BCag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGwpihjVq3bshNZjORKMVQl4Tm2H4Fd9uaXxYxVg3fmJdwxJEhXV9cqSlP1FXajOfmEzpQCjltc7dx@nongnu.org
X-Gm-Message-State: AOJu0YycCEBX5mvc4RjF6bppJ3O4jOdvcyicHtDvkHFd4TF4skvnIDH1
 4cN/EJaQmMJqlQP0+6vlJL5iZ/9RIqwLBVB3iN5BZT3wVuKs5vOj9DLWCicJwzg=
X-Google-Smtp-Source: AGHT+IHfo3dnxhz3fn58/onxTE0nDKASDgOSrAwqFVTtqRSBMF9yQH27czKKesaAHvb2RGN1n/waVw==
X-Received: by 2002:adf:e341:0:b0:37d:9508:1947 with SMTP id
 ffacd0b85a97d-3806123ee9fmr15871922f8f.51.1730359319705; 
 Thu, 31 Oct 2024 00:21:59 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e94cdsm14524755e9.28.2024.10.31.00.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:21:59 -0700 (PDT)
Message-ID: <fcff076c-5616-46f3-aaa1-45d3ad1bbb44@daynix.com>
Date: Thu, 31 Oct 2024 16:21:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-2-b2394236e053@daynix.com> <Zx_AuOl7l5b2UIjG@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zx_AuOl7l5b2UIjG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024/10/29 1:50, Daniel P. Berrangé wrote:
> On Tue, Oct 22, 2024 at 01:50:39PM +0900, Akihiko Odaki wrote:
>> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
>> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
>> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
>> bool.
> 
> Again, same feedback as last time.
> 
> With this design, existing users of DEFINE_PROP_BIT64 that
> get converted to DEFINE_PROP_ON_OFF_AUTO_BIT64, in addition
> to gaining the desired "auto" value, also gain redundant
> 'on' and 'off' values as side-effects.
> 
> In the next patch, the stated problem is that virtio code
> needs to distinguish between bits that are user set, and
> bits that are set based on available host backend features.
> 
> That doesn't seem to require us to accept any new values
> from the user. It should be sufficient to track user
> specified features, separately from user specified values.
> ie when parsing user input for bitfields, we need to parse
> into a pair of fields
> 
>    uint64_t has_user_features;  /* which bits were specified */
>    uint64_t user_features;      /* values of specified bits*/

Properties also have getters. We don't know what to return with them 
without the new value.

Regards,
Akihiko Odaki

> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/qdev-properties.h | 18 ++++++++++++
>>   hw/core/qdev-properties.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index 09aa04ca1e27..afec53a48470 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -43,11 +43,22 @@ struct PropertyInfo {
>>       ObjectPropertyRelease *release;
>>   };
>>   
>> +/**
>> + * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
>> + * @on_bits: Bitmap of elements with "on".
>> + * @auto_bits: Bitmap of elements with "auto".
>> + */
>> +typedef struct OnOffAutoBit64 {
>> +    uint64_t on_bits;
>> +    uint64_t auto_bits;
>> +} OnOffAutoBit64;
>> +
>>   
>>   /*** qdev-properties.c ***/
>>   
>>   extern const PropertyInfo qdev_prop_bit;
>>   extern const PropertyInfo qdev_prop_bit64;
>> +extern const PropertyInfo qdev_prop_on_off_auto_bit64;
>>   extern const PropertyInfo qdev_prop_bool;
>>   extern const PropertyInfo qdev_prop_enum;
>>   extern const PropertyInfo qdev_prop_uint8;
>> @@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
>>                   .set_default = true,                              \
>>                   .defval.u  = (bool)_defval)
>>   
>> +#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
>> +    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
>> +                OnOffAutoBit64,                                             \
>> +                .bitnr    = (_bit),                                         \
>> +                .set_default = true,                                        \
>> +                .defval.i = (OnOffAuto)_defval)
>> +
>>   #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
>>       DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
>>                   .set_default = true,                         \
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index f0a270bb4f61..cc76ff0dfae6 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -187,7 +187,8 @@ const PropertyInfo qdev_prop_bit = {
>>   
>>   static uint64_t qdev_get_prop_mask64(Property *prop)
>>   {
>> -    assert(prop->info == &qdev_prop_bit64);
>> +    assert(prop->info == &qdev_prop_bit64 ||
>> +           prop->info == &qdev_prop_on_off_auto_bit64);
>>       return 0x1ull << prop->bitnr;
>>   }
>>   
>> @@ -232,6 +233,69 @@ const PropertyInfo qdev_prop_bit64 = {
>>       .set_default_value = set_default_value_bool,
>>   };
>>   
>> +static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
>> +    int value;
>> +    uint64_t mask = qdev_get_prop_mask64(prop);
>> +
>> +    if (p->auto_bits & mask) {
>> +        value = ON_OFF_AUTO_AUTO;
>> +    } else if (p->on_bits & mask) {
>> +        value = ON_OFF_AUTO_ON;
>> +    } else {
>> +        value = ON_OFF_AUTO_OFF;
>> +    }
>> +
>> +    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
>> +}
>> +
>> +static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
>> +    bool bool_value;
>> +    int value;
>> +    uint64_t mask = qdev_get_prop_mask64(prop);
>> +
>> +    if (visit_type_bool(v, name, &bool_value, NULL)) {
>> +        value = bool_value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>> +    } else if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
>> +        return;
>> +    }
>> +
>> +    switch (value) {
>> +    case ON_OFF_AUTO_AUTO:
>> +        p->on_bits &= ~mask;
>> +        p->auto_bits |= mask;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_ON:
>> +        p->on_bits |= mask;
>> +        p->auto_bits &= ~mask;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_OFF:
>> +        p->on_bits &= ~mask;
>> +        p->auto_bits &= ~mask;
>> +        break;
>> +    }
>> +}
>> +
>> +const PropertyInfo qdev_prop_on_off_auto_bit64 = {
>> +    .name  = "OnOffAuto",
>> +    .description = "on/off/auto",
>> +    .enum_table = &OnOffAuto_lookup,
>> +    .get = prop_get_on_off_auto_bit64,
>> +    .set = prop_set_on_off_auto_bit64,
>> +    .set_default_value = qdev_propinfo_set_default_value_enum,
>> +};
>> +
>>   /* --- bool --- */
>>   
>>   static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
>>
>> -- 
>> 2.47.0
>>
>>
> 
> With regards,
> Daniel



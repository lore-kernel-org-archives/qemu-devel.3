Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF08C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 06:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfuxb-0002AI-22; Thu, 06 Feb 2025 01:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfuxP-00028m-CV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 01:01:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfuxN-0000NQ-0m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 01:01:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f11b0e580so11482505ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738821703; x=1739426503;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eniVEduT0ZKIKFpU+5+JfUDYGtY7H1aYn6MCC6+wZTQ=;
 b=Z7nkKsGfTkB1B55ebn3pf4jyA00KpYY8u6vaCbwNtS9RNqAshHn8xmaAIi6Ra9xjYy
 uqM/4uv4t9JUdCtrvuyI4uWfILF+lZQGwDnJxMTjA8mAAkVsEAeWnNaztGl8glgSMjEI
 oGgGmpotIC+Az4RokAGzrlVQ1youGhHSE8w98OYqfeKkpvncJnDkmwfFZLteyeIabGMj
 PFTlECcpr0zpASRhbMDvH/AHCdiT9lE0/QHdiU6WZKyqTPFpWwFAanTdI4vVXQOYMTme
 4JIDthFWLSMO6w6BYpPjMLPFXEMtMoxDB+UC9UjLp9ergSzcQU+Ia1EP7o2nIiibBp/c
 heLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738821703; x=1739426503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eniVEduT0ZKIKFpU+5+JfUDYGtY7H1aYn6MCC6+wZTQ=;
 b=d4xNFrr22sJvMnT20VejB/m8ib359hlVDb7aL8e4JHgdHKY/YmTiQt91AjBsx/xZdN
 yR+lMKuP2VXFHlOyganmV/51gYMhok1YMRVCkwpBi+bZC3hs3Pno4htjVlvrMC0xOtUa
 Rkz18nE1ZSc3LxR1QuQJ87BrPpsit1/fEHZJznUjlELNtCYXA7wPPZFxrN8QLfqnIZyg
 CPHr6a2xgKKRz4bx7Em7Rw8araqKd6sL/68SZBZPLAmqnf4/vBAdIbikJo38csMIB8iw
 6AN3QLmtftGogMi8ZxVhI0AdgQuspUduritYy7Pfvp5be0pb99dg5rgIwYRw5+xuV4qC
 3cpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUY9CLhgHekeoSH+59d8aBYE5o/W3REPy1VZvG7QzUFePdit2no2sA8Eche8dz9gKEx4KE1JmHE5+U@nongnu.org
X-Gm-Message-State: AOJu0YykOLIBvLeexxIKrkEpSu1KLackaFOWYodqGrsyqToQIiehY8Em
 4xAfBO9FBsd9V9JqLP+P65p8NxOOMiRuKCS1gXy/w1AhvAqGDyD28TTOsNk7dFg=
X-Gm-Gg: ASbGncukJ5YhX4lmLYPqp7cLeFhT46/FIkRzVFR2v7qFWTnUHV502R/Ia2o43NUAPtK
 T+sbtGXux23wRN6imEv2Y84wqQNx+Ix9AHEZqaj9a3l4+zKlgEmx/kPIWE2ZxI9I2ISeBIpVDdb
 0DecKxfNSWOIL0wEka8Yo6kwG1bbylCyFOifAHF6IGh+toFX8XlZTFxGfZ6xszKQArQhXD9v+z5
 ld3ZaK8RYxm4zdSorHQcsFGTFdu/PRo50Gq82tzcnJabyJVte2/E3qJZ1p+OcBWOd/ZLKu1aB5c
 BQi2fO8OmVrIEd0hDCVqsLFtJePl
X-Google-Smtp-Source: AGHT+IHe67iEggMKI40cJyL5Bwv/gfl4M3u9q+e/ScdIb5Md431zfJKqlEYic9kKigxjFLTkoDHcAQ==
X-Received: by 2002:a17:902:e5c7:b0:21f:b6f:3f39 with SMTP id
 d9443c01a7336-21f17ef010bmr98045995ad.34.1738821703327; 
 Wed, 05 Feb 2025 22:01:43 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09a183c8sm511520a91.14.2025.02.05.22.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 22:01:42 -0800 (PST)
Message-ID: <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
Date: Thu, 6 Feb 2025 15:01:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <87cyfwxveo.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cyfwxveo.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/02/06 0:29, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Accept bool literals for OnOffAuto properties for consistency with bool
>> properties. This enables users to set the "on" or "off" value in a
>> uniform syntax without knowing whether the "auto" value is accepted.
>> This behavior is especially useful when converting an existing bool
>> property to OnOffAuto or vice versa.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/core/qdev-properties.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 434a76f5036e..0081d79f9b7b 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>>       .set   = set_string,
>>   };
>>   
>> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
>> +                            void *opaque, Error **errp)
>> +{
>> +    Property *prop = opaque;
>> +    int *ptr = object_field_prop_ptr(obj, prop);
>> +    bool value;
>> +
>> +    if (visit_type_bool(v, name, &value, NULL)) {
>> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>> +        return;
>> +    }
>> +
>> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
>> +}
>> +
>>   /* --- on/off/auto --- */
>>   
>>   const PropertyInfo qdev_prop_on_off_auto = {
>> @@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
>>       .description = "on/off/auto",
>>       .enum_table = &OnOffAuto_lookup,
>>       .get = qdev_propinfo_get_enum,
>> -    .set = qdev_propinfo_set_enum,
>> +    .set = set_on_off_auto,
>>       .set_default_value = qdev_propinfo_set_default_value_enum,
>>   };
> 
> The qdev properties defined with DEFINE_PROP_ON_OFF_AUTO() now
> additionally accept bool.
> 
> The commit message tries to explain why this change is useful, but it
> leaves me confused.
> 
> Does this solve a problem with existing properties?  If yes, what
> exactly is the problem?
> 
> Or does this enable new uses of DEFINE_PROP_ON_OFF_AUTO()?
> 
> I'm trying to understand, but my gut feeling is "bad idea".
> 
> Having multiple ways to express the same thing is generally undesirable.
> In this case, "foo": "on" and "foo": true, as well as "foo": "off" and
> "foo": false.
> 
> Moreover, OnOffAuto then has two meanings: straightfoward enum as
> defined in the QAPI schema, and the funny qdev property.  This is
> definitely a bad idea.  DEFINE_PROP_T(), where T is some QAPI type,
> should accept *exactly* the values of T.  If these properties need to
> accept something else, use another name to not invite confusion.
> 
> If I understand the cover letter correctly, you want to make certain
> bool properties tri-state for some reason.  I haven't looked closely
> enough to judge whether that makes sense.  But do you really have to
> change a whole bunch of unrelated properties to solve your problem?
> This is going to be a very hard sell.
> 

I change various virtio properties because they all have a common 
problem. The problem is, when the host does not support a virtio 
capability, virtio devices automatically set capability properties false 
even if the user explicitly sets them true. This problem can be solved 
using an existing mechanism, OnOffAuto, which differentiates the "auto" 
state and explicit the "on" state.

However, converting bool to OnOffAuto surfaces another problem: they 
disagree how "on" and "off" should be written. Please note that the 
disagreement already exists and so it is nice to solve anyway.

This patch tries to solve it by tolerating bool values for OnOffAuto. As 
you pointed out, this approach has a downside: it makes OnOffAuto more 
complicated by having multiple ways to express the same thing.

Another approach is to have one unified way to express "on"/"off" for 
bool and OnOffAuto. This will give three options in total:

1. Let OnOffAuto accept JSON bool and "on"/"off" (what this patch does)
2. Let OnOffAuto and bool accept JSON bool and deprecate "on"/"off"
3. Let OnOffAuto and bool accept "on"/"off" and deprecate JSON bool

I'm fine with either of these approaches; they are at least better than 
the current situation where users need to care if the value is OnOffAuto 
or bool when they just want to express on/off. Please tell me what you 
prefer.


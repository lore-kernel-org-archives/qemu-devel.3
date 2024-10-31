Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313F8E68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PUg-0004Xe-AO; Thu, 31 Oct 2024 03:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PUf-0004XW-HR
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:21:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PUd-0000Nu-AA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:21:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so4670305e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730359277; x=1730964077;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zuop8CXsJhNCYhcpwiLCpRtqG7leKD1xs9iMRDLK5ss=;
 b=nIMC4ZFJapATy5kQ8AmkWdHkEKMkIA2LZjYdSiEDmn2sSebTMWkkI8msCobwb3xxlu
 /+CBMiahCI0aPpGnGZ7EReeKOiiQIKGzDpW3VX6rCzHuXz8XWXExhlrrOhYSvGP1icpM
 as4DqB29EZWIHlDT2LAfdB/ykIaSkxvqdmXNwMogPcgcNJTIpRuPc9uID+HRjnUFcy8C
 uKyPXjuTqsCjAbUiQTp7nrpeaAYtjGK7Wp0Nxz7k7Md6KVKTdNM5HL40NknRPj8NxEuf
 6Cx3+NEThmKohPmTIqnKVBLiQ5qWIcEt85zPrL/KZkoFMXd5hUI1/Da/JXnia0fmFmSs
 O1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730359277; x=1730964077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zuop8CXsJhNCYhcpwiLCpRtqG7leKD1xs9iMRDLK5ss=;
 b=TsP+N6naztzY5bqEhKbZ8XQxn0td7OQ08UMJRviFKOv15T/YVpdn1d5tpEzJP6KbQ1
 9slU1xDUV4Mnt244gyAWLGNANjmMs3G18zwdT/zPlQbQS2Z6Nl/TWfQu3sUAeOpqTMiH
 QvimwXK65Iq3nwb2Sa9cKZDuh4Z1hkdWyeMYtsN2dst5RvGDxaC20wY2X3zToFHs2rj/
 PFGA/sYzQz+0hVWmoZI4OWMEApj14XVxZSmGej4YNXoExooFQKgpIMTi83oFa72kk+MN
 Yx213NiEp06WKgi8/t3na7F5VxG/YYtmRfBHoZr0YL8zyIzXjCniE/rTVvy3AMGa5RUe
 kyWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWkEwUI20O9IqTa5QsFQOQDoYsWTSfzdVtkdxi12BF+AwtR7ZiHr39dT5B1nNyLWIi+9tVmcyfMRjp@nongnu.org
X-Gm-Message-State: AOJu0YxvCHBPMItiVXkHaeO+AxRrdt4TpQuNkc+5UuAZ6IaltbNBHg8i
 5bnUDtX4SPKotGN6zj4jL03q6ENTUaPhXj5SdZcdBMs0Awp+kjQ8gK8dx5/8sIQ=
X-Google-Smtp-Source: AGHT+IGrg3X1DdmdhZO748tL7DC6hyRq9UXo3Wi1H32ZincFc1rcu24LKp6mq1TUxv/prl5bJr4saA==
X-Received: by 2002:adf:f5d2:0:b0:37d:4afe:8c9b with SMTP id
 ffacd0b85a97d-3806122165amr11617195f8f.54.1730359277096; 
 Thu, 31 Oct 2024 00:21:17 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7435sm1207056f8f.52.2024.10.31.00.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:21:16 -0700 (PDT)
Message-ID: <3dd9b22b-2e0c-4999-aab0-eac751923c35@daynix.com>
Date: Thu, 31 Oct 2024 16:21:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qdev-properties: Accept bool for OnOffAuto
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-1-b2394236e053@daynix.com> <Zx_Ag0_MFem7Qn3a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zx_Ag0_MFem7Qn3a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::331;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-wm1-x331.google.com
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

On 2024/10/29 1:49, Daniel P. Berrangé wrote:
> The parent msg was sent off-list orignially, so below is a copy
> of my feedback to that off-list posting.
> 
> On Tue, Oct 22, 2024 at 01:50:38PM +0900, Akihiko Odaki wrote:
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
>> index 86a583574dd0..f0a270bb4f61 100644
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
> 
> My feedback is the same as last time this was posted.
> 
> This is adding redundant new input-only & secret syntax for every
> usage of OnOffAuto across QEMU.
> 
> "consistency with bool" isn't a expressing a compelling advantage.
> 
> The new permitted values are invisible to applications, beacuse
> introspecting QAPI schema for the "OnOffAuto" type will never
> report them, and querying the value of a property will also never
> report them.
> 
> I'm not seeing an advantage, or clear problem solved, by adding
> this.

The intent of this patch is to ease migration from bool to OnOffAuto; a 
user should be able to set the "on" or "off" value without knowing the 
"auto" value is accepted.

The redundancy of syntax is already present with bool. If it is 
problematic, the redundant syntax should be deprecated altogether, 
whether the type is OnOffAuto or bool.

We can add a alternate type of OnOffAuto and bool to the QAPI schema, 
but this type is not used in QAPI and is unnecessary.

Regards,
Akihiko Odaki

> 
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
>>   
>>
>> -- 
>> 2.47.0
>>
> 
> With regards,
> Daniel



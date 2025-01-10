Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C13E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDFN-0000NE-5Z; Fri, 10 Jan 2025 06:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWDFJ-0000Mv-08
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:32:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWDFF-0006kK-1U
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:32:08 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21654fdd5daso30906715ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736508723; x=1737113523;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOwfl8T1OPi3LmDUEiujmtqKC+bsz3f6LCCi1mvK46s=;
 b=gDu57tP7oMdm+w+tpEC1sbQ+n4vfzJrkbpW/3kV0+8K5GBbO0Mssy5tqdqmJ5+ypu1
 vIA6sz2F+T3LUr290maFw/7XblG+wJaehK+Z1AIgDTLENGn8QyYeu2KOpMl37r7g1t1y
 jvRtE3OpQeiaPmLawmT4VSXGFOMYaOO2qgNEgsVofm02AI1zstK3NccAvBdAEoy8nuBB
 YAJX/TsaYwc2naNlUOHZZdLs4vlA+uxSRpoCs5s3KRyCHf0cO+I9TbYxPc9m9tmJ5SrV
 ZBYO0UQTen/PdrNVG31Nz7i0XCQ2mVYR0y6CBDZYsPX6c5mSpkAcPTp4E28A6VaV9vqS
 gY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736508723; x=1737113523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOwfl8T1OPi3LmDUEiujmtqKC+bsz3f6LCCi1mvK46s=;
 b=Ap6wr1SFEX+zqk+0YTPx8O828xAGHtp3oI25gwUZG1X+nVsV2DqtPBf4WvdSYYcIrR
 24G2yZvf8y25g5hqjgl/kkOW0QK6w+da1ZPWj6NSMYhZiz05+O/yMaa/1KhEmkDfMh6T
 MXIFp6eRB6u49jF7t105H/RZoggm2bA+utplAJs3pgTCQsGv4Hst+yfmOd14kP6dG+TB
 8bzny0pKQo2VwrfjnoegIZzAQKxSHsv2l5jExAAvsnqVKu+rCzrj2NIlCeFhHIakuDcr
 BnAW+tYIW2bAlRwxQh0Hr/fOccBxZFDnHWcAjWH9UU/BJ9rqF9iiQ3ctau33X4keFnnp
 G7Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHXGv1vX2zVBktnsvWQvz+zxgVcfIth61ir+gTgWHyAWZULrEABJYQwWydEwa9I6rHfNKmwUr0FLX@nongnu.org
X-Gm-Message-State: AOJu0Yw0wQrJ+N28YlfkttXMCq6fba1aPmFLLpRJVZm56QLLDz3NY/Ir
 VHt1D3TNMKIV8vBMqorUeF2zyvSTdTqA39pm+OvpX1cV8pHof1b9eHZjn65Ahsg=
X-Gm-Gg: ASbGncv3A6HX1SF8Am5wQyFMPZLKZGRirD3qJjfkzbuUvfzciZUokke1xe+V7A2zWTz
 LrQtjbMt7hVPRVMQkwg5PJvjtPyMDo8UoLzgfiVg9bkpoVSRDU7FB5qBh9ERVFQhWPO5d4KNv5S
 kiDxO+ZTnlcNFDtoq7cOF6VEFcVeMFFXKP4yFMwKyd6fLoN2YII4AqlehbpFKj7QZ1WP1HuRpEt
 +e8zHedBq9/6n6Cf5TiqdU0mTVuR0aCoVBCYFCdfN7IwNmDlVPqIT38rLf+na6i1B8=
X-Google-Smtp-Source: AGHT+IEQcZXgK0HfQgTBt34zh8rNJyUV1pxrOtNTRQzrqrfL54D9wIzo9z/Z0UrkDCReJGc86owkGA==
X-Received: by 2002:a17:902:e74d:b0:216:3e9a:89e with SMTP id
 d9443c01a7336-21a83fde4f2mr149414755ad.35.1736508723284; 
 Fri, 10 Jan 2025 03:32:03 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f253fd3sm12258485ad.229.2025.01.10.03.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 03:32:02 -0800 (PST)
Message-ID: <65364ac5-3d8e-4f43-a371-4661bf8b5437@daynix.com>
Date: Fri, 10 Jan 2025 20:31:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
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
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <Z4D_zK-QIN07EXR5@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4D_zK-QIN07EXR5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

On 2025/01/10 20:09, Daniel P. Berrangé wrote:
> On Wed, Jan 08, 2025 at 03:17:51PM +0900, Akihiko Odaki wrote:
>> Accept bool literals for OnOffAuto properties for consistency with bool
>> properties. This enables users to set the "on" or "off" value in a
>> uniform syntax without knowing whether the "auto" value is accepted.
>> This behavior is especially useful when converting an existing bool
>> property to OnOffAuto or vice versa.
> 
> Again, to repeat my previous feedback, OnOffAuto is a well defined
> QAPI type - making it secretly accept other values/types behind
> the scenes which are not visible in QAPI scheme is not acceptable.
> 
> Effectively this is a backdoor impl of a QAPI alternate
> 
>    { 'alternate': 'OnOffAutoOrBool',
>      'data': {
>        'o': 'OnOffAuto',
>        'b': 'bool'
>      }
>    }
> 
> except this isn't permitted as the QAPI generator explicitly blocks
> use of alternate when the two branches are 'bool' and 'enum'.

The QAPI generator specifically blocks the case where the enum contains 
'on' or 'off'.

> 
> I'm assuming this is because in the QemuOpts scenario, it cannot
> guess upfront whether the input is a bool or enum. This is unfortunate
> though, because at the JSON visitor level it is unambiguous.

It's probably for the command line and possibly HMP.

> 
> I wonder if the QAPI generator could be relaxed in any viable way ?
It will make the interpretation of 'on' and 'off' on the command line 
ambigious; it can be either of OnOffAuto or bool.

Making some sort of backdoor is necessary to support the proposed 
semantics. We will need a new built-in type to represent the tristate 
value; I haven't added one though as it's not necessary for virtio 
properties I'm concerned of.

> 
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
>>   
>>
>> -- 
>> 2.47.1
>>
> 
> With regards,
> Daniel



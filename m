Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78317C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9D5-0001z0-JN; Thu, 05 Jun 2025 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9D3-0001yN-MX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uN9D1-0003LL-W7
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749124595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5D8ItS4B+oQ8wPJX6ZzierQPc64SpBbJI5HY+cjLr+g=;
 b=Qkpp3XxeJBmrxiPi1CgMYg6EjOHxmlHdIm35bPOtotGW2gnBk0Avb7/mDovN3pXKUzc5sb
 34tOmfh2jrQgVJ0Os5pyEW+5B9G8PvoH9Mk0S1TwOB89dT6/GHzAS0fCEzFVQ5kzQDRxCl
 +N48uy7yYjNB3ez6ahnjRT7Xyz9gcQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-YfDYqphXM62uxqz0xQ33Uw-1; Thu, 05 Jun 2025 07:56:31 -0400
X-MC-Unique: YfDYqphXM62uxqz0xQ33Uw-1
X-Mimecast-MFC-AGG-ID: YfDYqphXM62uxqz0xQ33Uw_1749124591
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a52cb5684dso231786f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 04:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749124590; x=1749729390;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5D8ItS4B+oQ8wPJX6ZzierQPc64SpBbJI5HY+cjLr+g=;
 b=EaPFIDjaaZqLItFG4TkhCA6qyjA7mmQeJyc/vacn1QroFz0xS5vynkR8ilCpruu4jI
 35hXPGp2amDIkr+WBQYOAjb2Az+l7lbtORvFmYljWXLE2FdW4G9+1cNKyRkLJpYXszQn
 NEhqdvSJqXxh0Y/6MyiZ0HY3WUcviRFGwVCj+nFPGWHNY6Gdv7c7N4uyyArX49GxNvOX
 c3EDYYHe2wjoropyG/WU2ikg5jIHFrAYHT2tJmdZyHK2R+WJZNj10H7ELy7AYPAy+mmY
 wpb8IrOScM28LBXpLe+/cagGt9r5luGIGaMQ8xJTiHKbkwNDdufvqQq45wjEMT7UnVKh
 hBlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXstDEfaakkySXqq3nlIHxwv/+h1gxNsVuzV6H6NaOYcNBbaFmv7cVPL9sk4OUh5tASWVTvOSR1l2Yp@nongnu.org
X-Gm-Message-State: AOJu0YzM0obpansrv5PTQbNF5sVzxuh3GgCQmt7/Fk7Luec2vzipuNrI
 ejwPLJ1OqI/1Zr2FwDxFoCHJ6ssiT4R1v7ScLlbhsNosS37YZudt01A4DQiQs6OdcWDpPf/hcaD
 gSvfjqfoOuiMEaF9D1g9VIJRmrNZf/z2a3+mzCnsJWBZCfhju0nMTj1hN
X-Gm-Gg: ASbGncsHU0K08sARIocT7ZNEWKOB1Yjyku6Xu2XOocfqgkVofMO71AEIOO56IXsxfXe
 PzQwdrfgnQnIJ7F7fVSlBwNdNjJn9J1rkVhueqBaR4hIgslKM5bg3CqnJnMIpbvo8RmYWZhe/Ee
 gqSvkvcKlvyBq3Xa0SDxLxRuFKjJlh/29PNzN7CCjP/qOxyQFDddhaWZEDl4dW88yxXhKmSTK3I
 zyMTjSkknV1a3sIw5el7dmKgnMpvFTiWItDvHv9/SWt1+qGR8rw7un64WKmHDUTue2qfOJubPZp
 EnOB52zvHeSIRO8SUCjIlqAxmvdXApzvYy47AW6SPTQ=
X-Received: by 2002:a5d:5f85:0:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3a51d91e0f3mr4911789f8f.13.1749124590517; 
 Thu, 05 Jun 2025 04:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyngpZOGVZ4a2ooUfTQy35zm2zoeK6WGFdQHJLiVbhDts7XI5lB+8f6wtTBFDBg2JVshBf6A==
X-Received: by 2002:a5d:5f85:0:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3a51d91e0f3mr4911774f8f.13.1749124590127; 
 Thu, 05 Jun 2025 04:56:30 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a528ed512bsm1643742f8f.86.2025.06.05.04.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 04:56:29 -0700 (PDT)
Message-ID: <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
Date: Thu, 5 Jun 2025 13:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
> On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received
>> as shown below.
> 
> [...]
>>
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>   hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>>   include/hw/s390x/event-facility.h |  5 +++
>>   qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>>   3 files changed, 110 insertions(+)
>>
>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> index 935fa87acd..ec711e2291 100644
>> --- a/hw/s390x/sclpcpi.c
>> +++ b/hw/s390x/sclpcpi.c
>> @@ -15,7 +15,9 @@
>>     */
> 
> [...]
>>   
>> +static void cpi_init(Object *obj)
>> +{
>> +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> +
>> +    object_property_add_str(obj, "system_type", get_system_type, NULL);
>> +    object_property_add_str(obj, "system_name", get_system_name, NULL);
>> +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, NULL);
>> +    object_property_add_uint64_ptr(obj, "system_level", &(e->system_level),
>> +                                   OBJ_PROP_FLAG_READ);
>> +    object_property_add_uint64_ptr(obj, "timestamp", &(e->timestamp),
>> +                                   OBJ_PROP_FLAG_READ);
>> +}
> 
> I think it would be cleaner if those were class properties.
> You could use object_class_property_add_str in cpi_class_init,
> but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
> device_class_set_props.

For "normal" properties I'd say "yes" ... but in this case, this would also 
allow the user to set the properties from the host side - which would be a 
little bit weird? So I think it might be cleaner to keep it this way here 
without the "setter" functions? WDYT?

>> +{ 'struct': 'S390ControlProgramId', 'data': {
>> +     'system-type': 'str',
>> +     'system-name': 'str',
>> +     'system-level': 'uint64',
>> +     'sysplex-name': 'str',
>> +     'timestamp': 'uint64' } }
> 
> This is unused now, so you can get rid of it and put the
> documentation sclpcpi.c.

Agreed, that looks like it could be cleaned up now, indeed.

  Thomas



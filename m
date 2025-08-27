Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 22:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOCm-0006R6-T9; Wed, 27 Aug 2025 18:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urOCl-0006Qh-C7
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urOCi-0007cL-Ek
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756332074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9LbhoLffTINf3bGY0XMLc1aTrpoReWQ/vHYPvIA3gK0=;
 b=hdQLRuuYyNw1tMvwVcGLcfXWBJTimh+X8CNuSoe+LP6fLhH6AppUYT7jgLos4ddYcIhzBM
 JY/nBSjj5WpLT62GYOSnoUrjW3fT7FR0iGFfMctcFHL4xGPmhqBND04QBgLInf00MiXa2b
 y70AvpX/bsuq/r96PcHuM7bCYbwSSBs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-EsJL0UHeNBqxuzgK3VE1lw-1; Wed, 27 Aug 2025 18:01:12 -0400
X-MC-Unique: EsJL0UHeNBqxuzgK3VE1lw-1
X-Mimecast-MFC-AGG-ID: EsJL0UHeNBqxuzgK3VE1lw_1756332071
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afe81959e5cso23547166b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756332071; x=1756936871;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LbhoLffTINf3bGY0XMLc1aTrpoReWQ/vHYPvIA3gK0=;
 b=lelwnCCXmNe8pQBW4kXwBYgvsAIbkTgMUW1/4AbmYdrkot7in6laHvd95LQcITEMYS
 lfc6gii61t1bri3zUogD0UP7vw4vFsdGBJS84dMeaalw7Gz3kIjOEUBEXt0rm0vkVahE
 dK3Flv4N6KpO7i6P51kUsERZ6F5W5N/Ei/ctGYvsrHRqgIxKWzkgSjaOSZIq/Krn5BCf
 3dipfowEXdOZ1yUSAnY96Li/4ah1JxuRbgdISGbnIdPyIoxQtPwbG5VqVlYTOLSahAoy
 4YGg0PbiQU/8VLZkdtobsKobRZ/V+cJsFhjVGOCwhKR/33JsXX0lOqz1guObWGziKfKp
 ARbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+StQO6XOJzvXU4az+zf9Y7vobZZOjfBTYA2zcH3S3T1Kc0Uvw5GzM3upRGDcdSV5f1T15gywJp0Se@nongnu.org
X-Gm-Message-State: AOJu0Yz3aRsJhyzAT/lI7o5CztoeLIcZHesfBJ995ZnlnqRgeoeJSvb9
 SbPOj5lOVWDdIzIfM/39+0wQDECWY+NiD2YtIs1ExvssaLfFXUcujPoC3ZU5EFXHiMM/6x2wAYo
 4fNNlpHm4PeV26PmBMF4N6gcRg2h0WXz3Zh3Vk1XCIH9nKpOlHwrQiZ7k
X-Gm-Gg: ASbGncv8+oz/jaioVKt7TxC92K9EN6MF81TSC178Ez39i/8MQurKd3eRnifpqTS8b0R
 goKlcxsngg6JsrxC475hfiikcQtK2uzLA5EllmBtIDBg9IX7EOLTXigo29FoV/qJ8wAmGrJhBd6
 GV3ab1DN9JgMFgbCe3nsAI5RPwiOPTuw3js+B4ehEoJyihkcOKxz2D+L+13N2ZX8egoDZhKj8wv
 WXEl+krzqtN/8jhd4HKQs6wMC5qBGVmebEZ4pC1A9S1ISqbGf5M0MT/WsxcZLloNZ8xOaE0iqk2
 MsDPpmUnqCJtr8C2b+g1FxxRgvY0RSDwCukWs+EtF+zPaE1tXIzzjd/hRL6cr5j38miDqinQjee
 vtmrZ
X-Received: by 2002:a05:6402:274c:b0:61c:d7b6:6218 with SMTP id
 4fb4d7f45d1cf-61cd7b663edmr142529a12.13.1756332071187; 
 Wed, 27 Aug 2025 15:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsOSZra7uurPCCy7aAXX3rgY/oVsERtX4enePQESCM4nixPZK7+1ehCrFkVb6wTn4iLZnGLg==
X-Received: by 2002:a05:6402:274c:b0:61c:d7b6:6218 with SMTP id
 4fb4d7f45d1cf-61cd7b663edmr142237a12.13.1756332066019; 
 Wed, 27 Aug 2025 15:01:06 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-247.pools.arcor-ip.net.
 [47.64.113.247]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61c90ffd657sm4201272a12.44.2025.08.27.15.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 15:01:04 -0700 (PDT)
Message-ID: <ff5a3203-6afb-4202-b59a-1021f0d949db@redhat.com>
Date: Thu, 28 Aug 2025 00:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Farhan Ali <alifm@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-8-zycai@linux.ibm.com>
 <537aa1cf-7135-471e-874e-a4cd3796b5bc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <537aa1cf-7135-471e-874e-a4cd3796b5bc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/08/2025 23.49, Farhan Ali wrote:
> 
> On 8/18/2025 2:43 PM, Zhuoying Cai wrote:
>> DIAG 320 subcode 1 provides information needed to determine
>> the amount of storage to store one or more certificates from the
>> certificate store.
>>
>> Upon successful completion, this subcode returns information of the current
>> cert store, such as the number of certificates stored and allowed in the cert
>> store, amount of space may need to be allocate to store a certificate,
>> etc for verification-certificate blocks (VCBs).
>>
>> The subcode value is denoted by setting the left-most bit
>> of an 8-byte field.
>>
>> The verification-certificate-storage-size block (VCSSB) contains
>> the output data when the operation completes successfully. A VCSSB
>> length of 4 indicates that no certificate are available in the cert
>> store.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/specs/s390x-secure-ipl.rst | 10 ++++++
>>   include/hw/s390x/ipl/diag320.h  | 22 +++++++++++++
>>   target/s390x/diag.c             | 56 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure- 
>> ipl.rst
>> index 70e9a66fe0..ddc15f0322 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -23,3 +23,13 @@ Subcode 0 - query installed subcodes
>>       Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>>       subcodes block (ISB). This mask indicates which sucodes are currently
>>       installed and available for use.
>> +
>> +Subcode 1 - query verification certificate storage information
>> +    Provides the information required to determine the amount of memory 
>> needed to
>> +    store one or more verification-certificates (VCs) from the 
>> certificate store (CS).
>> +
>> +    Upon successful completion, this subcode returns various storage size 
>> values for
>> +    verification-certificate blocks (VCBs).
>> +
>> +    The output is returned in the verification-certificate-storage-size 
>> block (VCSSB).
>> +    A VCSSB length of 4 indicates that no certificates are available in 
>> the CS.
>> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
>> index aa04b699c6..6e4779c699 100644
>> --- a/include/hw/s390x/ipl/diag320.h
>> +++ b/include/hw/s390x/ipl/diag320.h
>> @@ -11,10 +11,32 @@
>>   #define S390X_DIAG320_H
>>   #define DIAG_320_SUBC_QUERY_ISM     0
>> +#define DIAG_320_SUBC_QUERY_VCSI    1
>>   #define DIAG_320_RC_OK              0x0001
>>   #define DIAG_320_RC_NOT_SUPPORTED   0x0102
>> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
>>   #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
>> +#define DIAG_320_ISM_QUERY_VCSI     0x40000000
>> +
>> +#define VCSSB_NO_VC     4
>> +#define VCSSB_MIN_LEN   128
>> +#define VCE_HEADER_LEN  128
>> +#define VCB_HEADER_LEN  64
>> +
>> +struct VCStorageSizeBlock {
>> +    uint32_t length;
>> +    uint8_t reserved0[3];
>> +    uint8_t version;
>> +    uint32_t reserved1[6];
>> +    uint16_t total_vc_ct;
>> +    uint16_t max_vc_ct;
>> +    uint32_t reserved3[11];
>> +    uint32_t max_single_vcb_len;
>> +    uint32_t total_vcb_len;
>> +    uint32_t reserved4[10];
>> +};
>> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> Should this be a packed structure? The Linux kernel defines it as packed 
> https://elixir.bootlin.com/linux/v6.17-rc3/source/arch/s390/kernel/ 
> cert_store.c#L81

Packed structs should be avoided in user space code that might get compiled 
on different host architectures, we've hit related problems a couple of 
times in the past already (doing a quick search, I came up with 
https://lists.gnu.org/archive/html/qemu-devel//2017-03/msg05316.html for 
example, but I remember we had similar problems in the s390x code once, too).

In this struct here, all fields are naturally aligned, so the packed should 
not be necessary. Just add a size check with QEMU_BUILD_BUG_ON to make sure 
that there is really no unexpected padding here.

  Thomas



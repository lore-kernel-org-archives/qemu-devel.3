Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47543C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKCNV-0005S2-Tm; Wed, 28 May 2025 04:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKCNU-0005RG-5U
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKCNS-0001id-FL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748421789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hl1HFd32CLC7e8l84tic3h+79Metv0nJ5kBpV11sF9g=;
 b=eCDzJeTRfhWQzj1i5pel339fRGIJbhK53let7DKgMSIKGWYZVp9U/YMdblIUMsdiQ80qU5
 h31H0LpuZgcac5L2+t7qEUyfz2LnVLYrQPDDOB+2vCS+q9O0c4M1Yqy8PVKSUx15Wq6zwt
 Rl2/au6ScghtqBdKc8wUS3o8AQEh6WQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-V_h9W0ySP9KA1KVThWpGcQ-1; Wed, 28 May 2025 04:43:07 -0400
X-MC-Unique: V_h9W0ySP9KA1KVThWpGcQ-1
X-Mimecast-MFC-AGG-ID: V_h9W0ySP9KA1KVThWpGcQ_1748421786
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56a52edc5so429566166b.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421786; x=1749026586;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hl1HFd32CLC7e8l84tic3h+79Metv0nJ5kBpV11sF9g=;
 b=eedBaUek2lXKiOiInBxLMPvEzFuqczPxwlUpDr8XEeCspE2cHV3A+h9yVzh/ocQrw5
 gIyl/rbDmmzm4ZPhNXT0J8WfWLC76uiCiy92O536YCJ1fW6bnfUxSX8lkIEnsPMIQzZq
 +rtzvl/9fA5saitZFTRu2YBsJGDLH/ffSJ8XQqxU28wuYRI0MHV33XCjFiMskv7exIfX
 OIQtbhhVJpfrfnJY9b2KR7K8h8FiQ5K0UJL4mnD5beGlqRsaj8R+brv8jeq1MEga6NyM
 GYurZHjktDwW0ra0yq+kb04i9fhKWt88aMn3Q4boQKCjcS+qJxru9EIkDwZ6iOITR128
 QqTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4FNV4aa88B11FF6P0RQiYKr8MJ3j94p0TkAOM30/fyXRB+JwHRM8Lkl3a/Tmfqnm0pgb7elp2pRuX@nongnu.org
X-Gm-Message-State: AOJu0YxTITfuIqyXkIMq7tFY5Qz2sWwNkYfJ2fz69lorn4UFj5XvwCux
 byIyIz4se3x2LttoExz7vUO75850V4mUI09RA+l+0Z9DQ1/Cf9UvZ6V87O0X3W0Ng3khjShwGhR
 pT1TWeWVlEwNF2IZwFqpd5lEu7TznJ3fEZ/jWE0FNRhCJGSATvduNaTs7
X-Gm-Gg: ASbGncvowyVYG1gJLCbinAwDDN8xRLg1/HDOwY3mDFiXhuzuXQtjHdECP2h1eeNDHeM
 RnDiGMehDT+KKORdiJcRZ4m/xTqjbK6m50E9amumMSPwLGtL+KZOeDr2Zc7NujYRBV+RHHAh4st
 ydbzrGEa7aHn0ikLWoUrOxApaWhG9jnGpU7Ypu1vQKV7at1hvfnzAQ4oL+IAKEvs5ZpBf2NcZ9q
 3RkqKEqOnGqn5bAQ2aNfpolZtFYCinbGhsMX6kV8gMSj3FKyUHcgBLtSNBEKcjaVCVJY01oTTDz
 a2gZGXqHEBc2PQ==
X-Received: by 2002:a17:907:8686:b0:ad5:55db:e413 with SMTP id
 a640c23a62f3a-ad85b1504d9mr1415672366b.26.1748421785642; 
 Wed, 28 May 2025 01:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH24+hZ/IroBd22m/wRvWoF9tOeZ83C/tb0GCbW2+MrfVSgcgvhDjgja+Ki9gqtlMC+kf/0Qg==
X-Received: by 2002:a17:907:8686:b0:ad5:55db:e413 with SMTP id
 a640c23a62f3a-ad85b1504d9mr1415670066b.26.1748421785234; 
 Wed, 28 May 2025 01:43:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad8a1b289a7sm70197066b.97.2025.05.28.01.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:43:04 -0700 (PDT)
Message-ID: <d61afa6b-3b6c-4eb3-ae24-0cbb1c9f0c85@redhat.com>
Date: Wed, 28 May 2025 10:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Clean up and enhance of feature_word_description()
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
 <df9bf984-2845-497c-b2c2-dcdc43752b9b@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <df9bf984-2845-497c-b2c2-dcdc43752b9b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/13/25 09:04, Xiaoyao Li wrote:
> On 12/17/2024 8:39 PM, Xiaoyao Li wrote:
>> This series grabs two patches related to feature_word_description() from
>> two different old threads, they are simple and straightforward.
>>
>> Patch 1 is grabbed from [1] while patch 2 is grabbed from [2].
> 
> Ping...

Applied, thanks---with a slightly fancier formatting for patch 2:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8589391023d..446924be90f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5780,12 +5780,15 @@ static char *feature_word_description(FeatureWordInfo *f)
          {
              const char *reg = get_register_name_32(f->cpuid.reg);
              assert(reg);
-            return g_strdup_printf("CPUID.%02XH_%02XH:%s",
-                                   f->cpuid.eax,
-                                   f->cpuid.needs_ecx ? f->cpuid.ecx : 0, reg);
+            if (!f->cpuid.needs_ecx) {
+                return g_strdup_printf("CPUID[eax=%02Xh].%s", f->cpuid.eax, reg);
+            } else {
+                return g_strdup_printf("CPUID[eax=%02Xh,ecx=%02Xh].%s",
+                                       f->cpuid.eax, f->cpuid.ecx : 0, reg);
+            }
          }
      case MSR_FEATURE_WORD:
-        return g_strdup_printf("MSR(%02XH)",
+        return g_strdup_printf("MSR(%02Xh)",
                                 f->msr.index);
      }
  

Paolo



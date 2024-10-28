Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DB0D13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 10:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5NFi-0007NP-83; Mon, 28 Oct 2024 06:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5NFg-0007N8-62
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5NFe-00012H-Da
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730112333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKRFmYIQnLKZ8FAaDCIjLoP6qErS46mFGviCaI72qn0=;
 b=iP7vTioN7Toam87uFqLrv42mm4PJdOdQQMF3nSW5IwRL+JdRh98HkznrOeR1VG3xKDXIdB
 yatlq3qXUAs0IGpzpbP6mDzdLG0s7z0IC5yAWuND7jZRJjvkcWHtGXtOke0WruPipT1jJj
 oEEh4X3UdfWDUDTYT78n92hb8MQnnkY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-TIL169ntOnqK2WoBUxpK4A-1; Mon, 28 Oct 2024 06:45:31 -0400
X-MC-Unique: TIL169ntOnqK2WoBUxpK4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so2239461f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 03:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730112330; x=1730717130;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKRFmYIQnLKZ8FAaDCIjLoP6qErS46mFGviCaI72qn0=;
 b=KxWcw88TGm090ErfJpT7MFC38c7O4mXrCbrGzolax6ylylxrqrT9VbgJAjWurso/u6
 zCEa1rad7yhv58Vz0L+EHOjLmlsLc4aX9fgb9cGy72QjLgisA+Rjjp/6lVLNAGO08mJn
 3s9sqv+WvKzLSFHSZbOaWJ+DRGtXFixd4YQHAlLVX5JT6EBxpfw+/f3h9vJfMf1jhkDU
 /yem7ja9F9kbkUE6WL/pqUhychdZQUzpwdHwz4Gwa1t73WXMwM4QZ6CCpjcqfRrwhvvR
 u5IdRIR5sexhOCEQCKGc0ErS3uc7ffdP4ZiRpP961Az2EG/8tbDOLjfyCHUu57iRcFQ+
 x8XA==
X-Gm-Message-State: AOJu0YwRqIOPoQ84EeW3CXHkv73aTEufrx8XCIJ1ijWIwGwDP/iCmqlv
 ytkgnM9X7NExGE2Ya9rIldpJ6iiLBc9dDMPVqLcQ7G1aF5wd8mBhlnuLYheT8KOedrbYaifhU0q
 EFHYAC4Rky865eu4k12Ssmw1OYMDk2Dvagq/YPUXDmU/v+iulD06M
X-Received: by 2002:a05:6000:d0b:b0:374:bd00:d1e with SMTP id
 ffacd0b85a97d-3803abc2879mr11304336f8f.3.1730112329725; 
 Mon, 28 Oct 2024 03:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYp7+CDrHUl0zuWA7fgX1MnIlkx956vlN0ASJua1LfHCM4HVJYNCL+HDhBFrHcvjeU7huV8g==
X-Received: by 2002:a05:6000:d0b:b0:374:bd00:d1e with SMTP id
 ffacd0b85a97d-3803abc2879mr11304309f8f.3.1730112329305; 
 Mon, 28 Oct 2024 03:45:29 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4318b5682c3sm134075885e9.29.2024.10.28.03.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 03:45:28 -0700 (PDT)
Message-ID: <340b5b33-8b77-43ab-b0dc-c6e9f610b4a2@redhat.com>
Date: Mon, 28 Oct 2024 11:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
 <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/24 11:02, Tao Su wrote:
> On Mon, Oct 28, 2024 at 09:45:39AM +0100, Paolo Bonzini wrote:
>> On 10/28/24 03:45, Tao Su wrote:
>>> Since the highest supported vector length for a processor implies that
>>> all lesser vector lengths are also supported, add the dependencies of
>>> the supported vector lengths. If all vector lengths aren't supported,
>>> clear AVX10 enable bit as well.
>>>
>>> Note that the order of AVX10 related dependencies should be kept as:
>>>           CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
>>>           CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
>>>           CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
>>
>> I think you need to add a set of dependencies so that avx10 cannot be set,
>> unless all the older AVX features that it's composed of are available.  From
>> the manual these are
>>
>> AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA,
>> AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
>> VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.
> 
> Thanks for such a quick review!!
> 
> AVX10.1 spec said:
> Intel AVX-512 will continue to be supported on P-core-only processors for
> the foreseeable future to support legacy applications. However, new vector
> ISA features will only be added to the Intel AVX10 ISA moving forward.
> While Intel AVX10/512 includes all Intel AVX-512 instructions, it
> important to note that applications compiled to Intel AVX-512 with vector
> length limited to 256 bits are not guaranteed to be compatible on an Intel
> AVX10/256 processor.
> 
> I.e. AVX10/256 processors will support old AVX-512 instructions
> (limited to 256 bits and enumerated by AVX10) but not set AVX-512 related
> CPUIDs. So, I think we can't add these dependencies…

Of course you're right about AVX10 in general, you still need to add the 
dependency but only for CPUID_24_0_EBX_AVX10_512.

Paolo



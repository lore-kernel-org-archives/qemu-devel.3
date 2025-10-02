Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D70ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4K9t-0004FF-VQ; Thu, 02 Oct 2025 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4K9c-0004Dv-Uw
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v4K9K-0002wp-Qx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759414748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fvKbTha8pu/Nl9r/kArgbU0ivUuJAL19/HW3mE3YBnk=;
 b=HeyBIrbjjpHVIgW1Ia3s7ErM476iehVzUD9SdvqLxZC6oNT+dpl6PROZb4igugFk8M7t17
 qCyJ+IO0aZaoV8fyNWAgjHyux6+YOCnJ37ZXuy9q2wpAP/yrWR07KUyup41hU5DKN6BiEm
 HVtOwE9f55jXWKCiu9aCS7wPm7QQYzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-ZUaFafbDN_WY-q6jpWmlIA-1; Thu, 02 Oct 2025 10:19:06 -0400
X-MC-Unique: ZUaFafbDN_WY-q6jpWmlIA-1
X-Mimecast-MFC-AGG-ID: ZUaFafbDN_WY-q6jpWmlIA_1759414745
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e407c600eso5774265e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759414745; x=1760019545;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvKbTha8pu/Nl9r/kArgbU0ivUuJAL19/HW3mE3YBnk=;
 b=Np3tWkQ6E+R6zyGuzlEjz2G0Mo7OtMWSN+ilFMO4MhBDk7J+y4nxCGhDvvj5KO1wHw
 ZX1smWhyqDHtPGhQHB/FpPADMg1ummhg3Ctz2zwKrbjUlRTu4UseezknZL8fqsfgNNFW
 jPCNV1vxuyehc29AwhEj3Jr+vKJZeebtnwnhuF1ky6GzWXNeczUaRtM8uaLugEG0SkXi
 IWnz77OG8DeIRQxoORduoj4f1xmDKHEIJ8x1tB9hbjrvcU8VGL53vZHLBhFRjO40EK4t
 gm/bg+tr5rI8927wH/AcYkkQIhvR8FP5vpT8h5OeDi0UXELmq1DwCtpSg+GX6mTa5JMz
 3XAg==
X-Gm-Message-State: AOJu0Yx58afJKrVQe6La7CMwkS4gBUWojYfflooXfayb5vSiGU1V/Tkh
 lNTsdaKt8PtcuLwQNMe6/aV/man26wMbsaGJWn5GHhFCgdvdhsUMwr1BEIwfNTrU2abgBsYhzvs
 Y1MsPxlrdA7hez1iZt/Wjg42y8r+yxUSQWAm3vojAuZrKbpK+uyplgb5F
X-Gm-Gg: ASbGncsxf7AUXLQMcDxWI2+NQbUqC546D9R+AkB09Nj4d9dy6lOpxtZsE1UGNKBtv/q
 9qIWv52PaiKPvYFzYSIdH91C3XGdHdm+YzTW5k9es58zMI0gSJwbWsMV7XGUQtcPU92P3WIujGS
 sTtow7IqsM1X1jEAk/lgGRotQ9D5qoDzGryWBFLf47q48zCW+cs05LsqQcPqheaW6OMJXZ0Eanl
 9wqkE+b72xnocZ9ihuxKuLZhZS9FC+Du1EMYLBFQl9k/JS3eiuhxkhaMKMC1Pz11JLO+JEi9QX8
 8EVwzYsgX1wAOA5U/X/SQAkC0KujUc+i8z5Q/yVEvlqWUlUFJh4MKGBhtkkV6Uf9ETQifiGTuUK
 Qm+zb8MGJ
X-Received: by 2002:a05:600c:3b10:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46e613dbfdamr65313375e9.36.1759414744752; 
 Thu, 02 Oct 2025 07:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg2psYku8CpteOhUSt71EUftbjddUmpZNk3BAtX2bsF+wAODwUJAq9EcaxKoUYCNmbizVT/Q==
X-Received: by 2002:a05:600c:3b10:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46e613dbfdamr65313145e9.36.1759414744339; 
 Thu, 02 Oct 2025 07:19:04 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com.
 [80.187.80.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bd8bfsm37073315e9.11.2025.10.02.07.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 07:19:03 -0700 (PDT)
Message-ID: <aa461a43-0db8-482a-aabc-897cfa619dee@redhat.com>
Date: Thu, 2 Oct 2025 16:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
To: Igor Mammedov <imammedo@redhat.com>, fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
 <20251002161140.5b908e06@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002161140.5b908e06@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 02.10.25 16:11, Igor Mammedov wrote:
> On Wed, 24 Sep 2025 18:33:23 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> Hi David,
>>
>> I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.
>>
>> Previous Discussion Summary
>> ===========================
>> Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:
>>
>> Original Approach (December 2024)
>> ----------------------------------
>> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
>> - QEMU cmdline example:
>>    -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
>>    -numa node,nodeid=1,memdev=m1
>>
>> Your Concerns and Suggestions
>> -----------------------------
>> You correctly identified some issues with the original approach:
>> - Configuration Safety: Users could create problematic configurations like:
>>     -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on
>>
>> - Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
>>     -numa node,nodeid=1,memdev=m1,spm=on
> 
> that seems to me a bit backwards,
> aka it's just a particular case where node would have SPM memory only,
> which (spm) is not a property of numa node, but rather of memory device attached to it.

The problem is that boot memory is not modeled as a memory device.

-- 
Cheers

David / dhildenb



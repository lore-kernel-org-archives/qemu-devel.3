Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC797E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 04:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR1w5-0004QR-O7; Thu, 26 Dec 2024 23:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tR1w3-0004Q2-Ct
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 23:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tR1w0-0004LE-95
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 23:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735273604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UtTYhCVk1CPevsuX7TBPpppeXye06GXhJdw7MJ4vW/Y=;
 b=dpgQGnNpTBcTfZD1jiQ69sHMMDlWLEQX0NH0o9gK2wb07tzYDfcxsnj+mkGznVcvV4VNjw
 4Ork7vfCkxX1MjMdI/kVzfq8MBReCDZpYwy9RfLzYiTZK6wQgwOxzyeR17mycCiBT13UMP
 0dDKYYFBljwxjUa3OwwheiU2hNnF9qs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-iw4pqagMMiixc-JwSF8b-w-1; Thu, 26 Dec 2024 23:26:40 -0500
X-MC-Unique: iw4pqagMMiixc-JwSF8b-w-1
X-Mimecast-MFC-AGG-ID: iw4pqagMMiixc-JwSF8b-w
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so39741645e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 20:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735273599; x=1735878399;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtTYhCVk1CPevsuX7TBPpppeXye06GXhJdw7MJ4vW/Y=;
 b=bNWTGn2CPtjPyEi3XEKxi+2ogExPmOxviDxJrf3rToP1r362FPdLp/Wck4qqz1tb14
 n4KuGgPyI/9sf2Vcy45uHwtPdfLROXFBj+P9xtBVCZW9e3uSjUXw0ZdwC+tbMT8XPXxD
 pLF5H7RpyfqWgXzSIaBuSsVuSPDnhgrv7FyQlgtGteDGMEoL6Z6iAHNGySN1znZ/OR3l
 hrI3IB1TNqmjRz53JhLbAmT/jkRLc6IwUl5FokJUgTddXfW0D3wcBNIFvmoAh/GjC1Y9
 Hbay5r3ujohfp8uVLlZDZuRbgBvevWTWgNbZGtw0sqvSMluYC10L79ir6Hfaf+tiktxR
 YEMQ==
X-Gm-Message-State: AOJu0Yx7ZDXzXbGOx2w1cNaFICrIEB8NARbaddd6AInWd+ufxzq8UuCs
 AvBj3Q69wbhFtXIG0SZibw6C60/YYhXh3CUzd0uWRoSfC/5ZVBi41qGco039A3yF/J6B0YpQQD0
 uA4I2oMRLhoAvMaFMSQzwwkSoVwWeLlHWvn/gVJWyub2yU48eaDLi
X-Gm-Gg: ASbGncui91yiEdZm1OpfUJd9cdckmrhG48Gf6x9NCXC4OMN9JlqSCHLCu8MYXWcttS5
 vwnSEfnHrpgwFA4pAjme8WVQa9sLIli5UKfNGb+YW/K+Fi5l7OFzleUzRjcmTDZTn+72UzzgQm/
 kbcgiLElNLYyDEYmmbE90+aumu5SJIMU6xMkjI3o6BLkY4Ngnc/ulq0Zu45z09YfFwYOiYzZLvw
 i+FJmLuClH6zgdyGkmV/hLrFRUOVhLAzSq4hOJ5MyU1UpM00a9MDQnIj6Zr
X-Received: by 2002:a05:600c:1d07:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-43668548780mr210869325e9.5.1735273599651; 
 Thu, 26 Dec 2024 20:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg0AiZMrZ67MV7XFGpMyr65ZrE974+WrSpAXQsySwS84z1Uuz3cIj/OhbcKy1b+3t9w7OzpQ==
X-Received: by 2002:a05:600c:1d07:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-43668548780mr210869245e9.5.1735273599324; 
 Thu, 26 Dec 2024 20:26:39 -0800 (PST)
Received: from [192.168.10.47] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d32sm21265280f8f.99.2024.12.26.20.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 20:26:38 -0800 (PST)
Message-ID: <0dcebe82-8484-4fd3-8951-2e7bfef8063f@redhat.com>
Date: Fri, 27 Dec 2024 05:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] rust: add a utility module for compile-time type
 checks
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-3-pbonzini@redhat.com> <Z2wxoWmmalIPqysd@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z2wxoWmmalIPqysd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/25/24 17:24, Zhao Liu wrote:
> On Fri, Dec 20, 2024 at 03:29:44PM +0100, Paolo Bonzini wrote:
>> Date: Fri, 20 Dec 2024 15:29:44 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 02/12] rust: add a utility module for compile-time type
>>   checks
>> X-Mailer: git-send-email 2.47.1
>>
>> It is relatively common in the low-level qemu_api code to assert that
>> a field of a struct has a specific type; for example, it can be used
>> to ensure that the fields match what the qemu_api and C code expects
>> for safety.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/qemu-api/meson.build       |  1 +
>>   rust/qemu-api/src/assertions.rs | 90 +++++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/lib.rs        |  1 +
>>   3 files changed, 92 insertions(+)
>>   create mode 100644 rust/qemu-api/src/assertions.rs
>>
> 
> Very useful! Previously I found qdev property macro lacks such type
> check, but I falied to think of a good way to implement type_check in
> Rust, and glad to see the correct approach! Besides qdev property, I
> think vmstate also needs this.

Right, though for vmstate (and probably qdev properties too) it's 
probably better to go from types to C structs 
(PropertyInfo/VMStateField) and avoid having to do the assertions.

> And I think we can make the examples as the unit tests.

Having doctests support in "make check" is on my list; I have started 
contributing a rust.doctest() function to Meson for that purpose.  For 
now they are limited to what can be run through Cargo (i.e. you cannot 
use libqemuutil.a functions) but we'll see if the function is accepted.

Paolo

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
> 



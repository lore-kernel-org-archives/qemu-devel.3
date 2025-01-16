Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFCEC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLD4-00061h-5a; Thu, 16 Jan 2025 03:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYLD2-00061L-Pb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYLD1-0003kR-9e
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737015994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RiX3ieGT8Z6aY6qDtujUEblaT7wAJ87wJzymzblJqko=;
 b=eIKxcOus+9AwMXYVdzSqy7WR1p4drpc0D0s4jpEdyo1f+Ya8zLl8NnvMivh/4mH2s9j8WV
 PtRn33yEmih4j9Nh6sQjbXj3nzlrN5GeZ1NWFM+5+N7tBcCcSHm2yP90kDuum/LMg8LlUW
 KBR+OoTXTDADwzzKiCpsfxy2KsqAfVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-NYjM0YmGPnSzVGOTHR_nWQ-1; Thu, 16 Jan 2025 03:26:31 -0500
X-MC-Unique: NYjM0YmGPnSzVGOTHR_nWQ-1
X-Mimecast-MFC-AGG-ID: NYjM0YmGPnSzVGOTHR_nWQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so384052f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737015990; x=1737620790;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RiX3ieGT8Z6aY6qDtujUEblaT7wAJ87wJzymzblJqko=;
 b=hXGuAC50lzGy00XXHzefPeW+f4FpO0hkTGfqmTXBboBcVU+am777Mh6XlhcpvQPQ6D
 lofxXtXY1FA3RixLEZBs2QLZCG/tpP3IXIzcATzOVzVS+HmN4rBszoSKUZm46OTBmLp5
 Q3DeeQYx1VpGM2DyleCg+Cdmb8KJqjPWFGmmlAC+HnpskXgghG5i/lxuN0/5v8kFBJyb
 vtVbd6MUMPyydhSzNemHR/jjVQ5KyTxYYAZFwL0RIGTURxQ0MaexkstiwYdyVAV/8igV
 7TdFPuxavYygVQPTNQUdDDfVGePR7bI73Fi3TJ9wiBaBbNZyztyqP/YpDzqTlxfikx0w
 /x2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK/YafCzQrm0rlO+obpxz0cJLH6bmWjC+qMxTthENQOv/O7+5vMBfFQRjC4cOtKG+mXf3x/uCRoYuf@nongnu.org
X-Gm-Message-State: AOJu0YyBYNRz7qXYEjPG/1HCiL3YVtJ6UMBLRVDi2Tkl3GvcHbjpESFd
 a6l6Q9vwOO9RzeIgykEdVOBYI6vOYeuQ0xldpND2AMEfFHMNjH/ahkZ7GWreBWcVgpvE3tdLp4R
 eX2vNrN9wgc7Ql6cozctwtlT+4aOjOzM8908JgLvS1zQxiwoxvfKV
X-Gm-Gg: ASbGncs3Cj9aBOAJdkiLM7Qawft8xKjVsx/qJebkXJHWV5Lpkt1hFp1lmVuaxvXxsAR
 W5f9bS8dDpK/TPvHsppSZT4BcmJc/GEtKNtGb3nNZ9mWRs9f/N13SxvXgzgEZWRcZlzHrzZHYxO
 AP+v1BPRsW6Ls2VKqH3FazamB+m9gTrUA0fvdNq4xa0xCG0mfPpyc8DXzd/I4Qw3akzMFUJmR4F
 AJPbMBJAGIKV+LDM5d2zfpMA0Q0qhhmeZP9ZAxfJSLdGbV3McTldfIpo0biFymg7e3/x9Vk1cqU
 dWehDe/1fSub
X-Received: by 2002:a5d:598d:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a8733a3ecmr27179589f8f.55.1737015990040; 
 Thu, 16 Jan 2025 00:26:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBedwFrwtjq+vOwQ6Wj6RmFRb2TdJgutb6FUODXNuZefgabGscB0tJiQGHyUiv5zY520oKDQ==
X-Received: by 2002:a5d:598d:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a8733a3ecmr27179561f8f.55.1737015989651; 
 Thu, 16 Jan 2025 00:26:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c617sm50810795e9.37.2025.01.16.00.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 00:26:28 -0800 (PST)
Message-ID: <dfb1aba5-f95b-4fc1-9326-aa9df992870e@redhat.com>
Date: Thu, 16 Jan 2025 09:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] hw/arm/virt: Remove
 VirtMachineClass::no_highmem_ecam field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20250115171009.19302-1-philmd@linaro.org>
 <20250115171009.19302-14-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115171009.19302-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On 15/01/2025 18.10, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::no_highmem_ecam field was only
> used by virt-2.12 machine, which got removed. Remove it
> and simplify virt_instance_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/virt.h | 1 -
>   hw/arm/virt.c         | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



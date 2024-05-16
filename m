Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7a8U-0007fu-TI; Thu, 16 May 2024 08:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7a8T-0007ff-R0
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:23:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7a8S-00025i-3n
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:23:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34eb52bfca3so6820007f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715862178; x=1716466978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDuZ0uVjDc/k6leixpe5JAr0zDWmEA+dpL7b+9AzsxY=;
 b=XTC1n1eMWxBE3TITQi02xw5ShbsXU4AjbAwxVzb8cgFeprmVRQhdoOf7FBZp57YDSw
 qL9oBETmm6/YovWEZDiQGM/aSCU7UWRf/xxCngROQmhakIz71aFwscy7IJAvu5ykKRHA
 BS798/z4DInMZei/jJsM5jM8orMATEY+dbg1gIXS/1vamM+wHoXcNSvD/ZkEC5F2ZX0C
 dYaIJ340I+jMVpHzyNpoe5MgY4WnK4PcoH1dQkWp5uhkcI+9RLCFievccwJ59v2cEmHs
 A8QCdYU0S+HDPH6KJ3je7vht/2zya6jv9JezcY7tYGvjlizJr1TKT4oSnxR+juHk6d/w
 Uo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715862178; x=1716466978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDuZ0uVjDc/k6leixpe5JAr0zDWmEA+dpL7b+9AzsxY=;
 b=GnFuhoJ2Za/Q67V5vTmc7lphit06ZIGALZYbNbpwuOwKwqDXdyBQaqbekNB8P8PfBM
 U4zrvMFNzCv00fTCKj5tk2BkpaeG1M2QtKRDBOsRLz33yw+GA8NVCMIpgUeK5QTPwIAr
 WO8HPlXi/LD3Db3oUfpoz3RYG85NSlNb78+Sq4077biGNV3JPQmAaYbctc8Zt/V9/zYd
 CFWsGGgKERXXDsLnKKy5GCLmMYPdd92PhVelcrgm9xZU35DvvWN+WjJsf059Ar88VbLA
 x4eJX7xVQ49l5Zw9DhTJzAjNOtnNagme2uCl/VnosdHvkgVJu6qW0XJdODjk9l1yOfkt
 YMHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5nmEfbU4SVEqtbX8NCdcwTm+41GKtRJYks792d26B0wkUUqZqmOe0OaKAoHRAU7QH8UE2pmiqkCCrnR0QwCMp5T7d+rc=
X-Gm-Message-State: AOJu0Yy0usAd95occfTNSS/d1AioW1/IJo1GNCB1ZZyQcXvV3J4IA5Tf
 lcVoS3mvl9EJj6AVfs9pRRUt6Ss8Q/npi/rgySAHMUPMCNmAlPSxx+/LMwkAhb8=
X-Google-Smtp-Source: AGHT+IEWP3a8bwmAXIdrvKlmXTKwdlVYjPS3IEqCSoZFjxn2QQBxA1YLmMLjCs/iX3epRH80l1aQRQ==
X-Received: by 2002:adf:f5ce:0:b0:34a:d130:611b with SMTP id
 ffacd0b85a97d-3504a737804mr19026789f8f.17.1715862177923; 
 Thu, 16 May 2024 05:22:57 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b895887sm18870888f8f.40.2024.05.16.05.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 05:22:57 -0700 (PDT)
Message-ID: <e39e0aa4-ede1-4968-869b-521e14b263e0@linaro.org>
Date: Thu, 16 May 2024 14:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] gdbstub: Add support for MTE in user mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/15/24 19:31, Gustavo Romero wrote:
> +    /* Remove any non-addressing bits. */
> +    clean_addr = useronly_clean_ptr(addr);
> +
> +    /*
> +     * Get pointer to all tags in the page where the address is. Note that tags
> +     * are packed, so there are 2 tags packed in one byte.
> +     */
> +    tags = page_get_target_data(clean_addr);
> +
> +    /*
> +     * Tags are per granule (16 bytes). 2 tags (4 bits each) are kept in a
> +     * single byte for compactness, so first a page tag index for 2 packed
> +     * granule tags (1 byte) is found, and then an index for a single granule
> +     * tag (nibble) is found, and finally the address tag is obtained.
> +     */
> +    granules_index = extract32(clean_addr, LOG2_TAG_GRANULE + 1,
> +                               TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
> +    granule_index = extract32(clean_addr, LOG2_TAG_GRANULE, 1);
> +
> +    addr_tag = *(tags + granules_index);
> +    /* Extract tag from the right nibble. */
> +    if (granule_index == 0) {
> +        addr_tag &= 0xF;
> +    } else {
> +        addr_tag >>= 4;
> +    }
> +

I think I would prefer the body of all three of these gdb commands to be split out into 
separate functions.  I think they should use use allocation_tag_mem_probe, load_tag1, 
store_tag1 from mte_helper.c.  I am undecided as to whether the gdb helpers should be 
placed in mte_helper.c, or if the existing mte_helper.c functions should be exported.


r~


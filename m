Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38CD6EBFC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGyFc-00055j-CA; Fri, 29 Nov 2024 05:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGyFb-00055a-70
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:29:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGyFZ-00084u-HP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:29:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3823eaad37aso1770951f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732876164; x=1733480964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uxSZoNksZ1buJ0GjhahKKfGNoA3exZAc2twnFIzXyxY=;
 b=zsRCEeN78iZE/zZpPIg4RSyj4KwQMs3PbwPJtf6ru4E7YaMORdlv7pD5xjCgIAaueB
 rx4fu3LTnUJQMhQo0qT7MhTJIvWk3U7WmSkE2JDJEjhxTcAxdL6JTXE+HqYzafNB8yAW
 shFzYlNjpJ4zLi8S6jAsc7DB24Jbwi2aJut3klOHpfr7pgT3eMV51puCQWEpUCpMIFvk
 UtE4oq+bEtooDwXyNpp+XnGWamGea2zPfvzd/3TRD77dkLRoSQodFedEFha3oc3iOQyd
 uFD51jO3wJqhofm++IH6wLK24cKVkInVC+/6V9oAsUGyt1tNbbIK7qnHoU8eyFE15nRZ
 d9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732876164; x=1733480964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxSZoNksZ1buJ0GjhahKKfGNoA3exZAc2twnFIzXyxY=;
 b=EGxfYEq4ZWDC0sDU2VtNdylQUyJVL7EI2lRmtTVwl4xx3+WKzON31CfcYcoO+fsLZL
 KNwLI8NE0+fwCL2AcFUIVsKI9RC+99JYtkFRoNOp5sufUVTdPSS7+jUUfqU7KaTwmbjy
 fHqcsKdX9yE74aCSdk8CnAXuKh5llEgiipZnGieYfkzTLbIdMQhwNiCPAUtzuXjpz+9w
 sQEHE5g6T8Ws9Z8T3XqDHchf0ZVgxGh4or5110bPV5EZy2BKEmfxtwzGmgbmvYjkVlZk
 dqctagPxIk5k11FgYRNpiPQTqrcEFMUEC8+FZr6Du1z0DQ8WvyX7mL9DGlYeIMXeOZHr
 BFeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWoA94K7PGezlGRYs9/gblSvIdJ2SehMFo9GrJ8hxJKNpsHJM8LEIcmRmEX/MNkTsfCt0nkTlZzD53@nongnu.org
X-Gm-Message-State: AOJu0Yx6kYlKiC8wPxK7q9Cu+kGnJEq3AxvdHix2rISByKhgDPJocRpr
 EVPZpC67TMI2i6WCDhgaifMkqHK+VtYMB2Ls3wk8VP0+5CyfirZHgVWrXNcVHYo=
X-Gm-Gg: ASbGncubwjjfTmjjsAOHGBY4PIdCzB1hSYxpcUg+Zzp96UJlLw6LK2M4ZC+is1A1gpk
 P8AUaZLEeRnnsjxnWoK3UWq6TMB4iXje+RLdfWCRddRBVNX44BHRCSPA7d2OcdyZNJ8uB4zNTuV
 8dRqNDOnYDM4DfT6fbUu3ksMUiqY9/DZbR+GtWMEXVWFKyC9jfjfCA3QXixnpORUZbAt/KASyQl
 oR7DLvLtksdL4zvxJ8t7rmkVWaAbI3ObUi/QmbfAUWAIt7sHYv+FESi3/0uSNnPgw08eZ1D1eN0
 lomGtNF8fSjM5VEIhwr2
X-Google-Smtp-Source: AGHT+IGHFfy7c6zN2tI3E9rDTquTyNQ/00UEtLQLmF9KvfjElSIIcUed4RWyKkDbq7mwq89ecm7oYw==
X-Received: by 2002:a5d:584b:0:b0:382:134d:164 with SMTP id
 ffacd0b85a97d-385cbd80a3cmr4664729f8f.19.1732876163751; 
 Fri, 29 Nov 2024 02:29:23 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a580sm4047945f8f.53.2024.11.29.02.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 02:29:23 -0800 (PST)
Message-ID: <11a21260-cf71-495e-94bf-461fc0f39686@linaro.org>
Date: Fri, 29 Nov 2024 11:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
 Santosh Shukla <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20241114114509.15350-1-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114114509.15350-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 14/11/24 12:45, Sairaj Kodilkar wrote:
> Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
> linking error for the `kvm_enable_x2apic` when kvm is disabled
> and Clang is used for compilation.
> 
> This issue comes up because Clang does not remove the function callsite
> (kvm_enable_x2apic in this case) during optimization when if condition
> have variable. Intel IOMMU driver solves this issue by creating separate
> if condition for checking variables, which causes call site being
> optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
> Implement same solution for the AMD driver.
> 
> Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/i386/amd_iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F4C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGwl-0004lW-5V; Wed, 12 Feb 2025 12:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGwj-0004l8-Cy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:54:49 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGwf-0008OW-49
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:54:48 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fa40c0bab2so111251a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739382883; x=1739987683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AbdF5zuG9r5XmocxYEzcYTd19Er0LTyxud5WTm0OHo=;
 b=lpY56Hqucso8VeqfUEoVB26ae+eIpw/zY59ia4/hABYEcv+XZDCrmxV6D7O6srysFc
 pSZUDq4OcUj5eworIbj4r21hjOKhmDQ4uqQXdrSD2t1vq3hTqi7bcAyaNvYTS3l+Fc8B
 3R90DL/5z24icjqhDRDKBjPcFdqswhM3EbMEkkG1sgaEzMFvIVGc5LeqI1soYQSiQwvn
 fFmZs5sr51BkV0rifDlV+v5c74TNlFIR5RzbjCbsOwvI1PbVs/zx8XPfGm0l/eGDonVQ
 YZZwLszft2ruqAterA35OCzGkeVRau8RLOWtQCxLI48RhUuyrHNgJs+WR2fY6PhojCA3
 OVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382883; x=1739987683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AbdF5zuG9r5XmocxYEzcYTd19Er0LTyxud5WTm0OHo=;
 b=EWxayJ5IjF5QG8RucoggvAYS+F3oPSWhkwwHZHcV02dr4JVqHmUV1mrw/RfJxbOPro
 M1nj//6TWrdGGdjq8lLVf9cKlDb80rcrKcuRGzIgU9azXzM2ymppTsZ83Y6qUV1Nnfc1
 INo0vdM0QboDeh7AFszND8Z271XpF1oQBT9GDKij+WRFOFKpRqQ77Etv1gEWb50NVMPz
 IpG0E7whS/+Z+ZUiOYmyewC8x9SO+KsblE6RdqsDbZ0a01jckkNMy7jfiPsomsU5sHOi
 rHsRtdyrBc55qv/OXuE1JxveoEPQQAZLi2l01nCx2fqiE7Gs2nfUvziHFCs5S1un41uk
 1/tg==
X-Gm-Message-State: AOJu0YyyVQkppSsQLbiCK43D6RPm2G6p6bFUgqvk85AvgrtvVRaXSbNO
 nBurysv5V+17YKIf9pEl2QfiakmtJw5Uq4i/8l4PvgKkdzlUY6kVf5edfM+39KbBFcIskUuAJQa
 X
X-Gm-Gg: ASbGncuRDT8trGDwbG8jVSt7Afl0hS7EQ/N4AKXj/8U4VXn+0dIfIdg5iZSSV9D6UU4
 363kGvejbQW/icOSNDCJ9B9XPiZLNh+ynZym8gE1i28hXIKAy2FGNng2f9ZxhRpr/oazpquDxf1
 gJajNxIXZ71I4VPAUw4B3bouaILuHZ0gBxQUvqWUg3u9J3YFfT3MNUGjUhE0+OWx4mKqh1IBFGf
 d8Cyp344p73Cm5xEawCwQedt2NPcPqVFWiHkjsY5cWHFgQj9UUvyaoYAnzlw42cFjmqr+HWqhh8
 xNMKSaCGSPwuinQbkZq+f+KdqqFQ/IyDhtp88ehaywVk4BYS29eDYUQ=
X-Google-Smtp-Source: AGHT+IGcPZwSjnHCb/xDuFGWBebfV5ag3i2PgKPB8ExQ8p/Ck50rql3ucNKFvjt1NbxuRl7Akz8xiA==
X-Received: by 2002:a17:90b:4f8b:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-2fbf5be7433mr6692374a91.9.1739382883498; 
 Wed, 12 Feb 2025 09:54:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b7be7sm1807992a91.18.2025.02.12.09.54.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:54:43 -0800 (PST)
Message-ID: <ca0ef69a-9010-4fda-bcd5-a88442cccd97@linaro.org>
Date: Wed, 12 Feb 2025 09:54:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/i386: Mark WHPX APIC region as little-endian
To: qemu-devel@nongnu.org
References: <20250212113938.38692-1-philmd@linaro.org>
 <20250212113938.38692-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212113938.38692-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/12/25 03:39, Philippe Mathieu-Daudé wrote:
> This device is only used by the x86 targets, which are only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
> using DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-apic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


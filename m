Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26993C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhDw-0007Lp-Al; Fri, 21 Jun 2024 12:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhDj-0007FP-Ed
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:34:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKhDh-0006GJ-V1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:34:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f480624d10so18157595ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718987676; x=1719592476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=onRSqIiHbzmlenVVJ7TGSGAIeXgz+PKaQXs717txMhk=;
 b=qWjn2F+1SPPuTF5JEOa6GJXSQY6Cpkbev9AXnkWmav65mzInAL7CFTmZgTxtqYHyQk
 oQqnkkK8Mi+wvbexLmcl8BEPHVWlMv4iR2mgI7ntyJ3hN5N5ZY9gKSzN4FEwQW+1fnw+
 wEPOsWO7ENK0sG1aW1vAyJXZFqnph475xBk8l1noX71NUiyi0D8sTtDLFsy/AmNehoQH
 iugkaqmchVvyIZlt/yWcK/bhe6KxKGb1+Y1TpVOkei/nKl8Ipgb5L3Yaq/etJPWTN4vu
 ORhXzPDqD61Zdf3JEg7d+/V/i8Of//7WvfdkQBrPoogmjIMivhqGcjzygbfyW1RJjmhR
 jZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718987676; x=1719592476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=onRSqIiHbzmlenVVJ7TGSGAIeXgz+PKaQXs717txMhk=;
 b=wTKwdIIerOCk955vOh8AwQzJiOB57Eq1b7XvBOQT3dmsxCet3Wb3N5B4HGnBsL7UEc
 vu4iDoVHxmMXbaQaQ1F6TT/Td/fHD56O8FTcE74V7PmX7nel0C5XjmtqTZLaY6r18w/s
 gFJjmpX39F+JXw/x2WbgayiFT4KDsDB4yOxS+KMSYUJcE/SB4WaSQbObzmwe5B9Ognpq
 oLbq7h3AHIR1hRmw5qXVxy37L/qSwWGzMO4t5k785RIgi+96I6mz044iIpnDUhLtwoib
 Es4pIl0+55QSYV2pDOA6XkppkzfiVzsNVUAsjyIsWhNOGzOAgnvLUJyBU342Hykf4kZd
 aD4w==
X-Gm-Message-State: AOJu0Yxgi9NSIaGqFcSn31KxUj341zwf/Vxna7Qls0hGq8XPXZR90IoB
 c2VVJkaW4/DDBA3sHK1gfVvq5zP1uC11+5i2L7e+OozK8rn5sf67q/u160Uy+Lc=
X-Google-Smtp-Source: AGHT+IFqbU3aDcyh/wUvfXzBgX3XGNgDBBK5jsSIkZxhmVVlJx+1LQ6ejCD7YjmCLdwW6u59+xYKLw==
X-Received: by 2002:a17:903:41cd:b0:1f6:62cd:2c8e with SMTP id
 d9443c01a7336-1f9aa46c694mr103834965ad.58.1718987676275; 
 Fri, 21 Jun 2024 09:34:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb323636sm16012335ad.102.2024.06.21.09.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 09:34:35 -0700 (PDT)
Message-ID: <b41472ca-5627-4f3a-ba35-cc3cded553db@linaro.org>
Date: Fri, 21 Jun 2024 09:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240621114604.868415-1-rathc@linux.ibm.com>
 <20240621114604.868415-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240621114604.868415-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/21/24 04:46, Chinmay Rath wrote:
> +    tcg_gen_qemu_ld_i128(avr, EA, ctx->mem_idx, DEF_MEMOP(MO_128));
> +    set_avr_full(a->rt, avr);

This needs to specify atomicity as well.  This is much more important to for 16 byte 
operations than smaller accesses, as this might require stop-the-world semantics depending 
on the host.

According to section 1.4 Storage Atomicity, we need no more than 8-byte atomicity for 
these vector operations, and then the following the alignment bits down.

So: MO_128 | MO_ATOM_IFALIGN_PAIR,


r~


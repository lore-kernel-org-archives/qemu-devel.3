Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8A7C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XZi-0007R0-0l; Wed, 23 Apr 2025 06:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XZe-0007Ph-MS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:43:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XZb-0006el-5O
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:43:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso529488f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745405000; x=1746009800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZgI6UcFb0k3jLe5z+on11BhUkputrzrG+KMa34nBv0E=;
 b=ui3UQg5dxCJT657QZm1kK2Jbf0C+GKXwBWQRXqAiT9YuRwoWU16QflMZSAiYtghnD4
 5RYwwNv55XjLlQkVvkcp3F79X1elMxL/CufHfoh7NIJY5hv0saSwxtV5HMnARnFEfqMM
 KZZ+6RKzPBUIW+7Oud7Y8en1LBFzENksDZ3C1ckwxlzUZJClR8bqrB0OoTW9hP6W4H83
 8jt0CdlJ9Z2AfNgK4P0n39QXF7XLQxQuwifs12iRDMs6PmitIiW/bRR//OpSU8+EHl5k
 pmuL3owRCwcjJ71GXKafnS8QqVNnEnwxKxuuRD7DV0Uce2DWqwMpMJz5/djjReP9bH/o
 01jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745405000; x=1746009800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgI6UcFb0k3jLe5z+on11BhUkputrzrG+KMa34nBv0E=;
 b=ejlek6BckGSBNHG/zDyQG3Yy0vDPkM0BwiRan4lrLFAeuD2BUDkeP87ThNxxnPsoqK
 hQJF3DmmPzPUDroTBE38uZxCkc+jooTQ6Ir093uU+NhhYS8F6zCES0HFZXpjDFI7NH0g
 eHwXWVDm4dmFqTzP2yIh10gHtSTZ46QMN9utEbo9QNNzzA69F+h6hdPH0WGsfoDB2OVf
 XEmFn8sCJFcc37nxFhgAwJ4mQ4qXpgiZbFA5XQrvacgPZiiJG1ZIz+BQA6oOhqrJ2Q2o
 KfnZohhxbTxFUZOAESujFSCqwnt0EfrjIg5KSQ9bmkS0JwcPMlB9h2rWuTf59OK7+1Hz
 4leQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1mEZL3Sc8V2ThXRZQXBeMM4iFJ6fXC4iHobB5fa2nhBKJFR2UaBNaWSVtpfG6Qr03ZzVkks3+k1gp@nongnu.org
X-Gm-Message-State: AOJu0Yww2oLc54hbYQubc2iqBt2uU7oYo9j0hD6pw5IjwuKab8zNosjA
 C7C1/GKcDbpoesrJFyNSV7t50zDaYyuemK5sZlFlCy6oj6fdhUmWqksPe505LtQ=
X-Gm-Gg: ASbGncu4C1A0LP0dvNXGNgXDifdft55Yud1awXhyaG3+QImeUScpSiQ8J/hTQCNBUmx
 oD27v1Mv4+IhHWRAklxAZstyEqvLoYAfP4dfgYjjjx0GApTrq5oH0/xCKgPCfsC+qwwfKlO5lGv
 W7Lbu5OPY8wmp8qjrRGP90Rh0thoQih8QLjnu7gN1jmheN/30lLWrEX8D5LJrX7qMEdYWGB0uG2
 5eG12Niln0xKKg2kgcBYrdji9/X2ikUyEoKvb7Yd1FIR+rapO6HZjLwe4H0Bo5teHLH/oeM9ien
 aJ0RcnLY4S3jePIeXUTsZcX8yQpct4oMs7orU7fYDRlIEFR9AxEH3OAhNfekEDiczFtH2uuMkVf
 tpXPDlHKHimtEmmgOzuI=
X-Google-Smtp-Source: AGHT+IHd/dQ5vWMxlwG9RY9bJdISGIs8lsoNOixbwVNAa0UKUG0M6JHkVH80PBhYbkaVQZ5IfakEgA==
X-Received: by 2002:a05:6000:2512:b0:39f:cf7:2127 with SMTP id
 ffacd0b85a97d-3a067243417mr1775398f8f.14.1745405000177; 
 Wed, 23 Apr 2025 03:43:20 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4930f1sm18552672f8f.61.2025.04.23.03.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:43:19 -0700 (PDT)
Message-ID: <65e8345e-eb93-484a-b51f-abf642fadc31@linaro.org>
Date: Wed, 23 Apr 2025 12:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 140/147] tcg: Pass max_threads not max_cpus to tcg_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-141-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-141-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/4/25 21:28, Richard Henderson wrote:
> In effect, hoist the check for mttcg from tcg_n_regions()
> to tcg_init_machine().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/startup.h |  6 +++---
>   tcg/tcg-internal.h    |  2 +-
>   accel/tcg/tcg-all.c   | 14 ++++++++------
>   tcg/region.c          | 27 ++++++++++++---------------
>   tcg/tcg.c             | 14 +++++++-------
>   5 files changed, 31 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



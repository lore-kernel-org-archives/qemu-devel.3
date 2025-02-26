Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A799C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 22:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPbK-0000ux-6d; Wed, 26 Feb 2025 17:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPbB-0000nI-4S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:09:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPb9-0002xB-AM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:09:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so149382f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740607784; x=1741212584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ys9QWOGQLKWW6shpt4GEnfgl7JobR6A4zayACbwo9Kk=;
 b=AP7BBhUUOsjj/CJKWt1vA9PBXnvAuui2fDGWFU99YKyYmErP6l5HSfAnsf7EqsFioD
 05qKv8pKTYNFZLxDwiG21h9Bn5bLVLFF0ICinEgXHs437zW/NfWoo/uq85NCjlmNtPky
 npE4dCBBYr7isXeJlF9emxBzeeiTNVeuC3pyr8qg5xpE4+/SucbuFyaM6BHpebG6aXmQ
 ZdOUJVSTMNCMWeDk5BXs0uI+JRERrnEYvqWlyTciC+tauigLKSWi16V4gR2KXbpoS6nU
 K2U45Q68uR8HksvZXiNSJAeTPEh3h6bPas/ZVxwixkL4FyZ0337Vs0ssdtosAcCG5h0o
 2sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740607784; x=1741212584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ys9QWOGQLKWW6shpt4GEnfgl7JobR6A4zayACbwo9Kk=;
 b=aTo48WZNpO/tc0w3zS01Py6tDp647BwHYCqkkGVmfcT8xCFuTQSVdOMSWH4vpKnBDG
 2HzxlUmYYQxzme8dfzX6+qHfBq4mcWEjGxN+BLNp5ZiN2hNNZEHADczbmLHOq3+ZoXOt
 EDh3cTpYRTSqu8olAcFhgj9XT0kf8WE84RcTgUvdQzeUMBnXXtSrLShITWRlqlEBBAYj
 iQbdmOrDNZpXhTV1Bz/zsIzu83Wa4z6Uo9J37+86o50jfnugc1It7od0OQ+h5TksTbF1
 Fy3FMrW0hg6qdKZDSxvS2oXs4gIp/BGMGtj1V+7/G04j5Vzm2JjZl2BNVXwAICS+AQbB
 VcCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYsH0+EL/tzul1o+xbJ6MhZxLqy/bqpKAbKfI6yYnDCfdAqRB9xnk21KH+2RwVhTTkn93unPUt7Mp@nongnu.org
X-Gm-Message-State: AOJu0YzOVcAjcWBqrbwWwNgl4s2mioEbUVp136KW210dEB5Zny05H+O/
 T7hcWxhkG8uYRUhKfGZ5R/pSdMySXLk0ZhNDSVCL0dgrfoPyOjheeTwWD8awsuM=
X-Gm-Gg: ASbGncsQiAD/DQC7VbH/IW+BDIZG9odMadQ5Phq8NR9Cy9MHoxmeWyg8xehOLynwlHR
 vQcvuU2I57QPOmc0YiLJqhnoHFDFgwgWPV5OPv27SOar091AcbjdlNgKrHSrEAEUw2c21IHmLa4
 s2d5N8AW4xtXx1hcHQVdJ1EojwyxvfitSeApf27s1OXr22V7VU/YlJpjQQT4id8/oMhiXNqlXoM
 jgXnfjiJCUcXv7b4P6wDHEDrjed3+pgJ3Fw+TfqfpYldtXuDYC5shRuXNk0nZ3xMP2/ivISLIJ8
 tviBw7u826W28JM80SUanAOTrVzlSzDLiwL3gPSZTJm6BL6VNsvXwZRWxPYJtvTY73oc3w==
X-Google-Smtp-Source: AGHT+IHJsiQ5u4iS+saN25RoEjY8GpX+UhH+hXhXg+UJOnJ6xqSXKjaC+J3y41Adq34UCzLsHOZnlQ==
X-Received: by 2002:a5d:6d06:0:b0:38d:d299:709f with SMTP id
 ffacd0b85a97d-390d4fa366amr4687545f8f.48.1740607783888; 
 Wed, 26 Feb 2025 14:09:43 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f839asm2712995e9.2.2025.02.26.14.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:09:43 -0800 (PST)
Message-ID: <995c0f0c-d21b-49b7-a94e-4fd1f8ba8c2b@linaro.org>
Date: Wed, 26 Feb 2025 23:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 022/162] tcg: Convert nand to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     |  4 ++--
>   tcg/tcg.c                        |  8 ++++----
>   tcg/tci.c                        |  2 --
>   tcg/aarch64/tcg-target.c.inc     |  4 ++++
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc |  4 ++++
>   tcg/mips/tcg-target.c.inc        |  4 ++++
>   tcg/ppc/tcg-target.c.inc         | 17 +++++++++++------
>   tcg/riscv/tcg-target.c.inc       |  4 ++++
>   tcg/s390x/tcg-target.c.inc       | 24 ++++++++++++++++--------
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target.c.inc         | 14 +++++++++++---
>   24 files changed, 72 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



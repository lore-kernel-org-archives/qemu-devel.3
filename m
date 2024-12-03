Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FD5E74AD8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 21:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIa7i-0005Hv-JW; Tue, 03 Dec 2024 16:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIa7h-0005Hm-TN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:07:57 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIa7g-0002Zz-2W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:07:57 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso3510444a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 13:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733260075; x=1733864875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6OM2wERgAX/O8VV+420uVx+rVWF8CNr/EEB/9Zlg2fk=;
 b=JnV92BAeA9rmcVH7n2e6T7Rsik/Sz3FztZoXBGd4fcDw160W3n9q36ZBcv8Npzf6pj
 hdAQUNhGTMtGu93AfpXy8CKmige9DhqBzIwbIUnYdFIrjn0znYR1O9Xoi/bhMta2nMgQ
 fLDdrI2oHmLxUafZg3Dlf05B9pKcG8WczlqpXMfrIaZQDFUDxQrOQc4UqYlvDqinFdJ5
 9hv3Y+ipDGCYR3UnFaF8CYacB5cLp7FGsoxwzipBkXIk2vnwpBFADiWbFC0yOium0tQv
 BauqlmZSfipMZqaUo0i6KVeWwfZRpAdXZylrN0gqwpbbaXpzbH0s7XCfBJ2sQ8ba2v/J
 PG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733260075; x=1733864875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6OM2wERgAX/O8VV+420uVx+rVWF8CNr/EEB/9Zlg2fk=;
 b=l9lFcPdQF0ES8YrSdL0rj5WxtVSp0Z+JlwFWTPYQwpA8A9OfopQlQxiOrVWDkhbKnD
 br/oNCDsAjLE3qvIjzop9QIwmNhiyvsoJVm4AKfIjNbWvgAUmuQW2BO8r2g5VraH4Bs4
 FBmbRo6B2vChqtXXtBVKj9h0vo1UkJWrIH4aCxId4SD6bc0GztYaZNFBVvMXnG0wtS5M
 q7VHVNb5MNho/BzuZVhwFtglO4v+mHVjU8BPfG7OSQzCALhxJGpQwdVJM943OgwzqKT8
 bAEXISISun0tb5absN98sslr4LRA1jw0d2+woKRl12nLaZSEmGFOepMQeVKiiKIoSLqr
 Ga4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDcCvsHwL//7SndZTzLTkUA3InsJpfblr3LZkrzt1famsLLdMnx00JzK8wP+ypJ7b4FMNIuGMD6+pX@nongnu.org
X-Gm-Message-State: AOJu0YzqIzVBXlU5ksRcItCZ3gAmWJ2vAA7rXQK7bU0+nL5IZe0drnrJ
 g4uRKHz7cvZr5EZNTtNmoGmgdwG6/akao/GJOJcVhwtFcZMMN1US6RHRoI0Amls=
X-Gm-Gg: ASbGncsg5D/zOVcZeARimhBWBSbN0mgNrE+wjOSyQqLT7B8PEqot8bgECaaPHSVM3XW
 vcrv8v9a1Lu5ogOe8Va32RttJw5Vxq6cVWnP0DvEosJMpcWGmMYXu42i1O5i4Nq9S9G48k0pKaZ
 PhxqfSi0zPOyzIe8jRSi9224+udvytZ7gLoRGXKwda5mEoo236ltvCjlV2hqT42j97ZO0mzMRtE
 JjZKfDQLsNjZhy9ITc3O444LBSRHe9kMORzl75WtxfCgZ9jPGXjE+3Bld7gZQU=
X-Google-Smtp-Source: AGHT+IGEU7xhzF+SJ5ujAzUKZqBnDXLN1FlMwl1X4LRG+/O5/V6j7B7mnIc7bFIl9E0r5ZuZurOP2A==
X-Received: by 2002:a17:90b:3d09:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2ef012759f0mr5540180a91.33.1733260074717; 
 Tue, 03 Dec 2024 13:07:54 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701def5sm1184a91.31.2024.12.03.13.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 13:07:54 -0800 (PST)
Message-ID: <fd627284-c9ba-40e8-b592-e736ce7c51cd@ventanamicro.com>
Date: Tue, 3 Dec 2024 18:07:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Include missing headers in 'internals.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20241203200828.47311-1-philmd@linaro.org>
 <20241203200828.47311-3-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241203200828.47311-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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



On 12/3/24 5:08 PM, Philippe Mathieu-Daudé wrote:
> Rather than relying on implicit includes, explicit them,
> in order to avoid when refactoring unrelated headers:
> 
>    target/riscv/internals.h:49:15: error: use of undeclared identifier 'PRV_S'
>       49 |         ret = PRV_S;
>          |               ^
>    target/riscv/internals.h:93:9: error: call to undeclared function 'env_archcpu'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       93 |     if (env_archcpu(env)->cfg.ext_zfinx) {
>          |         ^
>    target/riscv/internals.h:101:15: error: unknown type name 'float32'; did you mean 'float'?
>      101 | static inline float32 check_nanbox_s(CPURISCVState *env, uint64_t f)
>          |               ^~~~~~~
>          |               float
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/internals.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index ddbdee885bc..76934eaa7b5 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -19,7 +19,10 @@
>   #ifndef RISCV_CPU_INTERNALS_H
>   #define RISCV_CPU_INTERNALS_H
>   
> +#include "exec/cpu-common.h"
>   #include "hw/registerfields.h"
> +#include "fpu/softfloat-types.h"
> +#include "target/riscv/cpu_bits.h"
>   
>   /*
>    * The current MMU Modes are:



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C3FCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95MR-0007sg-Ks; Wed, 15 Oct 2025 13:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v95MQ-0007sY-PA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:32:26 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v95MN-000086-MW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:32:26 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b63148d25c3so882684a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760549537; x=1761154337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqVrH5nOX1ic51ClmB65OHGjcxRyWLOch1avnZ7x5dA=;
 b=jBRA1skRuHUlOzavpMKoAvlC16z0ysifAZM7DsKdZpKptcpXIDoPf3blh92Cre7RAy
 TgC6ZxYQHimC747GmgbtkgSYxsLraUblebmPSfLwKV7U2PQMFowNVy8VbyyWXy2Wnb1s
 rfDF5IZT9+eTrvucUC3JUULUmrW/UE8GmnG/iU3ct9mJmNLU8UX+chGsrEAvo2PQv32/
 Sn76zKtD1I04M32Did7BjyZrTuGZ8dnTzkhycXYE+Tt1vx/20J2DPa4me9twP3GEPfl5
 eqL3MzOgxmwPJjixmSheOCFjTZJ18qRp5YKBK80kV25tD0s5v/dKZuSFG0NYoEhHmmXg
 bj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760549537; x=1761154337;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zqVrH5nOX1ic51ClmB65OHGjcxRyWLOch1avnZ7x5dA=;
 b=v066dC3AG9Vvg5yoTFR75pZ1RfdQtjYoFcfn6fbcM0IrMLEiF1oXdyJgcDcPDXIg3N
 Sa6HCfLKX+o0jkYxDBlB130HLNTp1cHNkgtBxbmPpwFuSpKfxOfspRberx6/ggdirgas
 FFYyCtMx9uodOvLEiFV/fUuQXj/UVCW0+wLKHMma4IdIbMsglcfAJtDZ39MIRrzZ0WfL
 Tvzx+C/y+7EcSv+7cuAZFIATHcbvouXZBSWA04h7fvIqDFFyMpy3YCR3kO703z3FGW/k
 BNfoy/vpR7wKHgOcHeQIetsXs4kfD+Oz5rJ+KUEK2JIAFieCpD0lpLYx+hrdiJ4hoFza
 UczA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnTbkIDMzeHUwLFG/tPM66hK/3AKIg437uoTrqdVffJ653bIMC9/KzRorRbp5zF1zlTlvAE0sCUzZl@nongnu.org
X-Gm-Message-State: AOJu0Yzega36WgAU7MGMIvVghLCtI2pck7iH/3nPXD+LYbfhJuuQDhmd
 bhA8IOvrHjARUNjy67uPqwCgyYc27k0BO49LzspUBEHwTu2E6J/DCGYgrqAdnGkwZfYJoJfZlfW
 ovWlMAH4=
X-Gm-Gg: ASbGncu40fMc+bNKCb4BOvOScc4lYc1Mbs0QICDWAmBiYhwzPbMeLv2NQYJS8EYQqhS
 jE693/ly+lpodl6zhZprK1TDHViOlytERPUF716GNkqnmxgjcwwFtIgbrYwX+ibo60/pHk3yOF4
 OlE3clTmVD87XmXqhiMFuIuF5ioAGwYEQEqEviGs4ru+GKlbxVwu4Icn2OiwKsWiRPUxKOpSmDG
 FLVEfm/w8G9rczTSXpTORZQtUZBnfbOHWiIc/xt/Q/4xq5JU+QgzHhZ0PLKwtvXs4g6VNKMzP3O
 SuvvZ+kuuAmBQjrWeTs71581UyzMU+vf/POXHkbzTw6Slhoc6Kzg/RcZq/5FG4/ptscVrfrBHFf
 FhG9HjSH76ge62g6n6JWKG4Jx3MsmrwQqgRmekc6qWy0rCcEvyMHkzLxUG5lHhASxr5wiJQ==
X-Google-Smtp-Source: AGHT+IEc9w7/o9pWqGWRFEYx0l0JpwK98LvQaqPxegAFLI5ACZjn/4JRMFmcStHlyNolGGn29BUrKQ==
X-Received: by 2002:a17:902:d4c2:b0:274:506d:7fcc with SMTP id
 d9443c01a7336-290918cbc9bmr11727905ad.6.1760549537216; 
 Wed, 15 Oct 2025 10:32:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a228a5b91sm210952a12.15.2025.10.15.10.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:32:16 -0700 (PDT)
Message-ID: <74cdcf75-5a5e-4b13-8637-422be5069439@linaro.org>
Date: Wed, 15 Oct 2025 10:32:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Name gen_goto_tb()'s TB slot index as
 @tb_slot_idx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251010031745.37528-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010031745.37528-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 10/9/25 20:17, Philippe Mathieu-Daudé wrote:
> tcg_gen_goto_tb() takes an unsigned index to the TB slot (0 or 1).
> Declare the argument as unsigned and rename it as @tb_slot_idx
> (which is more descriptive than @n) on all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/translate.c         | 8 ++++----
>   target/arm/tcg/translate-a64.c   | 8 ++++----
>   target/arm/tcg/translate.c       | 8 ++++----
>   target/avr/translate.c           | 7 ++++---
>   target/hexagon/translate.c       | 8 ++++----
>   target/loongarch/tcg/translate.c | 7 ++++---
>   target/microblaze/translate.c    | 7 ++++---
>   target/mips/tcg/translate.c      | 7 ++++---
>   target/ppc/translate.c           | 7 ++++---
>   target/riscv/translate.c         | 9 +++++----
>   target/rx/translate.c            | 7 ++++---
>   target/sh4/translate.c           | 7 ++++---
>   target/sparc/translate.c         | 6 +++---
>   target/tricore/translate.c       | 7 ++++---
>   14 files changed, 56 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


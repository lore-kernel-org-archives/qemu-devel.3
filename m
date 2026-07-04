Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CDC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6Qc-0000id-FA; Sat, 04 Jul 2026 15:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6Qa-0000hf-KI
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:53:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6QZ-0001tP-4O
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:53:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8475eca3a66so2427561b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783194806; x=1783799606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZlZMEbDabHK/vvIA+1e0tO4Qu2h+5fMiIuO/zFEy40s=;
 b=sads6K/XzrkGLlLPLLU5CBpjt815N3Hsf0vCEyU7BOsM7dFbe2TSyRp712NCCJwMOb
 NiaJT2WJTENI96uHorj1hXZVCYDGnok/Eux3/q+I2OxHv6t275pbjuqX8c24i34Q9+YQ
 TvMSCKbaSRWlP1wKg/h449tqUGZ/+v3FYn27CDAj1kGSDmDVkH7/aR904P6Opy66gf+p
 OzsllgCvuM+YeuzcFPjaOZyqK32afU274bG89gFLlOnrZKVm71wU8w4E4R/9a9EKA03I
 BYmmIf0FCGuVwpE6QRxbZWV8WhsZsZbEbahkH+SGLSwPUkhHApwQiSbqdjKOJD4f7CaS
 QlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783194806; x=1783799606;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlZMEbDabHK/vvIA+1e0tO4Qu2h+5fMiIuO/zFEy40s=;
 b=Mk3IUkkWOCjEJTfz4IGLQZzWovpktWdIAdlH4sKF0Dl+sdOg0n0Cj8HVIuVHY75ltE
 36FWM1GWnPKI/DZz3xDndDmiAc5N3CFwutzGO+lBNucBnZLdLTqpMMcCcCuRc9HWHpgj
 UjB0JAWjFrhATTKqu6rDnZRx1qjc9Vupm2BOy7utAtzJEjPGirDAA1x07CVfY815vgMr
 z6fpZ3DLJUsaI1iO1POfGraep2OAZLnSV3GdbCDOCxc+Mf1O/P9O2ZLrleahrEC2YLXw
 ez8HjnUaXxq+c7Eh8qGa77lMSYeicw+h+7pRw9crcTJd3JVQbaughe79TiUcqK+kAFFC
 uUag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OH4q78FXgq0fsH8n6VS3tb/jwzjVh/YYlqu1yXJa9LnPLWMutCqXWznlgQ24CBvFW4ng8gJOcmF4P@nongnu.org
X-Gm-Message-State: AOJu0Yzrx6e6Q4CsMyONDTd9ON273GDqz8w5mEGfIo/+z2jBA4QELvVZ
 u7s1T0tB9Jth9ST9IhybWf6+kEGazpHO+Wwtg8DdPCnDlMW/eQ0JuEZ03GNW/eG0hl4=
X-Gm-Gg: AfdE7ck7JuvJY94BDwwDOm7m/ScQByOnotpnj4n5mt5HsnvMEP2b5oEhmSfxHumv+6U
 hDJVn69+f3s0FNdezmC1bJTO21IjSjQrRKyk1qZLXm/XZ3/W/svMFpzew6AWXjdPWkkUUUvB/Uo
 tXQAih63ZZ6NN9sicEe4BBtQzeQu0XfP5uWzAHCgQb7YhYWQLv6NUH+sBpu1Q4pjzaSCNJDzat6
 vi26IZd51GOa/cg7WaKygnS8gWAyQb3AsYDQL8ILeQb8pMrJaUC08HPylYtl9Dwt6KWw00qbp/w
 q5N2uWeaPIhZ8F1PDXBnFWjvNX3MnvA9RpaQmA+7vGh6zaXHPzUK4BWlZDADNK6gGZ2uGWfm3Tm
 KRRg5VNQ8i/Ac4RLvl44GXeGmF9u4kWWziZeoOPnnKqSZJKv0vIhyEMkSyRNRRAy4zYLqyasfTA
 rekuMIGbYMit3X5p0hZ7UnA3XKMkJevXmX6du42+gxRhsCHr7rlM9EpGs=
X-Received: by 2002:a05:6a00:f0c:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-847f6d5a853mr4682184b3a.13.1783194805631; 
 Sat, 04 Jul 2026 12:53:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b97bbesm1571479b3a.17.2026.07.04.12.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:53:25 -0700 (PDT)
Message-ID: <42bc71e8-4584-4f89-9e35-f461054e5049@linaro.org>
Date: Sat, 4 Jul 2026 12:53:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/33] accel: Remove AccelOpsClass::supports_guest_debug
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-18-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> Now accelerators hold the 'guest debug supported' information
> in their state, accessible by the common code. No need to call
> a per-accelerator handler, simply check for the SSTEP_ENABLE
> inAccelGdbConfig::sstep_flags.
> 
> Remove allAccelOpsClass::supports_guest_debug implementations,
> inline gdb_supports_guest_debug() and remove the now unnecessary
> KVMState::have_guest_debug field.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   docs/system/gdb.rst           |  2 +-
>   accel/kvm/kvm-cpus.h          |  1 -
>   include/accel/accel-cpu-ops.h |  1 -
>   include/qemu/accel.h          |  2 ++
>   include/system/hvf_int.h      |  5 -----
>   include/system/kvm_int.h      |  1 -
>   include/system/whpx-all.h     |  3 ---
>   accel/accel-common.c          |  5 +++++
>   accel/hvf/hvf-accel-ops.c     |  1 -
>   accel/kvm/kvm-accel-ops.c     |  1 -
>   accel/kvm/kvm-all.c           | 13 +------------
>   accel/tcg/tcg-accel-ops.c     |  6 ------
>   accel/whpx/whpx-accel-ops.c   |  6 ------
>   gdbstub/system.c              | 13 +------------
>   target/arm/hvf/hvf.c          |  5 -----
>   target/arm/whpx/whpx-all.c    |  5 -----
>   target/i386/hvf/hvf.c         |  5 -----
>   target/i386/whpx/whpx-all.c   |  5 -----
>   18 files changed, 10 insertions(+), 70 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


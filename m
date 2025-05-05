Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE1C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0o7-00052j-G4; Mon, 05 May 2025 14:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0nz-0004y6-1Y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:44:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0nx-0006Jv-At
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:44:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so6160903a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470679; x=1747075479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GKKv/xMbQTGSWwlpOo8WHdB3SggIft/5hm7DLXoKBbI=;
 b=UGu0+9b3sGrJtfrHE5AdGu+KmzOQdRoimn6psaDKVJgPm4rz23wh1msdMdxQuJ5ZWO
 PjQcrtRJHRBNpMVPQSZZXKyW+BwdEROKsHP9eHhvpRb2RdrJTlpx7Zo/kdf/lUIY0KEv
 xPyRm7SzNgGjssnrtA3KTJufdKbmmsdc6pSEIsjSHL6D25esAL4751rOFUvnvDH1r3Q+
 Uxb4YjgLtx0Ca5acTL84FAM+qI9d1dfHFlzXmS5e48U67EPqNegRqN4zCaeGcOZJEs0W
 KAIeBwSi4N4PfVfUzEJnqq1UO+iFkd8LYNTjfFWaO6mRAqTMdj5i+oa8r+hJiuiQN200
 sapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470679; x=1747075479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GKKv/xMbQTGSWwlpOo8WHdB3SggIft/5hm7DLXoKBbI=;
 b=VtSzN5E7b7AP7CVdtbt1H3JVWYZ8MYXiin/8t1ywKQQf/fB28OEakxxwI53mBHYtbe
 U+HjyKyypd6VlR2WpSZYpTJ6SfNa6OJTY6wGU5025GqCg71ld6VLZrrRHbzDrXKrC6z1
 7iTakKxelINiXkOYFGgpf5n9kHlZNeNIMMw/ADePymU9JO417brUlSKspEt+DEVf3BhG
 xg7XTBqlcLEjUxo2hvOhri3BPQDv1iOH+NIkIT0klyfISFa9Z1Bb/v58GbvCaHpKjlhK
 1K3gj7/KAc/QlZ/Ux8tPk9qmMYc7pX/9BVEbxgCYPe4uHBOiG3hsiNIZ5OhctvahujHW
 khKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaJ0ERV3I/fNWooLRxyTPlKP6PyUSfS3/CP9cOtAUvsUkVZBq5kQVttnWwbxLe8XJVryblcS5m0FzP@nongnu.org
X-Gm-Message-State: AOJu0Yz473HkJOY8d+VVhtbOfCFTqqOSo7CUS00Csc2977ZV5Sy1v1p1
 TpVcJRDENCqFeXT/OF8SeRaq6od+M9F8nWsEjltwtIrEZLa1RZbgIf4yG6b9IEk=
X-Gm-Gg: ASbGncvXqaYnwGm9mhZ/DElrc8roWtgG/ydXffLQzlVhqdNoG/fVRqlKsRfJryF6vCK
 ctdcAqRl3P6wqxObTWSzK4U9d9b6G2U8ueImTAjT1s8foJ3fNw2u4qTIdznAY2VBj3jDyH1c5Xf
 5kVHjvXBNrr/u8e2h+ImiBA0keiSYa0TbWA7sKgsUL91wz9VT9OtQyNln4CfWA1LYrXt9/WCQj2
 Or1tP9QtVEZitiQLbIQgVJXUp5gpFiSV2wGe7k5w0f9UCcozzWCwixiWtTo8Wpi+67D15acJPgg
 VzpyY/C6IqEeYALL7laBGhEU9V8JX4Gls0ysfpgBJAhDhA9nP33zStce7eSR70obOp4OHpoHGIF
 968wKFhs=
X-Google-Smtp-Source: AGHT+IFypvcmIyf2TlfQ3FqOGv9EEEj4vApmLoTRsCwsw90TW1X57hFXURA9wAliPhoUB+iklAARJA==
X-Received: by 2002:a17:90b:586f:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-30a5adf4ea8mr14076314a91.5.1746470679444; 
 Mon, 05 May 2025 11:44:39 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4745fab6sm9298182a91.10.2025.05.05.11.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:44:39 -0700 (PDT)
Message-ID: <7ff2dff3-20dd-4144-8905-149f30f665b1@linaro.org>
Date: Mon, 5 May 2025 11:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 44/48] target/arm/tcg/neon_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-45-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-45-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/neon_helper.c | 4 +++-
>   target/arm/tcg/meson.build   | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

Likewise, I think this could be built once.


r~

> 
> diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
> index e2cc7cf4ee6..2cc8241f1e4 100644
> --- a/target/arm/tcg/neon_helper.c
> +++ b/target/arm/tcg/neon_helper.c
> @@ -9,11 +9,13 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/helper-proto.h"
>   #include "tcg/tcg-gvec-desc.h"
>   #include "fpu/softfloat.h"
>   #include "vec_internal.h"
>   
> +#define HELPER_H "tcg/helper.h"
> +#include "exec/helper-proto.h.inc"
> +
>   #define SIGNBIT (uint32_t)0x80000000
>   #define SIGNBIT64 ((uint64_t)1 << 63)
>   
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 3482921ccf0..ec087076b8c 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -32,7 +32,6 @@ arm_ss.add(files(
>     'translate-vfp.c',
>     'm_helper.c',
>     'mve_helper.c',
> -  'neon_helper.c',
>     'op_helper.c',
>     'tlb_helper.c',
>     'vec_helper.c',
> @@ -65,9 +64,11 @@ arm_common_system_ss.add(files(
>     'crypto_helper.c',
>     'hflags.c',
>     'iwmmxt_helper.c',
> +  'neon_helper.c',
>   ))
>   arm_user_ss.add(files(
>     'crypto_helper.c',
>     'hflags.c',
>     'iwmmxt_helper.c',
> +  'neon_helper.c',
>   ))



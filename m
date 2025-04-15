Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE98C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aQ2-0005HZ-Sk; Tue, 15 Apr 2025 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aQ1-0005HJ-4t
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:09:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aPy-00020X-Or
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:09:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso39877345e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744700952; x=1745305752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQorS3qs/9wF+hxqJeIyqNgmDflvogIXAEEo0HyX7cg=;
 b=dtPXgWFtLet/d+n5T/yga1rYc+KLIbj84TK/2etakuhxL+//DOfOqOasxScPLT1ELk
 PEIP2mi+7VLZokUZqxetPy72vTyKBDDD+0eA4aPWvY6cDWtcULNHCPXq2k5D4GbEh80i
 BejL6kTweF1CfOULfay06mc8pHvfEByVGq4VJGJF0Aczwz2I76atNU4pQBoqwmlWgehp
 njid0qHiQvENXZg9OkJxGgc/9MGMpzprQAs/ON1O550LYeoRY1LBvVzQGbJeB2R0qNZb
 cBbkkS8dT2AuYH5B8hRWLDTrUDcqzmMAdsrlvIhOixL2WxuxJedRudGk3G6U7ah8d5ls
 FRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744700952; x=1745305752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQorS3qs/9wF+hxqJeIyqNgmDflvogIXAEEo0HyX7cg=;
 b=gA1ExWZxejoft+9fnTni5JjVvNsqxF7QqQQssa5q5fJqsRLErgWKLfTshhCeZQbH6y
 PM5ygTJcm6W/FpY8obkJbrBLfBD1R04Yt6e+zkh1I1t09csuSXTCLeG4PhlhSu+4OCuV
 oz304QkR/9SgVFM+Jzrrz8y8Fo7MrXJxwx9ASocDy/Lv2JZ5VBX/eFDIRS6kDWz0/cE+
 f24xzNS0LT+k3oOBTzTByIS+iqgNsoloul88oOHeuwBxY8OTx+2Q4UG9ScjC0sXFFUJB
 SfNf5mR/4NAeJNOUR3Mbd2MWhEBSfFSj1cB9oAY9K6hWjPx7HGrZDFqfz1ZACgnOx3fO
 Dlxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWotvECEfdEyyBksNLxQEVzkqwh9bmwb6EGv56YHNrgiurQ8Iedr26y0iEH3tV4a23EXkn4+5EIPtGb@nongnu.org
X-Gm-Message-State: AOJu0YxmDn51zaWSMJyObIXUxBEvxSk6VdHLCbRjHq16Kc3khuWsX0c8
 XsulnI3Ckp7XjX22Ld2y2XBQpGtiOVN0biwidhEJtjfCy73LslCtGRvCfK9aLW8=
X-Gm-Gg: ASbGncsdT/gi0M70R/CQGGFnwFlsy4SHnLOL+P+j1+dXiIvdPVbK/lUuQ6scqWktufI
 70opxx67T+yIN2t1k9terKUuffeDWEZfr9nvvtkhkQ1Kr1v2/wpieq66b4W6j4KvuhAKHkb7JHm
 8FihjKF1UVk06AHFuDQtktOGHu5MWVpitCuX9VBtMPfS/Mc0idNVgrnoAp8HtenoloXjaexaJPo
 Jus0V+0QvjNSJ+WaXrwNtMunXyW0zUjB92ZNqNz8BUVa99boF451OZLwo/n2N+lgtDqWxEVD50z
 S/n1kwWU9gL6qEcGCFxU0Bxl8W9vpd56iUH5USBYT7uYQIwdtqa1ECtQY65A2E3SboxEwgWX4Ss
 rog+uQir7
X-Google-Smtp-Source: AGHT+IEBCb9hNiit5aB+Gor1TQBCisecLYyLH9/Q7InmyAKhQNWL89req9MQk6VcoCy7HxiIPVKtng==
X-Received: by 2002:a05:600c:3acd:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-43f3a7d827emr146771465e9.0.1744700952548; 
 Tue, 15 Apr 2025 00:09:12 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecc73sm201303415e9.8.2025.04.15.00.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:09:12 -0700 (PDT)
Message-ID: <0fb4cd74-bcbf-4063-bc3b-0e8359d04117@linaro.org>
Date: Tue, 15 Apr 2025 09:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] arm/cpu: Add sysreg properties generation
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-3-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414163849.321857-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/4/25 18:38, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Introduce a script that automates the generation of system register
> properties definitions from a given linux source tree
> arch/arm64/tools/sysreg.
> 
> Invocation of
> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
> in scripts directory additionally generates
> target/arm/cpu-sysreg-properties.c containing definitions for
> feature ID registers.
> 
> update-aarch64-sysreg-code.sh additionally calls
> gen-cpu-sysreg-properties.awk which is inherited from kernel
> arch/arm64/tools/gen-sysreg.awk. All credits to Mark Rutland
> the original author of this script.
> 
> [CH: split off from original patch adding both sysreg definitions
>   and properties]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++++++++++++++++
>   scripts/update-aarch64-sysreg-code.sh |   5 +-
>   2 files changed, 329 insertions(+), 1 deletion(-)
>   create mode 100755 scripts/gen-cpu-sysreg-properties.awk
> 
> diff --git a/scripts/gen-cpu-sysreg-properties.awk b/scripts/gen-cpu-sysreg-properties.awk
> new file mode 100755
> index 000000000000..76c37938b168
> --- /dev/null
> +++ b/scripts/gen-cpu-sysreg-properties.awk
> @@ -0,0 +1,325 @@
> +#!/bin/awk -f
> +# SPDX-License-Identifier: GPL-2.0
> +# gen-cpu-sysreg-properties.awk: arm64 sysreg header generator
> +#
> +# Usage: awk -f gen-cpu-sysreg-properties.awk $LINUX_PATH/arch/arm64/tools/sysreg


> +BEGIN {

         print "/* AUTOMATICALLY GENERATED, DO NOT MODIFY */\n"

Should we keep copyright?

> +	print "#include \"cpu-custom.h\""
> +	print ""
> +	print "ARM64SysReg arm64_id_regs[NUM_ID_IDX];"
> +	print ""
> +	print "void initialize_cpu_sysreg_properties(void)"
> +	print "{"
> +        print "    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NUM_ID_IDX);"
> +        print ""
> +
> +	__current_block_depth = 0
> +	__current_block[__current_block_depth] = "Root"
> +}


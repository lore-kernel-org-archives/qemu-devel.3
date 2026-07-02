Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC1AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLbL-0007hl-S4; Thu, 02 Jul 2026 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLbK-0007fL-AY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:53:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLbI-0006hM-NZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:53:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ca1479dfe0so20622185ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014803; x=1783619603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1YDasfJit96SgrAHspsfSi9XU5gZh5XjPd6MOOS2LU=;
 b=v4Z9HUB/Z95jvRD4kBEL0zaPvSLnuiplvfqW6JRLsijSTgt8GWJhc6DI+DgPYHJQUv
 Seuhs1K6j8Z9SGox7qan953KYFNpY1JdRK0HSeko7uUHqxzCMMob4Uewump4lbxmqn0o
 V1dFIgJeOMzewJcdoAbpIYGHVeQFT1g7LfRPhs9KTy0wamLVCJj3KL5Y4RFQGyI6Pw2O
 7MgERQfI/vhlxNP8haQMk67HBZefnqi3+hOsEGmW686uAyEDYmQE66GTelvHFw7gxaNZ
 iRkURzlNcLIQL1oy1OBeg/oa1/03A5NRyP2F0nmQYxe3gBylimuYjBeU08Xo7+7st0vu
 AQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014803; x=1783619603;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1YDasfJit96SgrAHspsfSi9XU5gZh5XjPd6MOOS2LU=;
 b=HCURvzDP/EqpJs19BWr5GJUfRTygtkLLC/BfmuPMABuW7WIefeByuT8C8UuMahyn30
 fAJVBNbV52wbmKBa33V6ceU8kDq1+6HK+NeQEOWDKCjQGtnl94xwrkHTfqLtRGjSAiSw
 eLpO2iqd8bEMwOMR+44LYfgI4iqHD0Hio90vSAqszU0jovx4xx6u/kgIVQljXO+8Tgvo
 Rdf7dDVkiVUgv51yvdOD5amZ8EA4Q8OTiOf+jGxPq5DZ0szr0cguA8UsTWlqGiQqWyVj
 xdiBREsDD6bYAU5iN5FI+OJtOO9MNGPMIDVL1Pa6bt0PZyiVI4wKzH2T1iHIvs+wax6L
 qKIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8C+U0PxhrANLlhqLKP9UMrWwiUVK3WvhCZTvadULvYrrsgrYFzZLSBzQ2Am0jLuqnxd1PBbmYomLJ@nongnu.org
X-Gm-Message-State: AOJu0YxKLb4c4S/PRVR0z4n8M9rmUALt/oKJdeeaD0enlHgWrZdMhaHp
 LirnF88J7nrBCP5Dd7R2c4ZuplWY5QZMtqFI67Y9yTFxhCOxAvpK/VFYP2PGBIs4Bwc=
X-Gm-Gg: AfdE7ckajtIN/hO4ihSbiZnRgvuuWXDtoWnzLonewN+rdQTwY0MUUsZ0FTyXdvKOZzh
 anlUmNvetjssnYF86S9cJDIIPP6znxdSxEy5uF5/YjU6/1MFK1g677VjiCXEZD9E7aflHLRDLHP
 c8tneWbzjk/MtkyPwf6cexVFs4iKD5tjyt2oGhlBqjHdjoxyGDx+azBW8o5aS9xXgB/m16YzpVM
 Vnx5wLC2kx/3l6O2KH3n13vgcZeZuyv4wFb40I4GdCmVmhTRIabv1O2yukTctk/jIQm91rhwAAd
 WENnOER+nqg8HfremdsuXsAEjFe9olIZJ0vnid9vk+/6K29BDKVVYMMZe3mZukNSwd3TqVC0BAM
 xfmKHu+T9gX1695UrK9jHT+4SAtA4arR2LlB//EgEOf0W7xnJ0JXLRZmr6G1u/MBOP7e5RoD/JD
 ZPyhjOuPbbJjk0m8y5FPhxaDIcHCWiyuvxaeAj/0AtR/TDhvp71CCHEbVMgA==
X-Received: by 2002:a17:903:2a83:b0:2ca:de3:15e8 with SMTP id
 d9443c01a7336-2ca7e8db877mr74759235ad.26.1783014803030; 
 Thu, 02 Jul 2026 10:53:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dae33sm17144215ad.1.2026.07.02.10.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:53:22 -0700 (PDT)
Message-ID: <d638a5c3-5579-4c17-90ee-57368d8dca00@linaro.org>
Date: Thu, 2 Jul 2026 10:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] target/arm: Inline check_watchpoints() in
 arm_debug_check_watchpoint()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-25-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-25-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> check_watchpoints() is called once, by arm_debug_check_watchpoint(),
> which doesn't do more than this call. Merge both. No logical change
> intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/tcg/debug.c | 40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


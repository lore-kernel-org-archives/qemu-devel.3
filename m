Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F265EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzbk-0007IL-Im; Tue, 10 Sep 2024 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzbd-0006l4-62
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:04:25 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzba-0008VH-7K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:04:24 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53658f30749so4674415e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969860; x=1726574660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lsGYTq1QpiT+N/yyLFsqNm2hUCSVXF6KhaQHQJ1beN8=;
 b=QBjzUHbLll2vgeM2LW5epcfls6Smv+DJ4p1hIArmv6jh7CaVQO3YMVlkdXPyNmuG/k
 +jQD7kgN6g04IUotGk+1iLwHxyHTx7LmfRTXRiCm4lmTYeaa6MDZpjvqVEPsOvIBB/0r
 Q0BocK5aT+yrRzf08s7inuPGTW5MTJX5C3fRMJPswGe4AiZsNzf+aEcW0zjvzzTH64zj
 swtc9v2opriqgtxXlgTx8Ryp7jTrDAD5EDz84hyD3g4PVPIVprB8floaNfLlfJv1qZEi
 HUKQk/JKuWFs5w6uQ0n4YiZKRlMa+MV6rH4M1gN77mef6NhWBla2kyjGbvi0Wqrzg4ii
 nrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969860; x=1726574660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lsGYTq1QpiT+N/yyLFsqNm2hUCSVXF6KhaQHQJ1beN8=;
 b=Bplmg0PN6rTOWJHl3KkZNHP5W9ENcFNf3wCKDg5IjwJbfeBacy7JX5mJXfaGcabR4G
 PPUmVb+SK796lEkD850xhe95axaZc6xAloV3uqpT+pBeT9Rb8jIKSSU/oQvLOC722Kc/
 zTzJo1md2rKBNVtQ249rh1VP7K7V1X5W7nfvbZrRRSialaK9U0XxdFdRiBIITsqeHLgM
 1dQTltHE/BZ7UIpCuaBj+jGrq8XQy27RU7GFdJBkL+6P9eQx/jsz8ayHu/FWlqE3UXgG
 7QO6dLgcLyEP8mW1qZ8kuwM9+5vPVjldT1wX8LErskkW8NSIB2Ifqcb3/dbq8Ufyo+sz
 zygA==
X-Gm-Message-State: AOJu0YzmsxB2Ne2AeK+aIK2K3FgrALJ7i6fTBohaFZBCfbpL9KMDTTv5
 Lojav67OfhAaUBoagGiYfCn2c6BBKB6f0Hzi9z0n8STj8TYgDCwk+OGYR050rVIB7irJg7wT/wY
 o
X-Google-Smtp-Source: AGHT+IHZomFpW5IvxvKfqQMESqUXQlkgFLG2uBp/b0hD5sA0+xjowxtn0YpG/mdTiWxzeTdQv8HVJA==
X-Received: by 2002:a05:6512:104b:b0:533:4505:5b2d with SMTP id
 2adb3069b0e04-53658816b7amr7156781e87.60.1725969859748; 
 Tue, 10 Sep 2024 05:04:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259f56f6sm464687866b.81.2024.09.10.05.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:04:19 -0700 (PDT)
Message-ID: <3849f9dc-57ce-4924-ba90-b2ad912ccd60@linaro.org>
Date: Tue, 10 Sep 2024 14:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] license: Update deprecated SPDX tag GPL-2.0 to
 GPL-2.0-only
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-trivial@nongnu.org
References: <20240910115131.28766-1-philmd@linaro.org>
 <20240910115131.28766-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910115131.28766-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 10/9/24 13:51, Philippe Mathieu-Daudé wrote:
> The 'GPL-2.0' license identifier has been deprecated since license
> list version 3.0 [1] and replaced by the 'GPL-2.0-only' tag [2].
> 
> [1] https://spdx.org/licenses/GPL-2.0.html
> [2] https://spdx.org/licenses/GPL-2.0-only.html
> 
> Mechanical patch running:
> 
>    $ sed -i -e s/GPL-2.0/GPL-2.0-only/ \
>      $(git grep -l 'SPDX-License-Identifier: GPL-2.0$')

This didn't catch the full list, this command does:

   $ sed -i -e s/GPL-2.0/GPL-2.0-only/ \
     $(git grep -lE 'SPDX-License-Identifier: GPL-2.0( \*|$)' \
         | egrep -v '^linux-headers|^include/standard-headers')

Thus squashing:

-- >8 --
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index e5a47eab64..4dc4c31da2 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
  /*
   * This is copied + edited from kernel header files in
   * drivers/net/ethernet/intel/igb
diff --git a/tests/tcg/loongarch64/system/regdef.h 
b/tests/tcg/loongarch64/system/regdef.h
index faa09b2377..b586b4e86d 100644
--- a/tests/tcg/loongarch64/system/regdef.h
+++ b/tests/tcg/loongarch64/system/regdef.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
  /*
   * Copyright (c) 2021 Loongson Technology Corporation Limited
   */
---

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/crc-ccitt.h            | 2 +-
>   linux-user/alpha/syscallhdr.sh      | 2 +-
>   linux-user/arm/syscallhdr.sh        | 2 +-
>   linux-user/hppa/syscallhdr.sh       | 2 +-
>   linux-user/i386/syscallhdr.sh       | 2 +-
>   linux-user/m68k/syscallhdr.sh       | 2 +-
>   linux-user/microblaze/syscallhdr.sh | 2 +-
>   linux-user/mips/syscallhdr.sh       | 2 +-
>   linux-user/mips64/syscallhdr.sh     | 2 +-
>   linux-user/ppc/syscallhdr.sh        | 2 +-
>   linux-user/s390x/syscallhdr.sh      | 2 +-
>   linux-user/sh4/syscallhdr.sh        | 2 +-
>   linux-user/sparc/syscallhdr.sh      | 2 +-
>   linux-user/x86_64/syscallhdr.sh     | 2 +-
>   linux-user/xtensa/syscallhdr.sh     | 2 +-
>   scripts/kernel-doc                  | 2 +-
>   16 files changed, 16 insertions(+), 16 deletions(-)



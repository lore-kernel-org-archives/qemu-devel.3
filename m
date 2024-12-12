Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053CBE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoKM-0004eH-AT; Thu, 12 Dec 2024 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKK-0004dt-CI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:20 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoKI-0006Xw-2k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:19 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso896713b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029654; x=1734634454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COQa0IDmzSYvfWdSQf7pgjwEYz5PX2cSNYwHo2OnbHQ=;
 b=RH2WLNViv5rxLLEtqjvRqVJn1hud/r/EPad5mdfhrhBEFe42heHMfFlOhtgtiliDaV
 msCSnoH5gPior3a84eKU+PiMJCZXAaN5jAPFO94ettyd7Wt9wD0KYY0wbArkiKhiDfHK
 JC0Z/iVj7yWyIHTlKZyuCn5tcG2XQs+Zl29Pp/WmL5bTfUrv+vIMGkdm8IHIuIeAVVwg
 ISNEGfs9FvqhPnUD40tkwIFTXpaoRPA3wwhZmYx8mKmPBfu1blYGAkk8WimYVAgPsTea
 7Yy9FRvqBwaWUca5DQHfO21LBJZRoAChpo5Sze2SCEr0KR03z2x8J2/kRuDlizy0l3a/
 1yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029654; x=1734634454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COQa0IDmzSYvfWdSQf7pgjwEYz5PX2cSNYwHo2OnbHQ=;
 b=vOjoqd1ZCdksyHqiFAiAa5iw8dlAygJt37MmuXdPByN5c7JcvZnVc9+lDSP50kI47/
 8BbFMvERvpNTFCOfgNmCHywCptVnggI/3eABWnvlNgRaU/7Gyc2CURMbvsMH7lnqiklR
 QPL6licDzFIiOvRecbtd8Wz8FDMc2kREVSWIl8X6WTPROixdVTpSGbYDeCMXJEAko+AE
 vmIOoOMjqPpPQ8kkmVk5C8RYBk6xG57BC0LI8Kq5mUsYZWBEH0URol23fAoJR1QJpNED
 rv/lQEo5ntJWH0oDqXd7MwP7wwIrya1ty8Asn5LJhqNdemq+pEveR0akbL02HCglKl20
 Rd5g==
X-Gm-Message-State: AOJu0Yyi5gWyxQVsEZJO3xEy5wTQmSG7bNfzABoEWRYKRsTrxAD8w9SY
 BFck/lM6RHhxPvoVmndek4J2SMjkqPMMjtIYLC0Irkgwxc32Z4pS3H3w188WQbN/S1r3RLSvrAD
 f
X-Gm-Gg: ASbGnctevQOQUUIx6cD2E4iirnaybNuRuBK/DSHCH2UaR5pel0KE0NQZgJALTzjqGR9
 BflITkOmxHIlS3f5/UHnZdwTMpVTwwuUPcL25DG8DzeIBYiUZ82XE12A1OL7az27m/kIa2SClY4
 bRWEzp/Y5dzprlxlx3E34vPiYTEaqD03Ze6ItXpOQdfqAwQaaZHsVE9kjljufpOBNfbpTbKq2ur
 QctPRHvQWqMiFcWSHJlSqmlJ5h2vttosJmmT5/YWnzuPh3MJ/2XVP0Luv1npvrO4HyulRtyx/tl
 YMw5r/6L6W+6KN8ZVc6kRFYquUHy5Lw=
X-Google-Smtp-Source: AGHT+IFQNSDMUDu1KjluxEHUpQ8TgFW6sOQJITb19SzMs2If7YWqMPatFEzqX8gHIDM4erPMDu2NjA==
X-Received: by 2002:a05:6a00:2885:b0:728:fab1:edbb with SMTP id
 d2e1a72fcca58-72906ae391emr2144317b3a.20.1734029654724; 
 Thu, 12 Dec 2024 10:54:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7273beba847sm5963884b3a.174.2024.12.12.10.54.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:54:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/18] linux-user/aarch64: Include missing 'user/abitypes.h'
 header
Date: Thu, 12 Dec 2024 19:53:25 +0100
Message-ID: <20241212185341.2857-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

arm_set_mte_tcf0() uses the abi_long type which is defined
in "user/abitypes.h". Include it in order to avoid when
refactoring:

  In file included from ../../target/arm/gdbstub64.c:28:
  ../linux-user/aarch64/mte_user_helper.h:30:42: error: unknown type name ‘abi_long’; did you mean ‘u_long’?
     30 | void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
        |                                          ^~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/aarch64/mte_user_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 8685e5175a2..0c53abda222 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -9,6 +9,8 @@
 #ifndef AARCH64_MTE_USER_HELPER_H
 #define AARCH64_MTE USER_HELPER_H
 
+#include "user/abitypes.h"
+
 #ifndef PR_MTE_TCF_SHIFT
 # define PR_MTE_TCF_SHIFT       1
 # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
-- 
2.45.2



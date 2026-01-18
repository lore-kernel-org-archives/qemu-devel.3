Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F685C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYYj-0005We-Ea; Sun, 18 Jan 2026 14:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYh-0005RF-0a
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYf-0006ei-KL
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso23917705e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764932; x=1769369732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ku6MKAbz0lsq66NK21aSSMinHF4P8+aWQtofxx0ViFw=;
 b=Fnu5lJAbLCwi6suxE5PbrAWR9FTxHIT3Du4vItRxPw7tiDqsHn4EkpRCo6mUyEs4MU
 hyUo5VFJMHsGGBVU46FNU53N4EG6w13aHgZD/goNUlLyi4ND9Sov/tszYr2qV4DpehDs
 V3LSkq3l53MJWoJcGCEx1t4AsN2Infn20hK/5A8VsacAE+bmEWSK83hNP9HSN1rL6sB7
 XkF0wAMXRr9/NP3RoY0mAxovD1f1jIAQjwsI9uGvsEqWQavBPUvM3Q+OZGSoV9DdmOOr
 vR+5rpKqGu5CB6TE5Y75AWwtYLqDLxCITILVaej1qSi1BO9nEzpNJMf2Houkf1pHG9w/
 h6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764932; x=1769369732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ku6MKAbz0lsq66NK21aSSMinHF4P8+aWQtofxx0ViFw=;
 b=w/6mQkT9+rc9JaSLdUJ1i7/LnN4QugdKZlEn+bzKcglo8h0WcQB94i8B5puMH6Q/az
 O9fJn2aCNvnqe23+hcy4Tf20DDWkNacn9FC3dor5kGOJoBCEnkG441W5XdtiRjo+W/TW
 3L2GZrnW1pIgq5VkT8/7OndQTUnTH4LxwFggE4Jj/6lA/+OSpyuRqqv6YG+BtaboqP4e
 WYh02cd0FYtDAuE0FGS82yRlHCN+fiVYtDZxgU7Gvj6klEL86mv0f0iQXBOrLUxjXUV5
 R+VsGraDDLFK9ozZLysLTTqYbA8zfhEF2UZ0NAZgPAABlTNauAB1bRzbOXYpQRgc5fJ8
 KtzA==
X-Gm-Message-State: AOJu0Yzu/dBuDYhNwy5dks2glyNxsw/5KnS/Qt0JBTxK6WKRnQGksZeo
 QN/Ni7RSCeP4uOW/SG5Kt6l0Y9gxT1OcN7cvaCRXKMHY9pI+eGM2WU4FM/Qr6YdyN200sj/d3mL
 RTlU1a3Y=
X-Gm-Gg: AY/fxX6y/m77Wq7a3HwNug9cQsOf4ZTCo8JsuihKmQNi+nzYKe6lKEjOneoFMEqDqba
 4igrIxqXnzXiveXwRvJ+PHRgTPCeh4S/y1ilshxdGxgZLPk0lVL7ZZQixSDgXpBq2TqM4fzj1cE
 cc+vfdzOOKqaPxDlfgkeKcYzQNcz/ebPctKvyIzM/SDc0xGsggS8jmiNGFyfDdwn38Q1Dkw8UMM
 vn+wJTbHldbdOy0zmlcYvHpbLUDd+OAhcBneY5BgBzpcbKSjV9V9dA2DR7UM6GkZjJZk3mPVWQA
 /Gjgj0a9SdPgs0Q+f+lcm0DQgJETGC/2apVz+tqT19HqZA1gBLfJj69semqjlb/f60UUpzM1wt3
 SRd2mg9Vkhe0lCnOuhNshituMmgyvrWoMMezXRHAbF/5ghVemTI/55mfXOzOg/qIzVHq/FXgrlT
 KXmKV8zslyTSch0WDFNQd62xdaaGQsyVVYJ3kleT3dWwd5WSrxauJE2+m9WOfH
X-Received: by 2002:a05:600c:4e93:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-4801eb09274mr93487815e9.19.1768764931981; 
 Sun, 18 Jan 2026 11:35:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0499sm158334345e9.9.2026.01.18.11.35.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 03/18] bswap: Remove unnecessary 'qemu/bswap.h'
Date: Sun, 18 Jan 2026 20:34:53 +0100
Message-ID: <20260118193509.42923-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

"qemu/host-utils.h" and "qemu/int128.h" are included a lot in
the tree, and don't use any definition from "qemu/bswap.h"...
Since it contains a lot of inlined functions, remove it to
reduce pointless compilation cycles.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/host-utils.h | 1 -
 include/qemu/int128.h     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 0777a2bb60e..181d026b6c7 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -30,7 +30,6 @@
 #ifndef HOST_UTILS_H
 #define HOST_UTILS_H
 
-#include "qemu/bswap.h"
 #include "qemu/int128.h"
 
 #ifdef CONFIG_INT128
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 2b8dd4dec9f..7b3b071c512 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -1,8 +1,6 @@
 #ifndef INT128_H
 #define INT128_H
 
-#include "qemu/bswap.h"
-
 /*
  * With TCI, we need to use libffi for interfacing with TCG helpers.
  * But libffi does not support __int128_t, and therefore cannot pass
-- 
2.52.0



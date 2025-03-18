Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D238C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOvw-0001LZ-DY; Tue, 18 Mar 2025 00:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0001EM-Fb
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvS-0008Sj-EC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22423adf751so86808835ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273497; x=1742878297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWIezDEnsVaTp50avzaVFN+/54kZx3DW446tGxF6xYk=;
 b=bURNFUCFanUVdGsPAdZtuPijDBHLWkSZIaA/GDC04doZz+tfv+QLBKMXPpMNn6ELij
 kBvDEa42DyXc1fAY2zsIH5zYS8tCcbqseeQm8rch0Gb1XIYUciLiaSKPeoCc/i76uqIW
 wCNIZobD5j9dc30kvsL92662NGolcYRykOB1pdq3PLj2+YK99zhuv7uwUrSDvDJ2nS7w
 VPw9yiu9TVKRQfjiw6PN7xOb529dudC+G1ExbOZ4nM7Mjoo+fgBHHpO9h6ukocYh2nMI
 OT63y9sDQKyhpbouKRyqDYSfesejsyOIQYgwirnmegUdt3le6LZk55HKKXakXm44hxcX
 WfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273497; x=1742878297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWIezDEnsVaTp50avzaVFN+/54kZx3DW446tGxF6xYk=;
 b=ZPFVoD/G0y7UM4FIFAdxysqplsIYmd2gmbygY00yHSa4GplSvBKUuHjcwJqBoa7pWX
 GH8f9yR5r2pf6sDT9BsMaDkaYDtjh1FwencYZWKU7Kw1fK32fZ10nWuAOjzDWbArEV/7
 9nc3RjdSM1AiCklD6Qd/aoyPPo7RkltX0iG9tR4Ck5UFPEg7Uc31g40PtkNQgm4fwon5
 ysEWsrqbvmyXH/qQEm4AQ3rZyPuthIKkgy5X3H43Z1XzxqmsT8gjbhxDQpAqCg7kDU7d
 RhYjrZCp9Oh8Lo7IKb1Q3QRv+aCX7dIcC9ur9kdotfktzW8CbRhVQVA9fRIVQ8UEJHAu
 x9vA==
X-Gm-Message-State: AOJu0Yy5Sib0Xzcim6o1YPmdT+IR1ldUvNfNp8wjnsMGH3KbZCtHWtX/
 JZFGZC5d1iE+rwwooAI3CetE1i6TEC026TU3yA9X/qtSvWMcWtUAObjQuznyU7smYPWM2ZpkwPk
 /
X-Gm-Gg: ASbGncv+UVKeXBj3PwxCmgja5nOC6IMRbf4ANSkEtYOONzwwSaH/MWmpQ9aONaLggFh
 yxzf84WWroFOcxtBrUYTS03TCYsLdM2a0wWzGqZO1LU5EGf/dEZ3Xg5ruB/DvDoZaE6+91GSHO1
 XKuSxRolneas6vAAto4V6hAQXYQxW3LrJy96nEgihriaBgTbrGZiBsBLh84deIKch/ldEOSFWID
 uZ0CBuBMl6+NguH/68KC5JoUQSOG4hNkmdEtsmk/ezYlHcOxAkUy/Ycn0moNiSMLdnG0q+c32vj
 IvNGrEGriW0xoKNdRSJVjM8BJaSV86QRYTCer4vw8bYj
X-Google-Smtp-Source: AGHT+IGfVS9r67mKi+C/QhYaIcplE7qOFrPBNlW784RCUzNr+6ZfRfHv2pwT7sOIOfbETdELQgrdAg==
X-Received: by 2002:a05:6a00:3cc1:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-737222535c1mr17970185b3a.0.1742273496888; 
 Mon, 17 Mar 2025 21:51:36 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
Date: Mon, 17 Mar 2025 21:51:16 -0700
Message-Id: <20250318045125.759259-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Including "cpu.h" from code that is not compiled per target is ambiguous
by definition. Thus we introduce a conditional include, to allow every
architecture to set this, to point to the correct definition.

hw/X or target/X will now include directly "target/X/cpu.h", and
"target/X/cpu.h" will define CPU_INCLUDE to itself.
We already do this change for arm cpu as part of this commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 4 ++++
 target/arm/cpu.h       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7c6c47c43ed..1a756c0cfb3 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -46,7 +46,11 @@
 
 CPUArchState *cpu_copy(CPUArchState *env);
 
+#ifdef CPU_INCLUDE
+#include CPU_INCLUDE
+#else
 #include "cpu.h"
+#endif
 
 #ifdef CONFIG_USER_ONLY
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8177c6c2e8..7aeb012428c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -31,6 +31,8 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
+#define CPU_INCLUDE "target/arm/cpu.h"
+
 #ifdef TARGET_AARCH64
 #define KVM_HAVE_MCE_INJECTION 1
 #endif
-- 
2.39.5



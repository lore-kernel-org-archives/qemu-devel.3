Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE72AE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLDG-0007Iq-T0; Thu, 05 Dec 2024 18:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLDF-0007Id-6d
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLDD-0002Kn-NU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a95095efso15908175e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733441084; x=1734045884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfTBm75o97Cz8/aU/8hyy/8ZcyfCCBeJMjQXzg2r+cU=;
 b=DeTL5FpYyAPcysikjB5Ar6SCl/XwB1baAEvvxzlvnN3oEnY8T31VJikhSgjaEQqkyw
 CPKpYBOSKkAEkTR023yzapmsF5O9NADLmoDWc9ns+Jdwg8IekQfFkyAAdA7SwwdDtEGj
 2rGd7Rg34NyMVnEqyskHgy7xcZbmhzsonLAgJav0DxDJ2Yb7BDjJMGPnr8SEiqYiOeFM
 XnY4ZvXqyA1aPGaL5RkRBOG74IW0kUhZpzmmflbsGu4DMsSnjHyiiHXRo3L5aFtCLf/Z
 VdcXNonq5VRVz584tomqFncdN0AMN13+FlllwXGK0A/lAGE265RiYPnHQLVSmgH7OV4j
 /UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733441084; x=1734045884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfTBm75o97Cz8/aU/8hyy/8ZcyfCCBeJMjQXzg2r+cU=;
 b=G+3QjAC92m7C+S413ymyZQ8pYCWnOX1D54RA7i6yXXbqeR8zRXKTaAtBosAXJFl5m/
 At9r3deWdy3kEEh8ZCwApRwFPejrDmC/aBPX9ZchG1UVG5Z9LKmMwCBSSSCJn5ZjWRvk
 BcBrQbaXmr+HPtF3dHz8/JyqzOVqlal9QimM0rMBv5qNZLcblQuP+3tArhwf4025S84k
 Idwz5vnP8jA2+cLi67bb6vQySGOGkWWJwVFedoQ4ncTexYFms1nfvLBGTkDuLDb2XTLw
 j/wezo1q8+oVApvOjRtrHGdRF5d3h2aC1fr2SWygcDFctXyOrcOPw3QFIvbQo5+T2Lp+
 ge6w==
X-Gm-Message-State: AOJu0YwET1AaWopaMN4Z+CvcbpvR0QxqSXuaJGl6GKL7omcrqsnEL8o0
 yGU3xzgGrpB0DDyp1h8XLu7dGyOSn2DDOeaZJFv8vbXBRgRY6a6w4L1MN+4vdpE+LY8vK8SljiK
 Z
X-Gm-Gg: ASbGncsZR5qBQ6R++WjjoGCDRaTcm+8GXNHKs78ySOqi9N62Cl7OovZDOvX8dxxNMBk
 gpg0ACimsY3ADX62dQE2+Vr3dg+psLOw4QqW2pgVZwB/J6+7uSJs4O3J89Sp0TZwH1B5wJ742KI
 O50gWO8vVe+aeoslhfrQlBHWMXAxvmRTN1d61Lv4rAg3m/6ucZz2pGpokL2nLwk/ILDGQkxCb4E
 2IBUBZPpGsRyh15rpMyf9E+UcydEcv1TsxpZk1bKG4syBNDi5QeJLQ5VF9+UL/q+0LuZkPTF6+s
 pW3Sibqw5FWO/vVSZYkcilE9
X-Google-Smtp-Source: AGHT+IGYwORdv7cVAcXdnT9tMF6kG6nrqvNtI3Fu60roK8lzqPGsHrK0l2snrRN7Dqz3vDZW4E7lbQ==
X-Received: by 2002:a05:6000:1a88:b0:385:f3d8:66ab with SMTP id
 ffacd0b85a97d-3861bb7f79fmr3761920f8f.17.1733441084551; 
 Thu, 05 Dec 2024 15:24:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d2738sm40030065e9.4.2024.12.05.15.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Dec 2024 15:24:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/xtensa: Implement xtensa_isa_is_big_endian()
Date: Fri,  6 Dec 2024 00:24:36 +0100
Message-ID: <20241205232437.85235-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205232437.85235-1-philmd@linaro.org>
References: <20241205232437.85235-1-philmd@linaro.org>
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

Xtensa internal fields are opaque, only accessible by
the Xtensa libisa. Implement xtensa_isa_is_big_endian()
to get vCPU endianness. This should be implemented in
libisa, not QEMU, but I couldn't figure out where to
contribute this.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xtensa/xtensa-isa.h | 1 +
 target/xtensa/xtensa-isa.c     | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
index a289531bdc8..1cb8e6ccb66 100644
--- a/include/hw/xtensa/xtensa-isa.h
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -829,6 +829,7 @@ const char *xtensa_funcUnit_name(xtensa_isa isa, xtensa_funcUnit fun);
 
 int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
 
+bool xtensa_isa_is_big_endian(xtensa_isa isa);
 
 #ifdef __cplusplus
 }
diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index 630b4f9da1b..36eb4bcf3d4 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -1741,3 +1741,10 @@ int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun)
     CHECK_FUNCUNIT(intisa, fun, XTENSA_UNDEFINED);
     return intisa->funcUnits[fun].num_copies;
 }
+
+bool xtensa_isa_is_big_endian(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    return intisa->is_big_endian;
+}
-- 
2.45.2



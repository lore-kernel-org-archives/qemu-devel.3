Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D14C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6U-0000bl-GF; Tue, 29 Apr 2025 01:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d51-0007dL-NM
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d4z-00060P-7f
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225df540edcso66043715ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902823; x=1746507623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyyYrSBpMjZGqDtX9J3tyJffb7EP1/gzXVNNR0hz1h4=;
 b=a8bunHGV34NEfR1MtLAwbGoswNscaly4kONN9c4YN0rr08t4FLT2sZ6DBQKZ1XjmBk
 ZnnDJFBBzPLvoAcFzYIPeSKf9hk8rJYzgGdeQT4J7kPj5qr64S6CfghbnqTlk2stAi3F
 9RFVXzuSarWAhTwh1OjeoF4Al8GA5YPu18hF/8JbP4O9H0Upk1z9rI4hUM1oBp27V2sh
 OZx1AjnlqVUjeG8xrEMkwneHIIFfMiAsZFTr2fYIAMza1o8DnQkwf5gtdlBWL5sdUOmO
 DT0KYOfLmZaGBuqr0Wg91WJOPLPIhAPSNP4rLhj0VJm6RCu7+1x+DDmVfQYQkmMwm/74
 XPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902823; x=1746507623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyyYrSBpMjZGqDtX9J3tyJffb7EP1/gzXVNNR0hz1h4=;
 b=DH/zl9LPTzbpLNbhNnULVaxZkID2Pm/4bMMsyHAyjTQQwCyxACw384db5mNeWOPIcP
 peqoqLGkbuB+v7vVxJPrV1jeO8jyNYDpob5uGL6JRvrAFCZXbIBn3Vh8eXrds37igN7D
 V0RUpCNXVDQaz60/v8m5oB2sh50bVkauZq8sYMOxZTyUMykKJhRukQC5sn1GD0B8gQRX
 Qdojl1Y+D8LQ1NAUTa8oLYhrWcIc2n8qRj87U/w6FjDfrVfAcIwh/WaMrvfggDyl0Rfp
 KUjP4wL3e5Ho511TBeY0wplVUMMOw4gEe4+6s0TV/ywkBzl1dv4NclK0o/znhtt4e6rQ
 Vu/Q==
X-Gm-Message-State: AOJu0YzbjCBNw8PyNltv2Ts+rM1J7tzb8bh0EevwZgF8D0a7jKz5Eu1I
 WE4RnZSOuhr1FASzn4ZkZu8+Txuhyx92slVEvzy5DPh+HL0Ms2wQy+QvmaJBgCc4BKYHkbzU4oT
 g
X-Gm-Gg: ASbGncvyn2G6UG3zPFiy3K407apc3kQQqxW7Oir363R3emDaUbxCp7LjgBqsvf+dYaj
 jNZv/za98vNsrXzVgQ9WBDOAmYq1Vtd68r5qkwzKXCQlgZOFaWV604S3OZHpf76ISWBtTZb4YXh
 JMCeJScydnizpT4QKBaAxUVskUwYB6O7WpsT6aWnj8O5CNOk5ZNwWYIgEYS261/RVhXPsxpEpGo
 9TqGqR9o5G/BZT0GkXFEC3XM2RlvyqBcmfJNuq/UbXyVyZgdFlGIISydaL0EvG3lyWHR9HBfBXs
 CAIX9KMDUM6QU7IZqsyfJ5rhQUWIhxWa4QV3jvAW
X-Google-Smtp-Source: AGHT+IGe2Vt41jFcsiUP8gtDdpGA+OGNZ8jHnyxm346MtXJL2horun4dC7fIa/fI75EdFBPvs9YjeA==
X-Received: by 2002:a17:903:230a:b0:215:742e:5cff with SMTP id
 d9443c01a7336-22de6c1e39emr23981905ad.16.1745902823374; 
 Mon, 28 Apr 2025 22:00:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/13] accel/hvf: add hvf_enabled() for common code
Date: Mon, 28 Apr 2025 22:00:05 -0700
Message-ID: <20250429050010.971128-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Other accelerators define a CONFIG_{accel}_IS_POSSIBLE when
COMPILING_PER_TARGET is not defined, except hvf.

Without this change, target/arm/cpu.c can't find hvf_enabled.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h  | 14 +++++++++-----
 accel/hvf/hvf-stub.c  |  3 +++
 accel/hvf/meson.build |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 356fced63e3..1ee2a4177d9 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/hvf/hvf-stub.c b/accel/hvf/hvf-stub.c
new file mode 100644
index 00000000000..22e2f50c01d
--- /dev/null
+++ b/accel/hvf/hvf-stub.c
@@ -0,0 +1,3 @@
+#include "qemu/osdep.h"
+
+bool hvf_allowed;
diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..7745b94e50f 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -5,3 +5,4 @@ hvf_ss.add(files(
 ))
 
 specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
+common_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-- 
2.47.2



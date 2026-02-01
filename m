Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C65E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgsq-0003NJ-9Z; Sun, 01 Feb 2026 18:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgsp-0003Me-OQ
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgso-0002WP-BX
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so35044695e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988573; x=1770593373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qak0qGdqEv+ckuqbzm8qmTzP57U15an7kYIfscsbE3g=;
 b=wGekI/0VCbMWohKIoeIxWFJfzV6eiN3Pmy8acHbLL+74Wlvw4R/OVJsSY9H5GLUuBF
 kGhrJaj3rtXK8AJCvfWozHeyqaHR4dGW/98PyUHT6MBzexkv1UoJ3kMOmN/9PheAoIjW
 6ptIa9tfaDhlnt/1c59xKmPyoxFDck/gCkQAqHxOb6UGVAoOFwnRfXZAWVory3STDMuY
 oknRMNHIBKRVWI1spFClgKp3j020jBu2ynQCipYtCQFQE4lA5sWA6cQQpuVjRBmRW4Ar
 BNKnFwjGSHGpBGaqM5BiAl6dsrc5aihCLUJosEcFy33SC40zQoThTeQ93ZpLRnMcnr1z
 dWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988573; x=1770593373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qak0qGdqEv+ckuqbzm8qmTzP57U15an7kYIfscsbE3g=;
 b=pXCf/+r4aA5igDjHEbRQv+65EResL4c16+4NwYl5m6oUUTDHm1MIpgv3lnXgzeAhx3
 Uwl67qPlImwQ67b1CwRT0mNMxoVsYYxztkkO/FKZsCmM+4xalQTYSdZB4Ao6eJB8zlTo
 Pl4Sb5tFfvETdAlkqZmkBRsPP4N2b8N8FKTXFhEZ789u+GLRunUV7273NptUpykDJGuU
 gxE9FhOMuT2ma165lXy5cqRRKqz3T6LEZ5kRMfQzEBzx84Nq4df7Eutoqn2OXp8z741D
 KGQY+LjP3RL4liU+ELtIAyn9dBPgaPEUeDdjufx1w/NNu0cvGbzTXN+LAa4DFnFiEB1h
 i/UA==
X-Gm-Message-State: AOJu0YyR1RskmgPEW+lKI8KoRlVpVVO8KVXWd6hpPg7wQxZEHYWQUybd
 ZhAvff/LwP3my2Dmo0VHUprHYKVSkXvGCs2t0i4VZXUY9snUSoy1sDhfFBahDLul9gk3oiT5E7a
 j8Akd1R4=
X-Gm-Gg: AZuq6aLtBqfIRi6hiAWt0lhJByUrDVI6a2GIGD09VGpfWdZfo79iyw+Z/sSVbsY87RE
 RW/OQ4kOl1MeSoWzKU4IRiAnW35/3aNPtQEaC5zewxL9l0Ae/lgHs3oEzfOjDc4gPRZt0a/26B0
 QJsMZRkjHgS/19ft/eE9m+D4QnMdO7Atsr6HS8coY7HAUS5zF3mj+D3T2PMvC//5wV2bBBKxFKF
 Yx8JFcOIE+af/L77WCujwRukDiL9Ig+PKbEZv/WL3MVbXChxiRsoMGHQzoICr5D4S9qXjZpy2EU
 bwS/1nCldKTC8RiHpIBl7A+auOgyaMRMHS5txDJo5xM3tkKRvSfA9i7ExxhU6QdBqsieowW7Xlg
 gUs4raG8NWOmSMg2uFOZlG/t+WvUk2RzJBTAZOfyIa2ALHb4F/FPjoMNeg+dMzLqIqJrHY7yUNO
 uJjxkEM09DW/Dn7cJP32+i0OMyoZUYQIs79V9Fkzmtq7TSluqQ+V+sRfZKkN17
X-Received: by 2002:a05:600c:4fc7:b0:480:68ed:1e73 with SMTP id
 5b1f17b1804b1-482db4f39fcmr120566075e9.36.1769988572650; 
 Sun, 01 Feb 2026 15:29:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd0f043sm90313135e9.7.2026.02.01.15.29.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:29:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 01/11] target-info: add target_base_ppc,
 target_ppc and target_ppc64
Date: Mon,  2 Feb 2026 00:29:13 +0100
Message-ID: <20260201232924.93399-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 21 +++++++++++++++++++++
 target-info.c              | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 62359622232..e3287334304 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -71,4 +71,25 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_base_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
+ */
+bool target_base_ppc(void);
+
+/**
+ * target_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit.
+ */
+bool target_ppc(void);
+
+/**
+ * target_ppc64:
+ *
+ * Returns whether the target architecture is PowerPC 64-bit.
+ */
+bool target_ppc64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 24696ff4111..5a6d7282524 100644
--- a/target-info.c
+++ b/target-info.c
@@ -73,3 +73,24 @@ bool target_aarch64(void)
 {
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
+
+bool target_base_ppc(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_ppc(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC;
+}
+
+bool target_ppc64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC64;
+}
-- 
2.52.0



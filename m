Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C9D172A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgjm-00050M-SQ; Sun, 01 Feb 2026 18:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjl-00050E-Ik
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjj-0000DD-Ur
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so51103295e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988010; x=1770592810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qak0qGdqEv+ckuqbzm8qmTzP57U15an7kYIfscsbE3g=;
 b=MGJEtnnGRnh+S0RvieOVvptG2Pal6D7CAk5Ud37zBS4pTPvH/k8mzwkrJhi3t43Jda
 v9Ojl9lJB3LjJEVOg+e3HyWR6MtrARb6b0sBkytc+DnMD5FDLaR+aKXO1PVHDfzrshGe
 uK5o0Z/GDireFYfJ4ccpbsMBf+rWxNa55TAAkdZD9IhE2nYNXJnEI5juqFsx3LaLCUVC
 h80vOWYSVb7vQLKHx9ZGEJ45K3YRbYU9OhPx6eHOrvQYyPzHFrXk6qE8FJzhnRvewo92
 afhbwUPHi5IPHAcBFSJ/9e9gIBhpFlOFP93mSQ84C4ErrsTDUZPXgPETaBMxroXzano8
 Wk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988010; x=1770592810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qak0qGdqEv+ckuqbzm8qmTzP57U15an7kYIfscsbE3g=;
 b=gwmk2Tp0ahYF4BRzVcuKCPjUb8uooMejVdcaRJIMZ+wV5nktE+toy/e4pCqDhVBWc7
 EMhebVikO76HrNOSLhR/6uiIH6Uk19FR+MKNtSRqxg/pDs3KiQkU85Bc9CKUuhifOY6Q
 oX6FXWWklzXHv+LI640fGlIkr5gRjf9SNdA93YG7nhISXLmq8MDM2qSDga9c2v/En7fo
 jACA7LdIRw+IPqMXr7MjQ8/BJAjjLJmid06eiphnK8wJ41zUc+G+fwNkcSJSXUnOb74n
 6szSiYemxmx9v3L+dft2YTiYHGiaI3LgRK/3rdZda24DmLiBrAsIhhcP6giu1FULVnBG
 2c6w==
X-Gm-Message-State: AOJu0YyzG9c7PAiB1XA1XiNpj1HEnePEQHniAl7Xsv7aSkri94GgDBQr
 q8vRlynZ3thIMA5nnUTxTuHMKJjw+Loc4+0qVNagtTfuyZtefjzKrAQS8puaxkakZNCIuJusyZ3
 +RUbkTjk=
X-Gm-Gg: AZuq6aKxLnXl05wconAeScQEkWgKqiLDv/qT38+8GvEnhFib18W8gu+6WoiyWE/X9eu
 cEtACdWOOKAzT5FITNbFaiWy+whuYW8muvm3DLA+WnuPXNsfgnufHr+ruf9VY7qgMJ8Y5YNx7cf
 huKVoEVqyP0cYMP/bepoEMvrttRocXACQbbQAQZDKGEJj8t9sgN2oI31VeaTYY0D5j+0tEyyRvI
 QUPlY6hkZ6763TsShJQwBXLF96CdG42XlIZuQURHujASMPuMpaUZ271pu32VowMOaZ3U1umUzQK
 TU6lVhhIGm3UwQMw201NNbYImV1fJ7gaK+fP+HQEvwdlQbWY+ql7D/X4etNHu9yVsJMO+xZE5+d
 a4+Q1zuMvUMVN+hGT6cRpNKs5TduNARJeMalDv0aKq5gW/Eh3YCghB9Bm3tVInGo3n0PdV949TC
 vjtGj4zeNHKZvHONsRRpq+LlhONn/BChNLdB3h4mUpbQrD0VpUL9G4KWoAfL4s
X-Received: by 2002:a05:600c:34cb:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-482db4921bbmr123762465e9.19.1769988010156; 
 Sun, 01 Feb 2026 15:20:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbc7f580sm97990715e9.2.2026.02.01.15.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 01/10] target-info: add target_base_ppc,
 target_ppc and target_ppc64
Date: Mon,  2 Feb 2026 00:19:50 +0100
Message-ID: <20260201231959.88559-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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



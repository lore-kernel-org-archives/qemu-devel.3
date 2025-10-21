Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65558CCD1BC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJUn-0004ok-VP; Tue, 21 Oct 2025 17:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUl-0004oW-0X
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUj-0002xr-8C
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37916425e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080531; x=1761685331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyBRVhXyrHJatY88IDaUClSZaIlND+mQCqYij+BB37Y=;
 b=PmYkKM8W1BCFtZbD6Jeyzi9kvKSpGmlna0snOJA91eBoiWyz8G+6/7RXNn7oQ54Svr
 CsD0yD1iZ9Ya9f/Hd4lFvvvjS5u5am2ehNQ/5Ki3iyqNQz026hpVNpZqqYXHT1UcWCtk
 5UVdMcvcn63IzIjuPaZMbsSDDSeqq0ETZ3czPN7NphUYMr9WVnwMUnx3F6RZNgYqXS9c
 lUyzF4x4BSuV5AaaqCbCkFjCkm9vRYRmytl1rWuYgXpHqMwt99FeVg2TpYnWFA27VMbH
 Nxrw37O344yQEoTTgxVg8qIJ2Lc1tucHU57igeCczuYZNCYxOlBR8wm97nikQc5CFTDq
 DhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080531; x=1761685331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyBRVhXyrHJatY88IDaUClSZaIlND+mQCqYij+BB37Y=;
 b=NK7LP32gqro9aImBNwT9IQ8gX5fnmzNkpz56w806SrzTNIH9sE/jJM53MBL0HI7V9p
 1PlSgj8jhxMhbwxo07ZFEP29BEEPyN1WosvCOOf4lR3OAjWIOrqWiqcCj+AeG028u+Lg
 9bZwfAcSXFPepoTZsDtEHQnRrZXkhWgJ2A8VL6tGnQbHvjixQk0Ov4zqozfcwIvKMiYm
 LGUbjn+NEanMDV+8KGGRnwN54XgvwOmHLPSwK1D5DUbglNAWOxTGP3Dt3vcmY7aihUHJ
 QCD8VqE1bbm+DaOpRO+VhNtMgXF8NNFvozJlCqPtFrBr7+BNAGDe0ZfJmhKD+xee38Md
 Jq8A==
X-Gm-Message-State: AOJu0YyjbIHyoViGCL/Sq3q6+zPNbe4YIi28+GRLlO/VuSZuPrH+mjUO
 V5Fehl5s00S1yOf8eNaLqg4c9FGJDntf9woi+flai5kEQJSd/kDVzRT3IgS4cf3xDkuIEXjGgCC
 Bu1IoaFM=
X-Gm-Gg: ASbGncuG5DefjjbxqIEZPiJwzI/eI7Dk/2qhiVcb/dVrK/WVS4o+S7CmjWk/0XzCeke
 YOSapOroNNDG1hVEaZ4alZup+1iqIRZY/W53l8saeZ2iSIlsVbIsprp6ljFIyJ4oRkXqhTdufK8
 xHN298/ohtRrVY2jbNj2G1qify9XUhfW28u6V3bb88GgnpMg3FJ241eORzomJmLkVkSnccaT5S8
 9NCu0dmRU+DQRL96vmFVxB1CVwzfqYgMTvl0BHUpWteyFF/qyXeTf4TsJzDSr9T8YAgnuCWK0hj
 q0burb30WLKZmi2WmCLy5tfKXIC+m0BfpiwTKEe9N7bjb7hfRMOAqTgpqPrwWlAqAx1wDxI+VOs
 pyPEPixLjMEDYuXdSBtW//MikXgXtVVozszLW74n1l79mQbCAmWDMdYPpJvrM925Qxy4ebzqJ6l
 /3iZFZHlWoJkTCQyfALTlcZi1NebskBarGFABIOo42B28h5KNI9tuAkaa1pszV
X-Google-Smtp-Source: AGHT+IEB+GhIMJSY17zfotixHDFe5CBPa/FciXAXoiTkzORWQUFQHmAtUk3NpA9PsS4WZq7aCvJu0w==
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47117912b0dmr137813445e9.31.1761080530972; 
 Tue, 21 Oct 2025 14:02:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f77bsm10544495e9.3.2025.10.21.14.02.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:02:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 11/19] qemu/target_info: Add target_base_arm() helper
Date: Tue, 21 Oct 2025 23:01:35 +0200
Message-ID: <20251021210144.58108-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
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

Add a helper to check whether the target base architecture
is ARM (either 32-bit or 64-bit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e8fbdf19d53..62359622232 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,6 +50,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_base_arm:
+ *
+ * Returns whether the target architecture is ARM or Aarch64.
+ */
+bool target_base_arm(void);
+
 /**
  * target_arm:
  *
diff --git a/target-info.c b/target-info.c
index e567cb4c40a..24696ff4111 100644
--- a/target-info.c
+++ b/target-info.c
@@ -53,6 +53,17 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_base_arm(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
-- 
2.51.0



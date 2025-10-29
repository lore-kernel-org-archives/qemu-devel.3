Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159EECCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE4B-0005N4-N5; Wed, 29 Oct 2025 17:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE48-0005M8-JB
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:50:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE3r-0007ap-I1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:50:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so1965445e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774623; x=1762379423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbKQE7qm6IKS1msYSrsdvM6/yFqMo5M5BB1u87CRFX0=;
 b=wJrchxNauDqyR6JwhoabgQhzgGNlBkG+6I+wWPylocoosmCmxJ77wvhxNQrzCdFh2c
 YosOrZKThdvDifZwYz3Lf8pAFG8kvUASjdy8PacNSavFlG8nAnc2OnIVavgPUvV+BHlu
 64OSlkBp7JmC1LkkpzZOzvjv2JA2WRAYIl0AHH7F5OToD5IUdXLYvYfAWdWlwKry4Ymt
 ciLdFx9IQ2Wc+Ti2k115T+R6LAz2B+vWnMWuzuFvlnG5Ymwnd580csdJHBTE7EJ/LKCE
 FqJ0ajHon0QQGm+uZ/m6/dxD6zr8t8VuoCAYEpmkh32AjyPl5y474PwB99erKfRSB4fb
 voIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774623; x=1762379423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbKQE7qm6IKS1msYSrsdvM6/yFqMo5M5BB1u87CRFX0=;
 b=YC7XicuCG3Jjp5mCxhT5rfkDHd0D6Nvp08ZCjraBoietYdI2fwfR6iQ/Xt+smU8zyH
 X4wpce4bAQLDIJrgqcYq+if4sbEoegluG8F1owes/t0b36XSthVY0qKz0mJ4sUvdhqxz
 J98FkEkLxDQao8qFZXCkwDW2l8w8fdUYAPAmC3aqiBR2FEgC2TfmpbOfbI3uMJsvDHCV
 eTLd8OdTA+Nc0yMjO10q/cP8HMx5UxyNFpCAh3QyufvaskoemYR5xUSC4BVNpfZ5ETsk
 9SheiDk1T1aabP6KU5flpLYKrUtuoSF0qTAClg+c+VSFsHlQEgE9oBbTl1HQWwBJT4ey
 v4HQ==
X-Gm-Message-State: AOJu0Yz+CmFMSmHprCzSA4xwK4arldv3ubI4yg+zUPNv1LC3E2Q88f2O
 mbawWh9CpS2U8dVFhYgZbUf+eFeA365oZEo4QDV55pPnhoUEim/RE0iPR0ti/bfw1r579f5xF54
 0p+Ry7OQ=
X-Gm-Gg: ASbGnct9OWv/0v58gMD2zXlQtetq9pxGTzuriTs+u3giseU8ICtPAMukinYHabTqz7Y
 ZtYXy7et4u31bOjBnVJIHASXFhNjgbK7thexxnaFhM+YO71lSDXTvIMvf0erDYKNK4CWzz7zxEq
 Fdwzs5bu7WQLycBBjB79mbwfiRzDtR8crDkjXTwgkry9xrURh6zPZUwzj/Grw5TRUFhDTucGDOE
 ghs4v7Oyc+U00zazQEKiJBuhFoOMgQN4jAc8CsEWEwBtcw1OJTwqZn7Fcslltzx+6vDA2av2IeU
 IMEznvqMJxBhBqYkwwR+gXBPPbr00h/YZrbYtwdLjQgcdsyQCvb2xYjGtf4m3bN5AZ8BPxhLqrx
 mvZEw5Hld80aR6XmB01ccaZC1BJdExTLvngYHPOTHI0fcbWdZw6NORpk7TfT/WNz0KPhO9qafth
 Wwr10pHxX0hDgv34y+MB1xv5ZwaQXq2YjsZkhjWjyZIc+oNh3Wcw==
X-Google-Smtp-Source: AGHT+IHTSwKOMFv0RaZtT2IQ/+PmQSFEK0hhc41Z4oKaL7KKgqcOFYejd02ZoERiD+R5YJKMT2Igng==
X-Received: by 2002:a05:600c:4ed1:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-4771e177c4amr40857215e9.13.1761774622623; 
 Wed, 29 Oct 2025 14:50:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477285df825sm4921395e9.0.2025.10.29.14.50.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:50:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 10/23] qemu/target_info: Add target_aarch64() helper
Date: Wed, 29 Oct 2025 22:39:47 +0100
Message-ID: <20251029214001.99824-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Add a helper to distinct whether the binary is targetting
Aarch64 or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-2-philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 984fba3f42d..e8fbdf19d53 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -57,4 +57,11 @@ bool target_big_endian(void);
  */
 bool target_arm(void);
 
+/**
+ * target_aarch64:
+ *
+ * Returns whether the target architecture is Aarch64.
+ */
+bool target_aarch64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 40716bf4051..e567cb4c40a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -57,3 +57,8 @@ bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
 }
+
+bool target_aarch64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_AARCH64;
+}
-- 
2.51.0



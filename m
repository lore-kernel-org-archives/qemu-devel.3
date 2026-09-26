Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93D7C9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMRB-0003ub-4I; Sat, 26 Sep 2026 03:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQU-0002xl-Hd
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:28 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQS-0000Ws-TH
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:26 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-3437a48f386so61915eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406143; x=1791010943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HJ9xRfE2HEWLds73Pc52p76fnBhp2O12QLdWppftCGU=;
 b=rGKhM1ZI3bGPzs54BNW7N8vhgl4jGGpP8+x1cT+FjVD98GnomgP4l4UVCWCSl1hYzQ
 CV98aIOuNI+FJMk7lur7KV9RiM93g61CwyKtKQgY3WVP91hth0A6b6GdT/8qyENywW/y
 9ZsDfFhVY1BLw1PXu+ItZloUT/3pXwNbzRrsy3U99et2LI9dMXmtd7e7Q0iHaCWeZPv+
 zN1rqNpjlMGlyZu7eiksnrE+xD8JXrC8asvG8qK3WKlMdOm/gIUTL2b1kZi4dl17RrPQ
 GMQtkTIh0mYslnL6E0f8Qkp5vAcktbBTuHmMlKTbWqSQQVvGM0494jwTsp5aQE10U1r4
 eE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406143; x=1791010943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HJ9xRfE2HEWLds73Pc52p76fnBhp2O12QLdWppftCGU=;
 b=PiWbCbV3OXCcjvFIoN1DiHVmN/qNqFQuluzJ40ToqRgcKzBGez+Z/OC3yBZm2KaC3s
 kddRxlfSbgHTSN+VXr49DWZMlTqiitCw605Qy0Pb8wFH5k6T7HFXaJ5OcJUUJ4K9/ao4
 LtucQfil+WvTE2Y3EvesXAm9bKPIcU2Pa3TqHcr/VB6w5L8gc/Nr+0Zh8nbTVGNQClEl
 38O2mYMPtCuVyQe11KX9Q0HZmgcViEyXtHx96nta77IrV9R+/8aoLTxBWHHt9JdIXo+X
 t9tcjsNzWHMfhIhZob7tz8bmyZA4VkrPZn6EGnqz/5RqjtWkZSKP6PO4EilO1R6JYeUo
 SkSA==
X-Gm-Message-State: AFuF++mGI46gE+JCLFg1ejQSS0BoG7xt1uMcug+GTs+ukqlPTEedV3l+
 67ut+XV/VRyxHJQvyD6uAzkUmOesZ4QHfkXJVA6ZPAnzM5fQFAZqoMEfk4FFfOcu
X-Gm-Gg: AYBFou2lOVpDRLwbkaT0cTPAxnqCZWnWuDWjeZ/e+MJQ+tZlGoj9OqpS8LwRGmXwSIq
 as2i3QqPML3G/Rs1mm9L7z5wJ2nHbB8RiWGAQAconL2PRwzS4FIuc9dsNbi/MgugHMzsze4EWwv
 jkc2DyLaaNSW4kf92qXa7xky6pmMT6XmQDgUFRNZSC7hiNJeXwbqkzS7YofIklZhzpsulPIA5Pp
 76Ljj6llCmkAo3kVANt1BBqwcHNXx07rkgXJIL3yBMxsD/2WbzdGrn5BuhW78WSnThofIso1Vcx
 c67Ca5IEn8p59w1Tes5zrYZve/2qiHZPlVHNUeBt8Iv1nsprncXdVVznCadfcrzvfSA6EBcBunr
 5DyWNO46bHY/CSY/pk/60+42I4D/QE7zlxDfsAOzFQo1e5qyc4GFsLFMqudKQzzKGHasdP0MP1f
 w4/lJxL3BCdOT9niikrvrwY75leCnsLIQNZYT2asrpyJU0gWyiYnB+a5wRambKc+oDbZfB6I8ct
 3USq7tXIlC0Hff05kMSh8En3/ChLkA=
X-Received: by 2002:a05:7300:fb10:b0:32c:5754:97e8 with SMTP id
 5a478bee46e88-34270ac3a45mr2183384eec.13.1790406143522; 
 Sat, 26 Sep 2026 00:02:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:02:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 20/55] target-info: add tl_is_64() and target_is_tl32/64
 helpers
Date: Sat, 26 Sep 2026 15:00:19 +0800
Message-ID: <20260926070057.1234-21-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Add tl_is_64() using TARGET_LONG_BITS per-target and
  target_long_bits() in common builds.
- Add target_is_tl32() and target_is_tl64() for a TargetInfo.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 28 ++++++++++++++++++++++++++++
 target-info.c              | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 3bbe1d9b607..a5dcf60dd9e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -34,6 +34,34 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
+#ifdef COMPILING_PER_TARGET
+static inline bool tl_is_64(void)
+{
+    return TARGET_LONG_BITS == 64;
+}
+#else
+static inline bool tl_is_64(void)
+{
+    return target_long_bits() == 64;
+}
+#endif
+
+/**
+ * target_is_tl32:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti uses a 32-bit target long.
+ */
+bool target_is_tl32(const TargetInfo *ti);
+
+/**
+ * target_is_tl64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti uses a 64-bit target long.
+ */
+bool target_is_tl64(const TargetInfo *ti);
+
 /**
  * target_cpu_type:
  *
diff --git a/target-info.c b/target-info.c
index ad93a4b125e..1bdf3869605 100644
--- a/target-info.c
+++ b/target-info.c
@@ -76,6 +76,16 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+bool target_is_tl32(const TargetInfo *ti)
+{
+    return ti->long_bits == 32;
+}
+
+bool target_is_tl64(const TargetInfo *ti)
+{
+    return ti->long_bits == 64;
+}
+
 SysEmuTarget target_arch(void)
 {
     return target_info()->target_arch;
-- 
2.52.0.windows.1



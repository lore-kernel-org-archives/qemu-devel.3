Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8D0E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLB-0002Hz-H9; Wed, 18 Dec 2024 08:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKb-0001L9-Md
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKZ-0005ge-2y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:17 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb790888c6so1976810b6e.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529393; x=1735134193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXrXbfwgiws2bkMK/0sJxto8toVBigST19xjjR4sDbs=;
 b=ZfabOJIu0Gm+4Tlh6SQLylufQHXR3qeQcUlAQ90pdZ5rlJAVPn7lV8Dj5pxeafwxmU
 WjfuSrmLaNZJ6i+X5s4ijKleCi2bS0doSEKRS9bbMJ34gi3N7wzIm1HTQndi43mjsFcE
 WT23bMD5efR/qcl8y+oV5ky+Q2Kl50QVYJnahNNwwI3xqO6YP82fN49aBBvFgQIFTWOS
 j8/p7sz/mS3elY70smwZs51dal+diI/4WZHyHOKV+Qf8C4ooTis6FgzrzoX7NWWboM9n
 eZZtnApElRJw13wKJGZjyLahkiypo6u3IsngB6jGm/pzSQfSzUxqYtWDnGfjPG+MUwwS
 DQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529393; x=1735134193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXrXbfwgiws2bkMK/0sJxto8toVBigST19xjjR4sDbs=;
 b=jolggMtL5mBM/23LORtL9JJDnSJxQXt9h5mpwOTGYkOjr0/yb1Uh2dnZzqapg3hSBq
 V+nza+L7jBHCyteWiRjSg1/A07kBvfqGn5g84yvTRp4lW6ky4zUCERzjLEH2i2+9ZTat
 dunN7uDdcLnMoo44HBUUCI7IQjVBE7eZ99Ang5UBwEP07GJaAVhC3Ob9vY1nJgmvyim8
 xwg7Ydj/NGKzdH1p9L4uxhham+OKNIkRyg/z9YxqVjJDjmV3AEUlfShNO2wkI1b0QF80
 COGqpQTcDcxJxAxm9ez7TR3Uvk/k9RmOMYT5yKKUn2rWiuRLUYiiMYzEuoX1Xwx7HC83
 8eKw==
X-Gm-Message-State: AOJu0YwDNXeKwVsh5Gnh83L1VhBIQIIehdSmO6kmY8Bb0Pb9Yuu/xqLp
 8D+PaIeCp/vvmWltfFDnJKXZORPud84bP53N+z7+QEA671h/CA7DmGwIjt8rFWg6ztk35bPMUGi
 Rc89bt8TL
X-Gm-Gg: ASbGncsnVRV37PzIeb0rGab6SBMi5CkN8Pee0Dz5gQmEQpS/SyaAaca49pnBjDqBNKN
 DmFv5ySH+7j/c8x+9boihiTSsGrjkcKA5ZpfH6wteDuJg4Ps6QrW6Fmo4Z1LfBvF/pnsN9OXiKZ
 jzv0Gzopwwr0h0Fu5JlklCfE8xiyWpGQa7nCisrTm3CHawjJKWJ9/Qiq862r5e4SJQ5TEAx9U4/
 K4s1bSpY/RAFsuFU0pnX3pYjVHLFBvaJnlqSbVD1d8h6IDgz6E8ciRnpciyQfI3
X-Google-Smtp-Source: AGHT+IHRD+38FsVVAVic53Rz5CkPtzKvHEEX2oVr0Q1+xhHUVdJvPskNHrjZtZFwLXTBmP2gSYxjVw==
X-Received: by 2002:a05:6808:4494:b0:3e9:1750:426d with SMTP id
 5614622812f47-3eccbf5450bmr1837358b6e.13.1734529393451; 
 Wed, 18 Dec 2024 05:43:13 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 14/24] migration: Use device_class_set_props_n
Date: Wed, 18 Dec 2024 07:42:41 -0600
Message-ID: <20241218134251.4724-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Export the migration_properties array size from options.c;
use that to feed device_class_set_props_n.  We must remove
DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/options.h   | 1 +
 migration/migration.c | 3 ++-
 migration/options.c   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index a360f93a44..762be4e641 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -21,6 +21,7 @@
 /* migration properties */
 
 extern const Property migration_properties[];
+extern const size_t migration_properties_count;
 
 /* capabilities */
 
diff --git a/migration/migration.c b/migration/migration.c
index 6b3b85d31e..d23d392685 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3822,7 +3822,8 @@ static void migration_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
-    (device_class_set_props)(dc, migration_properties);
+    device_class_set_props_n(dc, migration_properties,
+                             migration_properties_count);
 }
 
 static void migration_instance_finalize(Object *obj)
diff --git a/migration/options.c b/migration/options.c
index 24cc8471aa..70ff56535a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -196,8 +196,8 @@ const Property migration_properties[] = {
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
-    DEFINE_PROP_END_OF_LIST(),
 };
+const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
 bool migrate_auto_converge(void)
 {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A4CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF3m-0007uz-Pr; Tue, 21 Oct 2025 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBF30-0007AI-86
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBF2v-00022F-W8
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3711019f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761063429; x=1761668229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQHZGVkXScDOywlPnjbG70NN9Z/4NfeK+CobS7BN7zk=;
 b=gZm3uC/7VNOwMdfeEKsgQ2vEwcuUAsT+4XqUWEP9EDzbEI8PvFvwI9OkDiAv3pYVhh
 RSdXS5xvIjJ5C7tuWX9rpOrlABk3m11ykOFk2ntACHj9dyvnDBrO4x/6kcr8lV9uRM2U
 uRUjFvma+uNVLxX0WWpNWWOeUdRuOQjrRRgtD2bZUvA9mge+24oaIBliKyxZJ0RraPwo
 whvLnFAbz7+eyMAbFfJ/vZ31Tk94OMeExbEGI7VvGYhkOPS/wCG7j0bP+BBg2u2RK9z4
 oNxH7bhFJAr4z4CSpGuV5UWHtolxAqNCddosG1gbqq/cuKf6XYvB0wz2oJVoQpjqBopX
 IExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063429; x=1761668229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQHZGVkXScDOywlPnjbG70NN9Z/4NfeK+CobS7BN7zk=;
 b=lAU8joX9GDUG17y80fGiwIGZmzti8hJ+bIP5OgDX2X2/IdZNTa4QU/6YQ4oxnu/C6u
 aaEqtTnge7H/f3RSUy3CaIq1K8PIDkwA98mWwsC/uTK73097Q7mjmEzsUNxVcZUqpNtJ
 T6wCKCDmD7irRsrR15bgOB28Bssq4ZLUgHCtGS89kBZjpby8y4r6VWT+bVdqfohQ5W3q
 58zbdixNQyGlLhaySVuF+CrlWB8UqMhquP5jOuBf8AbQ4804tGBogvBKL6sp0tw9YgbQ
 Ax0wdjAG6zpiAFhekMPJTapHKPIBtLq7EcPMW4FG0XtTpINVBBSOTzDhRTwvfpciKIch
 KMFQ==
X-Gm-Message-State: AOJu0YwD/hfnkYumWBTfM+LumuOH398eirTc6nBBVtkidVJG8aOfQhwl
 mxz95dAwJmJdwWLeWWW8uLpaxZxpHoBFmHRC2J6l8fdQHhCoDVYhaTSPKj+AyXyxY+Lpi4/KePH
 3Qa2Qpmo=
X-Gm-Gg: ASbGncvuCSfZMVCvkSn4lBpMT9PxdEm2XOsqCO8MBvOSlSN5gzkybjlynQ4cKhagY14
 FpWm83Y8bkFJCTeYP7qRsYfZiWNX9sKoZ4VFopQ8KIakdPDZcbLwHQ5krt9gWsIQ3F9fnNxDfLN
 5QyFKcHh3BFZRKbAkdSWGMY/GFajDylBO1HKR0g2Z1Xxcp/r2SUy1iWueIbAOG584yZtONlW6C9
 zjUS6nlWrssSjzbAw8wPli+9BQZqhQmkPH7QYIzSkGkxwv8VWD67KX6USedwFrkpNt3nwqykcT5
 reIf5oy1oIgkpAEXxhWSbTZnLgGSVPu3ByBuaf3tdZE8JIBBqk76zMqdwDnjwu6NH7lrH4cWn/N
 PNtQYeLGmnXoCU0Z6Gs4rr9DGJz2Enrr/pXndYoe0+U0JvvopoPMpotr9MoqoDKxhLwrBvXT/nz
 1j85rYQVrhmfqporTeeW1N7VWmllc5fv75XmqHwVlZ9umypuTX3A==
X-Google-Smtp-Source: AGHT+IH+gv6M6PS/ZQBSj7bZjViU43YNua0cYr6F2LCAK08xZBTH74CgwsKa7hqKd5fgUA14vTrl8Q==
X-Received: by 2002:a05:6000:2f86:b0:428:4058:5351 with SMTP id
 ffacd0b85a97d-428405853bemr7765604f8f.53.1761063429221; 
 Tue, 21 Oct 2025 09:17:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c56sm21295267f8f.18.2025.10.21.09.17.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 09:17:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
Date: Tue, 21 Oct 2025 18:17:07 +0200
Message-ID: <20251021161707.8324-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Inline vfio_arch_wants_loading_config_after_iter() and
replace the compile time check of the TARGET_ARM definition
by a runtime call to target_base_arm().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Supersedes: <20251020222315.68963-1-philmd@linaro.org>
Based-on: <20251020220941.65269-1-philmd@linaro.org>
https://lore.kernel.org/qemu-devel/20251020221508.67413-5-philmd@linaro.org/
---
 hw/vfio/vfio-helpers.h      |  2 --
 hw/vfio/helpers.c           | 17 -----------------
 hw/vfio/migration-multifd.c | 12 +++++++++++-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index ce317580800..54a327ffbc0 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -32,6 +32,4 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
-bool vfio_arch_wants_loading_config_after_iter(void);
-
 #endif /* HW_VFIO_VFIO_HELPERS_H */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 23d13e5db5f..9a5f6215455 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -209,20 +209,3 @@ retry:
 
     return info;
 }
-
-bool vfio_arch_wants_loading_config_after_iter(void)
-{
-    /*
-     * Starting the config load only after all iterables were loaded (during
-     * non-iterables loading phase) is required for ARM64 due to this platform
-     * VFIO dependency on interrupt controller being loaded first.
-     *
-     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
-     * the right place in VFIO migration").
-     */
-#if defined(TARGET_ARM)
-    return true;
-#else
-    return false;
-#endif
-}
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e4785031a73..b0eea0de678 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "qemu/thread.h"
 #include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
@@ -44,7 +45,16 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
     }
 
     assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
-    return vfio_arch_wants_loading_config_after_iter();
+
+    /*
+     * Starting the config load only after all iterables were loaded (during
+     * non-iterables loading phase) is required for ARM64 due to this platform
+     * VFIO dependency on interrupt controller being loaded first.
+     *
+     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
+     * the right place in VFIO migration").
+     */
+    return target_base_arm();
 }
 
 /* type safety */
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F08D2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 04:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS6TO-0001cg-Bp; Sat, 06 Dec 2025 23:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5XF-0002vB-A2
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:10 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5XD-0002V2-RA
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:09 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7c66822dd6dso2864113b3a.0
 for <qemu-devel@nongnu.org>; Sat, 06 Dec 2025 19:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765078440; x=1765683240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7GAq65ALZiNekqSL+tWMcLPurYu/ToQPTuazfohejU=;
 b=XExwoL2bUodm/KVVocRHND8dtxbUNz4CTo9oC9H9+OnyKzyzRhdxwWwCp7bFoa5ok9
 yuxcBuns+4SOShIxHasBMvhKa3z5bAh/RLsT+bWU7/qRWMxbryAWDKAso0UZMJN4A6Fd
 IA5pvDjhlV6Bmdk6Q35fWXs5n5VBkOYAhnoUtJW1fa+dBFvcosibjEE/14MH2yVLgcfm
 SAC2MnFwROKqUbfIibMfim37Ngxn0YZOSg4JnENWx/vSGSsI2WzMl23ebQi/+DJ4/g+5
 ZkW/oE8eDSLfmSqXQ2jhaDC8zg6+Uj2K+lknz5vTMmC2s0a9ctXqTIrPqoIk8pzcZELk
 kebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765078440; x=1765683240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7GAq65ALZiNekqSL+tWMcLPurYu/ToQPTuazfohejU=;
 b=uVN+MieeP4Brjomt5flj1W8sONS/kIhv1BudQpEN1C6Jb8Eiwe5BpQ6LRA+dys3/Ht
 zchPdlMrt55Q3uCjLXBBhUVOGXqq/ctfm2KNhVq4xfIn6ParvPaUn114TvLjCusit+hK
 qPmucZtPUysUp0B+8q+hpPePiXpqZ3lME1GuxhFu/7KAOygv/rBhU9lrqZ+ZzpFqA7MU
 +X0cIK1xvYmVK4Q5DR9JftqLmqe3nXMzqTTbqjXUSWEkkd8JXvoLlK1OmF2tcKv3K5dC
 SsYHcHPrkivcKy6XtDVQfmv6Tm0sUgVMhZNnJmTcKgSrNemSqAXgz5Ak7ARTH8XjQk0n
 fUOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyxPqd4dHxrflqTa0vjwyJKRzHntwUJzSmEh1bKtQ6ypn+ThvHqwMekLzJCBw4NPeEZhfVGYPvb3Bs@nongnu.org
X-Gm-Message-State: AOJu0YzWuJK93RXFuz181NxMlqP7PvQTnPyo+QxKWriMyP1380f+KyKM
 b0M6SzPSpQv3worZO1C/gNLD3c20V+k+9W9ftClYk2ZN1uh3zNDRZjQa
X-Gm-Gg: ASbGncuhiYCOud2GEF+nuLRZhwVLD82QZuYP54qDp4WYDhLjJaNZJpZxBI5m0zunKo7
 LNPsoSAmCvBHvNlVyi+/yFrEDpg6YoPlAnZ0otUqCaZmuoijFWmlW4Ac6uktEuyV+4pWIxhIjWN
 PTa4rJYzS6ABtHwYMDw6i+VfIzaTKHaO4PPduriy+Wv12YP6SX+mR6ImIueH71VkHDqyjhSDoRi
 /hPv9eStettPZyhJOVVCjsAhIuCMsyboGddSS7ib22PHOVJsfkCZokGh9EDIrhF6r0dY8/F0dMO
 z5I3VgKQafCKGPIUemVI+hfpZbh+mJz9NycvQEmIWr/RKIS7Upu/v6hjSa7IIToEjcy8biaTfBC
 616EdjcAFxEkLRciitCefAtfBPlNqBD4zazvBWgmkkcf8BbXJQVWpGiGkAhnZrtBXh+yLcbGIYL
 /ZcReSxmGjNVUG1s3MHGQ4n6LZf2DP1694RDCWmAsOewnQpA==
X-Google-Smtp-Source: AGHT+IEMK4FwfiNE8kVKS6xJzAqj8hag2Nxs8wAx3qBd4ELvbUbobC30vgtbjXKA+Mvb59QCehGXBw==
X-Received: by 2002:a05:6a20:3950:b0:35f:4e9d:d280 with SMTP id
 adf61e73a8af0-36403343f9dmr12510286637.19.1765078440469; 
 Sat, 06 Dec 2025 19:34:00 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf6a1caeea7sm8496390a12.24.2025.12.06.19.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 19:33:59 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 chenmiao <chenmiao@openatom.club>
Subject: [PATCH v3 3/4] rust/hw/core: Provide some interfaces for the GPIO
 device
Date: Sun,  7 Dec 2025 03:33:30 +0000
Message-ID: <69e22b6002d411a8edee3f589c568ce8217c2f37.1765077679.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765077679.git.chenmiao@openatom.club>
References: <cover.1765077679.git.chenmiao@openatom.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Dec 2025 23:34:12 -0500
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

From: chenmiao <chenmiao@openatom.club>

In qdev.rs, we implemented the init_gpio_out_named function, which corresponds
to the C function qdev_init_gpio_out_named. We also refactored the
init_gpio_out function to reuse the init_gpio_out_named interface.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
---
 rust/hw/core/src/qdev.rs | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index c3097a284d..28da94dd0a 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -17,7 +17,7 @@
 
 pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out_named, ResettableClass},
     irq::InterruptSource,
 };
 
@@ -399,11 +399,22 @@ fn do_init_gpio_in(
     }
 
     fn init_gpio_out(&self, pins: &[InterruptSource]) {
+        self.init_gpio_out_named(pins, "unnamed-gpio-out", pins.len());
+    }
+
+    fn init_gpio_out_named(&self, pins: &[InterruptSource], name: &str, n: usize) {
+        let c_name = if name.is_empty() {
+            CString::new("unnamed-gpio-out").unwrap()
+        } else {
+            CString::new(name).unwrap()
+        };
+
         unsafe {
-            qdev_init_gpio_out(
+            qdev_init_gpio_out_named(
                 self.upcast().as_mut_ptr(),
                 InterruptSource::slice_as_ptr(pins),
-                pins.len() as c_int,
+                c_name.as_ptr(),
+                n as c_int,
             );
         }
     }
-- 
2.43.0



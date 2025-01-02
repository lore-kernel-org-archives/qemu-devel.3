Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F112BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMsx-0007YE-IL; Thu, 02 Jan 2025 10:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsk-0007Us-6n
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsc-0006VG-0o
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso121002215e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830776; x=1736435576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SedjiUgYQYU6AzbLGFtcjZEu6+G941iL/2CKfBNylU4=;
 b=QYuWcKjUgvQsnL9CYxPmVP4sBXfViWf56rCj/EdVf1xtxV6eCW9AN1mcK8MCJQ+gAR
 0xrIpvy74gJC6AdwVEO4ghxHXaHPU4UQgI2K1HItDx7YrWbGlJnFYAAC6pOvGfkav9qh
 Cl2fdeX8E3dpY39OXtYEtI39fm0yN3OUdkeTPaYoQxd9fT+niL97METHZHbBQFvrqpJs
 ShQTe9CCmOmMvIHJx1IJcHobYRBPcyVR5FarOO5v9R+8QwTTjFCh/LYRuCJPs+f8zMFA
 kQc7Sdv5zi9IilqIUn7d2o5EA2TTBdBpa2duM3c8rpicTVg64fyA5XhLDVZyOoY6HAKy
 rjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830776; x=1736435576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SedjiUgYQYU6AzbLGFtcjZEu6+G941iL/2CKfBNylU4=;
 b=bxk5eOvPsbD1+FKaF3gtlJoJpMUOG1PFXJBbBkq8sNsqYPRdDbEZ+JXikhmW4LU0E6
 91iViuHRIatonDpeeGaR3JoyjX8r3Z/pEiUCmzVNcT4mEQopTAbuqSXG6dZPZc8o+hOW
 Mrmk2iTpph4Gx6Dy+71DTE8g5xNNugKucaShSDvCrhNpkfdFM/H0zjY1RkVHe1j8yAPW
 JFbwkM9tH4784o7/IZ0V70mSJmYidJbSkQo34zLiKTxin/HNReDfsNa7kItffEfRqn6E
 O9wMVc/rntTeL6CUTEYsiKaf6j3Ug7B/cobclp9a179rKAG8kKKXA5b1QEuMWAm0NOt6
 OeOQ==
X-Gm-Message-State: AOJu0Yzl79cLWXRFeTSQSq/rhXgVqJnsM+6mQanzyDKGC1VnhwUTlVOs
 V+X6OdH60rdMulE4UyqCcfmG/egBUozThRP2fLSB9fEuuyAvxQFtKg+5f9I984WBopzokGoZsoT
 bSDg7ig==
X-Gm-Gg: ASbGncurs+0rKslHeOiHCTo1r/79neJzqINxSOaXLwR9EvdY0MkC2f1piwHr2kZ03qm
 rPMfi98nHhNBdCoefegWOhcADlHE/gXOUQuu6iZ6QwTgRhvmJq5oLsZvdmOAsYSEDChcKKShu8K
 3MpdIZIesRJ/6isvnYgCJWz+H9xlGog8DJGPFALMwbrUQoHx9rTKTPpQdaivXuEvyJhyZCC3H0R
 +P98DMLX8bjQ77FnZgHfvTQKavk4S7lF3WesScjkWIOeb39fAk+aP3TsSlMm4lnh9RqpEcWfBN2
 hJB25Nfq21ROL25y9+w+Nu+BBTGC0QE=
X-Google-Smtp-Source: AGHT+IGMtiY6Ms2cFmI5jQBbQ24EHWqBvymRMusjx9mCgcSOw9SBgpMh69aXrZfp4SUjc9wYuc14GQ==
X-Received: by 2002:a05:600c:4748:b0:434:f804:a9b0 with SMTP id
 5b1f17b1804b1-43668b78818mr372590985e9.29.1735830776258; 
 Thu, 02 Jan 2025 07:12:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4d7sm454232475e9.34.2025.01.02.07.12.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:12:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/10] qdev: Implement qemu_create_machine() for user
 emulation
Date: Thu,  2 Jan 2025 16:12:36 +0100
Message-ID: <20250102151244.59357-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

To satisfy QOM containers design, implement qemu_create_machine()
for user emulation, creating a 'fake' machine.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-user-stubs.c | 11 +++++++++++
 hw/core/meson.build       |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 hw/core/qdev-user-stubs.c

diff --git a/hw/core/qdev-user-stubs.c b/hw/core/qdev-user-stubs.c
new file mode 100644
index 00000000000..9d481a61dbf
--- /dev/null
+++ b/hw/core/qdev-user-stubs.c
@@ -0,0 +1,11 @@
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+
+void qemu_create_machine(QDict *qdict)
+{
+    Object *fake_machine_obj;
+
+    fake_machine_obj = object_property_add_new_container(object_get_root(),
+                                                         "machine");
+    object_property_add_new_container(fake_machine_obj, "unattached");
+}
diff --git a/hw/core/meson.build b/hw/core/meson.build
index ce9dfa3f4bf..0f020fed1df 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -46,3 +46,4 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
+user_ss.add(files('qdev-user-stubs.c'))
-- 
2.47.1



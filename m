Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ED1C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRvd-0003eU-AF; Thu, 30 Jan 2025 05:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvb-0003eF-BK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:43 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRvZ-0002ZQ-Op
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:37:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so6065765e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233460; x=1738838260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crB/f7vCa5hLa4LpwRk/HholuVWafRL1UUnQ0YPYia4=;
 b=wr9nErhY7z2lW5KuessTZCKeJZpJCQ06JsUWEz3Jxp7RusfDERjavprgE/RW6ARFTA
 9EVL3xVBukaAVJ1P4uo6zcAqNSLV5TjksY+F6V5A+C4VHP3elZAMoMt1uwckfWH6XsSt
 xaKJfUU85Qk2FrISiIbf8sK7qWjEvOoOsIycMVJlqYouN63GKGJdnYy07r+HiJ6GF2oO
 FvHZmamOsZmJN9Jwyj8LF8U2dkqoUTHhdF1Vn9hjpVmBTtmouu0/8CHW5rXZzHNx939E
 JxAb6vbizoZ3OmCrjStc+xBijXWhbDPU4JPDz5ZwrlRJPh0oGc2g+QZGXI/RD8SG81G1
 xEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233460; x=1738838260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crB/f7vCa5hLa4LpwRk/HholuVWafRL1UUnQ0YPYia4=;
 b=qrd9v+tXKGj0bUNWSbYKgnyHxlRco3LqgqVHO5acRzYFmA9teII1ehUc5Eg5AEKK1N
 SPJHrSqEOhQb2oUnagDbdo88zopui7X6EM7eiq1HFxsTBgEe92my9FVGPEsqLaj8KALP
 lwrJKLip/XiXqokoMu9mwdYT1Z1Tpy9y8DbvHu36ErEpHa2IRLVUHw8l6b+hrZ24ji0S
 piF9u0coqsFNVJUYs6NckwKYOE6HO54ELv6ghjsntyJuALV7Xs0VoXB1nWqd5w4w96lg
 Vgcf7aVntncprE91E6Bj+fLNlcbSOaNtCRhwumMDPL0c71+dSkx4k1NcMEaocinaaDdl
 kbXw==
X-Gm-Message-State: AOJu0Yz4VwSeHJfeyC4hQZKX5jbp2KD8uj4wz8YJx9VHX9Q7sdHhQHlS
 O1igWGuzbVVBg1SiEQ5xlBHO/t9aDrlZC5xQWgiDOJ7x0oG2INdEfndhhqf0UiR9MCLzAV+5ZgZ
 PM70=
X-Gm-Gg: ASbGncs6DwEvULKQ24AFmM/bFQtJ2HlLPQAhxPaATVeZup0Rwm3NacyvJZ/Yx91xWTA
 Ruk8WhBpiJq0XoKQ/bCmN/R7HmYlSuHrzS1HoJf5CKxBGCF3S00hF34NlgHkMQ44i7eQeBg6bnd
 8FdakvVF1UOcLPAtWQaqskcqZrLmziswe2w7bv2kP/zclMy0rOp6FyFOhf7o3WkADoy62Re2epR
 6fnHBjAAhIFWkANMI7aXJzD1hZxuXxOG7vnKLE8D/PyeTZsgqrP+xwN4xCWNvL2CRXaSy7hRdQK
 3ZT+qzRU9HEuTIEbrHLZbgyCbS7u4qI6Z2RUV14FnxCAWIafNsyx3bsF4iYiUfe+NA==
X-Google-Smtp-Source: AGHT+IF1gLQHPAIuuIgyNdXKa7cL163sNFjn/3xyiZz/AIADfj2BGfFziESdqjtD8ZX3WUVzbzP+cQ==
X-Received: by 2002:a05:600c:190e:b0:438:d9ae:337b with SMTP id
 5b1f17b1804b1-438dc3ca414mr59396625e9.17.1738233459802; 
 Thu, 30 Jan 2025 02:37:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d7aa296esm56173275e9.1.2025.01.30.02.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 02:37:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, xen-devel@lists.xenproject.org,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] tests/qtest: Make qtest_has_accel() generic
Date: Thu, 30 Jan 2025 11:37:28 +0100
Message-ID: <20250130103728.536-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130103728.536-1-philmd@linaro.org>
References: <20250130103728.536-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since commit b14a0b7469f ("accel: Use QOM classes for accel types")
accelerators are registered as QOM objects. Use QOM as a generic
API to query for available accelerators. This is in particular
useful to query hardware accelerators such HFV, Xen or WHPX which
otherwise have their definitions poisoned in "exec/poison.h".

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7e9366ad6d5..a55ac57ff7e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -30,6 +30,7 @@
 
 #include "libqtest.h"
 #include "libqmp.h"
+#include "qemu/accel.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
@@ -1030,13 +1031,10 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
 
 bool qtest_has_accel(const char *accel_name)
 {
-    if (g_str_equal(accel_name, "tcg")) {
-#if defined(CONFIG_TCG)
-        return true;
-#else
-        return false;
-#endif
-    } else if (g_str_equal(accel_name, "kvm")) {
+    static QList *list;
+    g_autofree char *accel_type = NULL;
+
+    if (g_str_equal(accel_name, "kvm")) {
         int i;
         const char *arch = qtest_get_arch();
         const char *targets[] = { CONFIG_KVM_TARGETS };
@@ -1048,11 +1046,12 @@ bool qtest_has_accel(const char *accel_name)
                 }
             }
         }
-    } else {
-        /* not implemented */
-        g_assert_not_reached();
+        return false;
     }
-    return false;
+
+    accel_type = g_strconcat(accel_name, ACCEL_CLASS_SUFFIX, NULL);
+
+    return qtest_qom_has_concrete_type("accel", accel_type, &list);
 }
 
 bool qtest_get_irq(QTestState *s, int num)
-- 
2.47.1



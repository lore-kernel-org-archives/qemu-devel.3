Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC38C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treqN-0007Ym-1F; Mon, 10 Mar 2025 11:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treq4-0007Dy-CW
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trepr-00083n-TJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1023888f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619663; x=1742224463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sImUXKvBXnYM+CsDBIniM9RjnRK8G5r/o0WxM6GDvAY=;
 b=XCzhktQ2SbHDdZVmDjOaldo9atLl0GXTI/GXK0LRNYV76aHjRRW5NyKJCySGHHexdh
 9AWsRWTfaMydZsdpSnFdkrmUKYZGmdfL/BpYbKcP25rD+o+K6iEArkGEzzsPAY9r0qIE
 nvGBwvhsfeYzaBpZ3SHe4SvCItVYmU8Ft7pFXOspGxnmN6OpwtEWdsCTg8VAkAxgjeek
 QsVvmJ+7Y0F8QJu1L64040qbhgI2c+Cw2NcNIJMneAc0q8L6DAudsTNDbNrtOl7BglM8
 OxGltMwgonzkBUskr/fAdeSOpLpFpVnjZCm5wVhjGwlbMh4xX2lt7yWQ44o5Z5Q8CFr7
 YLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619663; x=1742224463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sImUXKvBXnYM+CsDBIniM9RjnRK8G5r/o0WxM6GDvAY=;
 b=d/9RJJKa9DukBLKmEgmjWnsnCMNivc6Qi8fAjPJsusml9kyf+0Iq1DGdPgrr1RZN7B
 s4vyvmhE1X62wmwnn5I/ogdrMbKTW6N/yIyirl0u+XhU8QPS73Gc647MUBINRL7DpXrI
 vuCfXdIXSn22J5eT8nKJ6QkeJWlEZru+IcwsBrEJaRJUhziDlUpkBSiKijbcvW0HvxVd
 4fET5mhmQQrg096WU5ZOSLa0L96aMGdM7gyraoibZoJBPVaJMaRIHVYtBtTWB4TnJWre
 KE2Jtc2jeo+In99XUkjUGSrtg5ioeKa2uGahdsPaTzfL+anwLn3OOUGPcOY/2bUfLLfj
 USqA==
X-Gm-Message-State: AOJu0YxpUqI2aFiUkTf5YzHkP0rywIYHdJfDlq2jkZqshrD1GE8bmBJp
 vUrgRhM6aChUC6J3CBmhWWq2SyaMR8McvLH3ukqyRDF5EI9ULYW6Wd+w/Rgt9D2kalWbnTU758z
 lwNE=
X-Gm-Gg: ASbGnctY5txC34mG8Ec/ihZGHAeUOCL6i8b+swN6rtvVdEnXvPqhBUgI47kQwjI/ep7
 L/ssxW/IlhfWyyMUmIGoe0kJ8PXT98Vhvv6BUv7/MdpzEr10OPW+jzMtoNQIN3LxVDj+GOn8mlB
 x4yjfnS7fqxdtLSB/Hh0W//aBdOclui/Iijoqa4TR4o2HpiDgTLzLxRiySR5MW/R3wdw+IQJtsQ
 4b5TmZOyXPxTqeMJ3MWZ2L7+IpRE0PfY/ZF9RKm/kYAHos8Ma/XK3NlWPusC5pe8aZg1ZEPO46q
 vnlUc4eYTn7k3Nb7/jsxgLtozKDVSfGT4cWq4dJ82T6sJie8dh6Tqpx0mu+iCXn4xiXc8oFRXXB
 jVQkDfQxkLQI/WBsT/mc=
X-Google-Smtp-Source: AGHT+IFxYz8EXqxp8drd5ZiYlRr9cZz/0WweD1TtcVB0TxR6fCC0KjkVLV1otsdGV4pgQ+8Xt8wkqA==
X-Received: by 2002:a5d:5f8f:0:b0:38d:d0ca:fbad with SMTP id
 ffacd0b85a97d-39132d1f8b7mr9176876f8f.14.1741619663264; 
 Mon, 10 Mar 2025 08:14:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfd5082ccsm19268625e9.32.2025.03.10.08.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 08:14:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 1/4] hw/s390x/skeys: Declare QOM types using DEFINE_TYPES()
 macro
Date: Mon, 10 Mar 2025 16:14:11 +0100
Message-ID: <20250310151414.11550-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310151414.11550-1-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-skeys.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 811d892122b..d50e71b927a 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -316,14 +316,6 @@ static void qemu_s390_skeys_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo qemu_s390_skeys_info = {
-    .name          = TYPE_QEMU_S390_SKEYS,
-    .parent        = TYPE_S390_SKEYS,
-    .instance_size = sizeof(QEMUS390SKeysState),
-    .class_init    = qemu_s390_skeys_class_init,
-    .class_size    = sizeof(S390SKeysClass),
-};
-
 static void s390_storage_keys_save(QEMUFile *f, void *opaque)
 {
     S390SKeysState *ss = S390_SKEYS(opaque);
@@ -481,19 +473,22 @@ static void s390_skeys_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo s390_skeys_info = {
-    .name          = TYPE_S390_SKEYS,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(S390SKeysState),
-    .class_init    = s390_skeys_class_init,
-    .class_size    = sizeof(S390SKeysClass),
-    .abstract = true,
+static const TypeInfo s390_skeys_types[] = {
+    {
+        .name           = TYPE_S390_SKEYS,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(S390SKeysState),
+        .class_init     = s390_skeys_class_init,
+        .class_size     = sizeof(S390SKeysClass),
+        .abstract       = true,
+    },
+    {
+        .name           = TYPE_QEMU_S390_SKEYS,
+        .parent         = TYPE_S390_SKEYS,
+        .instance_size  = sizeof(QEMUS390SKeysState),
+        .class_init     = qemu_s390_skeys_class_init,
+        .class_size     = sizeof(S390SKeysClass),
+    },
 };
 
-static void qemu_s390_skeys_register_types(void)
-{
-    type_register_static(&s390_skeys_info);
-    type_register_static(&qemu_s390_skeys_info);
-}
-
-type_init(qemu_s390_skeys_register_types)
+DEFINE_TYPES(s390_skeys_types)
-- 
2.47.1



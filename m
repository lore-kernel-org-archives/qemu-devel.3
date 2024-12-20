Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C879E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfff-0005ok-KB; Fri, 20 Dec 2024 11:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffe-0005oE-AC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffc-0006cJ-Ky
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:09 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1618388f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711367; x=1735316167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQRaAxonstRNg+zJNWvBOScLNgnEhfzST5TP3my+hhE=;
 b=i9BU1xqm4WPFYftFAkMABmV0FxJuCa/pd+88XY7Xy1JrmY88Qq1ZKWa3XWUwAIuRvP
 4Q18njdwG+HMNQSq8gaZ8rfehpDIA5z2qbSWBiJIqKHutNl9ftYBuGIhznMzotbu4nnT
 FEEx9jXr71mywDnQVSTMQAWkZ9yfVLNZgYvhPlEmI5iK/qR6s6rcoflnuGfBAiM8+96H
 WNcGxeic1MN4RuJutX9LCI3bgSLr02UVE1mgowXGwL1oXCLEZjI6XpS46ZbImendXjez
 Hwe3mb0L1Xru0MI8zQCEW8U3C901qhEgJhd7Ng98co9jHIz523yBwMtuYxF2cUkpXsfO
 Tgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711367; x=1735316167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQRaAxonstRNg+zJNWvBOScLNgnEhfzST5TP3my+hhE=;
 b=HZmBX2pLMACjandpxx40HeTnjynVu/j/qb+/lPvF6n/6KxlM6d2Ngh0y/GgPhfhD5u
 PDeso04XA0EZLezVOp+NkdigJhSeWX/eSVtpt8h/SOuSoPIHy0iPI7RdEq4bf0XNK0SQ
 BDaJazGCSLjiq9ScDWqYrGPHeyWY6KmTB29rOL0r4PlNzgY0RzaF6VtYupyEiNkDHKQ5
 8mcDl5VWJdJv5i3Kuae0NZmJtAe4WqjOiPDo1VEgY/kfShuAwP+jLSj7ybGExfMgpGzp
 3+DK6PLHyQh3AhrSSuGnJrG2RuwYWi1uoPCV9DArGFf5WHt+2ibVp2aWzKMKZPwFNvhP
 /7qw==
X-Gm-Message-State: AOJu0YwahqYYM4o60aWcoZAgZTWym1NiRowlOLcOgYQvPyzYPMjvDRSQ
 1swYp6klbfMncFDXhdXAsCcX/BOtJm3GXxJlcT3SK7bSU7mJHbcHaulyjHeE54TuZn2eVa8gaKC
 K
X-Gm-Gg: ASbGncufSPNHurBs+XC8dSwM0y0FAH/8ffzj5v8iGX6fQDGvdKCv/gXQITwcylJ2TlX
 9BD59taBisT/RuTpfWRyKyWcJB2PgQ/lHC+j9S4GHCutKt+cddi2B3x+T7iyBHCYX1H6elGRKio
 pjUQ6NPxw2L26GbLjDM8Re4SldxATu1fJiRShSoAQtgFbHuIXTde1/CRbd1h3SVbgJjPp6C/a0p
 ukor6AeSAsOabCKjq2Jjaql+MajKs3wTSC1oj+gcZyvcKLprm36VQNXealrPipeeefO86AGynk=
X-Google-Smtp-Source: AGHT+IFIL8mrL3rA9rOVwpl7/tAwN8DtbL0XKtxkhL7KkWwFEEEkjg1vTXyr/HIHdXvvXQeGbs0n0Q==
X-Received: by 2002:a5d:5e09:0:b0:385:f16d:48b4 with SMTP id
 ffacd0b85a97d-38a223f7510mr4128347f8f.40.1734711366904; 
 Fri, 20 Dec 2024 08:16:06 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6d02sm85408715e9.1.2024.12.20.08.16.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/59] qom: Add TYPE_CONTAINER macro
Date: Fri, 20 Dec 2024 17:14:54 +0100
Message-ID: <20241220161551.89317-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Peter Xu <peterx@redhat.com>

Provide a macro for the container type across QEMU source tree, rather than
hard code it every time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-2-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 1 +
 hw/arm/stellaris.c   | 2 +-
 qom/container.c      | 4 ++--
 qom/object.c         | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index a201c9712a1..de02e16817c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -26,6 +26,7 @@ typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
 
 #define TYPE_OBJECT "object"
+#define TYPE_CONTAINER "container"
 
 typedef struct ObjectProperty ObjectProperty;
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7fc13d96c9b..e31884b23e9 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1053,7 +1053,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
-    soc_container = object_new("container");
+    soc_container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(ms), "soc", soc_container);
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
diff --git a/qom/container.c b/qom/container.c
index 455e8410c66..cfec92a9447 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 
 static const TypeInfo container_info = {
-    .name          = "container",
+    .name          = TYPE_CONTAINER,
     .parent        = TYPE_OBJECT,
 };
 
@@ -37,7 +37,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new("container");
+            child = object_new(TYPE_CONTAINER);
             object_property_add_child(obj, parts[i], child);
             object_unref(child);
         }
diff --git a/qom/object.c b/qom/object.c
index c7660f9a097..c9f8442b136 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1734,7 +1734,7 @@ Object *object_get_root(void)
     static Object *root;
 
     if (!root) {
-        root = object_new("container");
+        root = object_new(TYPE_CONTAINER);
     }
 
     return root;
@@ -1750,7 +1750,7 @@ Object *object_get_internal_root(void)
     static Object *internal_root;
 
     if (!internal_root) {
-        internal_root = object_new("container");
+        internal_root = object_new(TYPE_CONTAINER);
     }
 
     return internal_root;
-- 
2.47.1



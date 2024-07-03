Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AF3C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwZW-0004H2-4z; Wed, 03 Jul 2024 05:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZU-0004GO-41
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:40 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOwZS-0003el-Hm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:46:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb1c918860so1766425ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719999995; x=1720604795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMzjbrD5jj50KPQ4550DmY4pJFHnqB7zUHTL7YZsoEU=;
 b=ATJyiv3oJNP7KCY3Q5uMtImbqw+4XGPoOc/PM8fQErQ+M9S+90qDuRA+tMvUK1BVoE
 5QEJqbu+qt4n4HFx8ZWmRuKip0/bvA3YfSrD6+F93OFQi2gWhss5TqZSCt3stUYyt10F
 Vn0eoEDqaIZfYvDYsmsvb9w/+ZXQByW3okSA+bghMIXLNX0v8teFkd481eT8+2Uwaz5N
 8fyvU3009iWdRO/uyxJRXStYV0C8amEMm6/x4uXt1vT4HnIQ4bW7lkJvnlx87Jp69rpb
 boxuCtBNvhYFkg7INhBXyA9MslXb/OHasiJMt0FHB8xylwtSl5g8ZVedZDowhziE+9Jq
 4aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999995; x=1720604795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMzjbrD5jj50KPQ4550DmY4pJFHnqB7zUHTL7YZsoEU=;
 b=xPQnioAowXAf5OsM2U+GCaC28U31n6Rt0PEm5GJ9PCsIhr2UNljOyGqdliLF5w577q
 9JjDqrGEv7CFeCQzloXXthILkvCBn9YoP2+ByNf/KLylOzz7QFQUojMJGstmq7J8WnHQ
 NWAH0AA9BHubso5o5yUSgeSbJy4/wVTUgmv5nBBbEPq6TqZyA67YAOBqg3w0gVKONEgv
 NvACrkfYLJBROtAZ9tXbhOHDVIdRW6PNnWAkaKlUMbWkHoUaB452JKVOHp7c11toqpQu
 YWIwsO7V1cNwnGYot90idVAtoAP+aU0sLAdYoAiMHSfIDG9pVjLqZw9VyKRk/1+pSsBn
 kvQw==
X-Gm-Message-State: AOJu0YwkjeZBQhLLkDvbZDSMKbLXwxx9QTSCovhHhehN5eAk/EqVPKos
 3vLRaQgNW/S6Y0PYlF5cU0kh1ZqJ09Vdbn/3JdLcEdT/ac5HQrWmB5qQe1SJzUTbZBCZLALjNlY
 /
X-Google-Smtp-Source: AGHT+IHu5Iwcx1rpzty0nDjAWyHgVTVwFD1hM4n7HM8stpVecr/stO77C8njUl0q2qWf4OzFUErAEQ==
X-Received: by 2002:a17:90b:1992:b0:2c8:2236:e2c3 with SMTP id
 98e67ed59e1d1-2c97ad5d94dmr1981622a91.17.1719999995165; 
 Wed, 03 Jul 2024 02:46:35 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3bc5a1sm10278621a91.36.2024.07.03.02.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:46:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] qdev: change qdev_prop_set_globals() to use Object*
Date: Wed,  3 Jul 2024 06:46:25 -0300
Message-ID: <20240703094626.1704990-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
References: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

Next patch will add Accel globals support and will use
qdev_prop_set_globals().

At this moment this function is hardwired to be used with DeviceState.
dev->hotplugged is checked to determine if object_apply_global_props()
will receive a NULL or an &error_fatal errp.

Change qdev_prop_set_globals() to receive an Object and an errp. The
logic using dev->hotplugged is moved to the caller, device_post_init().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/core/qdev-properties.c    | 5 ++---
 hw/core/qdev.c               | 2 +-
 include/hw/qdev-properties.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574d..4867d7dd9e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -920,10 +920,9 @@ int qdev_prop_check_globals(void)
     return ret;
 }
 
-void qdev_prop_set_globals(DeviceState *dev)
+void qdev_prop_set_globals(Object *obj, Error **errp)
 {
-    object_apply_global_props(OBJECT(dev), global_props(),
-                              dev->hotplugged ? NULL : &error_fatal);
+    object_apply_global_props(obj, global_props(), errp);
 }
 
 /* --- 64bit unsigned int 'size' type --- */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57d..923f9ca74c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
      * precedence.
      */
     object_apply_compat_props(obj);
-    qdev_prop_set_globals(DEVICE(obj));
+    qdev_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &error_fatal);
 }
 
 /* Unlink device from bus and free the structure.  */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e..a1737bf4d8 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -210,7 +210,7 @@ void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
                                             const char *name);
 int qdev_prop_check_globals(void);
-void qdev_prop_set_globals(DeviceState *dev);
+void qdev_prop_set_globals(Object *obj, Error **errp);
 void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     const char *name, const char *value);
 
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3EAE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxz-0004YQ-FS; Thu, 19 Dec 2024 03:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxy-0004Y7-6u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxw-00058E-OU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRUx0ihRVJNBkx25RdEddlnJRXUqJCkYhNyCELXxXGg=;
 b=K6tsfJU5cMclqrbt4IwP4EmSHJmhf4PmERqK1n22xT0Nd4q4gJThbZUCEI11vrajL+3DvM
 8N60lElS8EIG7J/pBqeEkbqpz+s3KvwGBdsJASWGOrZYSps0Hb5p9g/Juizc1j8vLv4Ni+
 uVOLGe8Mts7gYLKZkKum5juKHx2NalA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-TA4oGsRnO-m8vnCNBxDY_g-1; Thu, 19 Dec 2024 03:32:59 -0500
X-MC-Unique: TA4oGsRnO-m8vnCNBxDY_g-1
X-Mimecast-MFC-AGG-ID: TA4oGsRnO-m8vnCNBxDY_g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43635895374so8047905e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597177; x=1735201977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRUx0ihRVJNBkx25RdEddlnJRXUqJCkYhNyCELXxXGg=;
 b=aVNVZXbfYZtQEaJ6H9mck4T2mEcxb+F15jwIDPFwg1eQkC9/pHRRtZPrvRqTGtjME0
 q6SD/FVnpFRCVlT2HvtDs+GAbYs/oDrlnYGh6V0vqUF0YcS7jQxIE9iAGIjCCnOdnrMN
 oaiEPJQzMX84PA4g0la8Kv4Ltu4mab/9YK6ReSgfbEag84QcUpfpwxPicePuXCxc5MdM
 FfqHAWR3YOvaL7K3VWHKUA0bB6fM+/x37Wfx/WucjjbQ5isLaQl6gmCVhy4UJb0K4Eul
 DoA+9D9zwpw1hO+FS9xz03gZoxfAPphAdymplH/f7LX+KeaNDYkV86xsI9+aBVzR2ogx
 +n4Q==
X-Gm-Message-State: AOJu0Yzmbby2xxaC7anytgo5exbIbQAtGb8sLhL+k6D63CcRhV9mFg/M
 v3GuTab7SzMzcljN7Y1/D/rvLC4LkW5ii0B3xm9fTW2K/dW6tcAT71DgvnlwuaxVQht94i90zFB
 ZvBmc5gb5PvqfSsaca0Cyqv7W9Vt0+Qpd/yE/UlrWare1n7Hrn+1dp2ARS4QVSQssI3ZEa1MFXT
 hm+GISmw8HhceAPdGE9JnlPArPoMhpZ7JYqloU
X-Gm-Gg: ASbGncvzFZUDv7NamuBXvWqCIJPVxyS3gIUbylUm9fkls4GmOtsG8IxXv12ErRhUCiK
 q4kzIr7QF4ZOgBqGi/ojScXuOMqkvvadfmvBhRTElxruh00CnXSL20IgZj0klA0OFb/389iX78L
 fD1ZW14k0RTzkrsbhoAGigLbdEYxdnHNil/JCkcZKO5SfQ9Zrsvv6sU0+VkbenKY93+ZbUU3cy0
 zynTTxbWHUqfOsJGuKwdrTskHrsEIyNOl4CrtVqQPOV/Pfjjqk4KH/sXnZP
X-Received: by 2002:a05:6000:1a85:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38a1a20497fmr1844545f8f.11.1734597176903; 
 Thu, 19 Dec 2024 00:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtngBPPfg14UQsoMZ5uPMt/AMHpdSGsKHQkQGeKh2ZeglvOoSJmI59/+Vbg/oFOq2hosBb5g==
X-Received: by 2002:a05:6000:1a85:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38a1a20497fmr1844507f8f.11.1734597176462; 
 Thu, 19 Dec 2024 00:32:56 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm992373f8f.84.2024.12.19.00.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/41] migration: Use device_class_set_props_n
Date: Thu, 19 Dec 2024 09:32:01 +0100
Message-ID: <20241219083228.363430-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Export the migration_properties array size from options.c;
use that to feed device_class_set_props_n.  We must remove
DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-15-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/options.h   | 1 +
 migration/migration.c | 3 ++-
 migration/options.c   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index a360f93a44f..762be4e641a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -21,6 +21,7 @@
 /* migration properties */
 
 extern const Property migration_properties[];
+extern const size_t migration_properties_count;
 
 /* capabilities */
 
diff --git a/migration/migration.c b/migration/migration.c
index 6b3b85d31e5..d23d392685e 100644
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
index 24cc8471aa0..70ff56535a2 100644
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
2.47.1



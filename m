Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A64FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyem-0008Gy-0F; Thu, 06 Feb 2025 04:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfyek-0008Gp-6h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:58:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfyei-0006IB-4K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738835922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JGRL1wIcRLgVQYu6ppXJozW9sLfu2j1bpGZjXaqriK4=;
 b=DAhQ6tOr6kFDwsRKso6ib2zss4QVMh6CV6DfshfWlEc8gjEUZaglJpevx93D7V+EmteJkS
 00U4nwW4aE+ElCN2A+ZkHq/OBPM9t8dNJuGIt/YDhgL2ZQDQlmq6dPOsfxuWsA6ErFwh1H
 nN0tcBvacAN98o8Ksl4qZc4m3zWJQro=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-JFX1Rc-uPpuOe_zNqWC-4w-1; Thu, 06 Feb 2025 04:58:41 -0500
X-MC-Unique: JFX1Rc-uPpuOe_zNqWC-4w-1
X-Mimecast-MFC-AGG-ID: JFX1Rc-uPpuOe_zNqWC-4w
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab77e03f2c0so14212866b.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835919; x=1739440719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGRL1wIcRLgVQYu6ppXJozW9sLfu2j1bpGZjXaqriK4=;
 b=q4RCdsoBZidPV20tXA3Zmw8qTuDPmER1d/Gcvyzso1jzclC9F4VX1CI8iqQ44jW/Gj
 QX+BwEi3GRmWN93Im+ZXqL37euv4JzO9SfB1RC8zPT4C8Q6IufHiGYipdQ0qJnOSksky
 +rUGGTDJA28hETLUcs4NBEX5wge3RBwJ9A8YclX3BuTj+TowW1SmwJdSxCuS7I/DctR4
 1fOxDAtr/jzD5bx2JV8uzprkYQB0LO6mBtIapFFShfrOr5WYenqtCszARMtVFLkLM4kD
 Gkdw78pbhX7dNYSMqepU3nmyzDuiEpu7/eaVteUv//BhugCdVAnn6ur/dr9MIKK8al6o
 pUtw==
X-Gm-Message-State: AOJu0Yw/40KgQHScojfJpfJsEiR67RVQBIhuiUnDWb+gIw57FQUlKJTK
 pX7IXYQKCjOw8MLcmyWg8Y4iJ1IHSrYtklZ8zR3s5erSaEo+Ph+x2KDUQKvJ75ucJ3W3t7qgnfQ
 04wcQwtA9+H3AQSsXoEeBPulMOSiZ4flhwdVWdqp+0pWy02tfuDf9Pq2fRVRHmygLF7x7a1Wx/X
 IERxPg0Go4UQV5FAEJs/RK5uALWLdesPRUg8uHYjQ=
X-Gm-Gg: ASbGncsi4JPAocegxtzWOA+vNxa0xJJp4/zEsymGFe7aHez0mMsLaVAh3Ird354jUXg
 m+OJfiS8g9n3XmeTFTg0uQibwFPY1j0nTgZsOXksKBXBHx135FDKnomropyVdHKTxZrsL8q1r90
 B6PnSFKrfqTIaNrOUomETpyORuJ6eFcgKbID8ZqgGtGDihhBSQ9APoVW1yl/MsqoQgD+xeG0EtM
 6oqXRPGkPcKrcxf/Ln2ztPbM25AVSbxC4Ez/UYEHaNMLslzSbdUp6SnQW76qYBjGb2Hvd/0Xh80
 3YpfuQ==
X-Received: by 2002:a17:906:d542:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab75e21fd4bmr630200766b.11.1738835918729; 
 Thu, 06 Feb 2025 01:58:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGzIIVWcn7cjZwj6VOTn2fzz/e5TpcNNzhnB+/EQMQVf7HO9owT+Aw+RJqDt9ckycgikFjwA==
X-Received: by 2002:a17:906:d542:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab75e21fd4bmr630198166b.11.1738835918252; 
 Thu, 06 Feb 2025 01:58:38 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f8bbbfsm73680766b.74.2025.02.06.01.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:58:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH v2] qom: reverse order of instance_post_init calls
Date: Thu,  6 Feb 2025 10:58:36 +0100
Message-ID: <20250206095836.2120918-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, the instance_post_init calls are performed from the leaf
class and all the way up to Object.  This is incorrect because the
leaf class cannot observe property values applied by the superclasses;
for example, a compat property will be set on a device *after*
the class's post_init callback has run.

In particular this makes it impossible for implementations of
accel_cpu_instance_init() to operate based on the actual values of
the properties, though it seems that cxl_dsp_instance_post_init and
rp_instance_post_init might have similar issues.

Follow instead the same order as instance_init, starting with Object
and running the child class's instance_post_init after the parent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 3 ++-
 qom/object.c         | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..c87a392259d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -445,7 +445,8 @@ struct Object
  *   class will have already been initialized so the type is only responsible
  *   for initializing its own members.
  * @instance_post_init: This function is called to finish initialization of
- *   an object, after all @instance_init functions were called.
+ *   an object, after all @instance_init functions were called, as well as
+ *   @instance_post_init functions for the parent classes.
  * @instance_finalize: This function is called during object destruction.  This
  *   is called before the parent @instance_finalize function has been called.
  *   An object should only free the members that are unique to its type in this
diff --git a/qom/object.c b/qom/object.c
index ec447f14a78..9b03da22cce 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -431,13 +431,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
 
 static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 {
-    if (ti->instance_post_init) {
-        ti->instance_post_init(obj);
-    }
-
     if (type_has_parent(ti)) {
         object_post_init_with_type(obj, type_get_parent(ti));
     }
+
+    if (ti->instance_post_init) {
+        ti->instance_post_init(obj);
+    }
 }
 
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
-- 
2.48.1



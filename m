Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3774BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Eic-0000RH-Pi; Wed, 01 May 2024 14:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2EiS-0000D4-IT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2EiP-0003Tj-RB
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714588201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i99CNYsghajQWHJEhdMacPJdUnahQLv0d3DWwXJq3R0=;
 b=SOs0gV7wCVzEU7Nhvqp/nivNNyg+beptBnGqjoVCYS7mDN7g45lrfwE9IQSfnHq+gfO8GK
 pML1UAdxjqCcvlARyYo3+DAO6BObnd1Y4Z397cKpKDSOCm3V87I8zzjtpfmgKwBsQlTjnb
 WiAbigA6h5shqyRWbRQIwNG8NjRoRcw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-icrVazhkN16CJldX0Q19WQ-1; Wed,
 01 May 2024 14:29:51 -0400
X-MC-Unique: icrVazhkN16CJldX0Q19WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3DB2380390C;
 Wed,  1 May 2024 18:29:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E603C8C4;
 Wed,  1 May 2024 18:29:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/14] hw: set deprecation info for all versioned machine types
Date: Wed,  1 May 2024 19:27:55 +0100
Message-ID: <20240501182759.2934195-11-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This calls the MACHINE_VER_DEPRECATION() macro in the definition of
all machine type classes which support versioning. This ensures
that they will automatically get deprecation info set when they
reach the appropriate point in their lifecycle.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c              | 1 +
 hw/m68k/virt.c             | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 include/hw/i386/pc.h       | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 24b104dfa7..e2e10523a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -110,6 +110,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         arm_virt_compat_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index cd6ee692f7..37bb36b385 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -343,6 +343,7 @@ type_init(virt_machine_register_types)
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4ab331da57..7f5412f2ed 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4795,6 +4795,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
         MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__);                        \
         if (latest) {                                                \
             spapr_machine_latest_class_options(mc);                  \
         }                                                            \
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 9324fecdca..289a687434 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -841,6 +841,7 @@ bool css_migration_enabled(void)
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__);                                 \
         if (latest) {                                                         \
             mc->alias = "s390-ccw-virtio";                                    \
             mc->is_default = true;                                            \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 669263dfca..acc17c7dac 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,6 +327,7 @@ extern const size_t pc_compat_2_0_len;
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
     { \
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BFECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2931-0006eC-7e; Fri, 26 Sep 2025 10:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292v-0006Wt-P1
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292l-0004mW-LL
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IWeST0K4wA1sxKfivRbQ89bYlDWZwGSw/0nanXkI7k=;
 b=R/0sRYtnlv/l+Z5rAe5x9LcZZr9EpYTpZ/CTsBhwzgZ6DfHKvVG0oTb2m6ITsuvSKkdq9Y
 LX3fPa4kU+Slhdk5GHKukHdQBYFGNDdydDv9ZiTKIW1bfJxr03hwP8AgxndwkSY6TRuFx+
 mN9zOOS68/ZMzGIb9rFjTboF41CYnYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-Y6eL0tnQMAK_RSoqs_Ttgw-1; Fri,
 26 Sep 2025 10:03:16 -0400
X-MC-Unique: Y6eL0tnQMAK_RSoqs_Ttgw-1
X-Mimecast-MFC-AGG-ID: Y6eL0tnQMAK_RSoqs_Ttgw_1758895394
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C074D1800621; Fri, 26 Sep 2025 14:03:07 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CE82195419F; Fri, 26 Sep 2025 14:03:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 14/32] hw: mark x86, s390, ppc,
 arm versioned machine types as secure
Date: Fri, 26 Sep 2025 15:01:25 +0100
Message-ID: <20250926140144.1998694-15-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The versioned machine types are typically present for use in
virtualization use cases and can be expected to provide a security
barrier. The only exceptions are the m68k versioned machine types
which are only used with TCG.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c              | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 include/hw/i386/pc.h       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..c25ef1c306 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -127,6 +127,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eb22333404..3581f581a4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4748,6 +4748,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("pseries", __VA_ARGS__),       \
         .parent = TYPE_SPAPR_MACHINE,                                \
         .class_init = MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__), \
+        .secure = true,                                              \
     };                                                               \
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d0c6e80cb0..54bc4e1b74 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -896,6 +896,7 @@ static const TypeInfo ccw_machine_info = {
         .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
         .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .secure = true,                                                       \
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1ccb6ed9fc..f576b3892e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -353,6 +353,7 @@ extern const size_t pc_compat_2_6_len;
         .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+        .secure     = true, \
     }; \
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
-- 
2.50.1



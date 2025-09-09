Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EAFCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1fo-0006WG-Rh; Tue, 09 Sep 2025 12:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fc-0006Oi-3o
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fV-0007ds-Pz
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43GjTmBiduG3qjxsUo/YeHs+pbqePCg/U9qzDj68t18=;
 b=iLQHUjWMee9Fnxft63Bir/4YbTFPMnJBlM2UR18S3crgsJBnanFpeiVFmaRJF8v+ckfNPr
 7RVrNUeEWOv38bRGvW6ws2qAMLHXWoak8IPqCgqgwjYLd3uGrcOUgOZ+1MpgCiB5CZNr8P
 BUK2KsdJqd775DlkfxdW0Hz27Gvj8bQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-S2S_sLC6M7ayPFbrb0Czwg-1; Tue,
 09 Sep 2025 12:58:02 -0400
X-MC-Unique: S2S_sLC6M7ayPFbrb0Czwg-1
X-Mimecast-MFC-AGG-ID: S2S_sLC6M7ayPFbrb0Czwg_1757437082
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3671195608B; Tue,  9 Sep 2025 16:58:01 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CF891800447; Tue,  9 Sep 2025 16:57:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/15] hw: mark x86, s390, ppc,
 arm versioned machine types as secure
Date: Tue,  9 Sep 2025 17:57:22 +0100
Message-ID: <20250909165726.3814465-12-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index e5c4142e82..f54c3c22fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -128,6 +128,7 @@ static void arm_virt_compat_set(MachineClass *mc)
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
index e83157ab35..7c31bf1444 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -342,6 +342,7 @@ extern const size_t pc_compat_2_6_len;
         .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+        .secure     = true, \
     }; \
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
-- 
2.50.1



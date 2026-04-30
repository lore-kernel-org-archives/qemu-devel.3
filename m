Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88420CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITt1-0003o2-GK; Thu, 30 Apr 2026 12:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrb-0008Hb-TG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrZ-0007Hg-UM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYssZ2jX6kV2gh+5VY85dXxJGS2UBMoRMWXKR4lB6jo=;
 b=Pp62dvrpfYByZxPuu80Lm1nSR0Cox/lo3WVAhM33xMFlGclnoE1I1uRueY/bMskx4oLJ0k
 +qY305kwYolCG8fAHng76nI33pZSjNppcKSaGXXh0m6OQytptECCwKid5WhLIl82vQSLnW
 O3l8CVSx8PsyHuNJr4t1mRub15dANC8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-_MP2ON3jPWOWjxPI6_imyw-1; Thu,
 30 Apr 2026 12:03:37 -0400
X-MC-Unique: _MP2ON3jPWOWjxPI6_imyw-1
X-Mimecast-MFC-AGG-ID: _MP2ON3jPWOWjxPI6_imyw_1777565016
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F59B19560AB; Thu, 30 Apr 2026 16:03:36 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97D041800446; Thu, 30 Apr 2026 16:03:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jaehoon Kim <jhkim@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 10/11] hw/s390x/ccw: Disable legacy virtio-pci by default
 (v11.1+)
Date: Thu, 30 Apr 2026 18:03:06 +0200
Message-ID: <20260430160307.634093-11-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jaehoon Kim <jhkim@linux.ibm.com>

On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
zPCI implementation (commit cd24834130ac "s390/pci: base support"),
making I/O BARs unusable.

However, when virtio-pci devices operate in transitional mode, QEMU
unconditionally exposes the legacy interface via BAR0. This results in
firmware warnings during PCI enumeration, such as:

  pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size

even though BAR0 is never usable on the s390 kernel.

Close this gap by disabling legacy virtio-pci support starting from
machine version 11.1. This effectively makes virtio-pci devices
non-transitional and prevents the creation of the unusable legacy I/O
BAR.

This introduces s390x-specific global compatibility properties that
set disable-legacy=on as the default for virtio-pci devices. Machine
versions v11.0 and earlier set disable-legacy=off to maintain their
original default behavior (legacy support enabled), ensuring VMs
created with those versions continue to work identically.

Users can override the default on the command line if needed:
  - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
  - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260420144759.2970726-2-jhkim@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cc768daeb04c..4d35f9b10bcc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -788,6 +788,21 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+ /*
+  * S390x-specific global compatibility properties.
+  *
+  * On the s390 kernel, legacy virtio-pci is not usable because I/O BARs
+  * are not supported (IO_SPACE_LIMIT is 0), and would only result in
+  * unusable BARs and firmware warnings.
+  *
+  * Therefore, starting from v11.1, disable legacy virtio-pci by default,
+  * while older machine types keep legacy behavior for compatibility.
+  */
+static GlobalProperty hw_compat_s390x[] = {
+    { TYPE_VIRTIO_PCI, "disable-legacy", "on", .optional = true},
+};
+static const size_t hw_compat_s390x_len = G_N_ELEMENTS(hw_compat_s390x);
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -878,6 +893,9 @@ static const TypeInfo ccw_machine_info = {
         const void *data)                                                     \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
+        /* Apply global s390x-wide default properties */                      \
+        compat_props_add(mc->compat_props, hw_compat_s390x,                   \
+                         hw_compat_s390x_len);                                \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
@@ -923,7 +941,15 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    /*
+     * Preserve v11.0 and older version behavior:
+     * keep legacy virtio-pci enabled.
+     */
+    static GlobalProperty compat[] = {
+        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
+    };
     ccw_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
 DEFINE_CCW_MACHINE(11, 0);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4011C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrk0-0003gb-Pj; Mon, 22 Jul 2024 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjN-0000Yl-HS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjL-0006bM-95
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EjSpN6QaR0ZZqxOK/bmYl/C0IZbF2wTX5yhHiNZlgP8=;
 b=ABQdCamxuS1JF3ip1ROHHO7FCRBww+5STOxmz5JUJb6uRsOf9Se9zgiBzm8xk8RUWO8zGg
 GkfkRgdmA8lj64ZQxtV7jl+PBjNMsO2ED9lh/ys8f1/EI0VDEUh3urT419Rs7B8SE0gDr+
 OLzM67ozDzKMacC3FLIuK/HQHTnspKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-jZqpIsknN0qTDOYbtXSbXQ-1; Mon,
 22 Jul 2024 08:01:22 -0400
X-MC-Unique: jZqpIsknN0qTDOYbtXSbXQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 310851955D4D; Mon, 22 Jul 2024 12:01:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69F231955DD0; Mon, 22 Jul 2024 12:00:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw: Fix crash that happens when introspecting scsi-block
 on older machine types
Date: Mon, 22 Jul 2024 14:00:23 +0200
Message-ID: <20240722120026.675449-10-thuth@redhat.com>
In-Reply-To: <20240722120026.675449-1-thuth@redhat.com>
References: <20240722120026.675449-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"make check SPEED=slow" is currently failing the device-introspect-test on
older machine types since introspecting "scsi-block" is causing an abort:

 $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio
 QEMU 9.0.50 monitor - type 'help' for more information
 (qemu) device_add scsi-block,help
 Unexpected error in object_property_find_err() at
 ../../devel/qemu/qom/object.c:1357:
 can't apply global scsi-disk-base.migrate-emulated-scsi-request=false:
 Property 'scsi-block.migrate-emulated-scsi-request' not found
 Aborted (core dumped)

The problem is that the compat code tries to change the
"migrate-emulated-scsi-request" property for all devices that are
derived from "scsi-block", but the property has only been added
to "scsi-hd" and "scsi-cd" via the DEFINE_SCSI_DISK_PROPERTIES macro.

Thus let's fix the problem by only changing the property on the devices
that really have this property.

Fixes: b4912afa5f ("scsi-disk: Fix crash for VM configured with USB CDROM after live migration")
Message-ID: <20240703090904.909720-1-thuth@redhat.com>
Acked-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bc38cad7f2..8a878f84d7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,8 @@
 
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
-    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
+    { "scsi-hd", "migrate-emulated-scsi-request", "false" },
+    { "scsi-cd", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
     {"sd-card", "spec_version", "2" },
-- 
2.45.2



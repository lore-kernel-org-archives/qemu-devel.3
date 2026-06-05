Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1ADCD8C83
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkR-0006l4-1c; Fri, 05 Jun 2026 11:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkA-0006BK-AP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWk8-0006Vr-G0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vs+pOjW26KjxQCHZrQ+kCzdjFkWO5ZRcdNEGFNTZkO4=;
 b=CQby+UNq423ZQj/BSKHvpAdYW1ENXyeA3l3qt/4jR7MyIJtU7Jg9nhbdMo0VXwwEu9/2en
 DSrLzVyARLRaw5o5Jl53dTI7aFj6DceMa6Pr2IOxPkMwyU8pkaswELMPMc1kKUnO/BCzjt
 8LV88fOLi3SoyQetsvzsN2s+4N2OzQE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-JKEX8Pf1NEqZbirYFSfTng-1; Fri,
 05 Jun 2026 11:45:54 -0400
X-MC-Unique: JKEX8Pf1NEqZbirYFSfTng-1
X-Mimecast-MFC-AGG-ID: JKEX8Pf1NEqZbirYFSfTng_1780674353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A758418005A9
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83C391800480; Fri,  5 Jun 2026 15:45:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:36 +0400
Subject: [GIT PULL 16/23] hw/i386/pc: free pcspk on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-16-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GcZTfkVfLUK9g6SdJBjC2sL2vzj7syFt54aMh0Kvqn4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VZ2F7yyVeXQPuIrwA8KgSkSvbSsiVy0BjL
 S3ObJJPnfWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5X7qD/4iKA2F8Q4ZK8kyng4a3FXcZLNGgapwLy+kl4r5x0xtEMc1Cc5ktwFSqG5zoiWYmTeV1L/
 ETVRSGUUYL7raP9XAOweXSK44RDb2poBRZKDKzBT/iCT8d3xSfS4/ezZ4WwzWrUHTg7mfkAx3xr
 EkckDt9RiXTzVmyzx4lDC9x3YgyBeYGDrmJSjsPi/1zw196M+n1wZNwDWR49UH21ajfKo/6GTB1
 Ky1vuLdJ4XK40cs6B8JIsxKWul3puS7aiJTXSVfsQliF2gpzLuf0iQG5zwpLOEnf21TEjK7LG3B
 sVIb7WOdtz5UYLYRGY7Obtge/hWiBqltIzS7qMCOZIMLXEN070gofBAtPLA3Zokr2rzZGVp+yLL
 CrgWM/00/AZgY2qzpfxhP0KqG5WCNc2Ll0tjhbAKWCyQ/Um4ZVclx4x09LpsR4gj5MNq5fA0bGK
 gTDjNefzr9hY6ox+rHS3ocVYbfAQ+yQc0EOlljTzNQkRjEm0I27jfP1Qm6LBrCEZm6lpYq8uRuH
 Ym/V9f0V6ST715QT2J929J7Dm52tnd0QKhsrQUbhnfDZ3I/TxMB22JGP+TaQ+KF3al4rs/DnKRY
 Sff9O7Hh4FR7Gv7JELIwVnGFAVCUkkgrIi+Utwxcv/TwNL/8bXJv4yIOz2L0b0evDHhyJ3EWSi8
 gcZT1p5DBShQ+kg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add pc_machine_finalize() to unref the pcspk device when it was never
realized. Once realized, the bus owns it and no action is needed.

Fixes: 6b8d1416482f ("audio: create pcspk device early")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503f..7b6ad97e5a9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1610,6 +1610,15 @@ static void pc_machine_initfn(Object *obj)
     }
 }
 
+static void pc_machine_finalize(Object *obj)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    if (pcms->pcspk && !qdev_is_realized(DEVICE(pcms->pcspk))) {
+        object_unref(OBJECT(pcms->pcspk));
+    }
+}
+
 static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
@@ -1748,6 +1757,7 @@ static const TypeInfo pc_machine_info = {
     .abstract = true,
     .instance_size = sizeof(PCMachineState),
     .instance_init = pc_machine_initfn,
+    .instance_finalize = pc_machine_finalize,
     .class_size = sizeof(PCMachineClass),
     .class_init = pc_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {

-- 
2.54.0



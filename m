Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9006CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraY-0007Y2-Ko; Mon, 04 May 2026 07:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraX-0007XT-TP
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraW-0000ny-Kd
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRg2XEz7g/q9Y9vnBcCYZpcSu3GsBjF6YOxJNwlUUiA=;
 b=adKFshqNToisbAbMGvgAiTxgCOIPJ4PbZbhbUM4tH7C69Ys36UpFMr0aG4UelWogAB5hny
 oRsFvQPfh2pYoBxpNJ6ab79YuqAyJiLL4XUeT/by8eHcb+6s03njmBx+8MQ5U/BFAPVWLM
 gQQpMV9bHdVpQz8fDeKVU2cMTB+G5ms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-VbhkPFRcMu2o00hZ1s_NJg-1; Mon,
 04 May 2026 07:35:44 -0400
X-MC-Unique: VbhkPFRcMu2o00hZ1s_NJg-1
X-Mimecast-MFC-AGG-ID: VbhkPFRcMu2o00hZ1s_NJg_1777894544
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC2C4195608F
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24ED1800347; Mon,  4 May 2026 11:35:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:53 +0400
Subject: [PATCH v2 05/46] hw/pci-host/q35: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-5-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/fxZ1GAbhmt7eqzcBY0CxzgAhlT5phl8zL1KjrOh2so=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsFAEBdR6ZsQVMihkZL7NzJXuLVMS1oXf5G
 vcsV3wnZhaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5R77EACX8Tc21I9tc2XKTsnuryt3fSgO5EZKCd3wBC52QaydTFdj/MDT39BiJeyaPOa4ZAC/I1C
 rxQwUjN9gsR21ZhOpR9OHSUAc0sYQIrxzZqzic0v6We2DPx713dUFwOl1TVyHoWZ1UvCiTM2jLh
 HhHUExuB+P3Xw18ASWxHQG7AT5HO3aakoQqLXhzdb5STf4I1CkzIKfE7/q64hye6DlgSCXAwdcP
 kv2gmilbvixcMQ2/w74A4DDalwL9cLmZkIErw+MAEIkcQG1/kD0xVFmbch+AeePnhByZiwg4lJt
 4dy3YEIqo29bk+T5/bxKKTB6S6CAPGEQBTgzmrGAqocr/G9BO/Psthhbhf1usgNLvpkm4zXOAsx
 CInIfLGbZSgBvgDpUxR5n38nDOpJpuvpuPifF9vgXc5535ARc5OZXnydYuQ1VSb/rmLPAgHub40
 4WPsURpdsFtYxohNDjT3/eDtZ1Xt9XIISBbPBnfxCrZP/rVJxcVtO2hlGpaKbzCosxrLSp0Tp8f
 of9Ia1Yk6Cy1Y4eKCorK0v8GZHQHWlS+7E/s6+4O87pJ+bh3W9yC9coOSADkiCSqsyvJOfVazWZ
 pTZMqipZLC6KLWJqcWwLIlpoKmKInrEL/uMBGMLhH6pdfxqJpWj3kvl/PtOK+gOigN5nmV7EyPk
 9neNP5linPspiBg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When called on an unrealized Q35 host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both the
pci_hole64_start and pci_hole64_end getters.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/q35.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b37..355e81bfa20 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -132,8 +132,14 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     visit_type_uint64(v, name, &hole64_start, errp);
 }
 
@@ -149,10 +155,15 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    uint64_t hole64_start;
     Range w64;
     uint64_t value, hole64_end;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);

-- 
2.54.0



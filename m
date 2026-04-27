Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E936FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtz-0001hk-Mz; Mon, 27 Apr 2026 15:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRty-0001a0-1N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtv-00008n-Tg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2PkMqAC5vaH2G5gTELChNOqj8Q/G8/EbVxLibW6cbY=;
 b=NxjvNPvctK0kk/qPwmKQcJdlz/WKoAi6fFeu6KjE8A5+/4I7MwtnsIgPyM0dOolM7/jxRI
 3s7Ey8IXqRX2p2sFjn44r0H+SshgeIAB/BUlw6E6PTpzz1aYbGR+TN0oFSQ4B/mRb0u01Z
 CgYnzqJXcXbdZofa0DjDa93Z3jLZmgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-_eoWI6QNPJ-W5oCIJLgS-g-1; Mon,
 27 Apr 2026 15:45:49 -0400
X-MC-Unique: _eoWI6QNPJ-W5oCIJLgS-g-1
X-Mimecast-MFC-AGG-ID: _eoWI6QNPJ-W5oCIJLgS-g_1777319145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8302A195608E; Mon, 27 Apr 2026 19:45:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA00330078C0; Mon, 27 Apr 2026 19:45:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:32 +0400
Subject: [PATCH 33/41] hw/arm/sbsa-ref: free unrealized flash devices on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-33-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8wpYSEdYwoIU5tUZLybA2hUuHMnCp+KlNmMB/+ET4dQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wV06CFj7hU2c0ZsBhZ0KcgP4PY3RTTUXEPN
 bRTQukYYHqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5eBIEACXMPEDc3nHnUDB7r7nxHaJQV7rnZW20f4A9ijvHe1etzhDlhofGT9nPrC9rOpd1x1ZbI0
 /82NqaELAEkcGEsU7U8xj7AYdKjPeoJG4/On99rxa3gtAptqfo84oHPEqV/PLmef1ghkA6rMDvQ
 t5wZWe2taCU3Xztf/bgENfdp7xq1meGpXdCzvT2dNC8800yc4n903es+6DJiL1H8jJBrKQoJ/SY
 sa26dFWazW4YkDx2pgCLtdJWt3aiK0LyVN9zlsLlHhKKV4kBLHQURLxJ1i10/oUMGLOTuEUkg0W
 uv9loq7oSH25EGtvVMSfFGIaVi+5zB0iL2lD7OW3am56GOT5y3yEaPt3Yh3QK9ExvNnMf26wT6b
 M0KsLYQqc3sZImyvd/VaN7uj2XXtOd3k7A52kUjr6aA1duMo/LddkHqIPTlXT3qZ5azcXPkynZc
 kb3zaSfiKnZlI0nNS7x9GmnWG4DKiHNHmUaR9g38u5Y1kzQgnn7ZvvyeU9CJJW08F2Jf8OUgI9X
 Ht7+Vp18PFksUIc37C2YJ4iTCJldw2WIIHMHNWkZE+f9g57DCzOpuVMqHn0EtQGJQLOVhxvKmNC
 zdkE2e72gujIwCbvubhl+oW+paYXtWNQSy9uYt/CNPjbizGkSzn3XA9R+lxTLLK2MuPFYK0nDGu
 dRo/021qlK179eg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Flash devices are created with qdev_new() in instance_init and added as
children, but the initial reference from qdev_new() is only dropped by
sysbus_realize_and_unref() during machine init. When the machine object
is destroyed before realization (e.g. during qtest device introspection),
the flash devices leak.

Fixes: e9fdf453240e ("hw/arm: Add arm SBSA reference machine, devices part")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/sbsa-ref.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 52c35e10c2d..484b90053e8 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -892,6 +892,17 @@ static void sbsa_ref_instance_init(Object *obj)
     sbsa_flash_create(sms);
 }
 
+static void sbsa_ref_instance_finalize(Object *obj)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(sms->flash); i++) {
+        if (sms->flash[i] && !qdev_is_realized(DEVICE(sms->flash[i]))) {
+            object_unref(OBJECT(sms->flash[i]));
+        }
+    }
+}
+
 static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -930,6 +941,7 @@ static const TypeInfo sbsa_ref_info = {
     .name          = TYPE_SBSA_MACHINE,
     .parent        = TYPE_MACHINE,
     .instance_init = sbsa_ref_instance_init,
+    .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
     .interfaces    = aarch64_machine_interfaces,

-- 
2.53.0



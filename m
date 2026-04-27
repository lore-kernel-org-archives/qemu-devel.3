Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF5DFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtV-0006KE-9f; Mon, 27 Apr 2026 15:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtP-0005ic-Te
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtO-0008JZ-E1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVTOEc0IiI6uSpSRFYv4vHJMS6ES4xPhZF55+W0yW6Q=;
 b=I7JsGtKRs+ugn4y+UHR3ROniHx2u6An60LNANDNP49Ejj/RE6Gzq+L5oTfw/H7vM6YlHKb
 uvsewnYRr6NuKMUI2TZiJuG8BxdmUJPsTD8kFpt8bdjtcuWS7/8GROSMUvKhr4//0wRg+E
 nC1RJbOODHSqmjWnGxf5//OuQU+SvKs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-_XWIiMtdN8Civ23OQsMPyw-1; Mon,
 27 Apr 2026 15:45:15 -0400
X-MC-Unique: _XWIiMtdN8Civ23OQsMPyw-1
X-Mimecast-MFC-AGG-ID: _XWIiMtdN8Civ23OQsMPyw_1777319114
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06718195605E; Mon, 27 Apr 2026 19:45:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC874195608E; Mon, 27 Apr 2026 19:45:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:27 +0400
Subject: [PATCH 28/41] hw/i386/pc: free pcspk on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-28-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MMJi309YeIRVDxOCPmIe2ejVLAl8h+a+IJoTKniQZdE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVLJBf9rSI+B0oe3XCCh6vD74yXpagfvXIO
 cVXYf8T3NWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5VN3EACwyykIpeyhUnQ0CYMUrtu+T+pAzyxXXo4QYTpGGiZZllZlHuZTSIWQRhGDTE17uvZxobF
 KrAcHSUj9b7A0fPyyNQ2bxdwfY/5SvQve2xuz8hyUaDlABO2tROfnRp6KO7YJYoVhN2HXRndFyk
 W4nMtfU1m9XIE3B38s/DhonuGcgH3Iggj6v76fY1WuO2PW7KKf5Hk9sCcovdE3h4ZrYFOvUXaZC
 61kHemP6UWJlAwHUFBt1R+m9qJlifsuAnORj+zS15sicXdzTxLQi/NEunc/TttYeNSAZcA56unV
 otWvyzxVOgVcWw9dprKc8TiBEMoDpzYgfwA1ekCCDANs0N9TF/hKy91ZYvEG7yjvXe65SrRjKyi
 dhaU9BEc7qunbLKsD6pGaiH1l4KPgBmf2fuZEXsa+FBqFuS+cpoKrLd19OZxWcNcb/5/xKu3VPq
 DjAuJ/j6JldvzzQRpEd5KO8N27pkWtEF5oWi9QfG6za+KFH0VoF7UPWNlapIbec7qHk4UaSl3bT
 7P7whEF4l07S5jkznz1wudVjgEatyHn3imreNjnPxflceyzKFqZt1o/HyK7Nwa10tpQsXywCRR+
 HuY6yHkoB8EQ4EpCCX1Uoqad8I0Z25LFrCmiZ9S/DHeg8tpk+eC7CUd556VZ8v4zWRLzIu/iAeB
 1rU0PMWyJSFgnpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.53.0



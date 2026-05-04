Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59365CD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdm-00013V-Fl; Mon, 04 May 2026 07:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdj-0000xj-Ba
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdh-0001TU-Sp
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjvZTAfOLRLSAwyVKRo9KUHII2BC/gQ7W5YOrQTDwCU=;
 b=fbH3LP53EFjPyh77LlfB1cMAY8d3GBNo4vQdv9EIaxQhJsDhWIX2z/ywcfAmgb5Ay4R8qK
 OZ769dzzSWofhafLspp4HBmKTwZ7wefn6IJwhWWzGfqGPp1FXiXgzVE4mNCW5eDj74jeMX
 46pIUd4uO8W2spg+VMPHuB5exD5UqsE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-EWytoH3JPeqFDMH34i6ugg-1; Mon,
 04 May 2026 07:39:02 -0400
X-MC-Unique: EWytoH3JPeqFDMH34i6ugg-1
X-Mimecast-MFC-AGG-ID: EWytoH3JPeqFDMH34i6ugg_1777894741
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5827B1800579
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD127180058B; Mon,  4 May 2026 11:38:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:27 +0400
Subject: [PATCH v2 39/46] hw/loongarch/virt: free flash devices and OEM
 strings on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-39-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gG7Ydo0sglWNAjrldcyy9F1jHx9Rn6zTspjlf6OHzK0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuUDEVC6J4myYWHD80PIi2OFE2zHlbN8wzX
 NKPsKYbSsqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5c/nEACnNSQ68RlRPRVfkxL7cxy1bvmmcIn5Wz6Nx1TiL446vdfCJ+a+3l69ZrRMhfT4Aj1mkrm
 HD7CUDB4CK5sh9AEMQGFd3fZ/lAyM87Mw8/QDeZK5AVD6hTybHbzvhQ8uTs06MCFQLuiHKfRf5j
 1F0NuZPjy6N8qXUgAIWqxoevQGuMgBETAwGt+cORal8Li0WPv9H5yFwCfV7GTn3qTWuHRgkILjN
 //15W3pUcPDNwMhijzIly2MiHuSIslvzbKkwr+DEXIXprLWcvRNdItegqZGyVp+5fY35MatAiNU
 pJuciWfOfh91nWpuYLL7fd9mWQMO27oY8Bkbk0ZqQwQkckPume1pFCYQ/0ljq9qpRUsmLo3KB4d
 IcTkb3vZYSOnX7/OIgfRq8uew8g70ZR8QIyDcJSUOEc10zLcO1pXMpFEdR+v5bWEOenBtMngmgc
 5PiEaDPMs5+BUNWka3WCgnsUSOnnDGoAUQs3o9h7cnyxpCJRepXcmwMUKuWIdYI3nuSGQ4pfXeJ
 GcQxSDyepFUdOG5a6Pjhm4JFvTBTkW4ZcEqQ+rsJvLJrBo4ovsMRKGKh/uwDSo4U7hWY4P3zwU6
 rZEzJwNjy1W3xamCtsyWfRWVPZ/ZgPBw0/rEAwyhYHTTfy2DMMUvjAPmMPxV+7Fm+vTgXbhBm9q
 lPY3oU6uo3RtFtA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Flash devices created in virt_initfn() via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 445c9c645 ("hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/loongarch/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2fc15261309..188fbc86c0c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1535,6 +1535,19 @@ static void virt_class_init(ObjectClass *oc, const void *data)
                                           "for PCI MMIO");
 }
 
+static void virt_instance_finalize(Object *obj)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(lvms->flash); i++) {
+        if (lvms->flash[i] && !qdev_is_realized(DEVICE(lvms->flash[i]))) {
+            object_unref(OBJECT(lvms->flash[i]));
+        }
+    }
+    g_free(lvms->oem_id);
+    g_free(lvms->oem_table_id);
+}
+
 static const TypeInfo virt_machine_types[] = {
     {
         .name           = TYPE_LOONGARCH_VIRT_MACHINE,
@@ -1542,6 +1555,7 @@ static const TypeInfo virt_machine_types[] = {
         .instance_size  = sizeof(LoongArchVirtMachineState),
         .class_init     = virt_class_init,
         .instance_init  = virt_initfn,
+        .instance_finalize = virt_instance_finalize,
         .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }

-- 
2.54.0



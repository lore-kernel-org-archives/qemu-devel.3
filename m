Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D244FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRu8-0002UZ-Qx; Mon, 27 Apr 2026 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRu6-0002QZ-Vh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRu5-0000B4-F7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KmAH1cH3IHfFz390iyZWiA2Urz4yiNrRXozv9253eI=;
 b=LblhJczXqqc7kXRh4zpZE0KVFyMZ1c+Og7o4/4+LG1BHAwQIO8CEAwUuIgb7U6GOAKQVN0
 G+4a6y7KjOIooGz2oyvwOtgLmjxlzEQ3B/iHwVIMFTjNZX1zHu9BMTNwo1FrlG3JOvDzmM
 QlBKPc38JUqJ05lk+EV4qryhAkD0a8E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-N2PSMl7XO-KlPkVH-a3LGQ-1; Mon,
 27 Apr 2026 15:45:59 -0400
X-MC-Unique: N2PSMl7XO-KlPkVH-a3LGQ-1
X-Mimecast-MFC-AGG-ID: N2PSMl7XO-KlPkVH-a3LGQ_1777319158
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E46FD1800245; Mon, 27 Apr 2026 19:45:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90858300070A; Mon, 27 Apr 2026 19:45:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:34 +0400
Subject: [PATCH 35/41] hw/loongarch/virt: free flash devices and OEM
 strings on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-35-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dxCTCxNaCfORhGdQQtAC7ccm1POGZcOgxYtSD5YETCc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wW+05ardbd/hj7Op+m929pAm4FEmkm9Ust2
 E8ltKtHXE+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5RJjEAC4Ifcaa17MbvTtqopgNgrGGBodzZ4MuMz7lEs19qyQ0UUYrCsD9GZoAmK158d1+dJcqro
 pLB6wS6jjTr7L2yoyLGDox/I4yMg0/4YQr3RLvYx+IDNTA/kQ3V7h3870AOQ5qRXaOfZth0rcC8
 o7TxUwUZ5lqbV+sMsH26AEUPjuRf2ecduQ4inG+K0agz6+I3z3Ry123sQ2rGvUp7YvpAtpNCtxB
 JyCKb6hlcXVx2EDVjZW/lgSBIYqYcDHPKJkadQBudDpYvrtpPdGMX9mlDq/GUdBT4x1TnjLsrmz
 u/Z+1RRtif7fsatjHXpMCB6mx00RnvI8lGnQ9Aeb044XuWu/d9bHDlRUY0oySgGJujeWW8g2a1U
 zkfbdCgAlFV1BZu3f5DQ5KhoaT7inHPWcJ5BPObGv0Sa6EmUlLjVxS0YqItjZx46h/+OgbOU3E2
 dDs2F/zVvfzI5H6KW1mXmgstTcOKE6i9+wiNfGSfr+8MBtv+YbemIOQVa9eA1agvhGxc4XfwsV3
 f4+rt1dP1ORwUmp5L8xV5zmM4Lq1y9iT/El89a+k9cWaI1jbbvW64aRQK2eIiIOHq2b88+EL4sw
 9uAVmCUK1wv7NbiekLXOvNqtqAQmCdNOPLOC2cED4Ok+3Vh0TMYg0BVzFiaEwO0xEnUJoSCq2c/
 aWVqWlWmGnBLplg==
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
2.53.0



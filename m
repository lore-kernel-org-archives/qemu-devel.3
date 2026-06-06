Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E2CD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPO-0004ZP-Ba; Sat, 06 Jun 2026 01:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPM-0004Hm-4o
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPK-0008LD-3l
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChO/3Bdzy1ataNflAM07S9oKMcRpR+opteLb5ymzCsk=;
 b=O9XG8KUKpyveCuk6FvEhb78uKPTYCvTcKbPfXjJOozsLeKjfjNBYKAD424fB1jAXC4+A3T
 tKVb5fBZcbjmgGsxN9ybaWyILeMCwD+Jcwa1jymngXFDT4LapUVr6PoqpM69xF11FtqsRo
 hKvHjhW7xs7Lae/0RBLYbbopRro3oq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-xsvch4XrNEmbde6OQB7ZDw-1; Sat,
 06 Jun 2026 01:17:16 -0400
X-MC-Unique: xsvch4XrNEmbde6OQB7ZDw-1
X-Mimecast-MFC-AGG-ID: xsvch4XrNEmbde6OQB7ZDw_1780723035
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F5341800473
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F286A300022D; Sat,  6 Jun 2026 05:17:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:50 +0400
Subject: [GIT PULL v2 18/23] hw/loongarch/virt: free flash devices and OEM
 strings on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-18-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O20pvfV7LycxXxxIqAxpoTODskHXvK4B1EMEAyeU4tk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1No10PrCy6sKXhKgzydh2xAml12bWBFotl
 4zlAvO2ukWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5c9ID/0a/euTBsHrgDDCZkN701Eaie4oPpf5AWNO40tK7foKO0xNh01Pv11Q8CZdA1dMZS7TPmm
 zRPO87iBx7+x55UROAFC+ki9PiTSkbK3z0s1h6ht0fiB7mSEbkc4qhGQIq7QTX2cGxo/3ao/MLk
 H0qskwZXj8aiCkyeMQyoW62jkKGlnDmAGzyoBC2MtzdCdad2RRgixIJacCAO+HJfMEHqBepbj8U
 G6rWl4Jf37/Isx0aFX4js0pfQokh6s8Ak6mCPfnn2/wuUf3Z1tEmXymhcDg2gzG9x4LCHmBqU6V
 DuFGFKmuYZvG0xx8q3UW2F3i+Pb/+H1+kNoK6rlZEoh28lOPuI5dEtVGXEbbWwjfhbNiMY8J/4s
 3GbusHREhclYwUiWs+ZwS6wCZaCdvnZvFSO81V9oc0XTXfjb+s9PAM56T6Ai+1yiBF58sa9tLEL
 3Wn/MsSeWl1RUyiWD2ap6baR/VRVrQYJLvnOyboILtSI7K5ASsrItBlF46lmzdK7Nd0NJAbGv2n
 BFGVr0zVtYpgjuUzk+lWKrRPUgkebnLUT4jqJM8JbWAhU4hAFogn4uqT5qJN8pEP+o7w67hZTLN
 un+NTf1rJ092zIRq5a0HIub9vkM9jmcabQ8FsmmLukgCz5hxas5RlOmq1r27ZoQmW3jEbF9JbZo
 d9R8gyJHFoytwZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Flash devices created in virt_initfn() via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 445c9c645 ("hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/loongarch/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f68ccdb12b7..6693dea647b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1566,6 +1566,19 @@ static void virt_class_init(ObjectClass *oc, const void *data)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_VERSION(false, major, minor)
 
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
 static const TypeInfo virt_machine_info = {
     .name           = TYPE_LOONGARCH_VIRT_MACHINE,
     .parent         = TYPE_MACHINE,
@@ -1573,6 +1586,7 @@ static const TypeInfo virt_machine_info = {
     .instance_size  = sizeof(LoongArchVirtMachineState),
     .class_init     = virt_class_init,
     .instance_init  = virt_initfn,
+    .instance_finalize = virt_instance_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }

-- 
2.54.0



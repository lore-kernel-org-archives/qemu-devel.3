Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823FC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5Y-00046s-Sd; Fri, 04 Sep 2026 16:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5V-0003fj-86
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5T-0008Io-FM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJp1n1X4kEb9FVyTrLhFfNk3BbvcDbYF/4WsCIfyaaw=;
 b=Jf/KoPM3s2XR/68/257MQOfk+Op3wowkd+9zgkr18lwtn/AmzWHwNDW7PSZEMjeDOscZYk
 TCu1uGffhcmxdeIryRcY0wYXMj6TTG657OTkNsaZ/BSck1bPIvaVgrOdX/AfHFzRAqxiFP
 zLgO3VIlsx0cSh+24dhhQXIBAnQOhJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-peOq2TIdObWWl3AVlu8z9Q-1; Fri,
 04 Sep 2026 16:00:31 -0400
X-MC-Unique: peOq2TIdObWWl3AVlu8z9Q-1
X-Mimecast-MFC-AGG-ID: peOq2TIdObWWl3AVlu8z9Q_1788552030
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BF261893EC1; Fri,  4 Sep 2026 20:00:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9856E1800577; Fri,  4 Sep 2026 20:00:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:22 +0400
Subject: [PATCH v4 39/75] target/i386: fix CPUID version properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-39-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nGSAzw2abdBuzYrCnna+i4/DxV7ssuqypEQwO1YQiCc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKZ/eQ/Ati9HSVR/aZPmQfXwgy0CiehYh09
 70PocVuZY6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5eX4EACYmyesSmt8a0+jPV1Go+Ic4LNmPM9+h/PqEDO+LrvhLtU2AL5n9Ox+WaBMD/dRZcCHwJf
 HEUo1Q/9LGCPzFV7hzMDAyAQPdEy/Z/WZ2QVYR5iBtdeehAHxHihokMBTK2bPdrTEP93iq/7jiT
 tiPevQi45q5C7uJ2ryRYXuJeKT5Hs+hE6ebe8M3Wg9A/5lObN4G6WOe7NQ3Pq/NAkZi9KkiCwCp
 Uh/IMjOk9668VxIBOPl7v3DrQY0J2x7hziZYjbkyYBXOuScoMVVLR7YHb3ZqS8OH1SDoXO6G0h7
 CT0tORJ0NpXz+tyYmbZ6NXjeNJ+GTzivLES7yqf78QPer7gCIMfSX0kFTPsI2arysqX58god60d
 7JbUk2YB3W8XmKVHqcVepZluAXSGwI/kkrOe7uJmCClNGKzH6YI13MVd8VguGvQxwmCAKP9MEbm
 SMrRKI9qwbzuitOK57ir7OTDoNPmIKHY/bfqQ1LzqfLx/l6CjamZaLv9zeYvjGfixdKsOiuMx2+
 teN5mmRdEOoafsG2A2GR2k2xgaTZ3qiatCKld0s733aEHGDQyrJ+msB81MyA3WsNR0X3T9NKQI4
 96VTWofKc47vL4xgbjS8G1PelPT+U3pIcjtd7rESUEGYCaRx6S+y/eXH/tPfCfJiXCqfKOXzkru
 I8Zki0Wz899B/xA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_uint64, not visit_type_int.

Fixes: 3e0dceaf9450 ("i386: Register most CPU properties as class properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7c24eba3e0c3..8650ff6caecc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10950,13 +10950,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
     dc->user_creatable = true;
 
-    object_class_property_add(oc, "family", "int",
+    object_class_property_add(oc, "family", "uint64",
                               x86_cpuid_version_get_family,
                               x86_cpuid_version_set_family, NULL, NULL);
-    object_class_property_add(oc, "model", "int",
+    object_class_property_add(oc, "model", "uint64",
                               x86_cpuid_version_get_model,
                               x86_cpuid_version_set_model, NULL, NULL);
-    object_class_property_add(oc, "stepping", "int",
+    object_class_property_add(oc, "stepping", "uint64",
                               x86_cpuid_version_get_stepping,
                               x86_cpuid_version_set_stepping, NULL, NULL);
     object_class_property_add_str(oc, "vendor",

-- 
2.55.0.543.g5ebe2ebe4ea8



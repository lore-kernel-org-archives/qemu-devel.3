Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F7FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRu5-0002KF-LP; Mon, 27 Apr 2026 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRu3-00029E-M8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRu2-0000AS-7U
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1c8VsTz/sTG4tzp9Faceii6mKYJmoEBKWa3DjmDQEWE=;
 b=Wmd+6lx8wSGw0mmYKzeE7L+VtI15wFRghR01JPd5gtjQo008T2dq1Urqpyd/v12qlDG+6B
 EOTJ1pKE95LCVTJm6nDQ7Xt3dYUrGLa9iGCRluD+Q04lt3yfVivUxOzuQeB251GtCB9iD+
 obuYHJtURkfChUtK5rlOCxQ5uFQ1bHA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-L27mdzMwMXW_UBxAymJhQg-1; Mon,
 27 Apr 2026 15:45:52 -0400
X-MC-Unique: L27mdzMwMXW_UBxAymJhQg-1
X-Mimecast-MFC-AGG-ID: L27mdzMwMXW_UBxAymJhQg_1777319151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80B53180065B; Mon, 27 Apr 2026 19:45:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04833195608E; Mon, 27 Apr 2026 19:45:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:33 +0400
Subject: [PATCH 34/41] hw/arm/virt: free flash devices and OEM strings on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=o92YyJD/bOFOENYE87KlzSXzoL53pQjL+BGFBW2kk0s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wW48UjKTU8KoPx74n2xI5CJTczJW/EUjYlC
 R3ZW1ir2jmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5WoWD/9dw9rvRCWsv0ETBfKlzGEEGcrQO1E77pa4/nW2MaZjxOBMlucGXfhnDoQBBMD4PVg8I9z
 f02jLPGBD6CN8wQcbCkG24hYz42o3oxxu7fb2Vbhklx+U4aH5HnjnTPA7darMNvF6NTynKIdqXQ
 +Fdrs1fbQKScqWWRQ5Lgg/gOH2XFAKMEebv0B+2lN0pbU5/c2ju6CR+IeoL1hjtGfAsjELlTAb3
 J6u5gAIWdWRq3GsyALc3CLeWy+xAUP7q7FYXvETchMa6rkpM7BEIbW7YVnXipqwZEw19bpjrRxE
 xHs4OdrK1Ei1AeavuXn2ZDpSkWw0NVVaoYuAXENLYO74j4DbF9zPAMnXO5iFJ9X43DsaqBZOXZx
 Y6XNAcchBzGg24RQvz9YB2xlL/bMCylsdzDZFtDAvO+q98SOnh0qop2MFpTGTeSkCGPvfmFikwv
 M7cF54ulM5wpU+rYmlwekDKJezkDNw4P4psluQeDwau7v+jrQQAAdq1THoMrPr+PHh6wISNpEXc
 AOoLaO6fq2Xyeh2BSBtnhKqk6j9h1U+NAS+YkSKfkaAs/8rPh9aL3POG2rkXPWEYnLLpSlbpvDG
 wOIXVlM1Sr68v54HJVNOf0Lz9bCRYimvm1X2RpcAETQwzAKiqM3NjASLoNnRdh5sr7tB9BDH9Jl
 9VwjIDwjIxrEeFw==
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

Flash devices created in instance_init via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 602b458201ff ("acpi: Permit OEM ID and OEM table ID fields to be changed")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f62253e1aba..fac825ccd47 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4032,6 +4032,19 @@ static void virt_instance_init(Object *obj)
     cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
+static void virt_instance_finalize(Object *obj)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(vms->flash); i++) {
+        if (vms->flash[i] && !qdev_is_realized(DEVICE(vms->flash[i]))) {
+            object_unref(OBJECT(vms->flash[i]));
+        }
+    }
+    g_free(vms->oem_id);
+    g_free(vms->oem_table_id);
+}
+
 static const TypeInfo virt_machine_info = {
     .name          = TYPE_VIRT_MACHINE,
     .parent        = TYPE_MACHINE,
@@ -4040,6 +4053,7 @@ static const TypeInfo virt_machine_info = {
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
     .instance_init = virt_instance_init,
+    .instance_finalize = virt_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }

-- 
2.53.0



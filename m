Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E27FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreR-0002LM-U8; Mon, 04 May 2026 07:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreB-0001Rw-UN
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreA-0001Vh-D4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AAWAtCladMOl9qwPLP2iDIrISuEXK2bC2mKMxeA798=;
 b=AEr5Pno4+ZlDJnf0vu1JNH+HLZ5J1NpxFRAEN+TrNh49XoSZZIyEmKobjqbAKn3RFF6cps
 xbbN/6pZly/pXufunm5In4GpgfOeoCkv0tx7V8TPR7YN1rTwfg9ULT5VwMMSJcTJvx/qDt
 oWT0FeIBw4jQILAwvL6UGMy1MM4AV8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-sv7wAvg0PU28B5cmbu4PfQ-1; Mon,
 04 May 2026 07:39:30 -0400
X-MC-Unique: sv7wAvg0PU28B5cmbu4PfQ-1
X-Mimecast-MFC-AGG-ID: sv7wAvg0PU28B5cmbu4PfQ_1777894769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2047195608F; Mon,  4 May 2026 11:39:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F2CB19560B6; Mon,  4 May 2026 11:39:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:32 +0400
Subject: [PATCH v2 44/46] hw/riscv/virt: free flash devices and OEM strings
 on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-44-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/h+ea/YAa+zMZaaz+w77We67RHGhjm3ilp8FFp4bR8s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRu7Cb7PLVUHTSESuurD/2/2vJ1Gom2XrysP
 9DCSV09gWWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5c7mD/4kkJGzwQA+qeasTaVIf+Cbvsj1vjH8ZnEvNKa7xhDGlup63W8UVIVJFMCUmmYk3dhrVV0
 4KA4OWilDH5ErPbvgYI6X0CnmpupEodQO9OEsgo9pS681V3tfIoyjUGzFu3dxTg+p7QPQwNBk6+
 lizsPgPLyi4xOH313/5H+rAyehaFjGwyWPC+/SWeKzhG1FDBv2/6M5zvGBmivaW95RNth9Rt0xi
 WnG+vnRk0o34tMf6Ottln0DJKJtVsXURM9sBDANOqbsJkVIvu/DddOdUoSjWdUMrBjgyXs9Jevi
 qUMiCM13dju8JLVJT7/ge9cU7/zXiJwCx8YfjGa1vE/niAYPeGEJeZRgSEbYNP/A4G8qOuOOAym
 dvIpetQiQdWdfyBKallJCotmORyQ0Z0Y9dxmDtMFaoenXAT+e9Mw54JkxKjXIYubVo02KKo34GN
 pWxEJzxWyjUywGbJEakzQxxAB+8u4PyakKfrTn+KZGjwTM4Kbgb1mjV/UNxQCP49ZUyT/0X2rMf
 mqe+IzMcB6kTL9I73TuKSR48Hw95Q/WDzoeoxpVBGne+RY3jn6FlWgm+YG4cgOaN7cSNa4qiAoP
 BgQcc+npdNg+u6wHQ+agPPz34Irkuqlr1/JdcZWEyEix+xpYCs46TwS8dL4+uHTvMKI74q0KGS8
 fgF1iMr5kEcBOkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add instance_finalize to free the two pflash devices (when unrealized)
and the OEM ID strings allocated during instance_init. Fixes leaks
found by ASan.

Fixes: 71eb522c4063 ("riscv/virt: Add the PFlash CFI01 device")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66df..315049bc86c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1745,6 +1745,19 @@ static void virt_machine_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
+static void virt_machine_instance_finalize(Object *obj)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        if (s->flash[i] && !qdev_is_realized(DEVICE(s->flash[i]))) {
+            object_unref(OBJECT(s->flash[i]));
+        }
+    }
+    g_free(s->oem_id);
+    g_free(s->oem_table_id);
+}
+
 static void virt_machine_instance_init(Object *obj)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
@@ -1984,6 +1997,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
+    .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B53CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvFo-00005n-Py; Fri, 29 May 2026 07:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFm-0008BB-0t
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvFk-0000GR-9B
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE+/q4F6W7Ekdb2sIMCJWMNTaDYcoal5/NVcetnDHis=;
 b=ElfM8JUmQLmnWYl/mfRubRPRMkaoKrOXICnKv23/KBXoRHOPsypSmD9XB8SBFH5SXm3VnV
 w8kYYLLMdB0GjA22OZOzejwqzagJcqQdqACzqrU9qNKQ0Qn+++DpbPuCRsaSqgoSu3IT6L
 FoKXgekFjR8mcV2IikbdJd6AB5CCwTA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-9Rje3joMOs2Td9KHjTn3GA-1; Fri,
 29 May 2026 07:19:42 -0400
X-MC-Unique: 9Rje3joMOs2Td9KHjTn3GA-1
X-Mimecast-MFC-AGG-ID: 9Rje3joMOs2Td9KHjTn3GA_1780053581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFED19560A7; Fri, 29 May 2026 11:19:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17AB83002D30; Fri, 29 May 2026 11:19:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:51 +0400
Subject: [PATCH 30/32] ui/console: unregister console from QOM tree on
 close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-30-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=G5ETinkAlSD3wMtGo4G48qKqH8z6lNeiiIdxzS1jppM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWQJ4ZUDvNDDtY17l7xa4LINjoo6bb7czrm6
 2Xy5mmmaGqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1kAAKCRDa6OEJdZac
 5WXJEACbLG7Qy9pebk1Ghx2Avez76l4u6c2FsGBdzFY1iJ0fq59G0p/D53+1awqZFcrG49mIZ7I
 nm3mpMt48Cc+VKjYX2/hqJFzWNJUUYbaKDA23ng5fan2VQxgJSTCeysRHrXY0OaMIeI7HLxv3TI
 2kkdsbYAZQdbpiUIKdCJV27WD/XaRFpZbnvkV3kC/vz0AI3oC+Aa8kDQD+ByBGH56cHW5uNrOdu
 Nxx7PRMuiO+c4G0sOOw7iQW8OZTkhWmDVuihyLCH/wOeL0l7WYKX1FTcP7dz5RlF4qc/RYiKQDR
 3wSXEsxiANClXeREsAyvlSROKRfaGeODpD8/1GJfekQ1UU+9+T3DKgc8fFbGFLhdpVC9G9lCBzE
 g8Njo3N1cFo0vGy7PyFogs7Oljqg1IfSYXz8SXI7hyN9CbLO7xfpxU/IzF9lbiHTK4t7AhA6+z8
 fGO4yUKJmh6wy6/ZocCh3op0WRC9hMUM44c+RYk7VOiJ5dg46W6gTshf96U8ExiIkDkyD89/5+P
 fa01v3K/HsrhLfX9bW3pNTbKKV5ZXjXWoAwFu4qvCuRYM/0su8YNk116ZKTk9WmfFWgQ2JZyHJg
 YJ5GVZJLCHEYAMK+O78iYdXHoQzGs1/pruk6ZrmwAhq+hy5AMu4cxgTS6jYrdfw1mmRp/tbFAGl
 Gn8eyWUi2ngAiTQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Call object_unparent() in graphic_console_close() to remove the
console from /backend/console[N]. This drops the QOM tree
reference, while the initial object_new() reference keeps the
console alive for potential reuse.

When graphic_console_init() reuses a closed console, re-register
it in the QOM tree.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index e01d893df4b..4d10884dc11 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1136,6 +1136,9 @@ QemuConsole *qemu_graphic_console_create(DeviceState *dev, uint32_t head,
         trace_console_gfx_reuse(s->index);
         width = qemu_console_get_width(s, 0);
         height = qemu_console_get_height(s, 0);
+        if (phase_check(PHASE_MACHINE_READY)) {
+            qemu_console_add_to_qom(s);
+        }
     } else {
         trace_console_gfx_new();
         s = (QemuConsole *)object_new(TYPE_QEMU_GRAPHIC_CONSOLE);
@@ -1176,6 +1179,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     }
     surface = qemu_create_placeholder_surface(width, height, unplugged);
     qemu_console_set_surface(con, surface);
+    object_unparent(OBJECT(con));
 }
 
 QemuConsole *qemu_console_lookup_default(void)

-- 
2.54.0



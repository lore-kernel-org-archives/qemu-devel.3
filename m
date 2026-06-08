Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18319CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUIy-0005Gr-EF; Mon, 08 Jun 2026 03:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGm-00035d-So
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGj-0000yv-Ds
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jE+/q4F6W7Ekdb2sIMCJWMNTaDYcoal5/NVcetnDHis=;
 b=fosvPwcQeBv79yS9dRu7UkMw0ai0/XbcE3/9Pa/40E/+aksnmGLFVUKsDjBwJX7Ufkeq9j
 q7KcYn+SQgx8oC554nJQWIir+3qVfT+cr98dto+z04GxoTRKKbgcK7A6IpPIolgzYlxlHy
 vYo4cWrMx85VeXQDFPlE+vUtKy+ibiw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-BUclrGQANPSpD8Z2pnLsJg-1; Mon,
 08 Jun 2026 03:19:26 -0400
X-MC-Unique: BUclrGQANPSpD8Z2pnLsJg-1
X-Mimecast-MFC-AGG-ID: BUclrGQANPSpD8Z2pnLsJg_1780903165
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 414F51800741; Mon,  8 Jun 2026 07:19:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 291B31956053; Mon,  8 Jun 2026 07:19:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:49 +0400
Subject: [PATCH v2 31/33] ui/console: unregister console from QOM tree on close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-31-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxN9hc/OeCLU4dT/we9x1XwpSTG0SqPYCG5c
 V7B88qh0HyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTQAKCRDa6OEJdZac
 5ZusD/9256bTWScUqHwgWmxGQgsjpJh22QPSw1P8SG3JLekH4CxOuz7uWfvU5LqBPLWZI6avys2
 LcVMd6o1KgBwTZ2PKGXCSqTutzCkrdOyC1YNGfyZ2MGUEIUo4P4vLtWU/AXIUrUb4KxHd5MgM/H
 jEKIg0X0K3JJTVo6BpZd6jguJIizdZ8hASTKgncJnmRlyG0VF637G4epGZq/TTzOenaBFmk/vbq
 K86h/UxvsZyAGUP+Ha8XSAFiQCCLryMf7s2GmoefjQeeKorXBPf4libuMZw5jV1qRzEUNR0Bflq
 IBjw3MclI2VuyMBqCn9pVWorucWi8rAfEqkMotefrrWfUT41jUiYReEjXBhpuciO1zA01oOlhB8
 qmlZRJrmM/DCBgvQ5ugALvNTtJHLEWyzvH2bOLUFSjJUWGNcuWfdnu2zQE5qZ+GeRWCky5J95ns
 NmLgxUVMdcsmxamgSPsavCp4EXkvP6UOMi4p+sCoLgKw8DMZANFJpGZV9fAT0pYtabnhEXaA8d+
 ptaF9zvoFaRfN0sc5MQs4Coe40z0UMqMuqdr4Vg24nMuCrykrQwT/JjgVnai0G0firdJ7ByC+i6
 aXDV9/Jzhn5Dw/wRnTWDHEVl898ybqjcIRBu+4AjX1Ca5081yLUd86mY6GjnJ70EmGkRimvUcv0
 l9E0JJKD2OjvKqA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7342BCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbNA-0006bA-PU; Thu, 11 Jun 2026 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbN8-0006aE-LD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbN7-0005P6-7x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxlChsVADaARWyTRMZ3NG8G9plRASvkV/Hq7x8L/VPE=;
 b=dcECVlMv5WOHc06WyZWL89OOvbtUXTvoaZJmUP+qg13GF/zKWSNAwOp5FKxGIMMPRKUR0G
 xT06imrj7Y7HLonFMhSpOxqJlgp3mZyY8fMy82ZNpcWu8pkPZ47tDF01TPD+Ss9xkbyp2E
 koDAk6Sinc/YEMMhjzzjedFj76wRW7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-qj-Kpl-rMzauFO_EBCrlqw-1; Thu,
 11 Jun 2026 05:06:39 -0400
X-MC-Unique: qj-Kpl-rMzauFO_EBCrlqw-1
X-Mimecast-MFC-AGG-ID: qj-Kpl-rMzauFO_EBCrlqw_1781168798
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86019180ACD1; Thu, 11 Jun 2026 09:06:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 368E91954B0D; Thu, 11 Jun 2026 09:06:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:48 +0400
Subject: [PATCH v3 33/35] ui/console: unregister console from QOM tree on close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-33-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mvCtk0KdkrQ8473OU30MMLcq6u1bq2unAsGOAvd3VMw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnniSjiyg5zpGulj+0BiQwS6hNyvCmYq6j/oW
 VCwjABPa96JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54gAKCRDa6OEJdZac
 5UAWD/0TWshkyrQdT6v6MQGuIFdIdLpcClysgrlbNcueWBlWBaT/YhkDgLRD0O2gPPGEN0yEo8k
 bbnhzYBwigozHhh+mfNlCMyuy8M9jSF1KEVTn9wVFjmLq/xfWebjtDE/HLzXbXeY58/kNLhEIMy
 iXNlNNSbTi/iZxbqWsv+rLx1OcI89pLdZ4I8vamggMl9xVRRJRWmGOfqGkgF/2XA1Uv5d7Ff/dO
 d51ov6mP/99hjjvINTKTYCEXbfNoul6IkkTIiBAb65/y+6/ox/enGSyt6HyZ7nOk+TWiezNK0Z5
 MsjMRqCFmK8xikag8gGpYaWVSBKGnvSeU5Z3WeHY5O2JrfGOuETnkLUb2ZaMlb5rVWfSUOV7sSd
 nCxvXsido68EJGqqtGHGSXbGS08jhf5anJcnhTfTUz14y/zUeNu3ZsGM3Es6bYXMgGg9yQPErII
 E67uRG5IkpjH+LkmYxsGJEOKvKozvkJZyIoro/mflRe6BZRnqnS8uM7+mTCclAqGl8NsHJJ2YdG
 81/gnWRSR8i8NQUNCp/HoWtCRWPrfLvukAhyEteUZnZXEtVGFdZ8aKKrSh3KWRsJJ5N4Gb1fMKT
 X05NDD9XZWJ+tRX9ux62xEoDVNWPrL34XKyqLYn5URt+P1uik6YSvBB+frnwrRnIDb4kGQAS6fk
 Dj+zVUVqUH0g6lw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
index db9aaf85f59..a8a2a247d8f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1140,6 +1140,9 @@ QemuConsole *qemu_graphic_console_create(DeviceState *dev, uint32_t head,
         trace_console_gfx_reuse(s->index);
         width = qemu_console_get_width(s, 0);
         height = qemu_console_get_height(s, 0);
+        if (s->ds->initialized) {
+            qemu_console_add_to_qom(s);
+        }
     } else {
         trace_console_gfx_new();
         s = (QemuConsole *)object_new(TYPE_QEMU_GRAPHIC_CONSOLE);
@@ -1180,6 +1183,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     }
     surface = qemu_create_placeholder_surface(width, height, unplugged);
     qemu_console_set_surface(con, surface);
+    object_unparent(OBJECT(con));
 }
 
 QemuConsole *qemu_console_lookup_default(void)

-- 
2.54.0



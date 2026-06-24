Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A38BCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM25-0007YK-9R; Wed, 24 Jun 2026 07:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1x-0007K6-IM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1w-0008KB-8B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn7ES4jiZNX9FsQjb9M//qTryK5m3dJw0Pe0NKBIzs8=;
 b=Wftx+CmuUTZUrrAsLkFeGZzoFSD+ssfis7nqjHdgU6gYBL6mhMs8crsRBruR7R8BpY7BcV
 HlC6BjlsRMSaKfS4Ggc8RU4pP1CxU56zCTSOZacgirD5fGBzL7dl6SFqBoD36aEvxqUrXm
 sxyYGIV/LnVr7D1QQbwAvy+IVztIyS0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-UJr2SydnMa6IcyfLWoLp7w-1; Wed,
 24 Jun 2026 07:44:26 -0400
X-MC-Unique: UJr2SydnMa6IcyfLWoLp7w-1
X-Mimecast-MFC-AGG-ID: UJr2SydnMa6IcyfLWoLp7w_1782301466
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2747B195398C
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCA811955F7A; Wed, 24 Jun 2026 11:44:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:54 +0400
Subject: [GIT PULL 32/35] ui/console: unregister console from QOM tree on close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-32-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7H/9RUpTaqtfP5P3TCRB3XrgwsOR3LJp54NEWFMgNDM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JpLPo2niUchNPX5mzFygu9FGUI+c/p1U/Wr
 T7cnlycYGGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaQAKCRDa6OEJdZac
 5XiUEACoi+UtTjSOkniw7wFnPJmXzTXW1WhmV+bvb0UidBWLbH9fPtdYIeKDG9uRQidb3eMTBsa
 hTva0Da8DI3EwS42deN2eIPVeFGdhaA32z/AVaWYu9gHrKhXs5dx6suPocItgYbwCjdxRLJrTVB
 cjCZN1USQFsKVplgpDcDUAgICJdIhNkqp0puDQSOUvgjzrqUy758oCyemWPC/idf48eyitDh6h1
 vLeMG9EPBwy7huOmi/1+TdupJeYcAVVjqdDjbJVci+pYtw43liwoH5QQOWdKFWFdV9DGWCQRaWi
 7dGkeY5K1lDdQpNPLGrhM9rkY1JdQ8syvTVxQF3Cz0qmo9zxmDC3PbK4oHcw0KxkMcQPNUKZpF7
 oVKakdp+45OVP/Kj2lmwW/8jI1JQKXd20vRdhM9WW+uOYopql4JiYBOJeKg2tceQqGT0jZmM3wf
 jzETIul16t9vllibWbMx1DoTyah3ElUeJuHkyVTd7CG8vlhxtucDyPxuyHryMDy+HkURgZLz6cI
 yFnDWl49VGwsQO5YcSVGQf5gcwBmJ/C1yTS0acsCXpfgFp6k/zkRJ6+aEwk2cVhKPp2JJWZycLF
 AkQzYwyX9oGRtIIXtFAiIQR6R60qGHBok/tDJNquEBelVx6IEpLxKEiDd6LZPer0DFLeLs7sCf/
 ne18X0TeGZp7q8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Call object_unparent() in graphic_console_close() to remove the
console from /backend/console[N]. This drops the QOM tree
reference, while the initial object_new() reference keeps the
console alive for potential reuse.

When graphic_console_init() reuses a closed console, re-register
it in the QOM tree.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-32-4656aec3398d@redhat.com>
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



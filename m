Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295D0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs92-0002jL-BQ; Wed, 17 Jun 2026 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs91-0002i0-7M
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8z-0004sl-EW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faZf4696yal0epOYIe7aL8QIsDmTUlbHO/VDxfj8Rcg=;
 b=R4ZOY8LVeKb8IG3X+Lo5EJYeVFK7Xa8CD+g1Z6QMOggCn68pBRqDsC6kgVbggNFsLwB31s
 nRZ3Hpem9B5LbMrorQZeTOpAp4X5xiDA28ovrPNDfQ/msIG/+cHYiPrcs83t93E75e3VYr
 uNKQzc+7GUdOHOepgBlMsvEe45ZH3qE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-f8PJgeeFNyaQlZrpiy_v2w-1; Wed,
 17 Jun 2026 11:25:31 -0400
X-MC-Unique: f8PJgeeFNyaQlZrpiy_v2w-1
X-Mimecast-MFC-AGG-ID: f8PJgeeFNyaQlZrpiy_v2w_1781709930
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB89195D005
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8A9B18005B6; Wed, 17 Jun 2026 15:25:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:20 +0400
Subject: [GIT PULL 23/27] tools/qemu-vnc: Have console_get_mouse/keyboard
 take const QemuConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-23-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+7928dyer7hqpvdZhH2zzD4wlqKd41p2LOQoGgqpc70=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpjuHnOC1vM/cOTCWUgNJU+FoX2QoJCarEl
 wjRzLGnYNGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5dM4EACUtzjfvJYGfVBa9Esh3vNnpcuh/lchrCCz1Ba8Dwt9iK6knu1gcHopey3tmEudLLC5zSi
 jO1th7xo7rxIpP+DM7dgQD9bN/foYbsEGE+L77knNLGerjLHn2nh98lbITDKBiLubdRgx5EzvoL
 1QyAUMhS/S9PfEop2YKAhvl8oIaKkMMd2HBNakKZEwJ/ow7lIBUN1gtXysUHRoKO1N/PNvyUjx0
 agC+SW/mrEUJku9PYBmVfpCNLTyYtZUIoIsh6UPaIbWwv6rOJhUCLmVIzRe1+v2lIj5atEMyyw6
 povfMrcKOh5RvhrLrpV2UkXgUlpPWUEfrnVAYq8v2wSHhBwRWsI2gcGMOBy1PokZBfmzpIfOWes
 +LJMW35LcJuTlC2VdW5JYk0YtKAn6xkRjEGWJm9fKTM96v4OKcpgdtOxuTLn2ZJEbkbM2CPfvkF
 yr7IN33VNc60qt+x+8xPH0pi2nXI+8IZNm+bvDyNG9onnqFVMzCJs4O/rAsNsOokZejn0BWPni4
 u8C/qvNOtZEqxzWK5tOwkTEAlqzaB5bqDNsg2mpHiiQJcA8tkZKPjnMK450b1YCXko5dyOBKfjz
 RLWqz8FEIgiOagV91efWbXiiV+arhGT/wZf0dEvWwaqflIWhwWbLidDrocqEXtB8m8jOeLeXers
 Osbr2aWTsS64Tcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Both console_get_mouse() and console_get_keyboard() only
access @con in read-only mode. Make that argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260611114212.27472-2-philmd@oss.qualcomm.com>
---
 tools/qemu-vnc/qemu-vnc.h | 4 ++--
 tools/qemu-vnc/display.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/qemu-vnc/qemu-vnc.h b/tools/qemu-vnc/qemu-vnc.h
index 6e483e4b475..15e4ead80b7 100644
--- a/tools/qemu-vnc/qemu-vnc.h
+++ b/tools/qemu-vnc/qemu-vnc.h
@@ -26,8 +26,8 @@ void input_setup(QemuDBusDisplay1Keyboard *kbd,
                  QemuDBusDisplay1Mouse *mouse);
 bool console_setup(GDBusConnection *bus, const char *bus_name,
                    const char *console_path);
-QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con);
-QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con);
+QemuDBusDisplay1Keyboard *console_get_keyboard(const QemuConsole *con);
+QemuDBusDisplay1Mouse *console_get_mouse(const QemuConsole *con);
 
 void audio_setup(GDBusObjectManager *manager);
 void clipboard_setup(GDBusObjectManager *manager, GDBusConnection *bus);
diff --git a/tools/qemu-vnc/display.c b/tools/qemu-vnc/display.c
index 8fe9b6fc898..b485cbe3100 100644
--- a/tools/qemu-vnc/display.c
+++ b/tools/qemu-vnc/display.c
@@ -433,7 +433,7 @@ bool console_setup(GDBusConnection *bus, const char *bus_name,
     return true;
 }
 
-QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con)
+QemuDBusDisplay1Keyboard *console_get_keyboard(const QemuConsole *con)
 {
     ConsoleData *cd;
 
@@ -444,7 +444,7 @@ QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con)
     return cd ? cd->keyboard_proxy : NULL;
 }
 
-QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con)
+QemuDBusDisplay1Mouse *console_get_mouse(const QemuConsole *con)
 {
     ConsoleData *cd;
 

-- 
2.54.0



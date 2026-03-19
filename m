Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D842A1090223
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvv-0005XG-FD; Thu, 19 Mar 2026 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kniv@yandex-team.ru>)
 id 1w3964-00066m-0D; Thu, 19 Mar 2026 04:51:16 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kniv@yandex-team.ru>)
 id 1w395z-0002z8-U1; Thu, 19 Mar 2026 04:51:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:119a:0:640:98fa:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7A45CC0237;
 Thu, 19 Mar 2026 11:51:05 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:b63::1:31])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ooJakP0AQuQ0-g1myH6BT; Thu, 19 Mar 2026 11:51:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773910265;
 bh=ua+utAIb/Aq6z+QAQTGHRzg0lX/9uTinaldLO54cuOI=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=jKfi8dDbYvHx1MWt/MSelf0ZmpR6oX8V8ZDHr4slTikd278gIs1/sDKO78X8nsEWF
 C0e/fI83R9xeU6aYMiZfJgsPGb/huINpdwHSSrdNiVOtCdEtFtrgcZTQ64usOBZI4G
 7pk5aWd7A8mmOlpKCOrqbYAZDfdSlqgs9gC9F76E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] qmp: Check vhost protocol features for NULL prior to dumping
Date: Thu, 19 Mar 2026 11:50:50 +0300
Message-Id: <20260319085050.1982608-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72; envelope-from=kniv@yandex-team.ru;
 helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Mar 2026 08:56:52 -0400
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

vhost_dev->protocol_features field can be legitimately set to NULL
as apparently it's vhost-user only field. At least I was able to get
NULL deref with a vhost-net VM.

Without that check querying vhost-net device:
info virtio-status /machine/peripheral-anon/device[0]/virtio-backend
will lead to SIGSEGV.

Fixes: 8a8287981d1169f534894d983ecfd3b70b71918b ("hmp: add virtio commands")
Cc: qemu-stable@nongnu.org
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 hw/virtio/virtio-hmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 1daae482d3..b9980197ef 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -15,6 +15,9 @@
 static void hmp_virtio_dump_protocols(Monitor *mon,
                                       VhostDeviceProtocols *pcol)
 {
+    if (pcol == NULL) {
+        return;
+    }
     strList *pcol_list = pcol->protocols;
     while (pcol_list) {
         monitor_printf(mon, "\t%s", pcol_list->value);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4A7C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLS-0000CJ-Pb; Fri, 28 Aug 2026 08:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLO-0008QL-ES
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLM-0002pi-Mw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mpb/2b3qMFQzTLzTCER3qNfrQzUe3H5wt66hPLCR09I=;
 b=eFW3x3sibWYZYdvofG2MKKERDMoao3VxSphBUyUVlmBUOh9IoztW44sFdokbOBqAnXyA0X
 41rYvNCEZS+LD7dHj91JVcMJy9CQ7+gY/eOJoRJkf2bVeUvYB2OF4EKbf3jKJejxOsBwBM
 F6ZTkvZuisaDVY/CMkfhBBRt7K2xBdw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-qM4CvCBHM7eXmV5BqyqJsQ-1; Fri,
 28 Aug 2026 08:05:56 -0400
X-MC-Unique: qM4CvCBHM7eXmV5BqyqJsQ-1
X-Mimecast-MFC-AGG-ID: qM4CvCBHM7eXmV5BqyqJsQ_1787918755
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF18188863E; Fri, 28 Aug 2026 12:05:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7236F1955F08; Fri, 28 Aug 2026 12:05:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:15 +0400
Subject: [PATCH v5 18/50] tests/qemu-iotests/205: fix race in
 assertExportNotFound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-18-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=skNsYNNV1xMEy9mfAYu0UimfTtL6eome8md1k82hjKA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk45qWdgSQZBbb0cTf1bSAisYilkJSQtbXaz
 NfTa3NVFBiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5UnSEACHxSlDiB4fSbQ6YvDUvDvDOmWHu5EgDfbYY3wHOanKqnKxrq5KEsUNGt05xahw41gXUug
 yDdQDQlniFvG+1q31kLQcVgvAWPPNf0CMXe0d1gPyyicFGX69sxCyTGDPESmrphjgac0+iKiCUf
 Plgn52L2LSgq4zF+lKaXjX8K1uPaWrNgfAft45RSxbC6mfeSEjMynV7wGXotjzmPyEZdrKL4U+n
 sXcnYj2mfXxQ8YywdVm11vciKnmDnyD0g+BKgSMiqegiGLHEhSxpGadUPYvv1yIKT/uTmXmve8E
 ca5Nz90QSNLmarK6JbF2M3vLSyHJfwkGavvKtcsvrWtCEPP+21uMENs3wGvl8kCNM/CTnLGWSsY
 EVPm+x/KCT9lsoW5tmyvHcyv8wxI6SuE6J+y6+MJGXZKD2Hpilwv6nphMqAeBFI6XlkrIihVWz5
 a1KNEnyyk4gRSMQYm+LYdFicRwpg5byA0PjEinaLECg8YjYXLKcBwey3taUfvS+kayAIVmlSqLL
 6YSDlptMcGve6QlJMVfvYTx7vrCyUy349QXysojzcdopEr8+23KiM3oE7uA8bxnupcPiYWCmINI
 TVEAKIu+fyh6ZebnIjIEgwIv7o/RVgm9k6tTjzTn6iWoAcpWRPbnvSbN8MBsZI1iPQFZiXat5dF
 nQf76IrhkrIsFyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

After nbd-server-remove with mode=hard and an active client, the
export is removed from the NBD export list synchronously but remains
in the block export list until async cleanup completes (via
blk_exp_delete_bh bottom-half). A subsequent nbd-server-remove call
may find the export still in the block list with user_owned=false,
returning "already shutting down" instead of "not found".

Accept both error messages in assertExportNotFound, since both
indicate the export is no longer usable.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/205 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 2370e1a138b1..78459065418c 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -60,7 +60,9 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
     def assertExportNotFound(self, name):
         result = self.vm.qmp('nbd-server-remove', name=name)
-        self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+        desc = result.get('error', {}).get('desc', '')
+        self.assertIn(desc, ("Export '%s' is not found" % name,
+                             "Export '%s' is already shutting down" % name))
 
     def assertExistingClients(self, result):
         self.assert_qmp(result, 'error/desc', "export 'exp' still in use")

-- 
2.55.0.543.g5ebe2ebe4ea8



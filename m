Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F0FC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJC-0000bR-Bv; Sun, 16 Aug 2026 15:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJ6-0000Ns-1H
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJ3-0007YY-Fp
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mpb/2b3qMFQzTLzTCER3qNfrQzUe3H5wt66hPLCR09I=;
 b=idZhVGgQPppx5WGxr/1KgIsagUrS7c7KwCL1aqzuGitBgpBI/bsns5GllJrsMzozPidtAr
 lpvaN7KIrUSy0xB8lBobEPM213GdDi1lcIFiA69w7D7A5dqTlwGkDwo189FAOw/QqS0Jik
 zbZYuSW1gDGwXnQCZxh1frBxiPT1zkg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-CZgBsuL2Mj21gun8HpRe_g-1; Sun,
 16 Aug 2026 15:14:00 -0400
X-MC-Unique: CZgBsuL2Mj21gun8HpRe_g-1
X-Mimecast-MFC-AGG-ID: CZgBsuL2Mj21gun8HpRe_g_1786907639
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FC9A195608E; Sun, 16 Aug 2026 19:13:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47BF6423; Sun, 16 Aug 2026 19:13:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:44 +0400
Subject: [PATCH v3 17/49] tests/qemu-iotests/205: fix race in
 assertExportNotFound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-17-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=skNsYNNV1xMEy9mfAYu0UimfTtL6eome8md1k82hjKA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggux9xF8HBJifP6ufTRARF2NfrLymW+A1BByN
 DNHywYIsVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsQAKCRDa6OEJdZac
 5c+gD/9AkCvoLEpbu8RuKptdxfRV/oHBz7UDgQQt4hw9jyxHENG4ZGpicaE9a9hGULLj3S2ozwx
 L2QZdgvp1YIEFO5/XXYHE0WaFJ1mCGfo3ZOWy/l3JTXa/i1eBcM45U9a3mbRJqlZNQ74m1ST64C
 5llcwTyQUkrSuR3ewYGD+pfGiSR1La1Q2OphTpCdhRecQO+jJKs0hsR1H8FaWgiIKuqpQXjK1ck
 kfOErWf/igmXrv518iackVIBAOXs+L61w5IUZdqH/fF9tQYUDtMLcGTrEGdCRpfk5iqnsJPMXQ1
 pkuJ3Mqbdu1hsmBeJV+mFXm0MgTZGr2nyRRstY3NSHpbQwRePnC8jnRFIZqLo8esyeFlI7dn1n+
 Y/y8kkqtoQO7wzRJ8a4h9bIW0zMIwHxu5lkFqIsC0kH2k656V/AdvQyLSTaSfCrUcDm4RAJqHIo
 dvqY0TosRcei3czA426eVlf9lLH3KGZ29EyCnTX0cqgXmU3hviQw0fwDWv8gGGDwP95F4ZkI9QN
 FLohYJ3pOMlEWrV8+ElDCWQQRfX3P90hCPsVy3Ex45JR0tPr9XxdIo5W6M64oTYjkFyXCsH6pM/
 D4uLQ1VEy1kUqr5CZsv58BG+SzITtfsCzYxrkgF7R/3VzoGF037BmvtTEhJ2OE6CvMSAW8y7wFR
 tZ8la7V+0VOCFEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



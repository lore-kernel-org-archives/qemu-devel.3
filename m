Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 10:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tur6h-0001al-Rr; Wed, 19 Mar 2025 06:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tur6G-0001Wd-Fs
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 06:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tur68-0007ck-TW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 06:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742381789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EVvLJZk1eCLHKj3fBvUuAJdZ7gm9VPm46gzBu2pkw1k=;
 b=DBB4ouAwLZtYJMN23acDTtEv7Q+ClRPXkF61v85KfQRjJfYDXPD8sujSUzTcp2D8QoIiuk
 cMgU3SznDujGt+74o5+LrT2DxeXbw5UgKNjUSqE51TelVaEk1R8Y3ihsEcPGT3lLOYEKYN
 Xkvi/wuBFqcPVKX5eAPDChVpYSzQe6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-Ow0hIvd6P_i4Z5USiq7z2g-1; Wed,
 19 Mar 2025 06:56:25 -0400
X-MC-Unique: Ow0hIvd6P_i4Z5USiq7z2g-1
X-Mimecast-MFC-AGG-ID: Ow0hIvd6P_i4Z5USiq7z2g_1742381784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E051418007E1; Wed, 19 Mar 2025 10:56:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D5153001D0E; Wed, 19 Mar 2025 10:56:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional/test_migration: Use "ncat" instead of "nc"
 in the exec test
Date: Wed, 19 Mar 2025 11:56:17 +0100
Message-ID: <20250319105617.133191-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

"nc" can either bei GNU netcat, OpenBSD netcat or NMap ncat. At
least GNU netcat currently does not work with this test anymore,
though the comment in the test says otherwise. GNU netcat seems
to be quite unmaintained nowadays, according to its website
(https://netcat.sourceforge.net/), the last public release is from
2004, so we should rather avoid that binary.
In our CI, we are only using "ncat" in the containers (it's the only
flavor that lcitool supports), thus to avoid silent regressions with
the other netcats, let's limit this test to "ncat" only now.

Reported-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_migration.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
index 44804113cfe..181223a69e3 100755
--- a/tests/functional/test_migration.py
+++ b/tests/functional/test_migration.py
@@ -87,13 +87,12 @@ def test_migration_with_unix(self):
             dest_uri = 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
 
-    @skipIfMissingCommands('nc')
+    @skipIfMissingCommands('ncat')
     def test_migration_with_exec(self):
-        """The test works for both netcat-traditional and netcat-openbsd packages."""
         with Ports() as ports:
             free_port = self._get_free_port(ports)
-            dest_uri = 'exec:nc -l localhost %u' % free_port
-            src_uri = 'exec:nc localhost %u' % free_port
+            dest_uri = 'exec:ncat -l localhost %u' % free_port
+            src_uri = 'exec:ncat localhost %u' % free_port
             self.do_migrate(dest_uri, src_uri)
 
 if __name__ == '__main__':
-- 
2.48.1



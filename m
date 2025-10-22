Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B8CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 21:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBgQh-0003XN-Fl; Wed, 22 Oct 2025 17:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBgQZ-0003VD-Gt
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBgQO-0001o5-JG
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 17:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761168674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=piaTdZ6Q1sGZ2RzPuK+UpupuDC+9eGbP5/5exluPCM0=;
 b=Z54yAXNnhi45nO1jN066jgPPMhLpXTxrc9MaOP1CyAGlluQvHaBUJ4AZaWnCUeYap+mTFN
 yCFAVRpcSti088yyN1tuZtpYw5K+u1sRM9zuyeUBj6pWEZsNE0Dh2n6xqn8NfosLw/H7Q9
 c0YCpbWeNLwZbPXkNJYFnCLfABR7Gt8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-oUz997IwPQqXCQNV3UGLGw-1; Wed,
 22 Oct 2025 17:31:12 -0400
X-MC-Unique: oUz997IwPQqXCQNV3UGLGw-1
X-Mimecast-MFC-AGG-ID: oUz997IwPQqXCQNV3UGLGw_1761168671
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81A8418002F7
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:31:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.197])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B509B19560B4; Wed, 22 Oct 2025 21:31:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] scripts/device-crash-test: fix spurious EOFError messages
Date: Wed, 22 Oct 2025 17:31:09 -0400
Message-ID: <20251022213109.395149-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the QMP library was updated to match the standalone repository in
094ded52, I neglected to update the logging filter(s) in
device-crash-test, which allowed the spurious messages to leak through.

Update the log filter to re-suppress these messages.

Fixes: 094ded52
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 1ecb9663ae8..c1576e8b966 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -527,7 +527,7 @@ def main():
         # Async QMP, when in use, is chatty about connection failures.
         # This script knowingly generates a ton of connection errors.
         # Silence this logger.
-        logging.getLogger('qemu.qmp.qmp_client').setLevel(logging.CRITICAL)
+        logging.getLogger('qemu.qmp.protocol').setLevel(logging.CRITICAL)
 
     fatal_failures = []
     wl_stats = {}
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61380CA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfpU-0000zP-L8; Wed, 03 Sep 2025 01:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfnF-0006SA-SZ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfnD-000789-Mi
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4xBFXb45hM+ZJ7Arv4NuY5r0toY1PnfWxR1gk8ah2U=;
 b=E8fyL6VQzOMDIEEynkmVBBov11E7CWnFWEGTB2X6hu+l8c5FFIJAIfF9mkr9B2vKIzwXuB
 um6CGrhZ3R0Uw6MjhnhqETFHqEcyJGpZe+On1ayDE3gj8+rAQLnuefsX2+ziAuyMuhP5ah
 d0Y/HSgzYQGSfMdNEYn0UQB/R5kO6aQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-KH8MpBioO6GDGy71av25gw-1; Wed,
 03 Sep 2025 01:12:19 -0400
X-MC-Unique: KH8MpBioO6GDGy71av25gw-1
X-Mimecast-MFC-AGG-ID: KH8MpBioO6GDGy71av25gw_1756876338
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B593E18004D4; Wed,  3 Sep 2025 05:12:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73E2C19560A2; Wed,  3 Sep 2025 05:12:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 18/18] iotests/check: always enable all python warnings
Date: Wed,  3 Sep 2025 01:11:24 -0400
Message-ID: <20250903051125.3020805-19-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Of most importance is that this gives us a heads-up if anything
we rely on has been deprecated. The default python behaviour
only emits a warning if triggered from __main__ which is very
limited.

Setting the env variable further ensures that any python child
processes will also display warnings.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 545f9ec7bdd..d9b7c1d5989 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -21,6 +21,7 @@ import sys
 import argparse
 import shutil
 from pathlib import Path
+import warnings
 
 from findtests import TestFinder
 from testenv import TestEnv
@@ -137,6 +138,9 @@ def make_argparser() -> argparse.ArgumentParser:
 
 
 if __name__ == '__main__':
+    warnings.simplefilter("default")
+    os.environ["PYTHONWARNINGS"] = "default"
+
     args = make_argparser().parse_args()
 
     env = TestEnv(source_dir=args.source_dir,
-- 
2.50.1



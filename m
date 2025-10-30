Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F237FCCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOx1-0003X4-Kb; Thu, 30 Oct 2025 05:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOww-0003We-U9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOvu-0004WY-OC
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761816408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qZhKi2lkS2z8Qf7um+u0aDLSSbPevJX1nqghD0P7VUs=;
 b=ajablx9vu3cuwTHMtM/Aq6tAsnZ/Piqd+OfAgadgjBJQnUXEI2Lzv6apRnNjtN0N0MKyXg
 gpGoV1zFUkM6HxX5whGEEi8bsgaZsrNvrPeL9261bUyHBOJb4xoJb+mrvT2WLI+b7H4GY7
 bAR01kvRr+NZnN4Junx9Wj3cmvFGYKU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-R4SNQVJ0MnyHZuk2nd86yQ-1; Thu,
 30 Oct 2025 05:26:44 -0400
X-MC-Unique: R4SNQVJ0MnyHZuk2nd86yQ-1
X-Mimecast-MFC-AGG-ID: R4SNQVJ0MnyHZuk2nd86yQ_1761816403
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F065119540D1; Thu, 30 Oct 2025 09:26:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F06111800579; Thu, 30 Oct 2025 09:26:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings with
 latest argparse
Date: Thu, 30 Oct 2025 10:26:38 +0100
Message-ID: <20251030092638.39505-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The argparse.FileType() type has been deprecated in the latest argparse
version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
functional test to fail since there are unexpected strings in the output.
Change the script to use pathlib.Path instead to fix the test_bad_vmstate
test and to be prepared for the future when the deprecated FileType gets
removed completely.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/vmstate-static-checker.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 2335e25f94c..89b100e6cca 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -21,6 +21,7 @@
 
 import argparse
 import json
+import pathlib
 import sys
 
 # Count the number of errors found
@@ -382,10 +383,10 @@ def main():
     help_text = "Parse JSON-formatted vmstate dumps from QEMU in files SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions would break based on the VMSTATE information contained within the JSON outputs.  The JSON output is created from a QEMU invocation with the -dump-vmstate parameter and a filename argument to it.  Other parameters to QEMU do not matter, except the -M (machine type) parameter."
 
     parser = argparse.ArgumentParser(description=help_text)
-    parser.add_argument('-s', '--src', type=argparse.FileType('r'),
+    parser.add_argument('-s', '--src', type=pathlib.Path,
                         required=True,
                         help='json dump from src qemu')
-    parser.add_argument('-d', '--dest', type=argparse.FileType('r'),
+    parser.add_argument('-d', '--dest', type=pathlib.Path,
                         required=True,
                         help='json dump from dest qemu')
     parser.add_argument('--reverse', required=False, default=False,
@@ -393,10 +394,10 @@ def main():
                         help='reverse the direction')
     args = parser.parse_args()
 
-    src_data = json.load(args.src)
-    dest_data = json.load(args.dest)
-    args.src.close()
-    args.dest.close()
+    with open(args.src, 'r', encoding='utf-8') as src_fh:
+        src_data = json.load(src_fh)
+    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
+        dest_data = json.load(dst_fh)
 
     if args.reverse:
         temp = src_data
-- 
2.51.0



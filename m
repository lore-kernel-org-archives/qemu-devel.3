Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A78CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsGt-0003mO-P9; Mon, 03 Nov 2025 05:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGs-0003lt-VO
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGp-0004FY-O5
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nf/Ytz5jJvKyHbVoMjGBTl6EhhVsR9/n9UTpq1uWonY=;
 b=aLCji00SvnO00v3+xJgv01e/JiS/HBIYCaGXd43f+6THv6zW0WzZ5Pp2ThGqfAtNfXNsmb
 kkDvrKT2iqPA2ERhA33AqtY0becRKG1WxPdGAzUVZfuHboegXJHVyISaAK5ROwdr4wPn6W
 a+dk/AiBn3Z9j/AmuSoWHK4ZMpd25+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-p3HTJpmQPG-vCyS6CHf88g-1; Mon,
 03 Nov 2025 05:58:38 -0500
X-MC-Unique: p3HTJpmQPG-vCyS6CHf88g-1
X-Mimecast-MFC-AGG-ID: p3HTJpmQPG-vCyS6CHf88g_1762167517
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99B141955E85; Mon,  3 Nov 2025 10:58:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33C5030001A1; Mon,  3 Nov 2025 10:58:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/22] tests/functional: Fix problems in uncompress.py reported
 by pylint
Date: Mon,  3 Nov 2025 11:58:02 +0100
Message-ID: <20251103105824.322039-6-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

- put the doc strings in the right locations (after the "def" line)
- use isinstance() instead of checking via type()

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251015095454.1575318-6-thuth@redhat.com>
---
 tests/functional/qemu_test/uncompress.py | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
index b7ef8f759b7..5bbdf8fe323 100644
--- a/tests/functional/qemu_test/uncompress.py
+++ b/tests/functional/qemu_test/uncompress.py
@@ -58,20 +58,20 @@ def zstd_uncompress(zstd_path, output_path):
     os.chmod(output_path, stat.S_IRUSR | stat.S_IWUSR)
 
 
-'''
-@params compressed: filename, Asset, or file-like object to uncompress
-@params uncompressed: filename to uncompress into
-@params format: optional compression format (gzip, lzma)
+def uncompress(compressed, uncompressed, format=None):
+    '''
+    @params compressed: filename, Asset, or file-like object to uncompress
+    @params uncompressed: filename to uncompress into
+    @params format: optional compression format (gzip, lzma)
 
-Uncompresses @compressed into @uncompressed
+    Uncompresses @compressed into @uncompressed
 
-If @format is None, heuristics will be applied to guess the format
-from the filename or Asset URL. @format must be non-None if @uncompressed
-is a file-like object.
+    If @format is None, heuristics will be applied to guess the
+    format from the filename or Asset URL. @format must be non-None
+    if @uncompressed is a file-like object.
 
-Returns the fully qualified path to the uncompessed file
-'''
-def uncompress(compressed, uncompressed, format=None):
+    Returns the fully qualified path to the uncompessed file
+    '''
     if format is None:
         format = guess_uncompress_format(compressed)
 
@@ -84,19 +84,19 @@ def uncompress(compressed, uncompressed, format=None):
     else:
         raise Exception(f"Unknown compression format {format}")
 
-'''
-@params compressed: filename, Asset, or file-like object to guess
-
-Guess the format of @compressed, raising an exception if
-no format can be determined
-'''
 def guess_uncompress_format(compressed):
-    if type(compressed) == Asset:
+    '''
+    @params compressed: filename, Asset, or file-like object to guess
+
+    Guess the format of @compressed, raising an exception if
+    no format can be determined
+    '''
+    if isinstance(compressed, Asset):
         compressed = urlparse(compressed.url).path
-    elif type(compressed) != str:
+    elif not isinstance(compressed, str):
         raise Exception(f"Unable to guess compression cformat for {compressed}")
 
-    (name, ext) = os.path.splitext(compressed)
+    (_name, ext) = os.path.splitext(compressed)
     if ext == ".xz":
         return "xz"
     elif ext == ".gz":
-- 
2.51.0



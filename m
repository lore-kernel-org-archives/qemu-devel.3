Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B50C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 06:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtVR-0001Uj-Rc; Tue, 11 Mar 2025 02:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtVC-0001Tk-BU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtV9-0001j3-DY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741676040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J6ZFLa8G13Faxej6D1UmH0qOm4z1sYNDBxjFg4+whdo=;
 b=fZHT0+Q2Gxso2czxrvhy9NpLSM8LDE1f+/C9qo4egH62qVgFUB31IDRNbXBU8muOFC3qMO
 ax4lvCJdpNbCDkNaACN2gV0wJ66+lHTpMB0zGV5Z0ITG7ssiXzb+ZeY4B0ENdao10iGgEX
 5OnMLziw2TJlj3hhcgroLUrcFbzrJiU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-Crx5LU2wMeaSIP9BwQk37A-1; Tue,
 11 Mar 2025 02:53:58 -0400
X-MC-Unique: Crx5LU2wMeaSIP9BwQk37A-1
X-Mimecast-MFC-AGG-ID: Crx5LU2wMeaSIP9BwQk37A_1741676038
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8D7C1800262; Tue, 11 Mar 2025 06:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C8219560AB; Tue, 11 Mar 2025 06:53:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE59321E66C1; Tue, 11 Mar 2025 07:53:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	berrange@redhat.com,
	jsnow@redhat.com
Subject: [PATCH] scripts/qapi/backend: Clean up create_backend()'s failure mode
Date: Tue, 11 Mar 2025 07:53:52 +0100
Message-ID: <20250311065352.992307-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

create_backend()'s caller catches QAPIError, and returns non-zero exit
code on catch.  The caller's caller passes the exit code to
sys.exit().

create_backend() doesn't care: it reports errors to stderr and
sys.exit()s.

Change it to raise QAPIError instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/main.py | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 5b4679abcf..0e2a6ae3f0 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -31,34 +31,28 @@ def create_backend(path: str) -> QAPIBackend:
 
     module_path, dot, class_name = path.rpartition('.')
     if not dot:
-        print("argument of -B must be of the form MODULE.CLASS",
-              file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError("argument of -B must be of the form MODULE.CLASS")
 
     try:
         mod = import_module(module_path)
     except Exception as ex:
-        print(f"unable to import '{module_path}': {ex}", file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(f"unable to import '{module_path}': {ex}") from ex
 
     try:
         klass = getattr(mod, class_name)
-    except AttributeError:
-        print(f"module '{module_path}' has no class '{class_name}'",
-              file=sys.stderr)
-        sys.exit(1)
+    except AttributeError as ex:
+        raise QAPIError(
+            f"module '{module_path}' has no class '{class_name}'") from ex
 
     try:
         backend = klass()
     except Exception as ex:
-        print(f"backend '{path}' cannot be instantiated: {ex}",
-              file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(
+            f"backend '{path}' cannot be instantiated: {ex}") from ex
 
     if not isinstance(backend, QAPIBackend):
-        print(f"backend '{path}' must be an instance of QAPIBackend",
-              file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(
+            f"backend '{path}' must be an instance of QAPIBackend")
 
     return backend
 
-- 
2.48.1



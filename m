Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE3FCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfoC-0007Bd-Oy; Wed, 03 Sep 2025 01:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmi-0006F2-Sy
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfme-0006SA-Va
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvlcoNBRtTemniW9XA73ofAIfmI7j9QtIOho6OWMmb8=;
 b=UI7r4JTEZ0FR0q8WbFU0+UBAuzoCk8ENE1AdGffKESxf6XKrFm5qurlYbk/2pO5pA0TNue
 NyIq755m++md1/WND9VhAFK3aJuOkejaX/BDFpr6fygBsJ3vTjvmMWPY9o9LSUxCAblVFS
 orrmrOIQuXOHUs9rDifL4u/pmY0tw/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-wBxDjXCUPb6nASM_EKdKSg-1; Wed,
 03 Sep 2025 01:11:42 -0400
X-MC-Unique: wBxDjXCUPb6nASM_EKdKSg-1
X-Mimecast-MFC-AGG-ID: wBxDjXCUPb6nASM_EKdKSg_1756876301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B84BF195608C; Wed,  3 Sep 2025 05:11:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E6FC19560A2; Wed,  3 Sep 2025 05:11:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 06/18] python: backport 'qmp-shell: add common_parser()'
Date: Wed,  3 Sep 2025 01:11:12 -0400
Message-ID: <20250903051125.3020805-7-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit 20a88c2471f37d10520b2409046d59e1d0f1e905
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/qmp_shell.py | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index 98e684e9e8a..02028e94b5a 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -514,21 +514,27 @@ def die(msg: str) -> NoReturn:
     sys.exit(1)
 
 
+def common_parser() -> argparse.ArgumentParser:
+    """Build common parsing options used by qmp-shell and qmp-shell-wrap."""
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-H', '--hmp', action='store_true',
+                        help='Use HMP interface')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Verbose (echo commands sent and received)')
+    parser.add_argument('-p', '--pretty', action='store_true',
+                        help='Pretty-print JSON')
+    parser.add_argument('-l', '--logfile',
+                        help='Save log of all QMP messages to PATH')
+    return parser
+
+
 def main() -> None:
     """
     qmp-shell entry point: parse command line arguments and start the REPL.
     """
-    parser = argparse.ArgumentParser()
-    parser.add_argument('-H', '--hmp', action='store_true',
-                        help='Use HMP interface')
+    parser = common_parser()
     parser.add_argument('-N', '--skip-negotiation', action='store_true',
                         help='Skip negotiate (for qemu-ga)')
-    parser.add_argument('-v', '--verbose', action='store_true',
-                        help='Verbose (echo commands sent and received)')
-    parser.add_argument('-p', '--pretty', action='store_true',
-                        help='Pretty-print JSON')
-    parser.add_argument('-l', '--logfile',
-                        help='Save log of all QMP messages to PATH')
 
     default_server = os.environ.get('QMP_SOCKET')
     parser.add_argument('qmp_server', action='store',
@@ -564,16 +570,7 @@ def main_wrap() -> None:
     qmp-shell-wrap entry point: parse command line arguments and
     start the REPL.
     """
-    parser = argparse.ArgumentParser()
-    parser.add_argument('-H', '--hmp', action='store_true',
-                        help='Use HMP interface')
-    parser.add_argument('-v', '--verbose', action='store_true',
-                        help='Verbose (echo commands sent and received)')
-    parser.add_argument('-p', '--pretty', action='store_true',
-                        help='Pretty-print JSON')
-    parser.add_argument('-l', '--logfile',
-                        help='Save log of all QMP messages to PATH')
-
+    parser = common_parser()
     parser.add_argument('command', nargs=argparse.REMAINDER,
                         help='QEMU command line to invoke')
 
-- 
2.50.1



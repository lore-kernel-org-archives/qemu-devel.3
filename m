Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E0C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuZvT-0006S6-N9; Tue, 18 Mar 2025 12:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvQ-0006Qx-KY
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvO-0004Vd-2T
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742315777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ldx0piybqUILZ+q26+wafghVoHtgoMwecCWubBVXrAc=;
 b=CzILxBcit/ZguYqr3jG19xFh/ZGXbr36dl3a8uZcDi6ItUxuuGqDHquehSwNulenDxRQhd
 VRZa76ym+n85MVeVmSCIpkLbPYJdV9lKSDtKM1gF0xfqKS8EqNRtMhR/rRSpk5k803+wRJ
 mCBnmaWE+exxhjlPySe0VpvWWqFQFMc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-ceQ7WSqCORmEbs6hz266ZA-1; Tue,
 18 Mar 2025 12:36:14 -0400
X-MC-Unique: ceQ7WSqCORmEbs6hz266ZA-1
X-Mimecast-MFC-AGG-ID: ceQ7WSqCORmEbs6hz266ZA_1742315773
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C0E1956050; Tue, 18 Mar 2025 16:36:12 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63C941955BE1; Tue, 18 Mar 2025 16:36:08 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH 1/3] scripts: render_block_graph: Fix invalid escape sequence
 warning with python 3.12
Date: Tue, 18 Mar 2025 17:36:02 +0100
Message-ID: <4d8f833ad9355cb9c64633cdbab362300f0a7b4a.1742315602.git.pkrempa@redhat.com>
In-Reply-To: <cover.1742315602.git.pkrempa@redhat.com>
References: <cover.1742315602.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
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

From: Peter Krempa <pkrempa@redhat.com>

Trying to run 'render_block_graph' produces following warnings on
machine with python 3.12:

 $ ./scripts/render_block_graph.py cd-throttle ble.png
 ./scripts/render_block_graph.py:57: SyntaxWarning: invalid escape sequence '\l'
   '  w - Write\l'
 ./scripts/render_block_graph.py:58: SyntaxWarning: invalid escape sequence '\l'
   '  r - consistent-Read\l'
 ./scripts/render_block_graph.py:59: SyntaxWarning: invalid escape sequence '\l'
   '  u - write - Unchanged\l'
 ./scripts/render_block_graph.py:60: SyntaxWarning: invalid escape sequence '\l'

 [...]

The graphviz '\l' escape sequence is used to left-justify the line and
new python started enforcing of strings to contain only known escape
sequences. Convert the strings containing the dot language to raw.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 scripts/render_block_graph.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 3e1a2e3fa7..14b2d02ec2 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -53,16 +53,16 @@ def render_block_graph(qmp, filename, format='png'):

     graph = Digraph(comment='Block Nodes Graph')
     graph.format = format
-    graph.node('permission symbols:\l'
-               '  w - Write\l'
-               '  r - consistent-Read\l'
-               '  u - write - Unchanged\l'
-               '  g - Graph-mod\l'
-               '  s - reSize\l'
-               'edge label scheme:\l'
-               '  <child type>\l'
-               '  <perm>\l'
-               '  <shared_perm>\l', shape='none')
+    graph.node(r'permission symbols:\l'
+               r'  w - Write\l'
+               r'  r - consistent-Read\l'
+               r'  u - write - Unchanged\l'
+               r'  g - Graph-mod\l'
+               r'  s - reSize\l'
+               r'edge label scheme:\l'
+               r'  <child type>\l'
+               r'  <perm>\l'
+               r'  <shared_perm>\l', shape='none')

     for n in block_graph['nodes']:
         if n['type'] == 'block-driver':
@@ -83,8 +83,8 @@ def render_block_graph(qmp, filename, format='png'):
         graph.node(str(n['id']), label, shape=shape)

     for e in block_graph['edges']:
-        label = '%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
-                                  perm(e['shared-perm']))
+        label = r'%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
+                                   perm(e['shared-perm']))
         graph.edge(str(e['parent']), str(e['child']), label=label)

     graph.render(filename)
-- 
2.48.1



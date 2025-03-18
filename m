Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuZvw-0006Yw-DD; Tue, 18 Mar 2025 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvW-0006TT-P5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvV-0004X4-0u
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742315783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nSFEwDzD0/q5vdwxo+YqLLaHUGRDBgwOiRZZHxK+Rc=;
 b=G2yX0WYTeZa2ldYjfMTGu2SLjxzyfZwHRNApclIgatJDVfLWIXPdpYQzydMNHKS0yei4+a
 MKgKDa66ftcRyEUw0sSEoUL7fnSI1Wtqo6axS/V1eq9pbjqSvKrL5yhtLJwS8UtHrE1FPA
 3Kurk5HYqXKJ3Tl7K6uxQtfV8cS3vHw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-lT1krjGZNUuD0BF6tklUHg-1; Tue,
 18 Mar 2025 12:36:21 -0400
X-MC-Unique: lT1krjGZNUuD0BF6tklUHg-1
X-Mimecast-MFC-AGG-ID: lT1krjGZNUuD0BF6tklUHg_1742315780
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D89B19560B4; Tue, 18 Mar 2025 16:36:15 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB64A1955BE1; Tue, 18 Mar 2025 16:36:12 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH 2/3] scripts: render_block_graph: Implement proper argument
 parser
Date: Tue, 18 Mar 2025 17:36:03 +0100
Message-ID: <00eab2a417ecdb7f0ea7eaf3880806f3309133dc.1742315602.git.pkrempa@redhat.com>
In-Reply-To: <cover.1742315602.git.pkrempa@redhat.com>
References: <cover.1742315602.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As no argument parsing is employed the script is hard to use and when
running without arguments it blurbs:

 $ ./scripts/render_block_graph.py
 Traceback (most recent call last):
   File "/home/pipo/git/qemu.git/./scripts/render_block_graph.py", line 135, in <module>
     obj = sys.argv[1]
          ~~~~~~~~^^^
 IndexError: list index out of range

instead of an actionable error. The user then usually needs to read the
script to understand arguments.

Implement proper argument parsing via 'argparse'. The following
arguments will be supported:

 $ ./scripts/render_block_graph.py --help
 usage: render_block_graph.py [-h] [--socket SOCKET] [--vm VM] [--uri URI] [--output OUTPUT]

 Tool that renders the qemu block graph into a image.

 options:
   -h, --help       show this help message and exit
   --socket SOCKET  direct mode - path to qemu monitor socket
   --vm VM          libvirt mode - name of libvirt VM
   --uri URI        libvirt URI to connect to
   --output OUTPUT  path to output image; .png suffix will be added; in libvirt mode default is the name of the VM

Usage then requires one of '--vm' or '--socket'. In libvirt mode the
output file is by default populated from the VM name and the '--uri'
parameter allows overriding the libvirt connection uri.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 scripts/render_block_graph.py | 53 ++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 14b2d02ec2..7a6738410c 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -23,6 +23,7 @@
 import subprocess
 import json
 from graphviz import Digraph
+import argparse

 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
 from qemu.qmp import QMPError
@@ -91,13 +92,19 @@ def render_block_graph(qmp, filename, format='png'):


 class LibvirtGuest():
-    def __init__(self, name):
+    def __init__(self, name, uri=None):
         self.name = name
+        self.uri = uri

     def cmd(self, cmd):
         # only supports qmp commands without parameters
         m = {'execute': cmd}
-        ar = ['virsh', 'qemu-monitor-command', self.name, json.dumps(m)]
+        ar = ['virsh']
+
+        if self.uri:
+            ar += ['-c', self.uri]
+
+        ar += ['qemu-monitor-command', self.name, json.dumps(m)]

         reply = json.loads(subprocess.check_output(ar))

@@ -108,15 +115,41 @@ def cmd(self, cmd):


 if __name__ == '__main__':
-    obj = sys.argv[1]
-    out = sys.argv[2]
+    parser = argparse.ArgumentParser(
+            description='Tool that renders the qemu block graph into a image.')
+
+    parser.add_argument('--socket',
+                        help='direct mode - path to qemu monitor socket')
+
+    parser.add_argument('--vm', help='libvirt mode - name of libvirt VM')
+    parser.add_argument('--uri', help='libvirt URI to connect to')
+
+    parser.add_argument('--output',
+                        help='path to output image (.png suffix added);'
+                             'in libvirt mode default is the name of the VM')
+
+    args = parser.parse_args()

-    if os.path.exists(obj):
-        # assume unix socket
-        qmp = QEMUMonitorProtocol(obj)
+    if (args.socket and args.vm) or (not args.socket and not args.vm):
+        print("One of --socket or --vm is required.", file=sys.stderr)
+        parser.print_help()
+        sys.exit(1)
+
+    if args.socket:
+        qmp = QEMUMonitorProtocol(args.socket)
         qmp.connect()
-    else:
-        # assume libvirt guest name
-        qmp = LibvirtGuest(obj)
+
+    if args.vm:
+        qmp = LibvirtGuest(args.vm, args.uri)
+
+        if args.output:
+            out = args.output
+        else:
+            out = args.vm
+
+    if not out:
+        print("--output required", file=sys.stderr)
+        parser.print_help()
+        sys.exit(1)

     render_block_graph(qmp, out)
-- 
2.48.1



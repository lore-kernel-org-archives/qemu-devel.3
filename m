Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81A9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuZvt-0006X8-4T; Tue, 18 Mar 2025 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvT-0006SF-Nu
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuZvR-0004W2-Ul
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742315780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aD3XptiGY0q8bTfzzfMt/ed3Ps/Cu6ykYAwObd+Bvlg=;
 b=TWVVoKv1qTqok2vGNC/602BxM2xZaxDZig5TLy0yJ9UCMW9QtWAE9a3xldB6XgULuz41As
 HX4v6qlfiNRfdZZ0DEX3mNH+8BtldZ0wufPojoOrepOFkFqxvB4eD0cu+tsGkA72QCHW7q
 7A3Mkuw49cYxw9SzekLnEShIBURKwns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-oUK13ubXPp6UNrzVDEwBaQ-1; Tue,
 18 Mar 2025 12:36:18 -0400
X-MC-Unique: oUK13ubXPp6UNrzVDEwBaQ-1
X-Mimecast-MFC-AGG-ID: oUK13ubXPp6UNrzVDEwBaQ_1742315777
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 805F6180AF55; Tue, 18 Mar 2025 16:36:17 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7C901955BEF; Tue, 18 Mar 2025 16:36:15 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH 3/3] scripts: render_block_graph: Avoid backtrace on error
 from virsh
Date: Tue, 18 Mar 2025 17:36:04 +0100
Message-ID: <8926805f0283b8aca7d709ae06b1103db857cbde.1742315602.git.pkrempa@redhat.com>
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

An error from virsh spews also backtrace:

  $ ./scripts/render_block_graph.py --vm doesnotexist
  error: failed to get domain 'doesnotexist'
  Traceback (most recent call last):
    File "/home/pipo/git/qemu.git/./scripts/render_block_graph.py", line 152, in <module>
      render_block_graph(qmp, out)
      ~~~~~~~~~~~~~~~~~~^^^^^^^^^^
    File "/home/pipo/git/qemu.git/./scripts/render_block_graph.py", line 47, in render_block_graph

 [snipped]

instead of just the important bits:

  $ ./scripts/render_block_graph.py --vm doesnotexist
  error: failed to get domain 'doesnotexist'

Catch the exception and exit. 'virsh' already printed the error.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 scripts/render_block_graph.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 7a6738410c..e2bb83b60e 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -106,7 +106,10 @@ def cmd(self, cmd):

         ar += ['qemu-monitor-command', self.name, json.dumps(m)]

-        reply = json.loads(subprocess.check_output(ar))
+        try:
+            reply = json.loads(subprocess.check_output(ar))
+        except subprocess.CalledProcessError:
+            sys.exit(1)

         if 'error' in reply:
             raise QMPError(reply)
-- 
2.48.1



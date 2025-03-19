Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F80C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwHa-00073E-BR; Wed, 19 Mar 2025 12:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHQ-0006yC-FJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHJ-00028s-3Z
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL0VXRjpyTvkmdCK6M/T5I1ZxCkjFirYEe1Pxoa76DM=;
 b=F/IRB1Ax1Q1X6GNXi2Mz/V/HZoKw0/IoEGz0BVCuZr15OSGXa7KRI/mPE/onnnrc3wGQtn
 lOVG9kK5QqM/QCcBSY7eDiVOnFmO8b4n5SRm6j8yv10xS09QC1Px2zDyuGQA6ZPrqTo8wt
 eR1W5VCL4fVuRa6C0kVY81VGF+eZ7fA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-D5X5mIZLNhWVFlJ_7coi-w-1; Wed,
 19 Mar 2025 12:28:21 -0400
X-MC-Unique: D5X5mIZLNhWVFlJ_7coi-w-1
X-Mimecast-MFC-AGG-ID: D5X5mIZLNhWVFlJ_7coi-w_1742401700
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D427A195608A; Wed, 19 Mar 2025 16:28:20 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2B7218001D4; Wed, 19 Mar 2025 16:28:18 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Pavel Hrdina <phrdina@redhat.com>
Subject: [PATCH v2 3/3] scripts: render_block_graph: Avoid backtrace on error
 from virsh
Date: Wed, 19 Mar 2025 17:28:09 +0100
Message-ID: <da2ffe5957c9ee567df85662d2050a31e6dd0ecf.1742401551.git.pkrempa@redhat.com>
In-Reply-To: <cover.1742401551.git.pkrempa@redhat.com>
References: <cover.1742401551.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 6f668dec51..3bfc751caa 100755
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



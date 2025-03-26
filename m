Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDEFC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRrB-0001NQ-Rg; Wed, 26 Mar 2025 10:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txRr9-0001N1-0B
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txRr7-0007dZ-7g
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742999744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qXjxZAG5fRNrK2Q2mOYRodDYqIxXJqQQeXyJ33SLNxU=;
 b=PhWkd9aJtr8TrETVdJPnbr3uJ1l/q9M7WB/LXn+uaG/iBycsIDS7ImPbPJ1/Wwml+LpBQ3
 MXUjaCjOkDXWWt0tYZKTMXvUcaLOiKuDiU3mzAEFQb1765vuIe4sG75Xy17kqnAyoPKiK0
 iR11nqwNDv8mqd3xXy7YRvxCac/H0LM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-bG-DQvlcN5KMJTEVBWB8gw-1; Wed,
 26 Mar 2025 10:35:39 -0400
X-MC-Unique: bG-DQvlcN5KMJTEVBWB8gw-1
X-Mimecast-MFC-AGG-ID: bG-DQvlcN5KMJTEVBWB8gw_1742999739
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B34BD1809CA5; Wed, 26 Mar 2025 14:35:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76A3519541A5; Wed, 26 Mar 2025 14:35:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org
Subject: [PATCH v2] Revert "iotests: Stop NBD server in test 162 before
 starting the next one"
Date: Wed, 26 Mar 2025 15:35:33 +0100
Message-ID: <20250326143533.932899-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

This reverts commit e2668ba1ed44ad56f2f1653ff5f53b277d534fac.

This commit made test 162 fail occasionally with:

 162   fail      [13:06:40] [13:06:40]   0.2s   (last: 0.2s)  output mismatch
 --- tests/qemu-iotests/162.out
 +++ tests/qemu-iotests/scratch/qcow2-file-162/162.out.bad
 @@ -3,6 +3,7 @@
  === NBD ===
  qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address
   resolution failed for -1:10809: Name or service not known
  image: nbd://localhost:PORT
 +./common.rc: line 371: kill: (891116) - No such process
  image: nbd+unix://?socket=42

The nbd server should normally terminate automatically, so trying to
kill it here now seems to cause a race that will cause a test failure
when the server terminated before the kill command has been executed.

The "Stop NBD server" patch has originally been written to solve another
problem with a hanging nbd server, but since that problem has been properly
solved by commit 3e1683485656, we now don't need the "_stop_nbd_server" here
anymore.

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Fix bad hash ID in the commit description (thanks Hanna!)

 tests/qemu-iotests/162 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 956c2c5f339..94dae60d304 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -65,7 +65,6 @@ done
 
 $QEMU_IMG info "json:{'driver': 'nbd', 'host': 'localhost', 'port': $port}" \
     | grep '^image' | sed -e "s/$port/PORT/"
-_stop_nbd_server
 
 # This is a test for NBD's bdrv_refresh_filename() implementation: It expects
 # either host or path to be set, but it must not assume that they are set to
-- 
2.49.0



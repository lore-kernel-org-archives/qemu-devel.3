Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D571C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Swh-0005uB-Qc; Thu, 03 Apr 2025 18:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0Swb-0005ti-Pe
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u0SwZ-0006Ir-80
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743718909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2ngaavqlUC9tZvJiDgqRpWihwprDOHT4VPr84qRsjE=;
 b=FkGI4Tz+YIzrPjElydaCLnUnejVbdABGsjhgq9J+45jTPgRREku5N8JBrDhGC45co585AD
 grfDTHtDHhIoGtCFvWWNIE3BqMVuP1TVhbv2BcTMonYTMbm06u6BlooIEL8IobNx3YqIJR
 rAGGXvymJJfV+Q4tEl/8c2meJkkKDtA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-AvCOKM1OOja80FZiPFwAYw-1; Thu,
 03 Apr 2025 18:21:46 -0400
X-MC-Unique: AvCOKM1OOja80FZiPFwAYw-1
X-Mimecast-MFC-AGG-ID: AvCOKM1OOja80FZiPFwAYw_1743718905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 711AA180034D; Thu,  3 Apr 2025 22:21:44 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 130EF1828AA4; Thu,  3 Apr 2025 22:21:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 1/1] Revert "iotests: Stop NBD server in test 162 before
 starting the next one"
Date: Thu,  3 Apr 2025 17:19:27 -0500
Message-ID: <20250403222139.1317475-4-eblake@redhat.com>
In-Reply-To: <20250403222139.1317475-3-eblake@redhat.com>
References: <20250403222139.1317475-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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
Message-ID: <20250326143533.932899-1-thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
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
2.48.1



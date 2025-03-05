Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19137C28B22
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpxob-0007Mx-2h; Wed, 05 Mar 2025 18:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoU-0007Lz-FW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoS-0000EE-Ul
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741215963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CCYjAiR2HYdV55MJcpESwkQpowegStqk4yTWsNqOxo=;
 b=IxSkLzyn4f8CUkMK6ID5yrFU29q1uX03zya/t7rapvd8i2Iy1oVXgSgeVgC8RtXPX4HfcR
 gPkbDu8PZcMHK/Z2FScHxt5Ucy6y8IJvMq1NT5E9TN8z9s/zqcBrCug9Ztkk2C3ewisMcv
 LzLS1/dr9gicMPlpvgmwBuOkP3ZazlE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-wYdRhcj1MTuznVzeH2PoVg-1; Wed,
 05 Mar 2025 18:05:51 -0500
X-MC-Unique: wYdRhcj1MTuznVzeH2PoVg-1
X-Mimecast-MFC-AGG-ID: wYdRhcj1MTuznVzeH2PoVg_1741215951
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E193C180087E; Wed,  5 Mar 2025 23:05:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B6561955DCE; Wed,  5 Mar 2025 23:05:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 2/4] iotests: Stop NBD server in test 162 before starting the
 next one
Date: Wed,  5 Mar 2025 17:05:22 -0600
Message-ID: <20250305230542.2225013-8-eblake@redhat.com>
In-Reply-To: <20250305230542.2225013-6-eblake@redhat.com>
References: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Test 162 recently started failing for me for no obvious reasons (I
did not spot any suspicious commits in this area), but looking in
the 162.out.bad log file, there was a suspicious message at the end:

 qemu-nbd: Cannot lock pid file: Resource temporarily unavailable

And indeed, the test starts the NBD server two times, without stopping
the first server before running the second one, so the second one can
indeed fail to lock the PID file. Thus let's make sure to stop the
first server before the test continues with the second one. With this
change, the test works fine for me again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250225070650.387638-1-thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/162 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 94dae60d304..956c2c5f339 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -65,6 +65,7 @@ done

 $QEMU_IMG info "json:{'driver': 'nbd', 'host': 'localhost', 'port': $port}" \
     | grep '^image' | sed -e "s/$port/PORT/"
+_stop_nbd_server

 # This is a test for NBD's bdrv_refresh_filename() implementation: It expects
 # either host or path to be set, but it must not assume that they are set to
-- 
2.48.1



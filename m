Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59131CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnwV-0003FS-G7; Thu, 08 Oct 2026 09:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnwB-0002ud-QU
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnw0-0002TN-RT
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+K+VQ0bywcPXjhezNpcEDL+/U48k3KTNJ+RDfUZVcMo=;
 b=SsUEVUlyiLxeUbJoUH7YD8M/RnwkovVWPlG+4KzLK8OTTeBPrrIjDEUddboi8zOIDvAyC5
 Kn+zhpUcj1nrq/jH9n/t1PmXrxAzv5/259j2nXDAdrBW3PyNEThPp+MrYG3eXlzKOABtUL
 /iiTTcyGosxLOJSWkO7FHP+RIjHx2Os=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-0WJscDCVMLiVWOdZZOggcg-1; Thu,
 08 Oct 2026 09:13:18 -0400
X-MC-Unique: 0WJscDCVMLiVWOdZZOggcg-1
X-Mimecast-MFC-AGG-ID: 0WJscDCVMLiVWOdZZOggcg_1791465197
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C34188307A; Thu,  8 Oct 2026 13:13:17 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31F8B30000E8; Thu,  8 Oct 2026 13:13:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 12/15] iotests/nbd-in-qcow2-chain: use default machine
Date: Thu,  8 Oct 2026 08:11:51 -0500
Message-ID: <20261008131216.2437896-29-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Farman <farman@linux.ibm.com>

Some of the NBD tests explicitly specify `-machine q35` which won't work
when running against, say, qemu-system-s390x.

The nbd-in-qcow2-chain test runs fine with the default machine on a z16
host, so allow it to run in other configurations.

Fixes: 24fd6d75b3 ("iotests: Add coverage of recent NBD qio deadlock fix")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260925194409.716498-2-farman@linux.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/nbd-in-qcow2-chain | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
index 455ddfa86fe..e35f072eba4 100755
--- a/tests/qemu-iotests/tests/nbd-in-qcow2-chain
+++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
@@ -43,7 +43,7 @@ TEST_IMG="$TEST_IMG.base" _make_test_img $size
 echo
 echo "=== Starting QEMU and exposing base image ==="

-_launch_qemu -machine q35
+_launch_qemu
 h1=$QEMU_HANDLE
 _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
 _send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
-- 
2.56.0



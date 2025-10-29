Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79997CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4y8-0003Vx-4h; Wed, 29 Oct 2025 08:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xG-00036T-Gr
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4x4-0004zX-FE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gRvYHHCROCtAqIn6dCl6PSPyw62CJBs+/oirAHeLJCw=;
 b=f30SPW0lbipUc0Q2Njf0Xh622fIuP7ofB4IcF2yeOhgZ1uWUC6Aa6KYzQwcH4IqqV6iZ8w
 wzewISf8XQQbBCfQiYFYnh6EujHuBzDYkl4R2NUntkWmAXNi7uzoOui9DadUB961wRCEj1
 oTmk8hfWsoILKRzppI2ykJLrzwdcDTM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-yzHmBEa_PhOcIj7bUJK6bQ-1; Wed,
 29 Oct 2025 08:06:50 -0400
X-MC-Unique: yzHmBEa_PhOcIj7bUJK6bQ-1
X-Mimecast-MFC-AGG-ID: yzHmBEa_PhOcIj7bUJK6bQ_1761739610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 035021956086; Wed, 29 Oct 2025 12:06:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABB1A180057C; Wed, 29 Oct 2025 12:06:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/18] iotests: Adjust nbd expected outputs to match current
 behavior
Date: Wed, 29 Oct 2025 13:06:22 +0100
Message-ID: <20251029120634.288467-7-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

'git bisect' confirms that the NBD iotests 94 and 119 have been broken
since commit effd60c8 in v9.0.0; but as Dan Berrange's efforts to
improve CI have proven, we haven't been reliably running them to
notice.  The change was good (moving coroutine commands to run in the
right context), but it meant that "execute":"quit" now waits to
complete until the coroutines tearing down NBD have first reported the
SHUTDOWN event, in the opposite order of what happened pre-patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context", v9.0.0)
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251013213638.494193-2-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/094.out | 2 +-
 tests/qemu-iotests/119.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index 97f894cf8f..9178474e79 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -23,6 +23,6 @@ Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
 {'execute': 'quit'}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/119.out b/tests/qemu-iotests/119.out
index 7b7f0f4bcc..45f82a4faa 100644
--- a/tests/qemu-iotests/119.out
+++ b/tests/qemu-iotests/119.out
@@ -5,7 +5,7 @@ QMP_VERSION
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 *** done
-- 
2.51.0



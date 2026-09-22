Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3617AC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970c-0002VO-Df; Tue, 22 Sep 2026 16:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zr-0000fJ-N1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zq-0000BF-1M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7TnWQ01G3TcbEQFLUIQl0E9NjvtZ2FR4jPTkDRy3h4=;
 b=hSLryurBN7oGdXh3ezPV6EYFrU+BE9e4WFQ+fbqjxV83JsoLwqEs6fQEMd4DTXiDv/PkRo
 YrARpkHp3Vkqm6BKjd/hGJG85koGctwHWNtyza/nmZv9SGOONZkkkSdzf1JVmzd6cVbPth
 auquVMKHDEjUeQ+L8g2v6GwSZ/c/vEo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-itxKMNkLMf235DJlbiw5Bg-1; Tue,
 22 Sep 2026 16:21:41 -0400
X-MC-Unique: itxKMNkLMf235DJlbiw5Bg-1
X-Mimecast-MFC-AGG-ID: itxKMNkLMf235DJlbiw5Bg_1790108500
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E941955EA5; Tue, 22 Sep 2026 20:21:40 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2373E756; Tue, 22 Sep 2026 20:21:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:49 +0400
Subject: [PATCH 42/88] qemu-iotests/image-fleecing: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-42-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3GzLtrngC5uDQhLaBblYQ9KxPJ9xR1689fuMdHIqCFM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxLps5xVgvL72IPNUYPjIlS7vRou4jtxma3
 LHi39UUht6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5eVAD/9qAALzc5M3UPpbI5pvxeJ2Y2cdR1rX7XGKvs9ZwJsmyDUH3bJcvXg5DuDuj/EJbj2jDFS
 FPyk1KMh9ofdtZq9o/VFTeFo4xQyjSefpQAG1x63oHqtOu/MgCgqJakDLdeKJPrIN1hPfwGOxuX
 l9/+LLVtO8rvaZxFIlzbEjIPMEJmiU9n2cAnUEeLcvm4F9eO7WE03tQhHjBHyrXOrk6RErs573R
 HE0N1LrBcx2UgalvCjdvIck/BD9d/XUVk/IEmYwemcH/CY+/y8kv6xY5t2g6LUjEL52X1TVj5Fm
 GlVPbmbHB8I1TaJ732V7fPnL+2y0Q8erwPH07vFvD2mMgbVipKU+hRv/LG57oGkrLHf9XiNxzMb
 Jm1PyD4q07yD2Mk2seZkCIUTIYau8xd7XUANa3gtyO0ukB06Hq30kYiFdf6BRSITpFr402MboYq
 yaC5QWWYfnFNpjLP0fijKTewwin0cFwE2rSryyiitjtfXHHtply2M+BznyBtlEvHraJZ/E6gmgj
 lpp7QfWHSheu2LBfo7GvLcP60GDePM81Qs8p3ZYfQ15jIkRUzfodBoJ6htNgDoidXoWICS+2p05
 gKVNU8kjt6hL3NEMn/c43ZLOrscr5DXXWi6xdGiZwUdjagSN+6ZMGzqOWCnp+4YJrepe42xw/qI
 eQIwl9WoBGnhwJA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

No need to log success.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/image-fleecing     |  5 ++---
 tests/qemu-iotests/tests/image-fleecing.out | 20 --------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 0142289843a8..5dff00977d3e 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -32,7 +32,6 @@ iotests.script_initialize(
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat'],
-    require_hmp=True,
 )
 
 patterns = [('0x5d', '0',         '64k'),
@@ -209,12 +208,12 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     for p in overwrite:
         cmd = 'write -P%s %s %s' % p
         log(cmd)
-        log(vm.hmp_qemu_io(qom_path, cmd, qdev=True))
+        vm.qmp_qemu_io(qom_path, cmd, qdev=True)
 
     if push_backup:
         # Check that previous operations were done during backup, not after
         # If backup is already finished, it's possible that it was finished
-        # even before hmp qemu_io write, and we didn't actually test
+        # even before qemu_io write, and we didn't actually test
         # copy-before-write operation. This should not happen, as we use
         # speed=1. But worth checking.
         result = vm.qmp('query-block-jobs')
diff --git a/tests/qemu-iotests/tests/image-fleecing.out b/tests/qemu-iotests/tests/image-fleecing.out
index acfc89ff0e99..a8c19615fc6b 100644
--- a/tests/qemu-iotests/tests/image-fleecing.out
+++ b/tests/qemu-iotests/tests/image-fleecing.out
@@ -31,13 +31,9 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 
 --- Verifying Data ---
 
@@ -101,13 +97,9 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 
 --- Verifying Data ---
 
@@ -172,13 +164,9 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 
 --- Verifying Data ---
 
@@ -250,13 +238,9 @@ read failed: Invalid argument
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 
 --- Verifying Data ---
 
@@ -318,13 +302,9 @@ Done
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
 write -P0xad 0x00f8000 64k
-{"return": ""}
 write -P0x1d 0x2008000 64k
-{"return": ""}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
 {"data": {"device": "push-backup", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"return": {}}
 

-- 
2.56.0.rc0.29.g47ce80527c56



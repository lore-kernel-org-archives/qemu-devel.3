Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60465C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yV-0005i7-MG; Tue, 22 Sep 2026 16:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yB-0004es-AY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y7-00086w-Bx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeztknFzlnU/nDvbX1f8VmXzvYDUa2KjfzS9HwyEXkk=;
 b=iXRRPTnscPuM3elN1xIoEFUsOKjUuqwr1WGhjgJYSoOj2AAZRkcHuGxRWUmeCNyCM6U26X
 mq+WP47tUwUk7QKEkauwLhL2JVL6tSR5Uprgbv9g6oXO0KuAx8bb4qP81uiil/wsxsch8s
 Lk2gBIxMSx9AWnS09X5+6iLQlLScmrY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-zKdT4ZaxO7-zs40lp_lgCQ-1; Tue,
 22 Sep 2026 16:19:57 -0400
X-MC-Unique: zKdT4ZaxO7-zs40lp_lgCQ-1
X-Mimecast-MFC-AGG-ID: zKdT4ZaxO7-zs40lp_lgCQ_1790108396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6C51955F3F; Tue, 22 Sep 2026 20:19:56 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38EF01800446; Tue, 22 Sep 2026 20:19:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:20 +0400
Subject: [PATCH 13/88] qemu-iotests/310: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-13-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aEEwoAgHbG3LoTAutO+AlDtApu6AteFRZg/C0d+T0WE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuxHQI1VA43ebuJpGeVYMnZchuWb5w5uSpj
 K30XSGFPwOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5dlFEACzu6Zc5x5jTfm6fb/dUKBA3oFSZa3lhjwsPsKoEDANpzNfi3RGY3Fj6o5jE8M9eVnluHi
 Jg6allSXmQ4Ujc8Rpcut4h7++trdMOl/xVCbGU7lrsiM/OBThUteBB7qq2jOc5KgdcDgcLXQgVZ
 DA1oT1SGtcGpu8daur1nNPZTsqWFaLNfmyTu3fMPK8vQmfs7p+CUJR4g5JF37PJuQAkHORZJL0o
 GHfT1kCwa8snMlnWrFSnznH4YsqVq/RkUNWhAdCq64Jko6zDphuMtIFfgZSZ7CpxsorMf0LxlRb
 JZjT9/j7NcY6QubqhDmYHPE2+0XhzVG5ksgwX7A7Lw0XLgPX6E2kRR5PHSbIcAUmIzVeIT5bbmq
 a0GLOHiS49oh8tmKCdxaqTeImDcMmZx+HJh6+JhM0CqaT3L6rCo2wluoi0Ikngx7TmyMJx6m+UT
 vdONsgTz3OCvfRSdd1N4TxOmkgU1Idth8JO0RGZopGeTtXZvs6lhE4869SeOWJ13eB+ILXnn7FV
 UQtYNPcRtV2deuL6ncDCdNZWSkfcGYMIKRnjUv51A4QYQlHKHDtNFrLKfl2IJjMuEFFa8hB4QNS
 XTSyLkTwQ5eRCWzSjllCmitFLXc+9PvbYDpI831NJDfBgWgIA8kiGwYa2Rjo9YE+989nIwTmNiw
 LO/+mFc2OV2Ztgw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/310     | 6 ++----
 tests/qemu-iotests/310.out | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/310 b/tests/qemu-iotests/310
index 7f290898fea0..5ca59fda8706 100755
--- a/tests/qemu-iotests/310
+++ b/tests/qemu-iotests/310
@@ -25,8 +25,7 @@ from iotests import log, qemu_img, qemu_io
 
 # Need backing file support
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          supported_platforms=['linux'],
-                          require_hmp=True)
+                          supported_platforms=['linux'])
 
 log('')
 log('=== Copy-on-read across nodes ===')
@@ -96,8 +95,7 @@ with iotests.FilePath('base.img') as base_img_path, \
                }))
 
     # Trigger COR
-    log(vm.qmp('human-monitor-command',
-               command_line='qemu-io node0 "read 0 5M"'))
+    vm.qmp_qemu_io('node0', 'read 0 5M', use_log=True)
 
     vm.shutdown()
 
diff --git a/tests/qemu-iotests/310.out b/tests/qemu-iotests/310.out
index a70aa5cdaeb9..b15bb93281eb 100644
--- a/tests/qemu-iotests/310.out
+++ b/tests/qemu-iotests/310.out
@@ -8,7 +8,8 @@ Done
 --- Doing COR ---
 
 {"return": {}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "read 0 5M", "device": "node0"}}
+{"return": {"human-readable-text": "read 5242880/5242880 bytes at offset 0\n5 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 --- Checking COR result ---
 

-- 
2.56.0.rc0.29.g47ce80527c56



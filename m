Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D12DFC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Ku-0006Nd-89; Fri, 13 Sep 2024 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kq-00069W-Pz; Fri, 13 Sep 2024 12:39:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000qD-9G; Fri, 13 Sep 2024 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=vEYGEDXABfP2ApaH+fC/vnkAPx15l1j90Jfj8gn89ys=; b=iyrExQZlIaCI
 rPNC2Y6YCdGOhjSAR00wvJ9CAWJ5fxM6LLqSbBlJ2P94NUg6WB0J4daBVVkVdP5sr5Rhec2GQEj5d
 IN0tGciZm3Q97nPBgy9SuBxXTklnkS3JXdPqEf0BASDYwxA8InADAGXl3cnxfCbwji73lZctjF9+U
 A/ubuLhF/wTgYEHUQ/CV+KqqZgcCtHrfroKilkOomkxzX+4InZLcmrA/R/dlfRttIbI+D7QugtRpM
 5zWvA87/fIXB//4Hojmfmnw/nLGMix5y6VNq1fd5IVdJl7mhXgP9DBNWCVDjSbBT7Il5tEYvZTUrI
 8lmsaa1I0umLqbosICIjqA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2q;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 05/12] iotests/common.rc: add disk_usage function
Date: Fri, 13 Sep 2024 19:39:35 +0300
Message-Id: <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the definition from iotests/250 to common.rc.  This is used to
detect real disk usage of sparse files.  In particular, we want to use
it for checking subclusters-based discards.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/250       | 5 -----
 tests/qemu-iotests/common.rc | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index af48f83aba..c0a0dbc0ff 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -52,11 +52,6 @@ _unsupported_imgopts data_file
 # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
 # anyway.
 
-disk_usage()
-{
-    du --block-size=1 $1 | awk '{print $1}'
-}
-
 size=2100M
 
 _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd..237f746af8 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -140,6 +140,12 @@ _optstr_add()
     fi
 }
 
+# report real disk usage for sparse files
+disk_usage()
+{
+    du --block-size=1 "$1" | awk '{print $1}'
+}
+
 # Set the variables to the empty string to turn Valgrind off
 # for specific processes, e.g.
 # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
-- 
2.39.3



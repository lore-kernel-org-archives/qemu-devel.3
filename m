Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA77CCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNqS-0001MW-QQ; Sat, 30 Aug 2025 11:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg5-0003c9-Vj; Fri, 29 Aug 2025 22:50:54 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg4-00088D-82; Fri, 29 Aug 2025 22:50:53 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7f7e89e4b37so260077485a.3; 
 Fri, 29 Aug 2025 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756522251; x=1757127051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qwx7Non1RKQkij6XP/CEOZXUJ1kdTiRPKXDqDi7L1NE=;
 b=eC2kBaebvVPOntPMu/wiDcHeLqhB5umi4Dt12j45XToWzyjP8MjWltHmbekhWJHjDJ
 0vOPCvD181/s0nmHWTGrL1hmcf3CnMWGKQhySLSuTxnwCkV0NvSXKMKUDOUwZMdlkLPy
 50vjYSHrGdPiIBR6QsuW5Oe04BWztCxm//xccJxDMnXE5I9CmH8fGNZWR156oNJvfzd9
 nbtNv8qYcyGklztInWF05OBgpfUncB0IP972NCOl5QhkEk/3JtLLM4VkdEWh5QErX6yy
 l59j3D2t4M4HAU7JoGysDqhhBL4YZyesyfLpCqS7FFzqd+ZKJM5Bvs3b5Z4yfHtI4NOa
 ZHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756522251; x=1757127051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qwx7Non1RKQkij6XP/CEOZXUJ1kdTiRPKXDqDi7L1NE=;
 b=djehV/yDWN8TkMpftauWuX3X/DbEFDtVKS2Mt63QR221bmYqYNvVpPGlNcrBgyJ2R4
 wdADN7+ivVX73yNcT0q99EFN0ghl8Nlmd1Xd9483WIT+7ZfSin0eqy7FnyMRoek3t0Ss
 kNQZOdXnN5LDex1fVled2ykXHTDszUkALw4z1MSj1ZURisLvc+e6OiyJe+/BAkX1FdHZ
 0nqjjzgY+oasXhPFnlkGzT/xn3I7j464HwY7dRPCHZMohud4fqDu/FSbTKWVeF7958om
 VutRJq0bgVWGMNBouPQ+hDZ/p52tWEcoykfakK3oTmX1HxKWcd+h91G+q+7cMNU6CQOk
 c7SA==
X-Gm-Message-State: AOJu0YzGz3NjIS7x/cPmJwNQ8iMY0T+MDXQc7B0t7YNsX73cm9RjiJAx
 2IC3vj5ykjBsRdI/SN9cUuqCGsOmnR0yLeQPmNo9ucsL5Qf/GrS+pseTwT/X6Q==
X-Gm-Gg: ASbGncsMT41rh82lAMgxFazwtGbHe/9rQQYs+ubZydIMquVkNSp9dLjerrSDs4o468V
 8LWkrsYuqoamk68VvSSYBA4Ur4VgYoku9wCrhDfaGUPOGXNwCVMfejY4dFwzUJ9BRDnHANJ3mjn
 dNRUrhnyMdelOYI4j3PA2FJTBkUulY8dJ9fbT07o/WAaXqBKFJ+wqfrOyeCrCbgs/nuytDYb+/z
 huwysQ0+kDHF1ZENFYGtOE8yjl2w5ajHcBajASOUeXc5wpaOUjiB9MbW41kaRZUlXkMA1M2yw11
 ZK8cx3kaIVu6a0Oq0SGJeJZus4xPzVbtrDC6C1dh6WHoOV+CoQYg7doQwH8fk4oz49XJ2k+Fufv
 fxM3fydtZ4+4jClTFHT/8CeQRo64Wi3AM4y4MiyUQ/14rjPoITJdSlMOkSgbPiMwP0HEheBIefK
 blolxYpGAp4swrV5lbchqhyJKbW4w=
X-Google-Smtp-Source: AGHT+IGXDfsIf0avkJ5sxwRhCFbRVyU9krZ2QlADQXNxoBq7/CyDcVLwJmFFJEogH/CEImWaTWSjyg==
X-Received: by 2002:a05:620a:7010:b0:7e9:f81f:ce72 with SMTP id
 af79cd13be357-7ff2ccd09e3mr99786185a.72.1756522250697; 
 Fri, 29 Aug 2025 19:50:50 -0700 (PDT)
Received: from localhost.localdomain
 (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca. [129.97.124.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0eacf1b4sm299457085a.21.2025.08.29.19.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 19:50:50 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
Date: Fri, 29 Aug 2025 22:50:25 -0400
Message-ID: <20250830025025.3610-5-hibriansong@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250830025025.3610-1-hibriansong@gmail.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To test FUSE-over-io_uring, set the environment variable
FUSE_OVER_IO_URING=1. This applies only when using the
'fuse' protocol.

$ FUSE_OVER_IO_URING=1 ./check -fuse

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 tests/qemu-iotests/check     |  2 ++
 tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 545f9ec7bd..c6fa0f9e3d 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
         mg.add_argument('-' + fmt, dest='imgfmt', action='store_const',
                         const=fmt, help=f'test {fmt}')
 
+    # To test FUSE-over-io_uring, set the environment variable
+    # FUSE_OVER_IO_URING=1. This applies only when using the 'fuse' protocol
     protocol_list = ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
     g_prt = p.add_argument_group(
         '  image protocol options',
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e977cb4eb6..f8b79c3810 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -539,17 +539,38 @@ _make_test_img()
         touch "$export_mp"
         rm -f "$SOCK_DIR/fuse-output"
 
-        # Usually, users would export formatted nodes.  But we present fuse as a
-        # protocol-level driver here, so we have to leave the format to the
-        # client.
-        # Switch off allow-other, because in general we do not need it for
-        # iotests.  The default allow-other=auto has the downside of printing a
-        # fusermount error on its first attempt if allow_other is not
-        # permissible, which we would need to filter.
-        QSD_NEED_PID=y $QSD \
-              --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
-              --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
-              &
+        if [ -n "$FUSE_OVER_IO_URING" ]; then
+            nr_cpu=$(nproc 2>/dev/null || echo 1)
+            nr_iothreads=$((nr_cpu / 2))
+            if [ $nr_iothreads -lt 1 ]; then
+                nr_iothreads=1
+            fi
+
+            iothread_args=""
+            iothread_export_args=""
+            for ((i=0; i<$nr_iothreads; i++)); do
+                iothread_args="$iothread_args --object iothread,id=iothread$i"
+                iothread_export_args="$iothread_export_args,iothread.$i=iothread$i"
+            done
+
+            QSD_NEED_PID=y $QSD \
+                    $iothread_args \
+                    --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
+                    --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off,io-uring=on$iothread_export_args \
+                &
+        else
+            # Usually, users would export formatted nodes.  But we present fuse as a
+            # protocol-level driver here, so we have to leave the format to the
+            # client.
+            # Switch off allow-other, because in general we do not need it for
+            # iotests.  The default allow-other=auto has the downside of printing a
+            # fusermount error on its first attempt if allow_other is not
+            # permissible, which we would need to filter.
+            QSD_NEED_PID=y $QSD \
+                --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
+                --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
+                &
+        fi
 
         pidfile="$QEMU_TEST_DIR/qemu-storage-daemon.pid"
 
@@ -592,6 +613,8 @@ _rm_test_img()
 
         kill "${FUSE_PIDS[index]}"
 
+        sleep 1
+
         # Wait until the mount is gone
         timeout=10 # *0.5 s
         while true; do
-- 
2.45.2



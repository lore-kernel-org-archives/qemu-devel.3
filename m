Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75287EE0ADA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:12:01 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8v-0007W3-Kn; Sat, 07 Feb 2026 07:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8m-0007GI-Lj
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:21 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8k-00038S-Ng
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:20 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3530715386cso1260650a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466217; x=1771071017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCy3i99i+qLbs/wAQI3hvrm5l/vGSJb2OpG7ZQh/YMA=;
 b=LNVSBaasX0HGb4h/d0CaoETSNAsUhQtvqCemdbZvTnhzjhKXtF94Vj80QebxVJqsIO
 VZ14NzV2LRvK7D7M+0HPsrrog48DlhIBRlk188AWLmsGDULMjF+Vtpbwc8IWcZjKMuKz
 5Vk2+Ws/v7WONu4tAc47E0lGwagl2ym3XQUsEa+CGeTjf4rehgIIpUfIJbCvdlVNNxKC
 ffsOBfFvF55XtRFVZ5IwS4Rey/KchINAcD6uce2iuxzUNZ80ksVq6/pty0kz78305avc
 NDvugQYSL1Jw+mj78OVxXnc7T7wEAOss9nAYUeL4qmaTSI3V/koHlqdyu13jrF0EvXYs
 CqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466217; x=1771071017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JCy3i99i+qLbs/wAQI3hvrm5l/vGSJb2OpG7ZQh/YMA=;
 b=M9bYv9I6/7EC2KOK0knOq1FgbJhvVC3Hx1BttBG1C/hlO91TCDKqI5eDbLVgHZxDVk
 0J9hqqgzpqeJ0NN61dcgovv7WM9cP77YxRwm9VM/QTJaCcpO5oUnEwxalxVvErwkol7w
 VSQr7xgIaBiFyfu4Ap/CKDzSBX0nugInO9s6+LlEwQTZUexlP8Y335bxYz2C/yivTAkX
 Pri7xVw2ULgjxbDqEdYkYTUqmQDX3v7D3y4+TR3fzB+nAO/5jOGBph4j0hTzddeZinOb
 Z7Dvj8hbSJSTKZqvgEkggVULiivV7/w4mnqkWHR/ElH6t8ClgOPlUv7N1PivjC1enZlm
 81RA==
X-Gm-Message-State: AOJu0YyTiOm6JCpedXoc4MW5oIfNkoFjiWWzTwuLthwESrO7axo6CjVH
 fOkc93ANKEpBBwOmVnoxbHghFrvv1xPxB/7+3jSf2NaBnVPTm2GTsmkX
X-Gm-Gg: AZuq6aI8W2u1dX0Rhhfs9ONe+esXFwv0th08gZkOc0fR/NogTOYTAaw7+G5b6hkciKJ
 2r//kh5/8ilyFk/cyDBSoyClA1Qb3NRIytT7LWjBIV4ZrIdTFPImyo5/0a+6HxrR5NrMAD/xAg6
 bNqBCmDmbJG3ofIP8PyiIJCh6N3gUPhB5cGQxl61282PJ5eFbsYWk8OidXUtYAMZXdTkjjiWTs5
 u6jPpXL2sUwI5y5fG2wnbwa//ZCy81pDJ/KAs8sEAhi+aIczS3+xoY3HUsjg6g1WgjXlMeLzBBW
 zXS0n0hwoKPfY6IjJZNuFrokOjGJR+1mW8bO5tJbSARgz03/4/dW8Rx0AyNnQIJZh6Y+I/bq04c
 W6mehdfOJBYkz3TtmBFXGVzZJsyqWtCflrqg7myQRcqbpG6oaQYrWQ1KQG8ugKaL/YbTK1YVqvx
 /0Rp8vuDNHnj1aJ/w+QCjAef8hEYPKBeP0KY0p
X-Received: by 2002:a17:90b:380b:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-354b3e338d5mr4916969a91.18.1770466216716; 
 Sat, 07 Feb 2026 04:10:16 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:10:16 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 7/7] fuse: add io_uring test support
Date: Sat,  7 Feb 2026 20:09:01 +0800
Message-ID: <20260207120901.17222-8-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=hibriansong@gmail.com; helo=mail-pj1-x1035.google.com
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

This patch adds support for testing FUSE-over-io_uring. It can be
enabled by setting the environment variable FUSE_OVER_IO_URING=1.

    $ FUSE_OVER_IO_URING=1 ./check -fuse

Additionally, the unmount detection logic is switched from `df` to
`mount`. Using `df` triggers `statfs()`, which attempts to communicate
with the FUSE daemon. During test teardown (when the daemon is being
killed), this often fails or returns stale data, causing the test to
misjudge the mount status.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 tests/qemu-iotests/check     |  2 ++
 tests/qemu-iotests/common.rc | 47 +++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 14 deletions(-)

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
index e977cb4eb6..a3e0ccb3d2 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -546,10 +546,37 @@ _make_test_img()
         # iotests.  The default allow-other=auto has the downside of printing a
         # fusermount error on its first attempt if allow_other is not
         # permissible, which we would need to filter.
-        QSD_NEED_PID=y $QSD \
-              --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
-              --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
-              &
+        if [ -n "$FUSE_OVER_IO_URING" ]; then
+            # The current Linux kernel requires registering `nr_cpu` Ring Queues
+            # when FUSE-over-io_uring is enabled. Here, we set half of the
+            # Ring Queues to FUSE Queues (`nr_iothreads`) to test the queue
+            # distribution feature.
+            # See the comments in fuse.c regarding the round-robin distribution
+            # between Ring Queues and FUSE Queues.
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
+            QSD_NEED_PID=y $QSD \
+                --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
+                --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
+                &
+        fi

         pidfile="$QEMU_TEST_DIR/qemu-storage-daemon.pid"

@@ -595,16 +622,8 @@ _rm_test_img()
         # Wait until the mount is gone
         timeout=10 # *0.5 s
         while true; do
-            # Will show the mount point; if the mount is still there,
-            # it will be $img.
-            df_output=$(df "$img" 2>/dev/null)
-
-            # But df may also show an error ("Transpoint endpoint not
-            # connected"), so retry in such cases
-            if [ -n "$df_output" ]; then
-                if ! echo "$df_output" | grep -q "$img"; then
-                    break
-                fi
+            if ! mount | grep -q "$img"; then
+                break
             fi

             sleep 0.5
--
2.43.0



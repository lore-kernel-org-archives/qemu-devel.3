Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBA7C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971X-00066z-5L; Tue, 22 Sep 2026 16:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970V-0002PR-5G
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970R-0000GW-4s
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8llSEfTpI770lJBMMM4akJ3fs76CK7fy8J4w0GKZ0k=;
 b=enoCUoC7u7+uZcqMSRN05swg0BWqf9yd1rKUhfNwObUJaglW93jalFA6I5At2YMkPousyi
 /OJC5bftsrOYpmLFsKnd30PPdlsTeIlKGem49K4RvoFH27tkT7KJOcvY86+kvht6XlW1PU
 y12CwJ1S+aJ+QE+q5Er8rh/YlM37XT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-Ok_oRx2_M7-CUzNHfPtKzw-1; Tue,
 22 Sep 2026 16:22:20 -0400
X-MC-Unique: Ok_oRx2_M7-CUzNHfPtKzw-1
X-Mimecast-MFC-AGG-ID: Ok_oRx2_M7-CUzNHfPtKzw_1790108539
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 342EE1801A0B; Tue, 22 Sep 2026 20:22:19 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3271E418; Tue, 22 Sep 2026 20:22:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:00 +0400
Subject: [PATCH 53/88] qemu-iotests/142: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-53-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=21030;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mhhIqeP7SFwjwjcM2BGNOxOGWwNaZVl9dOgVnA9nFhA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKypLqEbstmRM6a4AMu4idllBlDHDfucFPm0
 Z+JpfhKhzWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5SMKEACsQ0CND8ZyJ+Ao9BtGwJwf7K7j20jHmipRuq1hwEAgJQgI/9Ip5qkMqJg+aTixF9gWpZN
 1BYzSW9DbXMare+TpAMk9PTwOT9wqHtrPq/wVSQ7mnE9vnuNflUbtZKz6a57JQd8x2OVpQEGdR2
 GJUxNSZAqHhY22nsXB1FkOVcpjm1kGJHR+lluHEZYldtzysSJp+npDttSGy9bWlxHeES/hmuUhC
 kuRlOQJer+HNa0nnEX4tHSFibAVRB9TPxuHEtBIJrBVGejKT0HEHjsWEQhm8UjfU4rhxhwKUxjd
 OzTiQX0X+hX/ouvd3o6/oMTQzV167KfK7VIiViDdtxPqP5r7GjTIswfvBwIkNubyZvp+0HVW0Yx
 gIfTjxtBAMeh2YZhV5njBTZojdM91MgX5auPahhH1e0TkYiuuq/4IaQs/ZVvk0Ncl+OL8Yv0+Wd
 Ji0YxrvoiKv3TniMuJbx/hbIZFM6bkniPYWMRIkTlis4Fs0kNIHEAroHCeFOAdCNvtsdLNpWxU5
 DmJKiBZ5lSWfmOlsJEKZqanInTdxYw3h8RjqgI2Zno/Z2WK9y2BIrAMjuTKIFnn0mLbrdyMtgbR
 TMKaYczTVQXwBhXD0jp71V1V1kQT1EbF8NDpF6yBh5DPLEW5UU/uPXtAx4AzI0jXTMpwOtJuNQE
 hwGPfI2AQgqL+zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the HMP monitor (-monitor stdio) with QMP (-qmp stdio) for
testing cache mode configuration and inheritance.

The main changes are:

- Use query-block and query-named-block-nodes QMP commands instead of
  HMP "info block" to retrieve cache settings.

- Introduce _filter_qmp_cache(), a Python helper that parses QMP
  responses and prints cache modes.  Device names are looked up in
  query-block (backend-level cache) while node names are looked up in
  query-named-block-nodes (BDS-level cache), preserving the same
  semantics as HMP "info block <name>".

- Use QMP blockdev-snapshot-sync instead of HMP snapshot_blkdev.

- Use QMP x-qemu-io instead of HMP qemu-io for reopen operations.

The expected output changes only in formatting (QMP banners and JSON
responses replacing HMP banners).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/142     | 233 ++++++++++++++++++++++++++-------------------
 tests/qemu-iotests/142.out |  30 ++++--
 2 files changed, 157 insertions(+), 106 deletions(-)

diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 8538a727ac08..7a88c63d4acb 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -43,25 +43,92 @@ _supported_proto file
 # We test all cache modes anyway, but O_DIRECT needs to be supported
 _default_cache_mode none
 _supported_cache_modes none directsync
-_require_hmp
 
 do_run_qemu()
 {
-    echo Testing: "$@"
     (
+        echo "{ 'execute': 'qmp_capabilities' }"
         if ! test -t 0; then
             while read cmd; do
-                echo $cmd
+                echo "$cmd"
             done
         fi
-        echo quit
-    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
-    echo
+        echo "{ 'execute': 'quit' }"
+    ) | $QEMU -nographic -qmp stdio -nodefaults "$@" 2>&1
 }
 
 run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
+    (
+        echo Testing: "$@"
+        do_run_qemu "$@" | _filter_qmp
+    ) | _filter_testdir | _filter_qemu
+    echo
+}
+
+# Extract cache info from query-block and query-named-block-nodes QMP
+# output.  For each name passed as argument, prints its cache mode.
+# Device names are looked up in query-block (backend-level cache).
+# Node names are looked up in query-named-block-nodes (BDS-level cache).
+# Non-JSON lines (startup errors) are passed through.
+_filter_qmp_cache()
+{
+    local nodes=("$@")
+    python3 -c '
+import sys, json
+
+nodes = sys.argv[1:]
+lines = sys.stdin.read().strip().split("\n")
+
+cache_map = {}
+for line in lines:
+    line = line.strip()
+    if not line.startswith("{"):
+        if line and not line.startswith("Formatting"):
+            print(line)
+        continue
+    try:
+        resp = json.loads(line)
+    except json.JSONDecodeError:
+        continue
+    if "error" in resp:
+        print(resp["error"]["desc"])
+        continue
+    ret = resp.get("return")
+    if not isinstance(ret, list):
+        continue
+    for entry in ret:
+        if not isinstance(entry, dict):
+            continue
+        device = entry.get("device")
+        inserted = entry.get("inserted") if device is not None else entry
+        if inserted is None:
+            continue
+        cache = inserted.get("cache")
+        if cache is None:
+            continue
+        node_name = inserted.get("node-name", "")
+        if device is not None and device in nodes:
+            cache_map[device] = cache
+        elif device is None and node_name in nodes and node_name not in cache_map:
+            cache_map[node_name] = cache
+
+for name in nodes:
+    if name in cache_map:
+        c = cache_map[name]
+        mode = "writeback" if c["writeback"] else "writethrough"
+        if c["direct"]:
+            mode += ", direct"
+        if c["no-flush"]:
+            mode += ", ignore flushes"
+        print("    Cache mode:       %s" % mode)
+' "${nodes[@]}"
+}
+
+run_qemu_cache()
+{
+    do_run_qemu "$@" | _filter_qmp_cache $cache_nodes | \
+        _filter_testdir | _filter_qemu
 }
 
 size=128M
@@ -88,42 +155,45 @@ echo
 files="if=none,file=$TEST_IMG,backing.file.filename=$TEST_IMG.base"
 ids="node-name=image,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file"
 
+qmp_query="{ 'execute': 'query-block' }
+{ 'execute': 'query-named-block-nodes' }"
+
 check_cache_all()
 {
     # cache.direct is supposed to be inherited by both bs->file and
     # bs->backing
 
     printf "cache.direct=on on none0\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",cache.direct=on
     printf "\ncache.direct=on on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",file.cache.direct=on
     printf "\ncache.direct=on on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.cache.direct=on
     printf "\ncache.direct=on on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.direct=on | grep -e "Cache" -e "[Cc]annot|[Cc]ould not|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.file.cache.direct=on
 
     # cache.writeback is supposed to be inherited by bs->backing; bs->file
     # always gets cache.writeback=on
 
     printf "\n\ncache.writeback=off on none0\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.writeback=off | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",cache.writeback=off
     printf "\ncache.writeback=off on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.writeback=off | grep -e "doesn't" -e "does not"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",file.cache.writeback=off
     printf "\ncache.writeback=off on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.writeback=off | grep -e "doesn't" -e "does not"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.cache.writeback=off
     printf "\ncache.writeback=off on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.writeback=off | grep -e "doesn't" -e "does not"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.file.cache.writeback=off
 
     # cache.no-flush is supposed to be inherited by both bs->file and bs->backing
 
     printf "\n\ncache.no-flush=on on none0\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",cache.no-flush=on
     printf "\ncache.no-flush=on on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",file.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",file.cache.no-flush=on
     printf "\ncache.no-flush=on on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.cache.no-flush=on
     printf "\ncache.no-flush=on on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$files","$ids",backing.file.cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids",backing.file.cache.no-flush=on
 }
 
 echo
@@ -132,11 +202,8 @@ echo
 
 # First check the inherited cache mode after opening the image.
 
-hmp_cmds="info block none0
-info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -146,12 +213,9 @@ echo
 
 # Then trigger a reopen and check that the cache modes are still the same.
 
-hmp_cmds="snapshot_blkdev -n none0 $TEST_IMG.snap $IMGFMT
-info block
-info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'none0', 'snapshot-file': '$TEST_IMG.snap', 'format': '$IMGFMT' } }
+$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -162,12 +226,9 @@ echo
 # This one actually changes the cache mode with the reopen. For this test, the
 # new cache mode is specified in the flags, not as an option.
 
-hmp_cmds='qemu-io none0 "reopen -c none"
-info block none0
-info block image
-info block file
-info block backing
-info block backing-file'
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -c none' } }
+$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -178,12 +239,9 @@ echo
 # This one actually changes the cache mode with the reopen. For this test, the
 # new cache mode is specified as an option, not in the flags.
 
-hmp_cmds='qemu-io none0 "reopen -o cache.direct=on"
-info block none0
-info block image
-info block file
-info block backing
-info block backing-file'
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -o cache.direct=on' } }
+$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -193,13 +251,10 @@ echo
 
 # This checks that the original image doesn't inherit from the snapshot
 
-hmp_cmds="snapshot_blkdev -n none0 $TEST_IMG.snap $IMGFMT
-qemu-io none0 \"reopen -c none\"
-info block none0
-info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'none0', 'snapshot-file': '$TEST_IMG.snap', 'format': '$IMGFMT' } }
+{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -c none' } }
+$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -214,13 +269,11 @@ echo
 # BDS initialised with the json: pseudo-protocol, but still have it inherit
 # options from its parent node.
 
-hmp_cmds="qemu-io none0 \"reopen -o cache.direct=on,cache.no-flush=on\"
-info block none0
-info block image
-info block blkdebug
-info block file"
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -o cache.direct=on,cache.no-flush=on' } }
+$qmp_query"
+cache_nodes="none0 image blkdebug file"
 
-echo "$hmp_cmds" | run_qemu -drive if=none,file="blkdebug::json:{\"filename\":\"$TEST_IMG\",,\"cache\":{\"direct\":false}}",node-name=image,file.node-name=blkdebug,file.image.node-name=file | grep "Cache"
+echo "$qmp_cmds" | run_qemu_cache -drive if=none,file="blkdebug::json:{\"filename\":\"$TEST_IMG\",,\"cache\":{\"direct\":false}}",node-name=image,file.node-name=blkdebug,file.image.node-name=file
 
 echo
 echo "=== Check that referenced BDSes don't inherit ==="
@@ -236,35 +289,35 @@ check_cache_all_separate()
     # Check cache.direct
 
     printf "cache.direct=on on blk\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.direct=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.direct=on
     printf "\ncache.direct=on on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.direct=on -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.direct=on -drive "$drv_img"
     printf "\ncache.direct=on on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.direct=on -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk",cache.direct=on -drive "$drv_file" -drive "$drv_img"
     printf "\ncache.direct=on on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.direct=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile",cache.direct=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img"
 
     # Check cache.writeback
 
     printf "\n\ncache.writeback=off on blk\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.writeback=off | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.writeback=off
     printf "\ncache.writeback=off on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.writeback=off -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.writeback=off -drive "$drv_img"
     printf "\ncache.writeback=off on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.writeback=off -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk",cache.writeback=off -drive "$drv_file" -drive "$drv_img"
     printf "\ncache.writeback=off on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.writeback=off -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile",cache.writeback=off -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img"
 
     # Check cache.no-flush
 
     printf "\n\ncache.no-flush=on on blk\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.no-flush=on | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img",cache.no-flush=on
     printf "\ncache.no-flush=on on file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.no-flush=on -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk" -drive "$drv_file",cache.no-flush=on -drive "$drv_img"
     printf "\ncache.no-flush=on on backing\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile" -drive "$drv_bk",cache.no-flush=on -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile" -drive "$drv_bk",cache.no-flush=on -drive "$drv_file" -drive "$drv_img"
     printf "\ncache.no-flush=on on backing-file\n"
-    echo "$hmp_cmds" | run_qemu -drive "$drv_bkfile",cache.no-flush=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img" | grep -e "Cache" -e "[Cc]annot\|[Cc]ould not\|[Cc]an't"
+    echo "$qmp_cmds" | run_qemu_cache -drive "$drv_bkfile",cache.no-flush=on -drive "$drv_bk" -drive "$drv_file" -drive "$drv_img"
 }
 
 echo
@@ -273,10 +326,8 @@ echo
 
 # First check the inherited cache mode after opening the image.
 
-hmp_cmds="info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="$qmp_query"
+cache_nodes="image file backing backing-file"
 
 check_cache_all_separate
 
@@ -286,12 +337,9 @@ echo
 
 # Then trigger a reopen and check that the cache modes are still the same.
 
-hmp_cmds="snapshot_blkdev -n blk $TEST_IMG.snap $IMGFMT
-info block blk
-info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'blk', 'snapshot-file': '$TEST_IMG.snap', 'format': '$IMGFMT' } }
+$qmp_query"
+cache_nodes="blk image file backing backing-file"
 
 check_cache_all_separate
 
@@ -302,11 +350,9 @@ echo
 # This one actually changes the cache mode with the reopen. For this test, the
 # new cache mode is specified as flags, not as option.
 
-hmp_cmds='qemu-io blk "reopen -c none"
-info block image
-info block file
-info block backing
-info block backing-file'
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'blk', 'command': 'reopen -c none' } }
+$qmp_query"
+cache_nodes="image file backing backing-file"
 
 check_cache_all_separate
 
@@ -322,12 +368,9 @@ echo
 echo "--- Basic reopen ---"
 echo
 
-hmp_cmds='qemu-io none0 "reopen -o backing.cache.direct=on"
-info block none0
-info block image
-info block file
-info block backing
-info block backing-file'
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -o backing.cache.direct=on' } }
+$qmp_query"
+cache_nodes="none0 image file backing backing-file"
 
 check_cache_all
 
@@ -341,15 +384,13 @@ echo
 # TODO Implement node-name support for 'qemu-io' HMP command for -c
 # Can use only -o to access child node options for now
 
-hmp_cmds="qemu-io none0 \"reopen -o file.cache.direct=off,file.cache.no-flush=off\"
-qemu-io none0 \"reopen -o backing.file.cache.direct=off,backing.file.cache.no-flush=on\"
-qemu-io none0 \"reopen -c none\"
-info block image
-info block file
-info block backing
-info block backing-file"
+qmp_cmds="{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -o file.cache.direct=off,file.cache.no-flush=off' } }
+{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -o backing.file.cache.direct=off,backing.file.cache.no-flush=on' } }
+{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'none0', 'command': 'reopen -c none' } }
+$qmp_query"
+cache_nodes="image file backing backing-file"
 
-echo "$hmp_cmds" | run_qemu -drive "$files","$ids" | grep "Cache"
+echo "$qmp_cmds" | run_qemu_cache -drive "$files","$ids"
 
 echo
 echo "--- Alignment after changing O_DIRECT ---"
diff --git a/tests/qemu-iotests/142.out b/tests/qemu-iotests/142.out
index e20cfc8eb812..2769f354e867 100644
--- a/tests/qemu-iotests/142.out
+++ b/tests/qemu-iotests/142.out
@@ -6,24 +6,34 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/
 === Simple test for all cache modes ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=directsync
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value: invalid cache option

-- 
2.56.0.rc0.29.g47ce80527c56



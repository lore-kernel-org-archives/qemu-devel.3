Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A1C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Zm-0006T3-9X; Mon, 17 Aug 2026 15:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yr-0005zl-6H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yn-0006MS-Pl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4998590d392so40036145e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993188; x=1787597988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTB1V7zK+/ipDCsWgoyaofGyDwKvbgfAmLyT+QMpPvA=;
 b=lDcn8LmZphGItvDxf4/RfS6I3rbvzZDXrFug6M/fjaYUG+5X6i1V4yE8pbrr4UulUi
 2p80qa1JbVnsIYUMCC67COHWRXxnVa65m+EZEFBvDIYBTWcBToEBLiEZp9NLi1LLqO8i
 dyH0egO94eB0/5nvQQAjf1YAcGQFUDc6vHDvJ9LNDJyc4ES149n55dFLFO0MjdiQH/4v
 2nxu+W+LDxlyPBci5LXRh/9tHP7upfypCULfkyXfbkPXV0OUEdXcvlGFioVIxwfQD5jA
 bgPEP3Q6jW9Ra4HpG3Xsvbeg6DgVYAUWmyzLEEVNvE1tUYYzLdTciaDMs4PnnvTYnqBu
 fEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993188; x=1787597988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTB1V7zK+/ipDCsWgoyaofGyDwKvbgfAmLyT+QMpPvA=;
 b=mEuyEDydHuTw68mtHK3uvNYrgW7dbQUTuNGLGcGcIM9226vOElmYMa8TNmfA43NKEt
 9Ub79jSU22I/tH+/XBUKeFH5c39SObNQXRbbet2YdEWwoCf4EcRDPH7wHHKJjz32X3DR
 oEGFOXeAAGJbUNcUXVfO8vFXGs8lYHoYtzY9MIYkfRiwK8h769jEDnhvPriUHWD8NSZJ
 Vn3LmeKnYFlZ1uYSW2KYLRUVp/dmCnYK6eQNvihkk1dEVp9p9ouDyJWHN0q4P7igv0tl
 gJJC/J2dUD8WzMos7Vf9M3YRQGLto3wKfw1p3jacbbi/pSFtjbWymbOJC3olL+VLlyQW
 Mpog==
X-Gm-Message-State: AOJu0Yxf4Q1dNgBB+3fmqquaemG2P/GGRSnnKpH+aLT5GgfU5mUmgUjF
 aIlWKJIRyerf+PdHUUqeDHdtzjx7ztVoe+6t109ch5B1xAO+LVqu7ONqCDJFmsrNlpRXAHcekWH
 IPqd3
X-Gm-Gg: AR+sD11FRpggOPiWyTZ2w7MKW5nU3f1tejYLJv3l4/wPG7kjVvTOtiyT46tBdIDq2gf
 JP1v6g09mOjl0YWhFG9emQmdp/vNDurtX+0+OAcEq5lUQF9AvLhCCA8WWPPRBtwVjIUk7/onsgK
 t4FC6UJpCu+PPyj8eLXr311+FJtxN1G6h/+gk74tPRi+DixjT/m9g6C8Z3HqwvdiepK6gD+Jneg
 /ohh7yzfgCuSWnS65KXxESaypCjQ4Sbxur2fmbDfvnWOCnRpDMGoNZyrCMgMwG+dn0fJiuNtPhj
 QsCPTnXWdKp2CoWtzz87NldzU9wiiPHsovWSm+5okFkGFr1b9K9T9qRjJ3CR5OioFW3CXc7oFg/
 z2jSxOLmpbSqRHbDgd+H+wc6LzeQuXZE92xRyM9xNZJP7PbBVaurw2uQFisU4W/wVLiMcOXxEj6
 xXpt8re6nl/aa5oUCH1hnxsnIHWViz+EStqifVggRJsStSbFLQyg==
X-Received: by 2002:a05:600c:6089:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-4999fb847b5mr43101955e9.13.1786993188308; 
 Mon, 17 Aug 2026 11:59:48 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:47 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 03/25] iotests: cover inactivating a read-only node
Date: Mon, 17 Aug 2026 20:59:20 +0200
Message-ID: <20260817185942.1065143-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

A driver which writes something out on .bdrv_inactivate has nothing to
write for a node it can not write to, and has to answer such a request
with success rather than with the error its refused write produces.
The test inactivates nodes in several ways and never a read-only one,
so nothing caught that.

Add a read-only node and take it through a deactivation and back. The
case is generic, as every driver implementing the handler has to answer
the same way.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/inactive-node-nbd     | 14 ++++++++++++++
 tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
index 664157bfd0..24242265b1 100755
--- a/tests/qemu-iotests/tests/inactive-node-nbd
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -47,6 +47,7 @@ def node_is_active(_vm, node_name):
     return node['active']
 
 with iotests.FilePath('disk.img') as path, \
+     iotests.FilePath('ro.img') as ro_path, \
      iotests.FilePath('snap.qcow2') as snap_path, \
      iotests.FilePath('snap2.qcow2') as snap2_path, \
      iotests.FilePath('target.img') as target_path, \
@@ -58,6 +59,7 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('Preparing disk...')
     iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
     iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, ro_path, img_size)
 
     iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
                             snap_path)
@@ -70,6 +72,9 @@ with iotests.FilePath('disk.img') as path, \
                      'active=off')
     vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
+    vm.add_blockdev(f'file,node-name=ro-file,filename={ro_path},read-only=on')
+    vm.add_blockdev(f'{iotests.imgfmt},file=ro-file,node-name=ro-fmt,'
+                     'read-only=on')
     vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
     vm.add_blockdev(f'file,node-name=snap2-file,filename={snap2_path}')
 
@@ -289,6 +294,15 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log(qemu_io.cmd('map'), filters=[filter_qemu_io])
     qemu_io.close()
 
+    iotests.log('\n=== Inactivating a read-only node ===')
+
+    # A driver which writes something out on inactivation has nothing to
+    # write for a node it can not write to, and must not fail the request
+    vm.qmp_log('blockdev-set-active', node_name='ro-fmt', active=False)
+    iotests.log('ro-fmt active: %s' % node_is_active(vm, 'ro-fmt'))
+    vm.qmp_log('blockdev-set-active', node_name='ro-fmt', active=True)
+    iotests.log('ro-fmt active: %s' % node_is_active(vm, 'ro-fmt'))
+
     iotests.log('\n=== Resuming VM activates all images ===')
     vm.qmp_log('cont')
 
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
index a458b4fc05..3c43020053 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -227,6 +227,14 @@ discard failed: Operation not permitted
 qemu-io: Failed to get allocation status: Operation not permitted
 
 
+=== Inactivating a read-only node ===
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "ro-fmt"}}
+{"return": {}}
+ro-fmt active: False
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "ro-fmt"}}
+{"return": {}}
+ro-fmt active: True
+
 === Resuming VM activates all images ===
 {"execute": "cont", "arguments": {}}
 {"return": {}}
-- 
2.53.0



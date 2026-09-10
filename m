Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADB3C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pVQ-0000fT-CM; Thu, 10 Sep 2026 20:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPl-0001ij-9m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPe-0007Ck-IM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49e63568bfbso513455e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083757; x=1789688557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PTSvhPF/t9fH+un2rRT0I6FggMjWoGeZijLFp6youZ8=;
 b=QljilNWwiKBFj26pvyyrSm3/BovdVc7voVz/qkIc/bueBOrn2tf4rGw4Zm/8TgkQez
 /pZuFNz+TB2mm1H1JqENkVcgGDeMA6PWj6VKFG4MLfYIPbqKmIB2SfQxT2HuWdsfLXdU
 QnWfv5Y1/a2MBNZvK9ZxDI9ov4TUwtPLu+60VU21aYnXlDmR2kOhMdjZWu7okVAHoC1f
 qao/Ckg0q0BqR2q9aVvQzG2u8JGPUmb6sZtDyFfleViJCxGRjH2UD65aqGmI+L87W4RU
 OP0hfBHv1h9AAk9q0+QjQqjAHu3KO8XZ9xnUz6fEhBa8UrMNXF5bOZwAg5i/YOk71Zfb
 Uuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083757; x=1789688557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PTSvhPF/t9fH+un2rRT0I6FggMjWoGeZijLFp6youZ8=;
 b=j+/KnlvFc98AEv67Lg0MqAkthErh9lGxG9cFC+UdVTgDb744NzySw5bIe6zu9r3uzX
 JJz8OlE0Rw5ubb3Qcbh9iC1ZUdpkD9gVPprEC/pcUGRtFOezr461nt704/mM6+kh6u99
 TEcJY4/orGxpwamUoXpMgzOmUv5Ukgi6r9WcRrsvngWcokeRC3CZdZgBagHh4gXBFgMJ
 6CzqvSzHxpvBNMisIbib/Fm9gw5Z7qVYhhkt0oFDKxJnBi1cqR4ttSp2hmI0ECXHwJOi
 EGu26a7NvnGn3fiLRkCPqnVMANaSF7RsOkyfY3w51EVMC8qSgtS8+KFIyrWVF5cBJKCS
 kqBA==
X-Gm-Message-State: AFuF++l1wa5Zq9s+oMbzJKMcz9e8mM14XWt0sbxFZYfGx2D9+i7fQ6IY
 WqdBCd066FAAJTfzqPnHCNh72fWayQkBwa/mBMMjbNeRKn1sm4uWnJUIq+Tymv+4MVc=
X-Gm-Gg: AYBFou1zDbsmlE22ECppZmL4tHZCoNVb2Lmm/wfN1k7ggM+Tr0I9H1hoT3lPlzQ/Spk
 GOGp8PZflyQE6JX/mH4CSsZZaeaSHDZDA2VBvxLwR5/3JZ/FdFSo/x1cytWqCm5UbUId0wt5b94
 1U0yNQC2jo2cCSHTOCemgk226P1HUt6SQin8d0DeM31RJ6/9iO+8ozcfAZvDSfGbpsjsS3eC1iR
 LeMLPPo27oxdNlLEj0iqCzhZFO5xzhRw4w2DgtyN/V/o/7/bMSjUldM9aH0RUGoqq9T0hnXhIbb
 o+NZMsilEjTJc6U2sMOuqwJ2P/L7JFJcvLtmON/Kr56KI590UCcrkRpVwsYjEVASk7mVXI+8DxR
 nSTojXojaTqzq2dXNtQfsadmkzr72DBFSrXM0ZdS+HuQkmoGaPTmUz2+u6DyNFtQZ9LmIK/P789
 DgMpYlDWXGHe7NTK91ZlpyUsdIiD3iIvjFqqA93sL4bU2RGq4rFHLXi/+q1x5vXEYQvY77
X-Received: by 2002:a05:600c:698c:b0:49d:2803:22fe with SMTP id
 5b1f17b1804b1-49e619e1714mr18324985e9.32.1789083757065; 
 Thu, 10 Sep 2026 16:42:37 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 10/29] iotests: cover inactivating a read-only node
Date: Fri, 11 Sep 2026 01:42:03 +0200
Message-ID: <20260910234222.3039975-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 0fb8c18d87..96af7608de 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -227,6 +227,14 @@ qemu-io: discard failed: Operation not permitted
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



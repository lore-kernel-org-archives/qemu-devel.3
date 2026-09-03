Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D4C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f4-0002gC-DX; Thu, 03 Sep 2026 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ev-0002dY-2J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28es-0003zO-87
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso1741018f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446597; x=1789051397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PTSvhPF/t9fH+un2rRT0I6FggMjWoGeZijLFp6youZ8=;
 b=TyMuoAYNqbOnLFV9xWTauDpQs5b4/hZi56bnwMM3BGzflc/ZvVjXvfjORvAHujitd4
 YPaZiqrQw7rd5WhNRv2xnp9sFcRBZFbf8GtU1MGRwEtEbB201GbcvlGPGjqz1mNYtyjY
 PM60y+cUT/HnAKx/ZdQbQy1Yo08lfRimQZ2ybyzfxASFNmQdIgqHesCtM4QK/m2t39sx
 AqCptw9YI49xx2oHXzu/kdol/3HVqcxdASVL2WuxKXlR505d74/Fhh0ct0fz0jWdoqa1
 iuwdbtdCbyEzzdM0+O/w2V0NXwgl3nrzT6HRlb0savbd/QjiwnrFSvrBaOxjZM0uXhVl
 g5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446597; x=1789051397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PTSvhPF/t9fH+un2rRT0I6FggMjWoGeZijLFp6youZ8=;
 b=gKB+Wg4igX0ySCoMzgck0ehvWm8IKP/wUbdELdGRAHx3CYD6gIYAhbyPpNmwTKLGg6
 j1NFgPtNE4qZ1fWyW+PYiGltE05xqwgZLseYAcfUJqZhx62V9//6LKt6kV+V4fQ0TprF
 Bn72WnkqqtTDYe4kL1wRfAg7R2M9sK1CDDFLkX177TYRp4YzubBi+ShIj5Jt2fRjjqLI
 46wv+/p/yhGSA3FtJBBE+mA1aXAGeyTRVCJIjkwb8yTS2TwFU6iuDJ3zIrhM3xzLQQ50
 43op2nquR+c+INW2nN1QzYb3Rt7r2G1VOLgdjCDHz+6D9sTtm1MYAWBHzbF7VtrmjCuH
 FjZg==
X-Gm-Message-State: AFuF++kH1U0oUCqp8OauX1z1PDfuveQURSgTn6BgXhavtD6R14fBZd2b
 2dzkdkuJLr/6BPaMOtPF+L+dXEuRcGvvxWz+TvWo344zw4rcnhfLmL7gYDwJtrwRJWqJkICNh+b
 3wsq/
X-Gm-Gg: AYBFou0f7WZ7fJEfn+L3AnAJpzCgUHv4XP9zRGD8DgHZMp3QlZRh/LtBTbY8NeVKrVS
 KYEtJ/K/PD7sn4ozKxCAWgPz8ccbepPyXIdjIM9w5VcvDkWS4hR2IL3gxCPPVh7iXqdLUPwDFK+
 R8rq+om8A2MKFxq57crQCaTYkLwsCa9zYkYcMzfrCb5H0h9mrfJrkVFCcyp4vULMZGth2R3bDGy
 lKub4eWOnZtvdYM5bg61AsAHcSiu0XcGWHre4qnHy3CBF3Xs7DJ1B5Vud/GZjSyNDj+vOT+Psns
 Jun5pjb0mJAT4hUjoui0MCo2uloXKN7r8z/aoJl1g06cpq6iIUB0UI3iU7HzEmFJ4AQEvyAvi4O
 x+KRTuUpH3zBCeegCjd3Zk9hEok/EddmkbjM2+TGM7iFnw7iI4kj1jIWA+bXlNhn4YbY4ateblC
 Ofjcvwu8JjhY3dh3cUeKtJ4wsBjrhRmByq+ETm/7dnPxIoHKS5aVn1ApyeNv5x54MlYOI=
X-Received: by 2002:a05:6000:25ca:b0:482:fe64:1717 with SMTP id
 ffacd0b85a97d-48488dfb16amr21047556f8f.7.1788446595590; 
 Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 03/25] iotests: cover inactivating a read-only node
Date: Thu,  3 Sep 2026 16:41:21 +0200
Message-ID: <20260903144143.2328870-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D54C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9i3t-0002AK-0z; Thu, 24 Sep 2026 07:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3q-00028m-2J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3n-0003Nr-7H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:21 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so11154955e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790250977; x=1790855777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2of6IpDgSU0f/44dTod0e4ZV9C12++pxS+xEs2Nw4II=;
 b=kVrkq6+yAFjRx9mozla96x+ZzrdRt8L0azQQ0b72FLfw/dHsVUQ3sL4xxawXXXflR8
 ZbyvexrJQK3vuVXp47CmdYXtSwCk0lTb/Xmjf4nCn19wW6deXZCeYoYYrcg/UUIsRBCX
 oz6U2LezRo6AGpiNL08Og7iI8NCb9JItXPF33l6v/GoTFR2ETIA11FevhpvCP8nCKfNo
 tCBXN9l4xklkBMBUa9vjzok5s0X/lfniKUIy2ZCNBokX7GnDy+ZWm8yfRsN3qqgXKDRW
 T9ncuDXoViHjgXc5ecbi1499HxK5HfSQ5lVJ/zNUSfhquKj5zTkQJ8WqC6taiwfZHwc+
 wOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250977; x=1790855777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2of6IpDgSU0f/44dTod0e4ZV9C12++pxS+xEs2Nw4II=;
 b=ybPszUXTp69Ee59Yvq4ZnkGqyNQ4zj047t7LJ87Q3irIX0GSN5KQ2j0Ps5Qk4Gt6v5
 +Gil3eBYbrXhaVIy7K080nnZwsT0NjSwxqnOGSJINKjZToq/EVeX7THo8J7folPfnmgm
 6OsAAJtO7IPap2cSkt9B2eaZmSKUrran+aDAyh4irlqQ/pEGyNeZnP9dN6BbPfW2QctH
 b3h3JDdHBBBF+7nVfQW8SXN+fDok7bzSGnBu3Q0soAgqqh5l5XbWfQTNdaFqaQvsr2dP
 SuR52x5C/XSFZsajS+F4+nNfs4xkworSIIg9DyrH3dzjkNUAw5CjApJ7hBD/RMUDri0M
 16PQ==
X-Gm-Message-State: AFuF++nCfijptL70ec9dbVmdwv1+Zj5YzN5DZWEiq5FEgUbnFtvilab5
 P/va5X4i0BanR2PMk3Y6o1rvG3mHfX2Pgv93+O9JZukzbL5aE5Sh1Wwzj+7puI1zbQNVZE/7cnS
 EeLwh
X-Gm-Gg: AYBFou3oG1spihMTXVTrSdd8ZURnuQCrhP59iADel5Qi5Ii6yl+FzrBHv26viQGtHtP
 8PDlfH9AT16uZMGfyjBUjEGRj+PaaEpZUYfAW2odhforQgL9N9QFzoaxMHHXwrnD8p8W1XLUlC+
 Js1RNkx1C2ly5b4Zo6+KNPN9xJEUHa6YB009sP0OZcKQk3g4gX/+O8uQGbEjPqC8MFDkBc4VIAj
 gquW12i5fW4uioB8ldAnjFKXrohb44dLrP/htOckodoVgj45FvPR5o3nVzDS9IMHnqAUhpRVkAk
 l7f9lZOMpxpxSQy4VljjJKh1+OojGlXzpFthWarL44jizdbRcA+jFdGk97OiARDvLhVlyGFi8Qk
 LyQWv8Lf+NuiRLiEyjGg3SYHHwQ9iczwCsTt8WjcQKmNW6/3ESFnJomPaEEktGQ4/LjUY8LEwkN
 cg+vOoGzVFQn3ygZ73VfiE4nKSUWGVnbjJTSKktyaSYEntCQgRctBoxoJIH63avU8Xoys=
X-Received: by 2002:a05:600c:4e8b:b0:49f:ce78:356a with SMTP id
 5b1f17b1804b1-49fe66fb018mr37208515e9.27.1790250977594; 
 Thu, 24 Sep 2026 04:56:17 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cca160sm58870135e9.12.2026.09.24.04.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 04:56:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/2] iotests/migrate-bitmaps-postcopy-test: add a bitmap on a
 second node
Date: Thu, 24 Sep 2026 13:56:11 +0200
Message-ID: <20260924115611.4098417-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924115611.4098417-1-den@openvz.org>
References: <20260924115611.4098417-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

All bitmaps in the test live on drive0, so the source never switches
nodes after setup and the destination never resolves a node name from
the postcopy listen thread. Add a second drive with one bitmap and check
that it arrives intact.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 .../tests/migrate-bitmaps-postcopy-test       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index b2b37ada4b..36c281596d 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -27,6 +27,8 @@ debug = False
 
 disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
+disk_a1 = os.path.join(iotests.test_dir, 'disk_a1')
+disk_b1 = os.path.join(iotests.test_dir, 'disk_b1')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
@@ -97,16 +99,23 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b.shutdown()
         os.remove(disk_a)
         os.remove(disk_b)
+        os.remove(disk_a1)
+        os.remove(disk_b1)
         os.remove(fifo)
 
     def setUp(self):
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
         qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
+        qemu_img('create', '-f', iotests.imgfmt, disk_a1, '1G')
+        qemu_img('create', '-f', iotests.imgfmt, disk_b1, '1G')
         self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a,
                                                           'discard=unmap')
         self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
                                                           'discard=unmap')
+        # A bitmap on a second node makes postcopy switch nodes after setup
+        self.vm_a.add_drive(disk_a1)
+        self.vm_b.add_drive(disk_b1)
         self.vm_b.add_incoming("exec: cat '" + fifo + "'")
         self.vm_a.launch()
         self.vm_b.launch()
@@ -127,6 +136,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                node='drive0', name='bitmap0')
         empty_sha256 = result['return']['sha256']
 
+        self.vm_a.cmd('block-dirty-bitmap-add', node='drive1',
+                      name='bitmap0', granularity=granularity)
+        self.vm_a.hmp_qemu_io('drive1', 'write 0 64k')
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive1', name='bitmap0')
+        self.drive1_sha256 = result['return']['sha256']
+
         apply_discards(self.vm_a, discards1)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -212,6 +228,9 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         # check that bitmaps are migrated and persistence works
         check_bitmaps(self.vm_b, nb_bitmaps)
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive1', name='bitmap0')
+        self.assert_qmp(result, 'return/sha256', self.drive1_sha256)
         self.vm_b.shutdown()
         # recreate vm_b, so there is no incoming option, which prevents
         # loading bitmaps from disk
-- 
2.53.0



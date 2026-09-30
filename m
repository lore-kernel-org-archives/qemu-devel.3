Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D60CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW6-0007oL-KW; Wed, 30 Sep 2026 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVv-0006wD-Ss
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:39 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVn-0003Zp-AZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:33 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so33389595e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787020; x=1791391820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nk+gi0rQBaHti3N6byJTfS2qwKpbxxxTWgyInRcfQLo=;
 b=dDWlSbsHdS+Ekt4PUjWNuOBThHSju6yfCouHIpl9pjwIjo0Md+IijzwucTm17jQjHK
 HD2ke2PZm3Be2PIkCiD6L1bsmRSwGMNT3p9xJCaIBwJlo6/Zu1gUcYjRQuma8QLmnWny
 ptovVtFzNHB3tidp90df9RgnKzP2ZnqXP70eay7Zll7+4xiskmXo7vzy5ouSz5R0KbQa
 e75fTSNjXunvNJcS9Makt2AE0CtJU4YVMjAGnvZNHFToQw6QmDKxPD+mC8XTnBhomz/v
 UGpo1NkAaEzDeVFCfh/qZ2fEbz324c+cm3klq7GWfpTEVuz/Ip9ns3WLCeZ5wn6cXax9
 v9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787020; x=1791391820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nk+gi0rQBaHti3N6byJTfS2qwKpbxxxTWgyInRcfQLo=;
 b=MJkh5nX6C84Cpb8b1+7l5O2O81gFTQAafomFbpzABTPuj4BbrzP/vDXDaG00Ubbc4O
 eVwxwpyd89YZgwTJ9iXhsoglM4UejSt8gZVfVHDj2+jlYR5spxGe/HxxDU6hNV0Gf30w
 PuGQi3YpgUBkLdH2GuLbKIWV1FFAxbS0Xnp6Oyaj4PkmI0vv9UKvFXp+MOCZlcsHwEBk
 xAKZxeyJwbqC0Owjh7A1cveiD6YcQZqb5Y5cQYBDBz/8ycU4XXWStlMEp50cCh+qj040
 D0+AIY0WTp0QGSSG4vGr/JXaA8C2i3Kmye/Ga039iojz5kXC5s8Wgg9Ff6xKhQdtZuNP
 Bn+Q==
X-Gm-Message-State: AFuF++ndECmdTqyh7QCGBsSxu2OKQNxptXn49QNE3ujFDEtze8dXAMOL
 TXgCfjpfcmkJTeNT5w6GQ20WBW0/qb6jv2K+uSoIQ2mHDw8/YPFWOVtq9purUkLnTTg46qB5Qvx
 u9LcJ
X-Gm-Gg: AYBFou0PGfqIa9L6JYwY7btUfpUHvqFerupnj1Sz6+DC+1etneSJ9B1Soau+Iwaehwm
 w3By/dziR7fmg0GJzWl4wVLG28xTLTs1+qTNP/2pb7unsKC6R79qQLaACos+/KSd3OVezu41YxI
 FBQeX2u32V3h2xuEkJphBJajIaQQ9fcLCLWam7Jy8ez2AQNZdp5rKFqvaIIZB1GNSSK+PuUrIdq
 +dfd/y+Si7g74KtgSmWvVyhthvRg/yI2WOM2mm/a8nz0Pp+p+y6cm/etIOJVquPikwriMcKFNGB
 h9EOOXd2Gi6nOoaGn+gRKasyw0JFX+xTUDxTL9gG8GpCuh5CMZhuvicpUjoYnGpkwpJrXPvilqa
 e8TbEabrmENvxNGQXBTk/In3oNDevlJgQshLnWZtHVV9fAJkrwvIsH55Lvt7Hw+FtDObOUNHeTB
 mohWFn0tHc1KBrEZnqubjPgJz/sSx9NKRAHTruzLGXWWjPLkuXItNzmfzry3vADDVjczE=
X-Received: by 2002:a05:600c:1f87:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a01afe1e05mr37788825e9.19.1790787019885; 
 Wed, 30 Sep 2026 09:50:19 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:19 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 13/13] iotests/298: cover the preallocation races
Date: Wed, 30 Sep 2026 18:49:59 +0200
Message-ID: <20260930165000.303236-14-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
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

Three cases the filter has to get right, all deterministic: a write the
preallocation cannot reach goes through without waiting for it, a write
into the range it covers does not, and a write zeroes over data written
inside that range is not skipped as already zero.

The second one cannot wait for the write to finish, because that is
what it is checking does not happen, and the data survives either way:
a preallocation that finds the write still in flight gives up. It asks
whether the write got past the filter at all instead, by leaving a
breakpoint below it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/298     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  4 +--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 23e7789d09..866e00f8e0 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -27,6 +27,7 @@ GiB = MiB * 1024
 disk = os.path.join(iotests.test_dir, 'disk')
 overlay = os.path.join(iotests.test_dir, 'overlay')
 refdisk = os.path.join(iotests.test_dir, 'refdisk')
+racedisk = os.path.join(iotests.test_dir, 'racedisk')
 drive_opts = f'node-name=disk,driver={iotests.imgfmt},' \
     f'file.node-name=filter,file.driver=preallocate,' \
     f'file.file.node-name=file,file.file.filename={disk}'
@@ -225,6 +226,69 @@ class TestPreallocAsyncWrites(iotests.QMPTestCase):
         proc.close()
 
 
+class TestPreallocateRaces(iotests.QMPTestCase):
+    # blkdebug under the filter holds the preallocation before it is tracked.
+    opts = f'driver=preallocate,prealloc-align=65536,prealloc-size=262144,' \
+        f'file.driver=blkdebug,file.image.driver=file,' \
+        f'file.image.filename={racedisk}'
+
+    def setUp(self):
+        self.proc = None
+        with open(racedisk, 'wb') as f:
+            f.truncate(MiB)
+
+    def tearDown(self):
+        if self.proc:
+            self.proc.close()
+        os.remove(racedisk)
+
+    def qemu_io(self, *args):
+        self.proc = iotests.QemuIoInteractive('-g', *args, '--image-opts',
+                                              self.opts)
+        return self.proc
+
+    def test_write_below_preallocation(self):
+        proc = self.qemu_io('--object', 'iothread,id=t0')
+        proc.cmd('break pwritev_zero_untracked prealloc')
+        proc.cmd('aio_write -q -t t0 -P 0xaa 1M 64k')
+        proc.cmd('wait_break prealloc')
+
+        # Returns while the preallocation is parked only if it never waited.
+        out = proc.cmd('write -P 0xcc 4k 4k')
+
+        proc.cmd('resume prealloc')
+        proc.cmd('aio_flush')
+        self.assertIn('wrote 4096/4096', str(out))
+
+    def test_write_into_preallocation(self):
+        proc = self.qemu_io('--object', 'iothread,id=t0',
+                            '--object', 'iothread,id=t1')
+        proc.cmd('break pwritev_zero_untracked prealloc')
+        proc.cmd('aio_write -q -t t0 -P 0xaa 1M 64k')
+        proc.cmd('wait_break prealloc')
+        proc.cmd('break pwritev late')
+        proc.cmd('aio_write -q -t t1 -P 0xbb 1152k 64k')
+
+        # A held-back write never finishes; ask whether it got past the filter.
+        late = proc.cmd('resume late')
+
+        proc.cmd('remove_break late')
+        proc.cmd('resume prealloc')
+        proc.cmd('aio_flush')
+        data = proc.cmd('read -P 0xbb 1152k 64k')
+
+        self.assertIn('Could not resume request', str(late))
+        self.assertNotIn('Pattern verification failed', str(data))
+
+    def test_write_zeroes_over_written_data(self):
+        proc = self.qemu_io()
+        proc.cmd('write -q -z 1M 128k')
+        proc.cmd('write -q -P 0xaa 1M 64k')
+        proc.cmd('write -q -z 1M 256k')
+        out = proc.cmd('read -P 0 1M 64k')
+        self.assertNotIn('Pattern verification failed', str(out))
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'],
                  require_hmp=True)
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
index 6323079e08..52d796e60b 100644
--- a/tests/qemu-iotests/298.out
+++ b/tests/qemu-iotests/298.out
@@ -1,5 +1,5 @@
-..............
+.................
 ----------------------------------------------------------------------
-Ran 14 tests
+Ran 17 tests
 
 OK
-- 
2.53.0



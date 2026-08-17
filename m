Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F0C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aZ-0007mx-9r; Mon, 17 Aug 2026 15:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z8-0006CP-Af
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z2-0006Rt-AY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso48212075e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993202; x=1787598002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eOtnlSthIyUbYDQE781eStCJFY5oDrr5DFrAQ1ay8qU=;
 b=QdUbmivJAdP9crxZivNWM6wulqMqnV/ucJwgSR2IhW/Y2u66ztnd1/oBFcySbIniZH
 1rP7PIgxLwFXNCYNVWFu5GGVDfJRbfnvWm9+DFwG9m33svAJW52y1OuQ+oG5uXzB+xfQ
 OSesiy0bZGmru1pH7Lm6U6eqsNqDhHa30iopvV5Mo2tlyGRhnHH3xDylDkeGwGcNXYqH
 2nmHSAj8lcwi4kxOkTroZmEp5zjWLlYcflcWkISn5WxBUuF1Ce5oN5qV99U2ZHuhOrri
 io8nLzixgOSDCf3h1mxPIS4or0RbdEQgUkBrtPRWstgnlmo1fYPPP7bD5bSd1gCyVCx+
 J72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993202; x=1787598002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eOtnlSthIyUbYDQE781eStCJFY5oDrr5DFrAQ1ay8qU=;
 b=eJdZUhSlr5AJ+kDmw7zuYvrLD8Ay/rkM5J2/z1AObXEqsRgxOZCNR1jq1eXbF2z4SJ
 Ye2BLSVzXu5XFC2dLUwCcxU4mZ9y03ynAMQSr6jdSg8R+aAAmJxad9rMeEQbxug9KMhR
 VEzGSKvZElS1qMq5eywSFr0N7tMJDhf4pjfuNs4NVhJNv/HkoLI69lbpP90Uidv8Khct
 ilSKOrSE6EkpNmR5CyXv8jxE52yRKyrh4Yp6l8OyNBPf451TSBg/u6PvsxFjsOJ9cNHV
 ivS9z7OKKN2U/W1om9ory174CeQiUxtkHyAul+dlCEsxCbbHYwQjbEbWu8UaaxUhg7TS
 +keA==
X-Gm-Message-State: AOJu0Yy8nkiRS5/HB074NwSjK03M61UMg0eyWeI+1UxPUIEzJJse2tNH
 k5Op5H+qS82bFTy0/ikkfubySAHqYrRjGu/b33bRgu7OS13FsPseo4xVELWdWkGqAxBzpu+f6LP
 aBLG+
X-Gm-Gg: AR+sD13BtXxN96i7ouDbNGXaMncxtJ7HQm01uF//Wu+ygFiWPLvsJkLd420snkcwuH/
 RvacfNBZv3jN7TKtSBuBaykQzavQAjbL+Xq8Xj8iDEbB3wfP+RY6NkOqhPWWlxWk6kDdXdga9vq
 cp1yJRu8mw9EjuwTGAZPpoaw9uyxfXwsfVPxs1J5ht3MCgTZFE9wc+g3iqWgtzX5kLvCUYHutqu
 ff7C3fxiR1u7qGSvwnz+9VXY+4SZlqg2qkHbNeM5LXytiDxTMI5DlAU512g26TmC4FTjzsc1h7h
 D0PvadhXj7+QwwMncik48VgxyGvLI5NZrr6SSZspHwXE286FyvoRnnkBbinFUEx5uuImU1yEoNX
 ycOm8XUkBpxIbxE953Uwt4CJO27IccPN2vSPo6D4uMRYfPjGTLoF9Qt4d+nzIPptav1mBHRj5gA
 HvIzYInukEgd6eIX8lUHWgFPeZOEU92rGcCpeVfSc3YBs+GbN+SQ==
X-Received: by 2002:a05:600c:1546:b0:499:484a:98e7 with SMTP id
 5b1f17b1804b1-49987974700mr403413505e9.14.1786993202627; 
 Mon, 17 Aug 2026 12:00:02 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 15/25] iotests: run the persistent dirty bitmap test on
 parallels
Date: Mon, 17 Aug 2026 20:59:32 +0200
Message-ID: <20260817185942.1065143-16-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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

parallels stores persistent dirty bitmaps now, so test 165 applies to it
as well. The bitmap name is the only format specific bit: parallels
keeps it as the UUID identifying the bitmap in the image, so a name like
'bitmap0' is rejected on store.

test_reopen_rw is skipped, as parallels has no bdrv_reopen_prepare() and
blockdev-reopen fails with "does not support reopening files". Skipped
cases do not show up in the reference output, so 165.out stays as it is.

test_persistent covers what the series adds: it dirties the bitmap,
records its hash, restarts the VM twice and compares the hash again,
which passes only if the bitmap survives both the store on inactivation
and the load on open.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/165 | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b3b1709d71..5fd411974d 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -27,6 +27,12 @@ from iotests import qemu_img
 disk = os.path.join(iotests.test_dir, 'disk')
 disk_size = 0x40000000 # 1G
 
+# parallels stores a bitmap name as the UUID identifying it in the image
+if iotests.imgfmt == 'parallels':
+    bitmap_name = 'b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45'
+else:
+    bitmap_name = 'bitmap0'
+
 # regions for qemu_io: (start, count) in bytes
 regions1 = ((0x0fff00, 0x10000),
             (0x200000, 0x100000))
@@ -50,12 +56,12 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=bitmap_name)
         return result['return']['sha256']
 
     def checkBitmap(self, sha256):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=bitmap_name)
         self.assert_qmp(result, 'return/sha256', sha256);
 
     def writeRegions(self, regions):
@@ -65,7 +71,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def qmpAddBitmap(self):
         self.vm.qmp('block-dirty-bitmap-add', node='drive0',
-                    name='bitmap0', persistent=True)
+                    name=bitmap_name, persistent=True)
 
     def test_persistent(self):
         self.vm = self.mkVm()
@@ -100,6 +106,8 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
         self.vm.shutdown()
 
+    # parallels has no bdrv_reopen_prepare() yet
+    @iotests.skip_for_formats(('parallels',))
     def test_reopen_rw(self):
         self.vm = self.mkVm()
         self.vm.launch()
@@ -115,7 +123,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 != sha256_2 # Otherwise, it's not very interesting.
 
         self.vm.cmd('block-dirty-bitmap-clear', node='drive0',
-                    name='bitmap0')
+                    name=bitmap_name)
 
         # Start with regions1
 
@@ -152,6 +160,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'])
-- 
2.53.0



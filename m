Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B205C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pmK-0005lP-Ei; Thu, 10 Sep 2026 21:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ5-0001kA-4C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPv-0007GX-6t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so192106f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083773; x=1789688573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jfZ0sib9Q6CuIrjV7feNJ39M8KHkevHDagQkapzRWc=;
 b=cUVwSazRTi9UTqONOjXiXqK1cEHTdXcRuCvE319qNJmAiXpm6l4cpyQYpsK6Oc4og/
 8yl4PuFDag3lLIybyj+7JtfnC73MOWEnDot0blCHQAQAcumKzNnMMZVvHLkRVZmKQl5W
 NrR2O8Z4OkYFVrQi077VEp/4S0F8tGVZTWlroePwsRlWFCGgyIIOK4z7VP91fr9FVl1c
 EsQhCkmslSkTqtJkmS1J1HtY0+dAp7K9uEelXdon0aDxtqUtrqspwIgcPz2hM9Ddk6+F
 rkUYOOkjFFdbwZzhXSak0UwuOGeTKZrpkarXPdgnojlIh4eNYAAYKNzbSE72xYuBkDNG
 gpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083773; x=1789688573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jfZ0sib9Q6CuIrjV7feNJ39M8KHkevHDagQkapzRWc=;
 b=gs4WnJUn+pC7rYJBeIBprQ8phvd7UeULmbeblmtm9sXeMo6veAMjqDUCR1K6RuyJ+P
 yA1N+DBeXZNe6gUNOf4Cyes0e0S/W23+Bkt2xVbQwZ+Ft343bxyATYzGo/mMiZ4TUwzt
 kv10BLbvx/YDxYeQph+u8q5iDqaNzMmzg778LcHacT4edFfFTwgn6EYipIMl5EDavUqr
 x/czIjqWzO9AMTvYbV0qE/yTEJBFImcY+aCxttIkj4/wl2Rl0JhInWJBWyJmoQk58kom
 wCacmkltQFBODLHkR2/WhDJZ9l6vPixXXgVbdQV6TlcmT+d+IZtT9TSDYqtyn/HwPx/k
 yYSw==
X-Gm-Message-State: AFuF++mYJ7aT0cURkYPlkQA+9ipLafK+P5b2EOcveAtokRahHpitmWoM
 8XvmnyvaVqUzRaQbvkLAQovlvKN688no+Y7UVt8CvxB+yYDpLnH7thZy1sS0o1qB2YskvxszC2O
 YF+S6
X-Gm-Gg: AYBFou0zrvjKM2cyxGnIIZjaU2cVYJnPwCZPII943trg7I+pK0OvAV9nuKqeeBTGDrH
 L2hK33Ju+FYFYcIjBdsAWScVE9ySB7gHm/ronR1im8hbCkq8rR5Ul+UpdfmeDaeP3BANWFQhCg/
 4n4hS/7qT9JqWUMFnUmHguYp4JrfzpEAA2KdBaKuPFcTGQ8yjZBhghPqAcr3fNEJ+aLr5vEKu65
 6VGJByH0Q9DtWUYTYw3ErFuTMXpLGq8b+zhnqijoBjF3HKiqsLBwY+lwMzjDnf8NW9sfIcaqEMj
 AVfTCfwjBOmOdvXef1XfFVT4CfZkPJtbRVDCMfXqoN0a4k2tuBl7ImCREuqrhqgRvDjWNptkXpN
 0M5SPw+ryevtpX2lyJOu8DKIsJsARmjdh+FPivENenZemOHcCCOgIdDk12wj/uKD8J+oc/joruu
 9eNRSd9ykE8u8XsW8VjnJBRqKxO5GHEBt6W72zeo7YxI45naGPA7i3Va/fNW6DEPi55h3bmdnRW
 zXoc/Q=
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:a3d5 with SMTP id
 5b1f17b1804b1-49e619bfebcmr12244635e9.20.1789083773299; 
 Thu, 10 Sep 2026 16:42:53 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 22/29] iotests: run the persistent dirty bitmap test on
 parallels
Date: Fri, 11 Sep 2026 01:42:15 +0200
Message-ID: <20260910234222.3039975-23-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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
index 8fc79daae1..13b784fcc6 100755
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
 
@@ -152,7 +160,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'],
                  require_hmp=True)
-- 
2.53.0



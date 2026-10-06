Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488DDCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENDv-0003Ut-EL; Wed, 07 Oct 2026 04:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEIfD-0005yd-AU
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:50:20 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEIf6-0002ac-MA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:49:51 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5bcbd8df6fdso871919e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1791344980; x=1791949780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GSG5eI9J9gA2CNZ85JVT5WvSVphnqbW6RKvlDFGJvRA=;
 b=NdiIsJgGF3GBsOn9Ni4afMWAnrH04WQ1L7Z8e0LhKxmSyPw9ieRJC1IJj+7ig5J4SW
 IF/6+jvQGW/ReDnFjtm3rv8ZFVp4o3Haa0csCAaW5kReUHwFb92TqH5jcCBSD3IA5y+Y
 xE7m4g/WNyHZtfZe/zbmo9zZVXH7sCvRgP8KeY+uHZcJ9z075+JKXO4WPX8V2GnZ5wqZ
 uoqqscyC7/o1vjMSKJJlxsk4+dicMUbUJJTZ0KTNia5ovwXf2r70O8jHlaIAt5LY40or
 Q/uTltpGqgSArh5q+bFGgYP5KWbyC8CXMQ3c3EYq1vAKbjVbEzVYFUKKl2psIwu9ZJf0
 JkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344980; x=1791949780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GSG5eI9J9gA2CNZ85JVT5WvSVphnqbW6RKvlDFGJvRA=;
 b=KfolsOuxruIr3MvRO+otkscaoIcWfGdYpNhfZMAVqZxctY0l46PaJG0KgnWCsyyGOC
 5W/8VghfAARm7GANlmx9zcVb6SQAJC58xRGz4Pv0GpkPra6bPBT30V1rGJbOntdHxMeM
 DJplU4Ck+5DtWoC6J5ZGJAzkvQoqSWjDzlfPuctu/z6ki/asoXlP9n6sWM3DBlNR/O+T
 TwkVzLCRHs9vzLuwjbxghQXr2KDB1ZjNQBpNj/LXqwgnm0tIsO+OkY8Us7emb77CxdqM
 T/LNj1alOh27i0tqLB5gjXoVfz91M6RekNEvm0FQIflqs9jGowIXtjqGqLZav9TxMZia
 MkRg==
X-Gm-Message-State: AFq9FYK1w9uz8vAzYbrcE5n1J9DSZvipWES1sDEEaS5VkGXVbkpBbv9o
 xnma7en+AWma7jLKPQLBWwhwD8Up85osxZmgtHgsdWKK7JigS27c7Smz2vaq6uI2zWaDvOXngmv
 9wugF
X-Gm-Gg: AYBFou0o5KvJD5YBnWwkYOkMp1ksfUprlNPdSNOufdk8wDGIryzh5tIJNkvuvijD0m2
 q5gthBL+vqkP0mIBNRC9rHywUMrBprmyRjjHjp6IZAlpq+5keX8AJT81A1pztO8FnvkqpcFXF6d
 aJazg6w1WOe65Sl39WYjUcldyBvgcINJWxBktFUY+xwdcmLdDQoq/LRtYs5dMDWM/KHFAb+i2Fo
 pt3FRnjELNib4A+BqtsoEMJTaEt2eTzDyRWTHKtViYiQGJA91o+QG8lA12kEtBXVLQDPMrfdRMm
 mAiWdTgp/tlL+8zZj8TMeZxr7CzfRmRncjQtUEUfX4134mTIEGK1nwBspZK76bd+AGY8oMPHG9h
 wNc3Yj3DlzCt5lGnK1YuJbh55otH/orieTzcoTH8XQ7FeyVdESRSdqZKZowUyVKEd+aXC1XnZI9
 u3ZsxM4RdjEtUWUvxLZMjprvJTlwDSVjn8BDY4wYW333WF0iJpUhrcaj+8Bo/LzBRXrG4=
X-Received: by 2002:a05:600c:1f83:b0:4a0:2500:2cd0 with SMTP id
 5b1f17b1804b1-4a17b537e11mr33188345e9.18.1791306467137; 
 Tue, 06 Oct 2026 10:07:47 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a39a:8667:da6e:b69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5b9d6sm76254095e9.13.2026.10.06.10.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:07:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 3/3] iotests/migrate-bitmaps-postcopy-test: add a bitmap on
 a second node
Date: Tue,  6 Oct 2026 19:07:38 +0200
Message-ID: <20261006170738.453977-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006170738.453977-1-den@openvz.org>
References: <20261006170738.453977-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=den@openvz.org; helo=mail-lf1-x134.google.com
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

All bitmaps in the test live on drive0, so the source never switches
nodes after setup and the destination never resolves a node name from
the postcopy listen thread. Add a second drive with one bitmap and check
that it arrives intact.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
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



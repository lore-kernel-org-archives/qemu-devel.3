Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB28C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970I-00014w-TL; Tue, 22 Sep 2026 16:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zT-0008In-HO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zR-00006V-Ef
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ckm8SRSEwWZmPHm+F+FppvMG9LDEDyj4aXRm9+5O/+E=;
 b=RWz/qC+cXAXmgwCQx4D5RjJL9bQmyyEHhZoPwj6jc7UnqsgTp0Znkj36VBHwbPk5cAGaQQ
 /fb3yKheXmkgrYS3mLxO4AOmn+DM4lIv8jjez7EeH77T9OQPRDxkqF+EXKCs+mQSgJh4p2
 9iNLkpv0hwFbMTXRWhwqGfzWN4gZNR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-Chg8JXWLPoSr6q87RZUVnQ-1; Tue,
 22 Sep 2026 16:21:18 -0400
X-MC-Unique: Chg8JXWLPoSr6q87RZUVnQ-1
X-Mimecast-MFC-AGG-ID: Chg8JXWLPoSr6q87RZUVnQ_1790108478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE2A1955DDF; Tue, 22 Sep 2026 20:21:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D7D9180056E; Tue, 22 Sep 2026 20:21:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:43 +0400
Subject: [PATCH 36/88] qemu-iotests/260: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-36-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZKFxBDshMVxG1zhikar5BA4VB71xRdLmWyUDaDJZA7w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwrK+ZRWzSYelnjbtFKao6LWvsTSjvyw9+x
 1+VT+gmnsuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5T8NEACLBYdE//nzNcmmRxreFcXGJQY2bpBt7CdtXkH+NqBtMfkzBsjm3lPQmCgoCocf1+S4LCO
 BhcPLF97oH0wtd7F8iR7st+QIJHOepkGktE+wQ56Ra/fRE+kuFD5khMEQ0xbyQKI++wGwR27807
 jc9YgxMwPLkD9b5ncB5RnaxuxJUGHL1Z95cp6NFBRsjCbbruFoAZHp4UPu5M5anhsXYVRk90w5L
 zfDvMXmsWYngiZQclIUkPvwZGbTDLLY+0D1yEfmULHhdTZGhUJLfQC5kXjH+4YQQacEm0juv2i9
 GS97I6Z3Owf+9hAiZoPBsBPgT6mu/HVSQZaeGrFYLwVhdWyTWuGUo9N1oqspXoAgRYxm9x8LHSW
 /p4FZL7bKhyvOfeNCv/uWudJ5MlhQhekwyoqyhtQWxtC13lqumGMVEFnZyYuf9oofmA7HnqvXaT
 GhL2aAtM+7rI+2b3Lm1+95T0e9/mYN2xJnqibcswywB7C+QNjqZayTqVrT6LD78F8IZu0GECevk
 MfnGPBWaKhdr6kx0yLc43k34VydWwflP2pssnQFX3A/aJu6SSP2LEiXNX2oJUaJGeopIXvbNdUu
 TmLkdvvQNgsVI66VsQC/Aw/I/c13C/c4nmrWSA9qNJe5jyJ0gOZaUm2Tlo3Pokpde983Y4RLUeI
 vCM/Y0xC7vS3nnA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/260 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
index 65165446607c..6ca173aa020b 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -24,8 +24,7 @@ from iotests import qemu_img_create, file_path, log, filter_qmp_event
 
 iotests.script_initialize(
     supported_fmts=['qcow2'],
-    unsupported_imgopts=['compat'],
-    require_hmp=True,
+    unsupported_imgopts=['compat']
 )
 
 base, top = file_path('base', 'top')
@@ -55,12 +54,12 @@ def test(persistent, restart):
 
     vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0',
                persistent=persistent)
-    vm.hmp_qemu_io('drive0', 'write 0 64K')
+    vm.qmp_qemu_io('drive0', 'write 0 64K')
     print_bitmap('initial bitmap', vm)
 
     vm.qmp_log('blockdev-snapshot-sync', device='drive0', snapshot_file=top,
                format=iotests.imgfmt, filters=[iotests.filter_qmp_testfiles])
-    vm.hmp_qemu_io('drive0', 'write 64K 512')
+    vm.qmp_qemu_io('drive0', 'write 64K 512')
     print_bitmap('check that no bitmaps are in snapshot', vm)
 
     if restart:
@@ -84,7 +83,7 @@ def test(persistent, restart):
     log(filter_qmp_event(ev))
     print_bitmap('check bitmap after commit', vm)
 
-    vm.hmp_qemu_io('drive0', 'write 128K 64K')
+    vm.qmp_qemu_io('drive0', 'write 128K 64K')
     print_bitmap('check updated bitmap', vm)
 
     vm.shutdown()

-- 
2.56.0.rc0.29.g47ce80527c56



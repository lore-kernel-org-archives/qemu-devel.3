Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99835C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z7-0006zn-GN; Tue, 22 Sep 2026 16:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yX-0005tT-U7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yW-0008Dm-2l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uR0XPyXe0XDkCZ1aDXvNQKAOZQRc93eKEqjT8vUZN7w=;
 b=Hx2Qg6jmBfmXbSml9/hvgXeLpysP5cYGjF+q4wiEIRfExWla9z3CZN2Dqd0TIGSogXCLAT
 oeNs+1WqI2XCWpFDPLVLzFgpS8tfsH1eCTXXO6aVNu0ryb8tdspNsan4E8wC42iSRPsE0y
 YeAgbqEMDafRFyiQyxY8ywnfVXfbcdc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-k1ty7KX4N_-JUngWzuoNcw-1; Tue,
 22 Sep 2026 16:20:21 -0400
X-MC-Unique: k1ty7KX4N_-JUngWzuoNcw-1
X-Mimecast-MFC-AGG-ID: k1ty7KX4N_-JUngWzuoNcw_1790108420
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D24C119772E0; Tue, 22 Sep 2026 20:20:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06B373000223; Tue, 22 Sep 2026 20:20:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:27 +0400
Subject: [PATCH 20/88] qemu-iotests/152: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-20-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rQHnLcpQ3QhJYge5M2jfPGIdeLJ1sVSbfbngwrhRV58=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvl5P0h5y3VCGGMXZ8KLb4Z+fgMwW41Qk6M
 FYpXH750cGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5eXWD/4qT+r7CtMdFP4GpDjr5xIjJkKeP8Mcnt8VqUfHizSyUY4sxI0AKyx7L0doMinVM/Z0Hhv
 w8uwBLVk3TIoSAFGaNZa2JINmhQVNSqI1S8iYiQlSsCHo8BMZpSPK8dGQqZiIJucmi00YXbl8HE
 rSvava9zGE5pZFlZC8Z9gLEVBN+tyA1go5RO7UR66HlykSk6I4If1eYlvF13bbPAlYvMbq4zuki
 LxFULF8bhLSYdz0IveOS95EQ+UyugqPJlxm9bQ++TBaaL72ErUZVAVFpJdSbNCS7E9W+pwFeefe
 M6hVcR245ZlL4k4MwXJosYoiMttAEWvwaWIEzdHCTFaDALAVDek9i3NQyR0RNCEnCCzJhF9sSVF
 fo4QDGD82X3/H1kj0VZJiqAUGUd2YIkth29rseYhKzdlaZtMk22YBt87JLIqCyaQKUEib3+915r
 2UZa2Z8Bqx2J1o9MtQYw6yc9/1XX3Txt7VW1FTzLRUaywtsn05DjseNwwXFWvcXeg+U180F0NTI
 GkUuZ83w1fNnd+TrTXPXUQEcmbW6V0YiE3UhdSNiE9BHvMyiGoDWZc9mWwg1v8DzCHPkHAlZTsn
 k6TK9j3/6855RrS2rvIMBMoMmq2s2mNtut8VkhgDsHXqPAwKmiHc8YlMwcPQn/PrFRcvkdwyHLg
 DcvAq8hZtOeaFjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 tests/qemu-iotests/152 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index d9170359213a..f25c706273a3 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -52,7 +52,7 @@ class TestUnaligned(iotests.QMPTestCase):
         self.vm.cmd('drive-mirror', device='drive0', sync='full',
                     granularity=65536, target=target_img)
         self.wait_ready()
-        self.vm.hmp_qemu_io('drive0', 'write 0 512')
+        self.vm.qmp_qemu_io('drive0', 'write 0 512')
         self.complete_and_wait(wait_ready=False)
         self.vm.shutdown()
         self.assertEqual(iotests.image_size(test_img), iotests.image_size(target_img),
@@ -61,5 +61,4 @@ class TestUnaligned(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56



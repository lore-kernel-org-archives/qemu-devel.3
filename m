Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F154C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yY-0005uI-Sl; Tue, 22 Sep 2026 16:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yJ-0004pJ-E0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yG-00089B-Qj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GLoY4Zw+LeT4iB/oODQsrJ/ijf7cxwJruvuL54ie/E=;
 b=CrBU88B6dlFEOaojZefGH6fWJk8Pd5CZJpyWw7POLHy+vJlCL75vLHU4jaVqQNWHdcl/VF
 LU3yVjwn/i4GO9XyV5DGMysQQMBGrwzYrHE7pULXbbZ0Gld9UA8Ua0Sx+Y5Fp2Btxv7u6I
 my5SC1J0JZejTz2BacMcXBia0s5RvEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-HW1yJrEXOkSzSIHaTqM0ng-1; Tue,
 22 Sep 2026 16:20:04 -0400
X-MC-Unique: HW1yJrEXOkSzSIHaTqM0ng-1
X-Mimecast-MFC-AGG-ID: HW1yJrEXOkSzSIHaTqM0ng_1790108403
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16F141955F28; Tue, 22 Sep 2026 20:20:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46743766; Tue, 22 Sep 2026 20:20:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:22 +0400
Subject: [PATCH 15/88] qemu-iotests/281: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-15-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WbD4htSPwfv+XOHmp+8JUU8lEJZOKVWazxl8VoX/sgc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvMUIgEUccnjbZxerqcx1rs/4KBJXOd7KEQ
 orzbP9EM82JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5Zi9D/9UKC1DH8vcQRmqF87R8cV2Dh5ml1h0an6O7qh3e9oZhy3cVi6PCSxxW68JFsl7Lv3sn1C
 s+LBzPzJPQ/3mYaCIUsryXxliVfcXdJ2JK1sJm/6Oig6QApcR7TBSvzTz50bThfVIkEub2EsJK3
 Bim6QEFV5K7IzPAKbVA7kU1DGkjBTJ27pc8fZQNunOcBjuxznfGSOhg11DbOOENQJQQd0oBjDs6
 vHWGqhQgfYWZffc01BbnnO1NrI5B41+UTBeP3YhGyIMSmVhEFw6xnhjyP/NWrLCcsEvG2fxiv+8
 xxHDOzGl2dwkQaeko7Xs57bJ7sFUcXIdlqS4wYWJ6kc+SOr+79FE3nyJL4/z/etA1kc5B8DdetR
 n2iHOPc0otq4dgO1sc1YafIp91kE5P3O7MqQT6nzW1QdaAEGC9jrpIM/mTw20PFTIJWpNuRrVkk
 HuqcA1ulUT7rlTlDgLoVEDXW9eGpyykpNzWMZjlzJoCHc7LuaXWMjhk+RA1Tru6VNUHCAGI/hA4
 h25F+/UG4iFfWOH40FTxw6lxS0stSVAKYLcj1cCGe0LC9ikxl8fCBDBjNy1nT0uVBf4H5uORRwc
 UzO0MsxK8BYx5wY3mDy0MlmdEyT6bp4R3jjYzhemR8BVvJp1nRxOCBuxlJM2kIHZaGb2OI8og4R
 HVS9ibsuIsmQnLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/qemu-iotests/281 | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
index 5f3050f50d0b..65d34b427a43 100755
--- a/tests/qemu-iotests/281
+++ b/tests/qemu-iotests/281
@@ -273,9 +273,7 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
         self.stop_nbd_export()
         self.create_nbd_export()
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io nbd "write 0 512"')
-        self.assert_qmp(result, 'return', '')
+        self.vm.qmp_qemu_io('nbd', 'write 0 512')
 
         # Reconnect is done, so the reconnect delay timer should be gone.
         # (This is similar to how the open timer should be gone after open,
@@ -303,9 +301,7 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
         # Do some I/O that will be throttled by the QSD, so that the network
         # connection hopefully will yield here.  When it is resumed, it must
         # then be resumed in the I/O thread's AioContext.
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io nbd "read 0 128K"')
-        self.assert_qmp(result, 'return', '')
+        self.vm.qmp_qemu_io('nbd', 'read 0 128K')
 
     def create_nbd_export(self):
         assert self.qsd is None
@@ -336,5 +332,4 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
-                 unsupported_imgopts=['compat'],
-                 require_hmp=True)
+                 unsupported_imgopts=['compat'])

-- 
2.56.0.rc0.29.g47ce80527c56



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B971C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z8-00073M-Hg; Tue, 22 Sep 2026 16:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yp-0006FT-6u
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96ym-0008Qx-Oj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k0apT/gXx7rU8wyQb5f0m3GWi6qWdtJHX1UbVLCJ6kc=;
 b=Z9JSrwTpeb1kRY9npykny9B791pA/jBZMyEtJUI1hbs3w8GCmrF20vSeB0SwLGaTKIORxQ
 6hZb4Kb11yeCWMfCT9FRUlgbmKAlaEjtWR3Xpg3E0muabXzfBC+Kq7dcKP10lcOswH4wiE
 qZXjxnn/VuFDbUP+v726Kb2jeAEidTc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-4DOz1Xv3MSmaRWcuHmZtoA-1; Tue,
 22 Sep 2026 16:20:36 -0400
X-MC-Unique: 4DOz1Xv3MSmaRWcuHmZtoA-1
X-Mimecast-MFC-AGG-ID: 4DOz1Xv3MSmaRWcuHmZtoA_1790108435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9956A1944AA8; Tue, 22 Sep 2026 20:20:35 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C57D1800446; Tue, 22 Sep 2026 20:20:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:31 +0400
Subject: [PATCH 24/88] qemu-iotests/300: replace hmp_qemu_io with qmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-24-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H+WsH3KZNTmX6EScia3y63CWp6drQdJUQvzqi6FpLN8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKva5FNfURg2r7PvyMngk3E397MhrYNVXhG+
 dShVsiO9ISJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5X6tD/4gNIFRunYWHEvZ917aGUJjzc5MiKw4KVn2E66Uey0WVT2ubuWdPZcnMFBSHaISsdrnXTb
 PGPAQfWxqdbxHLRhJxX7CzqMA9lut5tcBoladKxACXw9dH4s1Lep5M5HhZ8KfiJTTzc3HXNsMn0
 rYhDnpfo0xt1WmMvOSFqp1ooSChzL42yxOycQOXBKC7WTycUlcJI3FDAm6ZtgJQnBm5NqnZOrl5
 Qp7A4XT/Od7u+M+C3IbdDv80dZ9X5DhG3QNdEt/wAHXztMFAz3F2Tw0aXg0XeNsmCYbGw65uLE8
 gMf1dC5myqa98mUuD0oodjxYOH8JlAWSLRH/IzT1e4pDfoXVFLJJ1CAIbQ7hKM/FVjYczeR4f7N
 a2dIjsb6RVb0UTKv9xnhjvb9pi6OaXkEiHbuyelVF/qt/N1+7F5QZQEnbRQnMNaAsUSQnKlUIHF
 vrfuwPyEIQfWsvSLKwNVGGR4GZ3sVCtEoPvAB7x8jTJmjkolidKDqJd5G2OkOP25fpl69g+zCQw
 HxM5uIrWCj5oBFTbP3CQi25CWIYqjCmqM+fgwXqiKsjGMEhQO7d/+s0czDEmKC0NKApfC8gF68M
 DkWPC4+nlGO1+CKDnkVPquzPY+rhPvRPaS8cw88BVhR25me13IKbdAWqNL+5/wM3KItqr/9lpDf
 9bXRqcbjCSVntgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

There is still HMP usage left, addressed later.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/300 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index df2ba326327d..bcc6fa972581 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -57,7 +57,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         # Dirty some random megabytes
         for _ in range(9):
             mb_ofs = random.randrange(1024)
-            self.vm_a.hmp_qemu_io(self.src_node_name, f'discard {mb_ofs}M 1M')
+            self.vm_a.qmp_qemu_io(self.src_node_name, f'discard {mb_ofs}M 1M')
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node=self.src_node_name,

-- 
2.56.0.rc0.29.g47ce80527c56



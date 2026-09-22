Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03147C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yR-0005QL-L4; Tue, 22 Sep 2026 16:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xz-0004TL-EU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xt-00084r-A4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RwZJpFBMV3SCwEfM8kdxiiIrdxzj3xjHFG8k4sz4yQ=;
 b=B/0Rkl0Mn5mO4TBgeL6KRHJuQHE021f6X7Njgayc1gTQZ0rZULLAkLIjK/K4X3Sa+LebBp
 8Ts3yP7HXTypvvBFkv6JjdVKWgWiuER13pYTLY8j9PrgFkJEqVFClCZTkqQwCJ3v89UaXH
 cYdL+36a/Nj8bvGZSokZXrvcohwPoBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-PUU68JGLOOOxCvTAsJg_HQ-1; Tue,
 22 Sep 2026 16:19:43 -0400
X-MC-Unique: PUU68JGLOOOxCvTAsJg_HQ-1
X-Mimecast-MFC-AGG-ID: PUU68JGLOOOxCvTAsJg_HQ_1790108382
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14AF0195398E; Tue, 22 Sep 2026 20:19:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 450F11800446; Tue, 22 Sep 2026 20:19:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:16 +0400
Subject: [PATCH 09/88] qemu-iotests/iotests: filter x-qemu-io messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-9-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5/OzWutjkIhlWuRLjbXJLQxKLZvvxMaDJBsOSR/JzPU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKulDX6IDIxbDT9mKfQfkSq6P+ZiHupjXjjb
 YRsj/bG6XSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5UBkD/97FClJKWsfMDnxm5/NHdP76ook3GfMY+mG6SjKgdrkhAQNN0btVE+6DuhxWPphI2ui4J3
 u9obswaRFeo+6ALrAdJxGWWP2tWOgqLOXGS9fe1EJkZfhQJSZqb9/TFJw8Jj9/hBq+EDwRi8bx8
 LJSZF2Tr6ITkPNxT4Y3bzv2pI8SrjeDmLThrsGtxGuN/nfAo18htUo5zXqJc7J0R2CB5yInaKNQ
 RaGpVcC1dy+kVMN3SwdTVijcHHKPHUupJ9LArTz9sdK3fleoBj1qKm2P/BHrgLnXWUsE2bE5QNj
 +3WZ12YP+X1vYPw7nbtx7O2DGAiZJfhJFes0PSVgOjgE8ZzwPJjdrWUn4Elb4UIhc/Aajj49f7z
 LSexCn0g15FPxqduXy5IZNy20LundxKLiZokZfFkjW09bb1smsLK0JSnYMIEN5I3iMyTbF+CpsR
 XJuSLKv1pxhbnmz0DAycLjecvv4QyL7VYvm9YxSpHVPWVqkaW9Cj1Gdd8bvOxDlWDp9PgJDwz6z
 9VAlWalz54CElMpkICW6eO9y9Tgh+YnW5Zj00bgxea4agImp1Tjz8AUk6ERusaXZKn1OUqzStEo
 BbbGACjBD+df1fWOlkOSwcZP1CC9SvfD4oeZPlVF/9nsbGny9s091KvNIG6PhOMT/2oF8O82djP
 Pf6HXtR7YHmbRtg==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 445a22a8659a..5d9b5ded64ac 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -708,6 +708,13 @@ def _filter(_key, value):
         return value
     return filter_qmp(qmsg, _filter)
 
+def filter_x_qemu_io(qmsg):
+    def _filter(_key, value):
+        if is_str(value):
+            return filter_qemu_io(value)
+        return value
+    return filter_qmp(qmsg, _filter)
+
 def filter_nbd_exports(output: str) -> str:
     return re.sub(r'((min|opt|max) block): [0-9]+', r'\1: XXX', output)
 
@@ -962,7 +969,8 @@ def qmp_qemu_io(self, drive: str, cmd: str,
         else:
             kwargs['device'] = drive
         if use_log:
-            res = self.qmp_log('x-qemu-io', **kwargs)
+            res = self.qmp_log('x-qemu-io',
+                               filters=(filter_x_qemu_io,), **kwargs)
         else:
             res = self.qmp('x-qemu-io', **kwargs)
         return res.get('return', {}).get('human-readable-text', '')

-- 
2.56.0.rc0.29.g47ce80527c56



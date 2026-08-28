Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51BC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pq-00077i-B1; Fri, 28 Aug 2026 16:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pp-000706-6J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pn-0008Nd-MW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opysn1bRFu0R0A9H/fB7b7lpVgHXolfrxFYbGxB1Axw=;
 b=HW1Pv+AFdEKZXs1mj+v0I5Dqi6RwcJjqyS6BJOFVWqConrcJoz0HgCkjvqXfYNd/Mk33qp
 A41qHX9F3PTqB/6VLWjvbFArEAqjV2wGWovvCUL+EFimKZLjIhL+4BOtfhQUANM/7Kh7MV
 2LXNs0l3GZ68SgDxVZ4UUvQo0KjfdYo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-QYz4VjkUPfS3XeAZ5XtsfQ-1; Fri,
 28 Aug 2026 16:43:05 -0400
X-MC-Unique: QYz4VjkUPfS3XeAZ5XtsfQ-1
X-Mimecast-MFC-AGG-ID: QYz4VjkUPfS3XeAZ5XtsfQ_1787949784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7278A186A704; Fri, 28 Aug 2026 20:43:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92E243001D3D; Fri, 28 Aug 2026 20:43:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:57 +0400
Subject: [GIT PULL 18/50] tests/qemu-iotests/205: fix race in
 assertExportNotFound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-18-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SYciGynbZfmzHmj6GnVAH6YIbsG3S4jakiHZ3jHlMHY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKU4+VCtzGm6PhcNU7893v2tTKJ3l+iJsTy4
 7w2kJYokgeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5UbLEACkDq89lPciOO44Of9shlmSxj3zof2zq9PqlN7N9Bvp1SQf84OT78SEeVVkR8Fbb/d9H1+
 /JIQlKMiWyMu7kr9ehhMJgZMHpDWThSonGcEO06/Dxz/VG+bfEO5x/OiSf+54mbLgYDzQg/M4gX
 Ap6HOC5pmNfhStxyFrDN4BNe/0R6DKtE8xEpo13p5+h3ihYxmRbeLjqA7SJRZ8iLtRwhNqFEfcS
 8SoRA0W3TY+nyNEyGzvBmNlqlk54HfBr+VJyC9GS8nSyTYdXGocn8KYrXEmimD0L8jSGRWImzxz
 sjWTJMzTyyf9qNHy7xUuAD6lKvO9Wz+LvpVwduTzq9BrhTIhXjr843r+sOPAGbejev19/wRTK3a
 y5TrFrRV6glKpmxxiKo/JCDs/e7DJ4IsN/Zx9zf2N93KSouoPgJus/pBO9oXVWySgbllaG19h63
 t9d9NrTTnadoKlVV0ZiIAuy+9i5IacCUDvBCKBpN/gxUR451kN10YwO64dRsPerJOVmzLH6aiDU
 ChfmjK5zgz52nydV6etrWkwB3dOTJCsPYL6uIljM1yA5TCUfVtQrSHCxq6wiWUlvwDEsvvx41S8
 rmtRjojL+4AegWe/vXTp7i8yG8gGHO7SUaS+3zUpfIvHyJWGgeCHpoG9mJwmYiEc62af77Bk1N3
 /8NQemJILLXaQsQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

After nbd-server-remove with mode=hard and an active client, the
export is removed from the NBD export list synchronously but remains
in the block export list until async cleanup completes (via
blk_exp_delete_bh bottom-half). A subsequent nbd-server-remove call
may find the export still in the block list with user_owned=false,
returning "already shutting down" instead of "not found".

Accept both error messages in assertExportNotFound, since both
indicate the export is no longer usable.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-18-9227de146347@redhat.com>
---
 tests/qemu-iotests/205 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 2370e1a138b1..78459065418c 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -60,7 +60,9 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
     def assertExportNotFound(self, name):
         result = self.vm.qmp('nbd-server-remove', name=name)
-        self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+        desc = result.get('error', {}).get('desc', '')
+        self.assertIn(desc, ("Export '%s' is not found" % name,
+                             "Export '%s' is already shutting down" % name))
 
     def assertExistingClients(self, result):
         self.assert_qmp(result, 'error/desc', "export 'exp' still in use")

-- 
2.55.0.543.g5ebe2ebe4ea8



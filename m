Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DADFC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJW-0001Xl-Lc; Sun, 16 Aug 2026 15:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJU-0001Kw-HX
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJT-0007eh-2I
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Li9eaIRd/wq0aVwn/Br8is5mFw0E+0GI7agP3g+jan8=;
 b=EjCdmixSYjfvTJO+gxGy/HZ4PAOMQ0n4MWoPLnN890LwuYRXKgLXdBglveYd5/+w0/N5gD
 r20EkI9v4oH3GiQJ+kN36rSjhSPwgFgVZz5HH78wsKprYZ4iN3s99/uQ0d1Sdkrn1FHHFc
 hqm9RiQz/F19smBaovSCKl/2yUeKNNM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-xBFrfoJvNxmnvNihVQcVKw-1; Sun,
 16 Aug 2026 15:14:28 -0400
X-MC-Unique: xBFrfoJvNxmnvNihVQcVKw-1
X-Mimecast-MFC-AGG-ID: xBFrfoJvNxmnvNihVQcVKw_1786907668
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00711800344; Sun, 16 Aug 2026 19:14:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 030CC195608A; Sun, 16 Aug 2026 19:14:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:52 +0400
Subject: [PATCH v3 25/49] tests/qemu-iotests: convert pause/resume_drive()
 to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-25-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/L0hVAFEx3XIWnCzmZ1t+k9L/2lgK8hla0QlNAoAMqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyHbad6hO7UA5n2apRt9oG1p8gXUFgkOtuu
 B1oAasvG9qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5Q8YEACp9eZDrHLMgPz+mMf+BcqCfYtYS9fUKcSU+cI9xPTJpEKBQwIVvlvW8uF7LBO96jDNNT/
 Oyp42Si9ro9Nsmfbt3fZjRhJskhXj8hFWdXV8qq3JQ1EtWVXBWBq+iFJPme9UH20sP7F63yLlP1
 hiitzPup9ZLRpHnsMAQZAPuIxUD8CwD3qmIHdkjLxgpUQbJJyMdjoMS7gD5WTvSm9wDAd03ffd3
 O/DUjrHTCq6B6hfXpq4vomosL+Bb2qqMz6wAOm6pa/XGRcx8xXafyB15Ot29hCPRvJhU5//nShg
 WqvwEML37bkqYcNhwWHMJeohH96shaWwmytliYGKC3/GDlf96EC6Sj3Hl1SCjMQ2+eqbwYLwL3A
 t2saxzorssyWc6hMhi1ZbZyLr3xYiZOwuttY4kOjK5sKg3rW+q1pnM88LwuCzVEzyYi7a1EgrQR
 b9UHpVaSIxlsghx086ER5+Z4OWpcau2P9fG7uSXJgq2ZCOZutKJoGjn1cCQhHXlKRJJrDjAX8HD
 xmzz9O4d1vxVajvCEZ9/PW3QFHoLehTNe7Mc3YZg8EgZDeJVlTh7oWdkyQtBh/Zfd2n8I38wc4e
 uEAr7JoaN2MrsI5xMfLxP0dLeaUH1LH4W1nqz+LJvdnvJSMeoXQDX6dvJmrpT39tTzGW+Z+/Q0s
 Bo92E9e8nUXZfgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Convert pause_drive() and resume_drive() to use x-qemu-io directly
instead of routing through hmp().

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c24f1e3767c4..f36bcf316429 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -941,11 +941,11 @@ def pause_drive(self, drive: str, event: Optional[str] = None) -> None:
             self.pause_drive(drive, "read_aio")
             self.pause_drive(drive, "write_aio")
             return
-        self.hmp(f'qemu-io {drive} "break {event} bp_{drive}"')
+        self.qmp_qemu_io(drive, f'break {event} bp_{drive}')
 
     def resume_drive(self, drive: str) -> None:
         """Resume drive r/w operations"""
-        self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
+        self.qmp_qemu_io(drive, f'remove_break bp_{drive}')
 
     def hmp_qemu_io(self, drive: str, cmd: str,
                     use_log: bool = False, qdev: bool = False) -> QMPMessage:

-- 
2.55.0.543.g5ebe2ebe4ea8



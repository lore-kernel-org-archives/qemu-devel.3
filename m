Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202CC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvMK-0002T6-Uy; Fri, 28 Aug 2026 08:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvM2-0001ig-4j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvM0-00031I-KB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Li9eaIRd/wq0aVwn/Br8is5mFw0E+0GI7agP3g+jan8=;
 b=YtYD4LxZAkiP4Z1wS6ll2R5+y9Iye1+oAd773iStCz5WtoLoIzbaH6z9mtihubdTzWVJ3Q
 djQNYO84B05/pWZkS/AJ8iXVHu0pRPY9GnpFFVqgtwcxnNO2twDsokZrsE/4caCDXLwDpp
 74oFQX5z5I0p9QK9fWe8nUzNby7yPgE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-kiGhUCMbMaumxuCPzYCcwg-1; Fri,
 28 Aug 2026 08:06:36 -0400
X-MC-Unique: kiGhUCMbMaumxuCPzYCcwg-1
X-Mimecast-MFC-AGG-ID: kiGhUCMbMaumxuCPzYCcwg_1787918795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5461953983; Fri, 28 Aug 2026 12:06:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 187EB3000223; Fri, 28 Aug 2026 12:06:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:23 +0400
Subject: [PATCH v5 26/50] tests/qemu-iotests: convert pause/resume_drive()
 to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-26-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/L0hVAFEx3XIWnCzmZ1t+k9L/2lgK8hla0QlNAoAMqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk58AK+tWvonuLcHWNwNgDdE0J38U1Q3Ipov
 tYhWmb7VyOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5br5EACATDVT76cI0TQJpCzCegCJXnT6nnokbgPKPhU/R9pLHJMNbkOWY2Cw7QaDo5BjppbLIJV
 EldM9F0yqK50+SZs+CNcWil7n4Yu7pin1NDL/pHMEJMX8tCkSs2R/mlt2ydWyJ2sQyJQkpIqaLL
 EwVNH6eDZu3jzvxfCeohvBt1A+COp4fORz9eMyHPssKB/KA0ex8l98e7JYVLUeCJI+EXFkXCT3A
 aZ6PmkgQlvQG6cl8AZM+Opn6O8oB0KkXKlvwoWRhcJsOSvqIWNKXGfLs3Q5ixq0swFRW+3NOdt3
 KSWEK6PwiCAJoujPtFMVrHH5IY270Ecdb+ypHsX+adghWTugfjdTWy/5g6KHCDyTD+XYv50xJTo
 eivycJ/YYf6C3+pANEgdjXSafwshFWK9Fj5X1nok2W8sD9gJw8Q88BG9ANnkq52otlMKjUv4WvP
 ORG0Vg4mcm0+T5xb9SYZkHxX2N5HEvG5Qx4tmIYhsfLxnEcASQui2ckl9nRAlPLVls2ynXKd63E
 wzEtXcnj5I+k4CWPF0sqkWzhQ/lr6YRYPBy9BsOjKpG1tIBOc76dxMnWWFPtQ63DMlnFdyJzy/X
 s/XYUc0d7nlZBYGI7b0pwhTbojD5yPuydO3UppGULTzM5NOCKWkvTTVt15sptkRphDjzb2bYuAX
 g0J5tlJDhSjI2fQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86035C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYm-0006Pc-MT; Tue, 25 Aug 2026 15:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYg-0005zi-RF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYe-0004FJ-IF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Li9eaIRd/wq0aVwn/Br8is5mFw0E+0GI7agP3g+jan8=;
 b=CAGkO/Gi1QUQR/TEab4h1A5hiBosInybCijveHF3DhONVncOtVfIf1LQwH2/z7ej3e3aGN
 9j3ppHkXxuAsSF2wiURozIxObO/jtwphNBW6e570sfYd0Ye1uksfgbpEFy/GZaBTYoNXz+
 SHaOQwO3K3VZt7z7PnnzuBLvfjHhJr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-qikDHNZsOFCvNSaw4WP9CQ-1; Tue,
 25 Aug 2026 15:11:37 -0400
X-MC-Unique: qikDHNZsOFCvNSaw4WP9CQ-1
X-Mimecast-MFC-AGG-ID: qikDHNZsOFCvNSaw4WP9CQ_1787685096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B8E619792EE; Tue, 25 Aug 2026 19:11:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EC6018005BD; Tue, 25 Aug 2026 19:11:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:32 +0400
Subject: [PATCH v4 25/49] tests/qemu-iotests: convert pause/resume_drive()
 to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-25-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHAh+rynmJmjPQE6NA9ucFldrhkrG6kciKq
 WFj6cfQ5wmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5RAUD/9z+APFdLA4oDk3E4TPtAUYCfnyvLMSoazTeMFsBOxd61ujb9ffTYNoaNYnR5jhpNtIJck
 hcR/Mq+ZKvTq9OsO7B9Qvgh5+KJutYqfdsVhCvexma7zPaPSe3uMLaOuuNvqPKRxQVZ7o59L0j0
 AeEZgpd+wZNNfH8GngnC6zPii3t6fut8jzXcFXm/29TsGih4L8iTaYhxcjZEJo4cqXe/wyr0P4t
 K0hLox75tL5z4hUg31mKh4oPL6VrTLCm1m3+CmIjgHjX3ZxS1UgBPcaz7YwNBP5l806o0FdFiRD
 Of0akU+sCBZxT9P6oylJYw1psOkFsaHi7p3MVSubaKFcpZXizS4QNogrt3419VTn2YnSxFAh2Rh
 1wSsD4wE0eN/LHv0baUR22Fe9V3xC+FsJtSnGp189B/JVuKnO8VledWFB97pM2pPiwJMqcs4oI3
 TA7RC6fpkKykUUuepbLTYnUdlRH18RjxhjtkfqC2tNIjG2hvGSIa8H9IpPYhkILZ9IYzKg7t3HY
 P+9yRqw4kHFDQjhsD86Av/IULHfOqP1c8jKKtXwOzM6MjRhPcf35v/OPN+fdTbk0yjFSfUafa0m
 eAcc9NVbtxZvGFuYjDxlYW47QIqqU8LwI+MuhRDl+eZt72MmgkYwPAHIqLSm9jbT2fQccKuypOq
 W9wJ0TD1zr+dBYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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



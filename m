Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95201C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QN-0000I9-TY; Fri, 28 Aug 2026 16:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QN-0000H2-2J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QJ-00007x-Ot
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLeeZ0AHiOKQ2oOvOf6V4+XfqMQ/FMyIOOORqxDbaMs=;
 b=G+YsAMs2G9Sr3/o2wR9utr9ROqzB+FgTeixS0JWMIQiQanGnNz7gtfEFBoTkrlGIAecGXg
 9PLvNtnVxlhaPEEdALi10PFbZr8VJZA/cLRmq7XEATb7Sx+IqYScf8z+1jhmXYppW7ghMo
 RA1JqvhRZTutAfDoqiqGLZvLetw7wVA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-uc1HaLSJMRqSFDICYj3Zrw-1; Fri,
 28 Aug 2026 16:43:33 -0400
X-MC-Unique: uc1HaLSJMRqSFDICYj3Zrw-1
X-Mimecast-MFC-AGG-ID: uc1HaLSJMRqSFDICYj3Zrw_1787949812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F68B180AEBE; Fri, 28 Aug 2026 20:43:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64B4F1955F0A; Fri, 28 Aug 2026 20:43:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:05 +0400
Subject: [GIT PULL 26/50] tests/qemu-iotests: convert pause/resume_drive()
 to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-26-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9yUWqz9+Kpd5K4Ga7zpfZ8+so7PJQ0UEYfgEPskRBu4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUV1ySLwAY99VN9LCdOEalNXUDtePdDeRdt
 Xy5hciFi8KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5eDiEACSP/G8wSC47oOi8csklvyMt//BuMaRnFWYhG9sCGDZ4WNt0+8iy4XAjrQOoDjMq5uguvy
 hHwYGBnMz3ZSORX8wquZB/KQYataTybNk+PTBP023uB7E22KcGZmefxB2S2yJbyJq8AhLx3dSFz
 dy68WDkI1RnEVAz5Frl3fa4vauhIx27wp1wIMAj2m7zNb7pCqCsyO22qNRG5FDFWPtREs7Zv9lI
 SK0YlKE4s+Ut4Ry6dnJZXTZrBbsKj6+OCWgBgj60BUtTZuhlqSAsZWAbVwLn+8SZ8txG/dXzWZh
 vBJN+KhHaikgv4bG9GLr2e79eaIMWi0odvntec/PLr8G8IGFo5kADwdO0XKrBHtr9R/dJBVpNtR
 Kv+seYjjL5eHl2HlPq5etZLu6fTdyhvc4N2Fh0kjXgSMpVugFRy2klyfXXRk2lDHkZOcitDLrUc
 n63kr72pJ0bj70x28Qpif7s/HdxTjv09ANwfUMnB179k2jslii+VpeiHYJJ/Qz8MPURxGV6wewj
 dgK793O7YeuJ0V+LVcF3F40bWCapOg8L0Xg8BOAv6alIxkGCHRhatgi6ANnNCE5/LJz0yVtVhDW
 H0RbYkBnqpUvAhRRo5o3fFIzNO0DfJwbQ7z0maXb/E68jagCsiUcdTVswxpX/EAHiqbapkgFwlF
 pXDg+z7+J9fAw2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260828-qemu-no-hmp-v5-26-9227de146347@redhat.com>
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



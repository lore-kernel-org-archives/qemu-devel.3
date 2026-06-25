Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49681CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWQ-0005jv-Ds; Thu, 25 Jun 2026 17:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWO-0005bf-HY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWM-0003u7-UI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hi2vEzgQrcrQaOzimQFu2ofvp7AA736N78llG+JKBUE=;
 b=cNfIeK3/92CBpf8sDd3F+0JVvNXnt+Qw+fcnTDOTohMq2SpLfV1g6doalRCIPioVIC/+2v
 40+qYxVZZO04XZKKL3XAWaJymC3m1fe6TVJDLLfUAXdKKQ3mlzWdH5ZxewS1Ce+fvqdtMV
 cem3MxOEzufW7QTWvJ3aSSEMLyjZnVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-GE4eovPaOH-XldN309WE7g-1; Thu,
 25 Jun 2026 17:22:00 -0400
X-MC-Unique: GE4eovPaOH-XldN309WE7g-1
X-Mimecast-MFC-AGG-ID: GE4eovPaOH-XldN309WE7g_1782422519
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61C0B1954236; Thu, 25 Jun 2026 21:21:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E9E731D2; Thu, 25 Jun 2026 21:21:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:28 +0400
Subject: [PATCH v2 27/39] tests/qemu-iotests: convert pause/resume_drive()
 to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-27-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qM0Xof+7smXnWaV+O717rWpzA/cboySeKHxvYp0PgWw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdk9+UxvsVXDDpKTU3ARlC5piaiYVKWRh13
 vTm/iBWjkaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5W0LEACp3FfWkDJfCRsdO6DWNZhUd1bYBJCmbWzgok8hwpoWMEAWNSjFwDTYBwPPM7qZaJNANoD
 hAC5n7n+Av8Qg2iLMJV4ndtsMBiNgEOU0nOYK/zgdcE8DTUyxqpecfzX5es1VAd31ZcqOefrMp7
 AIe6dR5yyfzHAOKbijw9CecCJ4MUueGjTROy9jxAzL28ysIGGwrQPZxswrFQG0B1T2l0dqFqUws
 izzlXNnm2kPoYiflxC9tsTrkmyRB/G1eBkDgx2pge+nv1NhiWfOXMgk5DQjSUE4pB2T+ZoCYJMX
 sojhCS55fjHRD8BNxrSUWBt9c1TGFbV+jbNZKKifLFzaeNTz9NYhd8RsZhHi9NDgri2CDYqMdle
 nU2MNJiHaUzGz98HfKaO6EtTe+nXVF3ZJcwlmOtRooxjbh6JOFdaukW07PBaE2jHQF4GDySnJJt
 c/o+Ly0xscStiKuqDL0a0WeWK75YTsT8vllmHSh+N0cMOpoUotsY0fLEFiGWLQC5HzR/azbc1BR
 L8BJZdJEn9IP6xweqzC1h/mDt+ruEV7IyDLRAgLOn7PnJeUCAp4xkvw2R5DQwZIikFYn3CDiUzm
 Xv5A4XWZPQ23sKTWODzHpQAdKT8WDat+JmLiygAXCdTpgXIDCvXcjOeWZ+MC4U1bSlcy4F+yFoX
 /gdx4kT9JeB/rSA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert pause_drive() and resume_drive() to use x-qemu-io directly
instead of routing through hmp().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c24f1e3767c..f36bcf31642 100644
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
2.54.0



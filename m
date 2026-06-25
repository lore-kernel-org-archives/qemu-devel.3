Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A1BCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWM-0005M7-8K; Thu, 25 Jun 2026 17:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWJ-00056w-Mw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWH-0003tD-K6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDTL60CqacufkpD3COu06t22E+dNdIfDWJkj0E3iGPE=;
 b=PiGkP4khYMPGECtqcRHoC2fKPua9qwz++1NDD/owgrK2D45cgYY0BvGXq2WS054XW8BZTO
 m+jr+vnwVYG1gXEuo3msWlo4/Gy8FBEQbTYKYmjXWIHwF9QNx1FvfUd19B6euuAZR6qwW2
 k/Wq7bu+GhyNvn6JU51cq+U0qQw4BnA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-bWs1EXXrOQiC5TBtP08adw-1; Thu,
 25 Jun 2026 17:21:55 -0400
X-MC-Unique: bWs1EXXrOQiC5TBtP08adw-1
X-Mimecast-MFC-AGG-ID: bWs1EXXrOQiC5TBtP08adw_1782422514
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ABC7180AC50; Thu, 25 Jun 2026 21:21:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1576C195604A; Thu, 25 Jun 2026 21:21:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:27 +0400
Subject: [PATCH v2 26/39] tests/qemu-iotests: add qmp_qemu_io()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-26-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zBEDpNdxGrFiJykDG+qFptAI5517U/xG7WgjHd2vzsc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdueCQTdlyHYGfkLn4d3D/+yQB/Zc0rS4am
 /q+OcVvvY2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5Q1EEAC0IdCL9ZPM+Kzk1PKKzmmpNPOA+IeMcjsPgMpiMH8U5A63ebC+i6a1yfnjbcG5BEn9J6b
 vVCPK/yPJw+8yqyRAaTWGrqBD2Mdc9U50Nu7Ocx5odfY4oRIgPXoHhYe4lqV+CZqeSzdiGlCVCQ
 srSwItFcCNTzmTQb7SxEUBXsFN1ivHXBp6nCoYaJmeDBwTYDTGDNA6+hirnzzRibTJWyj34EH1k
 jA3/nazpOvYf9TnVXeqVIZLLKh22h9GPdwpyJRR5jgs1pxL/lvcf8//xZXFEqnlOo0Oki+HZRAa
 1s7Fm/WhkzLMZEAF3phLW+u715Ikm93S9LW0zUuosKMqCbfcpru6GY/7mhTy2NHvzU1Q6CJJZo/
 gISORO2b5rXbpuiSOSe1Y3lSprJr2jOjiY1akAqvm18zwz2Yd50LGIkQfQHYRg37uVxnTr+54iI
 uaUyq7EF/xloio9w4IpYEMrqfB+bXyfo0NjfUE3z8c37wr+deI2wpY+il8qkdWVWkRtsTv16ipd
 T155L17G5TfiNcWDjrmbwBKbmrgHFyr71W5I+oGUjVUtA1tkVo/VKUsXIY58HOkVceKjv8tJWkm
 AK8Dw+Qf8o08TyltpuZGsQyJkCycvvTxv8uJYtxCooEHSYAVqR04C11BlU7nsqGGMhf0KZdSp/8
 giBmD+Lx6m9yv3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add qmp_qemu_io() method as a QMP counterpart to hmp_qemu_io(),
using the x-qemu-io QMP command instead of human-monitor-command.
The x-qemu-io command takes separate 'device' (or 'qdev') and
'command' arguments, and returns the error string.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 072be80e079..c24f1e3767c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -953,6 +953,20 @@ def hmp_qemu_io(self, drive: str, cmd: str,
         d = '-d ' if qdev else ''
         return self.hmp(f'qemu-io {d}{drive} "{cmd}"', use_log=use_log)
 
+    def qmp_qemu_io(self, drive: str, cmd: str,
+                    use_log: bool = False, qdev: bool = False) -> str:
+        """Write to a given drive using the x-qemu-io QMP command"""
+        kwargs: Dict[str, Any] = {'command': cmd}
+        if qdev:
+            kwargs['qdev'] = drive
+        else:
+            kwargs['device'] = drive
+        if use_log:
+            res = self.qmp_log('x-qemu-io', **kwargs)
+        else:
+            res = self.qmp('x-qemu-io', **kwargs)
+        return res.get('error', {}).get('desc', '')
+
     def flatten_qmp_object(self, obj, output=None, basestr=''):
         if output is None:
             output = {}

-- 
2.54.0



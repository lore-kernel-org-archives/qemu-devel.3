Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F276C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJb-0002GS-OW; Sun, 16 Aug 2026 15:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJZ-0001ub-8z
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJX-0007fj-Bt
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PoiWTQyc+6CT3+XQBefK1rDjJHIoQVwAvU80roRsDk=;
 b=ObFvkbyzmAp61fW05AuMz3fGqueL3dPoPkNzVRSNnxSgGM0JMECmcDZJXZyebCYm+I4Vdh
 woJKnnVI+UrbMZc00R5gwIMSMrGslzGK6iEjm1q+d854yOSu43aiOvxj9bLTPOkuBCvThm
 DIIJcCuHgB3T1Vo8M+ZfG4+FJUcLXyY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-2sJYkqVnOhW7qTqgQ4eEZA-1; Sun,
 16 Aug 2026 15:14:25 -0400
X-MC-Unique: 2sJYkqVnOhW7qTqgQ4eEZA-1
X-Mimecast-MFC-AGG-ID: 2sJYkqVnOhW7qTqgQ4eEZA_1786907664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B85DF1800471; Sun, 16 Aug 2026 19:14:24 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7115180034F; Sun, 16 Aug 2026 19:14:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:51 +0400
Subject: [PATCH v3 24/49] tests/qemu-iotests: add qmp_qemu_io()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-24-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2ie2jIETQhyqbbYcjhhut4gVUdDiVPF4PD6eQdFtxIU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyx3e9osmNQZwvs3dklmfo3O8xBvc3RhQZP
 9IGrjm6LVOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5e6vEACWsFYS7OvZNcZDGIaEVYxRVilhtQNPA2EsSmMpS5dwgR0oMPvLkLtITdbnN6hGYizUwrf
 UrWyFWnm/AOyfwrYMhlWGHPMbQOIHqYGZzgB4hHjp8F/xVFvexfzKzVHPK+XTqEmmw97rcfBXxU
 Kx48J7IYkvZZDiU1zxcQ+V2mYbzR7fLRT5MMFjsGv9yFWDz+/bIcjr+fkBc7hDbeY5HlHLx0Tmk
 8P1lSCMV9Gn6Id0zVZmNttt3icMSnLdmNZBXgpAf/IdGeivIV68FpFGVtM3qeqODxKUHwjgHi7L
 mpMtgimLUJD67SyB1hZpxi/sRHE2mL/uoiE55jMiqM2kdhB8oOTtQDfstwakSRWoi3yhdhxjcb4
 ekbsQkfuIqs9XbA96xN5CfE3RypUPJ63G/G+clzRtEIcHkexAyeljZhvjUwbCPkg6xCCLGEpO8Z
 o1kUb+7V0FtFH14Tr/bt1r1CcSCQ70jvVhvfzuWuSbn/4/TLTTeZaGIO+jiej4FQ0gG2vLBBrv8
 /YoS6XAdyzW33Kj2T5nd5aWVUbnNW83YUwlsC1Cjq5ArgrpocqTBM2v4zvCmSxXI3HimnPRbgNk
 HN7pEJgFi7oYWhXuuE3PY9wzKgkBpiN3YT+l/sGCSPD19SJm+v5O0kAJUYsiXeBV7AAIng3aR1+
 4t97/T6AOETFp5Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 072be80e0792..c24f1e3767c4 100644
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
2.55.0.543.g5ebe2ebe4ea8



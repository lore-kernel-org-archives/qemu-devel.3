Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8430C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvMG-0001xq-Dg; Fri, 28 Aug 2026 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvM0-0001hP-SD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLt-000308-S5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PoiWTQyc+6CT3+XQBefK1rDjJHIoQVwAvU80roRsDk=;
 b=XYVrkIKzKTnWcqbXmUQNZzW12bDt91yev1TpTFDA8q/yaJk/P8wBf3sDWjVRmfYL+9z9+a
 SH1QnvZZWl9Bv2MU70cLuU8TO/ab79W9r7reXPXnjXlmpdWZO/tdUbpBFUXBna7FOA/AVI
 jsjEjwQpDk/FLm2PeIAzhugeZqJFyQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-N0phaPWWMd66DFikDkOitQ-1; Fri,
 28 Aug 2026 08:06:31 -0400
X-MC-Unique: N0phaPWWMd66DFikDkOitQ-1
X-Mimecast-MFC-AGG-ID: N0phaPWWMd66DFikDkOitQ_1787918790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7683F195DE73; Fri, 28 Aug 2026 12:06:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 778B53000223; Fri, 28 Aug 2026 12:06:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:22 +0400
Subject: [PATCH v5 25/50] tests/qemu-iotests: add qmp_qemu_io()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-25-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2ie2jIETQhyqbbYcjhhut4gVUdDiVPF4PD6eQdFtxIU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5aQ8ncgkZxqghKioWdIznm3rcRKFg9LjNP
 0G91XSnJGWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5c6XD/9JhHjMGwXmE1q2zBuDXBGTI78tdH0vQXCuK2640PXHz8c3uQcRaEZ4uPV0rBamqLqfw9Z
 1nsStRp7HvYNMAvNuDCJsYCrAJ+66ivKA5FUQ/1z/QYf4XSzHo5d76ocMJ51HK+Kt7CXKSpMsM5
 FM5x0XWxy6IT6mSf2HxUubi2K2NEV1SAM4NLehm6wWYAL/mcJKheFzqsZQpETMZLTon9Wvrg4sU
 dQ/Slv+9qHJu4/iNYZ38hMUC2Jo6K5SHRaFWRuB7mxo7ObBefqKeK0MNaP6BbSeOAm5jBxMJdB0
 lw1+32M4lKq9dI3IECd93VCvf+v9fozBP4f9kKvJ7i0Zs58TE5yJlE54kGFarZYWSb/M9A7efOp
 dIxFq6sYPCtsheBRzEmml7iqSvGBNpUj1CbMlKcDHMuxQNYcQpbjZPbQ3kOonAndvJSmZ4LV5xQ
 C70qCN/PxcKEoMAfciayYCw0LabAKZS362krz+ISGsVeVJ1piq8Yw76aoXzn1sGdsIT9plEu2z1
 U4vj4uPlqxXBxYC+h6m0jl7LYLMKrbHhHKa6YZP8UZP6VqNwye4LzcFGKLDauv+XxQbdC4P+TNb
 plw93caw+TkFGXkg+nW3AFxL2mQ7W4Q4C7IaaUx+3FRFzSA+U/ZRiOGyNf6uByx/W58UjnxbjJo
 lGjdLiZX9FNm9XQ==
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



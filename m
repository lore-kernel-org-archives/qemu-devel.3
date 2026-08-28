Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C806C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QM-0000Ee-6w; Fri, 28 Aug 2026 16:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QK-0008T4-4M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QE-00006p-7J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nREVHJ2ggPDWwiykw8rk/olCs7J+5ZR9LLZEi+jxMJs=;
 b=Qo45+u/OfueJlhNDaB8XisuQavadDdYBe0l4siyarykwaA7Mcc2EVykjQ+aziVpN4HkTk8
 jG+gobFeODXzILqqpNGFgvOe5rhqLM1ehkO+EyXAbEp0WI6AZoDy3M1EBJ+ztf/5G5Rn+g
 BFYb/y4DbnUoA9mWdX0kRfnq1wpccXI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-IG5Lq1xXNoi-H8xqkvZQLA-1; Fri,
 28 Aug 2026 16:43:29 -0400
X-MC-Unique: IG5Lq1xXNoi-H8xqkvZQLA-1
X-Mimecast-MFC-AGG-ID: IG5Lq1xXNoi-H8xqkvZQLA_1787949808
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE3C618052C9; Fri, 28 Aug 2026 20:43:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11F8E5B1; Fri, 28 Aug 2026 20:43:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:04 +0400
Subject: [GIT PULL 25/50] tests/qemu-iotests: add qmp_qemu_io()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-25-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e7iJENBS4MN65nfoPd/4nF4dxmVAXNCN4WhH4u45gAI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUJZ/MdLw4Xw4Q8fj0h0ReXRDVYtAqsvzcG
 t3Cqi2wKhWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5ex5EACdLYB+ce4TJnFV1XbCwXIv2N/QCQ9Qn78fICX7CquHOsfP7+PJ0HBdG7TbWMl7maGwi83
 mhiBwLI4lyrSniOU7csBlUln7Q5Vn4XSF9GGEu2fFndPcpybzzGoZrbFy1Wu0uyBjzqVPx+Uw7S
 D/bRvvpmOhQ5wLdaww/01IkAoa96zovxkpUJsA8FPBnbPSrDS3LfftGPmeHtgXEWxCiuTabo4mw
 E5bqyzjdWctvB+LVN0r0TDorCs2d2BQrKNIOy5Ep6iPTRhMK7ksHRPrH9Zfp1CIq3Nqv69lYzto
 qyaM5Tiko/hMW/F6iNUpXCRHpKMgvW707VtLXHixbDrxHewzezucbVXUKXQX74MxEiXftwiHHTP
 ciqB3Omh1w58rreQwNXWxogUuo34nOFeXosMznFT/gPkrokLb1hxlMutjvoR6uWNKQ1cd9S9BqH
 i2bem+96iM7bIfDztUmZ8+5e1PeFzXuaTNU6pAbTDNJW0T6eX/X1B9n6fFZdxBK4eWdTlLSpEZY
 D+FAce0u4vopNQ1eBW0XHncSi5adEMv9m6/Vv3Zi9ZKmAp3GmfY4rAheOtfFEJoeVT13KTFgWA1
 GQ7xALbsC3gd5eQARooi8eMk9CHO1eIQ/keofRTi/TZKplVrP/oZnG1CZSViD1XSvtAryJ2JRot
 mSkwszsOoH0U3Ng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Add qmp_qemu_io() method as a QMP counterpart to hmp_qemu_io(),
using the x-qemu-io QMP command instead of human-monitor-command.
The x-qemu-io command takes separate 'device' (or 'qdev') and
'command' arguments, and returns the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-25-9227de146347@redhat.com>
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



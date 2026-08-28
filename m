Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087AC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03PM-0005Xk-UG; Fri, 28 Aug 2026 16:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PJ-0005Un-OF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PH-000852-Jo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpcC2w62/lSXsp20E/QAPSDIcPWQaTZ4db2BLfr2Gs4=;
 b=GJkTnzsG56R5NZZsOCXLQ0jvfYJ+8rZaFZmGp9p2bZimQij7kseP5GVzjae816iaKSJuHa
 bGvYF0ZI2/Ms/LTEPbDcy99+glAzA6ls/XLXadT5qXvoZRM9qhU7BfkufT+snEwNAQNfLP
 zBNAi7Gy2HXLHlAKquXviZhXkEtzk9Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-BKj35jrcO8ei_VyMuRYmqw-1; Fri,
 28 Aug 2026 16:42:33 -0400
X-MC-Unique: BKj35jrcO8ei_VyMuRYmqw-1
X-Mimecast-MFC-AGG-ID: BKj35jrcO8ei_VyMuRYmqw_1787949752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 923ED1802165; Fri, 28 Aug 2026 20:42:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C86C618001CF; Fri, 28 Aug 2026 20:42:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:48 +0400
Subject: [GIT PULL 09/50] tests/functional: use query-version QMP command
 instead of HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-9-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a7BQAN4Rq456sMPJdhnEnU9XECWArxIaaAddrjhmjno=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqR8pTIx/ShbocnLP4h4elTO7fyJZNrjZHcDawi6LSjIgw3J
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqkfKUAAoJENro4Ql1lpzliXEQALfK
 HZbKXR381CKLSxNSEFNh/OijYFvOM9t5hwVqJXrIyd3AgNd6RGuCO2dKma2562vkkWEvZuaPp0O
 7yRpl8DKNId/2rKFQC4O+7/0OzW0PGwsi64JvwDU8CtbY5kT06LYZsfDDeTN0KcgQEMrfavTYei
 bIoxoT6m5az2ObtHjvjERfyxbNAV4ldtjlAIqf+ui9ZKd6zlLVaatj2Ue9Ke9b7hFgjqSauimTs
 jBkLTIQ0Nogj53b7xDSTxSl00fHCwWOf/WhNJqoLNvh7uY8VWUCMqcRsgWHleCkdyaViBx3DxIh
 VSy/qOfSHSSsELNLeHgiByWgdWsidW626ttbjZXGz3TIajmraebQHxg+tcjxLMwRW508ceAi951
 xJ0pUFhOLMaBw0sW2KsEuWry1ONL8iDOwvYPcfbDyzyOiBvgI7CiMG12g9qtffyI5LFdTj7cw6H
 VYpvhQbbj9rwAJ2uvrSfJY8aahu5zLJGmtqv0DC0ZNcF0dA6EU3VLex1L8CuQa9OvfFJEW6Crb2
 ucxv5y4eGwzvBadj/xND87EHCHoT5/nYGZaOlVLIwN+rSSogSL+kWVstT7fYop9RQlaz4cLpK9u
 iKio6xfWoNlm+2bHBjdrkTZhO+RW9AnnVhFEr21k9yB4GLaFXCbRXK+h+5p2uvSOabhJIAwID5C
 WOldT
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace the human-monitor-command based version test with the native
QMP query-version command, which returns structured version data.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-9-9227de146347@redhat.com>
---
 tests/functional/generic/test_version.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/functional/generic/test_version.py b/tests/functional/generic/test_version.py
index 3ab3b67f7e39..7764424826e0 100755
--- a/tests/functional/generic/test_version.py
+++ b/tests/functional/generic/test_version.py
@@ -16,13 +16,15 @@
 
 class Version(QemuSystemTest):
 
-    def test_qmp_human_info_version(self):
+    def test_qmp_query_version(self):
         self.set_machine('none')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='info version')
-        self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+        res = self.vm.cmd('query-version')
+        version = res['qemu']
+        self.assertIsInstance(version['major'], int)
+        self.assertIsInstance(version['minor'], int)
+        self.assertIsInstance(version['micro'], int)
 
 if __name__ == '__main__':
     QemuSystemTest.main()

-- 
2.55.0.543.g5ebe2ebe4ea8



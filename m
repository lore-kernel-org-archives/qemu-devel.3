Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91F6CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrV3-00086g-Ua; Thu, 25 Jun 2026 17:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrV1-0007xv-RS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrV0-0003ej-3Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Skr8Rm5X4C+gKnfD4thdT1isIvOXB74ElKgQq8XP8kY=;
 b=PHOntaj15rteDetJCblN348p5B+VhFiGeuZx/zKqYodfCpuoNSJfzcOIRYcYc7d8LHkDd5
 MjgxybwRiWYiTaKQ7UjV2kXWlV3DCXFCL3IlCJkZ+Xo15NKhqrjaSvYn2GDO24wV5smMEm
 NaKRj8iK7JiMOuOXGRF9uPH6STqMf9M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-Ie8C82NMPDa_JCiMyJDJdQ-1; Thu,
 25 Jun 2026 17:20:33 -0400
X-MC-Unique: Ie8C82NMPDa_JCiMyJDJdQ-1
X-Mimecast-MFC-AGG-ID: Ie8C82NMPDa_JCiMyJDJdQ_1782422432
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C970180266F; Thu, 25 Jun 2026 21:20:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAC9A1956047; Thu, 25 Jun 2026 21:20:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:12 +0400
Subject: [PATCH v2 11/39] tests/functional: use query-version QMP command
 instead of HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-11-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VABZ91CpDkSkDFI6s9a/Gj6b4iw29Q7c1h+yv62zR08=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtc135UYWMo7NHuTPC3x/QuN88VfbT18Ijot
 0uE0yt5j0CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5Tk0EACr/r2lSUicHZJxdH8EiGrj8/HyEGTXC7qSZp1oMcinWfLPWs5o5Xff1yv0bpUiA83CHIN
 UiJLhJMH9SBhqV3kVlSMbCyAh96rMe8gF9xIJOlTHQoda1uohu9y0Td43dwbAYH2zxkrTgZHA51
 /RYQk+wX43uXSdi6YeHzhQjrvlLjZ9IX6F66XGrzO99CDn6/UG4bTYCBMhR8FV+ss7H45WqHS3D
 sjEDVzwXzZzXcOUjTWJuc/dsGHpJrq8yn+jw6CyBv7iKSnkxq5cJqcJcIcPFAJ9HawzGgiZf8Uy
 /YoQ+U4lTFtk+zs4CXHkiPA1tT6lBbkt+1EmIerkq6Tjf28uqx1gS7a3gg67KzzTtpuMHtdCEs/
 uQD17bkOY2vUVf/NxEXTgVV10buLYdfBAqxaOkhAWqS75PRqdjKYdNh5KKMNnS/c/X38eLTTmHi
 8CWDsYuIycPihQi5dHvHoqX079EpfA/aAZ0PPEzj0HCMWHgDQRUtAXZEIJ7BNhLSVpk5ygC/Yoj
 OOpJLId7ZpLc8XWJcsCp2JCzIviXAimyY9AVLfLBXUwiEy/TrR8WLotkRS95cbUfxaKcDl9qbhD
 iWOOlbPgoXLDEq9lHbD7tuUt4KiKzbrn2GzVFkuAuXxmymTX4xxemFp+r9JLwGbKSFRHYR+d8Ic
 IIsLZP7onjnL8jg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/generic/test_version.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/functional/generic/test_version.py b/tests/functional/generic/test_version.py
index 3ab3b67f7e3..7764424826e 100755
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
2.54.0



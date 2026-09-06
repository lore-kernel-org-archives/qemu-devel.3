Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB20C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38TC-0004OQ-0s; Sun, 06 Sep 2026 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38TA-0004NR-U8
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38T9-0008Az-GS
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkdOMIgrinUt4eKzJ0orj9ZC48fr0R6ervIPrquP93k=;
 b=g+vlhqVcmncLpVGA5HGKQY1NUJEHHhjxiWXrsp4LyPPsi04mi7UVnw1Q/6Fka8pG1JBply
 oYgFg06VMO403PuW7Tx3Szod/6z1Hy6wyXBU1uXL4Tll4xwOhS4jZb1827izIVcBMAK9aI
 ujk0qyp82YKxWXgJ89iei1kBoopNRhc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-8IRpRjchP5SpfjmCLhFo-w-1; Sun,
 06 Sep 2026 04:43:13 -0400
X-MC-Unique: 8IRpRjchP5SpfjmCLhFo-w-1
X-Mimecast-MFC-AGG-ID: 8IRpRjchP5SpfjmCLhFo-w_1788684191
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EED88180A9E0; Sun,  6 Sep 2026 08:43:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C7EA434; Sun,  6 Sep 2026 08:43:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:39 +0400
Subject: [PATCH 8/9] tests/functional: add skipTestIfNoHMP() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-8-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=udEfK2auwP9IcDT1+8DmgO7VHhpaCvKf73tLtE+Boks=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5JiOAfaERk9pZOoupf+/MIfoL0+2rMYw5A
 cYCj4h66BeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5aKHEACPgUxyH+IuFi/1GFAIBtnzikmeab2Fcn0NTzCBg7NWU3k9EBNyz4OBLpplLmFHGteGYCH
 aqV6Pi7BHHrKXEgdkg04nDA+M7VR5n+doi6qH25v9qQP1pacOfnlHel2ZWmxaJMcE1/QM8PtGq+
 5ku1t7LmzVaNmsnbmAaq6FMa5BtgntCq33LG0/X8AR8Z8fz8IpzJpij1GDoNyKsF9oWEPgBJ/WH
 W8Th8HPNQmc2FT41jmUNQaB8OJe7C62pihe0z2aq1E7Bof1I/AJI6qEkgiy80H21RvBnTwZYb/A
 UPw0L/kq0EiFz+JTmrqpHWdCSS9fQrSYgG4diCUFFchUIq6QtQKbkipOVFPtNixsKgIO9j3prR1
 kx2kGuPJc3DCglIQQXmX+aKoHBF7IpKcb1MhWnCLznprDu81utty75q2Rwvem1/s3IdykPNMZd0
 g7s+TqkmLSWNiHNYYw50i3cMv9Lb61hhkB8fefJHZUelluwWz1KlZjOoW+O9KDbVerQRge0vbs5
 xN8YQg94fx86XAJN9PFfM95AoXj7Wg3YYIuoRK7Wtk0ThB6AnPhyANbPHsdajLOouU1Yx7UXTpL
 AGjDn1JmafX2rLSTe9ItwHk00N/Vm4vrEFMDgyACVRvEbbN6iCiy39Tq///zfzbcJalb6MWBcTO
 WdgRWBBHqxmMYSA==
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 69d3d06cc0e3..bf2dc1dc101c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -369,6 +369,12 @@ def require_accelerator(self, accelerator):
             self.skipTest("%s accelerator does not seem to be "
                           "available" % accelerator)
 
+    def skipTestIfNoHMP(self):
+        commands = self.vm.cmd('query-commands')
+        if not any(cmd['name'] == 'human-monitor-command'
+                   for cmd in commands):
+            self.skipTest('HMP support is not available')
+
     def require_netdev(self, netdevname):
         helptxt = run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
                       capture_output=True, check=True, encoding='utf8').stdout

-- 
2.55.0.543.g5ebe2ebe4ea8



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8CFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlWC-00011C-SF; Tue, 11 Nov 2025 05:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVt-0000gg-4S
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIlVr-0007Z8-QU
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762856531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldr/4XpoJFVrmRFARbNYB+3M+77Mw6pb8E04l9L7Zms=;
 b=VoFtPWgvbpQroedctxv1hgzg/iIzA3QjMtLBELbCG7ZJQnOMJmRDn5kwms88cRYndb502p
 pJlkCwHek23SzTEI7pKiE68lGbl7Mb/D7MHjrjYsRyassWaduPfUggC8V/utSNm4TJ/vwk
 7AXLdEMr/dwXSPxCxESHLMts6Yq21tE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-RihMbcPsP6iIxDE4Pqxr1g-1; Tue,
 11 Nov 2025 05:22:09 -0500
X-MC-Unique: RihMbcPsP6iIxDE4Pqxr1g-1
X-Mimecast-MFC-AGG-ID: RihMbcPsP6iIxDE4Pqxr1g_1762856529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3F2C180034F; Tue, 11 Nov 2025 10:22:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B25930044E0; Tue, 11 Nov 2025 10:22:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/4] tests/functional/m68k/test_nextcube: Fix issues reported
 by pylint
Date: Tue, 11 Nov 2025 11:21:58 +0100
Message-ID: <20251111102158.92091-5-thuth@redhat.com>
In-Reply-To: <20251111102158.92091-1-thuth@redhat.com>
References: <20251111102158.92091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Fix the indentation in one line, and while we're at it, use an f-string
instead of old-school formatting in another spot.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251110104837.52077-1-thuth@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index e5e1c69dcbd..71c160d0262 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -40,7 +40,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
             time.sleep(0.1)
 
         res = self.vm.cmd('human-monitor-command',
-                          command_line='screendump %s' % screenshot_path)
+                          command_line=f"screendump {screenshot_path}")
         if 'unknown command' in res:
             self.skipTest('screendump not available')
 
@@ -52,7 +52,7 @@ def test_bootrom_framebuffer_size(self):
 
         from PIL import Image
         with Image.open(screenshot_path) as image:
-                width, height = image.size
+            width, height = image.size
         self.assertEqual(width, 1120)
         self.assertEqual(height, 832)
 
-- 
2.51.1



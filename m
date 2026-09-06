Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD3C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38TD-0004P3-8M; Sun, 06 Sep 2026 04:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38TC-0004Od-CV
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38TA-0008BB-W9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLEJavX+CYl5URxiAxOIrkjtvTfg2pt7Qx+aNxGhous=;
 b=GlKpLZwj0Ef94Q5RRwBVxGfGBkCbj+8100tk6S4eogjIzxDPAFem8+89vQJMRGwvs6MAi6
 PP1T6IHrqlK1y6Kj7OxXliG6A1ntn7FcytX7VDx9QTLC7pTDUnfFNFT4zkEiri0lhuzYcO
 Lu27fqjgnVh9jSnr9xwszhAoN37OcBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-2IDeIHMyN9WFpR7xZ2RZ2Q-1; Sun,
 06 Sep 2026 04:43:17 -0400
X-MC-Unique: 2IDeIHMyN9WFpR7xZ2RZ2Q-1
X-Mimecast-MFC-AGG-ID: 2IDeIHMyN9WFpR7xZ2RZ2Q_1788684195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FEE1955DCB; Sun,  6 Sep 2026 08:43:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCB191800348; Sun,  6 Sep 2026 08:43:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:40 +0400
Subject: [PATCH 9/9] tests/functional: fix some tests that require HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-9-daee96491c43@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3OofPbadkMI9D2wQEsOueK3/Wbpgib4zDKoUa7tcwDk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5vJ/74g1y2az4tJkUWDTcDt51fE5IcjAQp
 jDgUKcFfuaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5UAJD/4yPrXD+IwoOZaaUijKLcx1qlZmr1KX6qA66KuJERoKxrxWFbxpH38uo+kDURhX+IeLsGI
 BO1HeI7zQ/iH3I9cppFBhBYRoUDwzyKo4pAqpWAVXQur8Ee5vbtnftQfk7ektWzUdCSRhrkqKK2
 HSnZa43VJU7P63naDHnwb815t9LrxAfRtwlElQORpbBwDqEDZxkXE0L0GIy1BvCRI9/E9Cl0/Vo
 TnqDZ5A4juBwNC43ToOmMuLiVnW6tapBAGJydZ7uQuMTOPhu7nm9yMZEnUlcNwUnE2s6lWVPCXA
 Y5N0Wfrc54maJQ3twRp9oTJ6pUjiXT+9zbQoR36D87beG+yz4uDkA4nS4GqPQPacIOPqujUyzIa
 17Z7W/Z7pj897AoJNP4amBUvOfRaFuPbLQGkXZXo5PPFe354v/9cuZwIsKJ/G5ejLXRbsfiVE0r
 HV6ZxDgmeEsKc39IgeMnDnuBybxSuc495ZOkJkMrNBu+4oT6PmDuHNhhN5f6j3cB+k+Dq6M8nhd
 PfaaR2n8DsW1KJ7Wn6nNVR+ZxWjYXXcx8hBdRrI7VORpIPwvLN8fXRaYLuvRpYIS3i9F7McUXi2
 ZQpFBaJuam78fnV8/fL+cKpurhpDuF9ZrV8IB/poRFSqinVsDfxTcu1hLjYU5vX1h6KQkmtHUJF
 Lf6KpJNjpmQIk4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Those tests use "info registers" command and connot be converted
easily, for now skip them

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 1 +
 tests/functional/ppc/test_ppe42.py     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index dc99962eb75c..b0c0b653a7d0 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -27,6 +27,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
 
         self.log.info('VM launched, waiting for display')
         # Wait for the FPU test to finish, then the display is available, too:
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
index 53958a7938d1..a9c154f67328 100755
--- a/tests/functional/ppc/test_ppe42.py
+++ b/tests/functional/ppc/test_ppe42.py
@@ -72,6 +72,7 @@ def test_ppe42_instructions(self):
         self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
         self.vm.add_args('-action', 'panic=pause')
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
         self._wait_pass_fail(self.timeout)
 
 if __name__ == '__main__':

-- 
2.55.0.543.g5ebe2ebe4ea8



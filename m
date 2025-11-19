Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508DCCF258C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdXz-00049E-73; Wed, 19 Nov 2025 03:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXa-0003ap-Bm
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXY-0000wA-8h
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eYpbHkbboeqGDjLjd0tKacdsmgmhRfnYu1bcQyCJsY=;
 b=WOc+B7DktWw50eLNIQI9x+8tGgWhWtna6X1MQUYp6An4jmR8AOzrMtcEYSJHqvXjUkRUYf
 m/k6wGnm4tNOnEnsRwfTbLW9RPzdXUUu5k2Tt8uFjJYc5+U4HnMq33x/OnuCQJtEkkxQX4
 5q+B2bbrn02bvEa3gWrQdhnjd9Po9HI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-CZmYnqPzOJSR-8pE5FiUqg-1; Wed,
 19 Nov 2025 03:27:44 -0500
X-MC-Unique: CZmYnqPzOJSR-8pE5FiUqg-1
X-Mimecast-MFC-AGG-ID: CZmYnqPzOJSR-8pE5FiUqg_1763540861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 514CA18AB410; Wed, 19 Nov 2025 08:27:41 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBF79180049F; Wed, 19 Nov 2025 08:27:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 09/15] tests/functional/ppc/test_amiga: Fix issues
 reported by pylint and flake8
Date: Wed, 19 Nov 2025 09:26:30 +0100
Message-ID: <20251119082636.43286-10-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Pylint complains about unused variable "tar_name" and a missing "check"
for subprocess.run(), and flake8 suggest a second empty line after the
class. While we're at it, also remove the unused "timeout" class variable
(that was only necessary for the avocado framework which we don't use
anymore).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc/test_amiga.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/ppc/test_amiga.py b/tests/functional/ppc/test_amiga.py
index 8600e2e9633..36378fb6972 100755
--- a/tests/functional/ppc/test_amiga.py
+++ b/tests/functional/ppc/test_amiga.py
@@ -15,8 +15,6 @@
 
 class AmigaOneMachine(QemuSystemTest):
 
-    timeout = 90
-
     ASSET_IMAGE = Asset(
         ('https://www.hyperion-entertainment.com/index.php/'
          'downloads?view=download&format=raw&file=25'),
@@ -25,19 +23,19 @@ class AmigaOneMachine(QemuSystemTest):
     def test_ppc_amigaone(self):
         self.require_accelerator("tcg")
         self.set_machine('amigaone')
-        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
         self.archive_extract(self.ASSET_IMAGE, format="zip")
         bios = self.scratch_file("u-boot-amigaone.bin")
         with open(bios, "wb") as bios_fh:
             subprocess.run(['tail', '-c', '524288',
                             self.scratch_file("floppy_edition",
                                               "updater.image")],
-                           stdout=bios_fh)
+                           stdout=bios_fh, check=True)
 
         self.vm.set_console()
         self.vm.add_args('-bios', bios)
         self.vm.launch()
         wait_for_console_pattern(self, 'FLASH:')
 
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.1



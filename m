Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0020CCF258C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdXt-0003oh-OG; Wed, 19 Nov 2025 03:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXK-0003Lc-2Q
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdXI-0000vG-3d
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKH8JzV0HsTyowkmfXKDxl1PvhzoYQBZm0t+mg6hM08=;
 b=Z3YBoEH76thgVJHIuAJaBGsLNf4wrJ+7Cwjtp537uqSsascmjDSm96UfRcc6BA74C19O/s
 GazjUk41MzzNXaORDZ1UAhZvs282wLVZODjC70exCTljYcQ47dMf6GaydVlCJe1aLIUFVc
 uqHpOEYOWWqdUWCm6SN4RJpDAYyF+Zk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-8hGYOz8GPAWMJpoHbfSn_g-1; Wed,
 19 Nov 2025 03:27:26 -0500
X-MC-Unique: 8hGYOz8GPAWMJpoHbfSn_g-1
X-Mimecast-MFC-AGG-ID: 8hGYOz8GPAWMJpoHbfSn_g_1763540844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F09AF1956070; Wed, 19 Nov 2025 08:27:23 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAF17180047F; Wed, 19 Nov 2025 08:27:17 +0000 (UTC)
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
Subject: [PATCH for-11.0 06/15] tests/functional/ppc64/test_hv: Silence
 warnings reported by pylint
Date: Wed, 19 Nov 2025 09:26:27 +0100
Message-ID: <20251119082636.43286-7-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

To make pylint happy here, remove unused variables, switch to f-string,
use "check=True" when calling subprocess.run() and split a line that was
too long.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc64/test_hv.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index d87f440fa79..beec1dbbea3 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -29,8 +29,6 @@
 @skipBigDataTest()
 class HypervisorTest(QemuSystemTest):
 
-    timeout = 1000
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
@@ -49,8 +47,8 @@ def extract_from_iso(self, iso, path):
         """
         filename = self.scratch_file(os.path.basename(path))
 
-        cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
-        subprocess.run(cmd.split(),
+        cmd = f"xorriso -osirrox on -indev {iso} -cpx {path} {filename}"
+        subprocess.run(cmd.split(), check=True,
                        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
         os.chmod(filename, 0o600)
@@ -66,7 +64,6 @@ def setUp(self):
 
     def do_start_alpine(self):
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args("-kernel", self.vmlinuz)
         self.vm.add_args("-initrd", self.initramfs)
         self.vm.add_args("-smp", "4", "-m", "2g")
@@ -78,7 +75,8 @@ def do_start_alpine(self):
         wait_for_console_pattern(self, 'localhost login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
         # If the time is wrong, SSL certificates can fail.
-        exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
+        cmd='date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"')
+        exec_command_and_wait_for_pattern(self, cmd, ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
         exec_command_and_wait_for_pattern(self, 'setup-apkrepos -c1', ps1)
-- 
2.51.1



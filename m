Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C3FC8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB0H-0005PA-Cw; Wed, 27 Aug 2025 03:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0F-0005Mo-2v
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0B-0001xw-GA
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ax4N2KC7YVDBUyVDJ7hDMEHXv/KwkKAMNpl+d/QPO48=;
 b=Aj77lyutokvJXaj+0igD+z8ofdt7rYJDVvQLpV25kHq4ncdep52TqLM55909y5CE69bx9V
 pfwFVdHOsLhpH4zz/lex34/t9SstYk4hDBTi1xegnzlA3S9M78d6ogu2KfBdjuC1LTqpIY
 808nlmWnTEwh6GqCtVzl/QwCNdu+NM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-rRvlxexZM4aOJyCR4uhsHw-1; Wed,
 27 Aug 2025 03:55:20 -0400
X-MC-Unique: rRvlxexZM4aOJyCR4uhsHw-1
X-Mimecast-MFC-AGG-ID: rRvlxexZM4aOJyCR4uhsHw_1756281319
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A3F819541AF; Wed, 27 Aug 2025 07:55:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 621ED1955F24; Wed, 27 Aug 2025 07:55:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/31] tests/functional/meson.build: Split timeout settings by
 target
Date: Wed, 27 Aug 2025 09:54:18 +0200
Message-ID: <20250827075443.559712-9-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We are going to move these settings into target-specific subfolders.
As a first step, split the big test_timeouts array up into individual
ones.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-4-thuth@redhat.com>
---
 tests/functional/meson.build | 50 +++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 38ae0d6cd3b..356aad12dee 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -10,7 +10,7 @@ if get_option('tcg_interpreter')
 endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
-test_timeouts = {
+test_aarch64_timeouts = {
   'aarch64_aspeed_ast2700' : 600,
   'aarch64_aspeed_ast2700fc' : 600,
   'aarch64_device_passthrough' : 720,
@@ -25,7 +25,9 @@ test_timeouts = {
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 360,
   'aarch64_virt_gpu' : 480,
-  'acpi_bits' : 420,
+}
+
+test_arm_timeouts = {
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
   'arm_aspeed_witherspoon' : 120,
@@ -44,24 +46,55 @@ test_timeouts = {
   'arm_replay' : 240,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
-  'intel_iommu': 300,
+}
+
+test_mips_timeouts = {
   'mips_malta' : 480,
+}
+
+test_mipsel_timeouts = {
   'mipsel_malta' : 420,
   'mipsel_replay' : 480,
+}
+
+test_mips64_timeouts = {
   'mips64_malta' : 240,
+}
+
+test_mips64el_timeouts = {
   'mips64el_malta' : 420,
   'mips64el_replay' : 180,
-  'netdev_ethtool' : 180,
+}
+
+test_ppc_timeouts = {
   'ppc_40p' : 240,
+}
+
+test_ppc64_timeouts = {
   'ppc64_hv' : 1000,
   'ppc64_powernv' : 480,
   'ppc64_pseries' : 480,
   'ppc64_replay' : 210,
   'ppc64_tuxrun' : 420,
   'ppc64_mac99' : 120,
+}
+
+test_riscv64_timeouts = {
   'riscv64_tuxrun' : 120,
+}
+
+test_s390x_timeouts = {
   's390x_ccw_virtio' : 420,
+}
+
+test_sh4_timeouts = {
   'sh4_tuxrun' : 240,
+}
+
+test_x86_64_timeouts = {
+  'acpi_bits' : 420,
+  'intel_iommu': 300,
+  'netdev_ethtool' : 180,
   'virtio_balloon': 120,
   'x86_64_kvm_xen' : 180,
   'x86_64_replay' : 480,
@@ -404,6 +437,11 @@ foreach speed : ['quick', 'thorough']
                                build_by_default: false,
                                env: test_precache_env)
       precache_all += precache
+      if is_variable('test_' + target_base + '_timeouts')
+        time_out = get_variable('test_' + target_base + '_timeouts').get(test, 90)
+      else
+        time_out = 90
+      endif
 
       # Ideally we would add 'precache' to 'depends' here, such that
       # 'build_by_default: false' lets the pre-caching automatically
@@ -419,8 +457,8 @@ foreach speed : ['quick', 'thorough']
            env: test_env,
            args: [testpath],
            protocol: 'tap',
-           timeout: test_timeouts.get(test, 90),
-           priority: test_timeouts.get(test, 90),
+           timeout: time_out,
+           priority: time_out,
            suite: suites)
     endforeach
   endforeach
-- 
2.50.1



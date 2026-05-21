Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F9FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0lm-000329-8c; Thu, 21 May 2026 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0lj-00031e-Vy
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0li-0007ST-Do
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779359805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pMz3yn+p7hvzMusYNs/nh2jymNftNbPIBu1EOsEsv0=;
 b=HL6GdQisWVlGqhtYkHtBktaX63Y/QeUBGDiXRlO3hI/C44WtgsSpDEjOVF2D4yOFIhcL0A
 uZMJvG3YEBXz568aAdgMvXiKxSCch53rL1buiwuzqJ+wt2f+RjwtnVE5lP1Y85RlGw7hVB
 hS5hmxRU9VcTbjwtk76IzDmrFx4G9IM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-TuvsNgePNCCc36KGfekPcQ-1; Thu,
 21 May 2026 06:36:38 -0400
X-MC-Unique: TuvsNgePNCCc36KGfekPcQ-1
X-Mimecast-MFC-AGG-ID: TuvsNgePNCCc36KGfekPcQ_1779359798
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA2801955F4A; Thu, 21 May 2026 10:36:37 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B1EA18004A3; Thu, 21 May 2026 10:36:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: capture filesystem, CPU,
 memory and kernel info in logs
Date: Thu, 21 May 2026 11:36:24 +0100
Message-ID: <20260521103624.1645809-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For tests we have often had wierd failures that are related to the
runner environment. For example, tests that fail only with specific
filesystem setups.

Since we don't control the runners directly, it is important to
capture info about the environment to aid in failure diagnosis.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 005058625e..005f49702b 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -27,6 +27,10 @@
     - section_start setup "Pre-script setup"
     - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
+    - cat /proc/mounts
+    - cat /proc/cpuinfo
+    - cat /proc/meminfo
+    - uname -a
     - section_end setup
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -102,6 +106,10 @@
     # Prevent logs from the build job that run earlier
     # from being duplicated in the test job artifacts
     - rm -f build/meson-logs/*
+    - cat /proc/mounts
+    - cat /proc/cpuinfo
+    - cat /proc/meminfo
+    - uname -a
 
 
 .functional_test_job_template:
@@ -126,6 +134,10 @@
     # Prevent logs from the build job that run earlier
     # from being duplicated in the test job artifacts
     - rm -f build/meson-logs/*
+    - cat /proc/mounts
+    - cat /proc/cpuinfo
+    - cat /proc/meminfo
+    - uname -a
   after_script:
     - cd build
     - du -chs ${CI_PROJECT_DIR}/*-cache
-- 
2.54.0



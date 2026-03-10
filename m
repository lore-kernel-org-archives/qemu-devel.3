Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8AFCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4Z-0006rT-5p; Tue, 10 Mar 2026 01:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4T-0006q7-2L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4P-0006EV-TW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1Vm1eHYlS+Lm527ZjKRZGb4bqL0Ij/7r3TdhZBCcgw=;
 b=V8MJKXVJnLDTyWP2tlOkZ+qH2N0tGH4CeZQllLlHQyo0aaGKsiPCTshAWJPs/UsirB2vhS
 6PBivOLqalnnFotM3VxgwnVcJX2TQb3Mh2mfSJqWOeFiEQUnie/xIT0aFWSIIk34pmPGk2
 kT1N8rSWucavMUar9LdzMgWmbHYtPs4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-gGhzzpaxPG280DfBI2tNsA-1; Tue,
 10 Mar 2026 01:55:49 -0400
X-MC-Unique: gGhzzpaxPG280DfBI2tNsA-1
X-Mimecast-MFC-AGG-ID: gGhzzpaxPG280DfBI2tNsA_1773122148
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F19D41956080; Tue, 10 Mar 2026 05:55:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D3661955D87; Tue, 10 Mar 2026 05:55:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/25] tests/functional/x86_64: Disable memlock test for asan
 builds
Date: Tue, 10 Mar 2026 06:55:09 +0100
Message-ID: <20260310055530.8893-5-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The address-sanitizer intercepts mlock() and makes it a no-op,
because it interacts badly with the sanitizer's own use of large
amounts of memory.  This means that our 'memlock' test will always
fail, because it checks via /proc for whether the QEMU process really
locked some pages.  Don't add the test when QEMU is built with asan.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260309104545.1550888-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 05e4914c772..1ed10ad6c29 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -14,13 +14,20 @@ tests_x86_64_system_quick = [
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
-  'memlock',
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'vmstate',
 ]
 
+# The address-sanitizer makes mlock() a no-op because it
+# interacts badly with the sanitizer; this means the memlock
+# test (which checks via /proc for whether pages were locked)
+# will always fail on a sanitizer build, so don't run it.
+if not get_option('asan')
+  tests_x86_64_system_quick += [ 'memlock' ]
+endif
+
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'hotplug_blk',
-- 
2.53.0



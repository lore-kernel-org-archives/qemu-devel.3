Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0FEC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Usw-0004ON-Lr; Mon, 13 May 2024 08:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Usn-0004ND-2W
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Usk-0004Vc-Tz
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715603657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZ785zT+qMcpYwxB8fMfufyghsbSHwxj2i1XQxD081o=;
 b=h4tbAhAqYXjW8UbY5StFBGkSVIJ+qKqmRaWEkG7JeR9wF3FbEvHjuWW//tUkhhWTnAJ/bG
 dgqtwtfGSMdS0vXVXtKSIoz4kthTnGJkWIvZziAtQhPTQ6ylc3mEG+jvwDMm05cUaCnSYL
 t7fipbGhTWG5btfP1IRlIGAH+9r00wQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-k8ZYeKBjO5KdnJZGFwLxSg-1; Mon, 13 May 2024 08:34:04 -0400
X-MC-Unique: k8ZYeKBjO5KdnJZGFwLxSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3F7809F64;
 Mon, 13 May 2024 12:34:03 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDEB7414;
 Mon, 13 May 2024 12:34:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests: add testing of parameter=1 for SMP topology
Date: Mon, 13 May 2024 13:33:58 +0100
Message-ID: <20240513123358.612355-3-berrange@redhat.com>
In-Reply-To: <20240513123358.612355-1-berrange@redhat.com>
References: <20240513123358.612355-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Validate that it is possible to pass 'parameter=1' for any SMP topology
parameter, since unsupported parameters are implicitly considered to
always have a value of 1.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-smp-parse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 56165e6644..56ce5128f1 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -330,6 +330,14 @@ static const struct SMPTestData data_generic_valid[] = {
         .config = SMP_CONFIG_GENERIC(T, 8, T, 2, T, 4, T, 2, T, 16),
         .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
         .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 4, 2, 16),
+    }, {
+        /*
+         * Unsupported parameters are always allowed to be set to '1'
+         * config: -smp 8,books=1,drawers=1,sockets=2,modules=1,dies=1,cores=4,threads=2,maxcpus=8
+         * expect: cpus=8,sockets=2,cores=2,threads=2,maxcpus=8 */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(8, 1, 1, 2, 1, 1, 2, 2, 8),
+        .expect_prefer_sockets = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
+        .expect_prefer_cores   = CPU_TOPOLOGY_GENERIC(8, 2, 2, 2, 8),
     },
 };
 
-- 
2.43.0



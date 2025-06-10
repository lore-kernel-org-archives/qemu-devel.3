Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E637AC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyEM-000107-72; Tue, 10 Jun 2025 08:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyEF-0000v2-RE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyED-0000KI-Uk
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNEVpaA6ZpnQR9kqI67uv9Fpve9YxWzS8rPPOTlSlY4=;
 b=XOQ0aCEnO5mSzUGBNoCmL20epu2DNVM9cppdCBkYSAiT/D/TrFcxE3zwVx8L7M/roRMDi0
 iszp9iPEl7Ei3w1HuMyf3kQQvMSANkr4kxNxnFl3yNWUf9YwV3xcmMRXZmitEOsNH8MsJ8
 AB1yarXTk4OVaP8+ZsMLJsjoo7jEsek=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-mrIVs1tSNCaSGYVn00HIHg-1; Tue,
 10 Jun 2025 08:37:17 -0400
X-MC-Unique: mrIVs1tSNCaSGYVn00HIHg-1
X-Mimecast-MFC-AGG-ID: mrIVs1tSNCaSGYVn00HIHg_1749559036
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A5E819560A2; Tue, 10 Jun 2025 12:37:16 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBE3F30002C4; Tue, 10 Jun 2025 12:37:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/31] include/qemu/compiler: add QEMU_UNINITIALIZED attribute
 macro
Date: Tue, 10 Jun 2025 13:36:39 +0100
Message-ID: <20250610123709.835102-2-berrange@redhat.com>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The QEMU_UNINITIALIZED macro is to be used to skip the default compiler
variable initialization done by -ftrivial-auto-var-init=zero.

Use this in cases where there a method in the device I/O path (or other
important hot paths), that has large variables on the stack. A rule of
thumb is that "large" means a method with 4kb data in the local stack
frame. Any variables which are KB in size, should be annotated with this
attribute, to pre-emptively eliminate any potential overhead from the
compiler zero'ing memory.

Given that this turns off a security hardening feature, when using this
to flag variables, it is important that the code is double-checked to
ensure there is no possible use of uninitialized data in the method.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
[DB: split off patch & rewrite guidance on when to use the annotation]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/compiler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 496dac5ac1..65b89958d3 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -207,6 +207,26 @@
 # define QEMU_USED
 #endif
 
+/*
+ * Disable -ftrivial-auto-var-init on a local variable.
+ *
+ * Use this in cases where there a method in the device I/O path (or other
+ * important hot paths), that has large variables on the stack. A rule of
+ * thumb is that "large" means a method with 4kb data in the local stack
+ * frame. Any variables which are KB in size, should be annotated with this
+ * attribute, to pre-emptively eliminate any potential overhead from the
+ * compiler's implicit zero'ing of memory.
+ *
+ * Given that this turns off a security hardening feature, when using this
+ * to flag variables, it is important that the code is double-checked to
+ * ensure there is no possible use of uninitialized data in the method.
+ */
+#if __has_attribute(uninitialized)
+# define QEMU_UNINITIALIZED __attribute__((uninitialized))
+#else
+# define QEMU_UNINITIALIZED
+#endif
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.49.0



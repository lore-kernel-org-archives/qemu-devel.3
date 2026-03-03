Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B225DEDA686
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKN-0006TD-Np; Tue, 03 Mar 2026 10:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKM-0006Sz-P8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKL-00024O-Bb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nNBnkbdOoq/TO93m2/cqfU9S+qOIByL3MN/2Z5FSuM=;
 b=gJR2EZ2+IuqxZiPZS/+jbOQ0xczuTWb3bZOLK886DSTrfiUFEBzyRfDfQ+slLGRFlfeDGs
 FtA7nlSjD7g8/Dqfn2ivAEdNhiXG5YQpZRuUzpJFOGHQtBJVtECNMbhJAj+SVpg90Uwysz
 P5C1mU5aB0KlVQR4bjOhcgtMucCVUK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-0FTQ7AJ9O8y_egDtBys-Yw-1; Tue,
 03 Mar 2026 10:06:23 -0500
X-MC-Unique: 0FTQ7AJ9O8y_egDtBys-Yw-1
X-Mimecast-MFC-AGG-ID: 0FTQ7AJ9O8y_egDtBys-Yw_1772550382
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 718081956075; Tue,  3 Mar 2026 15:06:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 791121800370; Tue,  3 Mar 2026 15:06:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 07/27] include: define constant for early constructor priority
Date: Tue,  3 Mar 2026 15:05:44 +0000
Message-ID: <20260303150604.2402872-8-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

Functions marked with __attribute__((__constructor__)) will be
invoked in linker order. In theory this is well defined, but
in practice, it is hard to determine what this order will be
with the layers of indirection through meson, ninja and the
static libraries QEMU builds.

Notably, the order currently appears different between Linux
and Windows (as tested with Wine on Linux). This can cause
problems when certain QEMU constructors have a dependancy on
other QEMU constructors.

To address this define a QEMU_CONSTRUCTOR_EARLY constant which
provides a priority value that will run before other default
constructors. This is to be used for QEMU constructors that
are themselves self-contained, but may be relied upon by other
constructors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 1c2b673c05..4c49f52eb0 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -194,6 +194,14 @@
 # define QEMU_USED
 #endif
 
+/*
+ * A priority for __attribute__((constructor(...))) that
+ * will run earlier than the default constructors. Must
+ * only be used for functions that have no dependency
+ * on global initialization of other QEMU subsystems.
+ */
+#define QEMU_CONSTRUCTOR_EARLY 101
+
 /*
  * Disable -ftrivial-auto-var-init on a local variable.
  *
-- 
2.53.0



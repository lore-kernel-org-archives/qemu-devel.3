Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E927D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC05G-0004WQ-Ad; Fri, 15 Nov 2024 12:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04u-0004HA-65
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04s-0001Y1-MR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HH5f2yuM2bMECV8KwaAKjBVmFwnaT6DkSO6d1yN6l0Y=;
 b=FwzzXAz2dnVrx0FhgYYidaxJtqIZPT/VJWmMdTiPqjnFTj1J6CbN36GInfsClMyQSzHxJ5
 1PLNgsdQp2WWknG2jkTZjsTxgQ5hkA5ZrkpfhJfWWNQc/0cazPgDw648otLgk24Q8WwakM
 GE0HXAmq1D8iyLf/i3LPvVcXqip2IEc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-QrVR8gzLPAC3-9tcF04eSQ-1; Fri,
 15 Nov 2024 12:25:48 -0500
X-MC-Unique: QrVR8gzLPAC3-9tcF04eSQ-1
X-Mimecast-MFC-AGG-ID: QrVR8gzLPAC3-9tcF04eSQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95FC31953956
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:47 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E76DA3003B71; Fri, 15 Nov 2024 17:25:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 9/9] hw: enforce use of static, const string with qdev_new()
Date: Fri, 15 Nov 2024 17:25:21 +0000
Message-ID: <20241115172521.504102-10-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

Since qdev_new() will assert(), it should only be used in scenarios
where the caller knows exactly what type it is asking to be created,
and can thus be confident in avoiding abstract types.

Enforce this by using a macro wrapper which types to paste "" to the
type name. This will generate a compile error if not passed a static
const string, forcing callers to use qdev_new_dynamic() instead.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev.c         |  3 ++-
 include/hw/qdev-core.h | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index eceba33222..968fa33a95 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -144,7 +144,8 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
-DeviceState *qdev_new(const char *name)
+/* Only to be called via the 'qdev_new' macro */
+DeviceState *qdev_new_internal(const char *name)
 {
     return DEVICE(object_new_dynamic(name, &error_abort));
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 566c5ef277..335dcd31b0 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -448,7 +448,17 @@ compat_props_add(GPtrArray *arr,
  *
  * Return: a derived DeviceState object with a reference count of 1.
  */
-DeviceState *qdev_new(const char *name);
+
+/*
+ * NB, qdev_new_internal is just an internal helper, wrapped by
+ * the qdev_new() macro which prevents invokation unless given
+ * a static, const string.
+ *
+ * Code should call qdev_new(), or qdev_new_dynamic(), not
+ * qdev_new_internal().
+ */
+DeviceState *qdev_new_internal(const char *name);
+#define qdev_new(name) qdev_new_internal(name "")
 
 /**
  * qdev_new_dynamic: Create a device on the heap
-- 
2.46.0



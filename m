Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D9CC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWBe-0007Ke-5A; Wed, 22 Jul 2026 08:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmWBc-0007JA-0v
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmWBa-0008Da-3O
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784723788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wvH4kJ16rmYgzYlY20WgRCGo+Mnmz7RCGiO6iGpYuA0=;
 b=ZH38rOReIIiYCumqFv1pTafLN33SOJRgM84UdYJHmGIsoc9gDIf5uBGyLpIQDcr/3gk6Dp
 UyNTBjpJ6S7YehrUdUwcJCmlwQYkCMJFr6VmmPi+yG+Skit1f4TTQhpOeZHhFEy8TfKDyc
 GCUb6zrfg5RKOCpthecFR5GX2iWh358=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-ZTbs7avnOh6UddpihfHxbA-1; Wed,
 22 Jul 2026 08:36:24 -0400
X-MC-Unique: ZTbs7avnOh6UddpihfHxbA-1
X-Mimecast-MFC-AGG-ID: ZTbs7avnOh6UddpihfHxbA_1784723783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91A00180AAAE; Wed, 22 Jul 2026 12:35:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D9DE763; Wed, 22 Jul 2026 12:35:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] linux-user: Guard local FUTEX_CMD_MASK definition
Date: Wed, 22 Jul 2026 14:35:45 +0200
Message-ID: <20260722123545.743792-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Building linux-user on a host with Linux 7.2 kernel headers fails with
a macro redefinition error for FUTEX_CMD_MASK. The kernel commit
3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
expanded the mask to include the new FUTEX_ROBUST_UNLOCK and
FUTEX_ROBUST_LIST32 flags, which conflicts with QEMU's local
definition.

Add a #ifndef guard so the host definition takes precedence when
available. The local fallback is kept for older kernel headers
(pre-2.6.29) that lack FUTEX_CMD_MASK or define a mask without
FUTEX_CLOCK_REALTIME.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 linux-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5799769f832fd953fe731a33ad7746113dff9957..e033c7db341622e825da6457b1539dd2682b711f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2593,7 +2593,9 @@ struct target_drm_i915_getparam {
 
 #define FUTEX_PRIVATE_FLAG      128
 #define FUTEX_CLOCK_REALTIME    256
+#ifndef FUTEX_CMD_MASK
 #define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+#endif
 
 #if defined(TARGET_X86_64)
 #define TARGET_EPOLL_PACKED QEMU_PACKED
-- 
2.55.0



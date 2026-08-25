Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEC0C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLf-0003nO-HZ; Tue, 25 Aug 2026 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLc-0003dB-Q1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLb-00061P-28
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNlIBvz9vXULY0YURh0J5GIWI45xUL5THxgzjzMCUTM=;
 b=O2qroc5MRnjboRGH5qd6/g+pVBQKOQxmF3qA5tb554le6vrdMiZddSipv9GPIjDcUmDuQF
 qV4thw7XPephpGpxnEbaq5abNs+9VGLSnTTy9ZBk6n1kXTzIak2HuEkPh8FvED+os3w6g0
 dYSPNNOgYrcy/DTVQY342u1kYvZQ9Fk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-D2kBVfK8O6yUFE2GUR1LCg-1; Tue,
 25 Aug 2026 07:29:38 -0400
X-MC-Unique: D2kBVfK8O6yUFE2GUR1LCg-1
X-Mimecast-MFC-AGG-ID: D2kBVfK8O6yUFE2GUR1LCg_1787657377
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C781E191FCE9; Tue, 25 Aug 2026 11:29:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 413CE19539B7; Tue, 25 Aug 2026 11:29:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:59 +0400
Subject: [GIT PULL 09/19] ui/egl: fix qemu_egl_display type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-9-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UyNdNiV0dG+DhwVXNcwxb79nxs6Z7XIzmMBiOXtFPV0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUH9Z0r4QzMDXxY8XrA/VHXEPioqGZQgeKe
 wUNFYnNWuOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5WrPD/44Vo3RUZ3HukS7ADF7R8MHpuTGPzTg2elp2FqNfIExXHBRbUASIs83suy7rbA8JlXdw35
 8JXRuZRtPih4BMXqUDivtwQbw5VC/JRMirTfzJB2zzLSquv1XjSJ8inI01fE8wcYTs/MgeNXKpu
 L98DtMkDKMNts7W0M99Wxhd8/o2WpTo/TqK1Iqk5JfeyAXPGQpH12ph/ADVLpGS4ED9jRCFvHnn
 pNuK8xICvBExke33vUzHSCwTXRis4JXtPtWaoB3OiIK/+C+9CkHULaK7v5fWI+Ut7ZsPf7Syu3A
 +5JE1b/hmDuVjqLjH7XNSDv/vl0dzu5dNksKevjGWa3RYZJBksZYtGUKCDOR/rZEJavkAQd2LQQ
 +Y5AG2RDAfY0oCTHdAmQ3Swmj31pklYZ0n5mH1/ysXAtmH9unin7o1TpCi8/ab4W0mGQxHdAcMU
 ApUm8TxwuRpcSLRnCuqFYkENpb6qYbX4PcEeQQk0onYeVq6jf9etnFRuFhR8VhQKOH05rhQwKY2
 WmybQZxY1fID5A867dvnWr5d4iFRzIWZERcu0OCZZGV2QWS75HHtaTbE5/ZV81uSVAmn0Dib+vi
 LluMxdtHOFqZy+X6Z2l+s6+IM3U7ZzpSAUQqE5PsVdQmAuoIZKyaM6O6BU2f+dB5W6Ol90b54+o
 zxihiDzswczfpTQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

EGLDisplay is already a pointer type (void *), so declaring
qemu_egl_display as EGLDisplay * makes it void **, which
doesn't match any of its usages.

Fixes: 7ced9e9f6da2 ("ui: add egl-helpers")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260820131933.2729240-1-marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-helpers.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 405ddd912591..679c79eacd54 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -9,7 +9,7 @@
 #include "ui/console.h"
 #include "ui/shader.h"
 
-extern EGLDisplay *qemu_egl_display;
+extern EGLDisplay qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 extern DisplayGLMode qemu_egl_mode;
 extern bool qemu_egl_angle_d3d;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e89cc7c49af6..8e3729a54d15 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -25,7 +25,7 @@
 #include "trace.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
-EGLDisplay *qemu_egl_display;
+EGLDisplay qemu_egl_display;
 EGLConfig qemu_egl_config;
 DisplayGLMode qemu_egl_mode;
 bool qemu_egl_angle_d3d;

-- 
2.55.0.543.g5ebe2ebe4ea8



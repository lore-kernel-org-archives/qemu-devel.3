Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C4EC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGQ9-0007IR-M6; Wed, 26 Feb 2025 07:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPz-0007F0-1M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPv-0000gL-QZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740572493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhDAGmGGHM+6yqxXlBEye9IBdnCA/gcjGLsrCbhVe9U=;
 b=DBn9y3+/w4ZoPHxcn1q7S0T4j7M3XsceGzGp2GhAcMi4t/VYXzJAF1k1cqe95w4YhkMEe0
 vYf6mBXuURZVWzpRYKBK/dHPSvoiFCQLBbd4gmADutlFAHvwJYO+AYaenLKHDuDypKKRRW
 v49IR3EgzwxsLDNgkL2Be5a/BGN4UTs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-xvupr2_3M9abZ29JvZ01Bw-1; Wed,
 26 Feb 2025 07:21:28 -0500
X-MC-Unique: xvupr2_3M9abZ29JvZ01Bw-1
X-Mimecast-MFC-AGG-ID: xvupr2_3M9abZ29JvZ01Bw_1740572488
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90EE1801A17; Wed, 26 Feb 2025 12:21:27 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.227.242])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 608C219560B9; Wed, 26 Feb 2025 12:21:26 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/3] qga: Add log to guest-fsfreeze-thaw command
Date: Wed, 26 Feb 2025 14:21:18 +0200
Message-ID: <20250226122120.85790-2-kkostiuk@redhat.com>
In-Reply-To: <20250226122120.85790-1-kkostiuk@redhat.com>
References: <20250226122120.85790-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241216154552.213961-2-kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 2 ++
 qga/commands-win32.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6e3c15f539..12bc086d79 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     int ret;
 
     ret = qmp_guest_fsfreeze_do_thaw(errp);
+
     if (ret >= 0) {
         ga_unset_frozen(ga_state);
+        slog("guest-fsthaw called");
         execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
     } else {
         ret = 0;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 99c026c0a0..749fdf8895 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     qga_vss_fsfreeze(&i, false, NULL, errp);
 
     ga_unset_frozen(ga_state);
+
+    slog("guest-fsthaw called");
+
     return i;
 }
 
-- 
2.48.1



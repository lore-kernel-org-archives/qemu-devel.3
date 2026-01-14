Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D99D31A28
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwJc-0007es-7X; Wed, 14 Jan 2026 03:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwJY-0007bM-Bb
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwJW-0006e7-Sc
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768379593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wfssziJG2rNWSpwbyWUkGDi+9K0T813TnKrCIIVFFvo=;
 b=FhXbjPSTZefmDhVLENLzUdQheKBZ2sq2axF5dybCK5ERpLbmbvmKq1TgX/qtyewnZi0+P8
 XOZg46wrw645wi3rL/rUYcJOdvUThZK45cQqjW88TnwP5ODv9Qh+WZVc2oYiUo7JlcIif4
 88ktWn0bh8QBDdD91XN8X6KOYx/1cYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-RPnIn6zVPPinFg7st-bIuQ-1; Wed,
 14 Jan 2026 03:33:11 -0500
X-MC-Unique: RPnIn6zVPPinFg7st-bIuQ-1
X-Mimecast-MFC-AGG-ID: RPnIn6zVPPinFg7st-bIuQ_1768379590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 314D519560AD; Wed, 14 Jan 2026 08:33:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F1AA1956048; Wed, 14 Jan 2026 08:33:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org
Subject: [PATCH] configure: Set $PYTHON in the configuration of the optionroms
Date: Wed, 14 Jan 2026 09:33:06 +0100
Message-ID: <20260114083306.18172-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

pc-bios/optionrom/Makefile uses $(PYTHON) for running a Python script,
but this variable is never initialized here. So the script gets run
via its shebang line - which fails if the "python3" binary is not
available on the system. To fix this, write the PYTHON configuration
to the config.mak file of the optionroms.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 55e0bd34256..f7e8d7ad4c8 100755
--- a/configure
+++ b/configure
@@ -1643,6 +1643,7 @@ probe_target_compiler() {
 }
 
 write_target_makefile() {
+  echo "PYTHON=$python"
   echo "EXTRA_CFLAGS=$target_cflags"
   if test -z "$target_cc" && test -z "$target_as"; then
     test -z "$container_image" && error_exit "Internal error: could not find cross compiler for $1?"
-- 
2.52.0



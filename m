Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC653C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UPC-0006LR-SD; Tue, 01 Sep 2026 15:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UPB-0006F1-DR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UP9-0002Nb-TW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788291863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEm3jbhfxEfB9NqFt69UcYB9HksOABz3KkUOOO4fawM=;
 b=IZl6pQsLaDA2UqDa4+lah9lhZp81IaHT+JJiGCA04XTIRl6S9l7+mGJJ5HU8B5KwwGOz9L
 WNAV8zwUj6M4N3xC2MaIRiMi3n5dKFy9d9UstRDWkWfH1vAwEh2yGm3DPBxBkUc6SPgDag
 YhGhZjmGm7wHJtBP11+h5lbaXYLKfRc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-HA_aESQJPDaboUZWStkTRA-1; Tue,
 01 Sept 2026 15:44:21 -0400
X-MC-Unique: HA_aESQJPDaboUZWStkTRA-1
X-Mimecast-MFC-AGG-ID: HA_aESQJPDaboUZWStkTRA_1788291860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3482F1801318; Tue,  1 Sep 2026 19:44:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D5DB18005B8; Tue,  1 Sep 2026 19:44:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/12] qapi: convert simple command intros for machine.json
Date: Tue,  1 Sep 2026 15:43:23 -0400
Message-ID: <20260901194324.458482-12-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 8ef12504d65..9d709cb53e0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -363,11 +363,10 @@
 
 ##
 # @system_wakeup:
-#
-# Wake up guest from suspend.  If the guest has wake-up from suspend
-# support enabled (wakeup-suspend-support flag from
-# `query-current-machine`), wake-up guest from suspend if the guest is
-# in SUSPENDED state.  Return an error otherwise.
+#     Wake up guest from suspend.  If the guest has wake-up from
+#     suspend support enabled (wakeup-suspend-support flag from
+#     `query-current-machine`), wake-up guest from suspend if the
+#     guest is in SUSPENDED state.  Return an error otherwise.
 #
 # Since: 1.1
 #
@@ -415,11 +414,10 @@
 
 ##
 # @inject-nmi:
-#
-# Injects a Non-Maskable Interrupt (machine specific: for example on
-# s390x CCW only the first vCPU receives the NMI, but on x86 machines
-# all vCPUs receive it).  The command fails when the guest doesn't
-# support injecting.
+#     Injects a Non-Maskable Interrupt (machine specific: for example
+#     on s390x CCW only the first vCPU receives the NMI, but on x86
+#     machines all vCPUs receive it).  The command fails when the
+#     guest doesn't support injecting.
 #
 # Since: 0.14
 #
-- 
2.55.0



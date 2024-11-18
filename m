Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3993AD591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gu-0000X5-Cx; Mon, 18 Nov 2024 12:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gk-0008SY-4M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gh-0004tU-F6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/nRngikM8XwlZ3uc1cXGcgJ7UePav7UZ6qewh34zPI=;
 b=XvxrcYO5bvWCh+bA+ij1htLSR/p11z84Jn0CrbLsMVfKv60u4+T5REl8Z4IITAsaWdu+XX
 7jy07s7XFxinnoLyFqIOIB6lcZgYxNOeoU+HTFMnFyIhdMVT0s63EVlAXWGOnUFIX9lHnT
 +VpBqIt4ZsKjJV+Da4u4pcUznj0shaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-7gN5xAeePxOAii7t3Hk-jA-1; Mon,
 18 Nov 2024 12:37:16 -0500
X-MC-Unique: 7gN5xAeePxOAii7t3Hk-jA-1
X-Mimecast-MFC-AGG-ID: 7gN5xAeePxOAii7t3Hk-jA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB8F7192E27A; Mon, 18 Nov 2024 17:37:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 567E4196AFD6; Mon, 18 Nov 2024 17:37:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/12] .gitlab-ci.d: Raise timeout on cross-accel build jobs to
 60m
Date: Mon, 18 Nov 2024 18:36:34 +0100
Message-ID: <20241118173634.473532-13-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The current 30 minute timeout on the cross_accel_build_job template
is a bit low: sometimes if the k8s runners are running slow the
can hit it, for example this cross-arm64-xen-only job hit the
30 minute timeout while still not quite finished with the compile:
https://gitlab.com/qemu-project/qemu/-/jobs/8401277985

This is partly a "runner performance can be unpredictable" issue:
https://gitlab.com/qemu-project/qemu/-/jobs/8391726482
is the same job from just a day earlier and it finished in
16 minutes. But we already have build jobs that are higher
timeouts than 30 minutes, so we have headroom to raise the
timeout here to something we're less likely to hit on a slow
runner.

Bump the cross_accel_build_job timeout to 60 mins.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241118153226.1524542-1-peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/crossbuild-template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 45a9810355..303943f818 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -57,7 +57,7 @@
   extends: .base_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  timeout: 30m
+  timeout: 60m
   cache:
     paths:
       - ccache/
-- 
2.47.0



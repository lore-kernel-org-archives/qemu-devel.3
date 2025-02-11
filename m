Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5813DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQu-0005hO-2c; Tue, 11 Feb 2025 07:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQs-0005h0-H9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQq-0000OK-Pn
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ojImfigN5l1VNcIHNf6huQejoY5HsuARWAMCn/LL4w=;
 b=O7QeU/PuRhsScIc5GPiB2h14SZHHxkCvwfssBvye1ANDNK+Bf/XuiN6MsWI7GYFJ+CiCqi
 XF/KtOwwl4AqYaeAjNYH1oliy98mqWfLXj71gGv42vX/f5FjFrqp4Ez4SjTqxOZRM+AaiK
 uNFQAbUkQfVvGYhA/VMnrhTNp5zSs+k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-4NSgsBvmMRC3hYsMsM8Lkg-1; Tue,
 11 Feb 2025 07:32:01 -0500
X-MC-Unique: 4NSgsBvmMRC3hYsMsM8Lkg-1
X-Mimecast-MFC-AGG-ID: 4NSgsBvmMRC3hYsMsM8Lkg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B56F11800876
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:32:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF1D219560A3; Tue, 11 Feb 2025 12:31:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/7] gitlab: don't fail cirrus CI jobs when credits are
 exhausted
Date: Tue, 11 Feb 2025 13:31:42 +0100
Message-ID: <20250211123144.37617-6-thuth@redhat.com>
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: Daniel P. Berrangé <berrange@redhat.com>

In the last week of the month we have often run out of credits on
Cirrus CI, which causes the jobs to fail, in turn causing the
overall pipeline to fail.

The cirrus-run tool can now detect the "out of credits" scenario
and exits with a code of '3'.  We can tell gitlab to treat this
exit code as special and mark the job as "warning" instead of
"failed". This allows the pipeline status overall to remain
green, when we have non-technical issues with Cirrus CI.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241204194807.1472261-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/cirrus.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index a9e43e21d0..adc0007e5d 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -15,6 +15,8 @@
   stage: build
   image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:latest
   needs: []
+  allow_failure:
+    exit_codes: 3
   # 20 mins larger than "timeout_in" in cirrus/build.yml
   # as there's often a 5-10 minute delay before Cirrus CI
   # actually starts the task
-- 
2.48.1



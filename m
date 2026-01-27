Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B5DD2F037
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk2W-0006CI-H5; Tue, 27 Jan 2026 09:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2P-0006Ad-NS
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2M-0003ab-BU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tbZk7kKvr/QHmajzAyPefU5UXlH0HA6YDOdEBNq1qA=;
 b=Hf99dxwMRNUfXbIsy7knqC2af7p1pT3mRilFb/jtMY75O8DQS6qmMjol2rfSf7aJ9bRX0p
 7gkULdnaSrcZ5SfzRABFaEEfa58KPOp+lgQfpoGlgc9/Q3RckB/vxW5Y9zRLT7ie6gDdA+
 z+5C59b2nywdbBOhcg0NqcmmlS23ksM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-d9jj_lo_MzurQ4QRibKLqQ-1; Tue,
 27 Jan 2026 09:27:18 -0500
X-MC-Unique: d9jj_lo_MzurQ4QRibKLqQ-1
X-Mimecast-MFC-AGG-ID: d9jj_lo_MzurQ4QRibKLqQ_1769524037
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D27211800350; Tue, 27 Jan 2026 14:27:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B9E618001D5; Tue, 27 Jan 2026 14:27:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/9] gitlab: preserve base rules for container template
Date: Tue, 27 Jan 2026 15:27:02 +0100
Message-ID: <20260127142710.131904-2-thuth@redhat.com>
In-Reply-To: <20260127142710.131904-1-thuth@redhat.com>
References: <20260127142710.131904-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When extending the container template to allow scheduled pipelines in
upstream context, we must ensure that all the existing rules defined
by .base_job_template are preserved.

Fortunately since the new rule for scheduled pipelines can come at
the head of all other rules, not in the middle, we can just the obscure
'!reference' syntax to pull in all the pre-existing rules as a single
block.

This fixes

 * stable branches using the wrong tag name in container images
 * pushes to forks unconditionally running container builds

Fixes: 8bec7b9874235e60f14172618121c60fdbd39302
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 8bec7b987423 ("gitlab: add a weekly container building job")
Message-ID: <20260119135528.2738108-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index b92e96b0fc5..6eaa2f804df 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -23,6 +23,5 @@
     - docker logout
   rules:
     # because we want to enable this for scheduled runs we also have to replicate the normal rules
-    - if: '$CI_PIPELINE_SOURCE == "schedule"'
-    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: '$QEMU_CI && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
+    - !reference [.base_job_template, rules]
-- 
2.52.0



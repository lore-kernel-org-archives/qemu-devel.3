Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FC8CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCgI-0008UB-GW; Thu, 18 Jun 2026 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waCgG-0008TG-AJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waCgE-0001Il-MY
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781788874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEWf0ZU+dsINR42xlTmsrhOsHjAE9Frm+jOm/QO41qw=;
 b=iVvGRgU4FV4PG+GCsHGiGWOoyYE5b1pUGxoh0T/lU9b4F/UFUQ7PNUh4ne+/Hhs/yqashQ
 sB5/IQYpSJqOxZygwlziOhFnBm15oFp78rwsAvdlSQrOY/RrQ2nR1McLxoUv4jOEAzpdZk
 3bPfXLoaCBJqkLeGXDaKoqDRF8QCLmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-2l_W79Y1NGCD4Wf12FEAww-1; Thu,
 18 Jun 2026 09:21:10 -0400
X-MC-Unique: 2l_W79Y1NGCD4Wf12FEAww-1
X-Mimecast-MFC-AGG-ID: 2l_W79Y1NGCD4Wf12FEAww_1781788869
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A70DF19540F0; Thu, 18 Jun 2026 13:21:09 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A77C11956044; Thu, 18 Jun 2026 13:21:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [qemu-web PATCH v2 2/3] contribute: add automated tool disclosure to
 bug reporting
Date: Thu, 18 Jun 2026 14:20:57 +0100
Message-ID: <20260618132058.1044341-3-berrange@redhat.com>
In-Reply-To: <20260618132058.1044341-1-berrange@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

A while back we added a requirement to declare the use of any
automated tooling used in discovery of security issues, and set
a rule that the reporter must perform triage before submission
rather than blindly reporting issues. This applies equally
well to normal issue reporting, so copy it over from the
security process guidance.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 contribute/report-a-bug.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index 6071837..fd3bc6b 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -20,6 +20,13 @@ on GitLab, taking into account the following guidance.
   to the vendor's own bug tracker instead, or reproduced with
   an upstream QEMU build prior to submission.
 
+* If any automated tools (AI/LLM based, traditional static
+  analysis, or fuzzers) were used to discover the issue, the
+  reporter is required to declare this at the start of the
+  bug report. Users of such tools are required to perform
+  triage of their output to validate all findings and reproducer
+  scenarios prior to submitting a bug report.
+
 * Reproduce the problem directly with a QEMU command-line. Avoid
   frontends and management stacks, to ensure that the bug is in
   QEMU itself and not in a frontend and make it easier for
-- 
2.54.0



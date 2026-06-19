Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEF9CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVJn-0002CO-9G; Fri, 19 Jun 2026 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waVJm-0002C8-45
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waVJk-0007Gg-Fy
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781860514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l2eCPh7teHEiD5EX+/UUGPRbDeyOZ1+7NiTa3uHtTxM=;
 b=akQf+QSpptNgzpNdhsNbG1iNBIu5q17ZnGfE4UylzrEJVqUk2lAsuEh0sX8DE9BqSnrGtY
 JkV0RjuD8Z5U8tXLMBk/Je+8yhYpU9L6TaEQLcSmht+o94JHDnphEDQvzglujw5rR+zDLw
 ihHkstWxLf2D+1/1caJzyY3XqHbYMiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-R5qNNU-4MFG2eeGVLFZyfQ-1; Fri,
 19 Jun 2026 05:15:13 -0400
X-MC-Unique: R5qNNU-4MFG2eeGVLFZyfQ-1
X-Mimecast-MFC-AGG-ID: R5qNNU-4MFG2eeGVLFZyfQ_1781860512
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12601955E88
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:15:11 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECA3B1956088; Fri, 19 Jun 2026 09:15:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web PATCH v2] security: rework guideline about issue URL / CVE
 references
Date: Fri, 19 Jun 2026 10:15:08 +0100
Message-ID: <20260619091508.1194994-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

In v2:

 - Use non-existing issue number as example
 - Mention both issue URL and CVE to be optionally included
   in all commit messages in a series

 contribute/security-process.md | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/contribute/security-process.md b/contribute/security-process.md
index c091fa1..0ec1952 100644
--- a/contribute/security-process.md
+++ b/contribute/security-process.md
@@ -92,19 +92,28 @@ be scrubbed before disclosure.
 
  * The maintainer(s) will develop and/or review patch(es)
    for the issue privately, optionally attaching work in
-   progress fixes to the GitLab issues. All patches must
-   include the issue URL in the commit message(s). The
-   **"Workflow::In Progress"** label should be assigned when
+   progress fixes to the GitLab issues. The
+   **"Workflow::In Progress"** label can be assigned when
    a maintainer starts working on a fix.
 
  * When a CVE is allocated, it must be recorded as a comment on
    the GitLab issue, and the **"CVE::Required"** label replaced by
    the **"CVE::Assigned"** label.
 
- * The maintainer(s) will update the commit message(s) to include
-   the assigned CVE and issue URL. If multiple commits are required
-   to fix an issue the CVE must be included in the final commit in
-   the series, and may optionally be included in all prior commits.
+ * The maintainer(s) will update the commit message(s) before
+   sending a pull request to include the assigned CVE and issue
+   URL in the following format:
+
+     ```
+     Fixes: CVE-1980-12345
+     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/42
+     Reviewed-by: Not Me <notme@elsewhere.com>
+     Signed-off-by: Some One <someone@somewhere.com>
+     ```
+
+   If multiple commits are required to fix an issue the CVE & issue
+   URL must be included in the final commit in the series, and may
+   optionally be included in all prior commits.
 
  * When the maintainer(s) are satisfied that the patch(es) are
    suitable to propose for merge, they must be submitted to
-- 
2.54.0



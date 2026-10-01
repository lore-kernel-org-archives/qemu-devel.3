Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B987CCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUl-00006z-76; Thu, 01 Oct 2026 13:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUi-00005j-JT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUg-0006wi-6U
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8at+swstqrGAUyB6OIzkTtvoAOHY+PW+wLe6WMUYbs=;
 b=FTU4+PP+bJOn8s8x6d04cvNPTVojiDIV3u4DErFtrEKsyjH8JTxJ9d9n1E3e8vHAJ+6/KA
 EAoukUp38wtvoqRgn/Hhi9Nryg9x8DrL9qla1QD+iSjxZlk0gXPjSZXzMwVIr78CXBbYS0
 ZSD1vzxCLYPFCwUcf4ZiiexCqaly328=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-D9tSikvAM0eV31SRHUsgVw-1; Thu,
 01 Oct 2026 13:22:49 -0400
X-MC-Unique: D9tSikvAM0eV31SRHUsgVw-1
X-Mimecast-MFC-AGG-ID: D9tSikvAM0eV31SRHUsgVw_1790875368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C290197702D; Thu,  1 Oct 2026 17:22:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACAC31800348; Thu,  1 Oct 2026 17:22:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 06/11] docs/qapi-code-gen: add "Errors" and "Returns"
 subsections
Date: Thu,  1 Oct 2026 13:22:33 -0400
Message-ID: <20261001172239.2825745-7-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

This is a two-for-one as they are described together in one paragraph,
which I split apart into two sections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 8fc75488019..90488da7ffd 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1024,8 +1024,31 @@ like this::
  #     Duis aute irure dolor in reprehenderit in voluptate velit esse
  #     cillum dolore eu fugiat nulla pariatur.
 
-"Returns" and "Errors" sections are only valid for commands.  They
-document the success and the error response, respectively.
+
+Returns
+^^^^^^^
+
+"Returns" sections are only valid for commands.  They document the
+success response of the command. If there is some nuance to capture
+with the return value, it may be documented as::
+
+  #
+  # Returns: a list describing each virtual block device.  Filter nodes
+  #     that were created implicitly are skipped over.
+  #
+
+Long descriptions are written as a block, with additional lines indented.
+
+The type of the return value will be added to the documentation
+automatically. If there is nothing relevant to add apart from type,
+this section may be omitted.
+
+
+Errors
+^^^^^^
+
+"Errors" sections are only valid for commands.  They document
+the error response(s) for a command.
 
 "Errors" sections should be formatted as an rST list, each entry
 detailing a relevant error condition.  For example::
-- 
2.55.0



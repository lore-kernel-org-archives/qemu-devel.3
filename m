Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541E3CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUk-00006u-Qi; Thu, 01 Oct 2026 13:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUi-00005e-Fy
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUf-0006wZ-PR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcofzWvDzqbOlYQzfI7ekRqRMO9baKh4hD5KFHBom4s=;
 b=D0WF1QMLbXOPOhBJy54mIaBA8+D2IZlu4ERQqLAYKTbffcCIlfcAQ3pputnclb3SxtRFzJ
 MG9wpKwlDbMgz8B8qoTGtiIZyKFmSOzNakdnGFrHu43SBi5bV5yqGOwb8alNt4KOJRgkDn
 tFhJph5lLAGru4LIivtyONA49BZno5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-dnDZ9IqIMxOsLS9k9SWSbA-1; Thu,
 01 Oct 2026 13:22:50 -0400
X-MC-Unique: dnDZ9IqIMxOsLS9k9SWSbA-1
X-Mimecast-MFC-AGG-ID: dnDZ9IqIMxOsLS9k9SWSbA_1790875369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8ED71865DA0; Thu,  1 Oct 2026 17:22:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C36751800348; Thu,  1 Oct 2026 17:22:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 07/11] docs/qapi-code-gen: add "Tagged sections" subsection
Date: Thu,  1 Oct 2026 13:22:34 -0400
Message-ID: <20261001172239.2825745-8-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The usefulness of naming and defining a "tagged section" is waning;
its only remaining use is to describe a shared syntax common to all
sections.

I think it's probably likely we want to omit this section entirely,
but here's our chance to discuss that.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 90488da7ffd..1897cde39cf 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1011,6 +1011,12 @@ line "Features:", like this::
   #
   # @feature: Description text
 
+
+.. _doc-tagged:
+
+Tagged sections
+^^^^^^^^^^^^^^^
+
 A tagged section begins with a paragraph that starts with one of the
 following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
 the start of a new section.
-- 
2.55.0



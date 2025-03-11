Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA5EC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrH-0003e7-Ev; Tue, 11 Mar 2025 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqa-0003FR-9n
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqA-0006YN-CA
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWkuDCPzbZFxRLHuq8fODnWk4KA/4K4c8PccPKnfj6E=;
 b=Ie56fKIVQIy8F3XK4Nhv3W9dtGiWgcO5ZvX1PW4Y9Hj126+o8iM2CZF99mjkjifP4t8vGz
 sregKK+GVltuwA3we+OK1OTd1aRPkpzaDHKSZ/IHfAb3nG6mPvJl8aEsfXUAwCLNl+UkrQ
 trHhHCmWi06GoQEIaCN+02N8UDnJgyw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-vAk-3CYoNlCr78h1TLdRLg-1; Tue,
 11 Mar 2025 07:32:03 -0400
X-MC-Unique: vAk-3CYoNlCr78h1TLdRLg-1
X-Mimecast-MFC-AGG-ID: vAk-3CYoNlCr78h1TLdRLg_1741692722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B0751800258
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21CA81828A96
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 919A121E60E0; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 55/61] docs/qapidoc: generate entries for undocumented members
Date: Tue, 11 Mar 2025 12:31:31 +0100
Message-ID: <20250311113137.1277125-56-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

Presently, we never have any empty text entries for members. The next
patch will explicitly generate such sections, so enable support for it
in advance.

The parser will generate placeholder sections to indicate undocumented
members, but it's the qapidoc generator that's responsible for deciding
what to do with that stub section.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-59-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Tweak the stub section text]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index a2d6f648a2..432fef04b0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -233,11 +233,12 @@ def visit_member(self, section: QAPIDoc.ArgSection) -> None:
         # TODO: features for members (documented at entity-level,
         # but sometimes defined per-member. Should we add such
         # information to member descriptions when we can?)
-        assert section.text and section.member
+        assert section.member
         self.generate_field(
             self.member_field_type,
             section.member,
-            section.text,
+            # TODO drop fallbacks when undocumented members are outlawed
+            section.text if section.text else "Not documented",
             section.info,
         )
 
-- 
2.48.1



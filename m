Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsh-0008Bx-1z; Tue, 11 Mar 2025 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxsE-0005oG-Ed
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxs6-0006v8-PS
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+Z+s4Wlk9e7DaBkaSE8WMgOr8VXb4ioRLRxiSoSozA=;
 b=HKOKIdcvQN1Jds3cbgXVCEy659/nLxzyAlN/GM8pW8cmF4AAdOBxIZnd/lXHwPEFv27wQj
 ov3KTL4AkE5ZCA3bHHW6LDdomjYVzfzP+k0W2vIkIzzbp1rppkFc+wcpJ5ulFoEVhIPKRw
 4758j/lPQZ/terjyxKFwrwFRqQUtDGo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-N_IogstGNsaulcYw-5nQlQ-1; Tue,
 11 Mar 2025 07:32:03 -0400
X-MC-Unique: N_IogstGNsaulcYw-5nQlQ-1
X-Mimecast-MFC-AGG-ID: N_IogstGNsaulcYw-5nQlQ_1741692722
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C32DB18001E2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 747CD19560AB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CA0B21E60E4; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 58/61] docs: enable qapidoc transmogrifier for QEMU QMP
 Reference
Date: Tue, 11 Mar 2025 12:31:34 +0100
Message-ID: <20250311113137.1277125-59-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We are not enabling the transmogrifier for QSD or QGA yet because we
don't (yet) have a way to create separate indices, and all of the
definitions will bleed together, which isn't so nice.

For now, QMP is better than nothing at all!

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-62-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qemu-qmp-ref.rst | 1 +
 qapi/qapi-schema.json         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index f94614a0b2..e95eeac45e 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -7,3 +7,4 @@ QEMU QMP Reference Manual
    :depth: 3
 
 .. qapi-doc:: qapi/qapi-schema.json
+   :transmogrify:
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 2877aff73d..4475e81cc3 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -5,6 +5,8 @@
 #
 # This document describes all commands currently supported by QMP.
 #
+# For locating a particular item, please see the `qapi-index`.
+#
 # Most of the time their usage is exactly the same as in the user
 # Monitor, this means that any other document which also describe
 # commands (the manpage, QEMU's manual, etc) can and should be
-- 
2.48.1



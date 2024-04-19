Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA96C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1T-0007XM-Cg; Fri, 19 Apr 2024 00:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1L-0007UR-S5
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1K-0004EU-BQ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgmQqAuYgu1dPNNMrsu0N1EFVraXVo1CGsaUaNPJUFU=;
 b=QceiGIaFfbm4bJ9/bEZWoMURW+2UtG8dgqKHDpwxyVkq/FSO403nXSn/gIQ5GYZ72f5q8/
 t6jkzTBBAxoCAW8rprYggREaBUeEQECOfkBjqv8PM7Lqkk8QnMydgULvZ3+9eml+G3Cqpq
 vhWla73AxNYYBXOLBNtsZptqaT0/Uec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-t_M2gGGUNQufvoPpb69O2g-1; Fri, 19 Apr 2024 00:38:37 -0400
X-MC-Unique: t_M2gGGUNQufvoPpb69O2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95FBD80021A;
 Fri, 19 Apr 2024 04:38:37 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC79A40357A7;
 Fri, 19 Apr 2024 04:38:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 21/27] docs/qapi-domain: RFC patch - add malformed field list
 entries
Date: Fri, 19 Apr 2024 00:38:09 -0400
Message-ID: <20240419043820.178731-22-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch demonstrates what happens when you mess up a field list
entry. The next patch adds a safeguard against this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index c68e2044890..5bb1c37a5ed 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -129,6 +129,10 @@ Explicit cross-referencing syntax for QAPI modules is available with
       argument values. It's very temperamental.
    :return SomeTypeName: An esoteric collection of mystical nonsense to
       both confound and delight.
+   :arg: this is malformed.
+   :memb: this is malformed and unrecognized.
+   :choice type name: This is unrecognized.
+   :errors FooError: Also malformed.
 
    Field lists can appear anywhere in the directive block, but any field
    list entries in the same list block that are recognized as special
-- 
2.44.0



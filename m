Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4B2C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaP-00039O-1Z; Fri, 22 Mar 2024 10:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaK-00032s-Hs
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaH-0003ZA-MW
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytSeH8hlqYpjxO7DFtDPWnfCb5fdbG+rduc/ElyoZs4=;
 b=EnWykzI3CMb8+/Xjc9F6alPzZIjI1LU5/npRVA2x7tWX9VyDd/gVE9iKlRidCUQXu7PKac
 +JTJG+CO5YP8qfHsJGD2cnjVsLUp6oEowfJyK5ABcHHn6hNdCc4EoHAI++jI4K1fx1QBaa
 3XO3dUqa4/eo40An9yZBuORV0cEUhpk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-NHGVYYaFPWOC9Fx0-cGBJg-1; Fri,
 22 Mar 2024 10:09:21 -0400
X-MC-Unique: NHGVYYaFPWOC9Fx0-cGBJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC273C0D86B;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFA331C060D2;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D761F21E5D2F; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 09/12] qapi: Don't repeat member type in its documentation text
Date: Fri, 22 Mar 2024 15:09:07 +0100
Message-ID: <20240322140910.328840-10-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Documentation generated for the arguments of MEMORY_FAILURE looks like

    "recipient": "MemoryFailureRecipient"
       recipient is defined as "MemoryFailureRecipient".

    "action": "MemoryFailureAction"
       action that has been taken.  action is defined as
       "MemoryFailureAction".

    "flags": "MemoryFailureFlags"
       flags for MemoryFailureAction.  action is defined as
       "MemoryFailureFlags".

The "action is defined as ..." are redundant.  Drop.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/run-state.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 789fc34559..ae084e13a0 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -568,11 +568,9 @@
 #
 # @recipient: recipient is defined as @MemoryFailureRecipient.
 #
-# @action: action that has been taken.  action is defined as
-#     @MemoryFailureAction.
+# @action: action that has been taken.
 #
-# @flags: flags for MemoryFailureAction.  action is defined as
-#     @MemoryFailureFlags.
+# @flags: flags for MemoryFailureAction.
 #
 # Since: 5.2
 #
-- 
2.44.0



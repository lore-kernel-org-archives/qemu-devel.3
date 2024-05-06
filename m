Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1948C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s437H-0000ge-0X; Mon, 06 May 2024 14:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s436F-0000UB-R5
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:30:10 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s436E-0006lX-5b
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=pKujwA3KPnHlFZcH0s4W2NUvMS0SIdrbZna3AKE57Nk=; b=r5+qv4xFoK3gmoE
 3G3hc3uZuMaEKMfp7yOwdZrtLr0tM3FdGiafbVSHyKBqAkRFD8ckkuA+PE+Wx3ab9etoSO4oBmJUw
 daFsTyS5114gqqF6u4Me/EldCPRU/fP9x3lXSFfrey41HwQ7eN3h2rSW/0WP24A8zX574vogZf56W
 48=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
Date: Mon,  6 May 2024 20:31:16 +0200
Message-ID: <20240506183117.32268-4-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-1-anjo@rev.ng>
References: <20240506183117.32268-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

gen_inst_init_args() is called for instructions using a predicate as an
rvalue. Upon first call, the list of arguments which might need
initialization init_list is freed to indicate that they have been
processed. For instructions without an rvalue predicate,
gen_inst_init_args() isn't called and init_list will never be freed.

Free init_list from free_instruction() if it hasn't already been freed.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/idef-parser/parser-helpers.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 95f2b43076..bae01c2bb8 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -2121,6 +2121,13 @@ void free_instruction(Context *c)
         g_string_free(g_array_index(c->inst.strings, GString*, i), TRUE);
     }
     g_array_free(c->inst.strings, TRUE);
+    /*
+     * Free list of arguments that might need initialization, if they haven't
+     * already been free'd.
+     */
+    if (c->inst.init_list) {
+        g_array_free(c->inst.init_list, TRUE);
+    }
     /* Free INAME token value */
     g_string_free(c->inst.name, TRUE);
     /* Free variables and registers */
-- 
2.44.0



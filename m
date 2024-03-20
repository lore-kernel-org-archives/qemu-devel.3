Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCABC54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 02:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmlJV-0005RG-Gn; Tue, 19 Mar 2024 22:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rmlJU-0005R5-HZ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:04:20 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rmlJS-0006fn-It
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1710900258; x=1742436258;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vyG/HEl8aYHT4LtGcSxGyZuwg7vJ11LLCg+TgsHPV88=;
 b=W018HgpKvOLhfvxzzG0t7w3yGw6ZO0ODSeN+Q8WeJfGPcoP9e+pKV1k1
 CaWVbc8iRAAmj+JNn/oRi1upD7iFXQ6+cDir5Gx82tavkcwDuJiZwiP+g
 hj2mEFUCCVGJ8ExWqPy+En9e2JAEmX8WeQytc9ShvF3P/2vN2eq8c6svS
 Tau7UILJONqjlTSj6kNQOhtiTT6+mDIGnHI437H2VUW2Ph8u7dxKWrxvc
 AK/6Grq0tBpqJJvWHD94a0cvPFpgxbw4mBZKzZnnRmdz4PTyqX9Dl9P70
 t+zSd1hevQ/TRSsmgwW0Ke22xPkrv92SUY+JdT4nz1J/Fzr6ozWpl4GgS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="132128569"
X-IronPort-AV: E=Sophos;i="6.07,138,1708354800"; d="scan'208";a="132128569"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 11:04:11 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C4AA5AF9A
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 11:04:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C1B59BF4A7
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 11:04:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 649D721FC42
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 11:04:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A7E441A006A;
 Wed, 20 Mar 2024 10:04:07 +0800 (CST)
To: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] contrib/plugins/execlog: Fix compiler warning
Date: Tue, 19 Mar 2024 22:01:15 -0400
Message-Id: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28262.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28262.004
X-TMASE-Result: 10--10.242300-10.000000
X-TMASE-MatchedRID: N/ZbbLCcPKAPmP3FESo1jx1kSRHxj+Z5C//1TMV5chP1xrH5kKK/riC2
 FZ19GZhejDVMw6TJvuFqZQlTWBYkGK7NRB06WtQS9Ib/6w+1lWQ81ck8U80WlhzTkVRa1gtO3UT
 KRPNMe+si+t+0AiFaYvL3NxFKQpq1T12Hc9FhVjUK3Ma88LL+bhZSD+Gbjz3IGxDxAG8HwlajxY
 yRBa/qJUl4W8WVUOR/joczmuoPCq2CC+YDrt+JtuLo5lYlQRrYaQlFQo703sNkbtsHuvfDlS0Q5
 BNGaY3x
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

1. The g_pattern_match_string() is deprecated when glib2 version >= 2.70.
   Use g_pattern_spec_match_string() instead to avoid this problem.

2. The type of second parameter in g_ptr_array_add() is
   'gpointer' {aka 'void *'}, but the type of reg->name is 'const char*'.
   Cast the type of reg->name to 'gpointer' to avoid this problem.

compiler warning message:
/root/qemu/contrib/plugins/execlog.c:330:17: warning: ‘g_pattern_match_string’
is deprecated: Use 'g_pattern_spec_match_string'
instead [-Wdeprecated-declarations]
  330 |                 if (g_pattern_match_string(pat, rd->name) ||
      |                 ^~
In file included from /usr/include/glib-2.0/glib.h:67,
                 from /root/qemu/contrib/plugins/execlog.c:9:
/usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
   57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
      |               ^~~~~~~~~~~~~~~~~~~~~~
/root/qemu/contrib/plugins/execlog.c:331:21: warning: ‘g_pattern_match_string’
is deprecated: Use 'g_pattern_spec_match_string'
instead [-Wdeprecated-declarations]
  331 |                     g_pattern_match_string(pat, rd_lower)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
   57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
      |               ^~~~~~~~~~~~~~~~~~~~~~
/root/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 of
‘g_ptr_array_add’ discards ‘const’ qualifier from pointer target type
[-Wdiscarded-qualifiers]
  339 |                             g_ptr_array_add(all_reg_names, reg->name);
      |                                                            ~~~^~~~~~
In file included from /usr/include/glib-2.0/glib.h:33:
/usr/include/glib-2.0/glib/garray.h:198:62: note: expected
‘gpointer’ {aka ‘void *’} but argument is of type ‘const char *’
  198 |                                            gpointer          data);
      |                                            ~~~~~~~~~~~~~~~~~~^~~~

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 contrib/plugins/execlog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index a1dfd59ab7..41f6774116 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -327,8 +327,13 @@ static GPtrArray *registers_init(int vcpu_index)
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
                 g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
+#if GLIB_VERSION_MAX_ALLOWED < G_ENCODE_VERSION(2, 70)
                 if (g_pattern_match_string(pat, rd->name) ||
                     g_pattern_match_string(pat, rd_lower)) {
+#else
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
+#endif
                     Register *reg = init_vcpu_register(rd);
                     g_ptr_array_add(registers, reg);
 
@@ -336,7 +341,7 @@ static GPtrArray *registers_init(int vcpu_index)
                     if (disas_assist) {
                         g_mutex_lock(&add_reg_name_lock);
                         if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
-                            g_ptr_array_add(all_reg_names, reg->name);
+                            g_ptr_array_add(all_reg_names, (gpointer)reg->name);
                         }
                         g_mutex_unlock(&add_reg_name_lock);
                     }
-- 
2.37.3



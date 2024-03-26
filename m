Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A82CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 01:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1row0R-0002jw-1b; Mon, 25 Mar 2024 21:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1row0Q-0002jX-0r
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 21:53:38 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1row0L-0005DA-3X
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 21:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711418014; x=1742954014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vwq5HyFpMyOPE2zYdXJlQIfUdeX97KXdc3JI4IcbTlA=;
 b=hsom108gyk2VDd7RpKZuGgItZPs312XEuhqaxUqynrSGOrPWFbpURKwS
 AH2EwFnUDO2TBdafulFHsnbcHqUJpyLHyUIwkBScy9b3D+c8KnFZpXtEM
 Ahd2JnV1YvXCXNi/pKO81uU4j0Hw/9iz6/GWLd8uq70oyrDAcXqufQcLG
 kmt4rt5ig4kw62eDHkERsOCenQtnok0gh/D+5mhgfQuhcrHp9bSDvjmYZ
 qRvq/VOf0r9t+32RJrc/o0yvMhkbF3XX9wt5Mb3MCcFF4HqPc5CKpwkqd
 4A+n3LcGLflL7Sx0xXAT38HFITYN9DHgi5LzVdyiabfcaw72xeAiWQBv7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="153325456"
X-IronPort-AV: E=Sophos;i="6.07,154,1708354800"; d="scan'208";a="153325456"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 10:53:12 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 30E1D10A32C
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:53:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 73F30CFBB0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:53:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0864A200932DD
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:53:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3CD111A006A;
 Tue, 26 Mar 2024 09:53:07 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org,
 yaoxt.fnst@fujitsu.com
Subject: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Date: Mon, 25 Mar 2024 21:52:57 -0400
Message-Id: <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28274.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28274.003
X-TMASE-Result: 10--8.174100-10.000000
X-TMASE-MatchedRID: F68ycsQ3IOkPmP3FESo1jx1kSRHxj+Z5C//1TMV5chP1xrH5kKK/riC2
 FZ19GZhejDVMw6TJvuFqZQlTWBYkGK7NRB06WtQS9Ib/6w+1lWQ81ck8U80WlhzTkVRa1gtO6L4
 H3GWBX20pdBmkg8Rmd+8j2/Qpcz4879SLQXyG7tBO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDOxZ
 dIoBn2VHR9j1OrMyNz28+Pt/hXAjaXC3sMAGu+nwrcxrzwsv5ufrTt+hmA5bIbEPEAbwfCVqPFj
 JEFr+olSXhbxZVQ5H+OhzOa6g8Krc/jI6nJBa31ghpzz5E96ZMmOOKUQG2GcgWRrOugeznPB3kf
 Hctnmlw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 contrib/plugins/execlog.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index a1dfd59ab7..fab18113d4 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -311,6 +311,24 @@ static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
     return reg;
 }
 
+/*
+ * g_pattern_match_string has been deprecated in Glib since 2.70 and
+ * will complain about it if you try to use it. Fortunately the
+ * signature of both functions is the same making it easy to work
+ * around.
+ */
+static inline
+gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
+                                          const gchar *string)
+{
+#if GLIB_CHECK_VERSION(2, 70, 0)
+    return g_pattern_spec_match_string(pspec, string);
+#else
+    return g_pattern_match_string(pspec, string);
+#endif
+};
+#define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu(p, s)
+
 static GPtrArray *registers_init(int vcpu_index)
 {
     g_autoptr(GPtrArray) registers = g_ptr_array_new();
@@ -327,8 +345,8 @@ static GPtrArray *registers_init(int vcpu_index)
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
                 g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
-                if (g_pattern_match_string(pat, rd->name) ||
-                    g_pattern_match_string(pat, rd_lower)) {
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
                     Register *reg = init_vcpu_register(rd);
                     g_ptr_array_add(registers, reg);
 
@@ -336,7 +354,7 @@ static GPtrArray *registers_init(int vcpu_index)
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



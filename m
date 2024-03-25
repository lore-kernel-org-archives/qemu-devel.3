Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E4CC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodUJ-0002sq-Hl; Mon, 25 Mar 2024 02:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rodUH-0002sY-M8
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:07:13 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rodUF-0005sM-Da
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711346831; x=1742882831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=io0vjKt3DUX3bbLEAz4YJnl2lXVcbVGBOPReVWMf8Fs=;
 b=B7DVTay70Uk1AswV5Yv+8EBexPoJQDmImX9aRiOfMcjmbEUZ6N5JTbar
 NTkIO5Jh5wWVjtJkdeECn9CoRl+XSuYWFJkq65sD1O0msnHtP7LDAIvlj
 lm3m0s+m80Px9Wm98np5yRyXyP+Ksv0U2LR3syRCT5sl/3Gk+O69D8b5V
 AsqGd3/PXclAyIXkWw+C6J1QpBraM2zXQ51ZQVsm3gO/x3CNnMTzynjWP
 18tblRk7KfAaNClkZ7T77rL2qV+cbP3hFr8f66CzFbeoUIaj3Ao3GsHLa
 wpZGo9W+rfVe9YCcpWAVTxtNjp2cKGXwUDf9OlamY9XtJsiE96s2VyGmI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="141699592"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; d="scan'208";a="141699592"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:07:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EC82ED4804
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:07:05 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 202F5D6222
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:07:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DB6820097CCA
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 15:07:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D9F961A006C;
 Mon, 25 Mar 2024 14:07:03 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org,
 yaoxt.fnst@fujitsu.com
Subject: [PATCH v2] contrib/plugins/execlog: Fix compiler warning
Date: Mon, 25 Mar 2024 02:06:57 -0400
Message-Id: <20240325060657.3934-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28272.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28272.005
X-TMASE-Result: 10--4.760100-10.000000
X-TMASE-MatchedRID: F/q6px2NM/kPmP3FESo1jx1kSRHxj+Z5C//1TMV5chP1xrH5kKK/riC2
 FZ19GZhejDVMw6TJvuFqZQlTWBYkGK7NRB06WtQS9Ib/6w+1lWQ81ck8U80WlhzTkVRa1gtO6L4
 H3GWBX20pdBmkg8Rmd+8j2/Qpcz4879SLQXyG7tBO5y1KmK5bJRSLgSFq3Tnj1VNlojpO42hjFr
 zDFNuGe2Nj1vYGtvPcRHrEsMXfwkOXBXaJoB9JZ4MbH85DUZXyw5ug89ZVKMv6C0ePs7A07aLm7
 9W+wVodjVp6BPyhKWtOLFx/IKragV3nIPV6Di2N1e7ni4kyYe8+HfiDG3cIsMOZXEfpBeOUBm+h
 Pw53yV+zq3M/fI/zHWU31p31FoMysiVHQI/7266+6QVxiAZsda5sicnpScShiWAbBu8T+Gs=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
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
 contrib/plugins/execlog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index a1dfd59ab7..09654910ee 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -327,8 +327,13 @@ static GPtrArray *registers_init(int vcpu_index)
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
                 g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
+#if GLIB_CHECK_VERSION(2, 70, 0)
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
+#else
                 if (g_pattern_match_string(pat, rd->name) ||
                     g_pattern_match_string(pat, rd_lower)) {
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52C4C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaBg-0003Qj-Bz; Thu, 01 Feb 2024 11:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB5-0002wD-Dn
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:39 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAu-0002Tr-LZ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=mMqmzYHdP9y/z29knSdyyl/j1smIAiKPsHboaiDoM8A=; b=NF+mzlBi2DUXjLUWt2oYxQ5rNg
 fth1fWhQUWyxt2PZmJuQ1ufN6827/piC0i8d/6HReljxKQVkfpxzPcctqdUHGK+Jwz2F0gHyiHn4k
 kdSqnWLIEX+Dz9ps2/tBxmu7y0ZhAbhIyBCrDAJWDnwXPx6UdclCe3kWaykmnMnsWGcua1jomAykM
 JX9f2eRCPG+WYcJniqroBmwoE1hUIXO4jvAYFGfwQPrzA06pZDhoxyIYLudDObUSFAMQJO0MBcnS1
 zgtvsmz+KsR9FGlJmyTsntPapzQCG0dnmuMUkYs3hq8rAczC6H8V7OrCoviQt0tcjv4GKgJqCDwqQ
 Ijwf66rQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdt-3p4J for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IP6-3ppq for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/47] net: make nb_nics and nd_table[] static in net/net.c
Date: Thu,  1 Feb 2024 16:44:12 +0000
Message-ID: <20240201164412.785520-48-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Also remove the stale declaration of host_net_devices; the actual
definition was removed long ago in commit 7cc28cb06104 ("net: Remove
the deprecated 'host_net_add' and 'host_net_remove' HMP commands")

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/net/net.h | 4 ----
 net/net.c         | 3 +++
 system/globals.c  | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 588ee55f28..b1f9b35fcc 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -301,10 +301,6 @@ struct NICInfo {
     int nvectors;
 };
 
-extern int nb_nics;
-extern NICInfo nd_table[MAX_NICS];
-extern const char *host_net_devices[];
-
 /* from net.c */
 extern NetClientStateList net_clients;
 bool netdev_is_modern(const char *optstr);
diff --git a/net/net.c b/net/net.c
index d705e9b0fd..a2f0c828bb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -77,6 +77,9 @@ static NetdevQueue nd_queue = QSIMPLEQ_HEAD_INITIALIZER(nd_queue);
 
 static GHashTable *nic_model_help;
 
+static int nb_nics;
+static NICInfo nd_table[MAX_NICS];
+
 /***********************************************************/
 /* network device redirectors */
 
diff --git a/system/globals.c b/system/globals.c
index e83b5428d1..b6d4e72530 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -36,8 +36,6 @@ int display_opengl;
 const char* keyboard_layout;
 bool enable_mlock;
 bool enable_cpu_pm;
-int nb_nics;
-NICInfo nd_table[MAX_NICS];
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
-- 
2.43.0



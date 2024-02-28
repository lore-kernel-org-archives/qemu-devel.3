Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3317C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQ8q-0003iD-Ro; Wed, 28 Feb 2024 15:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8m-0003gc-ER
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:57 -0500
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8j-0008Gv-Cv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:56 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A4D58360E47
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:50 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id C5FC536006F
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:49 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709150570; a=rsa-sha256;
 cv=pass;
 b=6jyYEiBqCbROTj+OuhyRtTU6oqDnqXpP+z6Xk2ky6YvPH4ouicAKyGECbuP3YI3tQ+Dkcd
 mZTubPvLHcGWXsawWQqHh1ThxpO/oSZFqV0XKv2cKKBZWnvYHXcwPKdUlNV7sSEs+9UfEP
 /Ba8mfr+o621okYqpyjNJHfVjexkYBf2GsFYpwMOPnPEaA1bv52v6q307VTWZ7DPzazHgc
 mPItbiiF8P4dCK6Z2h69sGHrhZj0xzvLV7CPEe5d7dBTUQes/1PW02xjxM30ReXQdeBnDB
 1ixrp5QGC3RGQ3TJyXD8mjiL7WbtqCOYsJMPHfnALkSm+5F4cAtIRkzGuYxk3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709150570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=MEh3TElPIn4Ux6YSLZmqkWTrrchqIem6Xp0TObmY+Wc=;
 b=2SStYwK6/WS0T1PW2iszNG4Su8Yi/oyQp7L0fxDubkBMDBUF9xohX4QYhhC7DLtqibDC2o
 GQTHu76mHkA2ltvp/mmg0mam3JVV2F8vAfUTASblH1qVkXL1XGcVE0zaZxaPM2aTk9nype
 sU11DWMF2/ZJUcBCHkikwNu+dxLeIFcxjjHE9Z/cs5ggo56CiLFVxRPxtKVYy91KUDzO6E
 NvBZOzqInpigHNpUc37C4wln5w0h2r2HKU3LskjiymvyAPLcDQbSpVh4GRP5BmQZImksS7
 gIXTRem1oGFojb3NW9MG+UuPsw1ySf/548QaNZ1ENhZwJYo2ejGoDsv9q1QBGQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-zdc5v;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Society-Shade: 19c2208f583ba17d_1709150570386_721209793
X-MC-Loop-Signature: 1709150570386:2155191330
X-MC-Ingress-Time: 1709150570386
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Wed, 28 Feb 2024 20:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709150544; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=fzGB4Anz9JoTzxlrOf4IftnZyGcSnZNThKGzVQ20j77hINHF0uxODqX4PZCrVNNgG0G+CH3WdNbEb
 XXjWnZ99dA7xqOEc1+3dGKWA5kTn0zlYCgS6s0x0BNhjPUd5Pb+7MpY9yD8U33pxDHkJjadd0yRruP
 SPvWLUB6MEIaIW8WXaAXVDDPgM1P1cRBovNrmbJUeTroWfJnNbz48i5UHjP/8EvbsGsjw+tom00Zcs
 u5sCkzLpxGxkVGDckpWV9ISpQCqnHqlKkKdv1rSfuONaJlCxj0ATzh1w3bxvsPTtiEDl0U+oYmurqh
 Xu97RXdbfFz3kamb3YGH1sXjZJMR9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=MEh3TElPIn4Ux6YSLZmqkWTrrchqIem6Xp0TObmY+Wc=;
 b=e8Rfvdo+Se4HRT0r711O6Z83n/RCeDOo9Y4dppOdxpzzNABbFneotC1VzjsRMZD8weVkXa9F9Ft5h
 hbrcDkYPonasi60J6DnqZ/ZdcftGajA3zhdMH62rTdHCo3V+w/1uJkEyHts/th4kOUOzDTUpelfy9Q
 AjS8t3y9IFLFBuDi2oc6yl9iJf6p4Dq2Xmau15NK9gpOCb32T+k917lbOj9g0Grq9nIWJD3Tkw84/S
 eYUMn/sG5VOo4UxXrRQ1illHOoSSZ/+gMDl/fQ53STt0nTJSRrH4AllsVF1HshTzhTe3A/A1vjEu+u
 sl66tiTiE1Uh+Hb5249j0MhJYnv+zAA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=dMZVZnn1; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=MEh3TElPIn4Ux6YSLZmqkWTrrchqIem6Xp0TObmY+Wc=;
 b=q8/K9qjFdZ7SxO+xP+TU0IJFSkZ73iawiwbfIa5Ex9U/c3NXEyWnaw9IJMTzkRu0xxsZmRrv/YhEo
 YYlXHiuPJ0iwk2t1GNCMVugElQm5xZtWGQZFPozFksL94PfL2OCb/4Vy7Bs5ZCeLcNdXeOgUmBHhgC
 ELf5GyB3mwvZPDEI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=MEh3TElPIn4Ux6YSLZmqkWTrrchqIem6Xp0TObmY+Wc=;
 b=RSfFx32DfvB767mhdVgosteAzBqnHNASl1oUVr/Uf6A8mNxbXxvXF3qms3ED391ryU5X7o/uygfu9
 SqveK9nscOwgQk3cuQqNgSSq8yX3tJkYNTsPq41gOwLea+o9PbZgqwRJoV2aWQTQIPAROmNR1biPXd
 j1kui34yxpL6eJQrI5wIFCV8BPVaMQPdW5V54AdrKszoi/CAOlB8GADoXE95DkiJBsfZb4N5GpkANS
 prbl2VMvD5PamMwJh9jQC8G2KcA5UM3bMNc/i85BXkPUszspC3OhnYYusWTDG/9SsSI8T82AX6qsth
 PFuC/LoOU37DZxEvUELj5uzm8iLU3vQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 4772f50e-d674-11ee-af93-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 4772f50e-d674-11ee-af93-eda7e384987e;
 Wed, 28 Feb 2024 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MEh3TElPIn4Ux6YSLZmqkWTrrchqIem6Xp0TObmY+Wc=; b=dMZVZnn1KZWoFLgxzFi1jYN0Zh
 ulizzZ99CdwcHDAqRwf7OtXdliT28zVHUmNQBuXORwyku6eywkKKW3axetPP1wToGTgatn3xAgMe8
 2ua7ihfj4/r5aR2n3sw4eQzxDZG+gLgpobiSgoBIi9KQBxdXdGN66OE+ZCLys0uKV9K6oUi9BaqP8
 SsR3hPOegKTwqL3ICjL017xX0gQE64mjdIl7YwO8lwcMR+7Vy0ZWtXadOhqgiUVrK0KBfzlgI8vFL
 jLd54rvPEK5XPj9qmdT6sO+Q4kLf4qhYbS73oRp0oJPnlxHEbTDPN0VLQTwhNFZ4kBHrkIZOQV265
 Q8Milixg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQ8Z-000DfK-1Z;
 Wed, 28 Feb 2024 21:02:43 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 4/4] plugins/execlog: add address range matching
Date: Wed, 28 Feb 2024 21:02:11 +0100
Message-ID: <20240228200211.1512816-5-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228200211.1512816-1-svens@stackframe.org>
References: <20240228200211.1512816-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Allow to match memory ranges with the address matches. This
allows to give a range of adresses like '-dfilter=0-0x400'
which would only log memory accesses between 0 and 400.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 65 +++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 33fef9bfc6..a505f98be8 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -30,6 +30,11 @@ struct execlog_ctx {
     bool log;
 };
 
+struct address_match {
+    uint64_t low;
+    uint64_t high;
+};
+
 /*
  * Expand last_exec array.
  *
@@ -47,17 +52,18 @@ static void expand_last_exec(int cpu_index)
     g_rw_lock_writer_unlock(&expand_array_lock);
 }
 
-static bool match_vaddr(struct execlog_ctx *ctx, uint64_t vaddr)
+static bool match_address_range(GArray *match, uint64_t vaddr)
 {
-    for (int i = 0; i < dmatches->len; i++) {
-        uint64_t v = g_array_index(dmatches, uint64_t, i);
-        if (v == vaddr) {
-            ctx->log = true;
+    for (int i = 0; i < match->len; i++) {
+        struct address_match *m =
+            g_array_index(match, struct address_match *, i);
+        if (vaddr >= m->low && vaddr <= m->high) {
             return true;
         }
     }
     return false;
 }
+
 /**
  * Add memory read or write information to current instruction log
  */
@@ -70,9 +76,10 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
     struct execlog_ctx *ctx = g_ptr_array_index(last_exec, cpu_index);
     g_rw_lock_reader_unlock(&expand_array_lock);
 
-    if (dmatches && !match_vaddr(ctx, vaddr)) {
+    if (dmatches && !match_address_range(dmatches, vaddr)) {
         return;
     }
+    ctx->log = true;
     GString *s = ctx->s;
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
@@ -166,8 +173,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         if (skip && amatches) {
             int j;
             for (j = 0; j < amatches->len && skip; j++) {
-                uint64_t v = g_array_index(amatches, uint64_t, j);
-                if (v == insn_vaddr) {
+                if (match_address_range(amatches, insn_vaddr)) {
                     skip = false;
                 }
             }
@@ -197,6 +203,16 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
+static void free_matches(GArray *matches)
+{
+    if (!matches) {
+        return;
+    }
+
+    for (int i = 0; i < matches->len; i++) {
+        g_free(g_array_index(matches, struct address_match *, i));
+    }
+}
 /**
  * On plugin exit, print last instruction in cache
  */
@@ -212,6 +228,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
             qemu_plugin_outs("\n");
         }
     }
+
+    free_matches(amatches);
+    free_matches(dmatches);
 }
 
 /* Add a match to the array of matches */
@@ -223,14 +242,34 @@ static void parse_insn_match(char *match)
     g_ptr_array_add(imatches, match);
 }
 
-static void parse_vaddr_match(GArray **matches, char *match)
+static void parse_vaddr_match(GArray **matches, char *token)
 {
-    uint64_t v = g_ascii_strtoull(match, NULL, 16);
+    uint64_t low, high;
+    gchar *endp;
 
-    if (!matches) {
-        *matches = g_array_new(false, true, sizeof(uint64_t));
+    low = g_ascii_strtoull(token, &endp, 16);
+    if (endp == token) {
+        fprintf(stderr, "Invalid address(range) specified: %s\n", token);
+        return;
+    }
+
+    if (*endp != '-') {
+        high = low;
+    } else {
+        high = g_ascii_strtoull(endp + 1, &endp, 16);
+        if (endp == token) {
+            fprintf(stderr, "Invalid address(range) specified: %s\n", token);
+            return;
+        }
+    }
+
+    if (!*matches) {
+        *matches = g_array_new(false, true, sizeof(struct address_match));
     }
-    g_array_append_val(*matches, v);
+    struct address_match *match = g_new(struct address_match, 1);
+    match->low = low;
+    match->high = high;
+    g_array_append_val(*matches, match);
 }
 
 /**
-- 
2.43.2



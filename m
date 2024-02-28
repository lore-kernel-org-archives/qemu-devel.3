Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C291C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQ8r-0003iK-RY; Wed, 28 Feb 2024 15:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8m-0003gd-N0
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:57 -0500
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8k-0008Hh-Tu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:56 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 176CB14264D
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:52 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6719514352C
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:51 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709150571; a=rsa-sha256;
 cv=pass;
 b=84cXRFQ6+KiKKER74m15YT3I4v6C69rf59SGMGvdhREao3X0QITo1suHI9jrbqYpVDR3F/
 wMup0xbRd4zXKZwrC0Jg4wZscNL7BXBUPQBHgDQX9a7+2JtRlOwpTJ+g58ApH5T/Vi19br
 X7d3ffe3+DXrEf8PSw2OjEbi4iU/JsPMhTd6PXHfKtrxWcyLZdc6q/3aoLBcMdm3HSqH6m
 mkRy6AnE9A9F1dntb5WkiPAvx2qSbjbu9xpj3tkUutfvtl/OkZjmuB1xMso8YjwvI4BnhY
 bqoxGfP4+bjVeMPuMkhHf4mcWNf+gdgaUQxAhKI/yunVBXnTxAIsQbaFXdgSWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709150571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=oos4cikuJWmbJP4CgPy9Uasl/Cfj6YBGD9U5hBoHh6Y=;
 b=orCNVm2v065g91v0uVMZiZ/O6oZKxAzxY4TvZFewr2uiDmuW0nFqyiDrJHeDArcbm/EG8f
 EVfcsUsuF73TMEQ74E0D4XrrkCB0C9xMbimewW5NpHGAazETtSVNFBtRqVXiOV6X3FpdIx
 0v7oh7KhclA7n9JDbKJZHFuliO5OvutwNrsRXWn6a1ATi1bjMpqgiyylKS4R/8XHk687oN
 X2cQyhRJIR5slf6D9lYEd220ZfiYqVtwzpRWelTjzLKr9g5dF4bEOibiEv4V04Xj6+4SsR
 dqRLZOxWJD2n71H/p1wl/dwEcleo5BdvnFhi8Tt6kGEr85981U6KntSe15/HWQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-94f4c;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Average-Shelf: 07df89a1145b3d0a_1709150571938_51297580
X-MC-Loop-Signature: 1709150571938:3905586250
X-MC-Ingress-Time: 1709150571938
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.58 (trex/6.9.2); Wed, 28 Feb 2024 20:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709150544; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=MTnrygKpDwXUTygrQ1UC3gD/zntVSHJCimnbf7/br2mhr74VvO7LPHdoBJXIdG7gjV1G5bH0ehM5G
 k4CaizE7s+ihgq56XeJB1Hh/D5uoq5yYAYa9PFWqNAE/jPpg5tny9h9aEmVd+zkuuAKvIxKNDEdPdW
 w4ysglHSsmnynFMBK0wX+Kbh6eyCcTHeyKqrVeqeBZaLT/QvFWFdj4cii6eoh6LsYVEfXh3dLbwFsr
 IK0fmcBiN66jIsXqrsHcP/3bvU7yxsQjfDgvVrUg/v9x3XKpG/24dAqJse8+jOWwBd4FD9/vFCjk5+
 Iupz6AMUafZjGQpBoc0yWJBwTZPgQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=oos4cikuJWmbJP4CgPy9Uasl/Cfj6YBGD9U5hBoHh6Y=;
 b=kSstnUcEprS6uS5QeiFbZxPnzULftVNpOz2pbRmUcyWioU31LUSLOGX66Vnt747ngOfk2iTETa+oH
 Qi6Dyd/oPA/j6X0V/Y9s3SQV47BM6G2LJqMIqe5t2PA+ujSG960/ZKbn7BQ8cUrziR/wzRH+JmzvZ4
 NpO1Z4dVSJ2OcqzC6rlx4lgBViHLO2/FIz1VgPND3pQGAvSZTKK5cffFEbrSmEkRy32DK0XPQ0dG/r
 lpmcSgZBcRzw3lBaBFiGNODXzMbMvx4vRHaO1RzsLSvwuLYg9yPi76xjfBPvg/fK3+diyVTrKHplB+
 XEgZ6+w53BEugBMZfFJcvC4gm6zXwhA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=YIvKZqI4; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=oos4cikuJWmbJP4CgPy9Uasl/Cfj6YBGD9U5hBoHh6Y=;
 b=R8egNYkjXRSixhpy65CueWb3TGqgV5DSvY3RRQZr8S0CqmT6C7hGyJGfhH18hhha9KoevD/sxjnXi
 ywOUGK6ieK0Ws+GPWx2kEyLRblDacGihLlI/XoimIO97kzvCyEOagaZXcA1IjuAxa7OtNev40RBMKG
 UAzOx4kEeBbZpzkY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=oos4cikuJWmbJP4CgPy9Uasl/Cfj6YBGD9U5hBoHh6Y=;
 b=uSS6BilSElGUfBqBGI2zOZJ4bshCNLmafSc/Q9CsAqnAjsemsUFRlH4kd5D+IrrA6TjHsSmlcvk+e
 RTFtivZ6YVa8dIKQbuWoYqg46/LsszHxgK3C/FroAGZT+M//VayWoV/Jp0g3Ny8j/q5AYvH98fCJHf
 8/LNtAAnfKatDopC7SrrLq69llYtbs3EP+JvHokuWoA/WwAvttweyedwgQa24nZ1Kygw8QEL6O0NrW
 9Ab7y6ArtrUPr3eTQde3AgoHSik7fBBBMBqZix5nRwFR3cUxMauMhSVWXdEbx2/PUPNZ3s2MH8HgEv
 sZHwemWIRul7UDT6LiNErGXobvhr9RA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 470be23c-d674-11ee-af93-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 470be23c-d674-11ee-af93-eda7e384987e;
 Wed, 28 Feb 2024 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oos4cikuJWmbJP4CgPy9Uasl/Cfj6YBGD9U5hBoHh6Y=; b=YIvKZqI4KRliYBL1t6tLA80cje
 K+6YfZgFbA8wkWOxKiyN3q5LFkWEyLiINSmBCtUyQ85pkw0GgsW+7wbJ3vzDboAh8WRmscJ8RUr0p
 Sd7JsqOXLqEAWB3bUGwDemlplzmlvjBKYcW/dtuOyWe8lxYdYAKAGegUXoPktzQ3QdIzHhM8/jd8i
 OWZ1SoCbuBg1Hh3fwFu+Ufdg2YDNOM5RM8r9lqWmPtN5XyrfEUVKyLpZ8mOQq6ZuhaYujeRTj71JY
 6UgAuXy0g9uSzO3IrMUQV6RTKgSbZXeasmJa2XAdw9N4f0X6Z6+tiAi4bMd2KDzcrY1aX9mfMZscO
 IkUZ8tZA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQ8Y-000DfK-2V;
 Wed, 28 Feb 2024 21:02:42 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/4] plugins/execlog: add data address match
Date: Wed, 28 Feb 2024 21:02:10 +0100
Message-ID: <20240228200211.1512816-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228200211.1512816-1-svens@stackframe.org>
References: <20240228200211.1512816-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a match similar to the afilter address match, but for data
addresses. When an address is specified with '-dfilter=0x12345'
only load/stores to/from address 0x12345 are printed. All other
instructions are hidden.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index b4b5ba113c..33fef9bfc6 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -23,9 +23,11 @@ static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
 static GArray *amatches;
+static GArray *dmatches;
 
 struct execlog_ctx {
     GString *s;
+    bool log;
 };
 
 /*
@@ -45,6 +47,17 @@ static void expand_last_exec(int cpu_index)
     g_rw_lock_writer_unlock(&expand_array_lock);
 }
 
+static bool match_vaddr(struct execlog_ctx *ctx, uint64_t vaddr)
+{
+    for (int i = 0; i < dmatches->len; i++) {
+        uint64_t v = g_array_index(dmatches, uint64_t, i);
+        if (v == vaddr) {
+            ctx->log = true;
+            return true;
+        }
+    }
+    return false;
+}
 /**
  * Add memory read or write information to current instruction log
  */
@@ -57,6 +70,9 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
     struct execlog_ctx *ctx = g_ptr_array_index(last_exec, cpu_index);
     g_rw_lock_reader_unlock(&expand_array_lock);
 
+    if (dmatches && !match_vaddr(ctx, vaddr)) {
+        return;
+    }
     GString *s = ctx->s;
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
@@ -93,7 +109,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     GString *s = ctx->s;
 
     /* Print previous instruction in cache */
-    if (s->len) {
+    if (ctx->log && s->len) {
         qemu_plugin_outs(s->str);
         qemu_plugin_outs("\n");
     }
@@ -102,6 +118,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     /* vcpu_mem will add memory access information to last_exec */
     g_string_printf(s, "%u, ", cpu_index);
     g_string_append(s, (char *)udata);
+    ctx->log = dmatches ? false : true;
 }
 
 /**
@@ -190,7 +207,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     for (i = 0; i < last_exec->len; i++) {
         struct execlog_ctx *ctx = g_ptr_array_index(last_exec, i);
         GString *s = ctx->s;
-        if (s->str) {
+        if (ctx->log && s->str) {
             qemu_plugin_outs(s->str);
             qemu_plugin_outs("\n");
         }
@@ -240,6 +257,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
             parse_vaddr_match(&amatches, tokens[1]);
+        } else if (g_strcmp0(tokens[0], "dfilter") == 0) {
+            parse_vaddr_match(&dmatches, tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.43.2



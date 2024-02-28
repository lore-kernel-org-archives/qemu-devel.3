Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E938CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQ8p-0003h6-3W; Wed, 28 Feb 2024 15:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8l-0003gX-DS
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:56 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8j-0008GI-BT
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:55 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 638BFC18EF
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:48 +0000 (UTC)
Received: from outbound5e.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B6F72C19BB
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:47 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709150568; a=rsa-sha256;
 cv=pass;
 b=QZsbbADYdaayPmW80/Agz3mDk1Fuu03ICCfsRdn+FeCOAaNjaUVdcVaXHZZ63RNuuS90R+
 L7DhYUwVxUcUgQiRdozkyHZejLsN5nooUf7RkGlXJCR/bOjvqOFXHrH1ZRUVS+dddUHVt/
 u/crOCkNKMwM3fWbuedG5aE5mGmAPDcW+jP8oQGQLWDS2nFOOeHfLfg8t7IYA0Y8J3Yp5T
 3Uj7bxJjQcRUzCdYl89rEBgqexND0SjsiFB6rZiX011Vnei48wdX3jPWCObDJnQCJllLCu
 1+EG0jbMbPYE2bkYggIEuGbh08qXJKnaLRjKqhCzuZ0Bon71mjZj4+sAZIp7wA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709150568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=zzOEiQj7obGsHCQd9xyo6jp7AhLHL7sbZGnf3tSSs7Q=;
 b=1wOh+PBlOTUqPQgSwsC/E7vsn0qWRvBaUi9MaJ2i7bLUS+Dfdx9F26ycuPMCRv1HcXCmWg
 0LpH5lqLUrxQwJ6p/xhVhm6R8dkby3+rqhUA4CBEFfIILHTCIk/4CW856ke2yLPJA4gMOv
 4NbQW53rw8UU8AnZHXSq3OqmKWaf99PNicNZ8Uz/t7VtEWbj+OOHEu/bP/qhMd8YtyXoED
 fuWShME5Azjni6koYOJHXW8OpoI1JTARWxKCNMcSXp4+pD1KQ2mblvQAOh3Qq7tbv33Sad
 eKjxlrxyFhmIEfpRDlJZOqy9+S9nkrfR3QflydxafMOpgDHe8DptAfb0mjT6cg==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-9jm27;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Well-Made-Chemical: 780d60c13ad88cb4_1709150568257_3132101393
X-MC-Loop-Signature: 1709150568257:1413038961
X-MC-Ingress-Time: 1709150568257
Received: from outbound5e.eu.mailhop.org (outbound5e.eu.mailhop.org
 [52.28.168.19]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.116.14.15 (trex/6.9.2); Wed, 28 Feb 2024 20:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709150478; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=QWGJQlSDZzX8Jd+QX2B1l17NfY5JumE52Nro9ZVH20n4s6NjYqIxwNheWVh4oCZb43DqOC7a8kPx0
 IEpXZfJSiZfEc/NoI/qK1MZ6oiW0HtTWGsjArSD+boq9iwFavxwAR8+AyIscRrzRHx+3QGenX3oUqK
 3M9G9h9IF+jA/Na+DLwujIOSzGF0OOCnRZ5l4sSH6/TFQqA2jb/FdK4ERa6MPWRWXMUyPcc8+O8Onj
 dydb/W8VOskVcGjz85N+usbsmGUk0pufwlRh4MvW3PoT3pBdMcvvm9+qaIUWLa2C5ZTIwBbonExcfe
 UqNUsYAr1wfZy/KcN19s5dXb2xdfKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=zzOEiQj7obGsHCQd9xyo6jp7AhLHL7sbZGnf3tSSs7Q=;
 b=WnbMJtbq7YlBqEGCKiEk6sBFl50FVLpjiDqPuDrOcrb5pIGTyD2Mo9Cum2BzB+qOBTNzJmZS05ecy
 vg+mqnwYDPbdcvzOZAOslt7C4DEW/Biq8t9ckzLD9z4IP1h0NBoroyK6F3axj92tMJTQixDUXDW8fD
 ySzqJBE3H2hqCLiu1o7arf/T3DclVYW+nR1tAo/QIQnY8F1ES3kWy59z5ljOCPCZrHvAnn2nM7Mp4F
 wYyC8TeNIwTTRIHmoxAxa2IaCbb0+wuCX59+w2W0WaCBtKCIgPhTfHkRp+DzaYQYwM5Sf9PGZk6MpQ
 wz2NU+wjJj8W4xA/lKY6ULL3k+QBCXA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=lIVmE7Gi; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zzOEiQj7obGsHCQd9xyo6jp7AhLHL7sbZGnf3tSSs7Q=;
 b=oRIcTI0VIpbuVSk2Sck+juTzqLIjrtkWeNFtYSVUHSqaYjk3iowA/HpBu/TC0qUkP8nvManrl8e0f
 neURGoD+a5jB7xQ+h3iA7KzSa7Yf7Rov56Ni16E+ErUXGABQxn985zawYyv3SqEy1jGtGbezgB4QK2
 QpcNlND2LD+qWMVM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zzOEiQj7obGsHCQd9xyo6jp7AhLHL7sbZGnf3tSSs7Q=;
 b=OVg/GO0W2BUcoN5bYe1o6OZckth2DXK5GTNU5US0w7ODvFGXawhygqbq+b/ObE1isuCp2sELTc6cg
 tTp45PfR+9eZQvwTxMCgtc8vLsh7cWvhhr5+260rf/it0ItGa8XQiBWsSjr0ay5jKeVAtFwP1jD2+Q
 8eHfgjQKx8EEI55lZvBDikv35Sp/NYQ+I61qGsJAHdvNode+SKRl1Pf6cJC3nB7GfW5eGkE+eTSUkV
 egdDMUGPEh2jgikZxi9FZuNJLxJsUHBOsZAjIOTDg2/Bl+JUnLFRxs3B1Cd6TNg327BZEQ8BWR76A3
 HXTpgDosE+mDF8XXt8reDAFnuSSoO5w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 200962ad-d674-11ee-b650-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 200962ad-d674-11ee-b650-9b9d9be6ef2c;
 Wed, 28 Feb 2024 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zzOEiQj7obGsHCQd9xyo6jp7AhLHL7sbZGnf3tSSs7Q=; b=lIVmE7GibGzSbJHTkupMBYN0JO
 cnggrtTCCyS3kwPU4hRthQniLIj6mPey2UF06S/jcQfmFd5ePon/Wqibs8Bh9LhBdNcVl+8nQOd3m
 A9P/V3gyFQb1WQbpTUyFFnstZQ403unECxKAZi9iGgnuAWRSmXSNf0irH5DUc38s46C2EW2BTjRfk
 WPpP+KXWL0QQqgcfUQqJOssvqv/b29IxnxuEzjrS3zW0ic10RZUGFwhMl10VtwkGFTkkOshryaFXW
 R5z1Knz3B2EARgck+hDyQ97f8Ls/OXl4WEJOdLsgycqrWpY97URmXv9VuM73ZVD8sWXcVXu7PVhuH
 kB+z0twQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQ8X-000DfK-0t;
 Wed, 28 Feb 2024 21:02:41 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/4] plugins/execlog: add struct execlog_ctx
Date: Wed, 28 Feb 2024 21:02:08 +0100
Message-ID: <20240228200211.1512816-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228200211.1512816-1-svens@stackframe.org>
References: <20240228200211.1512816-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
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

Add a context structure for future enhancements. No functional
change intended.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e..90da1911b2 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -24,6 +24,10 @@ static GRWLock expand_array_lock;
 static GPtrArray *imatches;
 static GArray *amatches;
 
+struct execlog_ctx {
+    GString *s;
+};
+
 /*
  * Expand last_exec array.
  *
@@ -34,8 +38,9 @@ static void expand_last_exec(int cpu_index)
 {
     g_rw_lock_writer_lock(&expand_array_lock);
     while (cpu_index >= last_exec->len) {
-        GString *s = g_string_new(NULL);
-        g_ptr_array_add(last_exec, s);
+        struct execlog_ctx *ctx = g_new(struct execlog_ctx, 1);
+        ctx->s = g_string_new(NULL);
+        g_ptr_array_add(last_exec, ctx);
     }
     g_rw_lock_writer_unlock(&expand_array_lock);
 }
@@ -46,14 +51,13 @@ static void expand_last_exec(int cpu_index)
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
                      uint64_t vaddr, void *udata)
 {
-    GString *s;
-
     /* Find vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
     g_assert(cpu_index < last_exec->len);
-    s = g_ptr_array_index(last_exec, cpu_index);
+    struct execlog_ctx *ctx = g_ptr_array_index(last_exec, cpu_index);
     g_rw_lock_reader_unlock(&expand_array_lock);
 
+    GString *s = ctx->s;
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
         g_string_append(s, ", store");
@@ -77,8 +81,6 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
  */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    GString *s;
-
     /* Find or create vCPU in array */
     g_rw_lock_reader_lock(&expand_array_lock);
     if (cpu_index >= last_exec->len) {
@@ -86,8 +88,9 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
         expand_last_exec(cpu_index);
         g_rw_lock_reader_lock(&expand_array_lock);
     }
-    s = g_ptr_array_index(last_exec, cpu_index);
+    struct execlog_ctx *ctx = g_ptr_array_index(last_exec, cpu_index);
     g_rw_lock_reader_unlock(&expand_array_lock);
+    GString *s = ctx->s;
 
     /* Print previous instruction in cache */
     if (s->len) {
@@ -183,9 +186,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     guint i;
-    GString *s;
+
     for (i = 0; i < last_exec->len; i++) {
-        s = g_ptr_array_index(last_exec, i);
+        struct execlog_ctx *ctx = g_ptr_array_index(last_exec, i);
+        GString *s = ctx->s;
         if (s->str) {
             qemu_plugin_outs(s->str);
             qemu_plugin_outs("\n");
-- 
2.43.2



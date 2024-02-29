Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD0AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi0r-0002Wj-6z; Thu, 29 Feb 2024 10:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0o-0002WT-94
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:54 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0i-00080X-Vn
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:54 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B9188843DC9
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:46 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 876258439E6
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:45 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709219265; a=rsa-sha256;
 cv=pass;
 b=xUuGXSdYHr7dE5w1j+M2qg7ubaIL96GEhGqZ0i1ZC158uumJHhvD4YgpI4V2bnfop2xh0A
 G/l0jRvCi9VvE20vEnJTHGvlI5PdLW3p7+WiDVFTyflP39g6RaCCFflwYddmEEzDVNYOOK
 hk3jgcRdmvDJW3jMw9B0AIneuErmN6HNIY7PcsZ9aQsWjK4HDLBkBoXb4qs7ESquoqfOoN
 wBDFLKJilkYBMvnKx6jLYallj3X1mlrc4VFVXV5mNE7wCKeA8TsfrUXT7DAGYT4gcr7KJk
 lYq4TmTCFz4jxgkFvSVuXpxgBIjq2JWWo/wPxfiRkHyp06q44FaZ+LxmSmkCGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709219265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+MxZVS6+d/YpRNTrSjj+4Q8xp2pFhQZvVNtT1pIzzHA=;
 b=9NZa4/jrZGh4GtrS4QmyghTPoByCpP8SoECyjaTODQmFEIqom//zEv8Ti0e9JIFQfg4QPK
 rM1PKDbJtRZ3O/TVRYt0h++NX+5rGGISWsYEOGjfCHM34cBc2mqCSz0GC8RFl7TaslDxpL
 I+tTwW15x7jQXcsdvmxIud6Wl/k6eeftkRyJAd2No9LpzWrLsIFl/oUT0XeWLwOamykRrk
 V9qzHxtcuVNRWRJV9i8wjPt+9dIoLzhCKZIR+2Y5ANUqD6dExR5Z1lgTmbP+m3MOnrBEiy
 vbooEZ1x4i4IaOpM1x8Wz5TDe7n6gxXBv3cHl1zf7yf582JFGS862H+ZvXK3Ig==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-sjg2c;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Duck-Irritate: 2a88c6486e8a57ed_1709219266045_60340307
X-MC-Loop-Signature: 1709219266045:1984659563
X-MC-Ingress-Time: 1709219266044
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.58.46 (trex/6.9.2); Thu, 29 Feb 2024 15:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709219237; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=QjWdWGMbzL3QJB48/E0Mn1uEJQNGcXcIeWTG3mlori0QgflF7ZQdqvHfjL8sGplsrT965qLjpYvIU
 YUkUeR48DK9n4eK19tu6M8cmoje+APvvHAR9VWCQtM7MKmf8hlGCP836y+N1mO2mfnsJfdtS5c+11+
 LL1QwdQVPLH5u9LIOxv12Zv7IdTv7gc16IBkQ4y0CBJpkG54C1qs0FrNkyPRqUFyqa5BYpDEaR7/zS
 IWzIAP2cPtyLB59in6Va1jnQWlJAnLvgOLonDwtihYq8GApWpw5N1vQB4SO2EuB9Zi0T0C+D0BXoXN
 8lMOQ3TIMT+h32MEomJLA0ud+IJL1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+MxZVS6+d/YpRNTrSjj+4Q8xp2pFhQZvVNtT1pIzzHA=;
 b=M8hUoaDQceypJeJq7r9kaDNLQbUTzgkTB/K/B52GM1gzPq0Y5BJa7lfb50HHXVNcUIpJaYMNfIr7P
 2fpcZDOaQHLObII30DFQi71BQCw67rOAVCzJhESEY3p0bsWrGHK5P5Of97wXzgmNNX3B6AEHawEUoO
 q4rCmhW38ezzLkXExpdSWO3iJwi4FDqszmLlpNGFMmY419Uf68Rshex2rUTWA57Ri0dMhuo1ARM1Ug
 YPopSUa1MpIc9l3GUwP32GEbKG/Vi0SQ52+OCq0RGODlGmPCMCbNYvFKojcIwf+Jho5WRdvVm+1I9J
 ew4cFk9FCNMNiygx1wR21QXRqVfqW5w==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=eGmt/i+Q; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+MxZVS6+d/YpRNTrSjj+4Q8xp2pFhQZvVNtT1pIzzHA=;
 b=Z3dq1SPPYSBQJ13iqvGXz15/p0bGTZEfKgi3SdVJMnJdSUrDOc1vlvECeVJiEM05DWCCPVSunGr5l
 M8JmKvisyKtTyaPBN7ffpUku1cIggrA2PeQ7gIeTaAz/wtZzkfwZXE+ld1Y37Yh3ig/nEYSdlzujSg
 DxfzFMBo2SoYs2tU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+MxZVS6+d/YpRNTrSjj+4Q8xp2pFhQZvVNtT1pIzzHA=;
 b=o4piBhnXWW22UezroQXRkc/3J2HbzPVihdz5kWn1lPAKaRp/CZQQHm+jx6qrjJmpaCFxHiSZ/HDWn
 oZRZtq+Vt+DSXcDGI7dpbu8WXaebHyq8UOkJg1FnmmMpfBuRVi2l03SeUQhIJ8MQ7NjNc0nXWEkolb
 5wUEPSeh/I+62QRZaljaZ1pVesTCrsmiDaasYuXHxeYsklAQruu8BCfN6l5wRxvzlClF1p4qwC3Ht7
 q7tncUwYy5Hx9NrFSaxbPfdRyeMTK8/6J1SUG8mA48mKK7yzjzWPfMk4jpMO+53da/0BlTS9ux7L9P
 fJ78UXCOpcyUznXATL5r7ihHtGKr8Ng==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 37543b46-d714-11ee-afb9-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 37543b46-d714-11ee-afb9-eda7e384987e;
 Thu, 29 Feb 2024 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+MxZVS6+d/YpRNTrSjj+4Q8xp2pFhQZvVNtT1pIzzHA=; b=eGmt/i+Qr+fJwgBjaqCDXjXk3s
 YWbPxXm3pyELNkbxykzhN45gFjveaJUHuc0j8ugLQexNfSmZgiGSdwSGC58jVa1MBf6vfzcvHzS+z
 ft+W76z0ef+IKT3cELCmic0n/in/DtUvYSImcO06sCu0aiXglkR/tKBWKEhyyv1ocq7nvm1nvbPv+
 yIafOBZI0wW2ZD8VzEzz/Uh0gkgrA83EB0bF88SCPv+VZXMcnxLYCqTjeYaEOrK8UNmEtiqyfssaP
 3ZE0eseXVn5ifPe+F/Ot2gJmxGmksNSijYx3Q2+j9AtYoHmwpKL7Jot92cbK3d0Ktznqbq8hwBRcV
 dSr7/H4Q==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfi0W-000Lha-06;
 Thu, 29 Feb 2024 16:07:36 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/3] plugins/execlog: add address range matching
Date: Thu, 29 Feb 2024 16:07:29 +0100
Message-ID: <20240229150729.1620410-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229150729.1620410-1-svens@stackframe.org>
References: <20240229150729.1620410-1-svens@stackframe.org>
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
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 contrib/plugins/execlog.c | 73 ++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index c89ebc08b6..b1b2a7baf1 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -44,6 +44,11 @@ static bool disas_assist;
 static GMutex add_reg_name_lock;
 static GPtrArray *all_reg_names;
 
+struct address_match {
+    uint64_t low;
+    uint64_t high;
+};
+
 static CPU *get_cpu(int vcpu_index)
 {
     CPU *c;
@@ -54,11 +59,12 @@ static CPU *get_cpu(int vcpu_index)
     return c;
 }
 
-static bool match_vaddr(uint64_t vaddr)
+static bool match_address_range(GArray *match, uint64_t vaddr)
 {
-    for (int i = 0; i < dmatches->len; i++) {
-        uint64_t v = g_array_index(dmatches, uint64_t, i);
-        if (v == vaddr) {
+    for (int i = 0; i < match->len; i++) {
+        struct address_match *m =
+            g_array_index(match, struct address_match *, i);
+        if (vaddr >= m->low && vaddr <= m->high) {
             return true;
         }
     }
@@ -74,9 +80,7 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
     CPU *c = get_cpu(cpu_index);
     GString *s = c->last_exec;
 
-    /* Find vCPU in array */
-
-    if (dmatches && !match_vaddr(vaddr)) {
+    if (dmatches && !match_address_range(dmatches, vaddr)) {
         return;
     }
     c->log = true;
@@ -164,8 +168,10 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
             insn_check_regs(cpu);
         }
 
-        qemu_plugin_outs(cpu->last_exec->str);
-        qemu_plugin_outs("\n");
+        if (cpu->log) {
+            qemu_plugin_outs(cpu->last_exec->str);
+            qemu_plugin_outs("\n");
+        }
     }
 
     /* reset */
@@ -178,7 +184,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     CPU *cpu = get_cpu(cpu_index);
 
     /* Print previous instruction in cache */
-    if (cpu->last_exec->len) {
+    if (cpu->log && cpu->last_exec->len) {
         qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
     }
@@ -239,8 +245,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         if (skip && amatches) {
             int j;
             for (j = 0; j < amatches->len && skip; j++) {
-                uint64_t v = g_array_index(amatches, uint64_t, j);
-                if (v == insn_vaddr) {
+                if (match_address_range(amatches, insn_vaddr)) {
                     skip = false;
                 }
             }
@@ -394,6 +399,17 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     c->registers = registers_init(vcpu_index);
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
+
 /**
  * On plugin exit, print last instruction in cache
  */
@@ -409,6 +425,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         }
     }
     g_rw_lock_reader_unlock(&expand_array_lock);
+
+    free_matches(amatches);
+    free_matches(dmatches);
 }
 
 /* Add a match to the array of matches */
@@ -420,14 +439,34 @@ static void parse_insn_match(char *match)
     g_ptr_array_add(imatches, g_strdup(match));
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
 
 /*
-- 
2.43.2



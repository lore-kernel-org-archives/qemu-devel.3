Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E126C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi0t-0002Xn-Di; Thu, 29 Feb 2024 10:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0q-0002X4-T4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:58 -0500
Received: from azure.yew.relay.mailchannels.net ([23.83.220.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0l-00080Z-42
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:55 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 606FD6C12BA
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:46 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5D0856C1E75
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:45 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709219265; a=rsa-sha256;
 cv=pass;
 b=GLuGZG/RKQzSrmkFv42I6w8/fmJ3WkH6i0e1YGtPM7wzQVSKbsLZ35kyHqUDOqTHr8IoQY
 Il+QZdBfNV2hDckG4cq2xDDNHPN/tiXeyDuADLlF3jKcPfZB+Zp3OhvcIqFaP9T3hwkdHI
 EMIXT71VZpg7OPo+KDYegWy87uVfX88Y4jVQwy7jSS4h/yb0/cVkFF1H9B5tjkpw7zXBXM
 S4f8IqKxTzAX4Q9glj/iLX4fFq+BpZiMX9FvLr5ZCj5KS2Y/ThxSfxocaeHC2Mw/WidCrB
 vcYUwyFhSHinMPySWMD37KuxQYKttL/SiaamRdCVJfWiqNwFOQYgnE5AV6FWSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709219265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+MZmcw23+gcZpqaUG8wo+Hf/MlF1NZVB2P3dEGBbBAo=;
 b=JhOGZz0ja8cpOepnE32nRxX5T2n0js9aHKkw//sfk2dkWdYVsWAwdvWi2QBFP9/M2cGlgp
 XXmhw/O+ElAPRbrphFuE7CSQR+Ekl/RdYCrHLNjWCgUnsUp1/wmNbjeSeeZsrnYqpEonvG
 xEIzLqiIm8SyFQsW5L9bZJ2k6qmDVfkXuRXImfBEv93uBN6FegskwkTP1XK0KwJ3urxVRb
 r6vFtOly+HoMTz7+4d/CkYfDrJ94Dn05QYbgQcY1ctTQz4KnrNKtMq6Ql/MSoGYGr+Iuzn
 fDL7mEOA8yMWB6qSKP3D8tTXON46F8G7c6fauOO3fL/8ClXP9gD8ZfzhCOUJuw==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-h98rq;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Army-Abortive: 15400ec53f027195_1709219265971_3880336239
X-MC-Loop-Signature: 1709219265971:1621510739
X-MC-Ingress-Time: 1709219265970
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.236.39 (trex/6.9.2); Thu, 29 Feb 2024 15:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709219236; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=ubktn7dwMvzrUtjZ9sMLbF5+7RP+dY3oSlK3kDbb9v3jCuN3Du76NXsMvqmSK+PVrEzVMuNv68/xY
 VSUDaTKb7nrNPl7FdqEPr2hAk366da4l9Ee6wV6t/xvPjkt63zxyHNfloy5XeGZ2c5YWWhpFyUjrxE
 TSfat+JV2gWhgn5Bh3witH1DhnpmjSiM8dyRefxOloTXCbLoBEN+okPkrGyIR3Nv75y7g1tm3jojNx
 3fjcqmS5MzMdrtpwWIVB7yhfV8n83CmoNIuGon55pDmJZ3UC2EzRY2nmiJd281lozICsyEGSvPiKr6
 BoaV4Uc0SY3hRZWtA67MoqyOJTK3myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+MZmcw23+gcZpqaUG8wo+Hf/MlF1NZVB2P3dEGBbBAo=;
 b=OrkgbBamL20GGPJRre2QfYDLzWd3HLVFdFfQodfT96mCF8ss/MNewXsrwNDxQ+QfMGJCyEbULWhfc
 wCzpNzMTffIXW81GPf8OfKwr3HtnpmB+ANSVDfzKaPIJ1wD34iasNLAPfKo8XhDwTStuLoEQ/RW6aS
 /L9DaEDYM7RWaOCpp6oxK56zhhWHC/pBN5I+UfQIvg/InS13DycpEX6XZCdoX2LD8N4B7isfVoi9t/
 /UoQEm09n0Xy4MRnNkkEYw2F6hEK2o3O3B9EJVXOrumLJBK03FH2T9IVKWrxF8KywbEJ5ACPsI3d1H
 2BWJXyEGb4mN7TaSns2VQJ/yN1dTJeQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=a9QXVQjo; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+MZmcw23+gcZpqaUG8wo+Hf/MlF1NZVB2P3dEGBbBAo=;
 b=GMTTEfh28P+2n03++9XfTYcKNPFUKoIH7WbZ8xfBC3+/Xjj3SZBDoaiIZYrcvTPC9MaRFQ6VuTigl
 uif7eLRLLBg/ptHABmzyYHFfCe2IfmHQZbQZVLntWVRoois6+bqn2ZJ0cirjitp55XoheGKy21otuL
 UEeYO/L4gzKyX2pE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+MZmcw23+gcZpqaUG8wo+Hf/MlF1NZVB2P3dEGBbBAo=;
 b=v4qJNxoS5CA7WYA3M0k2H/uzlkqrhC1OG7uKjYdYthYNsbgc2VJEtYo53wW9GsJr8fKCObP1FH9mB
 l5A8xh3D+ZXnO+8Cj9XUX8C+EuU9xuFydUCoS99LNAeNZqEyJ9Fua7pdlsIoyA/FdgwoVaxJUtGqhq
 1TPiysHLkk8piccbBZdUOFxAGUtxrkEpTiUTjlTiqcV3/R6KlAsWFX7uABlqITrY2IkHOitqS09X9E
 de8cLtb8tcl/Juumuqu/hghgi97KmVWmxWli66LwFKPuBLJgh7UOlwPvuNwlCMSA3QasOv90MoRRFQ
 sWQnjLQrNVqpVSTWbAkEjYen4hzDqpg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 36ffd736-d714-11ee-afb9-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 36ffd736-d714-11ee-afb9-eda7e384987e;
 Thu, 29 Feb 2024 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+MZmcw23+gcZpqaUG8wo+Hf/MlF1NZVB2P3dEGBbBAo=; b=a9QXVQjoMqfqQUJHMSbvuqER8F
 +oLXeDb1Rw0JBhZofNG0SbHJqAEN+iP+TXd0QLgX5yjMX7X0vrDSstceEScvHtofTJ2ep9LBsDEgV
 anmYrqd9YeRdFppAqj09JWncz0b4/ZSXS9bMSkEFUleWq1oixVaGAXDyHNJsNL7HZA9fTYxK7+uVl
 NjLBxmjLVQDVs2ihopPsz7ixEwFFB26/l8HlTWxoFhrIuSJrNVtYw7onJA/MR2BkxXHBzDGgkhGzb
 jlm9j0FyaKgKEe9I/LP/V9Gu1K+2bmhlhyK0c80psS3uemVOqkgfH6g0A67vSHyvLYaHuVCvxfnIS
 hrzFu61Q==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfi0V-000Lha-1Y;
 Thu, 29 Feb 2024 16:07:35 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] plugins/execlog: add data address match
Date: Thu, 29 Feb 2024 16:07:28 +0100
Message-ID: <20240229150729.1620410-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229150729.1620410-1-svens@stackframe.org>
References: <20240229150729.1620410-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.220.7; envelope-from=svens@stackframe.org;
 helo=azure.yew.relay.mailchannels.net
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

Add a match similar to the afilter address match, but for data
addresses. When an address is specified with '-dfilter=0x12345'
only load/stores to/from address 0x12345 are printed. All other
instructions are hidden.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 934553e83d..c89ebc08b6 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -27,6 +27,8 @@ typedef struct CPU {
     GString *last_exec;
     /* Ptr array of Register */
     GPtrArray *registers;
+    /* whether this instruction should be logged */
+    bool log;
 } CPU;
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -36,6 +38,7 @@ static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
 static GArray *amatches;
+static GArray *dmatches;
 static GPtrArray *rmatches;
 static bool disas_assist;
 static GMutex add_reg_name_lock;
@@ -51,6 +54,17 @@ static CPU *get_cpu(int vcpu_index)
     return c;
 }
 
+static bool match_vaddr(uint64_t vaddr)
+{
+    for (int i = 0; i < dmatches->len; i++) {
+        uint64_t v = g_array_index(dmatches, uint64_t, i);
+        if (v == vaddr) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /**
  * Add memory read or write information to current instruction log
  */
@@ -62,6 +76,11 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 
     /* Find vCPU in array */
 
+    if (dmatches && !match_vaddr(vaddr)) {
+        return;
+    }
+    c->log = true;
+
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
         g_string_append(s, ", store");
@@ -121,15 +140,17 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
         if (cpu->registers) {
             insn_check_regs(cpu);
         }
-
-        qemu_plugin_outs(cpu->last_exec->str);
-        qemu_plugin_outs("\n");
+        if (cpu->log) {
+            qemu_plugin_outs(cpu->last_exec->str);
+            qemu_plugin_outs("\n");
+        }
     }
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
     g_string_printf(cpu->last_exec, "%u, ", cpu_index);
     g_string_append(cpu->last_exec, (char *)udata);
+    cpu->log = dmatches ? false : true;
 }
 
 /* Log last instruction while checking registers, ignore next */
@@ -166,6 +187,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     /* vcpu_mem will add memory access information to last_exec */
     g_string_printf(cpu->last_exec, "%u, ", cpu_index);
     g_string_append(cpu->last_exec, (char *)udata);
+    cpu->log = dmatches ? false : true;
 }
 
 /**
@@ -381,7 +403,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_rw_lock_reader_lock(&expand_array_lock);
     for (i = 0; i < cpus->len; i++) {
         CPU *c = get_cpu(i);
-        if (c->last_exec && c->last_exec->str) {
+        if (c->log && c->last_exec && c->last_exec->str) {
             qemu_plugin_outs(c->last_exec->str);
             qemu_plugin_outs("\n");
         }
@@ -441,6 +463,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
             parse_vaddr_match(&amatches, tokens[1]);
+        } else if (g_strcmp0(tokens[0], "dfilter") == 0) {
+            parse_vaddr_match(&dmatches, tokens[1]);
         } else if (g_strcmp0(tokens[0], "reg") == 0) {
             add_regpat(tokens[1]);
         } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
-- 
2.43.2



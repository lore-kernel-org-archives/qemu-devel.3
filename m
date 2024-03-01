Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79673C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6yI-0005dB-T2; Fri, 01 Mar 2024 12:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yH-0005cj-1T
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:57 -0500
Received: from cockroach.apple.relay.mailchannels.net ([23.83.208.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yF-0000Zf-9P
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:56 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 87137C3D31
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:53 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2AA72C0EEA
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:50 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315210; a=rsa-sha256;
 cv=pass;
 b=uP7UKcK1JV2BKkRYh+1IQIqUBc+qu0IFhjM+qVQe6JnswR3SWo8cJKpnbY6p5xv1CobmZN
 udkE1VWzWiZarOqowEqLhWvETsDmySHua3xtjkGRRxIg5bb3tIeQ9WjU79GlRIidbEUN5j
 1w3wQovbAucUYN5BZ7C7q0DdmuD3rg1lBc2SSTWHlRVYLHu5VUAt4nSpC3qZ5xp1S7KvsC
 iLiwDQyv13gskgYbYfWsvCjyh+6MUAp+PlagMej5KQ1orLVDtS9u+3GAIpn0wnckeEuxjn
 joGM8A9OV9XwpxwkbSUrtX3b3lYNwAS1K5qKrwPFUm9JAcv+7Yi3qhb1rLqR4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=cdkKRJF8r6aZrtkiBOxc7rRIDL5nfso4OZ50Eglu720=;
 b=R9xgxyCd902pY6Y0byXNVbVenD9fQPjsvsI02PLdMgvXtUq4Gif2Ipk12+sOmZId5Mf5Qt
 pcaZJUOAflREELcVnYP2zpbf6YCWItDilDMYZQnw6/rGhKZ6KHodqWJol4PNKaJxGix/UK
 rpRD0ora2MRpklXb6NpQqQglBbH7Y46WI5uPPNqnvl9KaT7hsAoILT6OZAK1qsUg5L3hPM
 iqWbDgXQupqQsgQ//xqAliQjvQ49qg4XDaipKMx0/FR94DCm4ecGRtVwFqweVljoovi2fg
 1KQ8fXBwPmSC0edKN62AmCLaA6+4A4JiybuvUNCNIfH9jmnHEexYFpFrDDySQA==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-wmrnf;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Quick-Bubble: 11df773a1f3f6dd6_1709315210679_3670380048
X-MC-Loop-Signature: 1709315210679:398321630
X-MC-Ingress-Time: 1709315210678
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.116.14.15 (trex/6.9.2); Fri, 01 Mar 2024 17:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315171; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Xme7XZJv9UNarWP+5ymRj+DQkj9Kpgk/t5BNgJvkGSaPPz8svozlOCKZrO6GtZyQ5xf66xO7mPLRO
 2AiDwLrhNjDdvET+jNhMNhxaneHvRQba01CDpZHd47KGzvD3UjxJTgj/0lIbN6brpdOIzNZBwVqoFz
 4j7+q+KbPQrDtBV+bS8REFMUGTQtSs3dgUExmwb6SMXRJfKtaL7Kek0BvVHbuI0Fre1D5G4AdlukZ4
 bwwn5mqR/7UaNKflzmGCeFRPThyc+tWnRt+C7NOMyw0PbXQL3fUDM2zYdKSyxQmF7U1wfi3/5AuRVI
 1oD32hvmq7Dng8hTlg26Jqmg1MJWbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=cdkKRJF8r6aZrtkiBOxc7rRIDL5nfso4OZ50Eglu720=;
 b=Vm3tzYkzsz2ZjLx7/8vxRfzL4ZujVKwwSr7NllmbBTJ+QesurJ6HtqyWapPoIM8ViSY2SN4XGE8jT
 UdsbWP8BmljUjvJi4r7GNLH1AaV1O1tgQumBxjblVezdsl+YuOkHExjT1o0fcOPJyA8FyJIq0GMI96
 jyZ/F8L6rQapNpu6yT9n1s53WioXDo6K8YT+uk9/LY2iXQvTW2GwcG2W5Ar3y47DNYIIbEzR9eQ3YB
 JLKhMQdS2dMDs1mEbfiqNdQXbbhpgtSfJqs0FHEyzq8lpWPdajl6KlbmOM2YNqurDKPghZJfwtzXIm
 xAs5Mg6imjbgMrHpmB+b6+VsoIu6ZQg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=GbfUHZjU; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=cdkKRJF8r6aZrtkiBOxc7rRIDL5nfso4OZ50Eglu720=;
 b=gKQznHz5OX4VlIRHL2DeNkZGAhbEqaXG/eVQIDFuJ4LybTfr8YTJrmaEcPmYPSmOXIjwyM0tMqUgq
 bCajaA3e5ILp5eVBK5ZWgND6oQKlgNpnbOcbiiAnrHbMaojAgA02/7l6lnqjLpGeKnN1x2jWZiNow9
 +fypuGqJCGNI5wVg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=cdkKRJF8r6aZrtkiBOxc7rRIDL5nfso4OZ50Eglu720=;
 b=T4dNUUZvEMBWxn0EOZFVZ9y07Di9iofmNfvFMNodqE1zLoNiLH3SZzIVUhHgHq9HVt/T8JvnHk0BS
 30L4qPvznEDJHqJOLvUPVJREuyhOE2pS0u1rngXxSQCQmp5OUEz0coXy/MrRCn4owdDRbt1zNbPhoi
 86/xaY9UwvOyMbokrsvA/eANiemB3AHfjks/zSse6PsD/nbbryi2UDbrtfl/0PjV5omf14VR605JUi
 4PBc+fL4s8ynRWoPril7CWfuszMz/aFny2m5UTx4iAHVa7QWbI2DQUS9YqVkYREJWPlOsE/t5HqTNd
 +/aZ8i1c+GkxflQwjLU2WYGSsbcR82w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 945a3604-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 945a3604-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cdkKRJF8r6aZrtkiBOxc7rRIDL5nfso4OZ50Eglu720=; b=GbfUHZjU8yXKgqMVCp1N3RbDS1
 9RH6reMzEsfGwRSTg1JHSzrs5Ifg+U67NtUBFL9Q8ChMpUcDJUsxkhT/ex+B6zaHiIRB+MDHBd7wy
 ocY94cSaOe7WIgaVpfIvV8QP2kgaxrY+Kowj/rlH9spPPb+TzYK4iS1VPjXvt4fkLgvH28assPCyf
 wxM2HevQL9Y1rg9/pjCCz1Bdjku4kw124AvxCBqN9mQduUP6OS95KTbg6eeEuIfzj7WYDTMyAavda
 0O1V3sT3zb+FGQP9OHJPHYi10YjzVl4b0mvNG03NeXmFwucwFXDuUGdYLTEnpHp30CKHHOx7+IN7T
 Qvin0BXA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xq-000bs2-18;
 Fri, 01 Mar 2024 18:46:30 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 12/12] plugins/execlog: add data address match
Date: Fri,  1 Mar 2024 18:46:09 +0100
Message-ID: <20240301174609.1964379-13-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.208.37; envelope-from=svens@stackframe.org;
 helo=cockroach.apple.relay.mailchannels.net
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
 contrib/plugins/execlog.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index c518797893..c44fd0e593 100644
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
 static GList *amatches;
+static GList *dmatches;
 static GPtrArray *rmatches;
 static bool disas_assist;
 static GMutex add_reg_name_lock;
@@ -62,6 +65,11 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 
     /* Find vCPU in array */
 
+    if (dmatches && !qemu_plugin_range_list_contains(dmatches, vaddr)) {
+        return;
+    }
+    c->log = true;
+
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
         g_string_append(s, ", store");
@@ -121,15 +129,17 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
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
@@ -157,7 +167,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     CPU *cpu = get_cpu(cpu_index);
 
     /* Print previous instruction in cache */
-    if (cpu->last_exec->len) {
+    if (cpu->log && cpu->last_exec->len) {
         qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
     }
@@ -166,6 +176,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
     /* vcpu_mem will add memory access information to last_exec */
     g_string_printf(cpu->last_exec, "%u, ", cpu_index);
     g_string_append(cpu->last_exec, (char *)udata);
+    cpu->log = dmatches ? false : true;
 }
 
 /**
@@ -377,7 +388,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_rw_lock_reader_lock(&expand_array_lock);
     for (i = 0; i < cpus->len; i++) {
         CPU *c = get_cpu(i);
-        if (c->last_exec && c->last_exec->str) {
+        if (c->log && c->last_exec && c->last_exec->str) {
             qemu_plugin_outs(c->last_exec->str);
             qemu_plugin_outs("\n");
         }
@@ -432,6 +443,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 qemu_plugin_error_print(err);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "dfilter") == 0) {
+            Error *err = NULL;
+            qemu_plugin_range_list_from_string(&dmatches, tokens[1], &err);
+            if (err) {
+                qemu_plugin_error_print(err);
+                return -1;
+            }
         } else if (g_strcmp0(tokens[0], "reg") == 0) {
             add_regpat(tokens[1]);
         } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
-- 
2.43.2



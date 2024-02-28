Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252A1C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQKP-0008HT-Gi; Wed, 28 Feb 2024 15:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKJ-0008FJ-Rz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:14:51 -0500
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKG-00042c-9R
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:14:51 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C7C6AC1612
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:45 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id F2E73C299D
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:44 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709151285; a=rsa-sha256;
 cv=pass;
 b=To36q/XZw2dc0c93Vd8KnXs9D9Zfxv1+qsH7LMuAukZqkucAn2QvYOgzUtfJ2jWpe0jr8g
 jPsux+9MehRFXNwp7TdoWdUs/xkKr55REU5zLnzyqpuzVXeafSVm4SzKYP5qQ/Hw/DXK2e
 Smk6AINAhCGAy17J/bNxPKdHYxFXfe0n+n+mnRTBTQF98HKC9DcZIaZ9lAsDNSw7h6dyZy
 BYC2ylDWm3hCQkV7ASFMclVFYFMlcgP+1gAOxHgkcdsAs/X2nOViJQj4CgBX8pIbd/3YRD
 lRJijz42ziMVI9Zg60lLNToMsYJJxnhxqT0FrXRr8AKye/76OcyqRrpOsrzXuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709151285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=tGqoTKg7uGmsAnU6stPR+zkpAgXqaQsmACDLXuTnCYs=;
 b=ltxJI3DRE2I53Kmh6hnZ9ILyxM4aHg5301mbgaYy9BY6sURzln+mhaolQkLTw/lbaMMUci
 XhHJKukFDiz6NSFPh8MkwScgwSxInFlsWcwPs6srVlIkKqARUkY7uLwmtBleRh58gQq/ZO
 UjmQAqnkKAMjqRBwQ8dCxq5QYX32Am/WIKbvRg+7VqcINWVGKDflB1+27zWXimMf8owshs
 uPdTed9RcQs1r2mqS8q36ng4cTh1EwT/KpusmsxOVt6B90rROQwWYCtZAIvjlhrs2dnPS1
 nnfG9cwdPVdfiCHI549bY2NliY/RJ/r3AFqPv4OxZXjaEYCp3kYyWDpxO/Teiw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-tc9hf;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Whispering-Abortive: 788949d90a4fbb1f_1709151285489_3456905678
X-MC-Loop-Signature: 1709151285488:2571048425
X-MC-Ingress-Time: 1709151285488
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Wed, 28 Feb 2024 20:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709151260; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=nLRUXW6Vn9WJ1qgK3olnVZzOAjB5bayJNGsOm6JToPrGBCukbSZlLahnffOn5JNingf04eixw/GRH
 goUEwycFPGpBTlXmhVwwE7ApfojlVmVFstsggf2dNFfecJlDMYjkJJxluZdntry9ho7PByjGbg0IWm
 nCIxYQNUFFu40AVb7O7LbByE9CcFtRogv038CnfmybdqUJ03zSLDmx5VBYigvuEpOMD9dcT5n6efsF
 CglOOGBTZgVNycpmlSeFTXZ74H3p7UUmY1wVzP178vJqf/bg3dRLIQCa3zFZQp5RI5k7wY8n3ceIrU
 x55vz/z0tYGlSa37gpuxOWQo1ZNqRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=tGqoTKg7uGmsAnU6stPR+zkpAgXqaQsmACDLXuTnCYs=;
 b=bJu4I/Ov9ea+PgvmowCfUm9H6q20i9ahyQyTOJwfW8DLcgihMMQLl9u72ni9jX/v2pFQK8b7HWlXg
 jVVNy56b2PVRaoF03aJ1cf6si8ymwXB5yQZ84fE8MxkRcXM40bDE9mb8fTLwfLwj8lgfAqSK/BrcKR
 XX8CNqo8Qizfh/pv59vBVL0bN0KyRhedHVxzcV+oEk7qXzsd5uWXNpbIkkteRZgnxz8rerqEwnkmZL
 Q2zfWRejGC6eLGYNMw21lrvqMp3q9xiG+bxci15chay2JvBbB136Vq8QgcT+LPxzzP87pD2J7wtWF8
 XohxwxY3iZ3n4+MrISliZlOolrKWfBQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=R0sht6P9; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=tGqoTKg7uGmsAnU6stPR+zkpAgXqaQsmACDLXuTnCYs=;
 b=sfG17wNNY+JywPu1A9E2HNcROfijEZBF8Ub5qSUE5az9BU7gCO1VUvZI0gQIavLHMbP+QWpt4M1mb
 1yzkaybIFl/yGwuV1w0A3SSyfsIVwfeQupeAu0VkCaPw8zvyiwx9oYfC1oNegWvsUWRTw9AQWpAWR9
 hWhuxZ8NR6cFEYes=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=tGqoTKg7uGmsAnU6stPR+zkpAgXqaQsmACDLXuTnCYs=;
 b=YC7sBcHN6nd28B+dLDJveYT0liSlN8SEZQ8dyjTQDJUhyUuR8E0Jo1iUHW9a54pnLuCSEN5oqq0iw
 zlAuKEEHvnNAebIHy5F8B4k9W+F0dSRXnDwTwz6Zjxpc6nDCt07kdV9QyBtamsMnedPsLurBArhipt
 C9d1XmzI6SuLCNoTRvukjI2fE4ql6fx+VRRJztY+3oGzlo4gHtjNsmkIc9LhzmHhQr9VKySs7wbxCY
 LnyKarLFGRrLZdi1WpOkNPLNKEl4Ruxph6Aod0oYSIG1SSU5yTs7eWfyHtGFPcfA2Csh8wPVmT/4jD
 5fnX2QmNEuXwEKydXjfdnktUN8mMySg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f31b9285-d675-11ee-af94-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f31b9285-d675-11ee-af94-eda7e384987e;
 Wed, 28 Feb 2024 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tGqoTKg7uGmsAnU6stPR+zkpAgXqaQsmACDLXuTnCYs=; b=R0sht6P95XIhPUBzd7A/cqubHE
 q1iBCmKLQUvAQfR0fPgcKB/JKiPo/W2fo3dXE7+oypCkpesAj0X21lWVIYI3RHt7y42b1gOUqbEi+
 Opp8bNFxKDX+/7pP4deVC2q5vhs6Q6s35JwSYaWGPquSD6jx7joPsIzQ+0pPOP/fe0xU6aejyvDKn
 SXX7K157N+Ta8RZf+iLG2mZSUUmF9svCzQnnPshHOTxOc3906A/cX1yZhkX82Lqeaz3SubVLgwITl
 ZDuBoxAzEnJ7lv0VylJUragIW74Cslf+inIskNrQp/WX2DNuoUaaG8oLm7LaMTv9iEEZWsoW+ND00
 mcuYXz2g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQK9-000Dka-01;
 Wed, 28 Feb 2024 21:14:41 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] target/hppa: add 64 bit support to gdbstub
Date: Wed, 28 Feb 2024 21:14:32 +0100
Message-ID: <20240228201434.1515893-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228201434.1515893-1-svens@stackframe.org>
References: <20240228201434.1515893-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/gdbstub.c | 48 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 48a514384f..a5b2c80c07 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,11 +21,25 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
+static int hppa_num_regs(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 96 : 128;
+}
+
+static int hppa_reg_size(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 8 : 4;
+}
+
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ureg val;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
 
     switch (n) {
     case 0:
@@ -128,18 +142,18 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->cr[30];
         break;
     case 64 ... 127:
-        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
-        break;
-    default:
-        if (n < 128) {
-            val = 0;
+        if (hppa_is_pa20(env)) {
+            val = env->fr[n - 64];
         } else {
-            return 0;
+            val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
         }
         break;
+    default:
+        val = 0;
+        break;
     }
 
-    if (TARGET_REGISTER_BITS == 64) {
+    if (hppa_is_pa20(env)) {
         return gdb_get_reg64(mem_buf, val);
     } else {
         return gdb_get_reg32(mem_buf, val);
@@ -150,9 +164,13 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ureg val;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
 
-    if (TARGET_REGISTER_BITS == 64) {
+    if (hppa_is_pa20(env)) {
         val = ldq_p(mem_buf);
     } else {
         val = ldl_p(mem_buf);
@@ -267,16 +285,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_hppa_loaded_fr0(env);
         break;
     case 65 ... 127:
-        {
+        if (hppa_is_pa20(env)) {
+            env->fr[n - 64] = val;
+        } else {
             uint64_t *fr = &env->fr[(n - 64) / 2];
             *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
         }
         break;
     default:
-        if (n >= 128) {
-            return 0;
-        }
         break;
     }
-    return sizeof(target_ureg);
+
+    return hppa_reg_size(env);
 }
-- 
2.43.2



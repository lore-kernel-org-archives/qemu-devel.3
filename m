Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB3ACD11DD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roIvp-0006hS-Bn; Sun, 24 Mar 2024 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvj-0006g3-1s
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:11 -0400
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvh-000307-F5
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:10 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E27197612C5
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:10:07 +0000 (UTC)
Received: from outbound5d.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 56D1C761119
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:10:07 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711267807; a=rsa-sha256;
 cv=pass;
 b=3MITKUDg0vMJG7CoipEQbNEa3XP/R1hajDKKHaXhmbSnlmPIfpuSzYQViZXqbzbWg/yyYF
 k1IvlGfAOS+mJleVb5vawvWrzImtK6UECagOIPrtufcXcmWO4/zX885ppG6qI8U4boU3cB
 1P18fRuCdhfYbcNSB4AV2mfBUUzzAf0UawZsgSLirOhn00/p3UUd895ZQTxewUwBhLnqi0
 Iq1bo5eZ2bN+QnmE/fGvBiSpibHZmv3n13XRA+z0VFlCW724+Odg5Nd2a2tBSWPoueU/65
 YkjMpvzFw1tpsXTD4j9YUNhJlsM809+m1W56WCPApPC03Y2PuLeQymxqxMNp1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711267807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=XDpvodS8+EtqOu2f7xW1QMkF8CmCMP4pxH2raL8KFd0=;
 b=A/i63YRep/CdZZmYucAf6N3fjnko0mVtMq4UtAvSYGlpb7nxofGEVlGA8q6Vx7GZueIuWN
 7OPIDk4MQT2cMy5LET3tnRsJVQxCKwy76jr1oB7DCpu8rhzuEPZ7dsKo4snYIE/5xocd0e
 yN7WovbvJHXxfbOLxURHx4rlBFSnijNI1EyWXtaLcqOIkARMHVQO6Rz/MEkZu5lRQxDbUm
 G5cY6+p0vn3pNgsy4UpwASMH62sImYagdI062nZqgOts3JkSuZvNdBsgrxbZp4m69rE2D4
 V05lu4k22ie6PFCLuLSIBgJ13bikFjxqAYs8FA34XTmjqeL1LW2o9GSAZ3mXiQ==
ARC-Authentication-Results: i=2; rspamd-dbbfdf895-4w9nv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Average-Sponge: 0d8a463f6406b6f0_1711267807828_84523601
X-MC-Loop-Signature: 1711267807827:517976485
X-MC-Ingress-Time: 1711267807827
Received: from outbound5d.eu.mailhop.org (outbound5d.eu.mailhop.org
 [3.121.156.226]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.72.200 (trex/6.9.2); Sun, 24 Mar 2024 08:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711267760; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=SVl5HlEuw/H9PU54DFLk4QD6SWiik9H1h1MmFACp+ubzUXonDbr/mW6yvAbeP/0f/tMKtjNbyq8mn
 oYz0kIGvHwsOJ42Wq9Hag8kmb86KOfzdNAKoOxf9AI3K+QMW14zXPPrdfaCwfndgWhCM68QbNcVMlv
 Muqgwftin7YSwkx6SPmclRzJdRqo8ZFwLJUtCcSSyZXGV3V2ZEugDN45Et0S2kyTwM8omc1m8fsPzv
 qFDEM6DFu67EtdwTCqVmDD91vGBY0PWYff+VcYCVJBgHdGDp2YzjZpksMhiFqiNvF0KB/cFrWsVDs3
 cTCs27o/iJ7zAUbMI6VcEheuvPRHV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=XDpvodS8+EtqOu2f7xW1QMkF8CmCMP4pxH2raL8KFd0=;
 b=Ke3oZTE50CpD/cOI7/Spcrzsv4PFCy+Gd/cVltga+8p1cZ6+GAO53DRdVuR8ZYtjI0Q05n6/BYjzM
 nL8XDV6tCCbE5NjHNnzEVIREODWU3+4FafPZmTOnseIZ45O8py1tkCHbV+Uidv+yGsOarA5OehhbyC
 c4pNGCoecZE1Iy0c1ptOFQ/cODNr/cmWdcb/WkHbUJnWE0ZycN+WA+iOK2TGgOfJ/tlmPfnGzDBLTp
 w2BDf+4iAOt9r5NCr0A7FrJLYwJWu0AvKkkjpvjU8hfI6QjeUfbIHSTxdoSVcwYSwcz3vt3/rJHDhX
 o8C8T/8TJy1QxOzApl0MNnsePRNBNJQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Qb5TF/5W; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=XDpvodS8+EtqOu2f7xW1QMkF8CmCMP4pxH2raL8KFd0=;
 b=n3hHKRKO2wp+fVV8k4o+QwEbxR8C1t97FnzcFdyTG+FFGMn+KESz9DKsYqf4O27zBGI9kgarsk+6x
 VpC6trEn8ZFXm9clkL4FK5knothBQNK3i/mbqQwiuFJepL4erDeE11skZwpC/uDuejBhZfhg/VATHy
 mlQkVnd4jHiLHucM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=XDpvodS8+EtqOu2f7xW1QMkF8CmCMP4pxH2raL8KFd0=;
 b=Y+2bjoV45FLd51kLzDH9v6O3C1420SdeTbj14VG+owJFoVeaoLJ1VMA3NEwWUJadr9isT6/f7xIdM
 DuDRg3HVda3An4aDbywPN9SnAhltR9X+qMM1gF3izEIWIxOnM4/2YlVe6Z9G2+Ga7xmReEfC93NfkU
 vcBmPlmCy5ggStf7bM4lpLaBjQu4iN3QpQMux+/xcJ21m/rTAm8TAu/RhdPGRDtw/8di/2U+gJ0KM/
 gpv12cMhAZONJbcTnY2HSv8E3TjjsEt0Z6L+mveYNOiS/Ra4Cei3ckDVp8O5u2VdOH6cqpM35J/Seb
 TLHlBYickJnPFEueydkOCRgf0btv9DQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: cfc88d5a-e9b5-11ee-b278-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id cfc88d5a-e9b5-11ee-b278-eda7e384987e;
 Sun, 24 Mar 2024 08:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XDpvodS8+EtqOu2f7xW1QMkF8CmCMP4pxH2raL8KFd0=; b=Qb5TF/5WKuN6sgSTPci6cSTJpX
 yKkH0df5x2/6eSRFtVLMC05nYRtn+c3F5BK+HvjlrAuteZQNnpAlLoHuM0wIpF4K1WMBNmdRr28xU
 nz7x/gU653wYq6uOdMoOXjSDf7Htqsbf6mZDQ/RpVcjqKKw29b6XdAQThfarW8rLmBrvv8iR17v8s
 Mgr6WtWNtQ69GrcesAJoxfRpeYBWSyCZfC+xvcV//WXJ4LZVjXWQJkiTTfQA58VuvxnpdEZLsuvEA
 YhrDolnZcVj3cYE7Q5AGxVlsvPxR7OSimEcRk5ZO5VmVe68eD6bkxhsFdZjQM80wfE9tRjiO4aPGd
 HDnucikg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roIvR-005LYx-19;
 Sun, 24 Mar 2024 09:09:53 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/3] target/hppa: fix building gva for wide mode
Date: Sun, 24 Mar 2024 09:09:45 +0100
Message-ID: <20240324080945.991100-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240324080945.991100-1-svens@stackframe.org>
References: <20240324080945.991100-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

64 Bit hppa no longer has a fixed 32/32 bit split between space and
offset. Instead it uses 42 bits for the offset. The lower 10 bits of
the space are always zero, leaving 22 bits actually used. Simply or
the values together to build the gva.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/mem_helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 84785b5a5c..6f895fced7 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -523,13 +523,16 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
 }
 
 static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
-                       target_ulong r2, vaddr va_b)
+                       target_ulong r2, uint64_t spc, uint64_t off)
 {
     HPPATLBEntry *ent;
-    vaddr va_e;
+    vaddr va_b, va_e;
     uint64_t va_size;
     int mask_shift;
 
+    va_b = off & gva_offset_mask(env->psw);
+    va_b |= spc << 32;
+
     mask_shift = 2 * (r1 & 0xf);
     va_size = (uint64_t)TARGET_PAGE_SIZE << mask_shift;
     va_b &= -va_size;
@@ -569,14 +572,12 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
 
 void HELPER(idtlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ulong r2)
 {
-    vaddr va_b = deposit64(env->cr[CR_IOR], 32, 32, env->cr[CR_ISR]);
-    itlbt_pa20(env, r1, r2, va_b);
+    itlbt_pa20(env, r1, r2, env->cr[CR_ISR], env->cr[CR_IOR]);
 }
 
 void HELPER(iitlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ulong r2)
 {
-    vaddr va_b = deposit64(env->cr[CR_IIAOQ], 32, 32, env->cr[CR_IIASQ]);
-    itlbt_pa20(env, r1, r2, va_b);
+    itlbt_pa20(env, r1, r2, env->cr[CR_IIASQ], env->cr[CR_IIAOQ]);
 }
 
 /* Purge (Insn/Data) TLB. */
-- 
2.43.2



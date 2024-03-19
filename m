Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D95CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBi-0005ZC-40; Tue, 19 Mar 2024 12:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBe-0005XX-HM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:38 -0400
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBb-00049v-WC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:38 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7289FC3492
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:32 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 99300C33C5
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:31 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865172; a=rsa-sha256;
 cv=pass;
 b=lZ/0Zg5ldKy8rq4iHDDu4wdPECrR429NyCMnZi3CyBxUeirNULF9lxc1sjvBWb2Weqej3n
 TGyy+WVG3g5FGcQ2Mo/aT+WzSZ4ubP9PRCFgy43no3Luzcgk03ctEVNVYlNySLlUziGm/7
 Hj1896jdotC/cDLtiFfo3mqOA8MKUWXlANKDB402INPluUCU4pBeYIXIjsVTSRz81yTpPV
 puPRrzHt2Np68Y6ZtR3KXq2pspLjxIdVYAQRVdPKTmzb39kByzZpGpGznWJmeVjMQ52vly
 mVptuN7FdlvMVwUnikwIdHQOh70yJBg6DxNhPsKgmNoBehM9zQf4UcqWVGpy7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=9lrfYQOjBLc4A4bdNI3q067UC3zgV7RvLSKSwlIZbvs=;
 b=917I6BQewXTYuvHUiFV78h3zo+5gExjYKDpwRdFFNRLr+5CByEAjFaCbeb7yNkpwliOwXp
 j1tEpmOjASAtV0mkeEQdtzYHZgQYx8lX6yI9gUkiErpdKxkcSA6eqF+vP/ZZWxGVEErnx0
 R2pBhrZJjrXr2HZqpkz6SCikeIb6fG2SloNboIZPGf8fewVVNRdStcU6Vv42qGIfUOlXYS
 0b9Yd3BLK3UTI1h2Ze4zrtP6BDdu+PdZ6YOd0XgNgFjbkdD6szP/lhW5xcplOZhIPLP+IA
 XCL0Iwr3ZRe8hZR5KsKgbAxa0tp23HVSNjkAykM6yakp6CHSATmUKHFuirJ1vw==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-psfpx;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Daffy-Glossy: 48303ec6796758cb_1710865172293_833756396
X-MC-Loop-Signature: 1710865172293:1831431793
X-MC-Ingress-Time: 1710865172292
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.164.55 (trex/6.9.2); Tue, 19 Mar 2024 16:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865134; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=RPI4K40CiDfZF4JqWIe0KIGDBPNVmywBXzP9Bb6FlQn2gHkXrMVPea9WBBy+q/7g0VHstOzsM8B2e
 eaqE6pvcE1jTO1RAoitg4frta2/hpZqhJ5kerizPGdT3r3k7lBa5GI0jduw/XSeIBUYt9jxjCs3s4G
 2yxEcV3weAEArb5tdgoDbCkBcyb1VO2Lton36+gIqMJETPLgn40DmFWu/pVm6KvGhP6DWmDX9ANSzI
 jW1OpP4JLWFuNnQxMdu3HclDUuH2B9+wrRXlwZikxUrn+6DbiQt1KtTVCYHxXcs3qKgB+v0R+Uvnou
 gKWxzPIpt5lcLbmjzrkRLFxjV/oI7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=9lrfYQOjBLc4A4bdNI3q067UC3zgV7RvLSKSwlIZbvs=;
 b=nacUtgdoifCk+mkLbVM6o2WQ2A4r722YyP0FgzyYNNWbkUbER7cqQPPav0EkeIBnUU+q7Va486wH5
 9ECpdNrJJXblrloqS5inBdr2CUkWYThWrc/4aWOVE2A4t48q0GLRUJ+dLk8odw0VQ5NKqxSmesyKec
 +NVNf+OcYK1lMgR+8PayIYUv1+LPhieLw7ZsCbFbBCAaVfqb6sEb5FsWOiGcMs1Par11UUP2Ixdt2c
 iXvtrW8jIXcmSbx71De/a5M5TtRxXK5fulgTrRWqUmFqzgCodONqHpZF2+6kE36QBDhz3pnXOwghlt
 6FPIatcDtO490pUI5HUOdqOB6VXEwAg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=fRTK5nxy; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=9lrfYQOjBLc4A4bdNI3q067UC3zgV7RvLSKSwlIZbvs=;
 b=lkOLHdJN5ObwMRLT/o42j28cYt1WeqExTYA8Yn/DwYVNjskA77VUBLstVPvjjBcjQlX0zU9KkCXwN
 XfbGdiCMIN+u42fWWAgOYjxmE0vvAOa6QpWW6pglNH2qiDdzR2Z5ZOb1MUHp3D+y7GHPa6qtluN8JY
 EanFORB/URO/NBb0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=9lrfYQOjBLc4A4bdNI3q067UC3zgV7RvLSKSwlIZbvs=;
 b=qfZzjyRduVMBTaWv6Urfs8pNSUWOLUqC09arUahMJbTNHeSG3nwhSaM5CvrAqxXV7dgUx8y4xasdQ
 ifEli6/FDS4hmqSizdyK/YcDm6qbGZWJJdY6TIf6H2NFTKgURE1HB8cU2N/RtOuLg+hO+bT0u5v9GM
 5YMCgCa5rk00gBepSrZ822hmwB50TrcBcLHC2AehoYFp9VhkQQK8pt0qnxcpIsUn4acCjEl+8AJMKw
 I1Yh3Gs9d2rLQTvK3J7SVQXljn085w2q6c5HIh0x45sIVR+8fbTo6/0MiqDlsLmWBIrJLOyol6s9D0
 vuZ+ZT7sIi/qMESPpQquWXgbLR8VG8A==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 5fa5241e-e60c-11ee-b1e6-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 5fa5241e-e60c-11ee-b1e6-eda7e384987e;
 Tue, 19 Mar 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9lrfYQOjBLc4A4bdNI3q067UC3zgV7RvLSKSwlIZbvs=; b=fRTK5nxyph0f1JpLAdWSSa1cQR
 hGyQzHLPzggWXGquTpQBWe+5ORwF3gGl0sgWHyKNlHb5hNjRH6HGYbg220vxy7U2agyS9zpDCPBoZ
 L2nT3rNdOKUnsFv5PBJl2kpohFi5ZB3lkULE8mPjCixWdhRg7YRRDnmfTeaG+qBpj0dSMrXcH4M2k
 8Et0tGUnMbGiN1WnkkDFpxwCTkPU6IYHcEIY2GjRCRY0/TAZpIm+g7Hf8Fqax56/DywduSN7oRjhA
 kW7GUKnNjMzyUdFjdX5hrr1SmgkC94eEan5uY17SHq7V7OGNM+QIAYlaCL76MbCv+F4JsUro7ivFc
 Qd07zzCA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBQ-004VVI-1I;
 Tue, 19 Mar 2024 17:19:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 3/6] target/hppa: fix access_id check
Date: Tue, 19 Mar 2024 17:19:18 +0100
Message-ID: <20240319161921.487080-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
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

PA2.0 provides 8 instead of 4 PID registers.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/mem_helper.c | 59 +++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 80f51e753f..f89ba91b20 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -152,6 +152,49 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
     return ent;
 }
 
+#define ACCESS_ID_MASK 0xffff
+
+/* Return the set of protections allowed by a PID match. */
+static int match_prot_id_1(uint32_t access_id, uint32_t prot_id)
+{
+    if (((access_id ^ (prot_id >> 1)) & ACCESS_ID_MASK) == 0) {
+            return (prot_id & 1
+                    ? PROT_EXEC | PROT_READ
+                    : PROT_EXEC | PROT_READ | PROT_WRITE);
+    }
+    return 0;
+}
+
+static int match_prot_id32(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
+static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
+{
+    int r, i;
+
+    for (i = CR_PID1; i <= CR_PID4; ++i) {
+        r = match_prot_id_1(access_id, env->cr[i]);
+        if (r) {
+            return r;
+        }
+        r = match_prot_id_1(access_id, env->cr[i] >> 32);
+        if (r) {
+            return r;
+        }
+    }
+    return 0;
+}
+
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
                               HPPATLBEntry **tlb_entry)
@@ -226,16 +269,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
-        /* If bits [31:1] match, and bit 0 is set, suppress write.  */
-        int match = ent->access_id * 2 + 1;
-
-        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
-            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
-            prot &= PAGE_READ | PAGE_EXEC;
-            if (type == PAGE_WRITE) {
-                ret = EXCP_DMPI;
-                goto egress;
-            }
+        int access_prot = (hppa_is_pa20(env)
+                           ? match_prot_id64(env, ent->access_id)
+                           : match_prot_id32(env, ent->access_id));
+        if (prot & ~access_prot) {
+            ret = type & PAGE_EXEC ? EXCP_IMP : EXCP_DMPI;
+            goto egress;
         }
     }
 
-- 
2.43.2



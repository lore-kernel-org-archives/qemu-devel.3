Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D78C54E71
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymg-0003fp-LH; Sun, 17 Mar 2024 18:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymK-0003cV-FE
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:56 -0400
Received: from cat.pear.relay.mailchannels.net ([23.83.216.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymG-0005lT-IT
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:52 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 3B92A415B1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:47 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9573A41584
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713686; a=rsa-sha256;
 cv=pass;
 b=y94h/bsFgqTQo/XjUHjpol0+aJxD9upa/PJxo8AClB6nETbunFRs2cU6s4CvGRepUwl0/x
 y5gxMj/33wi/JhjZPTXbyGDAMXIrvLHCMCT6XneUVW9RQpm/fe3qhIoKAuwCR0isV292Jc
 AWMKIBQ6oBICmImc8RfC6JojV4pdSErTSY4eAmbhRYs7VNGrwTRM2yH+qArGbQrp2zp8Mb
 xlk+/iC3Xn+hLJFMcyvB2Ng6vjl1fdjzT7mYnsdMZQdDlmcVSrDIt8gyQQU8sv4OzGrklw
 iVW09eazGRK3KOROIG7lXgf8jZB4bHnzOU+1SDnbgVwnEqBjVOrKX0Sls/r1mg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=sbLMLwbVtU5SxLDFLePP1tB9lob7A4Zj3o5kCDF/4vI=;
 b=hCFEbBKTqOqXcVg/zgUIW3Cf2RRgJ6r7ve792r0ht26VIqOGcvrl3SgCaNXj3hUD9E6AYJ
 gSVjNqgRLA+3+KDpVvK6izILu/DTfGRnzCrEzfOfwr9fbmI2ndlgVi4CzUPBjObzczkSb1
 ngw1/L4Cmqzj0zTvFoDwWPkNXJn9SBwjGt+HBnKzDxizpILqrTIFQnyU4hXB5a+2IEEhWV
 9nTL957BEwtXrl6WnKzysZ9bkERMtzdjqqzOcP4xEUWE7XWusFgwwREbcvXzIJAa9J9cyL
 5ZdxnckSAkOD2blW2C+m42ztpx7tiakRWbVdL6ZiVHSzwMnf04qoV1zb1UEEYw==
ARC-Authentication-Results: i=2; rspamd-b46fcdc5-6n9vx;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Language-Juvenile: 2e773bb8145a247d_1710713687114_54642100
X-MC-Loop-Signature: 1710713687114:828709202
X-MC-Ingress-Time: 1710713687114
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.173.87 (trex/6.9.2); Sun, 17 Mar 2024 22:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713571; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=MEsQ+4K51icQps/1tL0+MP5aLiitm7xSjBDifkc4ddAvMEa/xiEcWEamfgs6PvUa5RB+U3W1zhdfo
 0/apG9XBn94ONaTFRuRg6RtcwTl+VwBXH0JFtQuejitmoyu3UxL4wdQw/JBrE7ZCg81qt7lYps6np5
 IJmhi7ja7UQpD1rdoXjcCzRHF+wdct8V8KEgwGwQu6VuKhzGKcPeo0qAUvYzRY4oDfWHOmPJZPZNWn
 jtfooiNul4XHyjFnL5402IIrax4JApuQ1N+HZ+u2gSnXjOcb0les4ECPSn/046LFKPlIzvQ/kedyC6
 IJdQde0qZdN7/iw6bXIok124OkioP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=sbLMLwbVtU5SxLDFLePP1tB9lob7A4Zj3o5kCDF/4vI=;
 b=UUQvP5tjvzf5iOmmk1Y2Vg/Sow+YTLtuw6rnOeEQAi5dcdkGx5anI7w5RzVD4AIIrljtpTPoEsmnd
 F9j6mcKmLJFa9lUATXHkdUFGcbjALgwyU+KuwylrysPXVa64VJF9sZRQtvJwR+nYH+sM4RM/CP8Xnb
 2ptdTD4DvO4xrQa46fITnJayFRQ2hY9cq7jjlFwsLAz5y10yyXwFaSqNdn09qGYs9Plo8kPokN9Kka
 dYl6DVbE4YobX8ik6+S3F9NN9IAIXeLosAbrjFz1pk9RdXSBHZoDPTu35Ndbv61znnHpUMdt7szctO
 pqty4kfCnwwxJPE7N6C9BnLMig6v9nw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=js6PGY+8; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=sbLMLwbVtU5SxLDFLePP1tB9lob7A4Zj3o5kCDF/4vI=;
 b=GgvqwmGLc0kM0FUpbr2grZov29I+99pixGbn5Psvy3KA1bQoGntNRM1LBhs3T+4PoIytI09a8X0Da
 Wc+rFdktjZlPHVi1yL22mTsWkIdQhdrzZvYb3u0X5cqq/zBjnzbVdbGJ6PHVgSaZoKNPKeC/9R53I8
 TBOnxJULBdCWN9Zk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=sbLMLwbVtU5SxLDFLePP1tB9lob7A4Zj3o5kCDF/4vI=;
 b=ql9emCSKTWYxleNpmS68VS27+OddQ0r4asBu8d8P/0IpM4+r5QV0J1QedqBhd8T4RrXmmHMFLMfjm
 03GRFyF5D8/OJQqTixvV9L68PKfcfIjRuq+CmMXywNkBCdUg1mxtFAtrfRdFMep6K+SlIqcAeJWuEw
 J4e9q8yHvbRdCCXbLDwN7hR8wkf+jvQlp0zhuprFjVydCLGmLNGrC5YoXr7QBOC2j2IIz4gJTcbf/a
 09fahFwU1YtByIBaUguUutVoqFkuHQkgjkUfpbUSRuZQLXO6+XSB+dYhqKu37Z4Rxbft1U/YZu9vEQ
 5h/mknGhUVBBSf3Z+lPK38zhMt89+UA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 7d32ccde-e4ab-11ee-b7ba-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 7d32ccde-e4ab-11ee-b7ba-9b9d9be6ef2c;
 Sun, 17 Mar 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sbLMLwbVtU5SxLDFLePP1tB9lob7A4Zj3o5kCDF/4vI=; b=js6PGY+8/lMlFdbhRdjvEncF8J
 4k3CeUTqJCs59Yp5weSN9w3+N+poG5Slc+0WNsrGvQQcFXJkhDCYlNIH02eM5vGm7rPIbaRmVqUMt
 Pr69zEZVPfyyctaPbAVHwJ5creEiuIASV5kPYo/pll0IOMWolcahMhl3q59DWlXhKLtSG1CE7l/Mo
 X0mazz3YlDe07vp5i/YN0lxcPp/X0pCtX654g/mjV67bW5D+l4yUnfvADehrYBMzfFkPzO3jtn5st
 sF6cmd3NYiLunTbIW0JLc86F64dPjFsOPvrN5JeG7liolgmEQRQ1Tsr0NFrtpnZm+aXmIBTGZEYVN
 ntIrVLTQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym5-004C3C-2J;
 Sun, 17 Mar 2024 23:14:37 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/7] target/hppa: fix access_id check
Date: Sun, 17 Mar 2024 23:14:27 +0100
Message-ID: <20240317221431.251515-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.31; envelope-from=svens@stackframe.org;
 helo=cat.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 roms/SLOF                |  2 +-
 target/hppa/mem_helper.c | 67 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/roms/SLOF b/roms/SLOF
index 3a259df244..6b6c16b4b4 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
+Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 80f51e753f..e4e3f6cdbe 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -152,6 +152,59 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAState *env)
     return ent;
 }
 
+static uint32_t get_pid(CPUHPPAState *env, int num)
+{
+    const struct pid_map {
+        int reg;
+        bool shift;
+    } *pid;
+
+    const struct pid_map pids64[] = {
+        { .reg = 8,  .shift = true  },
+        { .reg = 8,  .shift = false },
+        { .reg = 9,  .shift = true  },
+        { .reg = 9,  .shift = false },
+        { .reg = 12, .shift = true  },
+        { .reg = 12, .shift = false },
+        { .reg = 13, .shift = true  },
+        { .reg = 13, .shift = false }
+    };
+
+    const struct pid_map pids32[] = {
+        { .reg = 8,  .shift = false  },
+        { .reg = 9,  .shift = false  },
+        { .reg = 12, .shift = false  },
+        { .reg = 13, .shift = false  },
+    };
+
+    if (hppa_is_pa20(env)) {
+        pid = pids64 + num;
+    } else {
+        pid = pids32 + num;
+    }
+    uint64_t cr = env->cr[pid->reg];
+    if (pid->shift) {
+        cr >>= 32;
+    } else {
+        cr &= 0xffffffff;
+    }
+    return cr;
+}
+
+#define ACCESS_ID_MASK 0xffff
+
+static bool match_prot_id(CPUHPPAState *env, uint32_t access_id, uint32_t *_pid)
+{
+    for (int i = 0; i < 8; i++) {
+        uint32_t pid = get_pid(env, i);
+        if ((access_id & ACCESS_ID_MASK) == ((pid >> 1) & ACCESS_ID_MASK)) {
+            *_pid = pid;
+            return true;
+        }
+    }
+    return false;
+}
+
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot,
                               HPPATLBEntry **tlb_entry)
@@ -227,15 +280,13 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         /* If bits [31:1] match, and bit 0 is set, suppress write.  */
-        int match = ent->access_id * 2 + 1;
-
-        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
-            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
-            prot &= PAGE_READ | PAGE_EXEC;
-            if (type == PAGE_WRITE) {
-                ret = EXCP_DMPI;
-                goto egress;
+        uint32_t pid;
+        if (match_prot_id(env, ent->access_id, &pid)) {
+            if ((pid & 1) && (prot & PROT_WRITE)) {
+                prot &= ~PROT_WRITE;
             }
+        } else {
+            prot = 0;
         }
     }
 
-- 
2.43.2



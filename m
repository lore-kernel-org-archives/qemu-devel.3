Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F845CFA754
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fm-0002Cm-ER; Sat, 05 Oct 2024 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fc-00028U-Pa
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fa-0002PO-OM
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b7463dd89so33893355ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141968; x=1728746768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KXMhwqlNY3FEn9X64ijA0SceY+BOiTFnpHj8/s1p5o=;
 b=zdimwVRYWcrIaLfcLOKxZT00xtHrk3o0XVhS6YCFHYYDBTLIo0fR3+ea+23xfyzIsO
 Zlmt/fGjbTjpXyBTMlONglp50UE7V3LsRVei1PGtVMHoTQ/7u0uy7hxzH2lilQocTGJK
 b7QQj+FsF9V69x/wRAOQBCmxNR3Kb0ncT08qJy6hiEgqOI8qLAUAd9kXCBjP//QvJVSK
 6OLtYvo1aBVFi4dI1goDzMuFqhoE2HC1Hz64l/I/B0Er+tOC5tn2twDUq/KdA4/quES1
 Nt6hFRC3FGP2AIEWf6msV0pGhHPakg4/jAthyvRdgJL8bKks2Qyp+ZGyslCkLNnMOlpQ
 fqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141968; x=1728746768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KXMhwqlNY3FEn9X64ijA0SceY+BOiTFnpHj8/s1p5o=;
 b=NJJ8EnKTiVtacegRw6JO9BNqN3hVXdMqNongnbFQ7R+DmapnuV7VnqWIQqMf17XDMY
 WYUfy6Y6OCn+CcuXUvYQL8Y1iolgE0JYHJVH2+taJK21h4ASVaYYjyfOecZ69xqlJ4Qr
 Rwykj0tueWXaMfQIxAl+hsF1fv15diKrLnmD7L2+3le99GRovA1C/JEWabis7eykWN8K
 4krmk7j3lh1J5EdrDtNv6kJlCuC0r1lhdj12zS6f+Px9X6HiTj4F7vBJOisLBkvixSb1
 K7maPOTc5JBEckTcF8E5swEQkEf5Rb+a6q/mSp5hfmDGEV29cGN0klWfdxZ0iNQ0UmL1
 sE3Q==
X-Gm-Message-State: AOJu0YxwLA2Z+dfwWZzDpoeVd0QpLDXRyg81SMgyGIaPFJ7PFscv0ged
 F9/zo5KrTcITs3jIK5l84GfLEgakth59QhUqS+AtVlLOtjuUsqrfR0afku0T01ik00ZQUoP752a
 l
X-Google-Smtp-Source: AGHT+IHoXvMFOA7jUAYxgFVahS1q2i1bg/ajDF/sY9Oymkr8mht01U8RsKNrUl4cngSkkvOkcrfljQ==
X-Received: by 2002:a17:902:fc4e:b0:202:4666:f018 with SMTP id
 d9443c01a7336-20bfdfd2693mr105297675ad.15.1728141968397; 
 Sat, 05 Oct 2024 08:26:08 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 16/20] target/arm: Pass MemOp to get_phys_addr_nogpc
Date: Sat,  5 Oct 2024 08:25:47 -0700
Message-ID: <20241005152551.307923-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zero is the safe do-nothing value for callers to use.
Pass the value through from get_phys_addr_gpc and
get_phys_addr_with_space_nogpc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e92537d8f2..0445c3ccf3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -75,7 +75,7 @@ typedef struct S1Translate {
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                 vaddr address,
-                                MMUAccessType access_type,
+                                MMUAccessType access_type, MemOp memop,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
@@ -3313,7 +3313,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_nogpc(env, ptw, address, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, address, access_type, 0, result, fi);
 
     /* If S1 fails, return early.  */
     if (ret) {
@@ -3339,7 +3339,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, 0, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
@@ -3406,7 +3406,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       vaddr address,
-                                      MMUAccessType access_type,
+                                      MMUAccessType access_type, MemOp memop,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
 {
@@ -3547,7 +3547,8 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
-    if (get_phys_addr_nogpc(env, ptw, address, access_type, result, fi)) {
+    if (get_phys_addr_nogpc(env, ptw, address, access_type,
+                            memop, result, fi)) {
         return true;
     }
     if (!granule_protection_check(env, result->f.phys_addr,
@@ -3568,7 +3569,8 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
         .in_mmu_idx = mmu_idx,
         .in_space = space,
     };
-    return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_nogpc(env, &ptw, address, access_type,
+                               memop, result, fi);
 }
 
 bool get_phys_addr(CPUARMState *env, vaddr address,
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C45CF042B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKRQ-0003EX-3X; Tue, 08 Oct 2024 20:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKRO-0003EB-EV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:20:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKRM-0004gJ-SC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:20:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b86298710so53360745ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728433231; x=1729038031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7jWpw5t/HpgELLkVMHDaBFNA3kqtZY785Yo0kKJfFd0=;
 b=Gcy4pvUtAXRtcl5CpazRmpDQ/CcINj8lMpNqPczzG5yhWK7/NqFSY5Fg6ZbvCSjBKy
 GwQ43VXtMkL7Wi0dpmygXhdpdwYFaHKGVvwhMJw2k+U7W56T0HVgUAg+5WM0BpAXK3fo
 oPRYTqc7ACKJbEHcg3Hx8i9g4HCC66T/xCeooxtsDtxnFxMHefWUEwlN15IdXABUvnlz
 Jay+uNkVl7UEvLvt4j2skPUft9G2fubrV3Yrsi4BICm2qZc/o3CaSE5QpvS7Sw2MQMip
 g4Rm0daHCiZYfca1zpHBmaXBp5yS+Om/M+9ll1N09yvolI4b+gV1UnCQynd3mbX2189u
 /IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728433231; x=1729038031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jWpw5t/HpgELLkVMHDaBFNA3kqtZY785Yo0kKJfFd0=;
 b=Q99lFgAZn/01kkI7eU435WLsLZ9cdGpuo7Ucbtw0I7sSYw+1R+9srlV9o4xWekKU1E
 Wb7DZnsC0qSrqGQyAX+Vvf3ftACPOy/wMwlvyU3OixVPr6g4YWjISYvI/98PhCdhvoWp
 VAPiwwvYmTB0U13iDJgd8rTOJioi3u8iNlt5NswM8nz+CJbibxsQJTnhgDoMKw1dV/kZ
 OrgG5LuLu4du0atXtCz2yBAGnuxnqAT59Qb2DvOmZyLKIp2byZrSDSoxcmn7fyl5r74s
 u8cHjS7SHTsbXa9q/TG52wYIzqFjj+x9gVwn3BnckX5jaPmuB6SstuRt2U8qXFpomxXG
 dUXQ==
X-Gm-Message-State: AOJu0YwqZt2YkVUFc1YY58AHvKiF423h+G4poUyKASTS3Q7lPo0jrlwC
 pCLilDk2ZqZ58JvexfyON5i8GkbBc6TH4nzWQi0dSbHp//9z4r+dqCUaq6xxI8cpg0ZUMHeDmQj
 I
X-Google-Smtp-Source: AGHT+IF5czlEotMcgl2ioDjPJb73S6na1Lx36N2IvW9UmHftaU5bwbqvJqIAFsI+a9EyHKe0uU9/WQ==
X-Received: by 2002:a17:902:e84b:b0:20b:9d96:622c with SMTP id
 d9443c01a7336-20c636eb67bmr11202805ad.8.1728433231030; 
 Tue, 08 Oct 2024 17:20:31 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1395a2b6sm60330365ad.205.2024.10.08.17.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:20:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: Use probe_access_full_mmu in ptw_translate
Date: Tue,  8 Oct 2024 17:20:29 -0700
Message-ID: <20241009002029.317490-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The probe_access_full_mmu function was designed for this purpose,
and does not report the memory operation event to plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..8f4dc08535 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -62,12 +62,11 @@ typedef struct PTETranslate {
 
 static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
-    CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
+    flags = probe_access_full_mmu(inout->env, addr, 0, MMU_DATA_STORE,
+                                  inout->ptw_idx, &inout->haddr, NULL);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -429,9 +428,8 @@ do_check_protect_pse36:
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
 
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
+        flags = probe_access_full_mmu(env, paddr, 0, access_type,
+                                      MMU_NESTED_IDX, &pte_trans.haddr, &full);
         if (unlikely(flags & TLB_INVALID_MASK)) {
             *err = (TranslateFault){
                 .error_code = env->error_code,
-- 
2.43.0



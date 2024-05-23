Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E652C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHaM-0005qt-AC; Thu, 23 May 2024 19:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZv-0003v1-4U; Thu, 23 May 2024 19:10:31 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZh-00065n-Fp; Thu, 23 May 2024 19:10:29 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7e2188592c2so318341139f.0; 
 Thu, 23 May 2024 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505813; x=1717110613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X63trXzm2Cwz8JysN9U2EZLCXiSRFKXHL3fvD7Vw2k=;
 b=RqkkBZZAunT5Abe8NiLeSAObdu5dPkWLFkLqIRglJFcsmjI+GDzXG12To3Tpo2HBhh
 IjEbwPaV70mlLuCwhPNxDpbkiDUmTpDp+/1TkKJlWzgnY/HDzVyS5y5HCb9j407SvWyk
 r84GGSCLvstVTK7Pzo9vE8WWAhMnVLKTO+MGXCxLzTKXwMIkYrxT9TiGPI4Xk4dtm4Ma
 1Sqly4CD3oWKSjkWnwGA+FDhk0x/CGTx3/S0bZmAt1bM65OgdVdFkkK6x4VruM3m4wbd
 8r1uK/0th3JvoakrrQyHgX4KC/cwxJmYACROsZvNjc4RLQJvhKEkBqhIzjRNvq/K6WQG
 fljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505813; x=1717110613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X63trXzm2Cwz8JysN9U2EZLCXiSRFKXHL3fvD7Vw2k=;
 b=s4QQrqHDtx62gKunCKEBHLW3Z35HFyuk1DeQ1QYSrB42hprBut2l93bGH6ImqXvQsQ
 oWxfX9bhruJGJA7mroskaaioORO5HSIws1WOnJZx4ggoYY+E35yzvMRl/1TP9UhClZdJ
 WpBVH5YzGfP6q+/BPRzi55qRSsEJ9mydFEMHmYT/e7GuZYx15cp77kc8+dpYTsNpjNGY
 SqTSDajBHvgHf+et9hn6UDcWIvvDvi8Z3BL/C4S8E+aiajTk2w/id3hPS19zOgfP4FH5
 KJ2enjPFswoiyynk6PLNMU10+E9mdYcKABLDSdD0gSHBKzx1g7wLzOW1Iv85hIOM9vCH
 Ne6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzoNwMHjeXPPLt+Q2jHVENQa4adE0Yl9Ad2jsqc5cZw3ccIY/sD8DjYo2crDUO2TfYprapo6S9kITpcvv36Pzvwxvd
X-Gm-Message-State: AOJu0Yx/Zkq9qmgbjaTvrgdXZJ+zHmuiBXKSn0N5By6NqCMB/o30eVq+
 dXlGilkg2Hs6Ncaxi9rV/Zf7XjLC3tXbM8/jF8oPIvwZLNKATbW0pP206g==
X-Google-Smtp-Source: AGHT+IGxrPy+Bj/fLXByaz1IdUpYRgvkxjkoinYwliPcvMScdJHxOlg3qi50WGfjSxlVTutVVASgBg==
X-Received: by 2002:a5e:d60b:0:b0:7da:cbc2:7caa with SMTP id
 ca18e2360f4ac-7e8c54c78fdmr87884539f.9.1716505813218; 
 Thu, 23 May 2024 16:10:13 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 44/72] target/ppc/mmu_common.c: Drop cases for unimplemented
 MPC8xx MMU
Date: Fri, 24 May 2024 09:07:17 +1000
Message-ID: <20240523230747.45703-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Drop MPC8xx cases from get_physical_address_wtlb() and ppc_jumbo_xlate().
The default case would still catch this and abort the same way and
there is still a warning about it in ppc_tlb_invalidate_all() which is
called in ppc_cpu_reset_hold() so likely we never get here but to make
sure add a case to ppc_xlate() to the same effect.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 886fb6a657..3391df61cb 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1219,10 +1219,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         ret = mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
                                                mmu_idx);
         break;
-    case POWERPC_MMU_MPC8xx:
-        /* XXX: TODO */
-        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n");
-        break;
     case POWERPC_MMU_REAL:
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
@@ -1353,8 +1349,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_BOOKE_DEAR] = eaddr;
                     env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
                     break;
-                case POWERPC_MMU_MPC8xx:
-                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_REAL:
                     cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
@@ -1427,9 +1421,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                         env->spr[SPR_40x_ESR] = 0x00000000;
                     }
                     break;
-                case POWERPC_MMU_MPC8xx:
-                    /* XXX: TODO */
-                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
                     /* fall through */
@@ -1539,7 +1530,8 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_32B:
         return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
-
+    case POWERPC_MMU_MPC8xx:
+        cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
         return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
-- 
2.43.0



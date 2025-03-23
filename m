Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBABC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGX-0005q2-L7; Sun, 23 Mar 2025 13:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGU-0005ny-DU
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGQ-0002sf-11
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso49156715ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751453; x=1743356253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n93sFLgifoxtvFypKbIjFGlyxMVTs87sLBcre3AkoOA=;
 b=QFKBLjBA1GmjGyL/FyySb+Ovt4VGhMGaeU/ugLvwOsydq+W1T7jTdbci9Ro4pxZCm0
 TFOV3AIPiJrNjwdGx260fPVKVy31xv5bG+69vsXlCGJai0Jt9/Fd13JB7QEI3wb03qs8
 tOgmSCL3cAvOYukFz2YJmFGK/a8T96hLWwjHOgvDzEaM6OFA/vPmEOZTVasY5h6q/jaQ
 L8mBfIH2qP0Ol3fK58LLrtEtckddQXOetG2VnFI3re77PPp8xjz1u2Fun6p4kDZq7Hou
 Mxy8agNE51jSo07zIQSBv05HyRDyhOW4otHYnsYilmcIO73wH+poS3HkPcSAjfLIdf87
 TPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751453; x=1743356253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n93sFLgifoxtvFypKbIjFGlyxMVTs87sLBcre3AkoOA=;
 b=LQkPSyxv0xpELFSHNo6c+XFuUYa1lzqFomdndpzUUMDqn/L0UPz4bfOPv/jh0MmOjZ
 gOM+ERjhWvt7AadOrxsDhdNb593sow/wXwf4C+E0MwtqiJqOPnD4ZZzy3YHY1f4g35tt
 Zajp11RlyXWnPMHP6XerjSLB4HFRG234PETkxTZEpbXim5C9xW9LGFLgoZ/mbdEMl851
 AypABIu2PSs6i9J7X1HuzWylJEvXhICSBnpEHYzpg3KF8/6vESWDYH67bL2y7ahAPj1f
 JCVkchULE3h/e0AP4DXPbNIYvQ7eUCwiT/ZdKbgr6cZ/5zvA2xbqdVnBzJhX2cLcCe2t
 8dxg==
X-Gm-Message-State: AOJu0YwKTpkxdzR3jai4C1VxZIR1R2sMnJtjkvknZlVeixWuKDGHGJk8
 NTWUU29lY2oNOT47jL0mxYKJAM6P0q4jjqmQEYn74IFZnqSg4z2hGVoBJKKLzPonsl5S8/0fROe
 /
X-Gm-Gg: ASbGncsd8JBMnCTKhVQ1AXuA6A461MyVLxo9+Xy5L4fuoAr3EGXPlwa0FUTmU+0RC1T
 PYRlDmZHWw1Kn5oXkByAjzyrJ1xtNxK9JD0cZEgFoNPoHmHu1Ax3HK3a32p4YgrZKc/kuz7SQ7B
 wQ3T4bjb+zgyWFGAekY1MoJYDf18Ezp6DrXkGfwxElYAukv0nKEIBdlSjXko1BqxaesBioZYeqC
 riXMAFcGxaQpPHFbcYPZhBbbMhro/NRqpyzBWRTQxdaxtT/GLt5PaCTTAw9/Yo5Rut5oU1frPb3
 WeQSEAiTs2pWjuR2wiJixBJ9moUjgr54ivzkRiXPRf3uJGVJJZYAaGA3mlf+lbtrTkbpV2fmaki
 Z
X-Google-Smtp-Source: AGHT+IFeL7hfN2mvzRSrDxwvc2HFDLEUkB74qmg6B7Zgf/1gvOLDdKv22Gb/Z3AHuIG15AxxS16TKw==
X-Received: by 2002:a17:902:e84f:b0:223:f639:69df with SMTP id
 d9443c01a7336-22780e15275mr165077675ad.41.1742751452680; 
 Sun, 23 Mar 2025 10:37:32 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH 02/17] target/avr: Fix buffer read in avr_print_insn
Date: Sun, 23 Mar 2025 10:37:14 -0700
Message-ID: <20250323173730.3213964-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not unconditionally attempt to read 4 bytes, as there
may only be 2 bytes remaining in the translator cache.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/disas.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/avr/disas.c b/target/avr/disas.c
index b7689e8d7c..d341030174 100644
--- a/target/avr/disas.c
+++ b/target/avr/disas.c
@@ -68,28 +68,35 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
 
 int avr_print_insn(bfd_vma addr, disassemble_info *info)
 {
-    DisasContext ctx;
+    DisasContext ctx = { info };
     DisasContext *pctx = &ctx;
     bfd_byte buffer[4];
     uint16_t insn;
     int status;
 
-    ctx.info = info;
-
-    status = info->read_memory_func(addr, buffer, 4, info);
+    status = info->read_memory_func(addr, buffer, 2, info);
     if (status != 0) {
         info->memory_error_func(status, addr, info);
         return -1;
     }
     insn = bfd_getl16(buffer);
-    ctx.next_word = bfd_getl16(buffer + 2);
-    ctx.next_word_used = false;
+
+    status = info->read_memory_func(addr + 2, buffer + 2, 2, info);
+    if (status == 0) {
+        ctx.next_word = bfd_getl16(buffer + 2);
+    }
 
     if (!decode_insn(&ctx, insn)) {
         output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
     }
 
-    return ctx.next_word_used ? 4 : 2;
+    if (!ctx.next_word_used) {
+        return 2;
+    } else if (status == 0) {
+        return 4;
+    }
+    info->memory_error_func(status, addr + 2, info);
+    return -1;
 }
 
 
-- 
2.43.0



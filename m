Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF1C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pb-0002I9-MS; Mon, 17 Feb 2025 14:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ow-0001uZ-B2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ou-0008MY-M8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221206dbd7eso26586585ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820619; x=1740425419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=neJJdwk4UPYsY3t45/cP8QwB2AF+ECfpIH9S+ZN5wQgVOLiH3pkLP34hgVBRinnc2f
 gz+7r3cz6fGRhIuIqD/TWV0/GwMaK50aVBECCCZ5ZKw+CV+DWRvDrewq57nF1oGd7FF2
 kyQDcX6WbKjbgb4DjY7GIJQtQTL6y1Pwp6y4qRH8Pyw2Ho9djH+iAU5UHnJJF+4mSdWk
 9t9beeu2zvzn0OiobjZAxn+VY8KZnRA/Yc75Dgj9dNZW3sC2UFpxXbqFsxlHpJJUl6L5
 7E/0m+j2p+VGNBH/TElpyOWvbAlY1kKWjtnQufTUsfLK0EyzjPcKDhC/FtxqglqaeSVj
 rPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820619; x=1740425419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2WH4FlAMIZ4FEc2EEi85vRc1c0fQFd97dzVfYF6JEw=;
 b=iJCQy/+MZ3GYTgQUB41CjDQqVv0n36nRmw56wONTQg/sBRSaq21wjlgWwvKCVjOhoO
 y0fa+8muPDKNhmSHV1/pfyQG6aIyro6oGDmjyKAsK/wZxj9Kg4a8cKEtQsLFfrZgxa6O
 AIEYaJMdgwQcZKWdM4Q+irEDWuLmJzN4y0+9sX9sjgOyRXxRClyb425RFasr1y9Aesyb
 eHl9riqW6j0P/qCQY4MYHSdaRFwTaEkdlOkvcaTwnqswgq2gRxdGQAkGfYSzPKrMTPoa
 ENETNTm/QZV7d4elyn5hlcg/FAbEz0EgYpu0y+x9rPqur48Wd3WnY/p39/iSPSV8TJcN
 4sqg==
X-Gm-Message-State: AOJu0YwOeJN5CUiovt2QYIdEqSv3ncCSb5aDmb5X2Z+SHD1mMDotFYq8
 eYdB5QJmixrbkbUelOH1QVuUHzZvELsWVeoFqgF0qUoIjgu8EhW8A1HgM6o5E78P+q31wpmHgA1
 q
X-Gm-Gg: ASbGncurA6RJ2YUpOFiVeUhbh5p6/uVo7CIrq4ryytQ8yVXdX74nMdtvuY98X0l8qxU
 edZU4LLZnVatIAZ+cJBAfAc7fcYT8uzk4pbOfWUAUe/l6jRiKjYFX/BftfneemVjfXi16TjEzaA
 3XJ1HDrploqTgWfk/1h+hBs7cK5SO4v63zfkYhbMG4uz4m66WISZ8vAaqV8c7K5hzcISDGoJvyC
 xWwrWbElW6LcZRmePuJy3M7xFh55wCguWB0hV+f0dEMkslERY57MSV//jtxV6gU4hkCDytnutuA
 yKMc2/iIITDClGHMzTQWtCHf6RQ2gRDL5mVkmBBZ4+Y/1Cc=
X-Google-Smtp-Source: AGHT+IGNDsAlWok9C/CMHiwXzRn2ZIVl3zZf9cKF+amhuQnuo+wGYnSD/i23zgeb6BRsICgXXHGtpw==
X-Received: by 2002:a05:6a20:9145:b0:1ee:c1b2:76c8 with SMTP id
 adf61e73a8af0-1eec1b277fcmr2181528637.37.1739820618829; 
 Mon, 17 Feb 2025 11:30:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/27] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
Date: Mon, 17 Feb 2025 11:29:52 -0800
Message-ID: <20250217193009.2873875-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The declarations use vaddr for size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 17e2251695..75d075d044 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1193,7 +1193,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
 void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, uint64_t size)
+                             int mmu_idx, vaddr size)
 {
     CPUTLBEntryFull full = {
         .phys_addr = paddr,
@@ -1208,7 +1208,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
 
 void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
-                  int mmu_idx, uint64_t size)
+                  int mmu_idx, vaddr size)
 {
     tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
                             prot, mmu_idx, size);
-- 
2.43.0



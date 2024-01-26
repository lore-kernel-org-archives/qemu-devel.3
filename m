Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D2CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHB-0002ER-PL; Fri, 26 Jan 2024 09:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH9-0002C9-Hy
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH6-0007rO-RB
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:47 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3392b12dd21so627682f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279623; x=1706884423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlL0ncqDDbK49LmHwxJsXF89nfVWU3/6tLGTdA35huY=;
 b=uLvhLgjo8xo021bgFZqoiHKDmsw6eGjuJ0GHe13ZGY4qTaeCjFh7KNX6zDDMBow+SR
 4ra1Bsvam1M2+Dn53Ez9tirct6tSaGElRmkJ5hHhZpVC+JKT4aFCj9XY5XMGLbbjh6Cy
 BZ/lwaDyBIOOx7/oswqdojFfBfqW/kQQ/aTbOnICqvbsnmDzZCOxQCY5LyOVMskkL39K
 lLzggREGZNQFNZ0+DJO7MM7/UrzlP6XpbJfzf93G67q4GQxj9riPEH/O0JdrHdvoWwP5
 PkefJgZ83uKG/LCh9RDGFawX6+MbO9Lt1NQ5BWWBop3ELnkxjegBESjbTbg88bpH4prz
 RRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279623; x=1706884423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlL0ncqDDbK49LmHwxJsXF89nfVWU3/6tLGTdA35huY=;
 b=h04f893vF0FiPN90TbhQUbr8hkMBm05Zlp0kS6PO1Qs3AkaG4oCkpBtDnbbl0MziIs
 OypKN8wWlUBu3yxfD2GQT/xHSe/2teKbrolgBlU3HJjRspM0PhUwYoKUbpgc3pf6Rj3j
 qhSrtnIoOyHIgFLTwDpEb/MzydoGQMlVFImraUoEYlYdZjpkzcH4IVslaFu6LwC36fBh
 /z8dxTXhtAJfC8FD0KzFy4vAN8uo7TNjnxpjWAn4DML7uXtbMOsuM5yz1xMZmQUBARWW
 wcmxFG0kSAEoh38oGPMQctUjcsK/CrxShY6avMQ4guRyGPVDOXv+ugUMwXoD5So7vEK1
 180A==
X-Gm-Message-State: AOJu0YykkkdA/0mTJMQuWFiW3AuyikGXmMI3/oHowDExn1VGO85D+EQW
 CxjvZoXa4p3z32i8Y8vXt+GqwD/bx1cPkZME3mn4n8JZKoWSfKmVvpZug4mwqQo3n+6mhbIGYuO
 T
X-Google-Smtp-Source: AGHT+IGFrx9n39TrRKNsYW8V5g8lxlOcwyMbMeeB5nsHmMs/lrmLwwRAGlbRr280DRflIR2RLMBGDA==
X-Received: by 2002:adf:a44e:0:b0:337:abf9:52a6 with SMTP id
 e14-20020adfa44e000000b00337abf952a6mr1003213wra.77.1706279623434; 
 Fri, 26 Jan 2024 06:33:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] target/arm: Fix VNCR fault detection logic
Date: Fri, 26 Jan 2024 14:33:07 +0000
Message-Id: <20240126143341.2101237-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In arm_deliver_fault() we check for whether the fault is caused
by a data abort due to an access to a FEAT_NV2 sysreg in the
memory pointed to by the VNCR. Unfortunately part of the
condition checks the wrong argument to the function, meaning
that it would spuriously trigger, resulting in some instruction
aborts being taken to the wrong EL and reported incorrectly.

Use the right variable in the condition.

Fixes: 674e5345275d425 ("target/arm: Report VNCR_EL2 based faults correctly")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-id: 20240116165605.2523055-1-peter.maydell@linaro.org
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index dd5de74ffb7..5477c7fb7dc 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -184,7 +184,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * (and indeed syndrome does not have the EC field in it,
      * because we masked that out in disas_set_insn_syndrome())
      */
-    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
+    bool is_vncr = (access_type != MMU_INST_FETCH) &&
         (env->exception.syndrome & ARM_EL_VNCR);
 
     if (is_vncr) {
-- 
2.34.1



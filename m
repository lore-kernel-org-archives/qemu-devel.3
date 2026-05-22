Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01BCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNC-0001Z6-AA; Thu, 21 May 2026 20:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN5-0001Yh-7H
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDN3-0003Ij-Dn
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b9ea536877so42326475ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408248; x=1780013048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ck1FjH8gwZzYqjalWaxvd/wqR/65wgyMLNJS0gQeToE=;
 b=Mcc49hGjlo6ljJJSCEAMXzA51TFh48e6K/oinhAKqnc9UUkbwmadiUbIolOIbixlPI
 N69Cdmd/bG80mHYzWFkIgc7ZGNyKYgif6ugHqbwljr4eZTNNQZbVeHqhLa5JPS2rPYFs
 jsd6kUWRi+pfemooeoHYYj4XUKs05Og+jM7mZq0eLhW2KryFoRZNkWo/X7fDVsHIBfr2
 wDNmUlBj6aWThOT70uLpP1XzZu+SkMWv8QcffhFe8EjC79+xSRkCpF8KQ8ll4U3b2y02
 w85Xi3KLz28JRdwO9tWBj1jiaNFx+d5QEkQkZsSN+mFoR8gK4pBvylTxEhCxdZTbRMkI
 uxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408248; x=1780013048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ck1FjH8gwZzYqjalWaxvd/wqR/65wgyMLNJS0gQeToE=;
 b=qBVTEyYmjjC8tgHSzSpUkOWG1JBSnnyG95s2VItfFiD96/DEbr9eZu4OEA5fgGrOOY
 1HggYnMcA4clWI5WbdzJc1QbIRuyHmwoFlBA5blqla0JldLGkZbsErHhpMEU9o5B19eB
 +FpRPlbE/SLV5DJlBHZdbkskjLr9iJ9Ogozcip2kqnvbPo/dLx8Vo/YnTlU1XvYy6iGO
 2A85qD9cTCvPzhOU+/67VUbE0tvyvSEqubwPgVk13O2r0OdNzvjHJBJJHa7CNgbTVjcQ
 3YfGgfljLL9yQ2xQ0+VftrYB0KHMq7HJpdK/BUzn68i0kuZ4MYM4gygCCsotPUkLKkZU
 kaDw==
X-Gm-Message-State: AOJu0Yyf1v92/9z3Lw/gKmr3OeFUtOPKQ/B06xTZsk66EWKS0DcVM+ix
 HA0ODIkwu/MGg/m6PEUBFXmcQke2JXYvIcoW5ksVGpkBRNX4w0sPg9q5icPysYLZ
X-Gm-Gg: Acq92OFyDbDD+K7hl7nsk7G1yc/GBqMb0s5faNtv4jsda5n2c9zqSDVexwUde2k50HG
 CU24YpJ62NZQP0tkdn3S3hlFtqJb4cqdXZqP0CeVv9xq+aouDExu9pJQ1Aiqveo7CudOMkuwkJ6
 rjRHE89OY0Hu9sWVj8jizn+j8zVJClJLnbz2EPxvNkSqqv80M96upzp6DCXuhgEwux098N0D7TN
 8PKS1KNo2cqoaP0eOll4/g/P3PzqaC4Dvj4kjXvbgaYVd1Tu/6bhTI9VEe09AkU99nuLAqnG5fK
 iOdubZ3396YxTb44alFHg+B8cy5HF6j0MKaELlfU3JHi48pVgWWyiwnL86r9sz6EgjVO6LPw3jA
 /8pK4gbfm7UYVO6ssnVJGxQ8p73jPXNYiEWy96h1JqDr1OaGkRQUz72Iybj1LTaNCNN2SPFgXx4
 7O3N6RkvX2vmkJ3cbTFL5V7F99ZudohUMZb/ho/HFMTw==
X-Received: by 2002:a17:903:234d:b0:2b9:cabe:ce37 with SMTP id
 d9443c01a7336-2bea20a2f33mr50739985ad.1.1779408247930; 
 Thu, 21 May 2026 17:04:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/48] target/riscv: rvv: Handle source overlap of vector
 widening reduction instructions
Date: Fri, 22 May 2026 10:02:46 +1000
Message-ID: <20260522000324.23255-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Blanchard <antonb@tenstorrent.com>

Widening reductions read vs2 as a vector of SEW elements and vs1[0] as a
scalar of 2*SEW. The ISA does not allow the same vector register to be read
with different EEWs, so they must not overlap.

vs1 is read as a scalar from element 0, so it is treated as a single vector
register (independent of LMUL) when checking overlap.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3208
Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260417080328.31918-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e65356eb7c..0b41cecb27 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3283,6 +3283,7 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_check(s, a) && (s->sew < MO_64) &&
+           !is_overlapped(a->rs1, 1, a->rs2, 1 << MAX(s->lmul, 0)) &&
            ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
 }
 
-- 
2.53.0



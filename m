Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F033EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8m-0008Jh-2S; Sat, 15 Aug 2026 16:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8i-0008Eu-1N
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:00 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008Ot-Hv
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:59 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2898643a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826273; x=1787431073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a/hlEFf1FqljA5oL9KqdkF9I8pya5mr0tI2C45YHawA=;
 b=Iq/BfRjPDzwe1c+4zAyQA89TqLY2gDYeGniHnTTd350UU4xDUYQVD6RXYqb3H5uuH9
 xL+gSDWnUr8bEOJgQXdFng5BsKbxjBmtxRr39T9bX3YzzW93zUpcOVsDITkjCe95tlt2
 Sy2vbR6jL7xYMxHE2vin97mxksExdbIky9kZlPbvOkJzqduBzrr5wjIlM3WMDCj/rgQk
 GpyJnNF5kpetOqSx4VpklKz2yj/L+/mSSHaZiJgl3HyVFHePT/rb+zgYcZnka17eMLed
 xNxjtA24Uvx9AxcOtKLFdiVTVSaTqLRcfm0BauTcnMGe27D3F15ypqkHqM8aLBXbpLal
 pZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826273; x=1787431073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a/hlEFf1FqljA5oL9KqdkF9I8pya5mr0tI2C45YHawA=;
 b=gKDGLtZ80FM4yRioP+KR87pupWYpy+TVR/E/XtaZcOJwWa8FH1mmKH1sr6fqOiIdcD
 Z+gE0kDB9XiOoD4HyAOf1gWAiS1rLXE08Z07uvaqXJ0R1Zt+Lr5OLEADv6C8XL9i9OiB
 RLeZRT4rimadal+XC4Mj0HSsfPQcICYPsnQe0zVjlgPi/tHApRiGL4z5hmzPeIfxglGE
 xyA8QycARiAx+HVfFs7p0pw34OilY+vasEf/WqBOQ6V0B35GCET1pKeWk+/Ove4oquhz
 vPzzuEnee+zgUxcdRamt8lm3fpx2zDLdrhONAR45EjC/uJE8aMWBoXw5uaxJwDtfocdz
 iaRQ==
X-Gm-Message-State: AOJu0YxjN5Dr4PHVhxQ5kC9LnFm3ihE7yaSXULxRqNCV/aeC6+mrEvxY
 L96eVbjWea+a8uG/ouV84W3+NNHtQBxAaOzE4SQREXTC4zjzNaCLOJvLl9mJmxU5vdp/DhvGuy0
 ovFtL
X-Gm-Gg: AR+sD12hTLTQt2YqGdrVs2oHTs+2noFYy0j3dO5M8pxHsScrp5WS47rfaeLjaZXAz7Q
 0zthwQAI/PvgLRtX0M/qVs7MqTvwGDg48EeJzA7GeU0YDFhWlyC3BidJOzos1mX/MHCR8pufQAa
 nRjuA0z4u01ksPgh5p6Lzj6EJe9/uI9I7rN24gaCU2U1D1TwuWkPAhSFkLLjNu+nzZcj0C2DGwU
 7V49KWw1tejQ+dvMfmjh0lBCbEuvytXCpBcAQxCp4EP5jxPLwjMHXOD8YYKpmA3263lczs3nipT
 An2kO/6XTRvlKydijQPGmPV5A/EEmwpCgSbuU0qvx1WmOdPTf9mThTsi4XJpDnRv+fu0n5+Ot5P
 tdpg1kJrnRDnra64is+vgb2yCfykn47Y1qi0NU53quxndbn4ttYVy8GRekcT1qmTGeP8ktQdR3J
 iqaIFu+zicxlx9T5AoTZAgZpjyQelxHb/X4FHzK5Di1OvWCr1kKs0BuGHI8aFcH8uGjBXT6pILh
 FoYSTgH17WzHdPthu3r
X-Received: by 2002:a17:90b:2587:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-3933b84b0b5mr16355159a91.8.1786826272976; 
 Sat, 15 Aug 2026 13:37:52 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 16/18] target/riscv: Recognize watchpoints with first/last
Date: Sat, 15 Aug 2026 13:37:28 -0700
Message-ID: <20260815203730.1468365-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 11f2654da1..3318e82ea7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1784,8 +1784,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, vaddr last,
          * Otherwise we'll throw a debug exception and execution
          * will continue elsewhere.
          */
-        cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
-                             wp_access, retaddr);
+        cpu_check_watchpoint(cs, first, last - first + 1,
+                             MEMTXATTRS_UNSPECIFIED, wp_access, retaddr);
 
         raise_mmu_exception(env, address, access_type, pmp_pma_violation,
                             first_stage_error, two_stage_lookup,
-- 
2.43.0



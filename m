Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DDC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17EX-0001Qg-Gm; Mon, 31 Aug 2026 14:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17EV-0001PV-KO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:51 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17ET-0000CT-W9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:51 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-90cd8e45460so49320296d6.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788202789; x=1788807589; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9GtGsBAQ9mS/SzBobD8ZOX7tnyIv8clzprzMF5QKwA=;
 b=mHzQHtwTHQYnVt6m+6KdCU+kXujviMvR8K3BMOWKK/0q1/XZsfHesLdrPtQA9WF0cR
 jwshAteTnXCUZqBtwHlnhuIJFpbm0C1IUr60I3EYHwrgKgwTB+xUt+nqOAdQhpBsEb6G
 tTVD9ZhnMLtthJ2YXLx2Rf5aF5cM1o1bnojHVajtcGel4oUZlSQ5A8MGg1MD7t/gU155
 zw0WIEPqaWc3Ni1eNoIVU6sQsVDC7ySbs/EVBCYI+Q+C7mAvb0qo/i++NhKCO7vAZCWZ
 PK2Dq0+exH1gDFCDYyvFcJJ1F4s9EWyVT4J6uuC6qPfHUQuBcMLoa7nRaoAGEQjKjll3
 UM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202789; x=1788807589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9GtGsBAQ9mS/SzBobD8ZOX7tnyIv8clzprzMF5QKwA=;
 b=P5AGDSff9mGSzCvu0pXDl4BX0z5BXZ29UJHDQwq4xtlDOqkx8TBn8LCmlS8qiOMDE2
 RtVWcNeM0lL1GBOmoTzIVlw3CpYqjCE71I5O42LK5bvmPCWRZkn4p8vFsTqOnv25wOWb
 0bAU9XGVDm4slpOv8h4YCTkWtOogR8ZWzNN5LyqUM0SgmH9UkW5WsOrr9deMlJtFiVPQ
 Cd5doZygz51CJNv8OBnS5y2WhoQwtolHixvh3OXWrNjY9v4pvr5UbbkuLQtUN6jXnQRx
 nBT+bwWNm25MW4Pfm1zBXuxT9rPWkjFlimWV9KvFpAfl2G8qeqUHTdhTC0A26KbRPbtU
 nuaA==
X-Gm-Message-State: AFuF++kEmzGZRAcPaK6xeUlgGFMDLAfZxY56CPR8xTa1FU3Ycb2ZD6wv
 Bw/fW7u4yNrG+9YtBhV2Om5EXF0iO3KJMM294AYxGzFfcZOHBLjfZ/OU7w7vba1VUN8=
X-Gm-Gg: AYBFou1uvtmHAmpLQnFXCVYz9y3wsuyarxCksFb8I0b1KEvHScQ04PyK5whsYzfQRy9
 cfH06SWGz3yJS4UNjQftj0ewhCi02uZuglp2Ne5zD3mzx63LGwhqlAFtUnQtFjsGs+ViA924OEt
 rhYqyZxbOSzO31Q/z3txc6FLWlyuhLO3Ebyt1wdgg5hDO4X7EFzXtC9yBuJheFbPV2F3Yyy3GG6
 2SzEZKfrM9oz4GbcwNA++Wu6++vNrztdQCnddb26sE8S/aGMw58TO8JFmJW2kfcDGYXKe6oMI9n
 3wz+5ZHam0j99BbwtbbK3WP+U8sfQ0z/AWK2Ta+ma1hSng/O9NVGo3hxPBl394LeBhlLbF/6hv+
 QI/YESqw0+8DxTsI5gAWJS0wf6Kc5K83a6enjDx0vJ2K7tCmFHmx2juQgBXCxOBFJUi+/xS4QWM
 02YHK/SgPeEoI2uhqnaahX/BSqd5whFsw8QJlUUZrmMakth8vjcBDdCaDtt3eZODwP3SQYOTBAG
 w==
X-Received: by 2002:a05:6214:5990:b0:90e:8424:4068 with SMTP id
 6a1803df08f44-90e842442c5mr189085796d6.24.1788202788876; 
 Mon, 31 Aug 2026 11:59:48 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce44f5695sm90952986d6.26.2026.08.31.11.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:59:47 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 31 Aug 2026 14:59:41 -0400
Subject: [PATCH 3/3] target/riscv: use a targeted TLB page flush for
 sfence.vma with a vaddr operand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-riscv_tlb_page_flush-v1-3-4fc6af95673a@baylibre.com>
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf2f.google.com
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

sfence.vma unconditionally called helper_tlb_flush(), regardless of the
rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
next access. Use helper_tlb_flush_page() whenever rs1 != 0, falling back
to the existing full flush for rs1 == 0. This makes RISC-V behaviour
more similar to ARM's equivalent (tlbi_aa64_vae1_write), which already
does tlb_flush_page_by_mmuidx() instead of a full flush.

Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
than get_gpr(), so that the address being passed matches the current
addr_xl width regardless of '-cpu' input. Otherwise, the raw register
value can carry garbage above that width and never match the address the
TLB entry was actually filled under, so the flush silently misses and a
stale mapping survives.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..8655fa332e 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
-    gen_helper_tlb_flush(tcg_env);
+    if (a->rs1 == 0) {
+        gen_helper_tlb_flush(tcg_env);
+    } else {
+        gen_helper_tlb_flush_page(tcg_env, get_address(ctx, a->rs1, 0));
+    }
     return true;
 #endif
     return false;

-- 
2.55.0



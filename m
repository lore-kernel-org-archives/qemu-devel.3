Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD163F433D6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeCl-0002Sg-8J; Fri, 17 Apr 2026 04:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDeCj-0002Ry-2V
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:05:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDeCh-0004nI-KS
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:05:32 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbba5076c8so210407a34.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1776413130; x=1777017930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nXWwqBQ10Hhfx10pB+p7V8zjRBHYSkmSuIN2Jd+cgic=;
 b=XefN9Tpuay/eZf4DMZ01rHAd3IcUWk5dgUjFUwgePNFqVMv9/B36Bp8A3bFKUAHF6c
 m3ErFJ04wgvx1jkuI8feQiQSZ9FHvYV5RPVbgYoOO1meK3iG+XFdFgUSPihsSpMgbPoG
 xX1hSuyuFfmi6JvZHFOthGI2VkclvhznO/xzlv+fy0zA3kt2EGAZR48C8N3aCMg5JNzb
 lh02ZRYGVnuN0a0gaZXtC3I6CcvWLECDmoujJZs+npety340gS2+uViv3CyWARj1pUTf
 sGVw9DkGH8OmJvceDlm4k95izhBvgBk17u2iBP6eR780SK856QstzDDBcLhGTcnuCKGi
 /2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413130; x=1777017930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXWwqBQ10Hhfx10pB+p7V8zjRBHYSkmSuIN2Jd+cgic=;
 b=fa59UcAsBpM5XSzI8/umotJ+f0AjRJ/gwz27qhA6XAsE4p3E5ZS0wpKOcTLMelcavM
 5PStTYkFrxKGkCTPNOskNXHRDzwFaQXGbZpkWx3kZdNo7fhPS2BMhpdRKXtJIrPW1Y5Q
 c+wSJzxE0BI5lJlnQylWguWvAlVjwZgAEFkpNfTcubbWf8TxZuQ7ZB9sdZbhs+6GkF/u
 AC779Mu91adK5xfWpdI6qc0aoPFbhkrctu8ucRr9RzWJ4Htvc3lqORNb6/NX148ciYP6
 JGAnaUgq0ZZ8D9DmHjD95hFa8VTwIjdeOyF723FaTGHuBYW1LKDhTM5s74qFIFiyrDzy
 cxqA==
X-Gm-Message-State: AOJu0Yxa8pdWJZ42PokGe03Qz17CH6p/juxyF50jgtohCZuWq0rHFh5q
 wBjO7bKHzlURPKMJ/PIvLw9U7hUKHVUKpshk0cuaHWLVpIlKiOdBa4ffX27dOUSTMgnHwde02VV
 /0VLXXS4=
X-Gm-Gg: AeBDies3SSuhlx02ZaPs+NB5/HkGhvBdQNTtxZmj9UgB/+WstGzt8FBfsFQfbzpa2Kc
 ZpCeuR7vk/4rTj3J9i29LvXbuOsenaXcOIxsqiEf3kVzdVK5BfVxZCFILChvhiAZxDc92jZ639y
 DFC4djUX1j/ZQxFtYRM8bSU47s29T3rtdvwVuZAgVH8Yaqg7i2ByeV05/qoFXPNR3AlpHFkOWsC
 t6c2OCo6C8dVX/dSPFsKHAZJTJccQPLZKXhs/SQma58hQgR5V7xpZDvlcYbFV7GOZxpdWFvBtZ5
 NDl1zWsa/ZHr+s0LuPpXbNrbZyhSPF2TS9pHjukplRjjBI8kGJkK57NGAYW9v/RkE+YSFD8y4eY
 JA6hQVYsdZPlSMVJ2O061fQBLqArBA8/WNVwrKvzVEy1bbFp3cRgKWr4HBwZjd8/iSPuE9rr8sL
 xP0eb8z3cUQ4/FGxIoXoXRVIm1aGahe/wuGGE3sEoRGjxnGItRxQd+LS4oNyC6Mr9ON6E=
X-Received: by 2002:a4a:e911:0:b0:67e:3ee6:d76f with SMTP id
 006d021491bc7-69462f29738mr1009958eaf.47.1776413130003; 
 Fri, 17 Apr 2026 01:05:30 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6946795969asm163084eaf.15.2026.04.17.01.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 01:05:28 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 liujingqi@lanxincomputing.com, max.chou@sifive.com,
 Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] target/riscv: rvv: Handle source overlap of vector widening
 reduction instructions
Date: Fri, 17 Apr 2026 08:03:28 +0000
Message-Id: <20260417080328.31918-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x330.google.com
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

Widening reductions read vs2 as a vector of SEW elements and vs1[0] as a
scalar of 2*SEW. The ISA does not allow the same vector register to be read
with different EEWs, so they must not overlap.

vs1 is read as a scalar from element 0, so it is treated as a single vector
register (independent of LMUL) when checking overlap.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..d9a0027e0b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3062,6 +3062,7 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
 static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_check(s, a) && (s->sew < MO_64) &&
+           !is_overlapped(a->rs1, 1, a->rs2, 1 << MAX(s->lmul, 0)) &&
            ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
 }
 
-- 
2.34.1



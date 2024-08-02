Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420AFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZimc-0007fo-7d; Thu, 01 Aug 2024 23:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZimb-0007f3-7q; Thu, 01 Aug 2024 23:16:45 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZimW-000743-KP; Thu, 01 Aug 2024 23:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722568586; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=oNvuh2j8JCTwpcZKbtfxd8+VNqgNcaLqgGg8ENxQoMg=;
 b=oyWwrOrNXyBwu8k4UU0ar8/k38UP4z1VaezqjGl+p12Nwvd6++ytxomV7dFWyowUl+oT+kPFgMO8YW+jpiq70Txt4JxQ+N6vymql8X6LOlc2FVUjOPPhHPdeT6Sox3MlD/p7pYn/XymX5/dJK3ZINOgpopBDTGR1L7VMse72Xjg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032019045;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBvrvNf_1722568583; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBvrvNf_1722568583) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 11:16:24 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v2 0/3] target/riscv: Remove redundant insn length check for
 zama16b
Date: Fri,  2 Aug 2024 11:16:09 +0800
Message-Id: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

In this patch set, we remove the redundant insn length check for zama16b as the
specification clarified that zama16b applies to compressed encodings[1].

Richard points out we should obey the MXLEN requirement for F/D/Q loads or stores,
so we add this constraint for trans_fld/fsd.

I notice that we have a too strict aligment implementation for fld/fsd when xlen < 64.
It will hide some problems. So relex it from MO_ATOM_IFALIGN to MO_ATOM_NONE.

[1]: https://github.com/riscv/riscv-isa-manual/pull/1557

v2<-v1:
  1. Add mxlen check for fld when applies zama16b.
  2. Relax fld/fsd alignment for MO_ATOM_IFALIGN to MO_ATOM_NONE.

LIU Zhiwei (3):
  target/riscv: Remove redundant insn length check for zama16b
  target/riscv: Add MXLEN check for F/D/Q applies to zama16b
  target/riscv: Relax fld alignment requirement

 target/riscv/insn_trans/trans_rvd.c.inc | 25 +++++++++++++++++++++----
 target/riscv/insn_trans/trans_rvf.c.inc |  4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc |  4 ++--
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.25.1



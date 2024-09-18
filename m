Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D669CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvGo-0002zU-8E; Wed, 18 Sep 2024 10:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGl-0002xs-2r; Wed, 18 Sep 2024 10:02:59 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGi-0002b0-JZ; Wed, 18 Sep 2024 10:02:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A4EFDC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726668169;
 bh=oxsZbL2ehpkUOthxSsGCY2jo8At/i/UgF1cy29T+VRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=UK1Eq/TUKnbquvrzN0PGc9yrm8jj1OEYRWL3NgidYHiqudqNOyLhOQR8QIlizq6z0
 KY4D4nhGUpK12IXjX9FgWpA2SIeX36vUotEXW5jYixqwgoO5fXqB2hDB2nQnI+WBeV
 NoK1owqtIgmjrgPNsVFL9UbvzHfd6CeOuWW7Zc6uFxg9gRa0o8nP2mRg0djg8RUqrR
 +qqbGNQcESZeSLjcV+gnHEdOykyQp/Cpv3OZ3qUqpzdehvC3VURmZTViN47xTgaI2X
 zs1pMmXxxE6+KHdcq9hSj68tGm8g/5jM6f4YzqRTmMwjlvv5xgUHCxofl8lEMyS6nn
 5x1H/5bhzLPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726668169;
 bh=oxsZbL2ehpkUOthxSsGCY2jo8At/i/UgF1cy29T+VRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=n0S4AA43NmZFKSnk38FJNTHtGUhh5ih9UwWKa1ELZah8iJp7s3o9HJ3LORiydzDgY
 Jlu55KXA1Z9zKdottKVH1juAn7Mwh8TaENj4FQFpc3D2ZbaukVNrQQNrC0i8ct6flf
 FB+c773eeroPRQg7M+xtrE9kvwu8aqvd/X9VslM7LVlHz3HP+TFhAiOO7O0He9EtxG
 UZZkTJMy+MWlVrqA0Q1OcbUfP+72gVV/2AMdOK0rGLEdXtFKXx1PVQ3cku49T/bJmP
 M1W42+3JgCKEjaEWldHE8dYf76HdM0dIeWOyi5Tt6wiORQcsSqqOGeomEIct+OFcFu
 0reHEjZ4/l4oA==
From: Sergey Makarov <s.makarov@syntacore.com>
To: <Alistar.Francis@wdc.com>
CC: <s.makarov@syntacore.com>, <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH 0/2] riscv: hw/intc: Fixes for standard conformance
Date: Wed, 18 Sep 2024 17:02:27 +0300
Message-ID: <20240918140229.124329-1-s.makarov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=s.makarov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

*** Patchset goal ***

This patchset aims to improve standard conformance for SiFive PLIC
implementation.

*** Testing cases ***

Currently there are no automated tests for these changes, but there
are several test cases, with which these changes may be checked:
1. Zeroth priority register can be checked by reading it after
   writing to it. Without patch its value would be the same which
   is written there, but with it it would be zero;
2. Trigger call of `sifive_plic_irq_request` with level 0.
   Without second patch it will clear pending bit, but with it
   pending bit won't be cleared.
If anyone knows how this can be turned into automated test, help
would be appreciated.

Sergey Makarov (2):
  hw/intc: Make zeroth priority register read-only
  hw/intc: Don't clear pending bits on IRQ lowering

 hw/intc/sifive_plic.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.34.1



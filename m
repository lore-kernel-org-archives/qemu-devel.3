Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5513DEE57DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 22:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soVpy-0000TU-By; Wed, 11 Sep 2024 18:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1soOnI-0005FM-L9; Wed, 11 Sep 2024 10:58:16 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1soOnB-0007yC-Fw; Wed, 11 Sep 2024 10:58:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3AB66C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726060766;
 bh=oxsZbL2ehpkUOthxSsGCY2jo8At/i/UgF1cy29T+VRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=lrKzyaQEDRzRsNTSeZxx2RfvvbH7WH8+Fl+uBFsdTO/RJMOk9isqUT9TAWVPkTkVj
 A1C/Cqzq+DmYstHxmjbIPMOdP0jL9DErxo9yfOtLCabxB7DKkK+Yb4P8qf0V/aopsX
 d04FA+Tsr+Nm061TjJK0AOOtxwzzfYTUJZXQ/keA+7aRG7fp0xsRcPrOtU9RgG10Vy
 ZSKgfXfk0u2CF57HR2MziDPcMaEm38fjOAS2ZxoeYek8go0mNAXyr1r139pWbxcDEr
 M9kNuJ3HZKzXnxsXowJyvU/+8JBwHTyLmru0NMUXVkpO7fzgSiqIfz2DMvJrDvCI8f
 Ue1uTJvCMxpsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726060766;
 bh=oxsZbL2ehpkUOthxSsGCY2jo8At/i/UgF1cy29T+VRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=qZa30XSj8Y6P57y4Nsn9P6QbW0yIBX52gKjNEBR/IB18ND10E6qCH4FT/noy3LRmb
 BF6WphEY+5ymFLrVFncSqAlLNcpjxZYnDOQ5XbsF9rjMDNCSMuzSR4vZq2M//tpUrQ
 v+lp38PiECZmV6ZBhy5udfLIfFSNvmbz/xfOgm6E6xCq6oBe1sOlGcziEdbrXiZRv/
 iWPeAARZ5TcrV+yYe1XYc9pf6U+nOVFvfRrDGlxVserQAETIrM6wqKiJzOcsDGki1R
 8blyh+Ttl24INI7ucBpyraJxRcv7l1v//QpLHa9jMjcwCEww+glmMrlKWMCCVQwi8g
 l/64465c/VAHA==
From: Sergey Makarov <s.makarov@syntacore.com>
To: <Alistar.Francis@wdc.com>
CC: <s.makarov@syntacore.com>, <bmeng@gmail.com>, <palmer@dabbelt.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH 0/2] Fixes for standard conformance
Date: Wed, 11 Sep 2024 16:18:58 +0300
Message-ID: <20240911131900.179648-1-s.makarov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=s.makarov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Sep 2024 18:29:04 -0400
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



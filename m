Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949C5C3DA61
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVWVi-0000rt-3M; Sun, 21 Jul 2024 09:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVSZM-0002GN-MX
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 05:09:28 -0400
Received: from kuriko.dram.page ([65.108.252.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVSZJ-0002Pm-0m
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 05:09:27 -0400
From: Vivian Wang <uwu@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
 t=1721552959; bh=nrrvipFBAhgDnyJR+4gF1DQaIkKMnSnYaI8hLutuQJw=;
 h=From:To:Cc:Subject:Date;
 b=fLG5KiFwgl5nUYdQsp3IEU+TtoAnG3ESDxoL6xhcxCqpCQ/veqJMhc9WcO5iJeA92
 ZPsv3nC/bC/xnehNGjvM7/YKfMBpspftnAVUdGDVSSn3nBLCRjAneWma5qztiFhiwk
 yCTMruA/PsZ3sDHfXZ56VoubIsAcTLUMA4USbD2g=
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/2] linux-user: Fix handling when AT_EXECFD is 0
Date: Sun, 21 Jul 2024 17:08:15 +0800
Message-ID: <20240721090817.120888-1-uwu@dram.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.108.252.55; envelope-from=uwu@dram.page;
 helo=kuriko.dram.page
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Jul 2024 09:21:56 -0400
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

Found when trying to build coreutils under linux-user as binfmt_misc
interpreter with "open-binary" flag.

I'm unsure whether the version detection in patch 1 makes sense. Please
advise on how to handle situations like this.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2448

Vivian Wang (2):
  util/getauxval: Ensure setting errno if not found
  linux-user/main: Check errno when getting AT_EXECFD

 linux-user/main.c |  3 ++-
 util/getauxval.c  | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

--
2.45.1



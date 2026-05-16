Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27340CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJle-0007XW-FB; Sat, 16 May 2026 14:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wOJlb-0007XD-R3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:29:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wOJlZ-00031p-Ux
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:29:39 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mail-out.m-online.net (Postfix) with ESMTP id 4gHszc582Fz1r9RZ;
 Sat, 16 May 2026 20:29:32 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4gHszc4MfWz1r9RC;
 Sat, 16 May 2026 20:29:32 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
 by mail.m-online.net (Postfix) with ESMTP id 4gHszc3BtHz1qqlR;
 Sat, 16 May 2026 20:29:32 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id Qnx51eCPr0Po; Sat, 16 May 2026 20:29:31 +0200 (CEST)
X-Auth-Info: V/QhwVQVJ9inqh12q/hpddVDmJtxqasvKPNGxi3zzITMGp1kIs3T7U2e78L2PrSI
Received: from igel.home (aftr-82-135-83-160.dynamic.mnet-online.de
 [82.135.83.160])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sat, 16 May 2026 20:29:31 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 906802C170E; Sat, 16 May 2026 20:29:31 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: M68K: qemu mishandles fmovem.l with multiple control regs
CC: qemu-devel@nongnu.org
Date: Sat, 16 May 2026 20:29:31 +0200
Message-ID: <87cxyv4390.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.9; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This should exit with 16, but exits with 0:

	.globl _start
_start:
	fmovem.l fpstate,%fpcr/%fpsr
	fmove.l %fpcr,%d1
	move.l #1,%d0
	trap #0
	.data
fpstate:
	.long 0x10
	.space 8

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


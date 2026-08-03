Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF14C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqwl8-00022J-I9; Mon, 03 Aug 2026 13:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wqwl6-00022B-0w
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:47:28 -0400
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wqwl4-0008Ni-CA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:47:27 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mail-out.m-online.net (Postfix) with ESMTP id 4hDPJT1jp2z1r8mJ;
 Mon,  3 Aug 2026 19:47:21 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4hDPJS6QdTz1r8mD;
 Mon,  3 Aug 2026 19:47:20 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
 by mail.m-online.net (Postfix) with ESMTP id 4hDPJS5JsRz1qqlR;
 Mon,  3 Aug 2026 19:47:20 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id wB3Vt-zE0QIc; Mon,  3 Aug 2026 19:47:19 +0200 (CEST)
X-Auth-Info: VpPGMxZ95asAtqxCHEH6npKrfPn3etlDEpksxz/oVsupuSL3at063P4tmONwxzqp
Received: from igel.home (aftr-62-216-202-244.dynamic.mnet-online.de
 [62.216.202.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon,  3 Aug 2026 19:47:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id C54D32C0AE6; Mon, 03 Aug 2026 19:47:18 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Geert Uytterhoeven
 <geert@linux-m68k.org>,  Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
In-Reply-To: <89e75011-61fb-4cbc-9583-4117005e58dc@gmx.de>
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
 <89e75011-61fb-4cbc-9583-4117005e58dc@gmx.de>
Date: Mon, 03 Aug 2026 19:47:18 +0200
Message-ID: <87ik5rksex.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.9; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Aug 01 2026, Helge Deller wrote:

> msgctl01.c:53: TFAIL: msg_ctime = 6a6e65d900000000, expected 6a6e65d9

If you use -D_TIME_BITS=32 with struct msqid_ds it will work, I'm sure,
even though glibc uses the same (time64) syscall.

> So, for m68k either the glibc or the kernel is wrong.

Both are wrong.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D1C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNz1-00021b-Hg; Fri, 07 Aug 2026 13:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wsNyz-00021P-SA
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:03:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1wsNyx-000836-OX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 13:03:45 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mail-out.m-online.net (Postfix) with ESMTP id 4hGr895dsGz1r87K;
 Fri,  7 Aug 2026 19:03:37 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4hGr89472Fz1r86Q;
 Fri,  7 Aug 2026 19:03:37 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
 by mail.m-online.net (Postfix) with ESMTP id 4hGr893hcJz1qqlR;
 Fri,  7 Aug 2026 19:03:37 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id TFiRop-bpZP1; Fri,  7 Aug 2026 19:03:36 +0200 (CEST)
X-Auth-Info: vdaz5uAD1y/5NwkJF0ez8//2jbKLUG44wvYkmgnnjRQzOfHnl+eUqgAB5InYlaAc
Received: from igel.home (aftr-62-216-202-142.dynamic.mnet-online.de
 [62.216.202.142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Fri,  7 Aug 2026 19:03:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 8C1232C0AE0; Fri, 07 Aug 2026 19:03:35 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Helge Deller
 <deller@kernel.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
In-Reply-To: <090faa9e-0ba2-4620-8d27-8fa4b7ac17af@gmx.de>
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
 <87ecgfkrg9.fsf@igel.home> <anEBr8nK-4nKmuXj@p100>
 <87y0emkhjo.fsf@igel.home>
 <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
 <CAFEAcA8Mof1EDHoF0hBRcu+to0W6ny-KvX7mUwch+SGVgRD3MA@mail.gmail.com>
 <090faa9e-0ba2-4620-8d27-8fa4b7ac17af@gmx.de>
Date: Fri, 07 Aug 2026 19:03:35 +0200
Message-ID: <87bjbdhnh4.fsf@igel.home>
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

On Aug 07 2026, Helge Deller wrote:

> Andreas, do you agree as well, that all 32-bit kernel architectures
> should follow this path and we should drop the "preferred" thing and switch
> to a native 64-bit time value?

That would be an ABI break.  But on the glibc side, the m68k definition
of struct msqid_ds is broken as well, having incompatible layout beteen
_TIME_BITS=64 and _TIME_BITS=32 definitions.

> If so, I'd willing to come up with a kernel patch...

Let's see what the kernel experts recommend.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


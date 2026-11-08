Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA0606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1Jb-0002mI-I8; Sun, 08 Nov 2026 06:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ1JZ-0002lx-Sj
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:44:01 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ1JX-0007H7-LN
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:44:01 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6A40760C2B6;
 Sun, 08 Nov 2026 12:43:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id evUrmNbM7j4C; Sun,  8 Nov 2026 12:43:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 57ED860C0F3; Sun, 08 Nov 2026 12:43:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 562C313991F;
 Sun, 08 Nov 2026 12:43:51 +0100 (CET)
Date: Sun, 8 Nov 2026 12:43:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@kernel.org>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Keith Monahan <keith@techtravels.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/4] ncr53c710_v2: add new NCR53C710 chipset driver
In-Reply-To: <20261106221818.139086-3-deller@kernel.org>
Message-ID: <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
References: <20261106221818.139086-1-deller@kernel.org>
 <20261106221818.139086-3-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
>
> This adds a new driver for the NC53C710 chipset. This drover is based on the
> lsi53c895a driver, and thus avoids many issues of the existing ncr53c710
> driver, which was written from scratch.

There's a typo "drover" above.

I asked this before but would it be possible to modify lsi53c895a.c to 
also emulate the 53c710 too instead of duplicating code? This device model 
is almost the same as the 53c895a or at least a large part is shared but 
it's not easy to see that as it uses different names for the same 
structures and functions. It would be better to at least split the reused 
struct definitions from 53c895a into a shared header and use that here. 
Then compare what are the differences between the functions and see if the 
common parts could either be split into a common super class or if the 
differences are small enough to just add conditionals in lsi53c895a.c to 
also emulate 53c710 with most of the code shared instead of duplicated.

A somewhat complex example of such code sharing is hw/isa/vt82c686.c which 
uses a common super class or hw/display/ati.c which has conditionals to 
emulate simlar devices. I was thinking about such code sharing would be 
possible for these devices too to avoid code duplication that can diverge 
in the future.

Regards,
BALATON Zoltan


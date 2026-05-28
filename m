Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA5CCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZKT-0000Zt-0l; Thu, 28 May 2026 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wSZKQ-0000ZB-JQ; Thu, 28 May 2026 07:55:10 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1wSZKN-0004j1-PU; Thu, 28 May 2026 07:55:10 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id B086812203;
 Thu, 28 May 2026 13:55:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id iwBrw4awZ_wn; Thu, 28 May 2026 13:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1779968891;
 bh=GPh3LNaQ2i/wzbh5HH3LftNFiXUcK4Sg3CA/5ASG9Tc=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=YNTGvdoqdoAkDGXTQuAHoBwfixseZ2NA2D7vSaZPP7mLJx1kSmqkl9RjPkB/2zji1
 mEYK/Ya911eVH1maqKCpBI4YAAZWudk0YahCsCJCC1J62ZcXR14gB9SYGiN2nOwKs/
 lrC86rBnJ+61FmgSnkLGLxzOWFqiu066ECHKA26nSs3z5D/2PN1K0FSmZK8YqBJXDj
 1HpwI7PRuhkvkUdPYuArgcXpYpkFHftxMiBeHR8x19IF8jQyfFm8tciF9Dj1keVFAI
 Xm9Ml2TDBATdw8ru7QP4C3P7ymY2INg9vuY3/phWOgXru1mf5IPYEpLALz0vVb8wq0
 Rd+ZgTsWLZi1w==
Received: from [147.32.86.150] (unknown [147.32.86.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 1516012097;
 Thu, 28 May 2026 13:48:11 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>, Andrey VOLKOV <andrey@volkov.fr>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Thu, 28 May 2026 13:48:10 +0200
User-Agent: KMail/1.9.10
Cc: "Bernhard Beschow" <shentey@gmail.com>,
 =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 "Matyas Bobek" <bobekmat@fel.cvut.cz>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Nikita Ostrenkov" <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, linux-can@vger.kernel.org,
 "David Jander" <david@protonic.nl>
References: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
In-Reply-To: <E1wSWUo-00000003ZfC-2dBa@pty.whiteo.stw.pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202605281348.10786.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
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

Hello All,

On Thursday 28 of May 2026 10:53:42 Sascha Hauer wrote:
> On 2026-05-27 20:38, Marc Kleine-Budde wrote:
> > On 27.05.2026 18:25:37, Andrei VOLKOV wrote:
> > > As the original author, I have no objection to reusing (my part of) the
> > > header under GPL-2.0-or-later. The reason it was not done that way in
> > > 2005/2006 is simple: only GPLv2 existed at the time.

thanks everybody for the approval to reticence
as GPL-2.0 and latter.

To Andrey Volkov, excuse for using inappropriate address,
but the questionable copyright situation has been raised
and was main problem even for the v2 series version from
March and it seems not to move forward from that time
so I have tried to find some address on which you could
respond as the original author and I expect that your
original address at varma-el.com is no longer valid.

I think/remeber that there is no other request for changes
in this round of review. May it be, the additional
authors can be added to the headers code excerpt.

But generally I approve this FlexCAN support
to be merged into QEMU master as CAN subsystem
co-maintainer and I would be happy merge is proceed
by somebody with commit right. Directly, directly
with addition of Andrey Volkov and Sascha Hauer to
the last line of notice in

hw/net/can/flexcan_regs.h

and

include/hw/net/flexcan.h

+/**
+ * These macros ware originally written for the Linux kernel
+ * by Andrey Volkov, Sascha Hauer and Marc Kleine-Budde.
+ */

or Matyas Bobek can modify the line and send
v4 version.

I would be happy if the code is merged, and it can be the base
for some future project to extend support to iMX8
FlexCAN 3. Maybe I can find a student or somebody
provides resources, time, GSoC funding, or some other option
to attract some students to take the opportunity
to work on a project and learn something as a summer job...
There are a lot more interesting controllers to support,
I (with Michal Lenc) lead RTEMS D-CAN driver support
GSoC for AM335x this year, QEMU support would be nice
for CI there, we would continue on the PolarFire driver
for RTEMS, one day, matching QEMU support would help.
Long-term, multiqueue and priority for Linux would be worth
solving; results on CTU CAN FD on RTEMS are exceptional.
There are plenty of opportunities to have fun.

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


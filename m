Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF1BC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgwM8-0006w2-2S; Wed, 21 Aug 2024 21:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sgwM4-0006vO-Nb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:11:13 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sgwM2-0000zv-28
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:11:12 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 50D9339AF6;
 Thu, 22 Aug 2024 03:11:00 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id bsPL7pB2aK8L; Thu, 22 Aug 2024 03:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724289057;
 bh=lAy4fZKctPjLAaixSPH/GIIYR+4S+PCzXLSP4B87AIA=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=jxLt5d2vNYWw371iEu/pI0qeT3OeBIeBFw1hvlK4W8CNp8FhP1IXpBnz2SegcB5HR
 wfq169eNlgDjOsqlQmPM7Sz/5xBVnz9pb8JKVlDHK4siL6SYh5Ddx7y9BLxgzkb++Y
 FYvbAlDXV1RudyIa+lAS5kQOlap7HEF/ifv3yiav+26jkDB94ht999prxcRN8zTJHG
 PJIuiG9gnaXTBuyqhlLwvvkScuMa8kj5xpPgnCdGweXEHJ7N00zWo27TjB1U3TqzJj
 I0eHjL74cB1XKKOWz1pn2Rn3aLf5G5oLisc7ujZ0rnfLwreqSJByy8Tme+ZNO0+RCK
 qlR4OG2W4G9nQ==
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id B479239AF4;
 Thu, 22 Aug 2024 03:10:57 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Thu, 22 Aug 2024 03:11:01 +0200
User-Agent: KMail/1.9.10
Cc: Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <20240816163504.789393-1-doug@schmorgal.com>
 <202408210857.20254.pisa@fel.cvut.cz>
 <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
In-Reply-To: <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408220311.01551.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.772,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Doug and Francisco,

thanks for cooperation

On Thursday 22 of August 2024 02:01:01 Doug Brown wrote:
> (Dropping Vikram from the email chain; I received "recipient not found"
> errors from AMD's mail servers in response to all of my patches)

If the address Vikram Garhwal <vikram.garhwal@amd.com> is not valid
then if he has still interest in CAN in QEMU it would be great
if he updates the address in the QEMU MAINTAINERS file. If he does
not plan to participate then the MAINTAINERS file should be updated
as well.

Vikram Garhwal is listed even as whole CAN subsystem comaintainer

  https://gitlab.com/qemu-project/qemu/-/blob/3472f54522a928f0020d6928d54c007f862c5478/MAINTAINERS#L2690

I plan take an eye on the system long term and I have
ideas and plans how to enhance it in more directions when
I find some spare time or project, studnets, thesis,
company interested in adding another controller etc.

But I would be more comfortable if there is somebody else
who is willing to be at least my backup when I am on some
trip without Internet (hiking etc.). I am quite loaded by
teaching etc. and all these my CAN and in the fact all my
open-source and other development projects are mostly out
of any interrest of the university department where I serve.
They would care a little if/when I bring paid contract from
some company, as we have from Volkswagen and its subsidiaries.
But it is long time ago at university and even longer
at my company.

So all depends on my enthusiasm and free time which
should have at least some maintainership backup by somebody
who intend to use the project in frame of company or some
automotive consortium. I know that there are big money flowing
on base of these activities.

Best wishes,


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


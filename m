Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2A3C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siGRs-0000A7-Ca; Sun, 25 Aug 2024 12:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1siGRq-00009J-Uw
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 12:50:38 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1siGRo-0002k0-Kz
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 12:50:38 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 5FBC616AA;
 Sun, 25 Aug 2024 18:50:30 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 3Bofv_-79F4y; Sun, 25 Aug 2024 18:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724604628;
 bh=Zp34jMY+SyJILqUa9TFUng5CqUfknUbO1fh4qPymEUc=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=kA4xpFBgVGR+4e7vKHxuIAwzScT000PBBTZW2j1lN8pYIxjoey5o51t8UCOAVL48b
 CtPiH/nDJ4MxUrUPat0pFsrIbCtfHCN0Zljt85sxY7IVgeL0R3Lh9zqrtBZAMiDwA0
 F7TxQMEbmud1ptFHhpZaaBwNeVW+oXa7gS6iYwv0af/Vuc9hiXe678SMveC5DazzrF
 QzxJzII3cVuQ4Gu6YllQ4wMKkJvP5aywGKGT3gTZ2Mv/wqQFUpTPjG9Uv7lOZKq5/a
 QalgBIQsJz6EWJPOWKs6hEHloT2jbMv7G1PlaZfwWLxtetgvvIWeCFfqajfLgPTggo
 uoCcN0rQDwzvQ==
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 8B3C916A9;
 Sun, 25 Aug 2024 18:50:28 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Sun, 25 Aug 2024 18:50:34 +0200
User-Agent: KMail/1.9.10
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <bonzini@gnu.org>
References: <20240816163504.789393-1-doug@schmorgal.com>
 <202408220311.01551.pisa@fel.cvut.cz>
 <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
In-Reply-To: <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408251850.34384.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-3.322,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Doug

On Saturday 24 of August 2024 03:54:00 Doug Brown wrote:
> Thank you for reviewing all of my patches, Francisco.
>
> Now, all of these patches are reviewed but there are a few other issues
> we talked about here (dlc2len/len2dlc and issues with the flags), and I
> also found a FIFO issue. Would it make the most sense for me to submit a
> V2 of this series with a few extra patches tacked on the end, or should
> I wait for this series to be applied first? I can do it either way, I
> just wasn't sure what would be preferred.

I agree with both ways,

1) merging actual versing and then providing followup
   patches

2) updating and extending the series

I have little inclination to the second choice (2), because
you have already patch where you touch dlc2len/len2dlc issue
and making it without middle step would be more straightforward
and readable to me.

Anyway, I am the initiator of QEMU CAN subsystem as GSoC and studnets
mentor and coauthor but I have no commit right to the QEMU mainline.
So actual merge has to be realized by people with commit right.
Paolo Bonzini has provided help with CAN subsystem integration
and the committing.

Best wishes,

                Pavel
-- 
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


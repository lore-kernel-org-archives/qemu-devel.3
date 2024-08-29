Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66520C83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjf8G-0002zq-Pb; Thu, 29 Aug 2024 09:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf8C-0002z3-Ub
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:24:08 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf8B-0007km-0n
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:24:08 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id C7BBC3A156;
 Thu, 29 Aug 2024 15:24:05 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id kjpTCy7mK6GR; Thu, 29 Aug 2024 15:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724937843;
 bh=H2HNR8cYsEyqK95lulFWgkkq2IrKbjEGC2AbbyHq4yA=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=cni7QCg0NSn3wRZsgI5W+fhoV28ORpJn+gZiXwTxQLDvvkCbQlbrTU1g2z6+EieuR
 YSQuGINkDBZB+5FzRZZ5hXECfk/w11mhkxRRQfq6y/VsmbZWO6ZAX7ibMuKaU3lpdd
 +t9Qo0WiOUjSaOYZ3rYxdde2Ks5BJi068olWYGYr4NviXtu9QOWARMmHUw6vbPLb8W
 Ucy5ADtvNVm3Bc0/tRqEW33ASXcxb0pO6UN1TSXflVR9vBKTUx6L3Bx6/CMLQ/xyEp
 kvBvcdlxPlcJELhQ9eS0EHmnCHhoUWFEMGbPy0RfhrVK0HEZtorXIYRI1fSwv1ogkI
 71tqZCHparFog==
Received: from [147.32.86.193] (unknown [147.32.86.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5E8DB39FEB;
 Thu, 29 Aug 2024 15:24:03 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 7/7] hw/net/can/xlnx-versal-canfd: Fix FIFO issues
Date: Thu, 29 Aug 2024 15:24:08 +0200
User-Agent: KMail/1.9.10
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-8-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-8-doug@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408291524.08632.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.084,
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

On Tuesday 27 of August 2024 05:49:27 Doug Brown wrote:
> The read index should not be changed when storing a new message into the
> RX or TX FIFO. Changing it at this point will cause the reader to get
> out of sync. The wrapping of the read index is already handled by the
> pre-write functions for the FIFO status registers anyway.
>
> Additionally, the calculation for wrapping the store index was off by
> one, which caused new messages to be written to the wrong location in
> the FIFO. This caused incorrect messages to be delivered.
>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Generally, I agree that index should wrap up for cyclic FIFO
implementation and change looks logical to me but I do not
see and studied all consequences related to emulated HW.

If that is confirmed or corrected by somebody from AMD/XilinX,
it would be better. I can find more time to do deeper analysis
if no other looks into the whole code.

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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F915C83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjf05-0005jb-D5; Thu, 29 Aug 2024 09:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf03-0005du-TB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:15:44 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf00-00065K-Ss
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:15:43 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id C32593A307;
 Thu, 29 Aug 2024 15:15:39 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id B_EqHtMs5tGL; Thu, 29 Aug 2024 15:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724937337;
 bh=MoAI+qLYfadqddbwLs3x44NhxfPmMgBLCcEfIN6k2as=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=UW8teVojvtmDjnAZvh6sfPcr7/TY32IPo+ZWeAmEzGXNQpuudAeYLyjZy6BK5Sc2w
 A++Gr3xTHkUYeMbOv2kVqLF/Jr8QwGsQsq8d4LCXeWkKPAyhg1lWwSj+dfcE0KnVRk
 sBwDB10BtpObdUOb2CVfwJgW06GunwA5Lqu72EURI4l0CSDN2nLryIvMuW4L1e/DAg
 OcjDQ3ooz753nrZ1jc/CNybCXZLgXRtWNZwjMqbRK1ZG855M2+v4QSgKzD9+IRw8I8
 aUoN3U3GRmWrTcCwheSLKWfxFblvNy1BwHFjxbSTbHXVgN/wDDmXm1+yMaW1nybxw0
 apQvgOdL3+hzA==
Received: from [147.32.86.193] (unknown [147.32.86.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5BF033A306;
 Thu, 29 Aug 2024 15:15:37 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 5/7] hw/net/can/xlnx-versal-canfd: Fix byte ordering
Date: Thu, 29 Aug 2024 15:15:42 +0200
User-Agent: KMail/1.9.10
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-6-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-6-doug@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408291515.42699.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.084,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tuesday 27 of August 2024 05:49:25 Doug Brown wrote:
> The endianness of the CAN data was backwards in each group of 4 bytes.
> For example, the following data:
>
> 00 11 22 33 44 55 66 77
>
> was showing up like this:
>
> 33 22 11 00 77 66 55 44
>
> Fix both the TX and RX code to put the data in the correct order.
>
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

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


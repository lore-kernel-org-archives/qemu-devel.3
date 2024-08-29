Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B95C83F15
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjf1b-0002QL-7s; Thu, 29 Aug 2024 09:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf1Z-0002Ph-An
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:17:17 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjf1X-0006AT-Ft
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:17:17 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 510F43A28E;
 Thu, 29 Aug 2024 15:17:14 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id RjChN_qkGYm2; Thu, 29 Aug 2024 15:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724937432;
 bh=CZYx1RdbK+yJ9Tdm4o5M4F1U2nQhaFm8eSkpWnYq7vg=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=AQj3GszyQlbYGrS1WxNBNdCDrn3ZKNnya4Y+KubKw1PrAa64lPf/R96SfDhgiapiA
 v++oRo26vLHozKkxVpyIuM0ZQ/OD9VnaO0xMHTJwPsOQlNtzaNwnj2vBt3O+fWNrgC
 SnzmF/CKdab3KhlyyDjMaHff/sL8mjuRkZed4bly0vLg7F3Fc1WCaKf7NXuTMG6lnh
 QDp3uEUKzqJI3/wIkw0AEGCoIAwXUJ3jDUW+R6zIz+g/HPSmbvJyBoAeFHnJReUC0c
 jAyn0sXNckt0l/1Ja8GGu8TZFoT6jgjkVowfljNYCAR2/+uD5lH+XJMadnsIlogFMw
 0Xrey/r5INPaQ==
Received: from [147.32.86.193] (unknown [147.32.86.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 110FD3A213;
 Thu, 29 Aug 2024 15:17:12 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 6/7] hw/net/can/xlnx-versal-canfd: Simplify DLC
 conversions
Date: Thu, 29 Aug 2024 15:17:17 +0200
User-Agent: KMail/1.9.10
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-7-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-7-doug@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408291517.17407.pisa@fel.cvut.cz>
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

On Tuesday 27 of August 2024 05:49:26 Doug Brown wrote:
> Use QEMU's helper functions can_dlc2len() and can_len2dlc() for
> translating between the raw DLC value and the SocketCAN length value.
> This also has the side effect of correctly handling received CAN FD
> frames with a DLC of 0-8, which was broken previously.
>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

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


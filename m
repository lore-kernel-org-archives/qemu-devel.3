Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D124D7494E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 23:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5vsG-0000Ah-Ca; Tue, 29 Oct 2024 19:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5vsC-00009N-O7; Tue, 29 Oct 2024 19:43:40 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5vs9-0006RL-Fx; Tue, 29 Oct 2024 19:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1730245408;
 bh=Xso3sElEGkFiueOKiSwOZboNeXIBDkpOIXEJKbLNR4o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=AN0iIpU7fiFeK7dqdcHJXRydv4jUQ7gV/vrqV2ey1ssSJ5S7x2b76/mrh3gCE0aDv
 +elGr+Or38vqxW3Eipt1oma9+kJj2Zn4ZXbKz0Gnw/0ZQj5qZXBqM3y7EHrBMtvI/A
 t032z4jo/vpUTvor/oHQjgu/yOPx7JCemhpidKasA3Mw0ok7Ew36GdwavAsVbKqW/i
 bM+7G7P8O19WOqpL2X5D2B04fkzLDjUqh5FgTyon4W6QYFkrY8ICtuk5nc7bTHqv+7
 PEC8kG8Ynlw0JoHF19nGqFZtP4ni5smkie4sie46T1H/rSDXtmjNBx4ugAJ06WRJ4X
 KNvUpJzPI04Kg==
Received: from [192.168.68.112]
 (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.190.243])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9AE8F67E6D;
 Wed, 30 Oct 2024 07:43:25 +0800 (AWST)
Message-ID: <7e1b21bf2f0c0654e63cd4b3c39f39162a3e3485.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/8] hw/timer/aspeed: Fix interrupt status does not
 be cleared for AST2600
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)"
 <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Wed, 30 Oct 2024 10:13:25 +1030
In-Reply-To: <20241029091729.3317512-4-jamin_lin@aspeedtech.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-10-29 at 17:17 +0800, Jamin Lin wrote:
> According to the datasheet of AST2600 description, interrupt status
> set by HW
> and clear to "0" by software writing "1" on the specific bit.
>=20
> Therefore, if firmware set the specific bit "1" in the interrupt
> status
> register(0x34), the specific bit of "s->irq_sts" should be cleared 0.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Hah, the datasheet table for the register uses `RW` to describe the
bits and not `W1C`, but there's a foot-note in the table that says
they're W1C bits.

Fixes: fadefada4d07 ("aspeed/timer: Add support for IRQ status register on =
the AST2600")
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks,

Andrew


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00115C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 03:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdLHu-0007k3-K7; Wed, 29 Jan 2025 22:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLHs-0007je-LF; Wed, 29 Jan 2025 22:32:16 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLHp-0008Ts-Pc; Wed, 29 Jan 2025 22:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738207931;
 bh=kTQxGgo7ou40qvmsBfu1dW38+QtlfEuOajgtgwxc62g=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=R8AOua8aTUXZ2ypJN5YlCbkv/gJK/tp9YFn5aDyEGLNiLLJLQC53SnjrVO/wwoKVA
 eBdqU6OVCRO7kJ2GxgSxTk2xzJjKtNtSVI1YeiF38iwP4zPlz0r0l2CUrMFiJF2mjs
 tfbNsw64yR1QAeQ5dHliPwzQdpaFATHsIebV58YSgSX+Jz6Ij4YCwV1Ib6T8tR3iWH
 V8kqdDqhOeyU4sBiKiINuCso7LP+CYEwJs9x2yBc00Cy/JN6sAKra+QByNobAgUm/z
 93trVvPlIH9ZESSTvfWM0CwWN+0IJNZGonGOBbr4pwMC39e9uqrvHlZ2d6KgJkSuIY
 bmY4xO9pCh6XA==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5B7E873803;
 Thu, 30 Jan 2025 11:32:10 +0800 (AWST)
Message-ID: <ee2d8a35f9fc890091c789cad452e6e0aa915cdf.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 02/18] hw/intc/aspeed: Support different memory
 region ops
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 30 Jan 2025 14:02:09 +1030
In-Reply-To: <20250121070424.2465942-3-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-3-jamin_lin@aspeedtech.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 2025-01-21 at 15:04 +0800, Jamin Lin wrote:
> The previous implementation set the "aspeed_intc_ops" struct,
> containing read
> and write callbacks, to be used when I/O is performed on the INTC
> region.
> Both "aspeed_intc_read" and "aspeed_intc_write" callback functions
> were used
> for INTC0 (CPU DIE).
>=20
> To support the INTC1 (I/O DIE) model, introduces a new "reg_ops"
> class
> attribute. This allows setting different memory region operations to
> support
> different INTC models.

Is there a reason not to make it a different type altogether? I'm not
sure I like the idea of playing tricks with the memory ops. The timer
model does something similar, but I was toying with the idea of
removing that part of its implementation...

Andrew


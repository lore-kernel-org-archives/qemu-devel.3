Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E62C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZn3-0007X1-Ia; Thu, 04 Jul 2024 23:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZn1-0007WG-QV; Thu, 04 Jul 2024 23:39:15 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZn0-0002R4-5a; Thu, 04 Jul 2024 23:39:15 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 301FA2014E;
 Fri,  5 Jul 2024 11:39:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1720150750;
 bh=iZbIs8kJw277k4hPcQvVI8L6MOunHhIgf7u0USBq86k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=YMkZt4TyBX+5IZfr6f+egYfVTTjSZaeJ6P1lPJHR25465CHzymbO1Z3EbVOnhTYr0
 ow+tYo4vmutwTaQ+dBHRUwQ4A9erNReSF02uOJpavX5kOx4Gbz8fa7+njwoCWF+/1E
 LwD37ThFT2WwLt74NxQWYnsVjekaVI0KkNc9ciXZxqmYmLkW3SFtPKE5yKBBVqxcoS
 3L7ufF8j+fnvon7p5Bq7Z4ypffWNi2jXFnFdKo35sgrWThNI4Tv7ZjmDPRN15r7qjK
 cxffcMsIKGeajQVxNDrOSvglTe5xYwydg08K2XnDJov+E9iuKJIMaNjGh6EOdN++81
 tuLUBtxZYYTiw==
Message-ID: <62ba0b417de5e2cf940a2a6f6d9ca5117efcfac6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 4/8] aspeed: Introduce a AspeedSoCClass 'boot_from_emmc'
 handler
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Peter
 Maydell <peter.maydell@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Fri, 05 Jul 2024 13:09:09 +0930
In-Reply-To: <20240704053651.1100732-5-clg@redhat.com>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-5-clg@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-07-04 at 07:36 +0200, C=C3=A9dric Le Goater wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Report support on the AST2600 SoC if the boot-from-eMMC HW strapping
> bit is set at the board level. AST2700 also has support but it is not
> yet ready in QEMU and others SoCs do not have support, so return false
> always for these.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


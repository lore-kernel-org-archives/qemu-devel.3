Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF071CD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzxl-0005Cv-Om; Tue, 12 May 2026 23:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wMzxk-0005Ce-7x; Tue, 12 May 2026 23:08:44 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wMzxe-0004Wt-CH; Tue, 12 May 2026 23:08:43 -0400
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wMzxS-0004HF-2Q; Wed, 13 May 2026 05:08:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wMzxR-000Jnf-2x; Wed, 13 May 2026 05:08:25 +0200
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 6C639480051;
 Wed, 13 May 2026 05:08:25 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id POBWUh0nmyUV; Wed, 13 May 2026 05:08:24 +0200 (CEST)
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 6E6E7480059;
 Wed, 13 May 2026 05:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 6E6E7480059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1778641704;
 bh=zjBdNRQb9PBJ2IjAOCjt07hGGZoCCPNYt7jct0KoNCY=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=TDA8dh2RxcpcQ4gbh4Z+V8BLgr3EPGCWQr6TUYLPDqd2CV0t3xWBOblz715VbTTT3
 P0Sh0yviU4vzHZmY/adYMcLHtPAGwnjxMvGnBv+N/5OPQyJwnQJi+hWp7rn61INWF0
 CDfiMnHgzrI43WMi6nHTmqkSrlTvjpzQ3ExnRCkNN+MgPcwPTD/xeGuMRwRTYdM/qI
 q3JHs1lyTH4CL7KkHoI2ZM3CZw1HIl94GI9RYOMwCuswe6g6OtIPEfKFKoHg6cuAC/
 AJ2MYL3lB9DhWrfbKL78PCS+Rro/fQHmJR++jp98/A+lMFHkRaUipN4zEvCbQj/3yn
 Ny/vOQ05V+beg==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hAQGq-R2VBkC; Wed, 13 May 2026 05:08:24 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 299CA480051;
 Wed, 13 May 2026 05:08:24 +0200 (CEST)
Date: Wed, 13 May 2026 05:08:24 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, liwei1518@gmail.com, 
 daniel barboza <daniel.barboza@oss.qualcomm.com>, 
 zhiwei liu <zhiwei_liu@linux.alibaba.com>, 
 chao liu zevorn <chao.liu.zevorn@gmail.com>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Conor Dooley <conor@kernel.org>, 
 alistair francis <alistair.francis@wdc.com>
Message-ID: <1514447636.13520.1778641704122.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <20260513023859.518484-1-alistair.francis@wdc.com>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - FF140
 (Linux)/10.1.16_GA_4863)
Thread-Topic: MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Thread-Index: rD5E6Ijx1uKevwYPx7BJnaC6ja72gg==
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.199.104]
X-Virus-Scanned: Clear (ClamAV 1.4.3/27998/Tue May 12 08:24:57 2026)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

----- Am 13. Mai 2026 um 4:38 schrieb Alistair Francis alistair23@gmail.com=
:

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> Conor and Sebastian as people to help deal with the fixes.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks, this is fine.

--=20
VISIT US @ SATELLITE ASIA IN SINGAPORE 20-22 MAY (https://asiatechxsg.com/s=
atelliteasia//): Hall 4, Booth 4K2-4
--
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB797C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 19:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wee2W-000351-6y; Tue, 30 Jun 2026 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@alien8.de>) id 1wee2U-00034k-I6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:22:34 -0400
Received: from mail.alien8.de ([65.109.113.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bp@alien8.de>) id 1wee2S-0001gm-3i
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:22:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B2A140E00BA; 
 Tue, 30 Jun 2026 19:22:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
 reason="fail (body has been altered)"
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id YVo1ovhGLYJA; Tue, 30 Jun 2026 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1782847336; bh=1JZ76zwI+8HXTbK3tedNL3TuIa9C1gm4JFVx2mqP8bc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f65DD/DNFHO/ifVhACLAc44kmeocymkXrSWiiGD5e/0aeHlvwGobQUqiLM9LMk1HW
 5fCO8triQc/vJhcgTxAthj252hmEeriPnUf9ccTKjnUMGofLZc4DfNa9qXKs0bCOYH
 aJSmuLEiq7oWU0lR3d8NaqyaWM44h3lNNv18ic9UqKEyq2F1pnPW27c4vs++je27p6
 3a399jPAjNXZdXj6HLha6yxD+h1Z/GFzHtUun2KvtcRvmajWeLckH5wLbLzx16htZj
 2wY0zxEUrXDXZTq0VkhX0wvZZBbPWVB64/Dq3mdkx+VE8n3VX1/RyIHt44S1CRpt0w
 RTbz7BinvhJjRMHH8MC1/8rQftsNB+SIi8j51q0K96cQhK/ltoaEDew5qHxCsDww8D
 WfGc+w7UChUpqhfMQpVLoDT7i/SMnOX9yrB7dup0ucu5aX6RpFEX4Nki5rxguTPDfu
 Lo6NZMqH40Wemrl2lcFWMcNVc169e1KhWI4NVVnjnnqVuBeAdYalXd8fS1432xXE3W
 xJs3uAJhVeUBaNgTZmBqQmOKJJbC/cMeT4dPVAHkbPB7h7ADqFzPQXiNKFD+lf26g5
 MmaOLcUE6rUc6x/AHYD/y0IhG+Hm/mfheP7b49jmSAYOW/Jwlxmf2LsUHWi42JMWNM
 RUTXxouiXKyk7sqzt2A7Qmgs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DCA040E00BF;
 Tue, 30 Jun 2026 19:21:58 +0000 (UTC)
Date: Tue, 30 Jun 2026 12:21:54 -0700
From: Borislav Petkov <bp@alien8.de>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/14] qapi: convert to explicit intro section syntax
Message-ID: <20260630192154.GBakQXUjMfaPrpc6-u@fat_crate.local>
References: <20260629213624.936258-1-jsnow@redhat.com>
 <20260629230756.GCakL6zDDd_g8DIeGD@fat_crate.local>
 <akN99Ov2ngf2BwbG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akN99Ov2ngf2BwbG@redhat.com>
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=65.109.113.108; envelope-from=bp@alien8.de;
 helo=mail.alien8.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 30, 2026 at 09:27:32AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > Why is this thread CCing linux-edac?
> >=20
> > I don't see any relation here...
>=20
> The linux-edac list was recently added to the QEMU MAINTAINERS
> file:
>=20
>   https://gitlab.com/qemu-project/qemu/-/commit/4c5e70b9a42744401fc10b1=
7cc61820586ba4a13
>=20
> and the entry matches the qapi/acpi-hest.json file that John has
> modified, so gets auto-CC'd.
>=20
> Admittedly the content in this series is not especially relevant
> to the liunux-edac list in this case, but the patch submission
> tools are just following the declared MAINTAINERS file entry.

Thanks for letting me know.

@Mauro, please remove a linux-kernel mailing list from being CCed with qe=
mu
patches. This is only going to cause a huuuge confusion as it is already
showing.

Please do a separate list only for qemu RAS stuff.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


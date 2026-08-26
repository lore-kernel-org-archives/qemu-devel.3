Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418B2C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Py-0002ZG-DX; Wed, 26 Aug 2026 04:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wz9Pv-0002Yw-Mn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:55:31 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wz9Pt-0002h0-CK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=B/0QpWGM+VgFwSMZz627RXIEQnuHEYnKHmmhwTAfKIM=; t=1787734529;
 x=1788339329; b=LUR7AdTGsO8b2++GHREuMYrcjDYoijYMlG2TACeMgiOvY9BdLMD3YDXgBJt0X
 B1rcrevPV/EqJM4y02kSZqw73IHagwW2amOEa147G0rpfAG3mDBzoGSG+jd1EoZrzjJar0MDqG8dn
 IWOixL3pGH7fZ5nzOq2z9m49an180L4Q8O+Yb5d8oh8tjTVcW0xJP7zRpIcE3amAxQ5Xp09aVLpHJ
 CLXrI2mlyAaMURaGVcjoP3KKob0t3ospLR1U68xb0ji2dZQra9VlfjDrZIUjD1o2a5a3Kd+jdPFU5
 s3B1bmB2Rb32mq0H3pS+BgF91QAL1ehg5uox63PR45HWJH5gvA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wz9Pm-00000003JS5-0drY; Wed, 26 Aug 2026 10:55:22 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6]
 helo=[192.168.178.61]) by inpost2.zedat.fu-berlin.de (Exim 4.99)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1wz9Pl-00000003maJ-3yfC; Wed, 26 Aug 2026 10:55:22 +0200
Message-ID: <20882e4165594352bc7c9007351f0a768a96ebb9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH][SH] Fix mac.w / mac.l insn
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oleg Endo <olegendo1024@gmail.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>
Cc: qemu-devel@nongnu.org
Date: Wed, 26 Aug 2026 10:55:21 +0200
In-Reply-To: <4a86e81ffa5e392efa069463cd21457374915b93.camel@gmail.com>
References: <4a86e81ffa5e392efa069463cd21457374915b93.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.82.6
X-ZEDAT-Hint: PO
Received-SPF: pass client-ip=130.133.4.66;
 envelope-from=glaubitz@zedat.fu-berlin.de; helo=outpost1.zedat.fu-berlin.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Hi Oleg,

On Wed, 2026-08-26 at 17:36 +0900, Oleg Endo wrote:
> It seems the implementation of the mac.w / mac.l insn is wrong:
>=20
>    mac.w  @Rm+,@Rn+
>    mac.l  @Rm+,@Rn+
>=20
> Qemu's implementation first reads both mems, then applies the post-inc. =
=C2=A0
> However,
>=20
>   mac.w   @R0+,@R0+
>=20
> should actually do:
>   read @(R0 + 0)
>   R0 +=3D 2
>   read @(R0 + 2)
>   R0 +=3D 2
>=20
> That's also how GDB sh-sim implements it.
> The attached patch fixes it.
>=20
> I ran into this issue recently when trying to use qemu for sh4.
> I'm not on the list, so please add me in CC in the reply.

I think the patch should be posted as inline, i.e. using git send-email.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


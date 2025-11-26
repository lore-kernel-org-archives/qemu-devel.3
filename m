Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE808D10F33
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEbY-0000yZ-3L; Wed, 26 Nov 2025 07:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vOEbL-0000kh-Pc
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:26:28 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vOEbK-0007Kh-0O
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=hGsWRrb00YMEMi7GM/BHnTNmz41Yqu7selnGwZ0OEEA=; b=OAuY+NA0+NBQg8zQafNLmRsMsZ
 AhMtFJXAXrAou1I2YTVvrE+9LAclE/XuuFMA01qTfaN2TnnZy4/yltr7hTtbxvO/DB/xrn8Xqx3sD
 RlZXYJXZmPVSh53AvOBafirCmUfxFvxcbEXqBGSxQTFYdWYarOWSBGcf0O56tHp2tNQjyLlnQ0Gka
 E9sVh2kV1JIzKeTnOyutSEJaWLwZCbPRHcqQ0FSZ4YLiyAZHLkA/NGDEBCfH1v6DlYjmeyGVwcc6S
 KBUg3kvDhGg5SDMGcU5XbQZnKz+Rpnfc3dHnX7lxUIKuK9ssvTv+N0YRGNDHem/gefghO2BKAjEV3
 sK9SY9HuRsOEdP+gNepFFvpkd0PDRjkUZE/7LMzgS5vbgmWyvZpbAht5QfFVB9tVXDrWLD1ZWCXoW
 ii/BsL4JFqXU4RlT76ccQ706LcyI13ItBr+gckP9Rr0BSJNMjeHj6OjFrG9wFYn8bSV4Pf0AKv94d
 GonYMFD4xwXBllO/E0BW1xbr9yHYVZfYNhdB6gdgjj2LeOVAXJgtny8Gso/kJpih/B9flpaVfn8sK
 fszr+mMXEd0FAB/CYvs003Y+kcA4LbGcpsey1s7szhlxfq4iA3fsmNRJTOvYaRdFLbHfOPYG8f7o1
 pIk0+icYgnsswySn2U+GEMfwaGlEzNrERnMy4CPoE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Date: Wed, 26 Nov 2025 13:26:22 +0100
Message-ID: <4695171.LvFx2qVVIh@weasel>
In-Reply-To: <88fca96d-c083-4fea-a5dd-619d3e053812@gmail.com>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
 <13893778.uLZWGnKmhe@weasel>
 <88fca96d-c083-4fea-a5dd-619d3e053812@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
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

On Tuesday, 25 November 2025 21:40:57 CET Andrey Erokhin wrote:
> On 26/11/2025 00:31, Christian Schoenebeck wrote:
> > On Tuesday, 25 November 2025 19:58:19 CET Greg Kurz wrote:
[...]
> > Anyway, Andrey is right of course. The C standard defines a "labeled-
> > statement" as
> >=20
> >   identifier : statement
> >   ...
> >=20
> > and the subsequent line in the patch is a declaration, not a statement.
> >=20
> > But I also understand if GCC developers relaxed this rule. Because it
> > "feels" like both, a declaration and a statement. Interesting, because
> > usually it's clang to be more relaxed than GCC.
>=20
> Probably GCC allowed mixing declarations and statements in a block way
> before C99, in C++-like way, which has statement =E2=86=92 declaration-st=
atement =E2=86=92
> block-declaration production (C99+ uses block-item =E2=86=92 declaration|=
statement)

It's not that old. It was introduced by the following commit in GCC, simply=
=20
because the C23 standard now allows labels to "appear before declarations a=
nd=20
at the end of compound statements.":

commit 8b7a9a249a63e066cff6e95db05a3158b4cc56cc
Author: Martin Uecker <muecker@gwdg.de>
Date:   Sat Nov 7 00:48:33 2020 +0100

    C Parser: Implement mixing of labels and code.
   =20
    Implement mixing of labels and code as adopted for C2X
    and process some std-attributes on labels.
    [...]


And in fact, clang -std=3Dc23 accepts it without error or warning as well.

/Christian




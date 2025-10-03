Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F14DCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 09:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4cOQ-0000ki-Tq; Fri, 03 Oct 2025 05:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4cON-0000hS-HP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 05:47:59 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4cOC-0008Qm-Oy
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759484869; x=1791020869;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=JFFGlxK9YLJee4l3cC+JZPxEyIjIf9R538BJSuGxWZQ=;
 b=P3dbPPI7MZ+effEFu6xYWIPDpalDX3bRuOlD71FanFBt8DNQFwhP3Sbs
 acIn5HgdkjB4BXwzitMQwInnIaZCFWcFyKrymIA7OyUsNvMZtsraZHQAz
 EeMMC+0363LBiyenTuLNKtjL45bJIEmoOA4qoW6UjxMZPrcoqxVnhoMnj E=;
X-CSE-ConnectionGUID: m3U+m8kfThaBoH5J6ncDYg==
X-CSE-MsgGUID: v0lluCQTQICQ2VeceYIY7g==
X-IronPort-AV: E=Sophos;i="6.18,312,1751234400"; 
   d="scan'208";a="3139859"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 03 Oct 2025 11:47:37 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <72mloahvtgskcdjulsggewy3euoutslvpcx2dnkxijgwkogdg6@6oq3h5tncfl3>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-2-Marco.Cavenati@eurecom.fr>
 <72mloahvtgskcdjulsggewy3euoutslvpcx2dnkxijgwkogdg6@6oq3h5tncfl3>
Date: Fri, 03 Oct 2025 11:47:37 +0200
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 ppandit@redhat.com, berrange@redhat.com
To: "Juraj Marcin" <jmarcin@redhat.com>
MIME-Version: 1.0
Message-ID: <26358a-68df9b80-a13-40f93b80@130992167>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/3] =?utf-8?q?migration=3A?= add 
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Juraj,

On Thursday, October 02, 2025 16:45 CEST, Juraj Marcin <jmarcin@redhat.=
com> wrote:

> Hi Marco,
>=20
> On 2025-10-01 18:18, Marco Cavenati wrote:
> > Enable the use of the mapped-ram migration feature with savevm/load=
vm
> > snapshots by adding the QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE feature =
to
> > QIOChannelBlock. Implement io=5Fpreadv and io=5Fpwritev methods to =
provide
> > positioned I/O capabilities that don't modify the channel's positio=
n
> > pointer.
> >=20
> > Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> > ---
> >  migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++=
++++
> >  1 file changed, 48 insertions(+)
> >=20
> > diff --git a/migration/channel-block.c b/migration/channel-block.c
> > index 97de5a691b..30dcefcd8e 100644
> > --- a/migration/channel-block.c
> > +++ b/migration/channel-block.c
> > @@ -30,6 +30,7 @@ qio=5Fchannel=5Fblock=5Fnew(BlockDriverState *bs)
> >      QIOChannelBlock *ioc;
> > =20
> >      ioc =3D QIO=5FCHANNEL=5FBLOCK(object=5Fnew(TYPE=5FQIO=5FCHANNE=
L=5FBLOCK));
> > +    qio=5Fchannel=5Fset=5Ffeature(QIO=5FCHANNEL(ioc), QIO=5FCHANNE=
L=5FFEATURE=5FSEEKABLE);
> > =20
> >      bdrv=5Fref(bs);
> >      ioc->bs =3D bs;
> > @@ -96,6 +97,49 @@ qio=5Fchannel=5Fblock=5Fwritev(QIOChannel *ioc,
> >      return qiov.size;
> >  }
> > =20
> > +#ifdef CONFIG=5FPREADV
>=20
> I don't think this conditional macro is necessary here. QIOChannelFil=
e
> needs it because it directly uses preadv() syscall which might not be
> available on all systems (see when CONFIG=5FPREADV is defined below).
>=20
>     config=5Fhost=5Fdata.set('CONFIG=5FPREADV', cc.has=5Ffunction('pr=
eadv', prefix: '#include <sys/uio.h>'))
>=20
> However, bdrv=5Freadv=5Fvmstate() (wrapper of bdrv=5Fco=5Freadv=5Fvms=
tate())
> should be always available IUUC (it is not conditionally compiled bas=
ed
> on if preadv() syscall is available).

You are right, thanks for pointing this out, I will remove the macro in=
 the
next iteration.

Just to make sure nothing weird happens without preadv support and with=
out the
macro guard, I compiled QEMU without them and indeed it looks like snap=
shots
are not supported at all without preadv. savevm/loadvm gracefully fail
independently of mapped-ram on/off.

Best regards,
Marco



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 09:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Qb8-0000GX-Tf; Wed, 08 Oct 2025 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v6Qb6-0000GO-Ju
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:36:36 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v6Qb3-0007S0-5c
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759916193; x=1791452193;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=NhF/a+vDjNHaSk9dfs5L4qtyMh0VQs4aew0LTHIpRvA=;
 b=ruhVkuthE97NAcjTyAC/lWo8hUhh2t8qwEJSQBX6e06YJ/qzHqi5v0z7
 S+lkOJso17FszeGVzXiSvuvv3+xikTdjMaYXhQr8lCum8qZ6aYKcnUpC0
 zwg+0r8eoSCkdOiy79gComVG9Si4wGVU9e9Ri8NjOYNpAJio4IxqbC8W4 g=;
X-CSE-ConnectionGUID: A5GsqYLfTtmGKdx92prvjA==
X-CSE-MsgGUID: WrLAg9dSQYqxxEfPMbDIGA==
X-IronPort-AV: E=Sophos;i="6.18,323,1751234400"; 
   d="scan'208";a="3187247"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 08 Oct 2025 11:36:26 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <aOWB9oxknXYjeY-i@x1.local>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-4-Marco.Cavenati@eurecom.fr>
 <26083e-68de3c80-5f3-4691f480@28926673> <aOWB9oxknXYjeY-i@x1.local>
Date: Wed, 08 Oct 2025 11:36:26 +0200
Cc: qemu-devel@nongnu.org, farosas@suse.de, ppandit@redhat.com,
 berrange@redhat.com
To: "Peter Xu" <peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <2ff5d9-68e63080-17f-1d382d20@13519612>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/3] =?utf-8?q?migration=3A?=
 =?utf-8?q?_mapped-ram=3A?= handle zero pages
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Peter,

On Tuesday, October 07, 2025 23:11 CEST, Peter Xu <peterx@redhat.com> w=
rote:

> On Thu, Oct 02, 2025 at 10:49:45AM +0200, Marco Cavenati wrote:
> > Please note that there are a couple of errors (swapped parameters),=
 which are
> > detailed below.
> > I will address these in the next iteration, along with any addition=
al changes
> > based on your feedback.
> >=20
> > Thank you
> > Marco
> >=20
> > On Wednesday, October 01, 2025 18:18 CEST, Marco Cavenati <Marco.Ca=
venati@eurecom.fr> wrote:
> >=20
> > > Make mapped-ram compatible with loadvm snapshot restoring by expl=
icitly
> > > zeroing memory pages in this case.
> > > Skip zeroing for -incoming and -loadvm migrations to preserve per=
formance.
> > >=20
> > > Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> > > ---
> > >  migration/ram.c | 56 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
> > >  1 file changed, 55 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index e238c9233f..597d5ffe9e 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -3958,12 +3958,55 @@ static size=5Ft ram=5Fload=5Fmultifd=5Fpa=
ges(void *host=5Faddr, size=5Ft size,
> > >      return size;
> > >  }
> > > =20
> > > +/**
> > > + * handle=5Fzero=5Fmapped=5Fram: Zero out a range of RAM pages i=
f required during
> > > + * mapped-ram load
> > > + *
> > > + * Zeroing is only performed when restoring from a snapshot (HMP=
 loadvm).
> > > + * During incoming migration or -loadvm cli snapshot load, the f=
unction is a
> > > + * no-op and returns true as in those cases the pages are alread=
y guaranteed to
> > > + * be zeroed.
> > > + *
> > > + * Returns: true on success, false on error (with @errp set).
> > > + * @from=5Fbit=5Fidx: Starting index relative to the map of the =
page (inclusive)
> > > + * @to=5Fbit=5Fidx:   Ending index relative to the map of the pa=
ge (exclusive)
> > > + */
> > > +static bool handle=5Fzero=5Fmapped=5Fram(RAMBlock *block, unsign=
ed long from=5Fbit=5Fidx,
> > > +                                   unsigned long to=5Fbit=5Fidx,=
 Error **errp)
> > > +{
> > > +    ERRP=5FGUARD();
> > > +    ram=5Faddr=5Ft offset;
> > > +    size=5Ft size;
> > > +    void *host;
> > > +
> > > +    if (runstate=5Fcheck(RUN=5FSTATE=5FINMIGRATE) ||
> > > +        runstate=5Fcheck(RUN=5FSTATE=5FPRELAUNCH)) {
>=20
> Should we check RUN=5FSTATE=5FRESTORE=5FVM directly here?
>=20
> I think it's still good to spell out the rest, we could put it in a
> comment, e.g.:
>=20
>   /*
>    * Zeroing is not needed for either -loadvm (RUN=5FSTATE=5FPRELAUNC=
H), or
>    * -incoming (RUN=5FSTATE=5FINMIGRATE).
>    */

I have no strong opinion here, but my reasoning was that the "optimizat=
ion
allow-list" approach might be slightly safer.

If, due to a hypothetical bug, we end up in an optimizable scenario (ze=
roing
not required) but RUN=5FSTATE is not in the allow-list, migration will =
only be
slower (I measured a +25% a while back in an arguably bad case scenario=
).
On the other hand, if RAM actually needs to be zeroed but RUN=5FSTATE i=
s not
RESTORE=5FVM, then RAM won=E2=80=99t be consistent and the VM could cra=
sh.

That said, since zeroing is the "new feature", it also makes sense to a=
dopt the
opposite approach and enable it only for RESTORE=5FVM.
I will do as you proposed.

> > > +        return true;
> > > +    }
> > > +
> > > +    if (from=5Fbit=5Fidx =3D=3D to=5Fbit=5Fidx) {
>=20
> Might be safer to check >=3D rather than =3D=3D.

Fixed, thanks.

> > > +        return true;
> > > +    }
> > > +
> > > +    size =3D TARGET=5FPAGE=5FSIZE * (to=5Fbit=5Fidx - from=5Fbit=
=5Fidx);
> > > +    offset =3D from=5Fbit=5Fidx << TARGET=5FPAGE=5FBITS;
> > > +    host =3D host=5Ffrom=5Fram=5Fblock=5Foffset(block, offset);
> > > +    if (!host) {
> > > +        error=5Fsetg(errp, "zero page outside of ramblock %s ran=
ge",
> > > +                   block->idstr);
> > > +        return false;
> > > +    }
> > > +    ram=5Fhandle=5Fzero(host, size);
> > > +
> > > +    return true;
> > > +}
> > > +
> > >  static bool read=5Framblock=5Fmapped=5Fram(QEMUFile *f, RAMBlock=
 *block,
> > >                                       long num=5Fpages, unsigned =
long *bitmap,
> > >                                       Error **errp)
> > >  {
> > >      ERRP=5FGUARD();
> > > -    unsigned long set=5Fbit=5Fidx, clear=5Fbit=5Fidx;
> > > +    unsigned long set=5Fbit=5Fidx, clear=5Fbit=5Fidx =3D 0;
> > >      ram=5Faddr=5Ft offset;
> > >      void *host;
> > >      size=5Ft read, unread, size;
> > > @@ -3972,6 +4015,12 @@ static bool read=5Framblock=5Fmapped=5Fram=
(QEMUFile *f, RAMBlock *block,
> > >           set=5Fbit=5Fidx < num=5Fpages;
> > >           set=5Fbit=5Fidx =3D find=5Fnext=5Fbit(bitmap, num=5Fpag=
es, clear=5Fbit=5Fidx + 1)) {
> > > =20
> > > +        /* Zero pages */
> > > +        if (!handle=5Fzero=5Fmapped=5Fram(block, set=5Fbit=5Fidx=
, clear=5Fbit=5Fidx, errp)) {
> >=20
> > This should be
> > +         if (!handle=5Fzero=5Fmapped=5Fram(block, clear=5Fbit=5Fid=
x, set=5Fbit=5Fidx, errp)) {
> >=20
> > > +            return false;
> > > +        }
> > > +
> > > +        /* Non-zero pages */
> > >          clear=5Fbit=5Fidx =3D find=5Fnext=5Fzero=5Fbit(bitmap, n=
um=5Fpages, set=5Fbit=5Fidx + 1);
> > > =20
> > >          unread =3D TARGET=5FPAGE=5FSIZE * (clear=5Fbit=5Fidx - s=
et=5Fbit=5Fidx);
> > > @@ -4003,6 +4052,11 @@ static bool read=5Framblock=5Fmapped=5Fram=
(QEMUFile *f, RAMBlock *block,
> > >          }
> > >      }
> > > =20
> > > +    /* Handle trailing 0 pages */
> > > +    if (!handle=5Fzero=5Fmapped=5Fram(block, num=5Fpages, clear=5F=
bit=5Fidx, errp)) {
> >=20
> > This should be
> > +    if (!handle=5Fzero=5Fmapped=5Fram(block, clear=5Fbit=5Fidx, nu=
m=5Fpages, errp)) {
>=20
> The rest looks all good.
>=20
> I can queue patch 2 now, which is trivial.  Please repost patch 1+3 a=
fter
> rebasing to Fabiano's patch here:
>=20
> https://lore.kernel.org/r/20251007184213.5990-1-farosas@suse.de
>=20
> Then in patch 3 you can remove the MAPPED=5FRAM cap in the list.
>=20
> Fabiano could also be posting some test patches too that he got for
> snapshots.  You can either respin before that, or wait for it (then y=
ou can
> also add a mapped-ram test for snapshots).

Ok, thanks!
Marco



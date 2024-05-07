Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C459AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MRu-0007tT-V6; Tue, 07 May 2024 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4MRm-0007qr-HM
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s4MRk-0002LJ-C9
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715094575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAMmzCwLtdG5RVdAgwNgLH0bsE7H0cYhJOrp1QsvG/c=;
 b=FMec/Gn+zA5/LVU5nkn2EL7gVvVEVSX/64xslvIPPLoUJaECfQrxQDF8a8RidpIGr1seQ9
 1WOLVXIFckooEjJszpYWevT9jidhNWdMBFYaJIPBzywJLd/swe/boK8R90dmi+pAPx1GYT
 5NEz0l385MSy8IZzKd4dzmMBmtDDgN0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-cMH_NkvYNBO7fhiLbC7z4g-1; Tue,
 07 May 2024 11:09:29 -0400
X-MC-Unique: cMH_NkvYNBO7fhiLbC7z4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCB741C01516;
 Tue,  7 May 2024 15:09:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C11AA1C060AE;
 Tue,  7 May 2024 15:09:26 +0000 (UTC)
Date: Tue, 7 May 2024 11:09:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Sam Li <faithilikerun@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PULL v2 03/16] block/block-backend: add block layer APIs
 resembling Linux ZonedBlockDevice ioctls
Message-ID: <20240507150919.GE105913@fedora.redhat.com>
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-4-stefanha@redhat.com>
 <CAFEAcA9U8jtHFYY1xZ69=PoR1imgzrTB9aK5aoe+vZJtQrU1Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="evVfc2bZ/OH8O6xW"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9U8jtHFYY1xZ69=PoR1imgzrTB9aK5aoe+vZJtQrU1Jg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--evVfc2bZ/OH8O6xW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 01:33:51PM +0100, Peter Maydell wrote:
> On Mon, 15 May 2023 at 17:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > From: Sam Li <faithilikerun@gmail.com>
> >
> > Add zoned device option to host_device BlockDriver. It will be presente=
d only
> > for zoned host block devices. By adding zone management operations to t=
he
> > host_block_device BlockDriver, users can use the new block layer APIs
> > including Report Zone and four zone management operations
> > (open, close, finish, reset, reset_all).
> >
> > Qemu-io uses the new APIs to perform zoned storage commands of the devi=
ce:
> > zone_report(zrp), zone_open(zo), zone_close(zc), zone_reset(zrs),
> > zone_finish(zf).
> >
> > For example, to test zone_report, use following command:
> > $ ./build/qemu-io --image-opts -n driver=3Dhost_device, filename=3D/dev=
/nullb0
> > -c "zrp offset nr_zones"
>=20
> Hi; Coverity points out an issue in this commit (CID 1544771):
>=20
> > +static int zone_report_f(BlockBackend *blk, int argc, char **argv)
> > +{
> > +    int ret;
> > +    int64_t offset;
> > +    unsigned int nr_zones;
> > +
> > +    ++optind;
> > +    offset =3D cvtnum(argv[optind]);
> > +    ++optind;
> > +    nr_zones =3D cvtnum(argv[optind]);
>=20
> cvtnum() can fail and return a negative value on error
> (e.g. if the number in the string is out of range),
> but we are not checking for that. Instead we stuff
> the value into an 'unsigned int' and then pass that to
> g_new(), which will result in our trying to allocate a large
> amount of memory.
>=20
> Here, and also in the other functions below that use cvtnum(),
> I think we should follow the pattern for use of that function
> that is used in the pre-existing code in this function:
>=20
>  int64_t foo; /* NB: not an unsigned or some smaller type */
>=20
>  foo =3D cvtnum(arg)
>  if (foo < 0) {
>      print_cvtnum_err(foo, arg);
>      return foo; /* or otherwise handle returning an error upward */
>  }
>=20
> It looks like all the uses of cvtnum in this patch should be
> adjusted to handle errors.

Thanks for letting me know. I will send a patch.

Stefan

--evVfc2bZ/OH8O6xW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY6RB8ACgkQnKSrs4Gr
c8g8kAgAxj4bwKXeYT8BKNFRjR/8G+m/TrpTmXgPwgOBCGGBcA4XvLNzMqDXlM4T
H+dv8UrKzKWI0l3RlQ37/DgWd7T4Wcc/f7BeUFTtFnOovPJ/CPtIuEgK28WwBZ0V
IRIP+yHusXY+AJ7TDvdrfrQlcY/tyZFoWUaQGw+DJDhWQWUcgGNBSs7y7IVBwf+f
XNjPFHLywD0Ct5leYJ50spSZlsBRPUZn+bqSoLcg6hb8OrWGR0j0DEAnqf3YqkVQ
A6e2sWnX5aRFnQJiy3HGretXG7IhTlP9oNRdlpNb076RawCUVshf9TmGIytxbTnm
H59Wlb6Tbi7aFVkbLj+Ufy7Qd8ELEg==
=h4Ah
-----END PGP SIGNATURE-----

--evVfc2bZ/OH8O6xW--



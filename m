Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE0CF34AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiXq-0006Xp-5e; Wed, 19 Nov 2025 08:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLiXo-0006X0-9p
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLiXm-0004CK-HD
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763560101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsySjUAW/OC81jZhGvxSBn3taIt42d+Gp2Dn5EiAh3I=;
 b=WAg03mFpf54yDXLZF5qTaxZ3c+wfDAyoSZpKJZP8A0MH8YbjuFvHAvwjaHZ4gzAMuOjPeZ
 vSqKoY/wS7zPjBGJuUO5OcoGA/otBQLdq6NJHZj+LnQoT/niwodiWC2Svq9WzRdXmF09yi
 WUotWLcjcOoMYbONFOAo2a0ugntcG4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-c9AsqnwVO_K6HMYJOAg8Tg-1; Wed,
 19 Nov 2025 08:48:20 -0500
X-MC-Unique: c9AsqnwVO_K6HMYJOAg8Tg-1
X-Mimecast-MFC-AGG-ID: c9AsqnwVO_K6HMYJOAg8Tg_1763560096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC8DB180035F; Wed, 19 Nov 2025 13:48:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A14B18004A3; Wed, 19 Nov 2025 13:48:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A94D221E6A27; Wed, 19 Nov 2025 14:48:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,  qemu-devel@nongnu.org,
 kwolf@redhat.com,  hreitz@redhat.com,  mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  gengdongjiu1@gmail.com,
 peter.maydell@linaro.org,  alistair@alistair23.me,
 edgar.iglesias@gmail.com,  npiggin@gmail.com,  harshpb@linux.ibm.com,
 palmer@dabbelt.com,  liwei1518@gmail.com,  dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,  sstabellini@kernel.org,
 anthony@xenproject.org,  paul@xen.org,  peterx@redhat.com,
 farosas@suse.de,  eblake@redhat.com,  vsementsov@yandex-team.ru,
 eduardo@habkost.net,  marcel.apfelbaum@gmail.com,  philmd@linaro.org,
 wangyanan55@huawei.com,  zhao1.liu@intel.com,  qemu-block@nongnu.org,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 5/5] error: Consistently name Error * objects err, and
 not errp
In-Reply-To: <aR3HpH88od11v8qL@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 19 Nov 2025 13:35:32 +0000")
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-6-armbru@redhat.com>
 <3ffe11b9-db81-4930-aefa-e55d758645bf@citrix.com>
 <aR3HpH88od11v8qL@redhat.com>
Date: Wed, 19 Nov 2025 14:48:11 +0100
Message-ID: <87a50ixhes.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 19, 2025 at 01:22:06PM +0000, Andrew Cooper wrote:
>> On 19/11/2025 1:08 pm, Markus Armbruster wrote:
>> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
>> > index b93ff80c85..3e62ec09d0 100644
>> > --- a/hw/xen/xen-pvh-common.c
>> > +++ b/hw/xen/xen-pvh-common.c
>> > @@ -101,7 +101,7 @@ static void xen_create_virtio_mmio_devices(XenPVHM=
achineState *s)
>> >  #ifdef CONFIG_TPM
>> >  static void xen_enable_tpm(XenPVHMachineState *s)
>> >  {
>> > -    Error *errp =3D NULL;
>> > +    Error *err =3D NULL;
>> >      DeviceState *dev;
>> >      SysBusDevice *busdev;
>> >=20=20
>> > @@ -111,8 +111,15 @@ static void xen_enable_tpm(XenPVHMachineState *s)
>> >          return;
>> >      }
>> >      dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);
>> > -    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp=
);
>> > -    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
>> > +    /*
>> > +     * FIXME This use of &err is is wrong.  If both calls fail, the
>> > +     * second will trip error_setv()'s assertion.  If just one call
>> > +     * fails, we leak an Error object.  Setting the same property
>> > +     * twice (first to a QOM path, then to an ID string) is almost
>> > +     * certainly wrong, too.
>> > +     */
>> > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &err);
>> > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &err);
>>=20
>> To your question, I don't know the answer, but I think it's far more
>> likely that the original author didn't grok the proper use of &errp,
>> than for this behaviour to be intentional.
>>=20
>> Surely we just want a failure path and abort the construction if this
>> goes wrong?
>
> In the caller of xen_enable_tpm, we just have error_report+exit calls,
> so there's no error propagation ability in the call chain.
>
> The caller will also skip  xen_enable_tpm unless a TPM was explicitly
> requested in the config.
>
> Given that, I'm inclined to say that the object_property_set_* calls
> in xen_enable_tpm should be using &error_abort, as a failure to setup
> the explicitly requested TPM should be fatal.

I *suspect* that the first call always fails, and the second one always
works.  If that's the case, the fix is to delete the first call, and
pass &error_abort to the second.



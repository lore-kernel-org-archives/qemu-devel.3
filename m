Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C00606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fScJfdlh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRAmD-0008FD-JP; Wed, 11 Nov 2026 11:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xRAmA-0008Ep-0e
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:02:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xRAm8-0006Zt-EU
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794412934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZqm85WGCaPppeoTXGqoctW6MZBEKDvV92GU7M9ROxk=;
 b=fScJfdlhkzwCCLc9fF7qw8RlAcQHYVfedUmb8A4wWJ+RyOe4ecAaP08tJEAKXB7JS+TPTA
 xYt1jaky3C33mwePZJw7SlPMop4nIP+c5QGLwXbpKYtc30vCs2p23hmiiriokKKBIlt9Sz
 YhW86RxFl4JWdjF+RPlKOGYuO19ObBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-1PxWf8hNOgGVZ9gdWLuejA-1; Wed,
 11 Nov 2026 11:02:12 -0500
X-MC-Unique: 1PxWf8hNOgGVZ9gdWLuejA-1
X-Mimecast-MFC-AGG-ID: 1PxWf8hNOgGVZ9gdWLuejA_1794412929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 321F91955DA2; Wed, 11 Nov 2026 16:02:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CDBE30000D3; Wed, 11 Nov 2026 16:02:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, David Hildenbrand
 <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Halil Pasic <pasic@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <avR4m8ZtI-m8-V4r@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <87bj7vwokb.fsf@pond.sub.org> <avRfKD2snrmJC3c-@redhat.com>
 <87jymjwl0w.fsf@redhat.com> <avR4m8ZtI-m8-V4r@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Wed, 11 Nov 2026 17:02:05 +0100
Message-ID: <87h5hnwe4i.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Nov 11, 2026 at 02:33:03PM +0100, Cornelia Huck wrote:
>> On Wed, Nov 11 2026, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> > On Wed, Nov 11, 2026 at 01:16:36PM +0100, Markus Armbruster wrote:
>> >> Peter Maydell <peter.maydell@linaro.org> writes:
>> >>=20
>> >> > On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
>> >> >>
>> >> >> On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
>> >> >> > My build of qemu-system-x86_64 has device sgx-epc:
>> >> >> >
>> >> >> >  --> {"execute": "qom-list-types", "arguments": {"implements": "=
sgx-epc"}}
>> >> >> >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
>> >> >> >
>> >> >> > The device as a link property to a memory-backend-epc:
>> >> >> >
>> >> >> >  --> {"execute": "qom-list-properties", "arguments": {"typename"=
: "sgx-epc"}}
>> >> >> >  <-- {"return": [...
>> >> >> >                  {"name": "memdev", "type": "link<memory-backend=
-epc>"},
>> >> >> >                  ...]}
>> >> >> >
>> >> >> > However, type memory-backend-epc does not exist:
>> >> >
>> >> >> There is some rather dubious code that conditionally registers
>> >> >> the type
>> >> >>
>> >> >> static void register_types(void)
>> >> >> {
>> >> >>     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
>> >> >>     if (fd >=3D 0) {
>> >> >>         close(fd);
>> >> >>
>> >> >>         type_register_static(&sgx_epc_backed_info);
>> >> >>     }
>> >> >> }
>> >> >>
>> >> >>
>> >> >> Normal practice is for types to be unconditionally registered.  Do=
 we
>> >> >> have any examples outside of this SGX case where we conditionally
>> >> >> register types ?   Should we change this to follow normal practice=
 ?
>> >> >
>> >> > TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
>> >> > "calls to type_register not indented by exactly 4 spaces" and
>> >> > I think the other cases are "misindented" or "data-driven
>> >> > type registration" rather than trying to do things conditionally
>> >> > (but I didn't actually look at all of them, instead making
>> >> > guesses based on variable names, so maybe there's one or two
>> >> > more I missed).
>> >>=20
>> >> Alright, I looked.  In addition to "misindented" or "data-driven", I
>> >> found:
>> >>=20
>> >> * register_types() in hostmem-memfd.c registers "memory-backend-memfd"
>> >>   only when a test of memfd_create() succeeds.  This is what Peter
>> >>   reported.
>> >>=20
>> >> * virtio_ccw_gpu_register() in hw/s390x/virtio-ccw-gpu.c registers
>> >>   "virtio-gpu-ccw" only when have_virtio_ccw, which is true when
>> >>   hw/s390x/virtio-ccw.c gets compiled into the binary.  So it's
>> >>   effectively compile-time conditional.
>> >>=20
>> >>   I wish it was literally compile-time conditional, either in meson or
>> >>   using #if.
>> >
>> > That looks like it is dead code to me. hw/s390x/meson.build does
>> >
>> >   hw_s390x_modules =3D {}
>> >   virtio_gpu_ccw_ss =3D ss.source_set()
>> >   virtio_gpu_ccw_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_CCW=
'],
>> >                         if_true: [files('virtio-ccw-gpu.c'), pixman])
>> >   hw_s390x_modules +=3D {'virtio-gpu-ccw': virtio_gpu_ccw_ss}
>> >
>> > it doesn't look like 'have_virtio_ccw' can ever be false, due
>> > to the CONFIG_VIRTIO_CCW Kconfig check ?
>>=20
>> adcf33a504de ("s390x: modularize virtio-gpu-ccw") seems to indicate that
>> this is needed for virtio-gpu-ccw being a module, not sure if that is
>> still the case.
>
> I'm not understanding why modules affects this though ?

Yeah, me neither.

>
> If CONFIG_VIRTIO_CCW is set, then we know virtio-ccw is builtin,
> and the module loading for virtio-gpu-ccw is fine.
>
> If CONFIG_VIRTIO_CCW is unset, then neither virtio-gpu-ccw or
> virtio-ccw are built at all, so there's no module to load.

Gerd, Halil: do you remember why this is needed?



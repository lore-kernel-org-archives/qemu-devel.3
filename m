Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAxc7zsR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLarS-0004mw-Sh; Tue, 27 Oct 2026 02:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLarN-0004ll-D2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLarK-00012A-Na
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793083232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5z5W3Z46pEbzuofmxiQmotzJ2y3VKzyTvyPnwigDQqk=;
 b=bAxc7zsRzs1WliroRpbsjYGJ6JF7DBJQ0XmwB3IINo/yGIGLI+RdceeHkqQ/L76+DwocJn
 GtKBUhDgdKeIgQF4ifeTQv8i6lx1c/sUPR9FCHs/0FW8w0i496y+F84bqxgL0DWBStrROu
 7pggW0rG8asrjhvz9o1u2hIWlQ8qG70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-5ypPBClDNFusxljbORYHvw-1; Tue,
 27 Oct 2026 02:40:29 -0400
X-MC-Unique: 5ypPBClDNFusxljbORYHvw-1
X-Mimecast-MFC-AGG-ID: 5ypPBClDNFusxljbORYHvw_1793083228
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B93C51800BC6; Tue, 27 Oct 2026 06:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CEFF1800444; Tue, 27 Oct 2026 06:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE20521E6A04; Tue, 27 Oct 2026 07:40:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  David
 Hildenbrand <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <attACqgQQ-Lxt5Pj@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 23 Oct 2026 12:07:54 +0100")
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com>
Date: Tue, 27 Oct 2026 07:40:24 +0100
Message-ID: <87ecdbbq93.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 23, 2026 at 11:44:10AM +0100, Peter Maydell wrote:
>> On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> >
>> > On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
>> > > My build of qemu-system-x86_64 has device sgx-epc:
>> > >
>> > >  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-=
epc"}}
>> > >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
>> > >
>> > > The device as a link property to a memory-backend-epc:
>> > >
>> > >  --> {"execute": "qom-list-properties", "arguments": {"typename": "s=
gx-epc"}}
>> > >  <-- {"return": [...
>> > >                  {"name": "memdev", "type": "link<memory-backend-epc=
>"},
>> > >                  ...]}
>> > >
>> > > However, type memory-backend-epc does not exist:
>>=20
>> > There is some rather dubious code that conditionally registers
>> > the type
>> >
>> > static void register_types(void)
>> > {
>> >     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
>> >     if (fd >=3D 0) {
>> >         close(fd);
>> >
>> >         type_register_static(&sgx_epc_backed_info);
>> >     }
>> > }
>> >
>> >
>> > Normal practice is for types to be unconditionally registered.  Do we
>> > have any examples outside of this SGX case where we conditionally
>> > register types ?   Should we change this to follow normal practice ?
>>=20
>> TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
>> "calls to type_register not indented by exactly 4 spaces" and
>> I think the other cases are "misindented" or "data-driven
>> type registration" rather than trying to do things conditionally
>> (but I didn't actually look at all of them, instead making
>> guesses based on variable names, so maybe there's one or two
>> more I missed).
>>=20
>> I guess maybe this is trying to work around the fact that the
>> memory backend API doesn't give a backend any place to say
>> "this is never going to work" early, because instance_init isn't
>> allowed to fail, these objects aren't TYPE_DEVICE so they
>> don't have "realize", and so the only other option is
>> "fail every alloc call" ?
>
> The memory backends are all implementing the UserCreatable
> interface, which provides a "complete" method where they
> could gracefully report lack of the feature via 'errp'.

Yes.

> This is not obvious since UserCreatable is implemented in
> the parent base class, but the subclasses could provide
> their own  'complete' impl and chain up the parent impl

David, Igor, can you clean this up?  Or would you like me to try?



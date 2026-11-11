Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44970606A88C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YxJiocIh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Ft-0007Wb-UN; Wed, 11 Nov 2026 07:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Ft-0007Vu-15
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Fr-0005C7-EZ
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+3dNTb5C6Yaz6YPsOrwsde4hWWwrBWk01C5joDfFzs=;
 b=YxJiocIhCNrvyc5kvSRqiwDZPS5CFirUEd+7bTihF4LOvNnMgS29lCmbUde+5R8iHjxXaf
 ipJz62DHNjurU0iz18av45fRpj9rKIXMLvFriY9kSUGEUhItK7k0PYeO8OavDuMuC7J6Xb
 tQlbHhs90ydoh46nJ/KUsJW89VGR6Nk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-5EuLuomhPwObE-FY1lrdsA-1; Wed,
 11 Nov 2026 07:16:41 -0500
X-MC-Unique: 5EuLuomhPwObE-FY1lrdsA-1
X-Mimecast-MFC-AGG-ID: 5EuLuomhPwObE-FY1lrdsA_1794399399
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541D018011E1; Wed, 11 Nov 2026 12:16:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0CB6588; Wed, 11 Nov 2026 12:16:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CDA221E6A04; Wed, 11 Nov 2026 13:16:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  David
 Hildenbrand <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 (Peter Maydell's message of "Fri, 23 Oct 2026 11:44:10 +0100")
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
Date: Wed, 11 Nov 2026 13:16:36 +0100
Message-ID: <87bj7vwokb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
>> > My build of qemu-system-x86_64 has device sgx-epc:
>> >
>> >  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-ep=
c"}}
>> >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
>> >
>> > The device as a link property to a memory-backend-epc:
>> >
>> >  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx=
-epc"}}
>> >  <-- {"return": [...
>> >                  {"name": "memdev", "type": "link<memory-backend-epc>"=
},
>> >                  ...]}
>> >
>> > However, type memory-backend-epc does not exist:
>
>> There is some rather dubious code that conditionally registers
>> the type
>>
>> static void register_types(void)
>> {
>>     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
>>     if (fd >=3D 0) {
>>         close(fd);
>>
>>         type_register_static(&sgx_epc_backed_info);
>>     }
>> }
>>
>>
>> Normal practice is for types to be unconditionally registered.  Do we
>> have any examples outside of this SGX case where we conditionally
>> register types ?   Should we change this to follow normal practice ?
>
> TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
> "calls to type_register not indented by exactly 4 spaces" and
> I think the other cases are "misindented" or "data-driven
> type registration" rather than trying to do things conditionally
> (but I didn't actually look at all of them, instead making
> guesses based on variable names, so maybe there's one or two
> more I missed).

Alright, I looked.  In addition to "misindented" or "data-driven", I
found:

* register_types() in hostmem-memfd.c registers "memory-backend-memfd"
  only when a test of memfd_create() succeeds.  This is what Peter
  reported.

* virtio_ccw_gpu_register() in hw/s390x/virtio-ccw-gpu.c registers
  "virtio-gpu-ccw" only when have_virtio_ccw, which is true when
  hw/s390x/virtio-ccw.c gets compiled into the binary.  So it's
  effectively compile-time conditional.

  I wish it was literally compile-time conditional, either in meson or
  using #if.

* qemu_console_early_init() in ui/console-vc.c registers "chardev-vc" if
  it's not already registered.  early_dbus_init() in ui/dbus.c,
  early_gtk_display_init() in ui/gtk.c, and
  spice_app_display_early_init() in ui/spice-app.c all register it.

  These are all QemuDisplay .early_init() callbacks.
  qemu_display_early_init() calls the selected display's .early_init(),
  if non-null.

  Because qemu_console_early_init() runs after
  qemu_display_early_init(), this always registers a "chardev-vc": the
  active display may register its own, and when it doesn't, we get
  ui/console-vc.c's.

  More moving parts than I'd like.

I'm going to post patches for backends/hostmem-{epc,memfd}.c.  I don't
plan to clean up the other two at this time.

[...]



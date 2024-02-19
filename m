Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE0C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4qI-0006yf-Ld; Mon, 19 Feb 2024 09:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4qG-0006yS-8M
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4qD-0005lw-FW
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PywWiBmxcb8yvjCgJbUBCRZXDUktOG9Db5gcFJ2aPrA=;
 b=geAq3gDOPseNUm6b9fv2nup7Vt5gY3LqhfIEwa76d8KyGw4qkl+M2VzrdkHIgR2HyTwhvF
 eOdN3SZsL+1wy7vtDmWAwaZ4OQkVXeUfbEIkgO8RDYG9v/D6aQSifm1b/U3nelzTIFPg5p
 8mMZHOkedzNk6L3CqlTyp3YBgYdhgck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-O5LS3iXeP-edt_hL1vKX6Q-1; Mon, 19 Feb 2024 09:41:52 -0500
X-MC-Unique: O5LS3iXeP-edt_hL1vKX6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9994088F2EC;
 Mon, 19 Feb 2024 14:41:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 426BD1121306;
 Mon, 19 Feb 2024 14:41:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1885921E66D0; Mon, 19 Feb 2024 15:41:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Cornelia Huck
 <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Michael Roth
 <michael.roth@amd.com>,  Sean Christopherson <seanjc@google.com>,  Claudio
 Fontana <cfontana@suse.de>,  Gerd Hoffmann <kraxel@redhat.com>,  Isaku
 Yamahata <isaku.yamahata@gmail.com>,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 50/66] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
In-Reply-To: <ZdNPpcNiGcY4Jefi@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 19 Feb 2024 12:55:01 +0000")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-51-xiaoyao.li@intel.com>
 <87zfvwehyz.fsf@pond.sub.org> <ZdNPpcNiGcY4Jefi@redhat.com>
Date: Mon, 19 Feb 2024 15:41:49 +0100
Message-ID: <8734tojz2q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, Feb 19, 2024 at 01:50:12PM +0100, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>=20
>> > From: Isaku Yamahata <isaku.yamahata@intel.com>
>> >
>> > Add property "quote-generation-socket" to tdx-guest, which is a proper=
ty
>> > of type SocketAddress to specify Quote Generation Service(QGS).
>> >
>> > On request of GetQuote, it connects to the QGS socket, read request
>> > data from shared guest memory, send the request data to the QGS,
>> > and store the response into shared guest memory, at last notify
>> > TD guest by interrupt.
>> >
>> > command line example:
>> >   qemu-system-x86_64 \
>> >     -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-soc=
ket":{"type": "vsock", "cid":"1","port":"1234"}}' \
>> >     -machine confidential-guest-support=3Dtdx0
>> >
>> > Note, above example uses vsock type socket because the QGS we used
>> > implements the vsock socket. It can be other types, like UNIX socket,
>> > which depends on the implementation of QGS.
>> >
>> > To avoid no response from QGS server, setup a timer for the transactio=
n.
>> > If timeout, make it an error and interrupt guest. Define the threshold=
 of
>> > time to 30s at present, maybe change to other value if not appropriate.
>> >
>> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> > Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> > Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> > ---
>> > Changes in v4:
>> > - merge next patch "i386/tdx: setup a timer for the qio channel";
>> >
>> > Changes in v3:
>> > - rename property "quote-generation-service" to "quote-generation-sock=
et";
>> > - change the type of "quote-generation-socket" from str to
>> >   SocketAddress;
>> > - squash next patch into this one;
>> > ---
>> >  qapi/qom.json                         |   6 +-
>> >  target/i386/kvm/meson.build           |   2 +-
>> >  target/i386/kvm/tdx-quote-generator.c | 170 ++++++++++++++++++++
>> >  target/i386/kvm/tdx-quote-generator.h |  95 +++++++++++
>> >  target/i386/kvm/tdx.c                 | 216 ++++++++++++++++++++++++++
>> >  target/i386/kvm/tdx.h                 |   6 +
>> >  6 files changed, 493 insertions(+), 2 deletions(-)
>> >  create mode 100644 target/i386/kvm/tdx-quote-generator.c
>> >  create mode 100644 target/i386/kvm/tdx-quote-generator.h
>> >
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 15445f9e41fc..c60fb5710961 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -914,13 +914,17 @@
>> >  #     e.g., specific to the workload rather than the run-time or OS.
>> >  #     base64 encoded SHA384 digest.
>> >  #
>> > +# @quote-generation-socket: socket address for Quote Generation
>> > +#     Service(QGS)
>>=20
>> Space between "Service" and "(QGS)", please.
>>=20
>> The description feels too terse.  What is the "Quote Generation
>> Service", and why should I care?
>
> The "Quote Generation Service" is a daemon running on the host.
> The reference implementation is at
>
>   https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master=
/QuoteGeneration/quote_wrapper/qgs
>
> If you don't provide this, then quests won't bet able to generate
> quotes needed for attestation. So although this is technically
> optional, in practice for a sane deployment, an admin should always
> provide this

Thanks.  Care to work some of this information into the doc comment?

>> > +#
>> >  # Since: 9.0
>> >  ##
>> >  { 'struct': 'TdxGuestProperties',
>> >    'data': { '*sept-ve-disable': 'bool',
>> >              '*mrconfigid': 'str',
>> >              '*mrowner': 'str',
>> > -            '*mrownerconfig': 'str' } }
>> > +            '*mrownerconfig': 'str',
>> > +            '*quote-generation-socket': 'SocketAddress' } }
>> >=20=20
>> >  ##
>> >  # @ThreadContextProperties:
>>=20
>> [...]
>>=20
>
> With regards,
> Daniel



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EED2C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfz3o-0006Mb-Gz; Thu, 06 Feb 2025 05:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfz3m-0006MP-SJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfz3k-00067q-Cn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738837475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1JJwh6yF/IsT6sxd11Y4Ef5wsz/K3dI/+2i6YU4egY=;
 b=bgbNBMQmP+2XGIt4SNx+ilanf4AbJuJC1jTu/rgXNZsme+6kcDb3TELlG1SaWuWaNzVb1t
 OoYEI9pQej38mMkDSinYsDcJr9WfEwBCFxwUCfWnTGcLnrkrqvFPT3OpOSa+SnOKkT7XgP
 qlMJz0MWmPjbfuNF3i3ybojIeM+F/jw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-GwQ5mL2yOECZrkG943ojpQ-1; Thu,
 06 Feb 2025 05:24:30 -0500
X-MC-Unique: GwQ5mL2yOECZrkG943ojpQ-1
X-Mimecast-MFC-AGG-ID: GwQ5mL2yOECZrkG943ojpQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE9CE1956088; Thu,  6 Feb 2025 10:24:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5403830001AB; Thu,  6 Feb 2025 10:24:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27B7321E6A28; Thu, 06 Feb 2025 11:24:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric Auger
 <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Sebastian
 Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <Z6SEIqhJEWrMWTU1@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 6 Feb 2025 09:42:58 +0000")
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
 <Z6SEIqhJEWrMWTU1@redhat.com>
Date: Thu, 06 Feb 2025 11:24:25 +0100
Message-ID: <878qqjqskm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 06, 2025 at 05:54:32PM +0800, Zhao Liu wrote:
>> On Wed, Feb 05, 2025 at 11:07:10AM +0100, Markus Armbruster wrote:
>> > Date: Wed, 05 Feb 2025 11:07:10 +0100
>> > From: Markus Armbruster <armbru@redhat.com>
>> > Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask
>> >  format in KVM PMU filter
>> >=20
>> > Zhao Liu <zhao1.liu@intel.com> writes:
>> >=20
>> > > The select&umask is the common way for x86 to identify the PMU event,
>> > > so support this way as the "x86-default" format in kvm-pmu-filter
>> > > object.
>> >=20
>> > So, format 'raw' lets you specify the PMU event code as a number, wher=
as
>> > 'x86-default' lets you specify it as select and umask, correct?
>>=20
>> Yes!
>>=20
>> > Why do we want both?
>>=20
>> This 2 formats are both wildly used in x86(for example, in perf tool).
>>=20
>> x86 documents usually specify the umask and select fields.
>>=20
>> But raw format could also be applied for ARM since ARM just uses a number
>> to encode event.

Is it really too much to ask of the client to compute a raw value from
umask and select values?

>> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> >=20
>> > [...]
>> >=20
>> > > diff --git a/qapi/kvm.json b/qapi/kvm.json
>> > > index d51aeeba7cd8..93b869e3f90c 100644
>> > > --- a/qapi/kvm.json
>> > > +++ b/qapi/kvm.json
>> > > @@ -27,11 +27,13 @@
>> > >  #
>> > >  # @raw: the encoded event code that KVM can directly consume.
>> > >  #
>> > > +# @x86-default: standard x86 encoding format with select and umask.
>> >=20
>> > Why is this named -default?
>>=20
>> Intel and AMD both use umask+select to encode events, but this format
>> doesn't have a name... so I call it `default`, or what about
>> "x86-umask-select"?

Works for me.

>> > > +#
>> > >  # Since 10.0
>> > >  ##
>> > >  { 'enum': 'KVMPMUEventEncodeFmt',
>> > >    'prefix': 'KVM_PMU_EVENT_FMT',
>> > > -  'data': ['raw'] }
>> > > +  'data': ['raw', 'x86-default'] }
>> > >=20=20
>> > >  ##
>> > >  # @KVMPMURawEvent:
>> > > @@ -46,6 +48,25 @@
>> > >  { 'struct': 'KVMPMURawEvent',
>> > >    'data': { 'code': 'uint64' } }
>> > >=20=20
>> > > +##
>> > > +# @KVMPMUX86DefalutEvent:
>> >=20
>> > Default, I suppose.
>>=20
>> Thanks!
>>=20
>> > > +#
>> > > +# x86 PMU event encoding with select and umask.
>> > > +# raw_event =3D ((select & 0xf00UL) << 24) | \
>> > > +#              (select) & 0xff) | \
>> > > +#              ((umask) & 0xff) << 8)
>> >=20
>> > Sphinx rejects this with "Unexpected indentation."
>> >=20
>> > Is the formula needed here?
>>=20
>> I tried to explain the relationship between raw format and umask+select.
>>=20
>> Emm, where do you think is the right place to put the document like
>> this?

Do users need to know how to compute the raw event value from @select
and @umask?

If yes, is C code the best way?

Here's another way:

    bits  0..7 : bits 0..7 of @select
    bits  8..15: @umask
    bits 24..27: bits 8..11 of @select
    all other bits: zero

>> ...
>>=20
>> > > +##
>> > > +# @KVMPMUX86DefalutEventVariant:
>
> Typo   s/Defalut/Default/ - repeated many times in this patch.
>
>> > > +#
>> > > +# The variant of KVMPMUX86DefalutEvent with the string, rather than
>> > > +# the numeric value.
>> > > +#
>> > > +# @select: x86 PMU event select field.  This field is a 12-bit
>> > > +#     unsigned number string.
>> > > +#
>> > > +# @umask: x86 PMU event umask field. This field is a uint8 string.
>> >=20
>> > Why are these strings?  How are they parsed into numbers?
>>=20
>> In practice, the values associated with PMU events (code for arm, select&
>> umask for x86) are often expressed in hexadecimal. Further, from linux
>> perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
>> arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
>> s390 uses decimal value.
>>=20
>> Therefore, it is necessary to support hexadecimal in order to honor PMU
>> conventions.
>
> IMHO having a data format that matches an arbitrary external tool is not
> a goal for QMP. It should be neutral and exclusively use the normal JSON
> encoding, ie base-10 decimal. Yes, this means a user/client may have to
> convert from hex to dec before sending data over QMP. This is true of
> many areas of QMP/QEMU config though and thus normal/expected behaviour.

Concur.



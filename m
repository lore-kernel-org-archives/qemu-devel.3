Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5967CFC72A8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ZeP-00067s-7R; Mon, 23 Mar 2026 03:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4ZeN-000676-1G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4ZeC-0000kA-Sq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774250662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5fpN+to2H34GvzMy4uc4/TyuJdurXy6MBQlxOrclng=;
 b=Wq39ltQQpqivrfZEb0mdJ6G8aJjIYXN5WEbrN+rSnXdIKs9H+mT4AUXWvvDz5Z5HxsoSGq
 +ExqxST8n2JWIRAKqkGabsv72OLh5botIOmf0WzxXkRVqfvcpbYP66lsFRSsf+FEuVu0Yx
 95cV/X9A5U7gZp9Pbt0fvln+knWB/18=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-OWGcTqnNM3KvCLrl65zUlQ-1; Mon,
 23 Mar 2026 03:24:18 -0400
X-MC-Unique: OWGcTqnNM3KvCLrl65zUlQ-1
X-Mimecast-MFC-AGG-ID: OWGcTqnNM3KvCLrl65zUlQ_1774250657
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D18E91955DB6; Mon, 23 Mar 2026 07:24:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06544180058B; Mon, 23 Mar 2026 07:24:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E02F21E6937; Mon, 23 Mar 2026 08:24:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tommaso Califano <califano.tommaso@gmail.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Eduardo Habkost <eduardo@habkost.net>,  Zhao Liu
 <zhao1.liu@intel.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Giuseppe Lettieri
 <giuseppe.lettieri@unipi.it>,  Paolo Bonzini <pbonzini@redhat.com>,  Luigi
 Leonardi <leonardi@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
In-Reply-To: <ab1ALDdqxwSWxPOx@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 20 Mar 2026 12:40:12 +0000")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <87eclfj66v.fsf@pond.sub.org>
 <ab1ALDdqxwSWxPOx@redhat.com>
Date: Mon, 23 Mar 2026 08:24:13 +0100
Message-ID: <87h5q7100y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Fri, Mar 20, 2026 at 08:44:40AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>> >> With this change it is possible to run a VM with the SEV CPUID active
>> >> adding:
>> >>=20
>> >>     -accel tcg \
>> >>     -object sev-emulated,id=3Dsev0,cbitpos=3D47,reduced-phys-bits=3D1=
 \
>> >>     -machine memory-encryption=3Dsev0
>> >
>> > snip
>> >
>> >> diff --git a/qapi/qom.json b/qapi/qom.json
>> >> index c653248f85..35cda819ec 100644
>> >> --- a/qapi/qom.json
>> >> +++ b/qapi/qom.json
>> >> @@ -1057,6 +1057,19 @@
>> >>              '*handle': 'uint32',
>> >>              '*legacy-vm-type': 'OnOffAuto' } }
>> >>=20=20
>> >> +##
>> >> +# @SevEmulatedProperties:
>> >> +#
>> >> +# Properties for sev-emulated objects.
>> >> +# This object functionally emulates AMD SEV hardware via TCG, so
>> >> +# it does not require real hardware to run.
>> >> +#
>> >> +# Since: 10.1.0
>> >> +##
>> >> +{ 'struct': 'SevEmulatedProperties',
>> >> +  'base': 'SevGuestProperties',
>> >> +  'data': {}}
>> >
>> > This is deriving 'sev-emulated' from 'sev-guest' which means it
>> > supports all the properties that 'sev-guest' does, which for
>> > the record is:
>>=20
>> Uh, I somehow misread the base as SevCommonProperties!  Had I read
>> correctly, I would've had similar questions.
>
> Even SevCommonProperties has stuff that's irrelevant for
> emulation that I mentioned.

Yes.  I was too hasty.  Glad you spotted it!



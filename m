Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E2D167E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 09:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8ps-0003w2-Lr; Fri, 09 Jan 2026 04:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve8pS-0003lk-E3
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve8pO-0003da-7d
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767951040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7D3wJsRoUQFpkz+nwVP/SWQLABnNWT7fTShKxG/tM6M=;
 b=ShvCfFZARdoWccCeQJ4TC81jMscmUTdOSl0mOtoHZENiOJZCJ4tnOr0AvocrWIOoAFsH79
 a1XfI3aKgIuVJXHw/H8+4T+FeOhQEZii0Ivic4dE72YK9bgD2Pk1PPmpZG3vwkeNidfzJ3
 SW/6DGTwdoXg7fM1W2M4HT3cj7kRK4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-tATHLlWJN2WRLHu6i0VSig-1; Fri,
 09 Jan 2026 04:30:36 -0500
X-MC-Unique: tATHLlWJN2WRLHu6i0VSig-1
X-Mimecast-MFC-AGG-ID: tATHLlWJN2WRLHu6i0VSig_1767951036
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D00B41956094; Fri,  9 Jan 2026 09:30:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CB231956048; Fri,  9 Jan 2026 09:30:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC19921E66C1; Fri, 09 Jan 2026 10:30:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  "open list:X86 KVM CPUs"
 <kvm@vger.kernel.org>
Subject: Re: [PATCH] Add query-tdx-capabilities
In-Reply-To: <aV41CQP0JODTdRqy@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 7 Jan 2026 10:27:21 +0000")
References: <20260106183620.2144309-1-marcandre.lureau@redhat.com>
 <aV41CQP0JODTdRqy@redhat.com>
Date: Fri, 09 Jan 2026 10:30:32 +0100
Message-ID: <87qzrzku9z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@redhat.com wro=
te:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> Return an empty TdxCapability struct, for extensibility and matching
>> query-sev-capabilities return type.
>>=20
>> Fixes: https://issues.redhat.com/browse/RHEL-129674
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi/misc-i386.json        | 30 ++++++++++++++++++++++++++++++
>>  target/i386/kvm/kvm_i386.h |  1 +
>>  target/i386/kvm/kvm.c      |  5 +++++
>>  target/i386/kvm/tdx-stub.c |  8 ++++++++
>>  target/i386/kvm/tdx.c      | 21 +++++++++++++++++++++
>>  5 files changed, 65 insertions(+)
>>=20
>> diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
>> index 05a94d6c416..f10e4338b48 100644
>> --- a/qapi/misc-i386.json
>> +++ b/qapi/misc-i386.json
>> @@ -225,6 +225,36 @@
>>  ##
>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
>>=20=20
>> +##
>> +# @TdxCapability:
>> +#
>> +# The struct describes capability for Intel Trust Domain Extensions
>> +# (TDX) feature.
>> +#
>> +# Since: 11.0
>> +##
>> +{ 'struct': 'TdxCapability',
>> +  'data': { } }
>> +
>> +##
>> +# @query-tdx-capabilities:
>> +#
>> +# Get TDX capabilities.
>> +#
>> +# This is only supported on Intel X86 platforms with KVM enabled.
>> +#
>> +# Errors:
>> +#     - If TDX is not available on the platform, GenericError
>> +#
>> +# Since: 11.0
>> +#
>> +# .. qmp-example::
>> +#
>> +#     -> { "execute": "query-tdx-capabilities" }
>> +#     <- { "return": {} }
>> +##
>> +{ 'command': 'query-tdx-capabilities', 'returns': 'TdxCapability' }
>
> This matches the conceptual design used with query-sev-capabilities,
> where the lack of SEV support has to be inferred from the command
> returning "GenericError".

Such guesswork is brittle.  An interface requiring it is flawed, and
should be improved.

Our SEV interface doesn't actually require it: query-sev tells you
whether we have SEV.  Just run that first.

This patch adds query-tdx-capabilities without query-tdx.  This results
in a flawed interface.

Should we add a query-tdx instead?

>                           On the one hand this allows the caller to
> distinguish different scenarios - unsupported due to lack of HW
> support, vs unsupported due to lack of KVM support. On the other
> hand 'GenericError' might reflect other things that should be
> considered fatal errors, rather than indicitive of lack of support
> in the host.
>
> With the other 'query-sev' command, we have "enabled: bool" field,
> and when enabled =3D=3D false, the other fields are documented to have
> undefined values.

Clunky, but works.

The doc comment calls them "unspecified", which is more precise.

> I tend towards suggesting that 'query-sev-capabilities' (and thus
> also this new query-tdx-capabilities) should have been more like
> query-sev,  and had a a "supported: bool" field to denote the lack
> of support in the host.

Maybe.  What we have there is workable, though.

> This would not have allowed callers to disinguish the reason why
> SEV/TDX is not supported (hardware vs KVM), but I'm not sure that
> reason matters for callers - lack of KVM support is more of an
> OS integration problem.

Let's not complicate interfaces without an actual use case :)

[...]



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E26E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEBq-00008p-UB; Mon, 16 Dec 2024 11:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tNEBX-000067-JT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tNEBV-0002zl-Nh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734367383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFVa/sJM9ABzS/W1XUZRvqhtM4Bslw6gR5ZuKKtZEgA=;
 b=LcxQnIace6b0ExG9jdXG7gNsBZLSRtxiySB6SIDwqbJRd8rtz2SCZ89VRyotvQqQk7jTHK
 IdmlPjMFg2k8HtROoK7xLzo1wsDgNidUZ2+SIq+iIeWXMqcvLGxfa14N6aoB3itixfw5aZ
 ryyvS7L3fRiSGJ5bxMwGnTHTE2uyjr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-OGmfvbv7NMa738s8YR0r-Q-1; Mon,
 16 Dec 2024 11:43:00 -0500
X-MC-Unique: OGmfvbv7NMa738s8YR0r-Q-1
X-Mimecast-MFC-AGG-ID: OGmfvbv7NMa738s8YR0r-Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B49001955F45; Mon, 16 Dec 2024 16:42:56 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4390730044C1; Mon, 16 Dec 2024 16:42:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
In-Reply-To: <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 16 Dec 2024 17:42:50 +0100
Message-ID: <87wmfzbmut.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Thu, Dec 12 2024, Eric Auger <eric.auger@redhat.com> wrote:

> Connie,
>
> On 12/6/24 12:21, Cornelia Huck wrote:
>> Whether it make sense to continue with the approach of tweaking values in
>> the ID registers in general. If we want to be able to migrate between cp=
us
>> that do not differ wildly, we'll encounter differences that cannot be
>> expressed via FEAT_xxx -- e.g. when comparing various AmpereAltra Max sy=
stems,
>> they only differ in parts of CTR_EL0 -- which is not a feature register,=
 but
>> a writable register.
> In v1 most of the commenters said they would prefer to see FEAT props
> instead of IDREG field props. I think we shall try to go in this
> direction anyway. As you pointed out there will be some cases where FEAT
> won't be enough (CTR_EL0 is a good example). So I tend to think the end
> solution will be a mix of FEAT and ID reg field props.

Some analysis of FEAT_xxx mappings:
https://lore.kernel.org/qemu-devel/87ikstn8sc.fsf@redhat.com/

(actually, ~190 of FEAT_xxx map to a single value in a single register,
so mappings are easy other than the sheer amount of them)

We probably should simply not support FEAT_xxx that are solely defined
via dependencies.

Some more real-world examples from some cpu pairings I had looked at:
https://lore.kernel.org/qemu-devel/87ldx2krdp.fsf@redhat.com/
(but also see Peter's follow-up, the endianness field is actually
covered by a feature)

The values-in-registers-not-covered-by-features we are currently aware
of are:
- number of breakpoints
- PARange values
- GIC
- some fields in CTR_EL0
(see also
https://lore.kernel.org/qemu-devel/4fb49b5b02bb417399ee871b2c85bb35@huawei.=
com/
for the latter two)

Also, MIDR/REVIDR handling.

Given that we'll need a mix if we support FEAT_xxx, should we mandate
the FEAT_xxx syntax if there is a mapping and allow direct specification
of register fields only if there is none, or allow them as alternatives
(with proper priority handling, or alias handling?)

>
> Personally I would smoothly migrate what we can from ID reg field props
> to FEAT props (maybe using prop aliases?), starting from the easiest 1-1
> mappings and then adressing the FEAT that are more complex but are
> explictly needed to enable the use cases we are interested in, at RedHat:
> migration within Ampere AltraMax family, migration within NVidia Grace
> family, migration within AmpereOne family and migration between Graviton3=
/4.

For these, we'll already need the mix (my examples above all came from
these use cases.)

(Of course, the existing legacy props need to be expressed as well. I
guess they should map to registers directly.)

>
> We have no info about other's use cases. If some of you want to see some
> other live migration combinations addressed, please raise your voice.
> Some CSPs may have their own LM solution/requirements but they don't use
> qemu. So I think we shall concentrate on those use cases.
>
> You did the exercise to identify most prevalent patterns for FEAT to
> IDREG fields mappings. I think we should now encode this conversion
> table for those which are needed in above use cases.

I'd focus on the actually needed features first, as otherwise it's
really overwhelming.

>
> From a named model point of view, since I do not see much traction
> upstream besides Red Hat use cases, targetting ARM spec revision
> baselines may be overkill. Personally I would try to focus on above
> models: AltraMax, AmpereOne, Grace, ... Or maybe the ARM cores they may
> be derived from. According to the discussion we had with Marc in [1] it
> seems it does not make sense to target migration between very
> heterogeneous machines and Dan said we would prefer to avoid adding
> plenty of feat add-ons to a named models. So I would rather be as close
> as possible to a specific family definition.=C2=A0 =C2=A0

Using e.g. Neoverse-V2 as a base currently looks most attractive to
me -- going with Armv<x>.<y> would probably give a larger diff (although
the diff for Graviton3/4 is pretty large anyway.)

>
> Thanks
>
> Eric
>
> [1]
> https://lore.kernel.org/all/c879fda9-db5a-4743-805d-03c0acba8060@redhat.c=
om/#r



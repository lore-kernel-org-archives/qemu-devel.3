Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C277DD132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zKE-0000SX-Ut; Mon, 04 Nov 2024 10:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t7zKC-0000S1-LZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t7zKA-0005Kj-Qm
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730735340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5qKSNIK6vQ6Q7JE8WWXcZJy6X0rXyRaC1H1Rdx2Ib0=;
 b=Qe374yvO4WLIqRmuPetbVa9cnnogqd06BbZm5dBhlQvU+QHeZZKhMQwXly+n3wgQ9LPTR2
 OL5Ap1oDAqsJNzTCiUjNhkUaZM9+37SmRgW6OzRDFi4cQzF7MBylJ6We15MRE1H1uSTuWH
 htHhLKeKJtj50w8xljgz5+37tiXVzWQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-e8lFgkbVPOG9bE--gIfUBg-1; Mon,
 04 Nov 2024 10:48:56 -0500
X-MC-Unique: e8lFgkbVPOG9bE--gIfUBg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A1F19560B4; Mon,  4 Nov 2024 15:48:53 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 556421956086; Mon,  4 Nov 2024 15:48:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
In-Reply-To: <ZyjnIMteSuCvpGPW@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com> <87y128nrfr.fsf@redhat.com>
 <Zx-3OUioG1l47hW3@redhat.com>
 <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
 <ZyjgWJ3bZ69sueE2@redhat.com> <875xp3nigb.fsf@redhat.com>
 <ZyjnIMteSuCvpGPW@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 04 Nov 2024 16:48:48 +0100
Message-ID: <8734k7ngnz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 04 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Nov 04, 2024 at 04:10:12PM +0100, Cornelia Huck wrote:
>> On Mon, Nov 04 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> >
>> > FYI, in x86 target the -cpu command has had a "migratable=3Dbool" prop=
erty
>> > for a long time , which defaults to 'true' for 'host' model. This caus=
es
>> > QEMU to explicitly drop features which would otherwise prevent migrati=
on
>> > between two hosts with identical physical CPUs.
>> >
>> > IOW, if there are some bits present in 'host' that cause migration
>> > problems on Ampere hosts, ideally either QEMU (or KVM kmod) would
>> > detect them and turn them off automatically if migratable=3Dtrue is
>> > set. See commit message in 84f1b92f & 120eee7d1fd for some background
>> > info
>>=20
>> How does this work for version-sensitive features -- are they always
>> defaulting to off? How many features are left with that in the end?
>
> Do you mean QEMU versions here ? The non-migratable feature list is
> just hardcoded in QEMU right now, and there's only 1 of them.
> eg grep for 'unmigratable_flags'
>
> Note, that "migratable" property is not defining a general purpose
> migration mask between different hw generations. It was specifically
> blocking just stuff that is known to make migration impossible, even
> if HW is identical on both sides.

I was more thinking of dependencies on the KVM version -- QEMU versions
are easier to control for, but you don't really know what kernel version
you are running with. In the end, we'd probably need to mark a lot of
things as unmigratable.

>
>> > NB "migratable" is defined in i386 target code today, but conceptually
>> > we should expand/move that to apply to all targets for consistency,
>> > even if it is effectively a no-op some targets (eg if they are
>> > guaranteed migratable out of the box already with '-cpu host').
>>=20
>> How does this compare to s390x, which defines some migration-safe cpu
>> models, based upon the different hw generations? If I look at the QEMU
>> code for x86 and s390x, the s390x approach seems cleaner to me (probably
>> because it came later, and therefore could start afresh without having
>> to care for legacy things.) Given that we'll cook up a new model for Arm
>> migration as well, we might as well start with a clean implementation :)
>
> The impression I get (as an distant observer) is that CPUs on s390x in
> general have less complexity to worry about. A combination of not having
> a vendor who creates loads off different SKUs for the same CPU model
> family with slight variations between each, and also not seeming to have
> a situation where CPU flags a known to disappear (or appear) arbitrarily
> in microcode updates.
>
> The s390x idea of a "migratable" and "non migratable" model for each
> HW generation is a nice simplification, but I can't see how it could
> be made to work for x86 when you can't predict ahead of time what
> features are going to be removed from existing HW definition by the
> next microcode update, or by the next CPU SKU that removes a feature
> you had assumed would always be present in a given HW generation.
>
> I don't know much about how ARM world works, but having lots of vendors
> competing with their own custom impls makes me worry complexity will
> be closer to x86 than to s390.

My concern was more about code complexity, not hw complexity. We'll
probably end up with a zoo of weird creatures for Arm, but I don't see a
reason why the code would need to have strange things tacked
on. I.e. have a set of arch extensions that you can baseline to, and
have individual cpus on top, so you can deal with both well-known cpus
and more boutique ones.

>
> If the ARM specifications define a minimum require featureset for each
> HW generation, maybe you can define a model based on that ? You might
> still want to have vendor specific models though, if there are compelling
> features they expose which are optional, or non-standardized.=20

We have a list of features that are optional for a given arch extension,
and a list of features that are mandatory, so I think we'd be able to
generate a model with the mandatory features only. Models for individual
cpus could base off these. (There are currently 13 vendors defined in
MIDR, but I'm not sure how often new vendors might be added, and vendors
may also be more or less active.) If you have a baseline of Arm v9.2 or
so, that might already go a long way.

[But I obviously have no idea how well that will work when it meats
reality :)]



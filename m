Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229CBD33998
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ScP-0005lC-1d; Mon, 28 Oct 2024 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t5ScN-0005kT-B2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t5ScM-0008Iz-02
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730132961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkkVElKn3Spk/fVm1hzjR0gsXNh0JNd5hSe/vYQwfCU=;
 b=UxnT4oD7C2X4Cn7SPrQSEaFpst1tk3nHFqcVG9bg2tv/NVdUmImAb9w1fxIoqUXI4SjMzY
 xDxcHSbnXwqtELJ2Rh9CMJ+Ulz01cRmS/5xezUotvHfPOsE9+IF4qZ42O0TxMP4ew6+6Ok
 4s80602c0Fi82TU7kvxllaT7lwo53GA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-LhHf3dMWMJeGWk7sEJHcIQ-1; Mon,
 28 Oct 2024 12:29:18 -0400
X-MC-Unique: LhHf3dMWMJeGWk7sEJHcIQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1572F1955D4A; Mon, 28 Oct 2024 16:29:16 +0000 (UTC)
Received: from localhost (unknown [10.22.88.106])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E9919560AA; Mon, 28 Oct 2024 16:29:14 +0000 (UTC)
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
In-Reply-To: <Zx-3OUioG1l47hW3@redhat.com>
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
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 28 Oct 2024 17:29:11 +0100
Message-ID: <87plnknqco.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 28 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Oct 28, 2024 at 05:05:44PM +0100, Cornelia Huck wrote:
>> On Fri, Oct 25 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> > On Fri, Oct 25, 2024 at 03:28:35PM +0200, Eric Auger wrote:
>> >> Hi Daniel,
>> >>=20
>> >> On 10/25/24 15:13, Daniel P. Berrang=C3=A9 wrote:
>> >> > On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>> >> >> From: Cornelia Huck <cohuck@redhat.com>
>> >> >>
>> >> >> Add some documentation for the custom model.
>> >> >>
>> >> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> >> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> >> >> ---
>> >> >>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++=
-----
>> >> >>  1 file changed, 47 insertions(+), 8 deletions(-)
>> >> >
>> >> >> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be qu=
ite verbose, the ``sve<N>`` CPU
>> >> >>  properties have special semantics (see "SVE CPU Property Parsing
>> >> >>  Semantics").
>> >> >>=20=20
>> >> >> +The ``custom`` CPU model needs to be configured via individual ID=
 register
>> >> >> +field properties, for example::
>> >> >> +
>> >> >> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_E=
L1_DP=3D0x0
>> >> >> +
>> >> >> +This forces ID_AA64ISAR0_EL1 DP field to 0.
>> >> > What is the "baseline" featureset implied by 'custom' ?
>> >> there is no baseline at the moment. By default this is a host
>> >> passthrough model.
>> >
>> > Why do we need to create "custom" at all, as opposed to just letting
>> > users toggle features on "-cpu host" ?=20
>>=20
>> We could consolidate that to the current "host" model, once we figure
>> out how to handle the currently already existing properties. Models
>> based on the different architecture extensions would probably be more
>> useable in the long run; maybe "custom" has a place for testing.
>
> If you can set the features against "host", then any testing could
> be done with "host" surely, making 'custom' pointless ?

We might differentiate between "do some consistency checks" and "allow
a completely weird wolpertinger"; if we agree that we don't need it,
then we surely could drop it again.



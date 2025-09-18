Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55186CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFsJ-0002EP-LS; Thu, 18 Sep 2025 10:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzFsH-0002EE-Ni
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzFsF-0004mh-Ow
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758206677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bRaHrd6EbZXA08zyuyoH8lOU/Cf+4efWH/UpMDvW7k=;
 b=UBz/M7/mtS74U9fBcWVCu8nR/7Q36EsnIL3kdCSYmu9xcZj4HQcvHm5E3HqQDqQVPeO9wc
 Y6YAW/I2O8NWSIplD6n3NnVdkCQ8tshUpDXgWbcwink+z0hQSEVZciAEWkm7ynBNr+T0mO
 kaHZdC4rx/SAAyi3F6M4WG70f4kNUnc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-e6QGosYFOzSuXop4VgHU1g-1; Thu,
 18 Sep 2025 10:44:36 -0400
X-MC-Unique: e6QGosYFOzSuXop4VgHU1g-1
X-Mimecast-MFC-AGG-ID: e6QGosYFOzSuXop4VgHU1g_1758206675
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9436E19560B5; Thu, 18 Sep 2025 14:44:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC0931800577; Thu, 18 Sep 2025 14:44:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC72D21E6A27; Thu, 18 Sep 2025 16:44:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH <RFC> 00/15] Encode object type security status in code
In-Reply-To: <aMv7JMkeCo6QGVRV@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 18 Sep 2025 13:29:24 +0100")
References: <20250909165726.3814465-1-berrange@redhat.com>
 <87jz1wat7n.fsf@pond.sub.org> <aMv7JMkeCo6QGVRV@redhat.com>
Date: Thu, 18 Sep 2025 16:44:31 +0200
Message-ID: <87y0qb95ww.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On Thu, Sep 18, 2025 at 01:35:56PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> > It starts with QOM, adding "bool secure" and "bool insecure"
>> > properties to the TypeInfo struct, which get turned into flags
>> > on the Type struct. This enables querying any ObjectClass to
>> > ask whether or not it is declared secure or insecure.
>>=20
>> We should clearly document what "declared secure" actually means.
>> Here's my attempt at it: supported for use cases that require certain
>> security boundaries.
>
>
>
>>=20
>> > By default no statement will be made about whether a class is
>> > secure or insecure, reflecting our historical defaults. Over
>> > time we should annotate as many classes as possible with an
>> > explicit statement.
>> >
>> > The "-machine" argument gains two new parameters
>> >
>> >   * prohibit-insecure=3Dyes|no  - a weak security boundary, only
>> >     excluding stuff that is explicitly declared insecure,
>> >     permiting stuff that is secure & anything without a stetement
>>=20
>> This isn't what users need.
>>=20
>> >   * require-secure=3Dyes|no - a strong security boundary, only
>> >     permitting stuff that is explicitly declared secure,
>> >     excluding insecure stuff & anything without a statement
>>=20
>> This would be, if it covered everything accessible at the security
>> boundaries.  It doesn't for now: only QOM.
>>=20
>> It might still be better than nothing.
>>=20
>> However, it may well be unusable until enough of QOM is declared secure.
>
> Right, the problem is that for a while we'll have 3 buckets of
> stuff (insecure, secure and "not sure yet"), when ideally we would
> only have two buckets (insecure, secure).
>
> I agree that for people running VMs, ideally require-secure=3Dyes is
> what they should be using.
>
> The "not sure yet" bucket is a bit like schrodinger's cat in a box.
>
> If we only had require-secure=3Dyes, and that was insufficient for
> the user, they'd be left with no way to exclude stuff that is
> /definitely/ insecure.

Yes.  I mentioned this fallback below.

>                        The prohibit-insecure=3Dyes is at least
> telling them they're not using something that is a terribly
> bad idea.

It rules out known bad, but not "maybe terribly bad, we just don't
know".

> In practice most of the stuff in the 'not sure yet' bucket will
> be stuff that you'll only want to use in combniation with TCG,
> and thus your VM will be in the 'insecure' bucket anyway.
>
> There is a 2nd less critical use case for prohibit-insecure=3Dyes
> in relation to security report triage.
>
> If someone submits a security report and it relies on a config
> that is blocked by prohibit-insecure=3Dyes, then we can categorically
> declare it out of scope for CVE handling.
>
> Similarly the require-secure=3Dyes is categorically in-scope.
>
> The 'do not bucket' is where we have to do case-by-case
> analysis of the reoprt to decide whether it is in scope or
> not.

Yes.

By the way, two booleans is a rather awkward encoding of three states.
What about require-secure=3Dyes/no/feeling-lucky?  We may want something
better than feeling-lucky, it's merely the first one that crossed my
mind :)

>> What would our advice to users be?  I'm afraid something complicated and
>> impermanent like "try require-secure=3Dyes, and if you can't make it work
>> because parts of QOM you can't do without are still undeclared, fall
>> back to prohibit-insecure=3Dyes, and be aware this avoids only some, but
>> not all security boundary death traps in either case."
>>=20
>> This is an awful user interface.  But it's also a step towards the user
>> interface we want: a single, unchanging switch that ensures you're
>> running something that's fully supported for use cases that require
>> certain security boundaries.
>>=20
>> A next step could be getting enough of QOM declared so we can move to a
>> single switch, with the (hopefully temporary) caveat about "only QOM".
>
> Maybe the right answer is to just declare everything insecure
> by default and focus on just annotating stuff for the secure
> bucket as quickly as possible.

Annotating something as known insecure has value, but we can do that
even with just one flag:

    .secure =3D true;

means "declared secure",

    .secure =3D false;

means "declared insecure", and nothing means "undecided".

Initializing .secure =3D false doesn't *do* anything (false is the
default), but it would still be a fine way to annotate.

> The lazy option would be to take everything that is built in
> a RHEL distro build and label it as secure. We know Red Hat
> is already on the hook for fixing CVEs in any such component
> and sending fixes upstream. So by following the RHEL allow
> list initially we should be implying any new burden for the
> upstream.

Do you mean no new burden?

> That would enable require-secure=3Dyes for a useful amount of
> code needed for secure KVM guests on x86, s390x, aarch64,
> ppc64 and perhaps riscv.=20

[...]



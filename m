Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A270CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H86-00016q-Fl; Fri, 10 Oct 2025 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7H7x-0000zS-0X
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7H7h-0007ft-CF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760118100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcOCZF4iQdr5vRNCaRgMPxxx6qhYEJ/LdPzmEp0yuVk=;
 b=bMppOTSFKJG0yeiDrZNydmTR1bIpmCizcccroYzB58PeFiZFbiwY17a1IDqS7ecKvjMJ1K
 oWxVg3AzdiVZNjTkDJhVBqtzzs7zOk9IZHVovEoUYBeQ5N4Uw9NlwdeorVPSmlYqo3IbC5
 DLhdoP13XyTCMLbybbHbs+uHHc1Caos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-q6ZBCQhrOrKuIEh0C1zAwA-1; Fri,
 10 Oct 2025 13:41:37 -0400
X-MC-Unique: q6ZBCQhrOrKuIEh0C1zAwA-1
X-Mimecast-MFC-AGG-ID: q6ZBCQhrOrKuIEh0C1zAwA_1760118096
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D58931800357; Fri, 10 Oct 2025 17:41:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73BFB3000387; Fri, 10 Oct 2025 17:41:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACFC521E6A27; Fri, 10 Oct 2025 19:41:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  John Snow
 <jsnow@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI
 discussion ahead!]
In-Reply-To: <12439b02-9273-41b3-85f3-c98e319194ec@redhat.com> (Paolo
 Bonzini's message of "Fri, 10 Oct 2025 15:49:28 +0200")
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <87ikgpn9oz.fsf@pond.sub.org> <aOY-PFGNPY7aOwkJ@redhat.com>
 <87cy6vhqz2.fsf@pond.sub.org>
 <12439b02-9273-41b3-85f3-c98e319194ec@redhat.com>
Date: Fri, 10 Oct 2025 19:41:32 +0200
Message-ID: <87wm52ejsj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/10/25 14:38, Markus Armbruster wrote:
>> The boundary between legal and illegal is a superposition of fuzzy,
>> squiggly lines, one per jurisdiction.
>>=20
>> We can only try to approximate it from the legal side.
>> The tighter we try to approximate, the more risk we take on.
>>=20
>> In addition, tighter approximations can be difficult to understand and
>> apply.
>
> I agree.
>
>> [Strong argument why type annotations are low risk snipped...]
>
> Note that type annotations are pretty much the upper bound of what I=20
> would consider a mechanical change.  I would expect, for most cases,=20
> that "include the prompt in the commit message" and the boringness of=20
> the change are together already a satisfactory explanation.
>
> At the same time, I decided to try with a more complex change to 1)=20
> avoid a slippery slope; it's easier to do so if you look at the hard=20
> cases from the beginning, and Daniel did that very, very well; 2) probe=20
> the limitations of the tool and ascertain if it's even worthwhile having=
=20
> an exception.

It was a useful experiment.

>>> There's a definite "slippery slope" situation. The incentive for
>>> contributors will be to search out reasons to justify why a work
>>> matches the AI exception,
>>=20
>> =E2=80=9ELibenter homines id quod volunt credunt.=E2=80=9C
>
> Yes, and that's why we should strive for simplicity if we are to have=20
> exceptions.  If you cannot convince me with the prompt that your change=20
> is mechanical/non-creative, don't even bother making complicated and=20
> probably wrong legal arguments.
>
> Paying a certain price upfront (i.e., now) is fine, but in the long term=
=20
> the maintainer's job wrt AI should be and remain easy.  There has to be=20
> a cost, but then the same would be true with any policy other than=20
> "don't ask, don't tell"---including zero tolerance.

Yes.

Cost is fine when the benefits are worth it.

Maintainer bandwidth is precious.  But it's not infiniyely precious :)



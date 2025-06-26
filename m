Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BFC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 10:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUk3B-00005Q-KI; Thu, 26 Jun 2025 06:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUk35-000056-5h
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUk33-00021p-8k
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750934497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LTOeEytEK6M6Zy+ARsHxMd7ptyZV4pEZRUH7CtLbSs=;
 b=ZA7OJgH+LuqW2emRbsRaQXqIBj3hNcU7ASJQSFuv5rCvd4f9/Y6BNsz3vyNLic4EF1Dgx6
 elmF+rJZfrwv/KyI35tvBJR6EOHSHCfzumSed/qRlHMB2JZ3Ef8YIefd7WwMOU9L8xLfLJ
 /HOnVnJrpw/w0NkEC3FRboKOf6VEG2Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-lfjC3l3zPC2VpoJM2giw2A-1; Thu,
 26 Jun 2025 06:41:34 -0400
X-MC-Unique: lfjC3l3zPC2VpoJM2giw2A-1
X-Mimecast-MFC-AGG-ID: lfjC3l3zPC2VpoJM2giw2A_1750934493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E8A1808984; Thu, 26 Jun 2025 10:41:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC1730002C0; Thu, 26 Jun 2025 10:41:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8CE621E6A27; Thu, 26 Jun 2025 12:41:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <20250625155910-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 25 Jun 2025 16:01:55 -0400")
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxRUFIfuDdRYA2m@redhat.com>
 <20250625155910-mutt-send-email-mst@kernel.org>
Date: Thu, 26 Jun 2025 12:41:28 +0200
Message-ID: <87zfduwzs7.fsf@pond.sub.org>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Jun 25, 2025 at 08:46:54PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jun 25, 2025 at 03:16:52PM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
>> > > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > >=20
>> > > There has been an explosion of interest in so called AI code
>> > > generators. Thus far though, this is has not been matched by a broad=
ly
>> > > accepted legal interpretation of the licensing implications for code
>> > > generator outputs. While the vendors may claim there is no problem a=
nd
>> > > a free choice of license is possible, they have an inherent conflict
>> > > of interest in promoting this interpretation. More broadly there is,
>> > > as yet, no broad consensus on the licensing implications of code
>> > > generators trained on inputs under a wide variety of licenses
>> > >=20
>> > > The DCO requires contributors to assert they have the right to
>> > > contribute under the designated project license. Given the lack of
>> > > consensus on the licensing of AI code generator output, it is not
>> > > considered credible to assert compliance with the DCO clause (b) or =
(c)
>> > > where a patch includes such generated code.
>> > >=20
>> > > This patch thus defines a policy that the QEMU project will currently
>> > > not accept contributions where use of AI code generators is either
>> > > known, or suspected.
>> > >=20
>> > > These are early days of AI-assisted software development. The legal
>> > > questions will be resolved eventually. The tools will mature, and we
>> > > can expect some to become safely usable in free software projects.
>> > > The policy we set now must be for today, and be open to revision. It=
's
>> > > best to start strict and safe, then relax.
>> > >=20
>> > > Meanwhile requests for exceptions can also be considered on a case by
>> > > case basis.
>> > >=20
>> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >=20
>> > Sorry about only reacting now, was AFK.
>> >=20
>> > So one usecase that to me seems entirely valid, is refactoring.
>> >=20
>> > For example, change a function prototype, or a structure,
>> > and have an LLM update all callers.
>> >=20
>> > The only part of the patch that is expressive is the
>> > actual change, the rest is a technicality and has IMHO nothing to do w=
ith
>> > copyright. LLMs can just do it with no hassle.
>>=20
>> Well the policy is defined in terms of requirements to comply with
>> the DCO, and that implicitly indicates that the code in question
>> is eligible for copyright protection to begin with.
>>=20
>> IOW, if a change is such that it is not considered eligible for
>> copyright protection, then you can take the view that it is trivially
>> DCO compliant, whether you wrote the code, an arbitrary 3rd party
>> wrote the code, or whether an AI wrote the code.=20
>
> Exactly. I agree! However the patch states:
>
> +The QEMU project thus requires that contributors refrain from using AI c=
ontent
> +generators on patches intended to be submitted to the project, and will
> +decline any contribution if use of AI is either known or suspected.
>
> and makes no exception for non copyrighteable parts of the patch.
>
> Or do I misunderstand?
>
>> > Can we soften this to only apply to expressive code?
>> >=20
>> > I feel a lot of cleanups would be enabled by this.
>>=20
>> Trying to detail every possible scenario is impractical and would
>> make the document too onerous for people to read, remember & apply.
>> It is better to leave it up to the contributor to decide whether a
>> change is non-copyrightable, than to try to draw that line crudely
>> in text. Even for refactoring that line will be fuzzy and contextual,
>> so not a scenario where we should say any use of AI for reactoring
>> is OK, as that will lull contributors into having a false sense of
>> acceptibility, rather than being aware of need to question it.=20
>
> Agree again! What worries me is that the patch as posted here does
> not make contributors question anything. It just flatly forbids using "AI
> content generators".

Only if you stop reading before the last paragraph :)

I agree with Daniel that trying to legislate exceptions is not going to
work.  Instead, we put in this:

    This policy may evolve as AI tools mature and the legal situation is
    clarifed. In the meanwhile, requests for exceptions to this policy will=
 be
    evaluated by the QEMU project on a case by case basis. To be granted an
    exception, a contributor will need to demonstrate clarity of the licens=
e and
    copyright status for the tool's output in relation to its training mode=
l and
    code, to the satisfaction of the project maintainers.

Last paragraph, i.e. a fairly prominent spot.

If you can make a convinving case that the tool's output is not
copyrightable, I like your chances of being granted an exception.

As always, if you think doc text is insufficiently clear, let's work on
improving it.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EF9C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMk3R-0003NV-NV; Wed, 04 Jun 2025 05:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMk3P-0003Ll-LQ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMk3N-0003i0-Jt
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749027895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGoXpcJDVMX/dHNrgPa0VRVmXtmsN3U496WC91nwsMs=;
 b=RM0avALfbd12VXEAO8gxqnFQXda1FzBWsnYkmoB3NurxHhYb9jDMBFCOlaUcwI9eV/2SLH
 uLVau/dsfn6YvMQOLwK4ybkIRsk4+z+kM3TXNkZn1NpwPJG/YVC6WDh38vsYAoCUkikWiR
 +i2rsjsZfClYenr5+soKjEiLSEyGX3I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-cg0BCFnhOzKqk9yvqNIWJw-1; Wed,
 04 Jun 2025 05:04:52 -0400
X-MC-Unique: cg0BCFnhOzKqk9yvqNIWJw-1
X-Mimecast-MFC-AGG-ID: cg0BCFnhOzKqk9yvqNIWJw_1749027891
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 538C11800361; Wed,  4 Jun 2025 09:04:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0644A180045B; Wed,  4 Jun 2025 09:04:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CE0621E66C3; Wed, 04 Jun 2025 11:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Hajnoczi
 <stefanha@gmail.com>,  qemu-devel@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S .
 Tsirkin" <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <3df2ae5d-c1c6-45ee-8119-ca42e17a0d98@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jun 2025 09:54:33
 +0200")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
 <3df2ae5d-c1c6-45ee-8119-ca42e17a0d98@linaro.org>
Date: Wed, 04 Jun 2025 11:04:47 +0200
Message-ID: <8734cfyj0w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 4/6/25 09:15, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
>>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>>
>>>> On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>>>>>
>>>>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>> +The increasing prevalence of AI code generators, most notably but no=
t limited
>>>>
>>>> More detail is needed on what an "AI code generator" is. Coding
>>>> assistant tools range from autocompletion to linters to automatic code
>>>> generators. In addition there are other AI-related tools like ChatGPT
>>>> or Gemini as a chatbot that can people use like Stackoverflow or an
>>>> API documentation summarizer.
>>>>
>>>> I think the intent is to say: do not put code that comes from _any_ AI
>>>> tool into QEMU.
>>>>
>>>> It would be okay to use AI to research APIs, algorithms, brainstorm
>>>> ideas, debug the code, analyze the code, etc but the actual code
>>>> changes must not be generated by AI.
>>=20
>> The scope of the policy is around contributions we receive as
>> patches with SoB. Researching / brainstorming / analysis etc
>> are not contribution activities, so not covered by the policy
>> IMHO.
>>=20
>>>
>>> The existing text is about "AI code generators".  However, the "most
>>> notably LLMs" that follows it could lead readers to believe it's about
>>> more than just code generation, because LLMs are in fact used for more.
>>> I figure this is your concern.
>>>
>>> We could instead start wide, then narrow the focus to code generation.
>>> Here's my try:
>>>
>>>    The increasing prevalence of AI-assisted software development results
>>>    in a number of difficult legal questions and risks for software
>>>    projects, including QEMU.  Of particular concern is code generated by
>>>    `Large Language Models
>>>    <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
>>=20
>> Documentation we maintain has the same concerns as code.
>> So I'd suggest to substitute 'code' with 'code / content'.
>
> Why couldn't we accept documentation patches improved using LLM?
>
> As a non-native English speaker being often stuck trying to describe
> function APIs, I'm very tempted to use a LLM to review my sentences
> and make them better understandable.

I understand the temptation!  Unfortunately, the "legal questions and
risks" Daniel described apply to *any* kind of copyrightable material,
not just to code.

Quote:

    To satisfy the DCO, the patch contributor has to fully understand the
    copyright and license status of code they are contributing to QEMU. Wit=
h AI
    code generators, the copyright and license status of the output is ill-=
defined
    with no generally accepted, settled legal foundation.

    Where the training material is known, it is common for it to include la=
rge
    volumes of material under restrictive licensing/copyright terms. Even w=
here
    the training material is all known to be under open source licenses, it=
 is
    likely to be under a variety of terms, not all of which will be compati=
ble
    with QEMU's licensing requirements.

    How contributors could comply with DCO terms (b) or (c) for the output =
of AI
    code generators commonly available today is unclear.  The QEMU project =
is not
    willing or able to accept the legal risks of non-compliance.

[...]



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B038AC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhRa-0000Dx-K3; Wed, 04 Jun 2025 02:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhRW-0000CO-Ua
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhRT-0000Kj-Um
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749017856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0Sx2Yef2ayjnWyjoyF/uwzTLxCPRwIPu6rymC2IcbE=;
 b=CsMMgZVMw1ONyWOyhiDs8JZ/IJB/pNqX0cNpUfJdMcjSAxHfYuP+8K3zfhxjR6q2jcWc+4
 /HbUaPxgoOWuWSHI2jXJQ69w9mhhHbIYbIEJVT2b6SElYOaVYo3L7wyCrdmjcPYXws9VzH
 x2kBc6LJtmzCXzMY9lorOKo2det8otM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-U_QAHRT-OmOimLZWUUrJ4w-1; Wed,
 04 Jun 2025 02:17:33 -0400
X-MC-Unique: U_QAHRT-OmOimLZWUUrJ4w-1
X-Mimecast-MFC-AGG-ID: U_QAHRT-OmOimLZWUUrJ4w_1749017851
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 451E018003FD; Wed,  4 Jun 2025 06:17:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580A719560A3; Wed,  4 Jun 2025 06:17:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A24921E6766; Wed, 04 Jun 2025 08:17:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 (Stefan Hajnoczi's message of "Tue, 3 Jun 2025 14:25:42 -0400")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
Date: Wed, 04 Jun 2025 08:17:27 +0200
Message-ID: <87a56o1154.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Jun 3, 2025 at 10:25=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> There has been an explosion of interest in so called AI code
>> generators. Thus far though, this is has not been matched by a broadly
>> accepted legal interpretation of the licensing implications for code
>> generator outputs. While the vendors may claim there is no problem and
>> a free choice of license is possible, they have an inherent conflict
>> of interest in promoting this interpretation. More broadly there is,
>> as yet, no broad consensus on the licensing implications of code
>> generators trained on inputs under a wide variety of licenses
>>
>> The DCO requires contributors to assert they have the right to
>> contribute under the designated project license. Given the lack of
>> consensus on the licensing of AI code generator output, it is not
>> considered credible to assert compliance with the DCO clause (b) or (c)
>> where a patch includes such generated code.
>>
>> This patch thus defines a policy that the QEMU project will currently
>> not accept contributions where use of AI code generators is either
>> known, or suspected.
>>
>> These are early days of AI-assisted software development. The legal
>> questions will be resolved eventually. The tools will mature, and we
>> can expect some to become safely usable in free software projects.
>> The policy we set now must be for today, and be open to revision. It's
>> best to start strict and safe, then relax.
>>
>> Meanwhile requests for exceptions can also be considered on a case by
>> case basis.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance=
.rst
>> index c27d8fe649..261263cfba 100644
>> --- a/docs/devel/code-provenance.rst
>> +++ b/docs/devel/code-provenance.rst
>> @@ -270,4 +270,52 @@ boilerplate code template which is then filled in t=
o produce the final patch.
>>  The output of such a tool would still be considered the "preferred form=
at",
>>  since it is intended to be a foundation for further human authored chan=
ges.
>>  Such tools are acceptable to use, provided they follow a deterministic =
process
>> -and there is clearly defined copyright and licensing for their output.
>> +and there is clearly defined copyright and licensing for their output. =
Note
>> +in particular the caveats applying to AI code generators below.
>> +
>> +Use of AI code generators
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +TL;DR:
>> +
>> +  **Current QEMU project policy is to DECLINE any contributions which a=
re
>> +  believed to include or derive from AI generated code. This includes C=
hatGPT,
>> +  CoPilot, Llama and similar tools**
>
> GitHub spells it "Copilot".

I'll fix it.

> Claude is very popular for coding at the moment and probably worth mentio=
ning.

Will do.

>> +
>> +The increasing prevalence of AI code generators, most notably but not l=
imited
>
> More detail is needed on what an "AI code generator" is. Coding
> assistant tools range from autocompletion to linters to automatic code
> generators. In addition there are other AI-related tools like ChatGPT
> or Gemini as a chatbot that can people use like Stackoverflow or an
> API documentation summarizer.
>
> I think the intent is to say: do not put code that comes from _any_ AI
> tool into QEMU.
>
> It would be okay to use AI to research APIs, algorithms, brainstorm
> ideas, debug the code, analyze the code, etc but the actual code
> changes must not be generated by AI.

The existing text is about "AI code generators".  However, the "most
notably LLMs" that follows it could lead readers to believe it's about
more than just code generation, because LLMs are in fact used for more.
I figure this is your concern.

We could instead start wide, then narrow the focus to code generation.
Here's my try:

  The increasing prevalence of AI-assisted software development results
  in a number of difficult legal questions and risks for software
  projects, including QEMU.  Of particular concern is code generated by
  `Large Language Models
  <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).

If we want to mention uses of AI we consider okay, I'd do so further
down, to not distract from the main point here.  Perhaps:

  The QEMU project thus requires that contributors refrain from using AI co=
de
  generators on patches intended to be submitted to the project, and will
  decline any contribution if use of AI is either known or suspected.

  This policy does not apply to other uses of AI, such as researching APIs =
or
  algorithms, static analysis, or debugging.

  Examples of tools impacted by this policy includes both GitHub's CoPilot,
  OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are le=
ss
  well known.

The paragraph in the middle is new, the other two are unchanged.

Thoughts?

>> +to, `Large Language Models <https://en.wikipedia.org/wiki/Large_languag=
e_model>`__
>> +(LLMs) results in a number of difficult legal questions and risks for s=
oftware
>> +projects, including QEMU.

Thanks!

[...]



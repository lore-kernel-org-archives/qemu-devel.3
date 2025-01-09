Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA9E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVr1j-000078-F9; Thu, 09 Jan 2025 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVr1f-00006r-Nx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:48:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVr1Z-00013f-S9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736423308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5IvpQdmfb47KrYq/toTzG7W8/y+AIUGQrKQdHiSqG8=;
 b=jFDlt6P0jAH2PO3vwlxWkjuk6h9nD00vL88tdgaR9+ne3yFzzjE3xAeq7VRmFwptJ9iPaE
 2x4AHdak4qJqp4MwhjwOQvqBhb96nTKJGb+VkpOG12TZQ0x4+AYyLBjSsFvK0RH1par5sJ
 gQ1lLP1kOPKZYj95b3TMeQOjHG31SdI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-FjJezqBlOOmXcPT1WCwbfg-1; Thu,
 09 Jan 2025 06:48:21 -0500
X-MC-Unique: FjJezqBlOOmXcPT1WCwbfg-1
X-Mimecast-MFC-AGG-ID: FjJezqBlOOmXcPT1WCwbfg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C52971955D80; Thu,  9 Jan 2025 11:48:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 278211955BE3; Thu,  9 Jan 2025 11:48:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08C5821E6924; Thu, 09 Jan 2025 12:48:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 00/23] docs: add basic sphinx-domain rST generator to
 qapidoc
In-Reply-To: <CAFn=p-YynNgOTb7-rzJeF69hG_3c1ojosHAOsnc-CW-a_SYrUA@mail.gmail.com>
 (John Snow's message of "Wed, 8 Jan 2025 16:08:40 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <87ikrfkg6y.fsf@pond.sub.org>
 <CAFn=p-YynNgOTb7-rzJeF69hG_3c1ojosHAOsnc-CW-a_SYrUA@mail.gmail.com>
Date: Thu, 09 Jan 2025 12:48:18 +0100
Message-ID: <87sepsqkcd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Dec 19, 2024 at 7:31=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > based-on:
>> https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.com/
>> >
>> > Hi!
>> >
>> > This series is a very, very barebones implementation for the new QAPI
>> > doc generator. It does not have many features that I presented on at K=
VM
>> > Forum; the point of this patch set is instead to present a stripped do=
wn
>> > basis for ongoing work so we can discuss on-list with full context of
>> > the code available to do so.
>> >
>> > The documentation this series generates is *not suitable* for replacing
>> > the current document generator, it has a few glaring omissions - on
>> > purpose - those features have been factored out intentionally so they
>> > can be reviewed with fuller context and more careful review.
>> >
>> > What this series does:
>> >
>> > - Adds the new "Transmogrifier" rST generator to qapidoc.py, which
>> >   generates an in-memory rST document using qapi-domain directives.
>> > - Adds a test document that showcases this new transmogrifier.
>>
>> Note to other reviewers: transmogrifier output is
>> docs/manual/qapi/index.html.
>>
>> > What this series very notably does not do (yet):
>> >
>> > - "ifcond" data for anything other than top-level entities is not
>> >   considered or rendered. This means "if" statements for features and
>> >   members are entirely absent.
>> >
>> > - The inliner is not present at all. This series renders only
>> >   documentation exactly as it is exists in the source files.
>>
>> This item is not even a regression.
>>
>
> No; but the version of this series as sent also does not add "The members
> of ..." stubs, which would be a regression.

Right.

>                                             I didn't necessarily intend f=
or
> this to be merged as-is; more of a "part one, with additional tricky
> elements that require more careful thought isolated into separate patches
> for later".
>
> where "later" means "in v2" or "as a follow-up series as we stage things =
in
> a development branch before final submission for inclusion to
> origin/master" or whatever the actual mechanism is. I don't have a strong
> vision there, really; I just wanted to nail down the basics out in the op=
en
> even if that was just between you (Markus) and I and we have a gentleman's
> agreement that it looks tentatively OK.

Got it.

>> > - *branches* are themselves not considered at all; they're skipped
>> >    entirely for now. They will be included alongside the inliner in
>> >    either a subsequent series or a followup to this series.
>> >
>> > - Undocumented members and return statements are not autogenerated.
>>
>> The current doc generator auto-generates missing member documentation
>> ("Not documented").  It doesn't auto-generate missing returns
>> documentation.  I explored auto-generating them, but shelved my work to
>> not interfere with yours.
>>
>> > - Pseudofeatures (Things like allow-oob) are not generated as document=
ed
>> >   features.
>>
>> What exactly are "pseudofeatures"?
>>
>
> What I've named things like allow-oob that aren't features, but ought to =
be
> documented. We may well decide to promote them to real-deal special
> features, or maybe not. My work-in-progress branch currently just adds
> "dummy" features to document them. We can discuss this later alongside the
> patch that implements this.

I agree this is a digression, so feel free to ignore the remainder of my
reply for now.

We have two kinds of flags in the QAPI schema language: features and ad
hoc flags.  The ad hoc flags are 'boxed' (commands and events), 'gen',
'success-response', 'allow-oob', 'allow-preconfig', 'coroutine'
(commands only).

The flags sort into three buckets:

1. Code generation directives that do not affect the external interface,
and thus should not be visible in introspection: 'boxed', 'gen',
'coroutine'.

2. Flags that are visible at the external interface, but don't affect
code generation beyond making them visible in introspection: the
non-special features.

3. Code generation directives that affect the external interface, and
thus are (or should be) visible in introspection.

3a. The special features: are visible.

3b. 'allow-oob': is visible, but differently, because it predates
special features.

3c. 'allow-preconfig': not visible.

3d. 'success-response': not visible, because we use it for QGA only,
which doesn't provide introspection.

Bucket 3 could use cleanup.

[...]



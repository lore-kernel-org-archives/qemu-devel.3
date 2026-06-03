Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2D7CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnea-00038r-Sr; Wed, 03 Jun 2026 11:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wUneB-000339-3e
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wUne7-0001Hp-BI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780501000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73TLPUsHO/0lNWEnutMJyuWaLSlJujXD9xL3o1teDxo=;
 b=BfeDPGwMdQKgw9XxVl3GHpiymBnzqonNSSqUu+DUjCsefJ8oHXzyQ0TjaghUmsrB/Kmk6v
 nKow4k0FZN+rrrDOrZmVvEOZQobLPkJvX9L+whavTErA1bP6TQk2Wv+JeZr14/fKVMRQ9e
 n4EImGi8VGO/hWrQeNSMpAcvHgVBUys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-NQlMBFTuOKCa6q_Wl3wlhg-1; Wed, 03 Jun 2026 11:36:36 -0400
X-MC-Unique: NQlMBFTuOKCa6q_Wl3wlhg-1
X-Mimecast-MFC-AGG-ID: NQlMBFTuOKCa6q_Wl3wlhg_1780500995
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eee3f9f03so5887944f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780500995; cv=none;
 d=google.com; s=arc-20240605;
 b=Z9R4JVwWKJY6hsJ2HrG0Hb0rLpw2xp3DUbPIq7KDGXH5l9NMy7nFVUDsSlDbz+7pCt
 Hqn1UQluS3BBT6gcWKh+O30LeKTvFrkXxynjwbowq2DyCYS598TNpgiOdR60K+D1RUqv
 nU2JWcVjYS0d5W2CRd2fRHNfp0xpYWAyLI1/ZJFkqqVI+GNBMj39DuddgrydWZtNJeb5
 SpqtZB4zQUuA9F/wN2y79FW1YUQwWSRoXBfww51Ii6KNQOLmLPvxZdrSZxwe1Wl47+9Z
 U1v3HMPlj61vfehisWOMao9ZC7laXdu/+Ngd1DVh8TBkKxgSnI8RLvI+MZRTZ867Bgq6
 kw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=73TLPUsHO/0lNWEnutMJyuWaLSlJujXD9xL3o1teDxo=;
 fh=jk7nVV7ug+Ip4OBwUOsno6gyw5Dfo9MDK2srV9NMVZQ=;
 b=cboXCQarhLzOAF59cVayxLol/riFD9kB1fNvXnPeBlB+yAhf6aKUum2lnjVSOHfMe0
 UWYCNE0RABczt3mxeHXW7AgiXHlC1KKVebvymV1qmCrJjaArGAle/vUDoSLYcsDGi90s
 odL076EbREoA/S6uDFGCaYQPZEWyTx7tTU7RCa1tiO3LqTpZnh8j94VFwuLmLMbv0MQw
 wi042MX9+lXUXHjz4UdX5CzwwEnUxB5pHKRpUXVKiXBbWEB0x6goD5P483bHY4qLTRaK
 yotatuO4rmGc7Noh8p3NZ6H1rS6KvWKHjAdmmyxWW5ujOUPYSyL6ygcOs1z/k1h+Squw
 bB+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780500995; x=1781105795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73TLPUsHO/0lNWEnutMJyuWaLSlJujXD9xL3o1teDxo=;
 b=KuOIoxFyVQtZCV5le2xIXAYD5sAO7UW1gQ5RNEHV4Qr5mtzq09uA74jgZLX5LK8CAl
 5JkHG1lg+xfMD78V+84hUxPdJYg0ZzlfNJ/tmKzBqDsy9L6zRx5q4OgEZjdHD1muEJvA
 pYP7Ip4GvS6I/jo0BEc0RnxpeZTSMGw4a/7S8ik2ldLa+vCPtcgHG1GCO6mLpUxAV2xs
 aDKPXpNl27mM97v1IMz6NqN4B2bq8cHXq32wG7Gl6D8BicHV4tQKUQjbgiDsN/Mm66xU
 Q5oLWzSyPQlEVnli4htFnQxzZ8jcAcQ41WEIfnPiS44b5kvMTmc1e6Ct9tZrGre3aS4I
 ZonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780500995; x=1781105795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73TLPUsHO/0lNWEnutMJyuWaLSlJujXD9xL3o1teDxo=;
 b=dlcTs5DFA/BkELqp3nfjmy60n1AqIdOQfA2a0zvsXqX5CvBGQmWsO86BaDRTA1Fqpk
 Z+zdmj9t0XAeC/7XzBBtkeoydQtEjM6Z+sdf0QQ7kTsnpwaMSTYs8G5k5GtzBUKu6Qhf
 aO5yMVfa/iAEIImmUYI+T9j1uuIOeRKQ805AlGOzixRt10GChdwyb6VNh01JmPIP94qg
 m6KJD/SMvEQOaeiBDtydS9hl5PUNzyFocNVYQuoiVE6wITFedmsHxpDDrOZ74K/2vS/n
 1MA/KbF6CVz2wRMocpD6aOmRF+iSwCeXxl3WwNPNy0J2EVNihpsGt6kd/UJ2sOgu3Vmy
 4I2w==
X-Gm-Message-State: AOJu0YzyRxq6S1OrZaWcuakT4IlZ4wHkC0I1tt3jEN/5MxTAIDEAdBgl
 xFHMLK5AqKe8IPV+CYgPPhbQS4TETVquzGMvPqy4fd/9OWcAoZs69f+WDbOqn5fpueSewvUeI0T
 xu6P3MGmFm/PHHBlCQtK5DJtj/JEBhXk81Jg7DVCz9PGuLyRlhkOBFNslYt9fIIqeV+soS5YNNu
 tj/P8+l5T0um6pWxb4gLdzMMs8Dy2Zc9U=
X-Gm-Gg: Acq92OHL32+mjjjCXWGALlPEJo6YJI5yr9a0EsFVlWan5SaBQkZThCWA0mpvjeCfeRT
 oiezcVLxKoSD6c7+WsmsXD7XFvj6xosjr7UfkCCAA+qslpSPDrHXA4pG51RL9T5jxxvduUVaqbq
 xV+uDJ8eFt8VDM/iAMPlS0bMlyV0U07UvO1qRc/q9zxaIbo5MGWIrPie+durK/voKWZckImOkJo
 iN9PQufiTJ6s6Wr0AVkPL28aTXuY6A+KUxRatbjJPD39wpZCXk3Go/+vk6W5uTrbz/qXUP3jlrd
 quBQNYnSloKwjpzm
X-Received: by 2002:adf:ffcb:0:b0:45e:f381:cd8c with SMTP id
 ffacd0b85a97d-46021959c5bmr4237453f8f.30.1780500994928; 
 Wed, 03 Jun 2026 08:36:34 -0700 (PDT)
X-Received: by 2002:adf:ffcb:0:b0:45e:f381:cd8c with SMTP id
 ffacd0b85a97d-46021959c5bmr4237409f8f.30.1780500994452; Wed, 03 Jun 2026
 08:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
In-Reply-To: <aiBBV48wyDF57vUi@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Jun 2026 17:35:46 +0200
X-Gm-Features: AVHnY4IDJBy9BwxeWwNW_b7YEZuz5qmPs68CN2L_yFfvnTaFrySHdBREOpU7nDg
Message-ID: <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

Thanks for the review. It will take a while to incorporate everything
and I'll wait for more feedback, in the meantime just a couple things
I can confirm or add...

On Wed, Jun 3, 2026 at 4:59=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> IIUC, by "small bug fixes", what you're actually trying to
> express is an acceptance of code that is either
>
>   * unlikely to meet the threshold for copyrightability
>   * small enough that the consequences of throwing it
>     away is negligible.

Yes, these two.

> In retrospect, I wonder if we shouldn't have have "ai-usage.rst" as
> a separate doc from the start.  While we can hyperlink to sub-titles
> via anchors, it would be simpler if we could just point to a doc and
> not require scrolling past pages of non-AI text.

I can split it, especially since there's basically no shared text with
the old one.

> > @@ -288,62 +288,108 @@ content generators below.
> >  Use of AI-generated content
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> > +Risks to open source projects include maintainer burnout from an
> > +increased number of contributions, as well as the risk to the project
> > +from unintentional inclusion of copyrighted material in the LLM's outp=
ut.
> > +In order to mitigate these risks, the QEMU project currently allows
> > +using AI/LLM tools to produce patches in a limited set of scenarios:
>
> If we're opening the door to AI assisted contribution, then IMHO we
> need to write about both the social and technical expectations.
>
> Admittedly that will expand the scope of your proposal here, but
> IMHO that's somewhat unavoidable. A significant part of the downsides
> of AI-assisted contributions comes from bad social practices, rather
> than merely bad technical practices.
>
> As a general theme, I would like us to emphasize at the start that the
> act of collaboration & contribution in QEMU is about the interaction,
> trust and relationships between humans, not bots.

I agree that it needs to be there somewhere.  On the other hand I'm a
bit worried about having a treatise that no one will read -- at least
with stuff like "writing a commit message" we can point people to it.

> If someone wants to use tools (LLM based or not) that's a choice,
> but the accountability for actions needs to fall on a real human
> and there needs to be transparency whenever automation is used.
>
> This starts from the commit message.  A good commit message (and even
> more so a good cover letter) describes the intent / thinking behind
> the changes.  An LLM doesn't think or have intent in its actions,
> ergo a human should be driving the authorship of commit mesages /
> cover letters, where a non-trivial explanation is needed.
>
> As reviewers, if we make use of LLM backed tools to respond, then
> we need to be transparent about any feedback that came from a bot
> rather than from a human.
>
> As contributors, if a reviewer gives feedback, the contributors
> response should be their own rather than just feeding the email
> review into a LLM and cut+pasting the LLMs answer back to the
> list.
>
> The identity use to contribute to QEMU should reflect the human's
> identify. As previously clarified, this doesn't need to be a real
> name, but we don't want LLM agents being given a psuedonym to
> pretend to be a human.

I'll try to weave these in either this section or a similar one.

> > +**Small bug fixes**
> > +  These should be limited to 20 lines of code or less, not including
> > +  tests.  You are still expected to :ref:`understand and explain your =
changes
> > +  <write_a_meaningful_commit_message>` and the rationale behind them.
>
> I think the "20 lines or less" is not going a good job at expressing
> the intent behind this point. I'd like us to emphasize between the
> "why" of this point, as that helps contributors & reviewers make a
> decision of whether a change is "within the spirit" or the rule of
> not.

True but we also need a rule. The spirit is better explained elsewhere
(and also, building consensus on spirit vs. a rule are two different
things).

> Docs is an area I'm more wary of from the social expectation side rather
> than the technical or legal side.  I don't feeel like "pay attention to
> the organization and flow" really mitigates to the tendancy to production
> of vast reams of convincing sounding slop.

Reviewers have no obligation to review.  The good thing about slop is
that saying no takes about the same effort as the author put into the
creation of the change.

> IMHO it should not be at the discretion of individual maintainers to
> accept large-scale AI authored changes outside these guidelines. To
> quote the commit message rationale
>
>    "Therefore, it remains prudent to only permit AI assistance where
>     the ramifications of copyright violations are at least easy to
>     revert and unlikely to spread"
>
> that does not suggest we should leave it to the discretion of maintainers
> to override the guidelines.

See my reply to Peter elsewhere in the thread. I agree with your
concerns for both docs and discretion, but I had specific uses in mind
that I'd like to allow.

For docs:
- create tutorials and/or feature documentation based on functional tests
- create function comments (including Rust doctests) based on a
high-level, human-written description of the module

For maintainer discretion:
- updating patches for changes to kernel APIs, before the kernel side
is ready for inclusion
- creation of parsing code for Rust procedural macros based on code
examples and/or a human-written description of the macro
- creation of boilerplate code similar to hw/core/hotplug.c

I think all of these are potentially compelling and I would like
people to be allowed to experiment with them or similar cases.

The idea of contacting maintainers beforehand comes from the policy
currently under discussion in the Rust project.

> > +When AI/LLM tools produce or substantively shape your patch, add an
>
> "shape your patch" ->  "shape the content of the submitted patch"
>
> as this better excludes the "background" usage mentioned below.
>
> > +``AI-used-for:`` line before ``Signed-off-by``, as a reminder of your
> > +DCO obligations and a guide to reviewers.  The text is one or more of
> > +``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > +explanation in parentheses:
> >
> > +.. code-block:: none
> > +
> > +     AI-used-for: tests, docs
> > +     AI-used-for: code
> > +     AI-used-for: code (refactoring)
> > +     AI-used-for: code (prototype)
> > +     AI-used-for: research
> > +
> > +``AI-used-for`` should not be included for "background" usage such as
> > +autocomplete or obtaining a pre-review of the patch.
>
> This is an interestng idea that I like much more than Assisted-by,
> because it gives more directly useful info to the reviewer, without
> turning into free advertizing for commercial vendors.

Yes! Thanks Kevin. :)

> > +There is no requirement to include your prompts or summarize the
> > +conversation in the commit message or cover letter, but you may do so
> > +if you think it helps a reviewer judge the result.  For example:
>
> IMHO we should actively discourage the inclusion of prompts
> entirely as it is the wrong information to provide.

Why? I think it helps especially in the case where we're asking for
maintainers to apply their discretion, and for reproducibility. It may
not be always applicable, but it can also help.

> > +**Helpful prompts**
> > +  These describe concrete constraints or instructions, making it easy =
for a
> > +  reviewer to see how the tool's output was guided:
> > +
> > +  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> > +    function already has a local variable or parameter of type ``struc=
t
> > +    bb``, use it instead of accessing ``aa.bb``"
> > +
> > +  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; it
> > +    takes the lock around the calls and forwards to ``T``"
>
> These examples prompts are just expressing an aspect that should
> already have been described in prose in the commit message. We
> don't need to classify them as "ai prompts" in a a commit message,
> we just need the author to write a useful commit message.

The commit message does not have to contain this information. For
example, commit 44a9d1b86c0 does not explain that it implements the
ToMigrationState{,Shared} traits for Mutex. The commit message could
say something like

"The implementation of the traits for types ... were created with AI.
The prompt was: "add a simple forwarding implementation of the traits
in rust/migration/src/migratable.rs for the array type [T; N] and for
the interior mutable types Mutex<T> and BqlRefCell<T>. Note that
interior mutable types only need T: ToMigrationState in order to
implement ToMigrationStateShared".

I agree that this is not a typical part of a commit message. On the
other hand we do mention occasionally how a commit was automated, and
this falls under that case, sort of? See for example commit
324b2298fea ("docs/system: convert Texinfo documentation to rST",
2020-03-06).

> > +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated=
-by``
> > +trailers to indicate AI usage.  In particular, it is not necessary to
> > +specify the exact AI model or tool used to create the commit.
>
> "does not use" doesn't imply "forbidden".
>
> IIUC, tools are liable to add these tags without the contributor
> even asking for them. If we don't want to be providing free
> advertizing IMHO we should explicitly forbid use of these tags
> and validate this in checkpatch.pl

Ok.

Paolo

> Also any rules in this respect should be documented earlier in
> this file where we outline what tags we use in commit messages,
> either instead of, or in addition to, mentioning them under the
> AI usage guidelines.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>



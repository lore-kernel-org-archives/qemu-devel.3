Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91D7CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBuP-0002O1-P6; Wed, 27 May 2026 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSBuK-0002Nr-3r
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:54:40 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSBuH-0003Qz-Tm
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:54:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so3179294a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779879276; cv=none;
 d=google.com; s=arc-20240605;
 b=BzqLTrXd4BVRmu+8Astg6T014WVO1+IxTskj6E98fq2lv+Nqw2Ml/Ac1zLauiGusvr
 kLfZFLBYTEP4tqmZrubEXoV9epfZK55fzqH8LrkQu0hziS/YiIJNRW8iBxpfRA2f1uWX
 u1R6zeh+jqBc6dFKzrE/5FtvUaPE3IG/rh6UrB+sz24Mv7HmO/LYZ8pv+/UGe++9TO99
 PyO9TT1fhQmLY9uDeW+yZ0GxHXw+hQ8Yczh/ng+1zYxSD//yaE9PXyeHGcmhsGPFDUOU
 LI5GHS9P19hALpcTkDCHEWtozRYORsS8qzoO30RPcpKDkvoZae0X6vKB1bJOuIbIOvqO
 krWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XYgeLjStHgd+GIsYPubMujIdj17ke1+ldm6qrL8mrEA=;
 fh=vc+OM9yZPS0uyYOT1xfyR/0AQQZ8z93uMpwxTPdOsBY=;
 b=gW7UVKmVMdm8IyP+WmTZ1NM8UjvbnbGt/JNMfgQIXwc3B8TKujAHcaAAaEEb4+nR3o
 NBLMUjLeU5Btod0KpyG2P5ssYnA7cLNBUVj2KO8oj9I6AtlFwvz8Y8cBQ72OzmQ5q9RJ
 eQRb30w+p6ygu1vc/NY+lRMrwmFBDB+/cwMJ8bGYub/tBO3UWmji3Yz6Nvls5UCtM1CK
 uvCgCz4nmSmQSajdPmCNbrvm3UOvima+QpSEbJ2/D8xgShfwF5OWIrbEeGs9Sy7vKTOR
 cxFeVrYHpUsf3IAQFdVoAfmS/mp+mQ/Hv50CfOUoWW17I3EkHahP1RI0ls7BuqrpqI65
 m5KQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779879276; x=1780484076; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYgeLjStHgd+GIsYPubMujIdj17ke1+ldm6qrL8mrEA=;
 b=K43fXI0lg8KbqVNsITYHZLQn3jnMtfHg92kUiRXMnghlez6gVQdxksy1GoW9YR2vvw
 u4svbRFz3ex//zkNjX7Uym9dnhPMsd7AC2lPBXicHAA/pNauznq1H0MxMakcAlnSH9ir
 sH1KNpCPph/cIzoCurKx5BI7hI1TY4ixfBca1TheE55RTeh9hJeNlh+y7EddYkBjO9Sj
 MLBNKCwRmM41OJGfYPxDIYp3b9ZjYbycElFh+jeuWQE8R90drxuryt0iqfIgIP5vTfdn
 88SVI9QnkfrOUtqgRseshpFLGh2gt7Jw9zlU2gQOqghyoG7CyhaHX4Wo/6dtMoeL9bnV
 BozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779879276; x=1780484076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XYgeLjStHgd+GIsYPubMujIdj17ke1+ldm6qrL8mrEA=;
 b=lQ5qp2G53BcXHqjFGV2Gpea+1eCWXqo9MTNclDk9VqVgDF2eab0Cr5RveQ/tVhbgvs
 3dgGZHlTRla6I8hOrkOz/BExwOWYC/xS6NJWCNx7XIXcb9a87EnoLkzws1C99/LOR3x+
 /vBVpu+R6euR05k+3BTG5+q8NiQFfrKX5dJe3b8/6MbCGDF4t2K13QHIlJtsq7NYRsd9
 Wvg7Cfqhj8y0J/f2fgtGtjWP2KDO/p6dAkfwXSq1wRqvPpj/CXZ850t/bknV0qBK7reA
 zMXSv40mIhWP08FETdCcQYezShWLgNSybAlVUVIPXQp9rRBX1YF7SR+ffuzWx98w5oQR
 mQDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Gkg1ar9PmDoJ/T1NeO6uPCqkFhXUeUw63Xl2WahomrkN0QUPgJR+XAjw9K5rzJpc9EWqNFLEXREau@nongnu.org
X-Gm-Message-State: AOJu0YwfVSp3opKFfJ+US+535o1jCiBSHlLFoYMEsgzbRUrtEAQVOXlb
 iBhGTETeA7TRarRq+mDxCF4xx54lC4dDsEJLvu2S0RiR0/7a+sFYVRlDNbLq0w2rROLcOtAQI45
 8ybh9kNI7Hcp3oRcEvkL9DR7Iuo9tGMc=
X-Gm-Gg: Acq92OFZ9CTjyheAlkdxS6dCJad76LOgl9KAoafV+xlR0DI20j/l12bbJ4kE1faGj9E
 LPoNolWLHO2nuKlWo+4E3HcBuRl8kSYzOEwqo0k3vokueJ9RYeWTUImuWVNGK5ZPCgkCdaLnxwA
 9NCs4wvOIob+VisEep9z6+IM9A9JGxwr+LTrpYOSOMluwZQhbGk+hnXl8hssUGLPUYQQCdt3e2S
 Rr+X2mtxQ8ghBT67Dr7J1rcS86UhcLqic2ckYhe5fGJse05ca6hPMMt39JA1dLFMzfHF2jXU7JS
 Cmlvh5TCnVbJMNtWGFI=
X-Received: by 2002:a17:907:b5a3:b0:ba4:f501:cb8b with SMTP id
 a640c23a62f3a-bdd22f294a3mr996715866b.16.1779879275514; Wed, 27 May 2026
 03:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 May 2026 20:54:07 +1000
X-Gm-Features: AVHnY4JWfIt9TJOL-O1ovXPrKAdA3y1ufVenZWZ5I4DTfQOu7aFCk9xfefBGn3c
Message-ID: <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 8:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 5/27/26 10:41, Kevin Wolf wrote:
> > Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> >> The QEMU Project currently may accept limited uses of AI that produce
> >> high quality patches that are limited in the creative content added.
> >> While maintainers will ultimately decide, changes like the following
> >> fall within this policy
> >> 1. Fixing obvious warnings in the obvious ways suggested by the tool
> >> 2. Tree wide API changes, and other similar mechanical changes done
> >>     today with perl/python/sed/coccinelle
> >
> > As I said in the paragraph you quoted below, I don't think we should
> > encourage using AI for tasks that a deterministic tool could do.
>
> In some cases such a tool does not exist.  Much to my surprise, there is
> no tool to do static type inference on Python code, but AI is very good
> at doing it.
>
> > Letting AI perform the change directly instead may be an acceptable
> > shortcut for a one-man hobby project that nobody else will ever look at=
,
> > but in the context of a community project like QEMU in which your
> > changes have to be reviewed and understood by others, it matters a lot
> > that the output of the tool is reproducible. Otherwise, you're creating
> > unnecessary work for others, and that isn't acceptable.
>
> When applicable, going through coccinelle (with the aid of AI if needed!
> is indeed a good middle ground as it helps reviewers for large changes.
> If you have many slightly different but easily separated changes (e.g.
> you can split the patch by struct field), it may make things worse.
>
> Its also worth noting that in other cases even sed or coccinelle, while
> deterministic, cannot produce 100% of the patch.
>
> > So maybe we should even explicitly mention a recommendation like the
> > following:
> >
> >      If you can use a deterministic tool, don't use AI instead. If you
> >      don't know how to use the deterministic tool, use the AI to tell y=
ou
> >      how to use it instead of trying to replace it.
>
> I like it.
>
> >> 3. Limited, small changes to fix bugs or add a small new feature whose
> >>     scope is less than about 100 lines and the originator can explain
> >>     them all or the meta issues about the patch.
> >
> > Not sure if mentioning a number of lines is wise. 100 lines can be
> > mostly boilerplate and simple sequential code or they can be a deeply
> > nested complex algorithm.
>
> I'd put the threshold at 20-50 at most.
>
> > I think I would see more use in a tag like (better name welcome):
> >
> >     AI-used-for: [code|tests|docs|commit message]...
>
> I like this *a lot*.  No need for free advertisement, but some
> traceability is useful.
>
> For tools such as sed or coccinelle, having the exact script in the
> patch or commit message useful.  Plus, the execution of the script more
> or lesss delimits the commit by itself (or 90%+ of it).  For LLMs it's a
> bit less clear cut because separating docs makes little sense.  And the
> exact model is pointless, it will be obsolete in 6 months and provide no
> useful information.
>
> So, something like:
>
> ------------------- 8< -------------------
> Use of AI-generated content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The QEMU project currently allows using AI/LLM tools to produce patches
> in scenarios with limited creative content:
>
> Mechanical changes
>    If you can use a deterministic tool or a script, don't use AI instead.
>    If you don't know how to do the change deterministically, you may
>    ask the AI for help, rather than having it stand in for the tools.
>
> Small bug fixes
>    These should be limited to 20 lines of code or less, not including
>    tests.  You are still expected to understand and explain your changes
>    and the rationale behind them.

Coming back to Peter's earlier comments and the Zig policy, one thing
we have in RISC-V is people are running AI tools against QEMU and the
RISC-V spec to identify places where we don't meet the spec. They then
write patches and submit them upstream. The patches appear human
written, so have been accepted.

A lot of the bugs found are corner cases that people aren't actually
hitting. From my use of AI review systems in the past, they do tend to
be very nit-picky. So it's not too hard to catch issues that users
won't actually hit and fix them. It's a valid fix, but easy to
inundate reviewers. If this process was entirely run by an LLM it
could be way too much.

So maybe we should add something here about don't send large numbers
of "small bug fix" patches. So someone doesn't point an AI at QEMU and
a spec and generate huge numbers of patches, all of which are just
small bug fixes.

Alistair

>
> These boundaries do not apply to other uses of AI, such as researching
> APIs or algorithms, static analysis, or debugging, provided their output
> is not included in contributions.  Larger uses of AI are allowed as an
> experiment, but they should be agreed upon with the maintainer prior to
> submission.
>
> Use of AI does not remove the need for authors to comply with all other
> requirements for contribution.  In particular, the "Signed-off-by"
> label in a patch submission is a statement that the author takes
> responsibility for the entire contents of the patch, certifying that
> their patch submission is made in accordance with the rules of the
> `Developer's Certificate of Origin (DCO) <dco>`.
>
> Commit messages for AI-assisted changes
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> When AI/LLM tools produce or substantively shape your patch, add an
> ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> explanation in parentheses::
>
>      AI-used-for: tests, docs
>      AI-used-for: code
>      AI-used-for: code (refactoring)
>      AI-used-for: code (prototype)
>      AI-used-for: research
>
> The trailer is intended as a clarification of your DCO obligations as
> well as to guide reviewers.  It is not intended for minimal presence
> such as autocomplete or asking for a pre-review of the patch, and it
> does not remove your responsibility to understand the changes that you
> are submitting.
>
> Include the prompt in the commit message if it helps a reviewer judge
> the result:
>
> * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> function already has a local variable or parameter of type ``struct
> bb``, use it instead of accessing ``aa.bb``."
>
> * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
> forwarding the member functions to ``T`` while taking the lock around
> the calls".
>
> * no: "write user-facing documentation for the new tool"
>
> * no: "write testcases for the new functions"
>
> Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> the trailer, but should be mentioned in the commit message.
>
>


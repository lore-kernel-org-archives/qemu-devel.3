Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259CACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnB7-0004jN-B8; Wed, 03 Jun 2026 11:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUnB4-0004il-1v
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUnB0-0002RL-4f
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780499197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y93FARN0r2Hw3TkoY5pQVn7y6cvxQfwbVe7Kg7L+RdU=;
 b=CeGYWp3TTTNCChn5BNKfiEYWOlqcwkceeIKBbzFYfqB0nzrV4hlayKauySq3EmrmGbUSm6
 YRSRYbyqG2S4xIih/DHSBCJZT5kBY9gde8ZYjFjB4AKyTGcjGgDAIHT+nZNgm/3YC40a9a
 OJG0S97NhhJbV3FaHQDzOGunZRs1O2I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Qh2ZPcnEMUiT-Ej_AXhkrA-1; Wed, 03 Jun 2026 11:06:34 -0400
X-MC-Unique: Qh2ZPcnEMUiT-Ej_AXhkrA-1
X-Mimecast-MFC-AGG-ID: Qh2ZPcnEMUiT-Ej_AXhkrA_1780499193
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so19398635e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780499193; x=1781103993; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y93FARN0r2Hw3TkoY5pQVn7y6cvxQfwbVe7Kg7L+RdU=;
 b=HxnV99l/J9TtGru7aYhdheTARzpOjms7UeqeMxIk97To9i4fffem+nv5RISluBdVl1
 KJflQVyLdJVFu/uHpjnsQA7p7dz2On2R20D2s3fZyZpPheW9qfWJjnZpC6wcVdf8SWk7
 DWuzcctthpIsl09J4zeCLyFfHuEZeP/ch0mxsyk+PKwTmwRPRr2WHqBPVvvBghFEi3pC
 iemuDgHW2DY1Mg2mlltbKPNbJX9oTaNGorXq+O3ltORbRRBNgbyWd1OjJlMjDzHbnVfI
 GyfyfKpRRo1GoXDX+imAcO7I8sbqq3qXfFbUMYs7GHaLoBZbm6ccmHp4Xu2RJYoDOAEB
 6rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780499193; x=1781103993;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y93FARN0r2Hw3TkoY5pQVn7y6cvxQfwbVe7Kg7L+RdU=;
 b=tLKf4euFt1ZEiP6FEqmr/7dowfkOBwdEi5ZK04Ifu/5BucrWNMXV+gKlpJAtPgQhpD
 8bE0johiX4KZWNAqIvDXzp46HkgwDKPvPUKNcqEwdu429YuOh+28tALSSUFm3vT/x/kU
 ABOTKE62PVyFPpitpx2tztssjLxMcUwSMAr83fGuyCHbTFKGrYwV9yFUc0HjKZRB/yOg
 LTk3FzjfPcEucx7+sRhBsm3gncDtWXBabYy1BgXXEQgHeMdYaqOOf8HskLjB5Tt0y1BH
 Ij8LWvXZXWpttpsOlFNb/zwsNT07rfj7WbznEmmS+YKE/XPwG+Mh5jlOYaPiU8WTtrdX
 nhqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dG7oZhGk2q8zNeVngnw5G8zG1sdUf0vznkCaH9A7/a0HyeT4/XHNDdKloSdrBimDy73+FIFjBv3Eb@nongnu.org
X-Gm-Message-State: AOJu0YxIft54KWpYwvv8QnahHKz0OqyjQUfYrkgwLocZZCYYvI6rA7s4
 UrWf0qc++1YW4L0hSZ22fQPgeuTDlxOyBITuMM0MrYBHoshKLG1JeTHJAYEkBuyJIs/daYqeLf5
 RvN6X44r9Od0xLBs9fGVLHWITTV7zp3dalVWPSqZtYXlFKNb+q4jZFR6i
X-Gm-Gg: Acq92OFYImhGKWh+hrtUZP4bGtZd1g35ISq9o49+bOtTvUM/XV1MVdnEN8YF6EjFSRe
 mamoe/u57y0y87YIQKNNiqGVxsPyirNjmPrKcbUX/xBR2doMFh1p59V84dmlT9qit5jyAfTz3nV
 BgJNw+GsqgZxdmv9B9aQcDAbjLoONBJiBMesQ55V4lkN7N/2D2p87OilT5gJiXbo6t852rdqcJU
 PvQQxGAS+fVQxxuV4tNy86IXpVBM74CPqYQTvWilfgHMEURNVNHxMjz1iLuEV9KIq0JxwMmPKmj
 v3jO42ndSqxbJ3MvBJmKFaULkyJyC1PxMteyElkZhQtjefBgQyzFuHhFy4vcHI46tOxRnXGmj7z
 FwmvB3mla1+E/9qGfu3PPU4GygutE9YVCFqMFzoSOe+50qLFgaaczkA==
X-Received: by 2002:a05:600c:4e87:b0:490:b432:6f1e with SMTP id
 5b1f17b1804b1-490b60e4026mr61577525e9.33.1780499192186; 
 Wed, 03 Jun 2026 08:06:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:490:b432:6f1e with SMTP id
 5b1f17b1804b1-490b60e4026mr61576555e9.33.1780499191350; 
 Wed, 03 Jun 2026 08:06:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e88fdesm156809255e9.14.2026.06.03.08.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:06:30 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:06:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260603110555-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiBBV48wyDF57vUi@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 03:59:35PM +0100, Daniel P. Berrangé wrote:
> On Fri, May 29, 2026 at 11:46:19AM +0200, Paolo Bonzini wrote:
> > The concern that motivated the policy is unchanged, and it is worth stating
> > precisely: the DCO is about whether the submitter has the legal right to
> > contribute the code, not about "creative expression".  While the status of
> > LLM output seems to be converging towards non-copyrightability, questions
> > around unintentional reproduction of copyrighted code are still open.
> > What has shifted is the balance of risk:
> > 
> > - projects accepting AI-assisted content have not run into serious
> >   legal trouble so far, which suggests the probability of the risk
> >   materializing is not high;
> 
> "so far" is doing alot of heavy lifting here & generally I think this
> rather over-estimates the speed at which legal issues might arises.
> Copyright infringement is a "slow burn" where the risk accumulates
> over time and issues, if discovered, may not be litigated immediately.
> 
> That is NOT to say the risk is high. The risk may well still be
> low. I'm just saying that there's not been sufficient time to use
> "lack of lawsuits" as a rationalization IMHO.
> 
> > - other organizations, such as Red Hat[1], have assessed the risk as
> >   acceptable -- though a community of individual developers does not
> >   have the legal backing of a company, and even an unfounded dispute
> >   would be a long-lasting distraction from work on QEMU.
> >
> > Nevertheless, even Red Hat mentions that "the possibility of occasional
> > replication cannot be ignored".  In QEMU's view, attentiveness and
> > oversight are not a practical way to address this; yet as a copyleft
> > project, copyright and code provenance are of utmost importance to us.
> 
> 
> > Therefore, it remains prudent to only permit AI assistance where the
> > ramifications of copyright violations are at least easy to revert and
> > unlikely to spread: tests, documentation, mechanical changes, and small
> > bug fixes.  Core code that other things depend on, and that cannot
> > simply be thrown away once a problem is noticed long after the fact,
> > stays off-limits without prior agreement from a maintainer.
> 
> The interaction of "small bug fixes" and "core code" doesn't
> fit well IMHO. A "bug fix" describes an action, but the code
> that is changed is usually a "feature" and will often be a
> "core" part of something in QEMU.
> 
> IIUC, by "small bug fixes", what you're actually trying to
> express is an acceptance of code that is either
> 
>   * unlikely to meet the threshold for copyrightability
>   * small enough that the consequences of throwing it
>     away is negligible.
>   * possibly other aspects ? 


tightly coupled to specific state of qemu code and so original.

> 
> 
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index 65b8f232a08..857588c43ba 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -1,7 +1,7 @@
> >  .. _code-provenance:
> >  
> > -Code provenance
> > -===============
> > +Code provenance and AI usage
> > +============================
> 
> In retrospect, I wonder if we shouldn't have have "ai-usage.rst" as
> a separate doc from the start.  While we can hyperlink to sub-titles
> via anchors, it would be simpler if we could just point to a doc and
> not require scrolling past pages of non-AI text.
> 
> > @@ -288,62 +288,108 @@ content generators below.
> >  Use of AI-generated content
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> > +Risks to open source projects include maintainer burnout from an
> > +increased number of contributions, as well as the risk to the project
> > +from unintentional inclusion of copyrighted material in the LLM's output.
> > +In order to mitigate these risks, the QEMU project currently allows
> > +using AI/LLM tools to produce patches in a limited set of scenarios:
> 
> If we're opening the door to AI assisted contribution, then IMHO we
> need to write about both the social and technical expectations.
> Admittedly that will expand the scope of your proposal here, but
> IMHO that's somewhat unavoidable. A significant part of the downsides
> of AI-assisted contributions comes from bad social practices, rather
> than merely bad technical practices. 
> 
> As a general theme, I would like us to emphasize at the start that the
> act of collaboration & contribution in QEMU is about the interaction,
> trust and relationships between humans, not bots.
> 
> 
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
> 
> > +**Mechanical changes**
> > +  If you can use a deterministic tool, it is preferred that you use it
> > +  and not replace it with AI. If you don't know how to do the change
> > +  deterministically, you can ask the AI for help.
> 
> > +**Small bug fixes**
> > +  These should be limited to 20 lines of code or less, not including
> > +  tests.  You are still expected to :ref:`understand and explain your changes
> > +  <write_a_meaningful_commit_message>` and the rationale behind them.
> 
> I think the "20 lines or less" is not going a good job at expressing
> the intent behind this point. I'd like us to emphasize between the
> "why" of this point, as that helps contributors & reviewers make a
> decision of whether a change is "within the spirit" or the rule of
> not.
> 
> >  
> > +**Documentation and code comments**
> > +  While AI can help draft text, it still requires significant human
> > +  oversight.  Pay attention to the organization and flow of the generated
> > +  text, and strictly fact-check all technical details as LLMs are prone
> > +  to being confidently wrong.
> 
> Docs is an area I'm more wary of from the social expectation side rather
> than the technical or legal side.  I don't feeel like "pay attention to
> the organization and flow" really mitigates to the tendancy to production
> of vast reams of convincing sounding slop. There's has always been a
> problem with docs of well intentioned contributors trying to write about
> stuff they don't really understand well enough. IOW they don't necccessarily
> have the knowledge to fact check details either. As a maintainer, I've found
> that reviewing docs and asking for rewrites can be even more of a burden than
> code. IOW, encouraging use of AI for docs, in non-expert hands, has a strong
> potential for expanding the burden on maintainers.
> 
> I'd be more comfortable with AI tools for inline API docs, rather than
> AI tools for prose under docs/.
> 
> Not sure how to better word this point though ?
> 
> > +**Tests**
> > +  Note that you must still confirm that each test actually exercises
> > +  the intended behavior including, for regression tests, that it
> > +  fails without the code under test and passes for the right reason.
> >
> 
> > +If you wish to send large amounts of AI-generated changes, or any other
> > +contribution not in the above categories, please get in touch with the
> > +maintainer beforehand.  These can be treated as experiments, at the
> > +discretion of the maintainer and the community, with no obligation
> > +to accept them.
> 
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
> 
> > +**Use of AI does not remove the need for authors to comply with all
> > +other requirements for contribution.**  In particular, the
> > +``Signed-off-by`` label in a patch submission is a statement that
> > +the author takes responsibility for the entire contents of the patch,
> > +certifying that their patch submission is made in accordance with the
> > +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
> 
> 
> This needs to be stronger language IMHO. The kernel has a more
> explicit statement explicitly forbidding agents from adding
> Signed-off-by on behalf of the human:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-assistants.rst?id=4bf85afb9f3ecd7c3b5d15a85b0902f8e725cd06#n27
> 
>   "Signed-off-by and Developer Certificate of Origin
>    =================================================
> 
>   AI agents MUST NOT add Signed-off-by tags. Only humans can legally
>   certify the Developer Certificate of Origin (DCO). The human submitter
>   is responsible for:
> 
>   * Reviewing all AI-generated code
>   * Ensuring compliance with licensing requirements
>   * Adding their own Signed-off-by tag to certify the DCO
>   * Taking full responsibility for the contribution"
> 
> 
> I think we should be similarly explicit that a human must take
> the action of adding S-o-b - it is not a rubber stamp to be
> automated by the AI.
> 
> This should be emphasized in the earlier part of the doc before
> the AI usage section where we described S-o-b usage.
> 
> 
> > +Commit messages for AI-assisted changes
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  
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
> 
> > +There is no requirement to include your prompts or summarize the
> > +conversation in the commit message or cover letter, but you may do so
> > +if you think it helps a reviewer judge the result.  For example:
> 
> IMHO we should actively discourage the inclusion of prompts
> entirely as it is the wrong information to provide. 
> 
> > +
> > +**Helpful prompts**
> > +  These describe concrete constraints or instructions, making it easy for a
> > +  reviewer to see how the tool's output was guided:
> > +
> > +  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> > +    function already has a local variable or parameter of type ``struct
> > +    bb``, use it instead of accessing ``aa.bb``"
> > +
> > +  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; it
> > +    takes the lock around the calls and forwards to ``T``"
> 
> These examples prompts are just expressing an aspect that should
> already have been described in prose in the commit message. We
> don't need to classify them as "ai prompts" in a a commit message,
> we just need the author to write a useful commit message.
> 
> > +**Unhelpful prompts**
> > +  These are too generic to provide meaningful context.  You can of course
> > +  use them in the context of a complex interaction with the LLM, but they
> > +  should not be included in the commit message:
> > +
> > +  * "write user-facing documentation for the new tool"
> > +
> > +  * "write testcases for the new functions"
> 
> Again this is just an illustration of an unhelpful commit message.
> Those would be eqally useless in an entirely human authored patch.
> Just emphasize the writing of useful commit messages.
> 
> 
> > +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
> > +trailers to indicate AI usage.  In particular, it is not necessary to
> > +specify the exact AI model or tool used to create the commit.
> 
> "does not use" doesn't imply "forbidden".
> 
> IIUC, tools are liable to add these tags without the contributor
> even asking for them. If we don't want to be providing free
> advertizing IMHO we should explicitly forbid use of these tags
> and validate this in checkpatch.pl
> 
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



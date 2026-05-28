Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA56BCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb3Y-00076q-Cu; Thu, 28 May 2026 09:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSb3U-000708-3n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSb3R-0001xa-59
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779975943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lxkp6wAkhmYDX8XgGgnkMMqrEbQMYcftVyI/Qkzz0Jc=;
 b=AEUWeW46HMQjCJhCAY/GV+ct7Q2M7qJ8GfUZFMVjJ4hPQ6nnCTnTARaW+V33ymtbKPsoQl
 iMW+p4B5W5GT080wp8WXk+FuZ67r98Ra7vr1N3QXKB9DXoO4al5fKY2CHVglevFuROxnjP
 NG63Rtf9yJ6JvreAmLn9efvRESHgQgA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-bK8ik_-cORGceXX1i5-diQ-1; Thu, 28 May 2026 09:45:40 -0400
X-MC-Unique: bK8ik_-cORGceXX1i5-diQ-1
X-Mimecast-MFC-AGG-ID: bK8ik_-cORGceXX1i5-diQ_1779975940
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bcfd21f71ddso417408166b.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779975939; x=1780580739; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lxkp6wAkhmYDX8XgGgnkMMqrEbQMYcftVyI/Qkzz0Jc=;
 b=dr9wzH0BC5dKjzxlglmb9y3bnW/yzLxpJB/0TSocyJpHXdIptOiNCMnkTICSET2znA
 FxzsXik3a3fLjgjtbbNy8hCHWxC8VkmKLCdXIvpMMDlK44aYncjBuKftKaYX/hCz0rQW
 xWePEkCMPom5NbpFXv3GEABWlftufip6zLHE86b+ZhFTZxuiSizM0uDYbtKmenMz576x
 M8Av6C8eamn2od+R2bqBYJZVHSvLqtF37xDynYfUM6E1O1DvOkg4jA9Ro9Xw0zW2YL+y
 ZK6B2iPJWLEA1ahkkIIiCPlCRe6x21296CFdsXXCg6iZ0q0V4mbtnCWBEm9YUgfJ2vJw
 gSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975939; x=1780580739;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lxkp6wAkhmYDX8XgGgnkMMqrEbQMYcftVyI/Qkzz0Jc=;
 b=oqjA9MMABZcZwZdWNFg/Dij8JOGtSWqbtBaxVJpcDlhvvz4TL7AEbnmvq1NkPGRaZH
 TOMRNYIpqBaG9DIdUkauRNzenvUNPeaK5C8ZmapUWVIeSdndE81icWIlmfzlOoQBgEey
 +WPf5QEHc69NfuokQR7yGOZ6/1f9Y8AfOt5njt4bliOi8soAgbpN/FyfIg16JsvpA0/n
 rb1Z6OiPEnLvNFbRKLDHv1hy3vCyqMUiNKwecN7uEtpeJj53yp2ycbKcELppeYOLjksI
 DI+vOjyv8KsdKkw9hx7yh6kcumP4m+JUItZ9/VM5zuwdLLDUfdC9ZZrHxdoAnm+pgltK
 8rJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZLAI7iDHz4emYmSn7PFwNeQuystANgmOxuuMRy7GJZjdlXY1zSx1V6yfs/s9kz/MPQ6aAnLOECLZU@nongnu.org
X-Gm-Message-State: AOJu0Yy6bHF8C7e+hFVQndRgUNOU1dHgMhdAioZWHtpa3uiE8zuIQvzs
 l1hLWyhKRrl+aRMwZqagJeswWqm07pvrjwemlBzDfiG1q7BteEa3Vz9mfZn2oxDcSgvIiywgp6c
 dp66ZSBwtSSA1/c7PnwioV+Ka2sRvTzaI5ZK0rUJWHD6fQk0IBJ5nq7r2
X-Gm-Gg: Acq92OHcqVGgc6ZAvS0OrAW1yL0/fDv5EY4rgrLpMgt0+ZISOFBFgPlkfJ9ETR6JBB/
 JVdSz+RUv2pcAWmOtC2/pBA43UCsf37H3iVhpgn6kMp0O+Vod8FVkjq+zHx+6yjyabxw5krApOu
 90o04NEus/ww5qGe4WMkbZVAK5TlmOpa07g5oR32fAqnLosPE2I37N+itlvhU1ggZr1jiiAYukj
 vDFzSByr1DXLqzgmsd80XpSXjv6e0hQG4GS/tYffKMI4Z02PyEBZDOaSst6By7oH8GweuEtqVnC
 me8SBSvrxEIz8HVC7ULy9GKJYhX3VfHAiBIQnzCRL9sAIMnEBDTMLVjojwj4ZxGREoTtmFe8XMC
 TexsELT0/5wRlnQRFKd8bKusvlThSQ/Sz0A8FObbq7W+GHtg4NOOUwA==
X-Received: by 2002:a17:906:ef03:b0:bd5:4536:6179 with SMTP id
 a640c23a62f3a-bdd26fcb7dcmr1614098466b.49.1779975939460; 
 Thu, 28 May 2026 06:45:39 -0700 (PDT)
X-Received: by 2002:a17:906:ef03:b0:bd5:4536:6179 with SMTP id
 a640c23a62f3a-bdd26fcb7dcmr1614095766b.49.1779975938839; 
 Thu, 28 May 2026 06:45:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d9520sm722552766b.50.2026.05.28.06.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:45:38 -0700 (PDT)
Date: Thu, 28 May 2026 09:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260528094350-mutt-send-email-mst@kernel.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <c05744d7-698d-313e-2365-865c2cda37e6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c05744d7-698d-313e-2365-865c2cda37e6@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, May 28, 2026 at 02:12:51PM +0200, BALATON Zoltan wrote:
> On Thu, 28 May 2026, Paolo Bonzini wrote:
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify.
> > 
> > The concern that motivated the policy is unchanged, and it is worth
> > stating precisely: the DCO is about whether the submitter has the legal
> > right to contribute the code, not about "creative expression".  The
> > copyright and license status of LLM output remains unsettled, so that
> > question is still open.  What has shifted is the balance of risk:
> > 
> > - projects accepting AI-assisted content have not run into serious
> >  legal trouble so far, which suggests the probability of the risk
> >  materializing is not high;
> > 
> > - other organizations, such as Red Hat[1], have assessed the risk as
> >  acceptable -- though a community of individual developers does not
> >  have the legal backing of a company, and even an unfounded dispute
> >  would be a long-lasting distraction from work on QEMU.
> > 
> > Revise the policy to permit AI assistance where the ramifications of
> > copyright violations are at least easy to revert and unlikely to spread:
> > tests, documentation, mechanical changes, and small bug fixes.  Core code
> > that other things depend on, and that cannot simply be thrown away once
> > a problem is noticed long after the fact, stays off-limits without prior
> > agreement from a maintainer.
> > 
> > Related to this, and already visible in the incredible uptick in
> > security requirements, is the question of maintainer burnout and the
> > shift in effort from the author to the reviewer of the code.  AI lowers
> > the cost of producing a patch but does nothing to lower the cost of
> > understanding and reviewing one; if anything it raises it, since a
> > reviewer can no longer assume that the submitter has reasoned through
> > every line.  The limits above work just as much to keep the volume of
> > review work sustainable.
> > 
> > Furthermore, introduce "AI-used-for:" as a trailer to record where AI
> > was used, and include other suggestions that help reviewers judge
> > the result.  The standard is slightly different from the more usual
> > "Assisted-by", which doubles as a check that the author has read the
> > policy.
> > 
> > In any case, use of AI does not relax any other contribution requirement:
> > authors still comply with the DCO and take responsibility for the whole
> > patch via Signed-off-by.
> > 
> > [Commit message largely based on
> > https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
> > Kevin Wolf. - Paolo]
> > 
> > [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> > Cc: Alex Bennée <alex.bennee@linaro.org>
> > Cc: Alistair Francis <alistair.francis@wdc.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Warner Losh <imp@bsdimp.com>
> > Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> > Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> > ---
> > docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
> > 1 file changed, 75 insertions(+), 48 deletions(-)
> > 
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index 65b8f232a08..84f9f4a70fb 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -1,7 +1,7 @@
> > .. _code-provenance:
> > 
> > -Code provenance
> > -===============
> > +Code provenance and AI usage
> > +============================
> > 
> > Certifying patch submissions
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > @@ -288,62 +288,89 @@ content generators below.
> > Use of AI-generated content
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > -TL;DR:
> > +**Please read the below policy before using AI to contribute code or
> > +documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> > +Llama, and similar tools.**
> > 
> > -  **Current QEMU project policy is to DECLINE any contributions which are
> > -  believed to include or derive from AI generated content. This includes
> > -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> > +The increasing prevalence of AI-assisted software development,
> > +and especially the use of content generated by `Large Language Models
> > +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> > +poses a number of difficult questions.
> > 
> > -  **This policy does not apply to other uses of AI, such as researching APIs
> > -  or algorithms, static analysis, or debugging, provided their output is not
> > -  included in contributions.**
> > +Risks to open source projects include maintainer burnout from an
> > +increased number of contributions, as well as the risk to the project
> > +from unintentional inclusion of copyrighted material in the LLM's output.
> > +In order to mitigate these risks, the QEMU project currently allows
> > +using AI/LLM tools to produce patches in a limited set of scenarios:
> > 
> > -The increasing prevalence of AI-assisted software development results in a
> > -number of difficult legal questions and risks for software projects, including
> > -QEMU.  Of particular concern is content generated by `Large Language Models
> > -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> > +**Mechanical changes**
> > +  If you can use a deterministic tool or a script, it is preferred
> 
> I think mentioning sed and coccinelle here would be a good idea assuming the
> contributor trying to use AI is not familiar with those so would not even
> know what to ask the AI to help with.


No, let's not go there please.

There is nothing so magical about coccinelle and sed, that we should be
asking people who know nothing about either to have AI generate slop
they can not read and then to run *that* themselves.
     
Nor does the assumption, that said slop will be in the commit message and
the first person to actually read it will be the maintainer, appeal.

-- 
MST



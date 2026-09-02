Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519F8C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mgW-0000wv-2i; Wed, 02 Sep 2026 11:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1mgU-0000wl-5Z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1mgS-00075p-98
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788362127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SNHDBa6jDxfTnl0Q8D6KmBB9Pi21fo0artPfovSgnY=;
 b=Bmr/sBh7nfJU2B1aADz05jznPtOB9Z+kgcD9btC/mhdf+z1dFzSrFk/irD+PFXopsBmkDe
 Ehp0vXhquEbwXSqOI3/8pxgTAVJ6MXhH57B6yawHaLr3fmrb5eDlp/tQo5nJxNOhLff/3f
 kJHVoNReIKuJqYC1kKexwblpmBefG6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-cbS697i7O-CvVQQ_boLVTw-1; Wed, 02 Sep 2026 11:15:25 -0400
X-MC-Unique: cbS697i7O-CvVQQ_boLVTw-1
X-Mimecast-MFC-AGG-ID: cbS697i7O-CvVQQ_boLVTw_1788362123
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b7c1dc61eso10520685e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788362123; x=1788966923; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1SNHDBa6jDxfTnl0Q8D6KmBB9Pi21fo0artPfovSgnY=;
 b=kV6VxG2Tqp0utWxU6w2kjZZYy7Kthr9NhIp65WDDmy6bqJiErEgSWAIUztRF7muDhd
 DmsgtfxIaoPlPxc7LUvOOX0XbzM30grewow42Ywo+0inCevgv7RIGv7XcJuPdIFaF+EI
 CT9lMrOC/cXBWBFE9G/5fNDHkbhu4s4sjcEY+Y/9l9/fsRVHwY6iDUgOk5aCKHe41DL9
 fC5wdxPc0IiH55aBemoTd9ForxWDh2/sQmMujj9vGttpeqH4/8wqsE+fmyMKDAEusOEM
 NgvbZyJCpPZD+zVgc7Cq64TAdWAeQ9yr/ftJsOt61PotgdYPjWvPLVF976B1sY/DEtqS
 6zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362123; x=1788966923;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1SNHDBa6jDxfTnl0Q8D6KmBB9Pi21fo0artPfovSgnY=;
 b=S8KEKvX5kvi/7+Yc3q40kwwYD+0dTWk3mSYjA1veNbdIdrMF9Fb/jA6ErOay7sN0Zx
 sHgfcewGaiYuwO1fza7TW5Yr+Em/s6BZZuQDDvkuycmdMu4Uv1yNWRkEJAXiLirkpIzU
 vCDWPvq6VzcP3+6q7uspoDTt46WmaM/ExRfzd2nYnmMX9rY5neDmsICEyRqD7U4+7o5E
 kepJLRMPXLspjyzhITZjzo5IzQlhvY6rCddPaNvvSzYPCWssO2vDxFVSftwc9FaTtXO3
 cLxkG+CYqYDLGIsBBiYoqtGrBjvalph+MqXJHWIY15L3jEoicLTJUCqpwqafu2MOOhcy
 CzEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJlMUIMlDeb0eEJegk1EWx+lfMbOHo7PwHbonpkabFUfwLMhi0w4HH9i+L/uOYjnME4qwKZ9sICE1Z@nongnu.org
X-Gm-Message-State: AFuF++nYg7ocS3pq3OU71kdNeqJd8H4RwKnkhaeZUAPVh5rfNaWSTmjh
 SkAacztxfMvGKm/viKp7C6C+mRX36/SwKVVm7VlGxj4GsTxWjJd5/HRLuAd2od0GIXi1k6Osrge
 9wAUHL2NMP0mNIAMCYpnfaYGB+asTRtCbQEQJXI+SPEj8yEVQUGQAUv15
X-Gm-Gg: AR+sD137y1l0S9Wi7NFKeNaN/IbF9LY5IkPCnE6BebwcsYuOF86U+g+xjKKLUC4gKSV
 qC686NVF2xK8lJUz5/wCWBUT0pPi9AdRWO4FPNRHvrSpLuKhDoDChmIRrdF19tfHINMjG1mQwb1
 6vnjYeZnYIz40cm4lm7DyPuQw6RpEuT30Qyq4gxoMlHl8yCXcuImUArLTJn1HlGOyOqWpalquGQ
 tDUSirq0T4AFmK12awP1eMdREAv57FFaT08OQld4qmL7dxlFAJK/shPR4jldoPTgmmHvqX4iKW5
 diySU6F0hcmbSCGBCPfBEVLCURbyNBbdmHMjumUVYCKuTWdUrejIZcnFTHV8IPOhKj4=
X-Received: by 2002:a05:600c:4e16:b0:49c:ee06:9c58 with SMTP id
 5b1f17b1804b1-49cee069c79mr13904515e9.4.1788362123076; 
 Wed, 02 Sep 2026 08:15:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:49c:ee06:9c58 with SMTP id
 5b1f17b1804b1-49cee069c79mr13902575e9.4.1788362122462; 
 Wed, 02 Sep 2026 08:15:22 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm45976475e9.3.2026.09.02.08.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:15:21 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:15:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: Let agents know what the participation
 rules are
Message-ID: <20260902111324-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
 <87a4pzrcqw.fsf@draig.linaro.org> <apgpDaBqCaVPqmLH@redhat.com>
 <20260902095523-mutt-send-email-mst@kernel.org>
 <apgt6epzNKfo5AM0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apgt6epzNKfo5AM0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 02, 2026 at 03:08:41PM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 02, 2026 at 09:56:25AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 02, 2026 at 02:47:57PM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Sep 02, 2026 at 02:42:15PM +0100, Alex Bennée wrote:
> > > > Paolo Bonzini <pbonzini@redhat.com> writes:
> > > > 
> > > > > Humans seem to be extremely unreliable in following rules around this,
> > > > > even after being told directly and repeatedly. Telling agents what to
> > > > > do seems to yield better results.
> > > > >
> > > > > This document is based on GStreamer's AGENTS.md file, as of its commit
> > > > > d08375499c279a56c0e77c928fbeae0d80cdf937.  However, GStreamer's agent
> > > > > instructions are "effective" enough to require an explicit carve-out
> > > > > for maintainers.  I actually believe that such a carve-out is a sign of
> > > > > going too far, especially given the good quality of some suspected-AI
> > > > > contributions we've received.
> > > > >
> > > > <snip>
> > > > > diff --git a/AGENTS.md b/AGENTS.md
> > > > > new file mode 100644
> > > > > index 00000000000..8fb96ebfc38
> > > > > --- /dev/null
> > > > > +++ b/AGENTS.md
> > > > > @@ -0,0 +1,100 @@
> > > > > +# Agent Guidelines for the QEMU Project
> > > > > +
> > > > > +QEMU is a cross-platform emulator and virtualizer. Due to the complexity
> > > > > +of the domain and codebase, and the interactions therein, the QEMU
> > > > > +project relies extensively on the effort of **human reviewers**, which
> > > > > +is **a scarce resource**.
> > > > > +
> > > > > +There are strictly-enforced rules for you, the agent, to participate in the
> > > > > +project.
> > > > > +
> > > > > +## Interactions with maintainers must be human-human
> > > > > +
> > > > > +The QEMU project has strict rules on what AI-generated material can
> > > > > +reach the maintainers.
> > > > > +
> > > > > +### No automated posting
> > > > > +
> > > > > +- Agents **must not** use any API, CLI, or web UI automation to:
> > > > > +  - Interact with the QEMU mailing lists
> > > > > +  - Create, edit, or close **issues ("work items")**
> > > > 
> > > > The others I'm fine with but I currently use an agent to do triage on
> > > > un-tagged issues. It only updates labels and occasionally posts a
> > > > comment when more information or a human input is required.
> > > 
> > > While this is technically something you're doing via your personal
> > > gitlab account, I none the less view the agent triage bot as something
> > > run as an "official" project service.
> > > 
> > > IMHO the AGENTS.md policy primarily applies to actions done in an
> > > individual capacity (whether contributor or maintainer).
> > > 
> > > If the project wants to deploy project level services that utilize
> > > AI in some manner and that conflicts with AGENTS.md that's acceptable,
> > > provided we discuss & agree that the project service in question is
> > > desirable.
> > > 
> > > Perhaps this is me saying that the issue triage bot should be made
> > > more official as a service, committed to git, etc
> > 
> > well I have a script that uses gitlab API to run the security process
> > workflow. But it's... how do I put it... AI assisted ;)
> 
> Can we make that an official project script too, such that it is
> something that is reviewed and thus "blessed" as acceptable ?


Once we have a policy that allows including AI written code, sure.


> I'm pretty uncomfortable with the idea of policy that allows for
> arbitrary AI agents processing issues with no independent review
> of what they're doing until after they've already done it.
> 
> The issue agent Alex runs, while useful, also makes a decent number
> of mistakes and wierd assertions in comments it adds. To some degree
> that is unavoidable for AI based tools doing this work, but IMHO it
> justifies the extra review to ensure the community is broadly happy
> with the tradeoff in the tool in question.
> 
> With regards,
> Daniel


At least my script does not do anything like this.
It just implements the security workflow.
Does not add comments.

-- 
MST



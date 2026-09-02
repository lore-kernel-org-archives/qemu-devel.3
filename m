Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E8BC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hTW-0007FQ-My; Wed, 02 Sep 2026 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hTV-0007FI-OD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hTU-00071A-3F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788342102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVy4vtE0ShkockVlBL168An0pxFi7LuPggVxGZbc4Kk=;
 b=ETOipuK2rfAauSPhHBgBSBI9he4iocpe4BjHUmADOzWM73Swr9OX+AYSgcpUJf5fiG5UUO
 RmEwDxYzApKYSWaFlUBTH7tHmeUmRKgij5az/AkuwTNhMF7Dhtj9dF7/TeoDC/BrAsVP0J
 dQltq4oWa2hXt+ZFFs9awPL4S7zTf8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-85IRWIhBN6aohzkusyYSjA-1; Wed, 02 Sept 2026 05:41:41 -0400
X-MC-Unique: 85IRWIhBN6aohzkusyYSjA-1
X-Mimecast-MFC-AGG-ID: 85IRWIhBN6aohzkusyYSjA_1788342100
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso7155745e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788342100; x=1788946900; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PVy4vtE0ShkockVlBL168An0pxFi7LuPggVxGZbc4Kk=;
 b=IiSrBGIbv5wnnifqe3lBhAWymHXHDQbYqafpKVII7pR2FxOS4V9KyxuvYnyL2zBywf
 +/gyQoEP60h/DoWAKTfOQNju6MqmZWzvbV57729IQNHV721gTZyzYDvorvBhqg0na8AP
 SqM+NJbHVZxuD/ItgTaahNaZz+LsOwKmVqyNINzxvynKikwirGSSOFQ1RejVasYSaneN
 4JCO1lerf8yT3UOT7nyTY5MpZoHltZY1JedBIStPaJy0t3spBuwbbfhiGjhvyIKXnzA7
 mJLnmqtTm8zDXS+X/089wz5g2x5tW6yyoPeXw2nTJD3/ddEWyMhLjTxoVRTx4sMqwhch
 O/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788342100; x=1788946900;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PVy4vtE0ShkockVlBL168An0pxFi7LuPggVxGZbc4Kk=;
 b=dQpKo4he3GlKTKb6POk+3JPeNn5XR7izXJnYwDK6U4ggAhu5QMRvdIwWDN4V7yAlNb
 W46KG2RC4El/ZS6ZkiyuGdvvDYdS4p3a9mgdqq7l9Ventgq3uS+nOvgGlJpnz1ikJVbi
 xKlX9vRbrAmBkAyVttUE0XIlNLHljsr/PETS19VbPxLCQ9DhgQH6uJg87Fqm0tRmnUy2
 9QMM2jo3/bwP58mlLgnklsvxY+Ajo8gx/MEqGjf5d1s7ustoJXmI4VW2R/pcMPMOmXIY
 cBdg9QER9V6HfDsfVVZiFgLHfGE3IzBpb6QuyMwYLQ88Bn/m+wBI+d0QML02MyGaKLpG
 KorA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvwBwaxdWjUr+lWkbAK+/yRegYqP+muQdRAgOMaz3gZSdM5+ei2ZTHisdawDJBUWsm2PE9/2WT0PXp@nongnu.org
X-Gm-Message-State: AFuF++l4kca+Mk8alSnXkOXFAjaCuDjS6673PAwC41hw/fMjdoLc0O7I
 3Ni19Jo03n2bIR+/gVVrMT+n/UV3nrVDzdu1ubGoy4TKIA1lqTUfoRXXsPrHYxS87kHmdNXF13h
 NTqUyIoXLiGgOU4jDrVsrJFupNd6r4ngDhZELaZGfRuDeyTRBau5x53Iu
X-Gm-Gg: AR+sD11WcvoHGftwrHWfdr/Bmc/Z7RaF71czn4uGqMLrAPbjETokGXTsrDPJ888ibI9
 FkJDP3RCMb2gO3XV4+yJexTp97ij0hQ1l3BWbYMy39lkiJjMsbYcD6QLGCtyIRW8OZjQZ7u7l1h
 909ltNKZnE4J/NZGMjFPfsyezQLpvyb8qaUoapglRTDkhGOvO1o66CgI5gBYcCLdWTggVxLYkB8
 V+q0a3D904hu/27QZNMEEjwPi9itkUvFiFhh2A6Lf2M2lUwfMGte4Eq5B/FWNB+w/5NrD0jRFCi
 pM9tmtDHCUf/qkX6eYGG2vSFoRW+gFT4hm+ggvC2YigobsxC8H7BvLnTS+ukrTrVYl8=
X-Received: by 2002:a05:600c:8b63:b0:49b:c8e:8e6 with SMTP id
 5b1f17b1804b1-49ce558ebd8mr68086545e9.0.1788342099813; 
 Wed, 02 Sep 2026 02:41:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8b63:b0:49b:c8e:8e6 with SMTP id
 5b1f17b1804b1-49ce558ebd8mr68085715e9.0.1788342099341; 
 Wed, 02 Sep 2026 02:41:39 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4642382sm59163155e9.3.2026.09.02.02.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 02:41:38 -0700 (PDT)
Date: Wed, 2 Sep 2026 05:41:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>,
 "farosas@suse.de" <farosas@suse.de>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
Message-ID: <20260902053207-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
 <e6ff364982ad264e0ea608458eaaa5aaa292913c.camel@wdc.com>
 <e0a10f28-9b6e-4555-b31b-ec3ea111f536@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0a10f28-9b6e-4555-b31b-ec3ea111f536@gnu.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 02, 2026 at 09:09:59AM +0200, Paolo Bonzini wrote:
> Thanks for the review!
> 
> On 9/2/26 03:38, Alistair Francis wrote:
> > > +Prohibited use of AI
> > > +''''''''''''''''''''
> > > +
> > > +The following items **MUST** be written by humans:
> > > +
> > > +- cover letters and commit messages
> > > +
> > > +- responses to reviewer comments
> > > +
> > > +- issue descriptions or comments
> > > +
> > > +Light copy editing of human-written text with an AI is allowed.
> > 
> > What about translations? Not everyone can write English well and I see
> > translations being useful.
> 
> Difficult choice.  I can see that it's useful, but we've never been
> hardliners for English grammar, and translation may cause agent-ese to slip
> in.

And it does! My suggestion:

- demand that contributor writes text in english.
  if someone is speaking to us through an LLM due to a complete
  lack of english .... do we really want that?

- add text in AGENTS.md along the lines of:

  When asked to fix up english syntax/grammar, DO NOT MAKE style or
  wording changes beyond correctness. Limit your text changes to solely
  fixing correctness issues or coding style violations. Also, if the
  meaning is ambiguous, do not pick a possible meaning, instead insert a
  question for the user and prompt the user to clarify.

>  I am not a native speaker but I wouldn't use this possibility, so I'm
> not the best person to decide.
> 
> That said, if somebody asked the agent for help translating, it would
> probably do it anyway.
> 
> > > - small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of
> > >   code) are allowed with disclosure.  Splitting a submission in multiple
> > >   parts is **not** a valid way to bypass this rule; repeated, frequent
> > >   posting of such fixes must follow the rule for full contributions.
> > 
> > Maybe add something like (fell free to edit):
> > 
> > """
> > When submitting LLM generated bug fixes the human should clearly
> > describe what the bug is, how it is triggered and how it impacted them.
> > The idea her is that we don't want people pointing an LLM at the source
> > and generating "bug fixes" for issues that users aren't seeing. This
> > can result in reviewer burnout.
> 
> I left that out because the document is already very long.  My suspicion is
> that the agent is able to infer most of it thanks to the "understanding"
> part of AGENTS.md, and reviewer burnout is covered by forbidding repeated
> posting of this kind of fix.
> 
> > > - use of LLMs to help generating parts of a larger patch---a test
> > >   case, a parser, boilerplate code for a new API, a tool to help
> > >   performing mechanical changes, etc. These are generally allowed, but
> > >   disclosure is recommended.
> > 
> > disclosure should just be required here as well.
> 
> I think it depends in general.  Sometimes there is really just one way to
> write code in this bucket, and in that case disclosure is superfluous (see
> for example the "impl<T: ToMigrationState> ToMigrationState for Mutex<T>"
> block in rust/migration/src/migratable.rs).  The AGENTS.md file will cause
> the agent to recommend it anyway.
> 
> Paolo



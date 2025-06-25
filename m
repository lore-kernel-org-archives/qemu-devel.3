Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73275C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUX3h-0002zE-5J; Wed, 25 Jun 2025 16:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUX3g-0002z6-4V
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUX3d-0005CU-NG
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750884564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgjEuRgTFxHaoS/NtDjx44kWrVq89i+T3Ffek1Q7VJM=;
 b=fcUJEicqX1kGrOdEsW8Kv0wSIhSb9ous3XkRLurOZekny7oswoOkBTu03iPvalREmwLlAy
 x4CqA4aMv1jA+jQZTwvK9ssXrOHFx4682//CTHz5ps/0EmEt8Yqq37Tfz4ZHOnpEfQKmPF
 UL6JiSbooDzN+aJl0ZpqQfBcIr098WQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-yrtR_2-HPcukPtchNP-G5A-1; Wed, 25 Jun 2025 16:49:22 -0400
X-MC-Unique: yrtR_2-HPcukPtchNP-G5A-1
X-Mimecast-MFC-AGG-ID: yrtR_2-HPcukPtchNP-G5A_1750884561
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so114415f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 13:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750884561; x=1751489361;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgjEuRgTFxHaoS/NtDjx44kWrVq89i+T3Ffek1Q7VJM=;
 b=tjGttvppep2Fcuw6uJsPdUiYWLXl7rlU9teiLTuq8EE25mVOLUwooD87SckgO9LcYP
 6+xhX/75XhPkyWU1RSJWZi/VvEpOdRq4obg594E0q51J6b0wAFNiNuJueY8sILW5y61m
 D9Lsy8lJkeALtzbU8GKZPL+AG8jQBet+b6dz6vewD7wpb/yTT4K8DBSuz2G1ekCHjdg5
 hLrAxJJYfrTmCuWas5U3yRF08cAtRhv07copNSCPMsqX7GhBNNc8gaC4xBrMdTaBJXZB
 kQHp3BgWc64hVljw5tOE/sMhII5GoxU4bAOXLJRVsjFcMj8c5fgPOLDgIBW6axTIBEMo
 sZdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYjoI09kSmkCY0tvqjmb21/7Xeq4m/qBsCI4xyXAnLCoJbvxtF4m78moOyP+fubLWUOWd5sDdH0cct@nongnu.org
X-Gm-Message-State: AOJu0YzMZ934DY62a0DmMR5s0ZJKSFL2BcVKxgU2PLjsCZ0mGgXkbBGa
 30sCEW3CmOl7x+YPaNnNxJX62cDXWkTUNr7lkFCG87jB4gKFmKOu3O7f4tiOjABImd5qpfrxSM4
 fR0OuNFq8UzX45Stnxzg5Q1pgSZXucRtiXkFiM4lHKRv0kjoUD8ahQWhB
X-Gm-Gg: ASbGncvNEJI8po99Lky1tVe97/GSL0FCW1kQRJWNHBNIJX2yYad1x2z+7XkolO60OWJ
 oGi36W/zSzKJ5F0bObQmuezrqd4VugGNwsxuCRbIA7Ka0PeEX9S+uI7eKgx5rKWCDavN3CY9W3S
 vfiUQMcL8mS1W+gYBE+nJ03c+U3qjS3euOgO5TQz5R3she0SjG3V6H/du093y6cc3Coq5i+wthR
 88nsYJWCyKxFdgKcx7Ds/P2uLQxUYkAJ2sLGMz5pSZXtspMzhKfUJJUp2dVoKHp5ZZsNP1aoV+s
 lZeS+MxuAnC8Zgph
X-Received: by 2002:a05:6000:1449:b0:3a4:dbac:2dc1 with SMTP id
 ffacd0b85a97d-3a6ed6506a3mr4214041f8f.54.1750884561287; 
 Wed, 25 Jun 2025 13:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmPuSc+MUPsdKgJn0ypcQ7fy5LNnoerPJFWY/XgwG/Nxhg0M//QwuCVdfYLgF95AbM2VxGWA==
X-Received: by 2002:a05:6000:1449:b0:3a4:dbac:2dc1 with SMTP id
 ffacd0b85a97d-3a6ed6506a3mr4214013f8f.54.1750884560818; 
 Wed, 25 Jun 2025 13:49:20 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811724bsm5344208f8f.100.2025.06.25.13.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 13:49:20 -0700 (PDT)
Date: Wed, 25 Jun 2025 16:49:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <20250625164902-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxePYi6bzLQ8UvN@redhat.com>
 <CAJSP0QXG_QD+ZWsRgpxSNyXYBooMkfX+gSOOFE8XWghv1E-htw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXG_QD+ZWsRgpxSNyXYBooMkfX+gSOOFE8XWghv1E-htw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 25, 2025 at 04:47:06PM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 25, 2025 at 4:39 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 25.06.2025 um 21:16 hat Michael S. Tsirkin geschrieben:
> > > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > >
> > > > There has been an explosion of interest in so called AI code
> > > > generators. Thus far though, this is has not been matched by a broadly
> > > > accepted legal interpretation of the licensing implications for code
> > > > generator outputs. While the vendors may claim there is no problem and
> > > > a free choice of license is possible, they have an inherent conflict
> > > > of interest in promoting this interpretation. More broadly there is,
> > > > as yet, no broad consensus on the licensing implications of code
> > > > generators trained on inputs under a wide variety of licenses
> > > >
> > > > The DCO requires contributors to assert they have the right to
> > > > contribute under the designated project license. Given the lack of
> > > > consensus on the licensing of AI code generator output, it is not
> > > > considered credible to assert compliance with the DCO clause (b) or (c)
> > > > where a patch includes such generated code.
> > > >
> > > > This patch thus defines a policy that the QEMU project will currently
> > > > not accept contributions where use of AI code generators is either
> > > > known, or suspected.
> > > >
> > > > These are early days of AI-assisted software development. The legal
> > > > questions will be resolved eventually. The tools will mature, and we
> > > > can expect some to become safely usable in free software projects.
> > > > The policy we set now must be for today, and be open to revision. It's
> > > > best to start strict and safe, then relax.
> > > >
> > > > Meanwhile requests for exceptions can also be considered on a case by
> > > > case basis.
> > > >
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > >
> > > Sorry about only reacting now, was AFK.
> > >
> > > So one usecase that to me seems entirely valid, is refactoring.
> > >
> > > For example, change a function prototype, or a structure,
> > > and have an LLM update all callers.
> > >
> > > The only part of the patch that is expressive is the
> > > actual change, the rest is a technicality and has IMHO nothing to do with
> > > copyright. LLMs can just do it with no hassle.
> > >
> > >
> > > Can we soften this to only apply to expressive code?
> > >
> > > I feel a lot of cleanups would be enabled by this.
> >
> > Hasn't refactoring been a (deterministically) solved problem long before
> > LLMs became capable to do the same with a good enough probability?
> 
> It's easier to describe a desired refactoring to an LLM in natural
> language than to figure out the regexes, semantic patches, etc needed
> for traditional refactoring tools.
> 
> Also, LLMs can perform higher level refactorings that might not be
> supported by traditional tools. Things like "split this interface into
> callbacks that take a Foo * argument and implement the callbacks for
> both a.c and b.c".
> 
> I think what Daniel mentioned is a good guide: if it's something that
> you think it copyrightable, then avoid it.
> 
> Stefan

Right. Let's put that in the doc?

-- 
MST



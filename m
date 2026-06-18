Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4F3CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFmJ-0003GF-Sc; Thu, 18 Jun 2026 12:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waFmI-0003Eg-Bg
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waFmG-0000Ke-DD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781800778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HU149pILsYFHp+w/r1Omz+v+aCGxUy6qZnDW1qXOmw=;
 b=djhPLL1BB2cT3qDEg3R9Mlgz+bYPr5IMLTXKiD2SR3NdUA+phQ7mvmt0frNW8xIvJ+KNSY
 59EbDJ/1xacywdLRyvCbZeLrBYU11P6axgG+wha+/bRaJDqKY1exJhWXQT2BlCFj1KPkAs
 0pk1IEh3krQGG69l12yI+9eyctmB6Jc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-r_uiq78-Oce6I5G87EZd6g-1; Thu, 18 Jun 2026 12:39:36 -0400
X-MC-Unique: r_uiq78-Oce6I5G87EZd6g-1
X-Mimecast-MFC-AGG-ID: r_uiq78-Oce6I5G87EZd6g_1781800776
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so8207845e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781800775; x=1782405575; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0HU149pILsYFHp+w/r1Omz+v+aCGxUy6qZnDW1qXOmw=;
 b=KCph7IFPrJROf39EhvxUAZFk9YmF210JA/yt9KPMA1LObQeP1iYoc6hRJlH2JSdryX
 ekK/lGsKqSvLz1yoj21Tb9iKXuo7H8pZ3yS0bmacuNfnZS+ja2bJEw8StV6h+KZubmLh
 pPmbeEFXmrZ1hueGaQWzWAlRtq7wk3B6ng/aAk00X5Dh013LzT/49RoSi07q2WUMoPi0
 whb8AMKN+TCNT1pgnbnD1Ou6gq7uXhLkI7t1SO9vn8zr6Li0fnpiIFFsrjQeiWVkXZVi
 BRf5TnX8o1ViDi5GiSQpja86LPvRFr7YEXLXzT5lN26L9dEwW5ftFedwuD0XcDAv2nkS
 bIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800775; x=1782405575;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0HU149pILsYFHp+w/r1Omz+v+aCGxUy6qZnDW1qXOmw=;
 b=NNqiVsLsawI/MdafFFr4UQilirnRinvbvy66RlO2QZou6O5OMnDg2OiCp/sknWxtkl
 M7VqYxgKWZ8oXxRqc2PHQ0rOTRtUsJf2vPxcFXINmzFwNcTqd3RRFOWaKRj5jGkR/lvG
 oSuAzpSgR/YPuoyOhxs4Ew4MVOy5Wd+PlKvXc3j8/aIaM36iGIj+iHVAUOWNMppZotMp
 78wRMV1Gz0qNZ20/Akl5ArDDJv+TbpSRrxr9PdnumBBehgvqT2n768e2GoXoVtvnCNq3
 fbDqH4Rjl1PNKlQmau1yuHJf5+C3r8+Nxu4FS9KBSgr6CklFl+cOV5Ie8pxMPS6FBliC
 d/dw==
X-Gm-Message-State: AOJu0Yy6JMk56jPQ0pNCmIg7GKPqLnmFIo0jNo7ztRI2AD5NZ/jkBB41
 viipPTZlcrqkgIBaaunTGVRb0yCx7gHkUrDwQ15WNu+EJZmA6Vf6bbIsS34DWo8UmtYeg1MdUAS
 xMppDDASclL5jFLe4nXXGwc8U3IjuLC7BjFYYVY66i/i2qgVPMCMnBuqF
X-Gm-Gg: AfdE7cmlWqTyHo5GRkxuJpGpZ4kQ2oH/m/0h1cZdE8U8GQZsoZ3BeIgs4x+UONu4XrI
 +Lp7R8GsbwTKQoEjwwx8Lx7WB7Io5xJ2bNT3VXpHHQ+nXzFq6cItHWdI1W8C6wuLqBvO1BC+pca
 sp5FyqSizBUCBFI99sV4yx8lJ2mols/0AdjZlBre+wiAwuOb8er4sE5NPUEtnODpMqXHGhJoK7+
 Qt3kLXXqaxIk/DpXTZyaEcjQfZQ/g6tndtLbjqgVhV+s5VccU0tFUrp4XRO89JkrHN0pCH8RdTC
 WNs65hhlRiHfYJWvLoQlx5Y2iTrSJY0wGBnBWqiSa7JZWxIzrK+ZCVZ7+WXLcdLHNZBxd996s7i
 nlgLXZktJgWpyrFsqy9yClVpQ/17WGB1n
X-Received: by 2002:a05:600c:8b24:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4923f439be6mr5772605e9.14.1781800775382; 
 Thu, 18 Jun 2026 09:39:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b24:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4923f439be6mr5772065e9.14.1781800774865; 
 Thu, 18 Jun 2026 09:39:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b76e7c9sm73355f8f.21.2026.06.18.09.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:39:34 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:39:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618123451-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
 <ajQXrpKNx4NnhUKa@redhat.com>
 <20260618121520-mutt-send-email-mst@kernel.org>
 <ajQd8nRuYau2xVcY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQd8nRuYau2xVcY@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jun 18, 2026 at 05:33:54PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 18, 2026 at 12:23:46PM -0400, Michael S. Tsirkin wrote:
> > thanks! sorry probably just me being dense but some things
> > here I don't get. might be worth clarifying:
> > 
> > On Thu, Jun 18, 2026 at 05:07:10PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > > > > + * The maintainer(s) will develop and/or review patch(es)
> > > > > +   for the issue privately, optionally attaching work in
> > > > > +   progress fixes to the GitLab issues.
> > > > 
> > > > attaching how? how do i ask reported to test the fix?
> > > > was easy in the email flow.
> > > 
> > > You can add arbitrary attachments in gitlab issue comments.
> > > 
> > > > > All patches must
> > > > > +   include the issue URL in the commit message(s).
> > > > 
> > > > you mean the commit message of the patches I presume?
> > > > there's no commit at that point.
> > > 
> > > Well I presume the maintainer will have a local git tree
> > > with a work-in-progress commit.
> > 
> > sorry I don't get it.
> > 
> > what does it have to do with patches then?
> > 
> > 
> > who cares about my local tree?
> 
> If you fix a gitlab issue, the commit must contain the issue URL.
> That's normal practice we've followed forever and would now apply
> to security fixes too.

Ah. You want a Fixes: tag maybe? Let's say so pls then.

> > 
> > and why is this mentioned twice?
> 
> Mentioning twice is a mistake
> 
> 
> > > > > The
> > > > > +   **"Workflow::In Progress"** label should be assigned when
> > > > > +   a maintainer starts working on a fix.
> > > > 
> > > > That's a bit heavy, and what is "working" anyway.
> > > > It's an issue tracker not a planning app.
> > > > Don't try to make it one.
> > > 
> > > Various "Workflow::" labels are already present in our gitlab
> > > instance. We don't use them consistently - this text is just
> > > a pointer that the're there.
> > > 
> > 
> > maybe "can be assigned" then?
> 
> Ok.
> 
> > 
> > > 
> > > > 
> > > > 
> > > > > + * When a CVE is allocated, it must be recorded as a comment on
> > > > > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > > > > +   the **"CVE::Assigned"** label.
> > > > 
> > > > Recorded as a comment how exactly, in what format?
> > > 
> > > In plain text.
> > 
> > yes but in what format?
> 
> Literally just  "CVE-2026-1234" anywhere in the commit message as we've
> been donig for years.

I suspect what we've been doing for years no longer scales or
we'd keep doing what we've been doing?


We desperately need something that is consumable by tooling,
and I just do not see how is a tool going to figure out
"this seems to be unrelated CVE-123" is irrelevant.

Unless we'll feed it to some LLM and hope it's right.

> 
> > > > > + * The maintainer(s) will update the commit message(s)
> > > > 
> > > > what does it mean to "update the commit message"?
> > > 
> > > The commit message for the patch the maintainer has in their
> > > tree.
> > 
> > then you mean "before sending a pull request"?
> 
> Sure if you want it to be that specific.
> 
> > > > > to include
> > > > > +   the assigned CVE and issue URL. If multiple commits are required
> > > > > +   to fix an issue the CVE must be included in the final commit in
> > > > > +   the series, and may optionally be included in all prior commits.
> > > > 
> > > > And here, included in what format?
> > > 
> > > The CVE just needs to exist somewhere/anywhere in the commit message.
> > > It is common to put it in the first line, or with tags before SoB
> > > but it doesn't really matter as long as we have a record of it in
> > > the patch.
> > 
> > Will be really annoying if any tools try to consume this e.g.
> > to decide what to backport.
> > I suggest deciding on something for these free text fields,
> > how important is it to be able to write ❤️❤️❤️CVE-1234💰🔥🎯 really?
> 
> I don't think we need to document every single little detail
> here, just carry on with what we've already been doing for
> commits.
>
> With regards,
> Daniel

If commits are linked to CVEs through issues that's fine. Need to
make that link robust then.

> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



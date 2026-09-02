Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B8C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lSB-00063n-BS; Wed, 02 Sep 2026 09:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1lS8-00063Y-Nb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1lS6-00040j-M2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788357393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRWUPAPZbVaHhho/GvgWVyHk2suwqHWxjlRezP8knf0=;
 b=KKAbRLrQhPK9cP005ft52oQgYsjF/bLu14LNTcu62Ie6XmQNE6oivnzL1uHdFyAaAoVqBH
 TwnDMrJoF6XQq0imYxchb5wA+v8HEfTWbo0uH8Qi3bvyPvsWDLA+dD5LaM/olHj9GDdhTk
 tponiELBzyJ4wzWJLERAozhtVixJdKU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-gI1WoP0qPvys_C4kG21yZw-1; Wed, 02 Sep 2026 09:56:31 -0400
X-MC-Unique: gI1WoP0qPvys_C4kG21yZw-1
X-Mimecast-MFC-AGG-ID: gI1WoP0qPvys_C4kG21yZw_1788357390
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso840481f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788357390; x=1788962190; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dRWUPAPZbVaHhho/GvgWVyHk2suwqHWxjlRezP8knf0=;
 b=m50pa9o8jIA6s2lDCEMet7XUxiChbJlQcD05n5+qPL7x9zCKVQvd4fmpQHkb5mCy/s
 0pQ356nL9+5kxvSMeQ7U4wq+cWi4iWN+aduXAvr5ah+qw6G4fYoJGlN5UlKiy957e5+8
 IbObYr5kYuTjAKWSRj5r/hTyKLiNgngYZo851QCDHxZL1OR/syeRUSazbpqhM0BVGOGJ
 RkGA7Rsbye7KJNJBuIjPsr2WzUqNrNLZ5HbXC3CynDlYH5HdRdzXekV20ZUA9fpu7L/4
 U3daCisyM6XunmKUvruZl4Qs1LH+A9IOjaVNG21H2ZSNzspyyDHKvIG56rsB94jXiYmt
 /lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788357390; x=1788962190;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dRWUPAPZbVaHhho/GvgWVyHk2suwqHWxjlRezP8knf0=;
 b=Y0GfbzRJz4iZHQ/p6ammadzMC/KcdysJ7bs0M8bFXyXC2pHlHmHuK4Vgh9SlrodjT0
 OrCt+VKT4fvd4bL8e5pSRIi5HxcJg0Zlr5PLqWslOhf2hfaXxrWehYGT5M5jm3WcCT+9
 BqRIZoyfOPbwrgs5k6NBs8D2h5i8+p3v7v/yMIFYUGzzMQNjvJ7xVjWVLFSmJfUssNNM
 LALSD/iXUykHPNjHL/JwKQbGIlVJqO3Lv1tDuPCqefMLFmeEdKT+g5WDNI3gg85xHtCR
 b1fxR01jHUWHxm/3HGqz/DewB8RriASwqzJTvvd5y2fZO5EwuX74Jw1KGKexQhaD5O01
 w4/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJp/LqANVT4seVty2y3YjbF5WUrvcQtrA5WskRzE8MpQmLMsWdExUNHMVIUD0DLAJ4CEh9rEha50FK@nongnu.org
X-Gm-Message-State: AFuF++nQvPtRSheIBRCE5w64k4GcPpaZh2A4IvqL7pWrQcZfkmOTCVHZ
 95ipRDPWOHOC5l31KHX31zR/9V6n73nVddsj4ymuaVCduAIL00scZ83ALROyWrZs3+1XeID3roR
 2vaEFYh4Vu/CbH0apKCuiZKwXNGjVRXISQgrZV7YpuvVDUj2Fw1d4WM2B
X-Gm-Gg: AR+sD13SAc2x/Qb4uhHQUUCnXDuA6QTc4csW/oacwkx+hhbCEzRS/hWRb7Zx0Zc8rOP
 NZVO761ASHOUX9NCJMYDPMivVANWgvDQJlY9ar5zSTexrT4u+A2aMxkZ62nKtGb7XbHGY73JB1p
 cc8IDvepa12qdcDNAGZS6fh6vzuowx+ijDZaSIhTDVdE4H0assMflGQApf5TBPcr+YAyErDHOtQ
 DZj6CoimN4f156S9tkypxeGK6scapSwYF+a55tS0jJLDKBXlJFDkLeZyFjxeAMcvXB3+Zt5n10Z
 UIyWj0c8voFONtaDK1aIe59jmU7/XA9/V3w7F/nv5g6ea0ZPJ6aEDYtOHwPhB1L69Tc=
X-Received: by 2002:a05:600c:8411:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49ce58204a0mr86964645e9.8.1788357390414; 
 Wed, 02 Sep 2026 06:56:30 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49ce58204a0mr86963285e9.8.1788357389913; 
 Wed, 02 Sep 2026 06:56:29 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5952560sm47183015e9.3.2026.09.02.06.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:56:28 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:56:25 -0400
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
Message-ID: <20260902095523-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
 <87a4pzrcqw.fsf@draig.linaro.org> <apgpDaBqCaVPqmLH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apgpDaBqCaVPqmLH@redhat.com>
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

On Wed, Sep 02, 2026 at 02:47:57PM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 02, 2026 at 02:42:15PM +0100, Alex Bennée wrote:
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> > 
> > > Humans seem to be extremely unreliable in following rules around this,
> > > even after being told directly and repeatedly. Telling agents what to
> > > do seems to yield better results.
> > >
> > > This document is based on GStreamer's AGENTS.md file, as of its commit
> > > d08375499c279a56c0e77c928fbeae0d80cdf937.  However, GStreamer's agent
> > > instructions are "effective" enough to require an explicit carve-out
> > > for maintainers.  I actually believe that such a carve-out is a sign of
> > > going too far, especially given the good quality of some suspected-AI
> > > contributions we've received.
> > >
> > <snip>
> > > diff --git a/AGENTS.md b/AGENTS.md
> > > new file mode 100644
> > > index 00000000000..8fb96ebfc38
> > > --- /dev/null
> > > +++ b/AGENTS.md
> > > @@ -0,0 +1,100 @@
> > > +# Agent Guidelines for the QEMU Project
> > > +
> > > +QEMU is a cross-platform emulator and virtualizer. Due to the complexity
> > > +of the domain and codebase, and the interactions therein, the QEMU
> > > +project relies extensively on the effort of **human reviewers**, which
> > > +is **a scarce resource**.
> > > +
> > > +There are strictly-enforced rules for you, the agent, to participate in the
> > > +project.
> > > +
> > > +## Interactions with maintainers must be human-human
> > > +
> > > +The QEMU project has strict rules on what AI-generated material can
> > > +reach the maintainers.
> > > +
> > > +### No automated posting
> > > +
> > > +- Agents **must not** use any API, CLI, or web UI automation to:
> > > +  - Interact with the QEMU mailing lists
> > > +  - Create, edit, or close **issues ("work items")**
> > 
> > The others I'm fine with but I currently use an agent to do triage on
> > un-tagged issues. It only updates labels and occasionally posts a
> > comment when more information or a human input is required.
> 
> While this is technically something you're doing via your personal
> gitlab account, I none the less view the agent triage bot as something
> run as an "official" project service.
> 
> IMHO the AGENTS.md policy primarily applies to actions done in an
> individual capacity (whether contributor or maintainer).
> 
> If the project wants to deploy project level services that utilize
> AI in some manner and that conflicts with AGENTS.md that's acceptable,
> provided we discuss & agree that the project service in question is
> desirable.
> 
> Perhaps this is me saying that the issue triage bot should be made
> more official as a service, committed to git, etc
> 
> With regards,
> Daniel


well I have a script that uses gitlab API to run the security process
workflow. But it's... how do I put it... AI assisted ;)

> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



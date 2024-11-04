Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CED3D1BDC0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zdT-0001ga-QI; Mon, 04 Nov 2024 11:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7zdR-0001gC-Oc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7zdP-0008A2-OQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730736534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGVZ2RJXldVjzPJj+hynLUdjDm4VmwDf6Jmje2pHs/A=;
 b=ZesJ71ivDJGI5hL/gMIYR3nbJ+cBoEmnjU+BVKFWHlFlOolAadUoGm8a3/pAzSVra2K6p4
 48Lk9ajP9pLqISDv9uxFKQe6GEI7ntVOfKUCssxqkuJmAutWBsMhCCblSQ3C4dzyT68HUG
 +3Bk522mdhO/m5R7BH+JqB9YduCUpB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-i7MESmEkO0eD_cn1IadLGQ-1; Mon, 04 Nov 2024 11:08:51 -0500
X-MC-Unique: i7MESmEkO0eD_cn1IadLGQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so31372545e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736529; x=1731341329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGVZ2RJXldVjzPJj+hynLUdjDm4VmwDf6Jmje2pHs/A=;
 b=H5aI1fq1/J+mIOdgbCGNYQK2XFcBOGO04oKrKExgUJEXyQk2MZbGvbQZIU0zBhAcIq
 wwry1UqseuYz/iI4ylt4o17UxLzCfke0qHY1bsVif9a+e1cDSnT/VBxLGtX8m71IN3D/
 6yOr0qwPP8CnY5A2a8wZxzE5QC9cLO/qwgbbfv+8yqP0LYyC4hTxIw0Huq/7H5TVRtdx
 mg42dydrCdleDicsLGmDL28ZKndu6xSGzDOQWP8T08W/19MUQwVda3Q+gHthZIUXZf62
 e1ig3iTXxwVu2UcAocex2C/mq4QmfmHCW9PO0hJTmx2XjXrpSU37mTnBoVjDA3+nvb4A
 njvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQ+PnPJr5jscwWUGSEp3W42p1ceD7cMGG7sR+2Um5neQ96lbCj3RBwNBV1lI+luUPuOOUN1jGPs5e@nongnu.org
X-Gm-Message-State: AOJu0YxCAuUbH4CQ2NOLVN4dsOTLx4F+++Tm9tG4P33Z6pwpms+goeIc
 J+HJwCsMcX/cmRT1LkfUkvcQ1GsyvxhI8S5Td+EeJrxijiJHaZx6jOikGUvivIqgINPkIGgv2Zb
 zwWAPPTgkkZSxneolVRZThSMr/C/4YB4idEjxHNhKIbEL31EtK2ym
X-Received: by 2002:a05:600c:198d:b0:431:5d89:646e with SMTP id
 5b1f17b1804b1-4327b8011cdmr133208995e9.32.1730736529523; 
 Mon, 04 Nov 2024 08:08:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4zffVRzsycKVnFt6vQyLa6CnL/f9a4lcr/zsX5swHwU8yxhzGXHXQFM1MIa5z4TFDDcIOcw==
X-Received: by 2002:a05:600c:198d:b0:431:5d89:646e with SMTP id
 5b1f17b1804b1-4327b8011cdmr133208665e9.32.1730736529129; 
 Mon, 04 Nov 2024 08:08:49 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113de0esm13590171f8f.85.2024.11.04.08.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:08:48 -0800 (PST)
Date: Mon, 4 Nov 2024 11:08:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
Message-ID: <20241104110814-mutt-send-email-mst@kernel.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
 <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 03:58:19PM +0000, Peter Maydell wrote:
> On Thu, 31 Oct 2024 at 04:07, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > MacOS and Linux are straightforward, but Windows needs a bit more
> > details.
> >
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> We have documentation on the wiki currently about how to
> build on various platforms:
> 
> https://wiki.qemu.org/Hosts/Linux
> https://wiki.qemu.org/Hosts/Mac
> https://wiki.qemu.org/Hosts/W32
> 
> I agree that we ought to move this into the main documentation.
> Some of the information in those wiki pages is probably
> out of date, but some of it looks like useful extra detail
> that we could incorporate here.

Also, as that wiki notes:

32 bit Linux target on a 64 bit Linux host would be useful for build bots



> > ---
> >  docs/about/build-platforms.rst |   4 +-
> >  docs/devel/build-system.rst    | 100 +++++++++++++++++++++++++++++++++
> 
> I don't think this is the best place to put this information.
> "How do I build from source?" is a question that most beginning
> developers and some end users will have. The information in
> build-system.rst is mostly about the internals of our
> build system and how to modify it, which is a more niche topic.
> 
> I would be inclined to put this in a new file, maybe even
> in docs/about/ rather than docs/devel.
> 
> thanks
> -- PMM



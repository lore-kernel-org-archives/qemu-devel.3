Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BD0C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 16:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAruD-0006kD-4M; Sun, 27 Sep 2026 12:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAruB-0006jq-GR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAru9-0007bf-Hg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790527147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iLxQoMtx0EVHCoyto8bvHYgvSVAevk14lVzFhS08lsc=;
 b=CFfsx+CLQQTuSbxBp/r6x70dA77gfVVVsDEHXKobMC2HjDrlKLxYz3VQPP/+UHm+abmI44
 mqKFd6cCG8HZF2t4WlCQj8u3hovjWkTzXDiCbD2PiMuQJ5VNbJI+uYTI1Vp3dav/pWA8Bu
 zN1I7ctPuLYyyUFVGEj7DOM7vE798NA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-af9h-_fkNCmVPCYpjE2jcQ-1; Sun, 27 Sep 2026 12:39:05 -0400
X-MC-Unique: af9h-_fkNCmVPCYpjE2jcQ-1
X-Mimecast-MFC-AGG-ID: af9h-_fkNCmVPCYpjE2jcQ_1790527145
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49fffa5de0fso10393865e9.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790527145; x=1791131945; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iLxQoMtx0EVHCoyto8bvHYgvSVAevk14lVzFhS08lsc=;
 b=P/NoTvnPjEHleJoIO7OGZo3DdOIyBtr0kkPXKA0EYBNLDEXrrErDZw9MbC42vX/NWI
 6yP7sKoeUy7cvEpEwcoGHQrD9jGqXtHeOVLP3FZtL94UmSuljPtwZVEbHEg3YHWDx/Oz
 tAogogFvlhT3oudzoSsPua3Zan446JQh3iJKWhtxTqWLc9hHTz0h70g9WyxmiCWP5U8t
 tCHJM9VFhvanm8xNlGglnXZhlK8+k/rSWVmlWWwqRO3UQhG+zXGurDTWuLil4TnDmKua
 dWmFTu3x+mUeg8DzgYGfY+ilJfU1wEOiQkpysSE+l1G974z+KIMri8L7pkfty1uF+hVw
 xLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527145; x=1791131945;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iLxQoMtx0EVHCoyto8bvHYgvSVAevk14lVzFhS08lsc=;
 b=GTkEvFsHbEeeFqGE0sFd6kzYF1/iekEoGRnYRrrjnVDISHFQqx5b2PVXLbQDchp9G+
 mLp3qYenepg6UWUBgeLO7ggz21T3MZaawDIlLuX3Jdm9E9dNkj3xLqQKmV6ihAmC8CPC
 kXFrochRYcD3RsPvIfzFpe4Uv0zORVgoDuelynek1uS1NpBtQLZSAYsbr+pEOXOVah1A
 VtaKJms8uDfphMhKL+UeCMFgeLhtCQCPYKFmCHr5QPcoafd9QSUWLcmNYYEbTlts8Ec1
 qoYj/KjBvarTCfNnF8s+CGiCGwefs/sGlj7um5SRDq5VD04gsdR0OSgQrCbMnNeVLun3
 WpIA==
X-Gm-Message-State: AFuF++mm/5qeeukNI3HehySfGin3/DiNSvPMnJeJAc5Yo2g+L0z72IBG
 oGj9LzN21zo3hd4fxs1P7tMw1xe684fX9GjBPBIlGfeHZD8yD+ZmzvU1hbNR5gpBYaFSpA51pbd
 g65v0EkqOtAieQng7d05SklBP5TwEaWbcJcecqES9qVgXIYH3iqhDdA7a
X-Gm-Gg: AYBFou2dlhl8AZALZBZ+zjUzP7F4YWcm42ys+Ks3JFpdbn3EuAuMAkel6WewJeXrK+/
 M62V0y4Esl8HTzYDheJgIgHw8u1UtA7ufIY4zaFQHDTIaCYyIzEvBnMEJy/qFsLNxG3/nRCz7zv
 yB4InyyjvrSpyc6IztbVBj0ich0GD64nIDxSVam9oZ+I0yPbz0BWkHXMZ6NEh32vUI7+nm5z55X
 2UseH2dnCyljNqbo8yPG1BJ9MXPqW3ua22m7lWefkbXXEiRDGVh69n68hlrwWDUdpR/8ZPYmjCq
 Qr1uD6HmsIhX27c3DKa600f1HxFIDOf7ShR91iw0eXFD3//viADzhEZq2fmjsxV9pDJ+NeZcX0m
 VH9jExd3JbVYLWaYiRDolIxdVxYFcF5WM5LWzQO2B1ZXvDhpqM9AceZvM77UZBLsFfw==
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49fe6707bb7mr210766465e9.30.1790527144627; 
 Sun, 27 Sep 2026 09:39:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-49fe6707bb7mr210766075e9.30.1790527144193; 
 Sun, 27 Sep 2026 09:39:04 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00571744csm4365255e9.13.2026.09.27.09.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 09:39:03 -0700 (PDT)
Date: Sun, 27 Sep 2026 12:39:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v3 0/4] docs/devel, AGENTS.md: a completely new
 policy on AI-generated contributions
Message-ID: <20260927123441-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075251.12831-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 21, 2026 at 09:52:47AM +0200, Paolo Bonzini wrote:
> WARNING: this is *intentionally* a full U-turn from the previous policy
> and discussions.  This is not a refusal of the arguments presented in
> those discussions.  Also, it is still a request for comments.
> 
> I've explained in v2 my reason to "try something else".  On one hand
> attempting to introduce small carve-outs did not work due the impossibility
> of reaching a widespread consensus on this topic.  On the other hand,
> some contributors have been posting AI-generated patches or even larger
> series, most likely in good faith as they predated the introduction
> of an AGENTS.md file.  This shows that AI can be used for useful work
> on QEMU, ranging from small incremental improvements to new device models.
> 
> This is not a free-for-all, which is not a good idea either.  Maintainers
> will want to apply their own considerations (see [1] for a good list),
> and contributors should take into account the maintainers' preferences.
> 
> This is an attempt at building a process for contributions that use AI,
> heeding Conservancy's advice to not shun contributors or maintainers
> belonging to either camp, and keeping in mind that maintainer burnout
> is the one thing we have to avoid.  Some of these processes already
> existed, but the possibility of AI contribution makes it all more
> important to write them down for everyone.
> 
> There was not much discussion in the previous version.  I tried to rein
> in some of the language that allowed too wide interpretations, to apply
> the changes that were suggested, and to clarify those choices that drew
> more remarks.
> 
> As usual, the text including the commit messages is informed by discussion
> with plenty of people, mentioned in the Cc trailers of patch 1.
> 
> Paolo



Something that we maybe should do, is to ask that
agent does not repeat, verbatim, code from outside
of qemu.

would not help in 100% of cases but hey.


> v2->v3:
> - remove parser example, replace with "adaptations of existing code"
> - when LLMs are used for boilerplate, "highly recommend" disclosure
>   for "non-trivial, functional code".  The idea here is to avoid
>   having to disclose using AI to apply e.g. changes related to
>   automatic code review, and leaving people some leeway.
> - clarify split between DCO (legal right to submit code in general)
>   and AI-used-for acknowledging that the submitter cannot audit LLM
>   output against e.g. the training data.
> - clarify the defense-in-depth/swiss-cheese approach to limit the
>   risk of copyright violations from LLM output
> - mention that pre-arrangement is not an entirely new concept
> - mention that maintainers can demand larger changes than for human-written code
> - do not mention inclusion of the prompt
> - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> - rebase AGENTS.md on top of existing file, split
> - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
> 
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/
> 
> Paolo Bonzini (4):
>   docs/devel: relax policy on AI-generated contributions
>   AGENTS.md: add final instructions
>   AGENTS.md: let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
> 
>  docs/devel/code-provenance.rst |  71 +-----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 202 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      | 137 +++++++++++++++++++---
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 336 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst
> 
> -- 
> 2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AF4CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw8b-0002VR-IZ; Tue, 26 May 2026 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRw8R-0002VC-2T
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRw8O-0001di-6Y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErvKNckfGI9jf9zfwhwevSdQ6RXXH8OgfaSKTfVdB1U=;
 b=aNYkGDL7YMbeC1l0kTYOl9E776YE9zesIn3WecSk+b7lykw/1XFsoIeFj4emRWqeeG4iQ+
 JhHx2Gu7ZcNAo0799i3e2iFciRNA4s2rbjrMaxIEr/rn0oMcyian5T8sxNleJYLrGSunH1
 XbZ3xVCKkamAk36l1O4WSSuRB13EVSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-cd5lqDgoMBK7I8DuFf72Vg-1; Tue, 26 May 2026 14:04:04 -0400
X-MC-Unique: cd5lqDgoMBK7I8DuFf72Vg-1
X-Mimecast-MFC-AGG-ID: cd5lqDgoMBK7I8DuFf72Vg_1779818643
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49045f93baeso32179045e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818643; x=1780423443; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ErvKNckfGI9jf9zfwhwevSdQ6RXXH8OgfaSKTfVdB1U=;
 b=aoK78Ht+LuhJw42HMKsx3C8+wjnwQnjcMvrDhvDfE0PdXrkZKWrOdYOHxRsGzCyoVo
 iscnBWCglr6daWV1TfJEQPqKjBSlM31jxva6h52NplHO/riaIncXW/V2syCUV5Vr9bft
 kK67G3qEbjHjKDQWyNVfVb+1BKXCP5nIQnZoUi43j67s6QMro2+rrqnkWq5C+ZNABZo/
 36R8rFEU5yyRSuTpCL6+W7s3CqJMkpPVAArvej5RcaEUD+HUieFlfF1AC0xt71MKywuD
 P5qcNaqKBeyBmDOUtM2OdEh0fzi7Om/ncuuy3yyFyPudhHcc4ilrBvdfNdDcQdDKzW5D
 XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818643; x=1780423443;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErvKNckfGI9jf9zfwhwevSdQ6RXXH8OgfaSKTfVdB1U=;
 b=NUBkKp5ReWlRXYdGnMSvs/uJxW8Fu/NtlVfUVJKqxYSDeZBRvZEyqAWAWZm6cSMEzy
 XjTOXNAWEH4AgxKSSThTLt+S1rGp1hjSWmZ8zyAziEESW6CZ9MHc+BtBv3sOR6haS2LK
 qnAXxhXdjEU7SpjOQ5o1qLy9aKcaej1Tr0SshH6YbekbjNvzYC57941RNPCj26ubvPr+
 ACz2aCTSys7LeC32XLSmuklSvHP0v5hDUvMbJW3h4BlzTmlksevskNQBQ4w9ucHE80jQ
 9s/BAcTyM+rLDXa5vp6Hkq9YPZ8TMi0D8Dw8tm2k4Gv9ih09AbLT3L8ok9y15HAYN/6d
 GjNQ==
X-Gm-Message-State: AOJu0YxYMVdF+gRuZrSuEPIc09VTXOdzBSV0gegZmb4JOnB4gSzZQpuQ
 phma+gDPKNDSaJK/GK3ZDRVo3HVwM4NRUdf0FLlBaod1OSYcLI46hCeH8bvt2wTreZg8Q6wXHFq
 ilsKQsJGXdzz1JkO2wEeRzPMmoI0nfiPMgH0ZRnKHWYGb6Z2qsBma1CNOOMWoVSOj
X-Gm-Gg: Acq92OGm9S71LwPHF8VkNlJZBAVoHrDJ/3hgSJp5a0WRIoijgZWVboW/8kIyRlkCPFg
 ZoDel3XDUQnpoga4X6KalZBdfk6APIFen4h8Ho5tggfJVGzjkLeX9hXCpxpZTYSjIA2/weXcXCi
 5aw3gUYV6i6PjBOKwmxlwQYBwlhugPwatHH+rAxdODEjkc1iSINmZoVYcSHzhzjNPqm8N79dXar
 Q9wZw6pP4Y4dSfRI9S/kQzg78axtjIlQKeivX6nIUqM7r0yy2ESzWXdmqc1CnyFyeySW73CUYEZ
 fQKMQhs/Ej0vDO6LZ7NWxpNyGQXnWvYP6+q39393rjaE4c646ZB5HYhIaHIr4q5XT9Db3OCKuG3
 5oBLfpSnp5xZTAYyWK+obnJsffFShXJ58+BrAsiVc8+Q=
X-Received: by 2002:a05:600c:5548:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-490424b0854mr209214215e9.9.1779818643176; 
 Tue, 26 May 2026 11:04:03 -0700 (PDT)
X-Received: by 2002:a05:600c:5548:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-490424b0854mr209213595e9.9.1779818642538; 
 Tue, 26 May 2026 11:04:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm347966975e9.0.2026.05.26.11.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:04:01 -0700 (PDT)
Date: Tue, 26 May 2026 14:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260526140231-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahXbxzB4C_lr6b0N@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 07:43:35PM +0200, Kevin Wolf wrote:
> Am 24.05.2026 um 14:42 hat Michael S. Tsirkin geschrieben:
> > So, I had to reject a perfectly reasonable patch:
> > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
> > just because of a tool used to make it.
> > 
> > 
> > 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> > 	content generators commonly available today is unclear.  The QEMU project is
> > 	not willing or able to accept the legal risks of non-compliance.
> > 
> > 
> > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> > published this piece:
> > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> > 
> > 
> > Saying, in particular "
> > 	We understand this concern, but the DCO has never
> > 	been interpreted to require that every line of a contribution must be
> > 	the personal creative expression of the contributor or another human
> > 	developer. 
> > "
> 
> I never found that blog post particularly convincing, especially because
> they acknowledge a concern:
> 
>     There are two versions of this concern. The first is practical: that
>     an AI tool could covertly insert excerpts of proprietary (or
>     license-incompatible) code into an open source project, potentially
>     creating legal risk for maintainers and users. The second is broader
>     and more philosophical: that large language models, trained on vast
>     amounts of open source software, are essentially misappropriating
>     the community’s work, producing outputs stripped of the obligations
>     that open source licenses require.
> 
>     We think these concerns deserve to be taken seriously.
> 
> The second one is essentially what I understood the QEMU policy to be
> about. Unfortunately, the blog post then goes on to only ever deal with
> the first one and ignore the second one that seems more relevant for us.
> 
> So yes, the DCO isn't about "personal creative expression" or whatever
> (and nobody suggested it is, this is a strawman), but it's about whether
> the submitter has the legal rights to submit the code. And that's
> exactly the question we decided we don't want to take a risk on.
> 
> 
> So if that part isn't helpful, what has changed since we introduced the
> AI policy? It's a few points:
> 
> 1. While AI has been in use for a while now, we haven't seen projects
>    accepting AI generated code/content get into big trouble. While it
>    could still happen in the future, it might be an indication that the
>    probability of the risk hitting us is not that high.
> 
> 2. The useful part of the blog post is that it tells us that Red Hat
>    considers the risk acceptable. This can inform our assessment of the
>    risks, though of course there might be a significant difference in
>    the impact of the risk for a company with a legal department and an
>    open source community consisting mainly of developers acting as
>    individuals.
> 
>    I think it's obvious that if the QEMU project gets involved in a
>    legal case, we have a problem (at the very least long lasting
>    distraction from actual work on QEMU), even if we didn't do anything
>    wrong and a good lawyer would easily win the case.
> 
> 3. It was easy to just outright ban AI while its results were usually
>    not really usable anyway. This has changed meanwhile, so it's much
>    harder to maintain an absolute ban.
> 
>    It's not really the best use of my time to look at the idea in
>    AI-generated test cases and then rewrite them from scratch so I can
>    actually submit them. (On the other hand, I think my rewritten
>    submissions were always better and more maintainable than what AI
>    produced initially, so there's that.)
> 
> So while my perspective is a lot more nuanced than yours, I do see a
> shift in the balance and was actually thinking of suggesting a change of
> the policy myself.
> 
> What I was thinking of was allowing AI-generated content in places where
> it's at least easy to revert if there is ever a problem with it: Tests,
> documentation etc., but not core code that lots of other things depend
> on and that will have evolved a lot when we notice a problem and for
> which throwing away is simply not an option.

OK. what about trivial changes? Using AI as a better sed?

> > I propose adopting linux's rules instead:
> > https://docs.kernel.org/process/coding-assistants.html
> > 
> > which boils down to attribution.
> 
> What would we actually do with the detailed information? Why do we care
> which model was used? Is this helpful commit metadata or is it just free
> advertising for a handful of companies?

I presume, if a specific model is somehow declared "contaminated" so we
can locate its output?

> I think I would see more use in a tag like (better name welcome):
> 
>     AI-used-for: [code|tests|docs|commit message]...
> 
> Kevin

I surely don't mind.

-- 
MST



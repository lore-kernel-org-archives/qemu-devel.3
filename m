Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5227CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 17:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRCqh-0006nC-9g; Sun, 24 May 2026 13:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRCqg-0006mw-2F
 for qemu-devel@nongnu.org; Sun, 24 May 2026 13:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRCqd-0002fB-Dw
 for qemu-devel@nongnu.org; Sun, 24 May 2026 13:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779644565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptAnrTShNOXdvR5tu9P/yqe2dmBjUDOmBbiVfCDhRB8=;
 b=VXXZQ9Am04778cmY0i8jQIZ5iZcVsyBeV2D1LINz9O1pCuJVtLuFU0a/HGluD3zBg8jD/b
 sVxq2I83iLMeXn+8SgS8149NZcCpGYxOCyMCTQFzjGNSRB+9Xbh7E2j3cObR0Qfjea8gGV
 4GQVJgDjr43W0QTxJXnEhT58y4FqWIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-66ea_rkpPzmvGW3sjtzOIA-1; Sun, 24 May 2026 13:42:44 -0400
X-MC-Unique: 66ea_rkpPzmvGW3sjtzOIA-1
X-Mimecast-MFC-AGG-ID: 66ea_rkpPzmvGW3sjtzOIA_1779644563
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44696b11265so10907710f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779644563; x=1780249363; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ptAnrTShNOXdvR5tu9P/yqe2dmBjUDOmBbiVfCDhRB8=;
 b=X7CVgV77T723pmjMVST/28XlQTcIB/Wr8jCrwo8lIRTZF5J1ZqQMYJpalOdhRVsMIS
 kE5pE7+gzvFcvfS9UPs5Khx55Y+sKkuyX8+1MS45qq3TTFvdq3i1ilJ8miuMUlfrPT1r
 w+KnYAvqc7YxMlrnYL9uPmI9DRJvBdBZb9cpL8c+F0ns9vcNU+I+nQ3xTk2rAHRT3cfe
 meYaqjzhPHt5osZzaHdpygGftrDwc1PHCRJjRWEnEmXUG0Rvh7DdY2/RD3SUttwVtuLa
 KlMFpX0o/2Efrwd33LPMg7hdz5x6tvOdc3Apw1ijEtvO+4lPNlMvuQRc6fNDSfbpsiYP
 MyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779644563; x=1780249363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptAnrTShNOXdvR5tu9P/yqe2dmBjUDOmBbiVfCDhRB8=;
 b=C0n0UZz2iX/aDtyIUN82X2VbWQpCYsfDbrpFmuNzaix3rGC0YCS5NeLJFWMXlwKcpJ
 VgtF9HB1jyQhib7cYqRFRfHEPrZhPTKZv2dW5jcAyIrU0sH9UnRn66p2klzsjnktv4gj
 UPCOM0gTqdJrROgEHG/CSemesFbDzZCJ7Iwwv5uUFa78+FrQ+tVgimlfVdBK+pLt4kWc
 R8vn7xtghMKxPyZ9eY4cZHsnF1TEIfJCWxGXqcKjiWA9V8e5q1Au+OT1Frompu15ny7a
 FXmp72MMCNWn4nFmiI1xTWy3WnSbGZcASHzMnzitQyu2l7dXgOrVezMIQwvdTjX98ffy
 SPTQ==
X-Gm-Message-State: AOJu0YxMEW5U/eQBGrgBS59+VWRNkwjJKdJd0+7UaSQCuM+o2wNs3IzG
 a0R7FQtLmbwfA2Oyi5+DLL7blyFU9ptakWzEA/aYWgc0pwkw3t7gqRUve87sk4cQ7pj0Bpfax3Y
 aHq52dCoGFbTSvUFT5i8qe4EyLwOcbejHZC0UcclTC9U0Hl6e8tQGI5pd
X-Gm-Gg: Acq92OEimdLoXjJI7k0CHTs+u6dyHwFUVrrjSYwMC3rvkZSllIVpOKgOCFICp+3YdbT
 wnZmBcwntD/pLrhFPVgYK5ToJH3eVA4bWJcW4KCMPlI064hr7NgkliEsW4610QkRDHtX7uWnZ5l
 IvvJp6XjkFPloet5U1JpKL43yI3QSNCX/NV+01hN1/q9S8woS8gj33hlRY0Vi+5ah36U2Xj+pN6
 1l2lFJGgNLFWbq4M9M5E7eSvOz0Ityz1eQhbwupldrGsPqfncN2ZMM+liXGZjGjSPWErTyKz3uz
 rYD8jKmClgbhMYwET540u+JMg/yO33sBN1vL/5/H57Aa6CqeIFGI8ReyklDuYnZCFmLYZiVXqVU
 kKMluCq4JFM1Ap2i4pY+RORCJec/zkWV/irnDbBa6M2JJ4Q6tnuQmUA==
X-Received: by 2002:a05:6000:4a0f:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-45eb36ab71amr18058359f8f.16.1779644562569; 
 Sun, 24 May 2026 10:42:42 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0f:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-45eb36ab71amr18058325f8f.16.1779644561978; 
 Sun, 24 May 2026 10:42:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cce0a4sm20172410f8f.12.2026.05.24.10.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 10:42:41 -0700 (PDT)
Date: Sun, 24 May 2026 13:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260524133734-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7ccd9eh.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 24, 2026 at 06:06:46PM +0100, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > So, I had to reject a perfectly reasonable patch:
> > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
> > just because of a tool used to make it.
> >
> >
> > 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> > 	content generators commonly available today is unclear.  The QEMU project is
> > 	not willing or able to accept the legal risks of non-compliance.
> 
> In the linked case the LLM is basically doing a glorified search and
> replace. There seems to be no danger of accidentally regurgitating any
> training data which is where the worry about inadvertent copyright
> infringement comes from.
> 
> That said in my experience generally any code that does come out from
> these tools tends to match the local code style and patterns pretty
> well.

Making the code original, too.

> As a general purpose boilerplate generator they are probably
> better than a lot of people at this point.
> 
> There has been some case law now that says LLM output could be
> un-copyrightable depending on how involved the user was in the iteration
> of the code. I suspect there is still more to come.

Waiting for courts to settle anything means waiting years, while
the industry has mostly moved on.

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
> >
> > I propose adopting linux's rules instead:
> > https://docs.kernel.org/process/coding-assistants.html
> >
> > which boils down to attribution.
> 
> attribution and *ownership*. I think the key point of the policy is to
> make the actual engineer signing the DCO the responsible one for
> generating, testing and validating the code. It is strongly trying to
> suggest that vibe-coded slop isn't wanted.
> 
> I still have concerns about the quality of the code and the
> "understanding" these models have. They can generate very convincing
> rationales for their decisions but they also are prone to being
> over-verbose and over-complicating the solutions. They have a tendency
> to chase down rabbit holes in the code and get lost while making wilder
> and more invasive changes to try and get things working.


That's up to maintainers though.

> That said for personal scripts or random experiments the ability to
> quickly get to a PoC is pretty great.

Patch above is beyond that.

> I think there is also scope for using LLMs for things that aren't
> directly writing code:
> 
>   - code review
>   - investigation
>   - generating test cases
>   - polishing documentation
> 
> and I wonder if we should spend some more time investigating the
> performance and pitfalls of LLMs before we open the flood gates to the
> code.

Who would do the investigating?

> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro



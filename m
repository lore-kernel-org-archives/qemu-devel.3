Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4FDCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iBp-0000Kj-AC; Mon, 22 Sep 2025 11:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iBc-0000J2-7Q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iBW-0006gR-EA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758553831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GpbEp03jRt5WyD7x92wNtFUIr2l/oWwdxOmUyfd11nA=;
 b=eVz/YsMi1mhLvM/Sq2TIw6KJnXsEU13O2DlC6br27Cy6iUKJ6vEBg4qm3jXVFqM7SS0OOs
 htkIXkph5hVdrR+wWvRHpoj6mWbWywuLZIwjcfmgd38u9WtDaW9JmPL9pUY14XHTBvmjTl
 Yrv4F7gtLB0LmUTdg5BQg+cypONY72o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-SlyRjHvcO42YXkw4wVT3UA-1; Mon, 22 Sep 2025 11:10:27 -0400
X-MC-Unique: SlyRjHvcO42YXkw4wVT3UA-1
X-Mimecast-MFC-AGG-ID: SlyRjHvcO42YXkw4wVT3UA_1758553827
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ef21d77d2eso3743799f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758553827; x=1759158627;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpbEp03jRt5WyD7x92wNtFUIr2l/oWwdxOmUyfd11nA=;
 b=gWCdZv50z6ONbLp69zg+ZU0OF2KI/ncWqudUL3uAR6w8KTo05WLfmgvh3nAqwDqPps
 w9aum3lshnmRvY0zEY65gz6gW1LOiNVTRP6NOXrNxd7TFUSFLGPAhFoZAHRNw0Q8bUoN
 Cvl6Xyh9cZJ4TvGW0CaRZIiPXAGFtQmvUFwXzxJkzQiqZCSkk/Il6k7itiSQF23SmQDL
 aov3eY9+3bT41lWwTY05x8uQFiAguTR2K39oPo7Nh1NVjvAh96MlIjXTvtyTxHVYzTY8
 DIS+PJ44tS1EQ6IiUijjItdbWPh645hqPP4k9SE5NwKvCv6B76wD1KOR1q575p1Me1WT
 oLvA==
X-Gm-Message-State: AOJu0Yysn4WXFn6aSLDMBUA1Kiy78MysiqFmGECi+1GsD10RN49PkPxV
 s9UTdxsY5+fhpr9H415RVJVDYU+SgMt9q21UKuzGyRUE8GXizfdt+WfrO9DPM3iX7uzlO5MtGWT
 6QQ5/plD+2cnRrtv5A9/++lsPYfPxvxGCmRKDmzPSH+i1fkEQmCLaPB3w
X-Gm-Gg: ASbGnctH8XuaYd66Aw/POmcdPlEkDwNGCGeL7FDkvIDlNgt4RFIjEQNnGDumrhuEm87
 liVsDV3922E0GNwkL+AGLOqU7Yw+KUGIcvQtGpOaOkhuZISuprFVQTMhPhgoEMfqMKiv8QpHZCi
 ItMmekIazxmZInI4LxTasoIzbN+Qc1TT2s7SxHEdm+LkLtyg/TkO51UC+MdI+Xq28ljhdqdYSPD
 2ZuCjgJ2W4dXO8fMqzWM1e6/CcsPq8OKKt8QNR70y8ZPITLEHb11CB2D9Q4nAGb6AivGywoNkCl
 kQhiL7ECdLlGy8bvKteNp6P/rJjApMQDu2z/PX9tzLmj9mSdPYG6pZsbO0ZenEEGW0TOyKzALnE
 GVD3ltDjVyZGKNbvvS4JiDSeZ3a38y/SjBG1Mmbi7TeA=
X-Received: by 2002:a05:6000:2c06:b0:3ec:25d2:2bdf with SMTP id
 ffacd0b85a97d-3ee7ea921dcmr11471146f8f.27.1758553826580; 
 Mon, 22 Sep 2025 08:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsCCcOus1rumwxTlgWHwpE7tMO3m4OCM1lxFIRxLVmmlFoHD4FmSbiz90WzFVykG8x3p5FKQ==
X-Received: by 2002:a05:6000:2c06:b0:3ec:25d2:2bdf with SMTP id
 ffacd0b85a97d-3ee7ea921dcmr11471118f8f.27.1758553826101; 
 Mon, 22 Sep 2025 08:10:26 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46d7a566a27sm38873945e9.20.2025.09.22.08.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:10:25 -0700 (PDT)
Message-ID: <ffaf300c-4f41-4741-899d-f0fc148ab2a2@redhat.com>
Date: Mon, 22 Sep 2025 17:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
 <aNFJVrusgEUaLuDW@redhat.com>
 <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
 <aNFXJtQu9gFkIwLg@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNFXJtQu9gFkIwLg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/22/25 16:03, Daniel P. Berrangé wrote:
> Whether we have our AI policy or not, contributors are still required
> to abide by the terms of the DCO, which requires them to understand
> the legal situation of any contribution.
> 
> Our policy is effectively saying that most use of AI is such that we
> don't think it is possible for contributions to claim DCO compliance.
> 
> If we think there are situations where it might be credible for a
> contributor to claim DCO compliance, we can try to find a way to
> describe that situation, without having to explicitly state our
> legal interpretation of the "copyrightable vs non-copyrightable"
> boundary.

Right.  I am sure that a lawyer would find some overlap between my 
definition of "where the creativity lies" and the law's definition of 
"copyrightability", but that's not where I am coming from and I am not 
even pretending to be dispensing legal advice.

The point is more that the tool shouldn't have any bearing on DCO 
compliance if the same contributor can reasonably make the same change 
with different tools or with just an editor.  And we have dozens of 
mechanical changes contributed every year, written either by hand or 
with a wide variety of tools.

I have no QEMU example at hand, but let's look at a commit like 
https://github.com/bonzini/meson/commit/09765594d.  Something like this 
could be plausibly created with AI.  What I care about is:

* to what degree can I automate what I could do by hand.  An AI tool 
moves the break-even point more towards automation.  I would not bring 
up Coccinelle for a 10 line change, in fact I looked by hand at every 
occurrence of ".cfg" and relied on mypy to check if I missed something. 
Maybe an experienced AI user would have reached to AI as the first step?[1]

* keeping people honest.  Between the two cases of "they don't tell and 
I don't realize it is AI-generated" and "they split the commit clearly 
into AI-generated and human-generated parts", an exception makes the 
latter more likely to happen.

> That said there is  still a questionmark over complexity. Getting
> to the end point may be a trival & mundane exercise in some cases,
> while requiring considerable intellectual thought in other cases.
> The latter is perhaps especially true if wanting simple, easily
> bisected series of small steps rather than a big bang conversion.

We encourage anyway people to isolate the mundane parts, therefore they 
could use AI for them if they see fit.  Independent of whether the 
contributor has worked on QEMU before, the more complex parts are also 
signed-off on (and we'd much more likely spot signs of AI usage when 
reviewing them) and that makes me more willing to trust their good faith.

Paolo

[1] I tried "I want to track the PackageConfiguration object per machine 
in mesonbuild/cargo/interpreter.py.  Make PackageState.cfg a PerMachine 
object. Initialize PackageState.cfg when the PackageState is created. 
The old pkg.cfg becomes pkg.cfg[MachineChoice.HOST]" and it did pretty 
much the same changes in a bit more than 2 minutes.  Including the time 
to write the prompt it's almost certainly more than it took me to do it 
by hand, but this time I was doing something else in the meanwhile. :)



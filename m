Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8169C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 05:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDceL-0000qE-F2; Sat, 10 May 2025 01:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDceH-0000q0-Q6
 for qemu-devel@nongnu.org; Sat, 10 May 2025 01:21:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDceE-0002Td-0d
 for qemu-devel@nongnu.org; Sat, 10 May 2025 01:21:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e70a9c6bdso42798265ad.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746854476; x=1747459276;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=icnR6mCExmKuvXMxjjDFnK3+IjjW6pRctB4P8e+djZs=;
 b=RyDvxz8MLs6hZ5vOgVw+3xEhWlsWEQZYkmHbBPxWuc9xWb3lnZawUQwdMABLdMN9k0
 UmvLAcQlae/6oc+j9UL92cYrVffXGeMBnSY+O88W+S+HhsLAig79AKPNWOYl14w5UJDN
 65HiIpcKJ8wmp87iCvuvhiAhgt9wV3Qb0KnUWnIBUMA8N/ooNZBvKg/u7K2gszAuaspe
 O3fXsk/M4TCSgs2ORcblSzh6hp3T/KqfnTv1Lj+juL7iCTD7EpfgFwIX5F2vg2mqd9nU
 EvmsTHA07P6ZVBZbMbMoLpMbVdhtIdSNiDR2Zn7UcP7WAUR5oXjSP9uYjqpFx1CPfJhZ
 nuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746854476; x=1747459276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=icnR6mCExmKuvXMxjjDFnK3+IjjW6pRctB4P8e+djZs=;
 b=KsRE/tE8TXJQr8PQ/sY7rFI76gDAJ3X2elM68jBFWZAOOFgnhEYwfFzNU+XsJDrBj8
 IUTEhlt6u/eZOfUBRDd3fhyW4w3JD6OnRVxiAUBYXEvH+gaLsxkhIlweZz3MtUOpuAlR
 yfZx+JELzDkJJbJWJGCwlfPce1CUl86Wm7SEhg1VBETz/9LT2BbXTs/izOWxdyI5Migz
 Yum4lw9lTm2yEZ28amt7gW6gjW0JyVSbkjB//x/HqXEntB6CIZ+oR7Wa5I9PHlv8FsO8
 3o4U/Oi6KWH8CLggvgJnNwIb/U97XlmhzJbfz8ANhY1wwHbb8k4WvTqWC76oRGJ3/UUK
 I2Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4zBREbfTs6UKQvpUitDEIdeDtxS4Rl1MZEmHR+naWjr0t+YOJwrCknmsrqCnNzwyIP1VOKAnfCVOr@nongnu.org
X-Gm-Message-State: AOJu0YwDqcTacJkMCvM0tbpWj57ZzwiHuhAaj0cJ2Uy74ui1OdJ6uA5i
 DCv1Qyt+71ZjPZ+N8e3YMEFDyaC/k40uzlcIg/96O2HCistVtcA1+gqQI9dOJSk=
X-Gm-Gg: ASbGncvzYELzk2dqNG20rpXgzcgPKUg6zPVoY9PnYt6SQD7BhOZatixs4sZJnjwrAW8
 XBFH+tSWLMKORW1qVE3AZPIC+B7CCXrWsp2D+iUduLqUEWbgv/CYZ2fVsDYsB4Z5mVD6hhGKF9n
 670cMLJQjNVYaDChJDOCtQq2oSsXat047X3YbRtR2Nd6kdN7qXdbRlCTCYGhLzBxlrAathi1nnL
 LbIsB7Wg5SKjT9+nAXyYe2+rFX1pASWvqq2S+BHxOC7gCgajoRoNM69Ihorj8yqsx/FGFdgj4kF
 rRx8pY0ZVCQiUhaYHALEh0OHjKiosDR3pLhhel2gHLyN3lrDuhTv7xvFqOIC+w==
X-Google-Smtp-Source: AGHT+IG4CssyCag+gZZ3r/aCdjY3EvqiHNBV3rlAq77gQl5Txi6jqPXp33+UvwNitXuBXCtw4tbDEg==
X-Received: by 2002:a17:903:32ca:b0:21f:1bd:efd4 with SMTP id
 d9443c01a7336-22fc8b334f2mr91622345ad.19.1746854476204; 
 Fri, 09 May 2025 22:21:16 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7741e76sm26499295ad.98.2025.05.09.22.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 22:21:15 -0700 (PDT)
Message-ID: <a77fbf1a-0155-4e88-b520-043b025d44f7@daynix.com>
Date: Sat, 10 May 2025 14:21:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: Bump sphinx to 8.2.3
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 devel@daynix.com
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
 <CAFn=p-bSMFVScSNewv_92-3u2FyyN5CYpUkABppazW53CUF-jw@mail.gmail.com>
 <871pt1ngeu.fsf@pond.sub.org>
 <CAFn=p-YmggufG8c7no68sSBca0_cZNO=fqZbLR0hcf2Lm40n_Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFn=p-YmggufG8c7no68sSBca0_cZNO=fqZbLR0hcf2Lm40n_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/08 3:23, John Snow wrote:
> 
> 
> On Wed, May 7, 2025 at 1:22 AM Markus Armbruster <armbru@redhat.com 
> <mailto:armbru@redhat.com>> wrote:
> 
>     John Snow <jsnow@redhat.com <mailto:jsnow@redhat.com>> writes:
> 
>      > On Mon, May 5, 2025 at 8:19 AM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
>      > wrote:
>      >
>      >> sphinx 5.3.0 fails with Python 3.13.1:
>      >>
>      >> ../docs/meson.build:37: WARNING:
>      >> /home/me/qemu/build/pyvenv/bin/sphinx-build:
>      >> Extension error:
>      >> Could not import extension sphinx.builders.epub3 (exception: No
>     module
>      >> named 'imghdr')
>      >>
>      >> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a
>     Python 3
>      >> version of python-sphinx and the readthedoc theme
>      >>
>      >> Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for
>     the new
>      >> sphinx version.
>      >>
>      >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
> 
>     [...]
> 
>      > Can we set our suggested version to 6.2.0 instead? This version
>     removed
>      > reliance on 'imghdr' but merely requires Python 3.8+ which is our
>     current
>      > stated minimum.
>      >
>      > If Thomas upgrades our minimum Python to 3.9, then we could use
>     something
>      > as new as 7.2.0 which requires 3.9+.
> 
>     Thomas did: commit d64db833d6.
> 
> 
> OK, that being said, let's try setting both the preferred and minimum 
> versions to *7.2.0*. We could theoretically aim higher, but let's start 
> conservatively for now and see what, if anything, breaks before we get 
> more adventurous.

7.2.0 as minimum and 7.2.6 as preferred perhaps? Patch releases fix 
regressions so the latest of 7.2.x may have the minimal risk.

> 
> I think 7.2 is new enough that I can remove the vast majority of the 
> compatibility crud in docs/sphinx/compat.py and it will make my life a 
> lot easier, without being so new as to require a bleeding edge version 
> of Python that may not be available on older platforms we still support 
> for package building.
> 
> I think it's not a huge deal to support Sphinx 7.x and 8.x for now. I am 
> just reluctant to suggest that we should have a pinned (very modern) 
> Sphinx version for doc building, because I do not know what the impact 
> of that would be on downstream builds that offer documentation from SRPM 
> (Red Hat, etc) which may not be able to procure a bleeding-edge Sphinx 
> from PyPI from an isolated build environment.
> 
> 
>      > I'd say 8.0.0 is too new (requires 3.10+) and conflicts with our
>     stated
>      > minimums.
> 
>     Requiring more recent versions of dependencies for optional parts of the
>     build can be okay, but the degradation must be graceful.
> 
>     This makes sense only when the more recent dependencies save us enough
>     trouble to justify inconveniencing users stuck on older dependencies as
>     well as the additional build system complexity.
> 
>     I have no opinion on whether that's the case here.  If you think it is,
>     make your argument :)
> 
>     "Graceful" means that if we require Sphinx 8, which requires Python
>     3.10, the build must still succeed when we have only Python 3.9 (our
>     stated minimum), but we don't build documentation then.  If the user
>     demands documentation with configure --enable-docs, the build fails.
> 
>     [...]
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC2xC-0008Bj-7D; Thu, 23 Oct 2025 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vC2xB-0008BK-07
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:34:37 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vC2x9-0003Ff-8m
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:34:36 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c523864caso3002921a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761255272; x=1761860072; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOmC2tiM/IvAmDg7gFMFf/gerrctVExmtEqvUk6yOgA=;
 b=RfnktX/YqNIUe120G4MXYnqXnob0VnL6MFlBAWREJgoQfifoOsN1cYm6AjYztDdh1X
 yt3tC1O1T+CVUHErqYXgdObjdI9/UrnpDrUoGZZR/IZiay/5uBI9QOcdPTbJMzkRn2A1
 GEKYPBjoi5B9gsIffEMEKUZcBTBgEpMQYJxtMx1rvQPgynmkYAZoy+H4UJXwHR6VSXEE
 xdpqu/WJrBXTMAQ/3SYIfG/pHMWaCBxSuV4lsJOfx3VYOODdIHvJACLsQsOhwXEPk04y
 uZAE5Ne+nhiCRSz2MbzT3oMBs/HA5rCwPoc79UDh/boCa04vuA3dtVxGkPQDj7j/8M/y
 pBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761255272; x=1761860072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOmC2tiM/IvAmDg7gFMFf/gerrctVExmtEqvUk6yOgA=;
 b=JPe07PCiBfKTUgUdoeu9e1QdFqVTCDuOYya0qaDCycyC1lE90Ol2uEJvyDJy2Atryq
 tUZsB6dG5jczZegHoyt/tG9u2jgnXPSNaYzUqBHmA4SscVix2+Ma8pg3dnVpaijnM5C1
 iY/cATSAHTS0hrx6KHo86XgtrBWaLXsH4n0rDq/ctgGDXcnsUoOnpEJhnEwIdp8ERx9F
 G10DXRiXJwmICV/nd8DDJLSju26daYuF4A6MFcy+NFI1t/98oVpOqnFN5O+K9TqHba/l
 K+pBL8FMKy6sdsjrKG4Hz3GQE+DW8j14N0/QpdnKST5nMsHdZJAON/kGGyY/GhLhWaMN
 VS7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCreu/nzDUw7HAvkMSqndaOZ5RsOsVG3IyNijypMtkDpJ76pY0CM9mLInozKgvtJXYYbgEMHu+eij2@nongnu.org
X-Gm-Message-State: AOJu0Ywk2q9RvaW2PYUOxGJDXDsKB7bOnuYf5IybwnGhNUi9RWeDarpT
 RtKs/nuj+5c2Y890C8zPxltvNu0jUlxGgaCEbSt1Krei1fo3QzkuqxqrhAEtmXjGOwtiA+iG30M
 ySLHWDfevXoettdB0+s1c7B7pxsg+GK8=
X-Gm-Gg: ASbGncvyzTb8YT69k9qg70kVtlgGNIfkrJ3xYuRvMfW3kn9O1iI7RBH0rS00/hexySH
 9uqXL3BSboxzxB5sxnhFb8Gnfsa4vQSkOXaGrYWg8wGyFCUFSh10dOSU5Tn6GApAq8zyMVOWobz
 iuuSqRmbyAftQMd55xUOEfZqLKJjKwCUwVCkVSaoAGw2wx0acjVmQprFyEFZJcR2VKsBIPyhzes
 FyvjMrVc+m3aZIndPAWGAGxmL4Jh5DuWUR7Ardlw1d8Qgd75bDYT4b0EMBlBy3PS9LSGg==
X-Google-Smtp-Source: AGHT+IH2Ib6su9qEvlAV83TykLYhPh/mUEKs7gJm4McAIsaj1VAB4Dz2qkijn6nx6PxOP9hjIkeVgHXYTiMEkk5gE+A=
X-Received: by 2002:a05:6402:35d4:b0:634:bdb3:e63f with SMTP id
 4fb4d7f45d1cf-63e600d16b7mr137146a12.20.1761255272137; Thu, 23 Oct 2025
 14:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
In-Reply-To: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Oct 2025 17:34:20 -0400
X-Gm-Features: AWmQ_bmBA7fizfp6BdSpTu1xNJIlaW2Czi5bAzYh9OKQviRUpNXUgnCEc5AQ1hg
Message-ID: <CAJSP0QU9M1QEXjKBjHtq2NgHu0FUTC4rXMxB657BsdxGvcs1ew@mail.gmail.com>
Subject: Re: AWS CI Oddities
To: Camilla Conte <cconte@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000dac9ce0641da32cc"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000dac9ce0641da32cc
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 23, 2025, 15:03 Richard Henderson <richard.henderson@linaro.org>
wrote:

> https://gitlab.com/qemu-project/qemu/-/jobs/11827686852#L1010
>
> ERROR: Job failed (system failure): pod
> "gitlab-runner/runner-o82plkzob-project-11167699-concurrent-9-ther90lx" is
> disrupted:
> reason "EvictionByEvictionAPI", message "Eviction API: evicting"
>
>
> So.. if I'm guessing correctly, the job is doing fine, 28 minutes in to a
> 1 hour timeout,
> when it gets kicked off the machine?
>
> This has happened a few times the the last week or two.  Is there any way
> to fix this?
>

Hi Camilla,
Any ideas?

Stan

>

--000000000000dac9ce0641da32cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 23, 2025, 15:03 Richard Hend=
erson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson=
@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/118276868=
52#L1010" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.co=
m/qemu-project/qemu/-/jobs/11827686852#L1010</a><br>
<br>
ERROR: Job failed (system failure): pod <br>
&quot;gitlab-runner/runner-o82plkzob-project-11167699-concurrent-9-ther90lx=
&quot; is disrupted: <br>
reason &quot;EvictionByEvictionAPI&quot;, message &quot;Eviction API: evict=
ing&quot;<br>
<br>
<br>
So.. if I&#39;m guessing correctly, the job is doing fine, 28 minutes in to=
 a 1 hour timeout, <br>
when it gets kicked off the machine?<br>
<br>
This has happened a few times the the last week or two.=C2=A0 Is there any =
way to fix this?<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Hi Camilla,</div><div dir=3D"auto">Any ideas?=C2=A0</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Stan</div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
</blockquote></div></div></div>

--000000000000dac9ce0641da32cc--


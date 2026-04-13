Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDCFEBFD08
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBMh-00022E-IT; Mon, 13 Apr 2026 03:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wCBMf-000221-H4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wCBMd-0007fO-1u
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776063940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rP9OmD6kzWjSTzfQyz6L9UHg2S7xLEMWRKDUhrbG2Ck=;
 b=HiOMFopk/fvNucn8FhXcNzDDY5OZdUDlCOq+0/15jGl7F6BJxn4GcjWewBKsXQFMVcu57g
 0Uq2MXMc4VJKNooeB4UPfO8MqZia8+hlYot5mzIBcbzRO+oRfXTuFPSUJxy9RhgTjuMJGU
 z+bZTs+ZHM/OVQcwM0oYr4SGkfJHtZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-NpwNmdH3Pl6zOfypDTPHIQ-1; Mon, 13 Apr 2026 03:05:39 -0400
X-MC-Unique: NpwNmdH3Pl6zOfypDTPHIQ-1
X-Mimecast-MFC-AGG-ID: NpwNmdH3Pl6zOfypDTPHIQ_1776063938
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso247650f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776063938; x=1776668738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rP9OmD6kzWjSTzfQyz6L9UHg2S7xLEMWRKDUhrbG2Ck=;
 b=GFvpUIh7uLM4ozV1SHvdAbXxNQOnQ6bZYXHeQF4aOOHGoFvQxDwImE9c3Kna3C7jL0
 4mpHBmlDr9On0x21w15Ukd1blPwwcVQdKGywL0CgUAWrdt6TBn7Xx2g9HB2Tyv49A44Z
 bbtj53fo2eJatM/IK1D6pu1Ils4VjJqh8doEA6ZukrUGhhtZeVx1tfRqlgplOkAKjbcx
 DO/htCfycBgSKJKH44nrkstjwzzTuV8PlrPlGyYyURWhZleCNF12L+mbrWWvqZWqJAKI
 l88o4/KRCWCY/btOAoFU+MrUCIhLypk/92fosgAyrQ0KmFVw47TKx7jWyawH3UBqUUB8
 1Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776063938; x=1776668738;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP9OmD6kzWjSTzfQyz6L9UHg2S7xLEMWRKDUhrbG2Ck=;
 b=UFisIt8s8Xja+FDWWCHisGlBFJlTx5QaK1Glr1UH2JJrWS8CsoxhoROt642IdcHnpR
 rwW5zMeYJtLs6wwnjj94CAAO43bNySfyDQgQdS81TzMqUm6SowTTYVZf9BoqiOq7ah6Q
 zCaIm7OEEV5yX4iCN1okfLUIb9y2k5mpq4LekVMbbvm1kzIXjM6yvG4VMopc3yufkIR7
 db42d+4HLJAaVIva3avi/c4758NP0WW0WlEJMF211ZbLkiTtQpUyQLOKDXNFzR/G/b6d
 NpOCyDBUwV9Z3d5DySoG1XrixaHBL5kCHxt71AZPw7uSlhPtBWj8gq9W2c4p4qehx48E
 eI1Q==
X-Gm-Message-State: AOJu0YyCHqvmloNbtD6wpzJ276ktCVs+dTibYFxEmlLFn7Ovv7HQ/64C
 1LRYr95nf28AXqF6g4Lqiy1pRzCgK+n9wVC4iDl6h1eefziRkt6wv6gY+LXxZvJUNONGZsPikR6
 XcQ764Vx3y5Ujtu+CNzsbSIkZ0dYW0Xwtwe4Oh9t7+Uut4BnGWkA9ebvz
X-Gm-Gg: AeBDieuq3mjCC2eO3/wJBXagA22R0ox84kSft0GEznMrqXsjGuOUADKjt9A6/h2Q+u5
 uE86KxbiJjK79p8OiS31lHxCfWbETLpY4zPlCVa82Iy5Y0Lz/h3ZWEtyc7AvevN4mEpnyuDJp53
 fDC1RFPcaRAN91/uh0AGHwIZMPTSK73OJLXCsYT3EkjFwAyCXtqWgwmDdT0ESm+kt1cCZfwZVxG
 a7UHIo4by72OLp3AhgVg0JQmX4sB+ILgjFnau328c9L9yrNHsJMIHfUREAOchYWvWTAwUz5f10h
 TvEgWUgpIfk0FcykhhAhiXm8Nmtp1Ahkx0Yyy9emJM+IoSIByahWh0IqoSq+43VFPQ3HZVz5wV5
 rkL9lLO4lrO3+LrWZiw==
X-Received: by 2002:a5d:5f44:0:b0:43b:8e96:d3d2 with SMTP id
 ffacd0b85a97d-43d5958edb7mr21705370f8f.13.1776063937646; 
 Mon, 13 Apr 2026 00:05:37 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:43b:8e96:d3d2 with SMTP id
 ffacd0b85a97d-43d5958edb7mr21705322f8f.13.1776063937037; 
 Mon, 13 Apr 2026 00:05:37 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5c981sm31709415f8f.33.2026.04.13.00.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 00:05:36 -0700 (PDT)
Message-ID: <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com>
Date: Mon, 13 Apr 2026 09:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cirrus CI about to shut down
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
 <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/04/2026 16.28, Stefan Hajnoczi wrote:
> 
> 
> On Sun, Apr 12, 2026, 08:45 Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> wrote:
> 
> 
>        Hi,
> 
>     according to https://cirruslabs.org/ <https://cirruslabs.org/> :
> 
>        Cirrus CI will shut down effective Monday, June 1, 2026.
> 
>     I guess that means we have to find an alternative for doing the builds on
>     macOS and FreeBSD?
> 
> 
> It may be possible to use QEMU's AWS hosting where we already run Linux 
> x86-64 private runners. EC2 can run FreeBSD and Mac instances.
> 
> Sponsorship is on an annual basis though and it would be a shame to redo the 
> setup work once AWS sponsorship ends.
> 
> If we decide to use AWS then I can help provide access.

It seems like gitlab.com also at least features macos runners nowadays:

  https://docs.gitlab.com/ci/runners/hosted_runners/macos/

... however, they are limited to Premium & Ultimate tiers, so the normal 
developer cannot use these anymore.

But since QEMU is part of the "GitLab for Open Source" program, maybe at 
least the qemu-project can use these? ... It would be great if one of the 
qemu-project Maintainers or Owners could check this! (I only have the 
"Reporter" role in the project, so I cannot help here)

  Thomas



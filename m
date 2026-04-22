Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90ADF94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFgPL-0000w3-Mm; Wed, 22 Apr 2026 18:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFgPJ-0000vE-N8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:50:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFgPH-00022T-N3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:50:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso82327385e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776898254; x=1777503054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9qaVfkahhhBjRvUFjPcmWxP+YplzAu/gh57x8EA7R0=;
 b=VorKv1otDgYQTIPve4xAHGLEsUtH5YHHhAmvW+Yyk23lcCfiIRNG8MFQ7jEdpqj4+x
 2nF6eKNBEdDMDSQ1jAzDM0jdWMwrmFm2YsFuBDtuUGFiC2npDJxzFl6Pa6U9VG5LXZXE
 dQabafLVvtzThVoWSJDxmTvYx5WH0Imsep+NzD4Q28QMJ/m6VoHkORaKLQqM1653UrnN
 Oz0Enqo+eX1bfJeq1cS/K/NA2BBLIJfYfxTWFwsEqR0P9/loC7BKCWkxmVhWFCSGUc+B
 BpiKjzp+cU+ufm7l8a+nF3xqnZ7+cMTxFK2ar1SGFJsv0pIMwofJEflU/pEv7fZtA+9h
 JcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776898254; x=1777503054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9qaVfkahhhBjRvUFjPcmWxP+YplzAu/gh57x8EA7R0=;
 b=iz8n5u+TP+rF35Tan2qHfmCBQnr3aGCe4cvkIBB0fmgLa75GKY2txGh5aFO9jJR311
 k58UEUvyb2D63NCybCXNadi0YghxW/cLa9wbQQ/ynvKZraHqJLzFnM1ws5ddSu+QiBf0
 fEAvbIOp8ld9oGyUB2GDNEagV6Xx+6wJmTsSf8cbUfQcPoIDH9V5hXXDv5v5O/0YroNU
 Xs++MV8i64yGcvmWFBbaxoMLCMt6jgiA3NV7u8duD7EoP5WjRmnprwrI9vhA5X+wPR5Q
 KD1sOeNHmp4rZwFH1J+23hRdPIgdEi973uiVgs0NeuAF0pheIrjzA7Z7pQL/uIpNMVIg
 LBUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M00TaUac4d7ccUXDEf1PHojv/2LcxQRBkQaVo3KISo8KhK9Il7CboS7q2xOMaP4P9r4JWpGAqxCeT@nongnu.org
X-Gm-Message-State: AOJu0YyfmAeOI8wTyr/ca09ooqDMLphLle5gsbTRGylJlv656mLzpjzM
 y+Qz3JyPcuiQ7PZwSTdn5URph0ZLOD4HEZTNql4PvTBHQ1c6n11hgEOel114lJ8lSzk=
X-Gm-Gg: AeBDieuRtX4MJonm2lgbcOZQ7vXej+1ocgsH/4Eh0DZd5JUUHjjXsBYVIJQfkCPN9i7
 lMIJfewnpXe9ZXMa87msLyM5+Vu/phmiPnY6pWpwCt1EFNskOK7wr9u7puBxqOhLX0TswvHRhkx
 Go5OIWCFlQBPXBuwzKsg8oxLKOg2d162EAMJOJ6GTgIObeEaZeiUUT6cDQ+lZ6vFjmSPPCemhb3
 MU4M8w4rmla4500D6jpl0SZ9pTUWSxL2yxiZeCsXKu8XNzVyoz1H0hupjV5xe6vea+uzUNRl6tU
 ulzPrU8iGeYe801s87qrrLwSQgjoOziwUtYpFzuZ+tKmi/Xz+Ean1uH4ZBtsWk/DYVx8lcF9uhL
 MhNlmWsFImMdoM+pDKRHOzAnDyx4qEwNLJ7oxAYnBXU+4BB0aaPe9DkSmd7gskKdAkqILUNkOHT
 wKwncx9jGfq8F1J+eXnT+CMz5kyawcCdeRMBFehXIwFgEVZtQOxny/Gy6QqJjNk12h0GotyJiB6
 qpl
X-Received: by 2002:a05:600c:1c29:b0:48a:5574:3a48 with SMTP id
 5b1f17b1804b1-48a55743b73mr143428725e9.16.1776898253861; 
 Wed, 22 Apr 2026 15:50:53 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a557412eesm72200465e9.9.2026.04.22.15.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 15:50:52 -0700 (PDT)
Message-ID: <b3c4e048-6224-4492-ab6d-4dbd6a150e7b@linaro.org>
Date: Thu, 23 Apr 2026 00:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
Content-Language: en-US
To: Yixin Wei <yixinwei@meta.com>
Cc: Yixin Wei <easonwei1998@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
References: <20260409164938.6735-1-yixinwei@meta.com>
 <bf633e1f-f551-4c1c-abdf-e54d7e4136d0@linaro.org>
 <CABe+LnuRJNwa=qyUOOVmNh33v0VEPBT+ob9MmycvU+DVaRSw=Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABe+LnuRJNwa=qyUOOVmNh33v0VEPBT+ob9MmycvU+DVaRSw=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Yixin,

On 21/4/26 17:15, Yixin Wei wrote:
> Hi Philippe,
> 
> Thanks for the review! Just curious about QEMU's typical merge workflow, 
> trying to get a sense of how long this usually takes to land once it's 
> validated.

Something like:

1/ Patch posted on the list

    ( delay to next step: 1 day -> never )

2/ Patch reviewed

    ( usually within 1 week, up to 4, sometimes get lost)

3/ Patch queued

    ( between 1 week to infinite )

4/ Patch sent in pull request

    ( 1 to 3 days, rarely 1 week )
    ( respin on CI failure )

5/ Pull request merged


Delays depend on maintainer workflows.

Note on 4/, before every release the tree enters a "freeze": no
new features are merged, only fixed, until the tree is re-opened again.

Luckily for you the tree re-opened as of today!


However this patch belongs to the 'linux-user' subsystem which doesn't
have dedicated maintainer paid to do it. Some developers take care of
it as 'best effort basis' (thus Cc'ing Helge and Pierrick).

Regards,

Phil.

> 
> It's a niche use case but it affects anyone using qemu-user on big- 
> endian targets, so would be nice to get it into a release at some point.
> 
> Thanks,
> Yixin
> 
> On Thu, Apr 9, 2026 at 9:48 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
> 
> 
>     On 9/4/26 18:49, Yixin Wei wrote:
>      > host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
>      > as its loop condition. When the last rtattr in a netlink message has
>      > exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
>      > without byte-swapping its rta_len and rta_type. A big-endian guest
>      > then reads rta_len in the wrong byte order and fails validation.
>      >
>      > The companion function target_to_host_for_each_rtattr() correctly
>      > uses ">=" (added in commit fa2229dbf8). The kernel's RTA_OK macro
>      > also uses ">=". Fix the host_to_target direction to match.
>      >
> 
>     10 years old bug, nice!
> 
>     Fixes: 6c5b5645ae0 ("linux-user: add rtnetlink(7) support")
>     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
> 
>      > Resolves: https://urldefense.com/v3/__https://gitlab.com/qemu-
>     project/qemu/-/issues/2485__;!!Bt8RZUm9aw!8GbeoUxJTV2Px--
>     RJ27lNOg6O6xYuOKOwEP614qzPEoNam2D2rtWkp6O6vvuf1vAnD2-g02GCUsn$
>     <https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/
>     issues/2485__;!!Bt8RZUm9aw!8GbeoUxJTV2Px--
>     RJ27lNOg6O6xYuOKOwEP614qzPEoNam2D2rtWkp6O6vvuf1vAnD2-g02GCUsn$>
>      > Signed-off-by: Yixin Wei <yixinwei@meta.com
>     <mailto:yixinwei@meta.com>>
>      > ---
>      >   linux-user/fd-trans.c | 2 +-
>      >   1 file changed, 1 insertion(+), 1 deletion(-)
> 



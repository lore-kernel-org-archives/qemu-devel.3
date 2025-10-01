Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9EFCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v41mG-0007kj-3K; Wed, 01 Oct 2025 14:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v41m5-0007i8-5A
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:42:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v41lp-00082V-5b
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:42:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso81092f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759344092; x=1759948892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nl2SIymaSoLGPM0GZwLv+GOmwyB7QiFpXfrEivX0AWY=;
 b=vuhDYXarAbGjUUoVwGLbPqIgfzsaq1GJX6P+a9rAs6+UJElnUHqkZRXnQS+VV13meL
 VFdAmd4lYhrjxFZ+nu3LJMaFi8lMmK5ojzVuQ1oHXneI90k8XXrz8h1b0vHz2jwAEAOI
 RmdfziOBgUyb0Yy0failf32oSqwyJZ0y0L81SYoNU1GgG1lYW3qzTaLlea+fKRYsnQXx
 c8SuUljOyt4te+gc+ym2dA3Xo1nk87TeN8Tnlg1XhZGewl1/np5/3l4ivrOWOAOG7sjr
 UNW1r+JKIXgFxaLgcnD/3gjM0MT2OOVSeqMRvxOhhg21elxsNLahAen1GNWVamS2YBKM
 iMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759344092; x=1759948892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl2SIymaSoLGPM0GZwLv+GOmwyB7QiFpXfrEivX0AWY=;
 b=hyTt6jRosEGoR7+RAwCP7hiFJ8T7ADfkgan+4Ayt3Pott8x/eq+fEiSbRnsB/2EbeA
 Dbk6l/fja2NyI1c6F56ahViIhrVyaSPpzd38WSfpOeexCJPgoBaUVm6u+ZW8x/K6TEJy
 2p1oswg1986Z9E/+m4GaDJpMp9km4zHtKINO4znNqmicRcC2J6nxwF5H90QYyMI/J7+W
 r3ZmpBySl8uXeYW6uK2ypUPEx7ZrGfws/5etEEltqJTYKBHy+Y2EmXnREjeEJeczs4mv
 x1/3Kc7kLQhFi9LkhdeZR0D/mC86OlZaw3cdqpVWBrjMagTNFV4DIYTxyTspOiv+qkXe
 fW+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURc0STY1ILPMvE0VpyP1FyawaTsBdtd0DM4ITsMy5gAIqdCWjLDtfRle2vvws5B6lzukiGNNqnh3Fy@nongnu.org
X-Gm-Message-State: AOJu0YyQAGaumBEfVvDlQMs9i9L/zLDR2jX8xsU8Ipq2SgoyfW8sNVmT
 HRnSghHW5WtjDZEfzDU3qn516A20baHtcadtLiUSNSvVoQPOpTlS4LqfUoltdWJ8/T8=
X-Gm-Gg: ASbGncv8OO7zTYsx0tiiV+6r0w6Bpa42CZxtD/9x16xbZ5JxzvRfYfBjWERNrTjSol1
 wDZ86fN+JqK72voDoWtPgmAt17g0Mu9Tsp22KMiOxxuELMi3ESxFon+DyonWfLpryF51kmYGzzz
 MEi3NWPzBA5mhz8eM9XF+DINuqeLTYHGJN/7N4pkuM6Ne3UvoBXDPK9y7jT7H3nCnB+g32Ulgfk
 U3leOeREU7jX8B+8FttBEHpfqlM0G4QhniEN2ulqhV0Pdw2CupgZThMbv5vumoA0OBXH1sRw1XR
 tRoyoDFN0VzxCMdAMGOkp6Ct8I9kBWOG2xLeVvA0O64yREqEYi/uXkxiIFaPVxX0W+fi8KSxEtm
 185l6Lqh8Y6RBgGqs84aLAXdSglsSYP9WAnGol3ZDILKqsiQ7OGe6Fg5YX1WNGdOF368kkw6A8F
 QFAYqNp0AabiCwj7M4ifo=
X-Google-Smtp-Source: AGHT+IFDUgMWWFaSlg8mrmo+Ej2x7djhEHr3dK7DVzmPuJgOTJ22nVrphKZblwmNTwIXsEZAORf23w==
X-Received: by 2002:a05:6000:1787:b0:3ee:11d1:29dd with SMTP id
 ffacd0b85a97d-42557816defmr3489400f8f.35.1759344091981; 
 Wed, 01 Oct 2025 11:41:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bcc93sm2455395e9.13.2025.10.01.11.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 11:41:31 -0700 (PDT)
Message-ID: <50536048-2b05-4424-8254-d61711b03693@linaro.org>
Date: Wed, 1 Oct 2025 20:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tests/lcitool: drop 64 bit guests from i686 cross
 build
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-arm@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001170947.2769296-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 1/10/25 19:09, Alex Bennée wrote:
> With only TCG available we can't support 64 bit guests on a 32 bit
> host.
> 
> Fixes: 5c27baf9519 (docs/about/deprecated: Deprecate 32-bit x86 hosts for system emulation)

AFAICT this is only deprecated so far. Should this patch go with
a series taking care to remove "System emulation on 32-bit x86
hosts"?

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
>   tests/lcitool/refresh                             | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)


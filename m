Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8261D26D99
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJVD-00068H-2o; Fri, 09 Jan 2026 15:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJV2-0005VY-Af
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:54:24 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJV0-00015z-HC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:54:23 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso32843455ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767992061; x=1768596861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DF+j3uQ6yCvoVyhvi8asJ+OnWiCmeWmoYfJi5d4ebg=;
 b=F+OEMselNzElOVTTlQdbZGbAZMMNRoIolx93hJeiv0VugSXOEvhRAIZrgyQ3B+jjoG
 auWGhFwIHuN0uG2ivDpeTP0ZbAqZmrOT2NJn4uTknNYkeeJV9rpy1U8gmSIoi7geRQkx
 5dKvdw2p9lm/cjdJ5xlmzvMKAepS9Jpu9zFodVdJZTe2Xll2e7vwsQmUjbWIW3Jhe6nu
 eNnM+julYjZZ8HGkWWLjaIofyovS6XOWCVCdjxqx1cjtdjWsb9IidPktOxIN8avTNC4n
 mlHIF9s8gGRZfSbvCTJiFfVXM5hqJy0/qDG0YUJhFfKBJbyr658i+xFOuwaS+guRoLM6
 kp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767992061; x=1768596861;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DF+j3uQ6yCvoVyhvi8asJ+OnWiCmeWmoYfJi5d4ebg=;
 b=BJwR8KGF437UWOg3uHMhL7pX+1RvaCuWO4b37GgoiHQpiMgvYQaTBwjuPY0mA/7W7x
 k0xEbxTX1s+8PbOS36iYbhRrWz8m/dbB7MuzJr/BbMB0klrWxgM/u2+9/SbvStaosBsy
 AIS0RrMo3jMxlmynUa6v1b0/5JX6k2AhGXA7TnM90s8aRoPR+XLSfQuMDedV2ivxlItS
 Iv82nIqjfJFvH2IW5CKoIKNwMlokWZAgsXo9c85CGDt4Tsl4hlqp3JdVR9WWx2YU9XXd
 JjWFyPR8RjuD/dcnKUS1Rkat4xqqElKIzGU3buw3N0kginn89sOZYzaIHmvM6Xz8gm6p
 4jNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkWaJiEBKZrmPrZT7A912vydrl51t8mTL4Dtc4pAGSYN6Aar+PmVCoFvZE2fawFjnNyHlMSlvb8FXy@nongnu.org
X-Gm-Message-State: AOJu0YyS6HN/amR4YI4Ho4fbzzCxcXx+DDCYPvSmjSNLIl1JxuHaVonX
 7iD+eDwW2afV2GwpvYqbNqm1fDaZJOHlDEgMi/BU3VZwDLEuhFLK/5b3bBvnG+/EjWeayFtbvo4
 bK+GWw2o=
X-Gm-Gg: AY/fxX49r6rIwA3uvnNJp5/Za1GkMNUxOXrJBKtLWa8Oq7C1635bNHbRxjUIP/WVVYV
 ar/g0x5Gn3+AI30PoMQCZQsct6xyRZ2E7AKMWQUQUffOlFtLV8RkB4639ORGzmTzxjGJVb4ikca
 AVWByN1rMtZIrekAQilBE5+Gzu4I/+k9I2SeigwKtj+0iepdqIqs18Y8KbGfSoQJ68todj51/7f
 XWoX0sp8SLGgH54p/PE9u503OnHIsNYIbBljnPaZdboC7jrbdiO+qOu25O0yLL2DPYwNo9AyFhr
 CH20U44gkFw7ut1BVSgq8SYVR9gW3BTyRkr0uUJOcTB9njAldM2INpXY03cnu/HfL76gnt8OoS6
 JNvA3RyBlW8SsJrdfrBm2opaiUEKfpE+0wogyuBLnJHHtX+eTyZBN0zqp1XgDsp3CiaQ58b7YmN
 7ac4l+IYPBrFNacpmi4Qgu7sq3QA==
X-Google-Smtp-Source: AGHT+IFTivEDPuChQJcXh4Fo8y/QRLp6vtgG4xZU37cSc1eBwTZxw9WtN/oOLHNK0Gt9xvs/FanJig==
X-Received: by 2002:a17:902:eb8d:b0:2a2:ecb6:545b with SMTP id
 d9443c01a7336-2a3ee46510cmr100953335ad.2.1767992060675; 
 Fri, 09 Jan 2026 12:54:20 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm111188415ad.3.2026.01.09.12.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 12:54:20 -0800 (PST)
Message-ID: <76b85ad5-d6d2-46f4-aff8-ce61b50ba788@linaro.org>
Date: Sat, 10 Jan 2026 07:54:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu linux-user: why we check if TARGET_NR_foo is defined?
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development
 <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
References: <968e584b-f26b-4d61-9cfa-61d88515cbd4@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <968e584b-f26b-4d61-9cfa-61d88515cbd4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/9/26 03:56, Michael Tokarev wrote:
> For a very large number of syscalls, we have conditional
> compilation in linux-user/syscall.c.  For example:
> 
> #if defined(TARGET_NR_epoll_wait) || defined(TARGET_NR_epoll_pwait)
> #if defined(TARGET_NR_epoll_wait)
>      case TARGET_NR_epoll_wait:
> #endif
> #if defined(TARGET_NR_epoll_pwait)
>      case TARGET_NR_epoll_pwait:
> #endif
> ...
> #endif
> 
> However, there's *no* target without these two syscalls,
> and no target without (relatively new) epoll_pwait2 -
> these 3 are always defined, for every target.
> 
> Why do we have these #ifdef's - here, and for multiple
> other syscalls?
> 
> Can we drop these #ifdefs, and thus simplify the code
> significantly?

A few are required; some are not having been added reflexively.
Any time you can successfully remove one, please do.


r~


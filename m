Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B18DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KE8-0005uq-5q; Thu, 02 Oct 2025 10:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4KE0-0005uN-6l
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:24:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4KDm-0004xG-S2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:24:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so519763f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759415023; x=1760019823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfuU4zidgtQhPc7U3EHcYKc4WDVfc2Wfkuy0v1qLnpk=;
 b=EjtGErrDjvq0uhpHzsvJiV/j5PgEOm9YPfdKvb9ITStnYr08riaEpyYrSPm6uSH6my
 lsaYPqXRw3bDYkPhhFcFEm7YFby5Gxs1SUQj8Lmk9TD393J9YrOp7nRG5vh9rQzj4BNs
 34KAioaYms6G4WVgR4SqwINDOhJIQJKyCl+jZk1wlLLC60E4Sg5xabCH2H097J+v6ft3
 rllUMUtgCUKGd9qR4ROtqXTeAkA484ciA9bVMApoAOovYftqTGTbge5UOxAWcZQKJe3u
 MYleECGFRU/7hnIG7RYRRJM1IKD+PN5vkULhz1mSQPoo5spLD9lET4UdiVgKUhaEttHu
 qXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759415023; x=1760019823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfuU4zidgtQhPc7U3EHcYKc4WDVfc2Wfkuy0v1qLnpk=;
 b=S2/I3q1OitX0bIQncW9960yOsLZxLj8jqjRnX4dIAmxbBR0LPu+UPrmP+LmROrKake
 kQkzzAYSG4Ys4e/Rx2O8XHoZXxdiYMw5DiynSqrMmbGZqlXC+Ifaf8nzjEYVRDWuGh86
 b+0iGgr1QgkrK9yXn0IfJaiwlGBxT8I+F0ONwxyx4XJxAq60tkz8p9euRcIAgtQiL08U
 DNSWBdPFbskjLN4baOJDS98nwECc8KME1w6bayhhgmIosIdwKc04dcGxEpThWVZ/625X
 w9VslUkC16brQT8ZoluDaP0bVJ7pIgzWjtPQyZXosmR+HELhH8RNk36+3N1GInWwF6xV
 5wvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Hqz2m+IviG64KORBI2NXX8VaiFtfL9qJdA6l3noo9exsi8W8Vc95Mfcsc7iZeaSW57nz7iyFqGuO@nongnu.org
X-Gm-Message-State: AOJu0YxoceGQtSYdybbO/ctaKQsjRqzm5a1wOiVqb/cnOVi1RsWlC7Nq
 YQylGNu206oOj19enIqzG0x7bWGjjb/W3xXtz3Tl0a7Rt02ShlHaPIAL9ZcMUHW3jh8=
X-Gm-Gg: ASbGncv1E5y8TcvL1SLlrlDpOaIJTUJBSH4yLIYHz+A6HEYecI1EvSbgWIKFF5urHmT
 3SeNtZpgZvdglOYdU+q3RF94Wzkc1KO3J5e2eQGQ2faxH5+Wzq7QtpPhVuOXyKPkS3Fs7EGi9VU
 hpK0T4ElAUuJY+rK7RHnTPOIm0njSk0BsfOCDfykMoKHn8wsT4Fxl5rCRy7rokGBLAJAv/ni3wO
 Meqc0LC5O1AZX8bY74nWD5Ew4tkpGNT7tLcbqfSFYWuidlwz6cVt6bc2cJbAEYGHqDM0eu3k6bz
 EUat8JKUoH0m1rShKftG/7NaGyqRmC1+xpvkmzZpTv3te9GpTqkM9cX1DYUBVBV2T6eywWlVdtC
 DqY/9p24B0D1sTXAEb+yTE+6x0MBh9DGv1Akhn4uM3Nf2A9CIny7HL8bKN38cBVfgU+wKdVeq4k
 f/K7hXdmI7GKEUX6AZnYGUzZmtxM0Z
X-Google-Smtp-Source: AGHT+IGKA+TiY1gyBSVI+AJ/Me91dsYlg33olnlI+4aKeTUTKm6CuJprhxhTdq2MI2fCPf7+lnOSSw==
X-Received: by 2002:a5d:5d85:0:b0:3b9:148b:e78 with SMTP id
 ffacd0b85a97d-4255781c7b6mr6056873f8f.53.1759415023018; 
 Thu, 02 Oct 2025 07:23:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab960sm3868349f8f.13.2025.10.02.07.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 07:23:42 -0700 (PDT)
Message-ID: <1f77cfe8-08fb-477a-89b0-e885d57df776@linaro.org>
Date: Thu, 2 Oct 2025 16:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark VHDX block driver as "Odd Fixes"
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Jeff Cody <codyprime@gmail.com>
References: <20251002125446.2500179-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002125446.2500179-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/10/25 14:54, Peter Maydell wrote:
> In 2018 (in commit 5f5246b6b) Jeff Cody stepped down as block
> maintainer, but left himself as maintainer for VHDX and with a status
> of "Supported", with the rationale:
> 
>      For VHDX, added my personal email address as a maintainer, as I can
>      answer questions or send the occassional bug fix.  Leaving it as
>      'Supported', instead of 'Odd Fixes', because I think the rest of the
>      block layer maintainers and developers will upkeep it as well, if
>      needed.
> 
> However, today the way we treat subsystems which are only maintained
> under the general umbrella of a wider system is usually to mark them
> as "Odd Fixes".  The vhdx.c code has had no commits which aren't a
> part of more general refactoring changes since 2020, and Jeff himself
> hasn't been active on qemu-devel since 2018, so this seems also to be
> how we've handled the code in practice.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> (Jeff, I've left your email in under the M: line, but we could remove
> it if you'd prefer.)
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



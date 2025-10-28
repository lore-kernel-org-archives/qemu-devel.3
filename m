Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2BBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeAr-0004aW-M6; Tue, 28 Oct 2025 03:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeAX-0004RT-9w
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:31:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeAU-0004im-GG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:31:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-427015003eeso4963528f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761636655; x=1762241455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEzoQDM9mSnVz9QLn6FTTopG9J7I3kL+wox9V4NkHNw=;
 b=ZkZO3ag8MVsjkYuCdhbT4idpK/bk8y4IUsO/qD4d1DZPF/TECXjCrqotq1t4BBZ3nQ
 eST7kRKAmQEnsQF5EzJuuT7MKQhGY3dW/20uOPHiBWacxkB9AG5cAud3Wnv+qUo5fji/
 K8Npt8N0EiYfUZfPLzwr6NTnV2yERRZ4nrw/j1n2eZLpol/ZNDte5CGcruf9nk9XdUbo
 SYFl3MuK4TZoHVjc3IId/b9DfUVll9Q8gB7uL+Za0EA6USLhR87BpwKg2Delt69iDFb5
 ALAT/rV26kRml0x/3/9fl4yNBjwPAEewwlJfkV9gydJGLAnqExRnKUlUPzyglLNu5YgG
 bk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636655; x=1762241455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEzoQDM9mSnVz9QLn6FTTopG9J7I3kL+wox9V4NkHNw=;
 b=cOHlP67QKY/iScLotRLRi9RK9cZ92ihXuC3JZRgWFrelQdWMaNvxmde5N8DRNE5LH6
 lAUFMhlKJYLdPnQGauZAIMrg676i5JTF+bN0JgzoqEf9E1sREYHigmlPw6YJLKhAeWEq
 IKwxXUsSjad5n+VIcZYqVl1uSZ1yDMxmsLmRoKTZ4DnSNWfx8BGAEuFTs2zjZ6WPRIr3
 sd8DJ92nLEjCcu8tYBpBztEQFkhyimZhB69sYlbLK/RzSV874WxrToqziNiI4WdNS1q/
 pAjcHWwKZ+zRlRCXzkAMohwX8d1+f7chSgS66HF0/2DroEdd6AezPqU23qBUI0Fstxj7
 psFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaDsOV6e0pOlJBGP0Zq07upmPluRGWoiXpYN4ehNWLNVT+du6wOILvDjrnPJ7XwD9GA17xmbCGS9wB@nongnu.org
X-Gm-Message-State: AOJu0Yw0TBE+D+m5hxtl7z7ciHdyVJ5JQQyk2zftoMl03PjyuodKthhU
 rlobNamj7hRKh3tjiPflrZmnh90n+qWFHkCVSCFR5OmoDdbycGzRXf3lltU9kuK0cUZNnT4Tpqr
 gPXIo52g=
X-Gm-Gg: ASbGnctYjEwImKTdhlQCY6hRpUMosDo0x6l6K7QhMaUxN996CLnzRjzIs1+7D0Wr2/k
 UV+o2L8z1IRx+2jy8xYjsa6HYHkwJu3OpG+16wIzgk/OHKeoBDBVVGihB/+E6KbxzBbM34bzp39
 K2Hxnrlwt4ac1A6kPeKECybAoqtUaKQANncmDX2l81p+SG34y4dXVgxT4p2trYjpA7mS2PS3tQu
 pEZtAKuRUEafwDU3tYCCfd5JwXAcPoY6V868PpjQHi+q8QTjbWXeBNB+ErAw5ftkz9asMjSuzqv
 uijVTbo4vy1clEZoXYgeVgvZl6//jz5CCWat+XQ+m0uwVPpITfIbuiDnt1kP0YEShKYnrjPI0SW
 CQCET0rfeUqEbEzRaFiAgvYTX0Ueac1pIWoVx45NPV556J+9EWDW9FbH8xTqEVCkKCwwWRvIbiQ
 SopBUwgYQOhvuTKjfJ533jGZCWx/N9f0y0Ohb5P5IF/x6QUQdL
X-Google-Smtp-Source: AGHT+IHCKmo2srPVKKeafu4guf724ubNIObUmN4ggh9glDZdHwe78PPBMK88V/VY9BthnEqFSZIfpA==
X-Received: by 2002:a05:6000:230b:b0:429:8cb7:4e29 with SMTP id
 ffacd0b85a97d-429a7e59459mr1932807f8f.25.1761636655040; 
 Tue, 28 Oct 2025 00:30:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5768sm19110316f8f.24.2025.10.28.00.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:30:54 -0700 (PDT)
Message-ID: <b45053c9-8032-4efe-9687-4c8e2eecdb02@linaro.org>
Date: Tue, 28 Oct 2025 08:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Set FPCR exception flag bits for non-trapped
 exceptions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20251017085350.895681-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017085350.895681-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/10/25 10:53, Peter Maydell wrote:
> In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
> we added the code for setting up the registers correctly on trapping
> FP exceptions, we accidentally broke the handling of the flag bits
> for non-trapping exceptions.
> 
> In update_fr0_op() we incorrectly zero out the flag bits and the C
> bit, so any fp operation would clear previously set flag bits. We
> also stopped setting the flag bits when the fp operation raises
> an exception and the trap is not enabled.
> 
> Adjust the code so that we set the Flag bits for every exception that
> happened and where the trap is not enabled.  (This is the correct
> behaviour for the case where an instruction triggers two exceptions,
> one of which traps and one of which does not; that can only happen
> for inexact + underflow or inexact + overflow.)
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3158
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Queued via hw-misc, thanks!


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2D7C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWlX-0005rL-4A; Mon, 10 Feb 2025 11:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWlU-0005hV-4d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:36:08 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWlS-0005HY-LG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:36:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa3fe04dd2so3542437a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205364; x=1739810164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9F4aQ11WgRR9TNMzzZj79ewD4RmkZSwo/smJ3fCh/E=;
 b=JUcHKbaG0MfuJ/Hp4QcwApD2CjCHJodZ9KrpJTXlhaaP3Dlrecqh7PPklYCRb8xdCl
 LNOGyQz50JBnf6hzAU539OvfLH6xV+gRSBPwD7sA2HiLm9W98lwNBHEgJp0IAe5EWi4x
 fl9IGSavjAbYUc6zkSefunkvVwW0T5aSPQoAStm6PHVva6Q0mvHDt8ZNOhvH+sdZzuRi
 5DhYy3V1uBuR6pI+eMzudzTBKlsnFUcKjdVC0+pG+lxgdnopG+e5GkDvaLrX05knHsot
 hZjeUEktHuuLoOwXWd461yjJPeOdhw857npm42qukpboRTMVGcTgPY0xkQht8E2PwZKx
 W6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205364; x=1739810164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j9F4aQ11WgRR9TNMzzZj79ewD4RmkZSwo/smJ3fCh/E=;
 b=ChNlfNsdN0co9pgeu7aBQ2x7dI+27c9jjzlmLSfRoBnk+6LnP9fOKFUx78vN3HShCi
 Ydq6HtBRLcOf4BYqsjvV6MB2LC0sGjgnfKrTV82SgSE8yyRk82sxuRymWRMVntifYot7
 pgtylhE6VtrFWEXAJquIPQM//qr/8f+ehGxnKA7jXwsIK+GfEoCqyQXxe1uisSDBWElb
 duH9+czXZGsP59wFoB1gPgwv9Oo+T3iLWdmW7CzM5cxJQkWLhnyS0oJWlC/w8MylU4Sj
 u9XLAfHt7029tpYRsuRaUCVY7qkN0UHZzBUd81r3lmv/T74PpwkzE+Dvw+AaqvGM9p1J
 tMSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpfskIYXf68VCTktaZC5AGAKfsd5E7upNA7XSG/cRu2IXk5XIGUY4R6eFqpIlQua0f93mzlplsFVUm@nongnu.org
X-Gm-Message-State: AOJu0YywhO+fV+fGWZ9NZbYlF7xv50OU2rkzzvR985dcQNpTOOD1c3Vy
 RL4JeqrZvdRd8uN5cxv90ikpK1OXmw+rjn7kP0/508Y379VEtR2SCC1HzcqT6cY=
X-Gm-Gg: ASbGncv1mdsMRwu0aYZOqIbQ0Qh5QszF17pWw7T/rKC0CbfmE5yqQSB66Z7JdEDFEm/
 qPhj6nYxrw5k4PLyGCGXqy3I2ZzKA5CvQzmkoc1Nl/WsDyAyqfSRM+UAI30MJqEYuYMUXPHeJzt
 4absAmh4lC88o1tCBHOCLvjR/kSlfZEgaZ8MyjcRAyHeOqaVBvLuFuNNaKZW+PyPLs9XjZ3b7+F
 5ifZ+gQ+g7L2ktFOM48P9c2wFObI0JPszDa+5pwzc19kb2JQ32DO7dEjY4PKKpXtmxSnEqPPZst
 WHh8ibr6V1QdEgTbATRwuTSi3Ueltt87cDsCApVsPPv8h/tmF18k6TE=
X-Google-Smtp-Source: AGHT+IGH4VzpetyXnpLZjFReLD546M4beMeGXJdXMDNi4u3BxjLyXwSTeMAscnJXdTzKT8SlsPa9nw==
X-Received: by 2002:a17:90b:4a4c:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2fa24064043mr22440348a91.9.1739205364095; 
 Mon, 10 Feb 2025 08:36:04 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f268fsm8435564a91.0.2025.02.10.08.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:36:03 -0800 (PST)
Message-ID: <b348744b-2725-4223-a14c-53810ca5a87f@linaro.org>
Date: Mon, 10 Feb 2025 08:36:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] hw: Make class data 'const'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> When the %data argument is not modified, we can declare it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sdhci-internal.h   | 2 +-
>   hw/sd/sdhci.c            | 2 +-
>   hw/sensor/emc141x.c      | 2 +-
>   hw/sensor/isl_pmbus_vr.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


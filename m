Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6077FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHITs-0001GR-7E; Mon, 27 Apr 2026 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHITq-0001FG-AE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:42:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHITo-00034z-N0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:42:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b150559bso79468255e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282935; x=1777887735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4YNnNfRTbJRtIq4x5ehgxFda6IiFl7V71AQRLsGxV/8=;
 b=a5HocQFNtHbp6XzRcRQx53ZokdQ6VmpUgEvSVc6S/Fkzj+iFQ8zgFpfXpJAQxYsvyj
 ZXAJylYeFZyZd7GjyK/BKklus9a6TgOZjz8WjaOWMMo5z48jGKEHTSM3ZFA4nnLKitLs
 BGx/1fbOoEL7iSkYdOTvq1YQhz1+YRVpOOIxTQ3cbg7ATGRDsPS9urMZ6HedA5InChUh
 njovSpIgAVRw5NKp2Z5NqfG0NUWnIwdb3yznnFDyVVl4jXJnMXuvvqAsShe2IJngWTb7
 d4Z9vMPSGehnTRDcZWVkjRj7QOSyX5Tb65Xdej+owx9/U1sGBKGIPD9QNOijtN3CTFp6
 GLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282935; x=1777887735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YNnNfRTbJRtIq4x5ehgxFda6IiFl7V71AQRLsGxV/8=;
 b=KWoozK5CGIhl0WG73ZL885KpXKoT7/HuEV1Y9maYhPQ7eYNmx7s/F8WEMZaPOQkoU4
 ahNb9MY8WT4RXtOorOjbTAerw/KXGwQQUqtCsWfHH1Yj3pAId/IkX1ChAcAlbEuU7Dd/
 Y+u+rvMqUMsdbsba18fNwgyXhHcV8u/gFmbI15gu5lSiDBToZbegeJZw61S8LmSzR+oO
 Rk7ZbAfSC15hsUFUWAAz4BLPut3OvxY9bGWUdxwvoOs0Qlf5YMxdEM3GNwShwfOvyMrD
 E/Co1Pr2XsAOyZTbzAokeoDYIji84a3TZeS0XXCvbZJUFo1C3BuKF3FIwcjj2ut9WcPi
 Hc2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SrkhIzyZ366dT8pOATo37mEky6SHq1pziYDxpm8m5sMUHbXlqbWJSRCQsQGlEvY0HRARb82ePU5RW@nongnu.org
X-Gm-Message-State: AOJu0YzZ/xfw73WPgBaLb8hoKrkSEcQa87+uv6r0bmN+LXNSkoPfX/Rg
 uCh9LyiDTxpDPR1NECkO/rWA0IojZIngjw6ydLbUysKfcBlrG2la9C9gVbk+UvYPp8DAgaAsU7Z
 2Hp/IEFE=
X-Gm-Gg: AeBDieszA/x+hbEzpmY7bV9c7+p6HOVaFrszM4TxeU9cNkyRoUX++e6D31jd2Mn/jfu
 HowMa0UEgTRS/jMkZL0/ARV+/gF5qfbtqAvtWfKZpqo+X2tXnE9q7KrOj6uWBmXcF9OwV5iexRH
 JgAkX1HfdZgeSdtlXaGVKR4YsYWQfemla/DgfzLEinYDK1r/fhVlIgPQxneRxt5JtaL0OaswcJJ
 I46oA/uMmskIhDPt5WEnuzFOxcYkcuXhCrfWIBWR1xf9c0xQpZ/K3UZDBIbYbCMsMJKysIuNTRV
 r7vem68KlF3GM4QvDrU4VhMPlP311zoOufhheH80cPHHhhdeejeP0Rvmd3wqtmNvm9nndVD7OYN
 9w2gyLob7s/9Woe6nEl65wTSONtw5j/52J4bYLctpE/IMKfia2YAg5xohKSes1PmcEmlTm7DtpG
 YQNo5goBlIutMbTe1QTAOSbZYGMdp1jrongIZNSZppjlubsTEccg0RNhal0gQNUKwBMqw84W3Vt
 hyZ
X-Received: by 2002:a05:600d:10:b0:489:1b0c:8b43 with SMTP id
 5b1f17b1804b1-4891b0c8c48mr382510065e9.1.1777282934976; 
 Mon, 27 Apr 2026 02:42:14 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891941e05bsm197566675e9.36.2026.04.27.02.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:42:14 -0700 (PDT)
Message-ID: <a4fcb37b-dcc5-41fb-8390-d58dcefd08f9@linaro.org>
Date: Mon, 27 Apr 2026 11:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/84] fpu: Drop parts_div
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_div at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3185C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qXp-0006zr-Ef; Thu, 24 Apr 2025 02:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qXm-0006z9-Vw
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:58:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qXi-0001KG-5Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:58:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so5234565e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477920; x=1746082720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQNKAnb4lOwYNeGW0Zfbtx7HYcaiup+BBAigliR0L7Y=;
 b=WHjyBWY7WIZqjDJ7HtZtWqVqcbUN6WMRqeFNHBg310+oz5wkGAbN9gMe0PaJcniq1K
 TX03CPsGIXOLd3UhkiR8/wtko6d4h/IytLM+wkq5nS5GyHRL/QqPuV1PekysjR8sP/FG
 JiSEsc5BA49Ul8iS4M8soNjV/49qLxDNtHjecOPSce9NRUcfPRZtqRkyEhRpPnaeo3AJ
 SzY4w7gGmBhTeXcXFVW2fyDj8xWEEXsmSH0vLtvzc2Fyo8yhrH2MGgqPKpXFSipXuDpG
 Bom03ncpdZu4PZL/qZiZLCQ+71LUVXAtZn0YPAKWdpGkR5MH56P8prGWWK6N8MEZScse
 5ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477920; x=1746082720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQNKAnb4lOwYNeGW0Zfbtx7HYcaiup+BBAigliR0L7Y=;
 b=KaBM/ENREI9/lS9AnT449QWSYdB8lo95RTkV8DzoIMDdBR9ztRzVwx49Xuso6ETj97
 QZJk+y1wfr7NcnGKXDs9Or1yqXuM9/ZZv+2awMQ0Ubyh+EBc+HZKYphmiCXuZxGFDJYW
 6IKaEePNp5vBQJvqBnxuIpJ+Yx6Et2TcOGsAlzZ5SnfGaGu0Q7+Q/jKfvPFJWvFYHMw/
 TrQpmG6y9X9Iq78QcMyLlCI6GkegLTG0jWWXpIdew36tdNNCrqs7B2ZWBuOTJFVOplRU
 lHCukrs922fmBPGRvDZ5HhkwbX5Yo3vOkgbtiJGvaJSziMjMotyL/ytY2swtFjjef30G
 /4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSh3nZgLwOMag51UH5Rzlg0fEhXPNLXIMIIyvwdHgTjJIN9I15LwtW6++zB4AleL9yN5/F58KQiQY+@nongnu.org
X-Gm-Message-State: AOJu0Yx+oYgWXgh62qGejPaH+G3wskQ3RnSx1oxonbOBEIiOI+9WIQ8S
 CSPdEYtoel6n9dMgTjDYfgcvSUZGQ3JLFUe3kmGeiaeiF+O8/3dcmwba19Qdir1sxvoxv3xn41R
 O
X-Gm-Gg: ASbGnctHMWr5cOmG3cHIQl5ULBT34LbOancyKg/FUOYTqbE72+uwqcUn++Foa20yUXa
 R/BpssyIdLnSjATU5fURW1E5VrwJOh7j1difS34a3HpsgghShDRsDe9GArJoTKKe7sj+GTsE/SE
 3LZ2YWGW4VNlvX1pRHNNF81wN5Z6+DISre9a1sw+mTelvz0a/7UR6dLpbYnZqCntbGRwM/FS7iV
 ZFvI0SPlvNwezfEPWDAQkxtSOTdbSKkhxdAsdugurzeP86htdytvrGeMLEARb5SnQlRQei9kfNC
 Rjy1sim+5NwdAuFjYNNf0GwDSojBNZISWErUlDj8SplAdAgVovVx6EZ7fopxx25J7+6X+Bqj9WX
 PmjoR5vpizMkJtQ==
X-Google-Smtp-Source: AGHT+IHclSqlTisdotWfMzFCK6ifIVpaR3xseGBKFLpXwFcf4QP81cxW/HFxesrsnLn6qvi+5emo2Q==
X-Received: by 2002:a5d:5f46:0:b0:391:2d61:4561 with SMTP id
 ffacd0b85a97d-3a06cf4ec4bmr974452f8f.6.1745477920251; 
 Wed, 23 Apr 2025 23:58:40 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d532dfesm1052671f8f.63.2025.04.23.23.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:58:39 -0700 (PDT)
Message-ID: <78ccb323-b373-4b19-9ca6-bfd475e72317@linaro.org>
Date: Thu, 24 Apr 2025 08:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range_fast
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-7-richard.henderson@linaro.org>
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

On 24/4/25 03:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 5 ++---
>   accel/tcg/cputlb.c      | 2 +-
>   accel/tcg/tb-maint.c    | 4 ++--
>   3 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



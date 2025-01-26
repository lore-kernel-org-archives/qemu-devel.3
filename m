Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CEC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcASF-0004Ur-KB; Sun, 26 Jan 2025 16:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcASF-0004Uj-1A
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:46:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcASB-0004Kd-2C
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:46:06 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso62426815ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737927961; x=1738532761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPoJQyk530J6vTQqFzOirqdAamgtlOOf/rWtoirtLyM=;
 b=KmZtAV8eY2jZ3U9Xhvrf5l6sjxhRWNrmO5QitCvJFDgEiP5hsJm2wBVMl7NFtk/75N
 IMCXs1qLFCWHU7plYv1afIiZ7nT0BNbzOYgEqSXOBSwrofmblJrD6gwHCLRIMpDW8b1O
 vrEUaRvIsJOGHjsJ6fHHgTrZ93jUrcq2RlBTdii6NcSrfiUfgAuPh/LlsE8H+hP2SrpY
 +LGC5G3qjvWKpkt4S78aunUGx6uFKZCQ2hptV7TaofCkFBIHfq1/O/2ynTYeVnHSimgs
 RF9uATIgqE4H+x5HGCHIupyfQQt1VRbxNIb7w69flEn99aH0plMgVg67ba/BzvjfENAo
 pt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737927961; x=1738532761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uPoJQyk530J6vTQqFzOirqdAamgtlOOf/rWtoirtLyM=;
 b=eEZ+QHDlgpvdzkRlQTUkCVgf13+vnloK9OwAe1kcvMfGmgqTEN0yzDjUveb0Gz/bFh
 NWU2MjhQSvsVkW0snZni/EE9/NJo/95gvwr+V6xq7MSI9G+3g9XwoWJ+QrO/FIIuJb8/
 nqdGEiMIL5L9HYWp1n/uQzOnCkMVVagJy81zQzSz/E+Hy4NmeeYfay1wiD5DHFT51bpJ
 aVxi3qqHDbbhN2uMtgFBJmhKkIsI99dskSyQGff46n0mvSF+wsxX9vt0Lv0SxNAYsfEn
 N0C5u1OQC3b2whyxbAceMn4hqZ51BbiOOew2NCNv/tchyKjQ/RDnRcVl5blMi3E5FGap
 zv4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+5h89z97f6oBjdkZiSSLdJD/oOF0xP2h8AEIW5mfi3KC7ZGS1dDy6+Meyqv1Ag0/rFOPXwqHUhFxq@nongnu.org
X-Gm-Message-State: AOJu0Yyx85vfD8Bn10+ZYuzEMsCD7HZ3nASQRGSu9K1ZW+TZZTdoCAPx
 D42rIta0ziwA9HHOXF9VLHHubYou0ju8V+AXPSw4IAxSYUJwic4nM+gggMDekjY=
X-Gm-Gg: ASbGncvc3VKW+PhGphVWbxHqS+1Bm2oD9BUTjASewGUveua4ay0ZUmMIvKNJpAKBg0L
 wEM7/lOWTNJh2FUMVrESre4fsLiMZ2i6wlsEdM2DVP9PZmAfqn94dEwumCL/chq6edT9FwXAiVL
 Dl2GlkaBSvuzqDjyt0O5qzczDDzx449ZpGEs4iv/Y+KzK6RJR1EixUd3QtZC/dmIDo7Kdtj11RG
 Yydl7GZJ/XiDzQpE15wX1agDixktsr2n6MESmVAIe13MrxO0hy9kZpR6Vg8p0qkaPZ07f/nbvqy
 np+cuszKgwMxNuk33FGdu7kJqCaVARgdbpyHE2fxrENroFM=
X-Google-Smtp-Source: AGHT+IGpNkf0RduJa2LMPEKj9eAXSpU3uaUMm6OAYVg7O04SUoKj9GmVIBN+xWIIUumgZQgHH95FCg==
X-Received: by 2002:a05:6a00:84f:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-72dafaf8ab3mr63763657b3a.24.1737927961386; 
 Sun, 26 Jan 2025 13:46:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b30b0sm5820903b3a.55.2025.01.26.13.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:46:00 -0800 (PST)
Message-ID: <6c1aebb2-0abb-418a-b1be-9f6b303cacec@linaro.org>
Date: Sun, 26 Jan 2025 13:45:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] hw/sysbus: Declare QOM types using DEFINE_TYPES()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/sysbus.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


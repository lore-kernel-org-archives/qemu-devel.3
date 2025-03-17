Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08566C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAD2-0005Dp-6T; Mon, 17 Mar 2025 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuACt-0005CX-EO
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:08:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuACq-0003pn-CV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:08:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so12063405e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742216914; x=1742821714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zW5ILPwnSPp5y0jGrA0j3V5RWYx5pvXEPdAKsHiM0jw=;
 b=hAi5GLm6tu6fIjWnNCdPSQls8WfUSophy4x7iNwpGsun8UFuRoq0CGNMJJXOypSTIJ
 IWDWG9nVAsajEAZ/kkD+KxHI+geGKdXJFKkXHhdlpeg14CTu0pGFhqGY34Oecq3Nzm1D
 zdthBIOs+fBUIOFT9gOqhI4u6RC010NfRgwyrZvrIXbI/2mEn39g9bsZOjDU5ULjlW+A
 uYjuORPuFC9txxHq9R3Ye3zoWDQY3RCkTnf+vZKLXMw6+rtZcFkHVh+2Nm6Gtceq2sYb
 qN1p7iSJFMDWy31PO/+O9DgXafG/ymdXkOBt0CM4cgz+8f7jqMDum2YHluT6Zln5so2X
 1Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742216914; x=1742821714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zW5ILPwnSPp5y0jGrA0j3V5RWYx5pvXEPdAKsHiM0jw=;
 b=id2TE441vcZmGaLA88coUGAuJRDxjdPAbQ0+VjEOY1q6RMjNW7V4OuGG2VvLn5SBH2
 1YBntXzNVfc9BcidHZHaKDyv+e3h5UOl0ECt8+ApWWXr9tRoZcjpSxMXv8o3xdojem4N
 EVQVIeR4aNfcr/RHWv8a16hGJR2nkD/mb1iPmvl3iwg9iMEQPry2DoxmsAUVJks8FhLY
 QC95dksT/MDoJgDaRvC0DDkjV6jGF4HRX2N7u47cjsolrRSkDENsgCLj1Cvr4FWgdVc+
 xss8yn4VG5DIKp0uGGzb/fVV2ZR74gyQ17lbUii7uwhretjg+7R+Mhvh2LLVNWADtCN2
 tOiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3lZ5SkqQTT4VKPkYPLjBOkyNisMZSWROUUSSAzemCW494ofnP0t2qMulAIkhGqutS0HZBBuX5vpHV@nongnu.org
X-Gm-Message-State: AOJu0YwJjtSyvamAP82W3zRtBXDD3z777Os/tGy4re9g6U/2bx1fzbWo
 +ECZe7UZwyg1997SfHEndKLKe0f0SD7GDJOFQ4B4W00yaKEWCMzD9tZnXeDX7Jo=
X-Gm-Gg: ASbGncsBtOQgY68r9SVfKEB/EF15NAXpgu/AjRFggU15BtBBgc0iA9cswGXZkq5Uy1T
 ovYWxK5yYPPJFU/Y+PmMkVtG068G/HL/zYXwcVcd/YpdQt/dJUc9lrvTQGV2N/yzKT4Dg3SkmSe
 AlzjSn8JFbCwtizdy1IVofgdggnoeFD4yVBxzycVRsYhpPaedhrp2L57BsmoDZpJ7Jq+5M2rBaa
 Nzp35tTnzOe50HC9IXXa8ldIA80lCr/u5qYts/0AwtC12rAI9ej7eD5eIRss7sAEkx+y50g47KU
 8FA+qhw+WWx9VS4wMx9xDgeCd37oCtuA2jQQaf3HZ2Z0y+YXzgUNXHf/Sj+YifyR4Bv9lIZoQ0q
 2TD1b9x8noY4C
X-Google-Smtp-Source: AGHT+IE++mwj28Qpa4jqFts362H2VOpBasiy/SGomPXJx5aD4SKsnsI1ux3FYtyCr/CEx+0fQAxumQ==
X-Received: by 2002:a05:600c:17d1:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-43d180acf99mr165699735e9.10.1742216914551; 
 Mon, 17 Mar 2025 06:08:34 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffbcf1dsm104025995e9.13.2025.03.17.06.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:08:34 -0700 (PDT)
Message-ID: <efa36fe9-d0c3-457c-a1f5-3eccb1c8f80b@linaro.org>
Date: Mon, 17 Mar 2025 14:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/amigaone: Constify default_env
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20250314200145.08E0F4E6067@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314200145.08E0F4E6067@zero.eik.bme.hu>
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

On 14/3/25 21:01, BALATON Zoltan wrote:
> The variable holding default env is not supposed to be written.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/amigaone.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



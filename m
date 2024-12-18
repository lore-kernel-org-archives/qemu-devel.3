Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E5E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuPy-0001Kq-Kk; Wed, 18 Dec 2024 08:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuPo-0001KH-8F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:48:41 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuPl-0007i3-TJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:48:39 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725ecc42d43so5543551b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529716; x=1735134516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08/1oHa/JIB/SXnUR5X8Xzoeva10diDLh8BqkEyE6Is=;
 b=V7osWQVh8voULSiGqWcAUXez004W4U8CD9MNI8KnnvCQBbog8uPurcoryQLZEnbX0i
 HGl/WKqi0xhI4xqftnu4W0V4hHrTfsb9nBoJ0uExx1Yirf6nEcNG8PcgKWfYwcWeIPBu
 StfWJuDqxBpsgMI6RryOCPwTR8D6abc/DlSzyIiukWkJsRIxmS/yI7tswvbEBrmG4BlQ
 OSItDTy6P0rdBe7FtZ+QPxpiDLkq3M4ZJ23SbUOi3wp2vSBidZBnyJhNiWALUeX2ITG9
 YBSQYqXSXx9PZaieGbAvPt5zcbeXxn9vbfAvZw768KyBjXm6GG+elz9Bsi2yJ+UGgUXS
 PwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529716; x=1735134516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08/1oHa/JIB/SXnUR5X8Xzoeva10diDLh8BqkEyE6Is=;
 b=bZFnZRe91S9c6+iGLHBTW9pQWac6UY2LHB2EOC+I4cXLhYH2UehtuLUk4J05eqkfxE
 b92AWzhZM+mxSaiRrMfWZ35F+4iQJK6TgysvPzIKD1wBK2E3BE1w8AFvZJowVRoHrUJJ
 uYVS0vFMfAYfJr4CuhJ/7E9D8U3Ee/y+ipfBNdktRPxyRigeBlS/srdEotlQtK4W7at6
 4Yy52bTBrZQvuLhyKm0urvdwklLXTR11IL66N+EJhRNvKmYyrWEc9GwfJrlsh/nP8bgc
 1RQ12His24hGSl8UyGvOwihlPzcHLFRPOAkK2mSJLf0dR08XQqYKM5Wvw5UWhbCq9xEJ
 +mBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdPT/GDzVYWf8MB/XIkDSrA15HNTbQFTeYW2DabJi3CTfZ7SddVypb1ZnQMBiLbVSZ0MaCDGaaCpHL@nongnu.org
X-Gm-Message-State: AOJu0Yw8EPVAXfJnEVHj8mKVDIbqY3gNCowdMZ2IH3vEUyQCkVlmbYFh
 jl2Cz39CmH2076r22L53V/hj593ygfzPTapLVVmvfxqhczFAX3U3hw2Tv7Opg70=
X-Gm-Gg: ASbGncuxkIBKDRIjSVnnjzdzwOK6hRH0xZEZH+Rl1XMvVKp6aGI6ZYm74l3ZbmAgb2T
 ln9+z5WCoG9RL9SeiMvCX5vfx+9q1lOsb4hTmy5NHsjPb3Jpq7QBaaxfL8BtrMqXkuKq5FzLcRJ
 bf0Pr2iIwohnLI3FEB62G4Ac0iyIs+tbm3Wyj19pZRI4CzaJMbe0Xm+2HkDAu3+cVvDt+6h3C0K
 jdeh+uhbWIydfOwM/ZLT2llgO+qtJJpgkd300FQsVe8d0GFbQ+0gTdLplbMm4efnzCZ172G
X-Google-Smtp-Source: AGHT+IHI428kWpAtGjAnuQVA9MpgEuKs8et3YHo036CcWnL+GPO72zqAC4rEwWDe5e5g8T+tILnCgw==
X-Received: by 2002:a05:6a20:748f:b0:1db:ff76:99d7 with SMTP id
 adf61e73a8af0-1e5b48891bemr5588088637.35.1734529716420; 
 Wed, 18 Dec 2024 05:48:36 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-729187601f0sm8517736b3a.0.2024.12.18.05.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:48:36 -0800 (PST)
Message-ID: <5b4ad875-d0ca-41f1-9de9-86debfa49c2c@linaro.org>
Date: Wed, 18 Dec 2024 14:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/24] hw/tricore: Remove empty Property lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42c.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/tricore/tc27x_soc.c          | 5 -----
>   hw/tricore/tricore_testdevice.c | 5 -----
>   2 files changed, 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



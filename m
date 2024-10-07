Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB44DCED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvCC-0008SM-Ol; Mon, 07 Oct 2024 17:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBx-00088f-3n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:23:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBv-0001on-Fx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:22:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso37956215ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336174; x=1728940974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JQrX4FJYwBpWHhPKiJcQ2GuPdkcdNLrxWDBad3wr5hk=;
 b=LPPiLOTIXMEsLenu7JQ6EQlJm/37PwXZ1yP9RE4+G8Tcw3/Hf/hyuewEQyopxzVtm5
 WQQemdJy73RE3LxplPc7tGjklZXHdbAf4hrEtBWOdH9y0pt1ZzHCBnZkWiJiEWza0cgY
 1hGqOcG7f/0WwcwTePlIVX+loomKmVeFEbYqGcyP0Bv7hR7Ii21l9SRDr90DnBAZ2/hR
 VMBIWKJwV1JeecR3FUXhsImSj3yGdQSGAoLVi3fPJxozrQ3FqMcs5004rhwrzbJit0LW
 xV1U/vJFoei5TU4g60NG2Fl6zRP+kr9/i2lBLmDD2dpWyzMSwqz39F5MjQr/VIfaIUOD
 c2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336174; x=1728940974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQrX4FJYwBpWHhPKiJcQ2GuPdkcdNLrxWDBad3wr5hk=;
 b=V294lCzcAyhtkdYQLVZXYu+3tdf1cxt11RXMoNaNTAhKKINtDY/ng47Iy9WdJMCke2
 5mH7YnKBIAcu1lZjTqPxINpFwEul7FOsFKSSpv3ED4a3ehRgZH4r/cxXZgN8UvKdH90p
 DZ19dPt9rf9SqXYPnNx1jFPOLAWAwvkf1ZDC9yxyH1DhZTF/jCFFOB8oLvynCypx6fqp
 JXbuNGLB/GZrenULNu4H3lqdoqd8GvbWQosLGIjWpBrh/t2CfZDASbVoIMGXkLnUVfK0
 vXTnQsHQcb8ljoA0+69ePHP+2TpCZ7dYWmWSe9J536hNO8CvkGGdMSSuyb1V16ByiD1O
 LgyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUoFBlqIcf16lYOLI26UAwPg+aLFntr4yAEJIb/WQrsbO7qMaRMl8zTB0eGUBWR+REWvIHSQX+pSZ4@nongnu.org
X-Gm-Message-State: AOJu0Yxo8BcjsBwwNQgHFRrA/flEfeJvBCHSLyhlCE2WvnCczjhHyf7G
 wIvA4opCIlXITRrRaWNpBpRDi0wc7tbOaxKNLQKJMAoOmk7+l+hJVY4VMy4Yk7MJAd5n6bR9vFD
 L
X-Google-Smtp-Source: AGHT+IGxE2UXWL4HXQi1bHHYsm1hmlS7OM5d6LOCRdyFm+k4HWWFBQAvPvMKtZKW0dsLxu5nZ9u7pA==
X-Received: by 2002:a17:902:ea0a:b0:20b:9062:7b00 with SMTP id
 d9443c01a7336-20bfd9b0194mr214054745ad.0.1728336174109; 
 Mon, 07 Oct 2024 14:22:54 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13930e19sm43956615ad.166.2024.10.07.14.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:22:53 -0700 (PDT)
Message-ID: <16613db3-ac69-4999-8506-485416aab571@linaro.org>
Date: Mon, 7 Oct 2024 18:22:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] target/arm: Pass MemOp to get_phys_addr_lpae
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Pass the value through from get_phys_addr_nogpc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



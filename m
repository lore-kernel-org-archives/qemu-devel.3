Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21908C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvoS-0003e5-OQ; Mon, 17 Feb 2025 02:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvo2-0003bI-RV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:44:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvo1-0005ug-1u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:44:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f1e8efef5so2060277f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778279; x=1740383079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=867r24LsSfLJb9oig6KxFeGCUWJ5OJgqXtuZdGaHPeQ=;
 b=ar88ujiFuYZdYHdSb9L3x4c6KcBsD4RsARuy1So3SWm2DBl9kQjpqMnxWhGwfBf8d0
 QnLfXiaikxJLSWhl/pH1WMBNQo4UrRBFRMTUeGtoWKi/7456CjxtNoEtSWmLcuCeggQu
 kh3m39XeGSJlX3I1kKkQgipoh88yFD7LmO6YEfXHodyeFd4tHPKRxdwjx8b92qvYoDXO
 kybbBxkOTtA5Pq0OlnBXW/CRHqSOmo2Ov2j7gKlY4gowL/FAy1VEMFHhAeAeBAsG12n7
 Jy+S/kjlZMjnIbzX6GDZd1mGkEmWUwXEZNlOpO18+5dW/gDou2tvouEZIRl2BvUUzPiy
 Yv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778279; x=1740383079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=867r24LsSfLJb9oig6KxFeGCUWJ5OJgqXtuZdGaHPeQ=;
 b=moaM2QgkUtk6D2A9Y3AIlCqs6yY39IydeMN62xjftAJhdaW3XpJ8KmKazBG096xds0
 K/OmIJMrW4ea45xtsdJGihhVFgG5jysi+hs3fGmq/tUwFTBjTaDzK/fH8VOC24pF53b4
 ZvM9Q0C8V1ZUV5ZiL8bzocdsBhbhadM/oGOYcpJU7s6pT6Tzr/AhQ1+wTDUp/BBmCn/+
 UORxF38K19hCbVoq6NH5EG1HoO2onlNQm1jMQHdXP473TFQdeXbbWUQO7xPLAB9wDRsd
 2Xk23rshG91rL/YBgRoxga7qgBoJSl7n2cVCd61gGqFJmx74jlVFxiFZVpssYSytcFZ0
 tRzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq2JpqJLtfO+xHdLWQmBPO3cBaZGvp3CAb7ENiBVHRGprLveS3z3aP1NbqSIfwGMV6gordV7ZwkgPI@nongnu.org
X-Gm-Message-State: AOJu0YzC/ECO+BM56/o4LBCq0GU/IyHuFw8ZS5tNpZrszsYZOo/mt5E5
 pm/jKV+jp2WGfy2Gk7969Ixr20x3oJMMuw8jx7d3f+QGM+aO/EjGNB7ExHk5g1PG3slat7Wt4/d
 4
X-Gm-Gg: ASbGncuA94dGhqkzje7Evc/waL03e4Ctwbg6xdAoJuSr+cU4jxomArI/4cLQGskPnWd
 r+tV+BMVv/NvZ+LKtpnIaZV9WWHP6B7yYmhWD7hgiUUTxPzdMe6zyE24urrjOnZAfmO7At86ufF
 7HhtXLOpzGd2b6OT8Kfe+Y6ZEkdca0oFOo4X9mS3//94/2QomNR2l3MkvrjF01OkuuPw4tg5ChB
 vqlDBTXi2aolzTK538pVFprl7V/A4PHyuokhMbThH2P28EKvM0cFHle42hga+2ljZfdT9aTvqvw
 zr6Lfl2NRDk8bvv/CTI4SXc5CFsfxpZ23JY=
X-Google-Smtp-Source: AGHT+IFR9FVul6liQjGCadi6oPpoth2JEyeHBGiPgX2h1sdqx8i5USaP9UQkA6+jcvhgKjpfl+v0NQ==
X-Received: by 2002:a5d:526f:0:b0:38d:dcbe:91f2 with SMTP id
 ffacd0b85a97d-38f33f58e43mr6850904f8f.54.1739778279162; 
 Sun, 16 Feb 2025 23:44:39 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4491sm11256093f8f.7.2025.02.16.23.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:44:38 -0800 (PST)
Message-ID: <2d433574-33aa-4d22-a197-a49e3d5b506b@linaro.org>
Date: Mon, 17 Feb 2025 08:44:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 035/162] tcg: Merge INDEX_op_mul_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-36-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  4 ++--
>   tcg/tcg-op.c             | 12 ++++++------
>   tcg/tcg.c                | 14 ++++++--------
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 19 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



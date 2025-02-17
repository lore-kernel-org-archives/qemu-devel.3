Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32616C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvub-0006IB-5O; Mon, 17 Feb 2025 02:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvuY-0006Hp-68
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:51:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvuW-0006xA-9U
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:51:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so2750605e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778682; x=1740383482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+SrlBZ2wDSgYQ5gTV6FJMYkJWBDMbfNYPQHbghYFvA=;
 b=khC8rZKx4MToDdYrHDg52PXKgVQ0u24S0Qu4fxOvOEpKR0UvKE0pcPBNjdHpTcbNkN
 +Wr0hDAUp3ZU4nDsdSHPp57D9Ql9OX4WwefLHbPTR1vRkDIH25zP1qQVG19Banelez/Q
 C/HBa5Zt6Vs6CICiitwplo+t1CBpwPtugQAx4gUv8BoEqvF+Av6eLHS0Wyz9Rj1qpL/T
 znt2COVRcMO2F0pw//gb2Xn9e9KMzBN63AI2SHgzo74fWBhq9ev56fxZNWxT9BPeg3NM
 9oHdhtdfGPJ2wd5DnWbmR0d5TK+4CtQ2ZKeJxgpy/ObrTbIpmKoa/7Qvc/BsAyCCMklJ
 MfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778682; x=1740383482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+SrlBZ2wDSgYQ5gTV6FJMYkJWBDMbfNYPQHbghYFvA=;
 b=cm4P36NRmcEsR+xhgNUxvcrE1qjElnybgP/C7N3dE2+YpBIKURqMFlDH1IfKI2Ap4Z
 RSQo5wMhikLUhaFqNJ87ZRL2uPGzuqyi5oD8vzkClmxjLWT0HehR+x9Q6rar9k396y2R
 77DcZJtTgU4PpuHbACgJ/Z6R35uox64helkX9e+XBG5dp6GmyL+SrDl5fDJ+/KFD5Pd9
 TYg0nuZzVaLEJrhF/Loxlxc5MPJxAJxhGt+GM6qeiFM+BOZ2623cPv8ftEgf/sgpd/8S
 KeYy5CgIMLwX2h8qumNv2IwO+tbLDrimePiAFzWRm1U1aeEWToamVcI6ujiAb3tKa4Q3
 BH5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfW9fYH2kSW60r23nk/ygAFFtx+1Rds6w+3H6bBJKkRtWkQd22RtTDEuVXOTme4yrjfQTGvkzGdDTH@nongnu.org
X-Gm-Message-State: AOJu0YwfWJjmdH2HlgwFO6zZ52deJA9Zf32EH+FKcRaB2dVqmnfuk2Fb
 R8opJeLIHgirCt5hX6JFerxjP7tIXSvPuPqSAYCqG6okKFE5XsY1TPSgxDtck/261hmQ2uMRp3G
 x
X-Gm-Gg: ASbGnctQvAH+rmJDbaNbTpD9XTFgUCVU4jngZ1XfFVTDx+/eqnFZzug1b/Sx1D02L0x
 Li5EmfQlBxsfo8CifGyV6F6Xu4d69XwbotuICHcCVq3E5epMhQGuDiawDav+5hBlmJB34AbsqHm
 KbTzlWs+o7bMWlVXxXFoi1ATX8VgUyQmI+IgwR7iXKQ5ovxQuz0FCUBdrAJecU5T/ANfcw2/icL
 hTjaG+OLDcxGk+bQoU/XtjxONm9PLqoV9/oiWO8RmdtPZvZFY2k8wVxk+MQJmilv/gZLIx7pjIv
 aKMvLhsJSAEm1UNXaLNvys2EWSjkCXUkGv4=
X-Google-Smtp-Source: AGHT+IFhc77D92kiCoijAf81O3TVmLCV13amoJQVlOHW1pxTpx5+wU4VgpyZOsEDj7v4nAZJ9qAMxA==
X-Received: by 2002:a05:600c:4e8d:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-4396e7d3b00mr72220355e9.0.1739778682017; 
 Sun, 16 Feb 2025 23:51:22 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396b5267eesm55692915e9.0.2025.02.16.23.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:51:21 -0800 (PST)
Message-ID: <0455bdcb-e724-4296-b592-ad8375050ade@linaro.org>
Date: Mon, 17 Feb 2025 08:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 051/162] tcg: Merge INDEX_op_remu_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-52-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
>   include/tcg/tcg-opc.h    | 5 +----
>   tcg/optimize.c           | 9 +++++----
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 6 ++----
>   tcg/tci.c                | 4 ++--
>   docs/devel/tcg-ops.rst   | 2 +-
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 16 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



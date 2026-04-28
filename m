Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C98FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbdO-0001ge-US; Tue, 28 Apr 2026 02:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdG-0001YC-Ks
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbdE-0007iC-8f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:09:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so64656985e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356555; x=1777961355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rtYH4PQyyJnj1p7aRo0kfTr9/95pcoWQx2j9Q6QiHf4=;
 b=uERn1kDp8/kidepcXHcsOkScNGI+EsEMyAg5wtAyMLxvLoqdp4Q3Xv9KfWksypPAwc
 VH6j9ROldmQUj9TZDrrJnnWSc9XlTY6RjeV4GMixe6C1bYb5PmGCyyL8t+0+9gAH/LhY
 h+u16Y83us80WqL9oqEHaTRr9JlUaFLfctQbBQ5fdhRUur6Kd6grdw2dZTjHhfmwt1kG
 7dzwmDdBmWD7vPESe5phsi0+4iartzChSkqEXdSOeBig1PHOhO/+oy1tDIlEgNbukYT4
 IloK5ZkKr22IDDYLzdmmuBULZF7ytESxUag0AmkyliKvPXufFV1DqifqUyQHjOe9bmCO
 +Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356555; x=1777961355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtYH4PQyyJnj1p7aRo0kfTr9/95pcoWQx2j9Q6QiHf4=;
 b=cNMKCcehD5qUs1VNYOkkd1iRt41yjXDAh726bnQjL0g0ZbadhfwdoPjgyttz4Lv+vg
 VVrAy5p/DGyAPf6k8cD/UwdzKTb76TzlfVayRFb1D7MLpeUUuUWQpf/lrjgQBcer+JZ4
 Oe1drkm4XWi5pmJN5glTb6sq/9itdG3kU6/kM0dfWO15tQKnEL+tJwpkD2Fi1aN7jqkr
 CiMmrEZDb9IpT37gkZaaEVXk0yWGmJwbji1x0AjzIa5onX1M1iO42CbB9RaR/mh5nkmd
 ZtVpsg80XS26Qyemm05UHMj6bKXkjlgYSnx6klSJgVx2flq8EKcbyTpKl1lfQhKOUIii
 oRWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2kmHVa5p+BKC5FKoDZ8l5UsfqlCIGt30tbazheQWkNIRAIoqhxwhcKMICu/rLb+nhNefs03rgWZE5@nongnu.org
X-Gm-Message-State: AOJu0Yy1uS/3kmMyjfj2tBv5x+N7T7MJi80/eMzE8C0gH1pokWtoOcAu
 7exWq3xZr8b9safy3KvwcEVcr7z5D1cHTgCBAMmXV9Sn0PmU4FVK+257txnnzcTY8m0=
X-Gm-Gg: AeBDievG6I3G5uyag4QR0iihl6KKNNDB7C0c4k3PrsbGb5RVD7iqXABMqVhK0qqWOmf
 ogQ6OZRTEwTOO2bkeK7ZXPexjJJKfoPnTlnVqAoIokQa8moy33bHCTEuEqXOFMtQqwVCrFQ3JON
 ES3Hvszt575KX/q0SR9HkTqf1wQ6kstVC3nUJPedSZvTFOr//ydyt9THDZYYhnSbB9scP7q0iRD
 WHdr+QXFuYVTs96eRTOuiYldhm6CmsEnfzRdUF0aXfGJvdP+z+xgiVckoo69G2MuG77CMjlKS4u
 NwBVS45BjgOkTKAPwe7/khJA+GuY52BQC1cp4E0s18c9e+2aeP1puypdnLFlDmPxBsKc7J2k7Ax
 VOTKLwkrKGB6oj1XSJNfj17AvzUW2TaIVoNrKo52lmPhy/JS74A88uO83f76Dgva1LAie1aL1iA
 5SySGnPhFxktWRIRP4+nWJ0klEYXX600xHHQcekQ7QfUIkaSuM4haLOyGth54Zi2xBanrZ5FHdG
 Zk8
X-Received: by 2002:a05:600c:3b13:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-48a77add9cemr23514545e9.1.1777356554765; 
 Mon, 27 Apr 2026 23:09:14 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f58bsm3557359f8f.12.2026.04.27.23.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:09:14 -0700 (PDT)
Message-ID: <7f5bf75d-79c8-4186-a534-bd8ec116ea0d@linaro.org>
Date: Tue, 28 Apr 2026 08:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/84] fpu: Inline float8_e4m3_pack_raw to single caller
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-50-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


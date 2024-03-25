Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E9C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropAi-0002Py-1N; Mon, 25 Mar 2024 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropAf-0002Pg-6d
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:35:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropAa-0008VL-GA
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:35:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29dee60302fso3864115a91.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711391738; x=1711996538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spMgc84ydbHqPKVJ22/rKjwC2ETJwUqU6MFV6npwYJo=;
 b=WgOVXAPGk+1HWCKwaCN1MvwDfpsTGDiqeSlXEkdfT34pJcfx6Lf1mIYZ/2+oD9cI1q
 0PEidAt8yLEGgYk5/9o7zCUQObo15Hf/KyerhpMjiZXYYlmXxKhIOih6kiytXygR2d1T
 LleKlA8+ckSwCosuuhtBFu+BzKAtN79GowX71WNegPpxj1oirDuUDoCrjVDECPUnj/cc
 kRSDO6JdbNFIPN7/f0iORkW96rmISisuXmqup79BHQCoOzWDPlG17PLL/4TafAMBSMle
 dvmEF6200ORabf6Vy9Q9yC205fbUEdtft+aH58ywDYeO0IfYt7HlbOnqC1QWGeYICkDT
 490Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711391738; x=1711996538;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spMgc84ydbHqPKVJ22/rKjwC2ETJwUqU6MFV6npwYJo=;
 b=PQZc/3UNO5GohfVxVGkyK9RBS57rBo4xDnYZ460TNOVlOTSlzu/xERxmT/vUy2RBIw
 sLNaRgd0oEESxK08+VijOlFvbVf1lser4X4A7zZKVNUzGMwh73z12VX49VgRgg3X0okr
 dUHYCeJ+2BsGxVrAczkD5Ub1ZW7azYRL6xZeqsiqw4J7blcXPg8GCvaQJAmD/svgo1UH
 heOIfxnwPk426+56S61KRN9ivv2XIybiAFUH5iyR7/+Q+RoTB9/mX070RqVhJXpUYRBa
 B4+Z5w8+COGObWkidDVMvyRSo/7Q2Nh4GwpUSwtlqS+vCxjw+cK04y/PDyGHGEppzrrs
 pfMw==
X-Gm-Message-State: AOJu0Yw7ovbLWEEig2WwT90jWTmfTFuvZkeG4VPcDFXtMpM9Xa2SppYq
 n75BPlCUBwRZmMAUmugxk4WrSsDmwOPaHwb1ArvSvlUvx4TM44xivAyL8NxZU1k=
X-Google-Smtp-Source: AGHT+IGoXj1kh0mT074X34vnAiXUsKOkJ4dE3EFJOOO2KnoKqHKHSBXGgonFIGUYcDnXw2HRjVHy3w==
X-Received: by 2002:a17:90a:86c6:b0:2a0:76b1:896 with SMTP id
 y6-20020a17090a86c600b002a076b10896mr3588923pjv.12.1711391738584; 
 Mon, 25 Mar 2024 11:35:38 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 oh11-20020a17090b3a4b00b002a01802565bsm6797461pjb.57.2024.03.25.11.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:35:38 -0700 (PDT)
Message-ID: <88659040-6476-4c8b-9f2e-2d96f07f74b0@linaro.org>
Date: Mon, 25 Mar 2024 08:35:35 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/tcg: Test shmat(NULL)
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240325153313.526888-1-iii@linux.ibm.com>
 <20240325153313.526888-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325153313.526888-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/25/24 05:07, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


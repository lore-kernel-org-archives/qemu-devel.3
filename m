Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DECC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GFt-00022d-S9; Tue, 22 Apr 2025 12:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GFr-0001tC-0C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:13:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GFp-0006Ay-7x
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:13:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4023332f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745338427; x=1745943227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7bZKglEKKOHON+U3tgpwoOeh3Zh4tGU0Ctzw/wfUfw=;
 b=xpvXm2uNil1hYMhgMefx+PkK9t+LqNS1AQZDLjw31ZGWwx2m1eZ0QD++RqYEVYaT9B
 YlZSSe5x1/4vUS1aWaKQqTgxKJlaycpeCkMu3Zgu1lFLI9XD+bpZaqHQ7jcs7T/8A78r
 0PXL+IZQqK8TXLzv1N4dYPrPzpTf1A/EfTcnNgbqtc4FGp6xjQmSgxwJq6vlC8vIy+9l
 5R5Tt/dsWoIkZCHnH01pBs8RQlpjhYyg7rI6JrKjfie8Hic0MxifywM29seYtzkDpfLJ
 yFamy4ypMmYL/ETub1m8gJf3DS0FLP0po6dKmwkRtunePpVmsCa0DOebTtq5pLFr8sLD
 1B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745338427; x=1745943227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7bZKglEKKOHON+U3tgpwoOeh3Zh4tGU0Ctzw/wfUfw=;
 b=rf7w8G3KRJQhrRLT4op/gvwzATjh6F5LwYq1neegaT6Y9PwiXCsF2vm0AUZ+nr4gj9
 xWGvJYMhLyMrHU9v/VQW7q+aYlS7MO/eNtkpcO74E5HEO26pPEdyW1oWMiVMefReO2hD
 VLdKvk7t/Wz4s0NqewOSvoJhuouIewa2LaiKFaJmGJX7uaDcq6fDMTf1v3JDHCn+ocCL
 vm0iGm15KyUIT4OceA4b7H0z38qBFHAm8TTttdaz9diW6aBSuoCQreKlpQbkqNHdKJ7g
 xSI8aikFuehXwYZoVHZlSZw4Y8pf7W9DfvncPSZKgtZg/ivzTMGeKUWEtqufXtWbyac6
 4IOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmkGJ+Q3+/kw3KCsi7g540kiO/La4+9JZZbCmgjZjVz0k/ecmJzGqyn1Fgts1VoyM72V+7rdz8yd/B@nongnu.org
X-Gm-Message-State: AOJu0YyykR3uCm2QYlK5wcBZNlPobcQlNygPiT9cLstwKWMEtAqAdn50
 qdBZigrvGpGyhQG5bKlF15nVxQOim4/WnxJB5qRnMm9pM6OAK/TO+9GhrTJR9/3MbH1YlYEoDJl
 B
X-Gm-Gg: ASbGncsdUb8jVXZ/NS1OTaR3NoFpgdoHhzjrz4xNHQ9QFQj/OiNAgo596hd+qACm/C0
 t7pJaBApfkOyzvtqUunbDkKlZzblhxYrVXwBPVzpTEmgVIu0LCDT3mTCen4iiwd6YyCalySASzy
 bGtk+8/VB6+CQCjyZws3qkvwYFEvXhxVeFIWOoRgo4JeQ3pWNkoQPJhQtFPRaTaPp+tZXwbiCu4
 L/i6epsQyocl1Q1NvwRGOsPqWaI613k0YRXLHfUx/qCqf+ze1v8ljIS0epb8RUMo+0wLcnQ8LQI
 ZDX4fe5d4beShI8BnmbSTqHXov7MzEVJ55A9k8G2FdTO+bNEYu7y/1EzZVKwm0CMtLaEcPrrALa
 WfvegFBjM
X-Google-Smtp-Source: AGHT+IFICd2X8CrgjODL6vq+A8mRxORbbA4OKz2Z87RBRgVsN2m1CCXjqr56u8azd0OMyG2fy84bVQ==
X-Received: by 2002:a5d:598b:0:b0:390:e8d4:6517 with SMTP id
 ffacd0b85a97d-39efba3d0e2mr13259609f8f.21.1745338427522; 
 Tue, 22 Apr 2025 09:13:47 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4235dasm15502651f8f.9.2025.04.22.09.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:13:47 -0700 (PDT)
Message-ID: <53dd58bd-a11f-468c-a5e1-94692b1f5367@linaro.org>
Date: Tue, 22 Apr 2025 18:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 123/163] tcg: Add tcg_gen_addcio_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-124-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-124-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Create a function for performing an add with carry-in
> and producing carry out.  The carry-out result is boolean.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  4 ++
>   include/tcg/tcg-op.h        |  2 +
>   tcg/tcg-op.c                | 95 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 101 insertions(+)

Please add brief documentation in docs/devel/tcg-ops.rst.


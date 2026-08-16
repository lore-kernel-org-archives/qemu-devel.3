Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD431C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvckC-0006Sz-7D; Sun, 16 Aug 2026 11:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvcjz-0006HX-NI
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:25:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvcjw-00067h-NX
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:25:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2942814a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786893932; x=1787498732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m9Qpf9GXwsvzKNeURLdWIaMZeQ+RttPA1yPVizMSgJk=;
 b=Hic/QHMU3HYXspLxQ+19jdnF0OFATKpcKEq9YbNN7KDVa25FhYVthpDjmfOoR6CvUk
 n0nYYjhhj82/sQj4wBSjefgNePA7VLFLHYO4+K203G2Sbk2loUhVS0zxk2EfnexEYyN6
 MvK1NXXOm6GszFx+ZRXT4gM0mdGOf3Y26mBt7zTisDRHJHECxrIqLCZyxiOTv3lAeJJz
 Kcx8grhxfToX3iYjsE2F6kawFZSwcyi1uw+rYJvp87jm2JijleTvmkKzEwjf7nJL47jN
 F8P3hLz9cTH4jyrJPHBhEkdvEJiDukC0kJg08UC6e+qRyTvVrMAHz13SJfQRRpH8KHO6
 nonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786893932; x=1787498732;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9Qpf9GXwsvzKNeURLdWIaMZeQ+RttPA1yPVizMSgJk=;
 b=i8PqcmD6ftA7ajeuFfEmmgi2pVJU9My+8jydXLf4NiHWw3glr0aD5V6P+e4h794/43
 8Z5wZeRy0eo2vx7G/2VeUP+02Dzcwiw5N7e9+NJT+2wQXUBuChxzYnFROCnfUqCgSWi3
 cxgBM/IQuv7Sxevx05iwkOIwj9fSjXfYTWVeA6LrWOujYBEpOsUHiJfk8WmznigvVydV
 XBwGmomVYg4qcs1Vpp7ZKy6u+HBlfWeYt/TFfWZdW+VPkgzUVsYaQy5EZtfwIj3CKDSN
 2j/e24Oon6rAjzy7PfscBg55jpB8qBUw6PQt61TcGENLPY6ikeelZmTJVdC6ZuankF8/
 0qpw==
X-Gm-Message-State: AOJu0Yy3R8fO6xKM8w8F5pYfMB9zqOhpE9JiY1jBn9vUL+DoZBclLdRP
 uekiRp8vy2EYJxs52GR9DQoatYYbAlS5G7LfmIzbFAAezG3SiiDj1Qv/xL2Jh5n6g96lQEEWbOE
 gruZI
X-Gm-Gg: AR+sD11G/7c6l00GjnX2LiCkp74phoJZiLPd0KmnsCeRlPahwquvCdZbr86ySqh3vw0
 DjBh62Oo1nHqikTrX/v6KM5gKjNpNoCSKIyNy337d0kjrX7URCvEF0cSfiamoGjPVq+5u6eW6oG
 0y+W5fXlLBqo1N4ljAjc/HqXzqeuBodVeDiQ5JHQeBsNfgAqs8Ngr3f2zF1kKUlK2X4TqQzrrlT
 V6H8yNGtzr+zPJdjV41McdGB9GVgH4P1d3ep8hhyzU6EaSVQByrFVpFbmWubsMa154zEG8TxwI0
 9CnxsA2UmQIHrFumGzNNv+sg2ftuePld8+zLZFH5TJnga19U49mz8OFM8ko4FoVU7s/R4dnATzO
 5gCG4aN3REDZOy0H7ieyXv62+cIv85ElO7dD+8oClIgnH4TswUKg4bBAhbUylE1MmkdtjBfyOAR
 9aQjyp9W9a12jsUfR3jv+s8RT8eObK4PB5PCzt006FVpDvdWYbBMfOQtEYCI0vtZVCkxv0gf9Pa
 RKemk3sEXHHnk3NcKDjpr6i+iw1
X-Received: by 2002:a17:90b:1651:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3933e633478mr18563238a91.15.1786893931938; 
 Sun, 16 Aug 2026 08:25:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531fbc08bsm1756917a91.12.2026.08.16.08.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 08:25:31 -0700 (PDT)
Message-ID: <0ca1d5b0-775a-4069-8202-a58530339e01@linaro.org>
Date: Sun, 16 Aug 2026 08:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] target/riscv: Hoist vma check out of
 vext_set_tail_elems_1s
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com, max.chou@sifive.com, qemu-riscv@nongnu.org
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-3-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260815194549.1377505-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/15/26 12:45, Richard Henderson wrote:
> In all cases we've already extracted it in the caller.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/vector_helper.c | 35 +++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 16 deletions(-)

Bah, I'm blind: vma != vta.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D2EC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQO3-0000SK-4c; Tue, 04 Feb 2025 16:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQO0-0000SC-C3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:23:12 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQNy-0008Vt-KV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:23:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so114130f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738704188; x=1739308988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yn+lx0Ff72ivxp1p+qnbfxeJnBt8j/pOvF6+ZRbIJJI=;
 b=SS463txIZV6s+GOI6+RDAhLNrIX4ZbGQdpfSrtM74B7cIg1rRIiZElYwBArpOOrCNu
 8eSbzx1gKJlIbujTLgtR7+ahgU6+SrTEh/JlbYTiVjPFx3ACRLuosGLltU2RaZkfWYMd
 jFSDSlJg0TMrmtI9f+nV6EIVSoChlaUrvi0HMMRaQTh1Dd0tu0s4P5zE4OujfqsZ7k8B
 n/tIs8l5p3UiXzU2mp5R1FYiRmy4KRewvdTWPGxbHC/sdI2FZLYJ6BEnEkZ3ftuTUU2D
 UDhFjPSob8ECUqsEpAy+wRoToEL/OvchV3KhSL3DovXyiXsPJ3ExwP/P+zrzY5Pk7D85
 BDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738704188; x=1739308988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yn+lx0Ff72ivxp1p+qnbfxeJnBt8j/pOvF6+ZRbIJJI=;
 b=RW4xJkcBtCQvBdNsLIP297RwJz1+v31Ym/CrN0bNdG6KoDqpra24LMhoWK3nxKNDyB
 VJK5+WRn7P2tBYGJe4pArcncNd5BWw/Se8c+2oj/Un3sjYXGdSZckto/q/VVsdJAqadc
 7DLKXoPJfAkg4weDTsSs7Dkj6XrtHYJ+0+c83jUkgnkuYTOWQA7FUM+iPdERvpmxhz6a
 eEhEwFV6Etc5H82tpvEIhIZ9ZByVq78SarWACAUSXxsUy48lGoDxRxybsmqY8RcKHchN
 IQHb2A7gLlGZE2PgARg0RLSXVsfLSXYT9WA6MdEA4iIIBkR9Jnm0FVn5M9SD9c0morOQ
 PKkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdkzqez/0ApFZBQw3OOpCn0De+NaRhWmc/+ihN2yfxGczTZWDkHrhKU1r4rvsMCkmvaP0Nrl6KkYlk@nongnu.org
X-Gm-Message-State: AOJu0YyX7DKhAFcwwculjXmAyPPBNq6tjjZRWdvDsMMGrFbfMdwVsHb4
 7cgtGIoZPgEU7fYMv+6hSGg9/tOYECK/guoC2sIUQfMLJX0OYJqTRHw7VH6GYzM=
X-Gm-Gg: ASbGncvE9HfTwt3wCVxLF07cuhnotFEekKCoZQxhRwJeg821P7Bdioz2a33VsOw90zE
 meEi0L+Wfkol1GbQqZ0w9zqUrOoHD+hJ6me0fRN8UaP/ZEZuNTxjR5JNFsnMFG9PUaqAkqIiND2
 Fp/dBwGM2Df2XArguAWfCi//QWo/5ZMUyuDSE12IpQC1tS98LYFY1IK0klzIDA0dAeY+PQxE6B+
 4sJu8Tu6Z7xkpIcLALGgDDxHHAosmTIJ5UA1/ySFJrd1lO/fKkcH2EgW6aoJwHyV0hgILdkHxlw
 y7YSvst5oQ4T2o8orcLG+gfo6sXrWv5pq4XSBzrhSZL+zjbTc3h8yz/Gc1Q=
X-Google-Smtp-Source: AGHT+IGRP9ASmGxa2gIONHJIeMtoDj7oJUvBP0OJC4QP6gu30veETmQ2is+YMCAe0VEvAsK8Ub4iQQ==
X-Received: by 2002:a05:6000:4012:b0:38a:8d32:2707 with SMTP id
 ffacd0b85a97d-38da5404c5emr3942983f8f.26.1738704188204; 
 Tue, 04 Feb 2025 13:23:08 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390da712f9sm143965e9.28.2025.02.04.13.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:23:06 -0800 (PST)
Message-ID: <47873abc-2203-4911-8933-c1804abb75bc@linaro.org>
Date: Tue, 4 Feb 2025 22:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/*/xen*: Prefer QOM cast for XenLegacyDevice
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250125181343.59151-10-philmd@linaro.org>
 <20250127094129.15941-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250127094129.15941-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 27/1/25 10:41, Bernhard Beschow wrote:
> Makes the code less sensitive regarding changes in the class hierarchy which
> will be performed in the next patch.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/usb/xen-usb.c            | 6 +++---
>   hw/xen/xen-legacy-backend.c | 2 +-
>   hw/xen/xen_pvdev.c          | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



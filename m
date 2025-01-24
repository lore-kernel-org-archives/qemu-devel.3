Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8265AC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNb6-0006kk-By; Fri, 24 Jan 2025 12:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNaz-0006Z7-Tz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:35:55 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNax-0001aW-HH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:35:53 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so19608991cf.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737740150; x=1738344950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vj2bmY7ocEoFlIJW1XIP32ep602ok8GPszCadUjMCC0=;
 b=q2NfdE8WjKnllajXNWdfmj+UGrWXtdBzy/jmVavcROZSF5uLaXevueO2/UvwgPlyVP
 axJDsD6yiTSm/NDHSf/KuMGi8Pjj+bvoFbJfG6LyQE+l2TjZn+CA/KzOmo4rlKjj5dkn
 aQ4Hgy95FqpD1i3cO6sexQ/RhEt7ap6uqR9sV2CiBU1JLMB2+dD9AWfbt9JuW1OWyNPX
 Z8AHRvaBHZ9t96u2Ug0gXVllrT/xh9gjUdcvGzNkmSOxnyMII8xktrgyGakvFQScxWjM
 p83tzbihhxXwxfZU7WY2roAjnwpDnD00LJZCaJmZjhnmVIzzMbiNILnYLAUaWqEZ6R3N
 REwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737740150; x=1738344950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj2bmY7ocEoFlIJW1XIP32ep602ok8GPszCadUjMCC0=;
 b=EcMhsa1Xa/8bJX5xIPnq+gFDbL44oXeLCxpD51dxCjcVpOuMVOFYMukASpD4asw1L6
 wdew5ZUC8i/jZhvXznjzJI+bn2UYWC8bGhBfjEI4k/CJ6ftTqpO3Y6smrw3o2zJ2ymcT
 xN+70ejbm2HRqKNDkh07HuIKS60eIH0l4Zir1iyZtEB2WsvuHcwEdegPfcITF6S/spj7
 rdMrbresGg1pQ3bfx1fT4uxFmDPlksZKSQTe+k2wwchypk+YithTxj3XNUSBxnJEycSI
 5BPPlKhsuRgr52Q1hZNxTYVhp3akFl7XY2c50HIdrnQgZuwkbwQpmY1fK7oR7KbvQKQG
 Xy3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyC7akgKrSb/DNYXuHe24uIDCEetpSR02oDj3NqROMAwhrSvd9un2hcCzVVXfNEHX/k0fQRSiT+LMz@nongnu.org
X-Gm-Message-State: AOJu0Ywf57+h0KmQZiGa9lxE5BW06rTmtePcNcEbZIs9LPH3BzERHr7J
 rzX7XbXCZqjhoqRqI604YCbcZq0qXyV39VS8isVknkRNifYl6aYHALT0Mv6vaSs=
X-Gm-Gg: ASbGncthQ8E4V1JYN2dol2koWCNDbKziLITZK8OM7UsIIpntz7CqV/QL6ECstuzWRLt
 XTCaoaWTXX1oOYMhnUn3WXSw6EqUCujrNdXVOcVJQb5mBKGTy/K8hCvVuBib9c5pE2v1TxpoJeb
 6Yy/qM6T77RwfHXHA/TX75FUzFlzXjHtnIOrDDCHBgkzE597gb0Sl3o0hO8/3lLAlFXpShZzMOM
 4nhzFb8j+Jw8GJrMNVmMWVqW/2G74r25LpalcIjVNNn4xZkb+qW64jbS1EjiQuneqitzvMM18+A
 VSTJQNH9Y4+ZkeYuibgLCAwasngVCqO8cPzTcNXPFG6UKfn8VwP9E34/722uZhaFeg==
X-Google-Smtp-Source: AGHT+IG5zy7kpCZfM4oDghApgGhB9RDQUW4jb5N1vvFI3/InGtq+Q5BK9G6MoPKTFkdaYrToA9Px6g==
X-Received: by 2002:a05:622a:1387:b0:467:674d:237f with SMTP id
 d75a77b69052e-46e12ad5f7bmr480219311cf.11.1737740150360; 
 Fri, 24 Jan 2025 09:35:50 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b84c9esm11820501cf.66.2025.01.24.09.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:35:49 -0800 (PST)
Message-ID: <83ce8b2f-6f97-4287-89ba-0f5bf3815eab@linaro.org>
Date: Fri, 24 Jan 2025 09:35:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/28] target/sparc: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-26-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


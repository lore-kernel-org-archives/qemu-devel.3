Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F59C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiDl-0000k4-1X; Thu, 27 Jun 2024 02:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiDi-0000jo-Ls
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:02:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiDg-0001xg-7k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:02:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso103521f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719468175; x=1720072975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZMFX3tza7VwmU+1GVNUSyiESH98F2ejDVxyRy3ROSyc=;
 b=N3SVxGmBSTpiiMNbIj0gy+oUyHx5CoPszvk8z1cVuye6fmhg729kIDw67v1qPLrUJx
 6Mql0cUi/siO6pPHqA2XUZ2NZAP94kC/pRbHXN5plfWUYRfcsruOhxMm29UAGDAF4Ovd
 TqGEZYN4Wsiq9/5+INjDzGHv2HN3bzfHqWrPNEwZYf9pTfnBanPaJ7FKgSUSZPLQ273z
 /4EqVSWz7Ra9DPGFZQXHMoMdkwoYItkk0CDtwt6zNmE0q2iRb9AH94FU/XquHJEQe+t8
 3M6toZh8ajr8fJ2GHosNDX+4+x7asgKSHZr6QW7xYMTzZ2t1yF4i4veZxdp4/s1JSRlX
 E1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468175; x=1720072975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMFX3tza7VwmU+1GVNUSyiESH98F2ejDVxyRy3ROSyc=;
 b=cTlR71ju0yjN/fHPSZgObShGxkfpPqEblc2xCyrWVZBwWofiXE3b+ZqvEl3TRNX2Dk
 ud7CXeWeZFRQZKnv+5/LfuKebjm4WBG466ANTfNJcgbEVDObMwvsp4o+rnYYhvqxW+nC
 wKmJwadjvqgSVZOkrxxKl3nO9i0fDDyW5dEDuwliHnakdJXbvFPpRBEuvW+6BrPQ11AS
 cxc1igI2nHRLLGUvDBEvrNrI/EtoARzI9dJNLseXr1wOr1bwzZBHJulSUkWh7AXr97vG
 pNffs2QNKpL8VinHrEoqQzvb53TuFulCqCm7ObzLbNv0L5R336/XB9w2v0EVQWRW3IwL
 anJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/lJ8qVmOgxojGEOuTdlz1ySJ9N64izwYTL5llo98DjZ16//jnb37qM6VLy2D1c0IUCw15N88+Y6AJMnxGXBNk6XaWVnw=
X-Gm-Message-State: AOJu0YwaTwzZgkPcNgqqgCkLglg1BYZEe/p9JwQAfOs4E7/6RnhkEAJY
 YZIpjDnm/EkWdP4JLD7N8rwyfpyy2ACl8CGN7gb3JOtdBimRgrW3/E35yLvegYo=
X-Google-Smtp-Source: AGHT+IFzn41t/SRvtp2HJYuocWCoShpr91+do+AT0ndVfPMe0189X3ibNNF5bZFPC2S8XTjXxxnb3g==
X-Received: by 2002:adf:f6c6:0:b0:362:b906:11f2 with SMTP id
 ffacd0b85a97d-36741930e0bmr630802f8f.34.1719468174754; 
 Wed, 26 Jun 2024 23:02:54 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc4f65sm10015135e9.41.2024.06.26.23.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:02:54 -0700 (PDT)
Message-ID: <ba91e39c-199c-4a67-90eb-97a73a53212c@linaro.org>
Date: Thu, 27 Jun 2024 08:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] target/arm: Make some MTE helpers widely available
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627041349.356704-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/6/24 06:13, Gustavo Romero wrote:
> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
> available to other subsystems.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 45 ++++---------------------
>   target/arm/tcg/mte_helper.h | 66 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+), 38 deletions(-)
>   create mode 100644 target/arm/tcg/mte_helper.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E94CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gux-0002mQ-Si; Tue, 30 Sep 2025 16:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gud-0002bG-S3
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:25:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3guU-0006tu-HL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:25:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so96090685ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263908; x=1759868708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bnKNn4p4G+ty+DAsIKs0/mvdZfpYqUlGdLD6y7lj4Dk=;
 b=Hs3RoZpmff7dY5BU59lrdwslrfXH12F7dVYx5jB1cDj0B44/qJgil/xUV4x8Q6AyAS
 NmoUfQyPz6B0KySSHxRDbGY3tXLOY0dLGJD2YwN/7OGnwcQTabd9NSSlVYwaVc/C8ZGO
 SnIwcGbcBY4GvJGpa+Z1BAP4UWa0d2zdOxesKNYQE8bNe1V7GIK1JPudipZ5i+axpDb8
 BiBz1Gq9/AGLBDATnbmFr/E75ZUB5ZdHm7fsyBJOhcGCRkQnSQUoAX7tPvpRTxvrfABL
 DdOE0HmAfHWmZkU/kBLxZgpv7rxDduIgqTSS1WdZm35UM3dIPbShL6mCEahApxvZBOGy
 a1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263908; x=1759868708;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnKNn4p4G+ty+DAsIKs0/mvdZfpYqUlGdLD6y7lj4Dk=;
 b=avs3B6+mB3k6Oz6sCWN55zNeGS+CT09h7jC8eoKTiDdRjWdRK4GAJiZ9s4ZEF8hH9D
 FUlhTfBYe+xHD+jBq2CtLsMsIV4iT9lGdQZVphqf3LBCs4I+fESR071A43NjezcuZ/P6
 a6KmmPO6q1WBFrkDaPgIHgdQi0KEds/HY0yR9bdIZZm3DIY1CaY9S0c/Bepnq5F1RU/j
 S+F1nRFoG227QF/0mSmlLthCLx0Xe/RVABdMOvOogs6a+lLBoAbkqPfWFDQ+jtRlDEu3
 Z6uDAAOkkkNEqp+xjIEqrEpZ5o0bLvhLs1/+alm63a6dLIB1MSqtj4x2RbyjlNNy5c7R
 pjvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhZzQo1gfmuGfsZNhgwmSWvx+DEVEuoUW/8h9x0nY/KIvUVWe41ONvTWg3FkbjicBgl5BdgKdr+ja2@nongnu.org
X-Gm-Message-State: AOJu0YzpwC1oJm6gd0Wvte4cIqDz8hl4GO5Ctuc5PdLo5UyN+H+vqdtq
 Otx8D0ErcvkmhVW2EbmsaguuOLfXWh0AzKUWPKfbIcJZ2sy0lj6BguKUkj8jqAmJbfo=
X-Gm-Gg: ASbGncvAraQZ+QQCz0DJux2icIr3SsHFox7TBo+SeX7Owebri5YNJ6vmvGY5F6EO65g
 5wM185Pr9a2TFQ1BDlL32WFVjLkdBUk8F/q6CTLi4PYwMVTrSJAR/huZFPguBjp1Vy7xGEp7K1W
 QfBrF3eJfKGKgC0JFfPqqet6vudPrLf8yjv0m9pH3J8DCAPz1P5Bm2teLWpfReBYK+ypQZo/FZe
 zXJZYXsNcb3GBGl/kzolRIt+RnBMNOptPhPzFA9L65JkyCynuWwRKqUte8KmSn7zL5CbevqtADl
 /FmUKKrkSFnCz0SDlyJJeSGaEsz8tZv+jiPGu8HwwK8c49EBBz/4HShBUOlczQ0SgBAHbvRsg85
 0CZz2+91v+knZ29yJBTNkqgq90IN1jtY7FFjCa6Fvlr0Jxv/jmYTHfeFtoO48
X-Google-Smtp-Source: AGHT+IHo0Hg8lB0IJwn0sMJP6T2+LQ8lAntLvaOA3zAgBy+aLqzJl3os7yIuixP5T4ufyRTqSyli/w==
X-Received: by 2002:a17:902:f68c:b0:276:9863:44da with SMTP id
 d9443c01a7336-28e7f2a12c7mr11294295ad.8.1759263908242; 
 Tue, 30 Sep 2025 13:25:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed68838b4sm166663475ad.66.2025.09.30.13.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:25:07 -0700 (PDT)
Message-ID: <3ba7cbbf-3586-4aa9-a27e-c4a2f7435197@linaro.org>
Date: Tue, 30 Sep 2025 13:25:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/18] target/i386/kvm: Replace legacy
 cpu_physical_memory_rw() call
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Get the vCPU address space and convert the legacy
> cpu_physical_memory_rw() by address_space_rw().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/kvm/xen-emu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


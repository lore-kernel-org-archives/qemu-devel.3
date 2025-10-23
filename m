Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F159CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC13q-0006O7-61; Thu, 23 Oct 2025 15:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC13n-0006Ng-3W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:19 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC13l-00077O-04
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:18 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e17c0fefbso1328403d50.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761247995; x=1761852795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zI7H0+S6mgONRWOcAFX5W0Ru64I07y+MoLWztwUBbAc=;
 b=tGrNvcmBgtVVcIodRfyq0RvRUKCUJyg/ccXBTm4Ke5GQjxu9BKWNWz5tGpqTbpT7ru
 AO2qpG/XY4u7wjeKRjSwhePHzwLAvqfs+fzAQoTr42p5N/3dx55HL8DT3KKanqMx7Lnw
 woJDiarrro6GokTximd1jXl97Ua/OUfXkiP5pF8tzZAG5vi5h2vGU/x54MSiMZ0lSrZM
 Lfec9sraExvoMqVhvu1MlGhvdgghgF+2HuWA3MBh7COynFq9YMSR2U5Ip54x64qPTizh
 SFf5hSMm11YCIy0qOB+E7MOG4AJO7uf7+Z2mUaGR00vXMPWuIGo2wPAHqxUN9kIh4PMt
 5d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761247995; x=1761852795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zI7H0+S6mgONRWOcAFX5W0Ru64I07y+MoLWztwUBbAc=;
 b=t0+/oFZdERMjds6l0qfA75lUPbtxaIqYrL8n0Gd6T8oRMx0JbaIy3uVsTw5s0pSiUM
 OQf0ZCogxANP1QDnCXPsaIy7U/pxxDsCmrTtDb1eHSyfpZn+6i/rC7i/uljVWkx9SkVs
 wCZE3IO5BTnE+F1wYl+rIwxA+PmW80zdnNHU4dv21BDHw1OIKTFyIjaMLk3WVoURM4OE
 5bPt2YIzpGol0JFdrUS52L/KKEVi9tRvWAyjQxQap7ykS7fEM1C8HmJJGWUEt5afsTwi
 czQdlBNQnRmiKVSS1QNoE1iVig+M//SIdOXn97CNLb5rZHWE9TysdwxM6VpoAG/Y97Aj
 S9kw==
X-Gm-Message-State: AOJu0Yz5s/UD/omSQYrcn4UgSQ49DwiDEL418ita2YA/G3Q2IpRbkgW4
 lZ6ZNB0TxCrW+loN1WejqRtYXhVuw5Rjw5V2HTfWOG5X2OjS2Hl38/Gxqat6+N2eq1o5G9RLy5o
 e2QPL
X-Gm-Gg: ASbGnct13uBuFcMyAwmWQDPj7OVIDkFa+FnWNR05OI1RiecEF68zIt0bZvNGa2On0MH
 fP6IWQJCHoLSPvF3MftZsYnuoqix7pWWphg6FCUhJow2GOycKQ1E2MWQ+JNhzrTF7PKgTpja3Qe
 kSFz/M+4wa7nlzujQC6u3SsWCAJlXj2UtRKkoqhMJ2bb9MzBzsObli9QrQ+seGiQho3QUIcA+wp
 IKze/joICq2ZIrHEomh/Qu/Gy9rRUzR7c8U6PzfBBd7Ax7Fuu8VYNAgitIS8vHtjz8mKglR4Q4v
 Nwxa255UUK13wd9sj2f5x6UfkOX+PdVKxCGvADcOg/YLry0BIxiTjrSiFhbJTsCKa/u0FOrYN3j
 LHv7col26Sw3aQX3VBI/3hLA1WpJtKF0Hl0cOQpuOwNhu+vi5BhAB7o/WQ4Lc2kOGBE4EROkqOd
 mKbBO7P3KTmmpkAlqFisSwhHz+VHEKG7D0ceG4OeuDwftLmvNdyIuzuCoOqXdi
X-Google-Smtp-Source: AGHT+IF5ICy2hY9i0Af3NGUodHBBJHojiGU+3GKnRCAimiflYff096JtugAFdrckEyqZfkQEaf9jyw==
X-Received: by 2002:a05:690e:d5c:b0:63d:d8c1:4347 with SMTP id
 956f58d0204a3-63e160e9854mr19768463d50.5.1761247995656; 
 Thu, 23 Oct 2025 12:33:15 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63f378f0171sm899326d50.8.2025.10.23.12.33.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:33:15 -0700 (PDT)
Message-ID: <75e030d3-b6c3-4d44-9037-8947c714b453@linaro.org>
Date: Thu, 23 Oct 2025 14:33:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] loongarch queue
To: qemu-devel@nongnu.org
References: <20251023120710.3086556-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023120710.3086556-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb129.google.com
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

On 10/23/25 07:06, Bibo Mao wrote:
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251023
> 
> for you to fetch changes up to 79ff2eee9a377f654ed0c3533a0874a0e7d6226d:
> 
>    target/loongarch: Add bit A/D checking in TLB entry with PTW supported (2025-10-23 19:43:48 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20251023 queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C2CCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1GP1-0007sk-6P; Tue, 23 Sep 2025 23:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1GOr-0007q9-2l
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:42:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1GOl-0005ag-Lf
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:42:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso33570785e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758685347; x=1759290147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XbUjZEackku+2xlQhlBf3yl6Kx3zftUQ//S8OZsjVmA=;
 b=l90CJmjulO0kt3Qon62uu8J1I+iN5GqwPfFt3k970umJW2Ave4voM0WSNYPjfkx+Nv
 CiwDOEfVlutPwzcIqmsGwCdZDlkzsGV0yJJ0ddHi5Ndb7EO3SfdilBbeiAxOvjpdukQy
 rPyvEkHMjJplhc43wFfHrIzxj0Nietr99KiNl2cPGMIFJmlIwZfDiVOOmrdq77wXQwFd
 eHZHoRX6ZzfUMkLQCZJ3L3f6S3d9h6Ctkijm2rvTNzD0NHHps7wuVvDx6fxwPNu9KGBf
 FZQsgnk40aF2Z8cXfSe5i9BkV7RuEB5ICGs/P5ZnUd3EM2tVrCuTUZpDglrqQeULM3U9
 9TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758685347; x=1759290147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbUjZEackku+2xlQhlBf3yl6Kx3zftUQ//S8OZsjVmA=;
 b=Wgek7zbj+S4bkLI/ednYrnVS1OmBVpDfPeRkN8+MoSmPoCpf5aGxVMHssjXrF/MfKK
 mBm04ZujvpAXT8uWjmxn3C9UxT5B26CW3Yr6ItmBsSGzMm+daYEbBmLW5rPh/6KCIDE3
 gPqbsQBNE5PVmXiSroknbpIZZiczFC40dBO3I6zQifcv4RYtzEAzUTHO9PCaQeMS9Ibo
 GhEX4sIaHxQ5iO+GL3oz+FGhB3XUST8QXT74Fsjm+EuwzDzaH/sg1VeP8fsFMcuBkY8N
 aJ98xXdv/E+46SgBcH+RvRd5IS9Puxn2LcHGa+8ahJNghBtne5LjuLDiYrGSEHBwP5tD
 PnCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi66/oHd9s3Y3iMQeGrS959Tp1wVvyz8FmuoAvksF3p4m+I3fc2Ync2CXI9R5oOWFwrJPks29UlN82@nongnu.org
X-Gm-Message-State: AOJu0Yy67bG9SMErmjZX8e7Y46WFFq7yG36CIn+O6z5qaN8YeyRDFUo2
 uklzYGAhe5ZAb8xVDddLikWddUXC/u8OwVhYAz+cw3N35l4CITFL+fqLHcAwsfSVynU=
X-Gm-Gg: ASbGncup+OfRbiMGoB+jN4TP9SmTmkmAOSqKb/sPuheCpbPaVd+Q2QIUaiBkyGMFSMj
 o+xCGukRoZVIZCECcB+x6wIViXR7GJ2WQqICOAjBbOlQR+lo0SnPv0ltyp39Ayx2h0xe9EmWTju
 PtJlNus4yM1fyDTPOC50EYK3qIxMbGDN7pbVe/uyaJvKRsYfQpbIfb4y0UYQ/Yj2pGeFPO1+K5t
 0IgCRjGcI+nSrzYBU7njOVeBKbttrT4gZA7t6RvmqZp8XUZSRoJ7cIOayfQ6l20bF4RoKHB67Bb
 ifSSCKkstvia+yPn35o6elZzn2WYHaspZ7M/mWDUss3AaaW8Z8BHD3JZPnmPb7XeftEp7baiY5G
 2A6yhPC2g/pdUkId+xylyCpkbAqkxVy7e2GBIFdiIiGSvrBkyE47lnVPduisu5wsM9w==
X-Google-Smtp-Source: AGHT+IEMk+RSqSKYev4AjmaQKRmttunasCgC6N/lhxlBUQrTB6ATBow2pf5TE28guj0S+VyPYOXhUg==
X-Received: by 2002:a05:600c:a44:b0:45c:b6fa:352e with SMTP id
 5b1f17b1804b1-46e1dab5488mr53612015e9.18.1758685347170; 
 Tue, 23 Sep 2025 20:42:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-407a3bbeaf2sm3632438f8f.49.2025.09.23.20.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:42:26 -0700 (PDT)
Message-ID: <d76f2dd4-f20f-4d8c-9f85-d0ac51483ee3@linaro.org>
Date: Wed, 24 Sep 2025 05:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com, Jon Wilson <jonwilson030981@gmail.com>
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
 <20250924020735.3909216-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924020735.3909216-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/9/25 04:07, Richard Henderson wrote:
> From: Jon Wilson <jonwilson030981@gmail.com>
> 
> Set and clear PAGE_DONTDUMP, and honor that in vma_dump_size.
> 
> Signed-off-by: Jon Wilson <jonwilson030981@gmail.com>
> [rth: Use new page_set_flags semantics; also handle DODUMP]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/page-protection.h | 6 +++++-
>   linux-user/elfload.c           | 4 ++--
>   linux-user/mmap.c              | 6 ++++++
>   3 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



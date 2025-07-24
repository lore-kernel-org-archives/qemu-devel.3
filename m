Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A034C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 09:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesUB-0003Yp-Vo; Thu, 24 Jul 2025 05:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesU9-0003Uz-TY
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesU4-00075G-UZ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso7805905e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753350207; x=1753955007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xEAkKoENW8vDgmahFUrX2zUydTCbclzrikgoLfT95k=;
 b=ZiMv+dWo8DRp0a53yHbU5SsFqdOydTucJ7ObEVLVk4E4/MfZqR11btt7XKZ2H/Y5dt
 wm6VVFAC3KN+D4F5yr+nNC91GiBfJR6UUBkNjlZ9zDl+td4ah9eCbcBDWuWMVKY31Hl/
 kuuBLNjD7d68HjFLjfyI7J7V82jb6U2ZBWyIOxOfoCNqqnkhcGT1EUvSxV1/4fA2BU/2
 bJTuzPOT52arTf/lhXs6QOTB9/dclQPaaNPfRq2ow5qH9LDcgNFNDJeUX5xcmxy9spXd
 hHdQDEWBevZ4DaKbQP5vGX2pz6pHUTaMbk9s13ktJkPRCCl9J81XA71R0SgrJGqW34Oq
 K6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350207; x=1753955007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xEAkKoENW8vDgmahFUrX2zUydTCbclzrikgoLfT95k=;
 b=U3+l4By2mFZEEqAP+Je+vX9o0P6iVeMj/0b3JfZPBB36p17WITMdhoy0CRD3zt94SY
 llD3EjpPXiGkU2FIckN/OGi07KhJz7/+W0ZT6gndvSXCRPpjRYZXUKjzGEYa/UaSuRqm
 PMnYsYFJIJ9KPFXWtQGZJRERUo2VyghD50Y0BL8z2zKQ8Lpoar/aHlcx2cjEVLmOHRig
 u1zwyiTxEIcwHaDtcLluL/fFxFOUnhuvjVAm72On2GP+68kCFoeJ3fGbpKmSU6kOMWYW
 oX48+M2PwBWDmNxHSpOg+LPa9+O+IUp1R8tJeG9hFvcfERhP5uBxtk/N0wOam7lIiwhR
 Dndw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsIdQ4X6sqM3faBfdAqPbi9dEz9dOmRiNH8ORxT/R5L47JuwIuBGxc+IMAmL1BgIA9Ft9glcyzVzJP@nongnu.org
X-Gm-Message-State: AOJu0YyDqMMJ2i5sN6TVWe1PWqDT0mP0wJRo2M1JIy92Tiy+fC0uSUvc
 viBvXQb7yO90mxC6RXt1pEezpdkDTW4i5W8t8fj621+2qw7h03bXcD47LMBkWaCP2c4=
X-Gm-Gg: ASbGncuG50Ngo8p0QpIyWR9pbQ9D/H4CuJ4bsgtRZc/6TR69Jk7Fd8RW9oSs+Ex8kIU
 Fn9qW3Zn5PuxGuxvR/jPgWHPeM9TrEIl8zh86T78yPCEvNYfbkCFsgyBqzNBYVAzY+TwEyT45If
 v7K8fFnyvM7+jbxeG5wRt/cCZKL6UwrhqHbVJEoyRpnE1KpRPAkqoYjp3ZJfY2JL/eBz232eyfM
 qT0UXre3XpCI0O2Q86W4PdAwaDonHhsnTYgNMK+bNWnSlxKBZkZ1IE6dCX0Ihct0D9OIsFxczwl
 GgesyqvBfXNadHg8OnJMmQl7YVcG+oTHsvHc2ekRNTpsKHFsikpU+KBFkzXWQbZefWAi3Pjn3Q5
 LCkMLabL7b0JusPWS3Oy/t+nAV/L27tjxdx0Qtv2d4Y8xkorDV9Dihb6+3NG3rryXEw==
X-Google-Smtp-Source: AGHT+IG7HcpyG7lQwwI6di/e1uOPne8y1cCaeWOqAgCOSA56TuIbtzv+yaS+k8EXXmyt7OxJvhsoTQ==
X-Received: by 2002:a05:600c:c167:b0:456:1c44:441f with SMTP id
 5b1f17b1804b1-45868d7266fmr52852685e9.31.1753350206702; 
 Thu, 24 Jul 2025 02:43:26 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4dbdsm13875815e9.25.2025.07.24.02.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:43:26 -0700 (PDT)
Message-ID: <d7e6838a-1010-4ebf-9d5c-6220802043f6@linaro.org>
Date: Thu, 24 Jul 2025 11:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] MAINTAINERS: Add myself as a reviewer of PowerNV
 emulation
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <20250724063623.3038984-5-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724063623.3038984-5-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/7/25 08:36, Harsh Prateek Bora wrote:
> From: Aditya Gupta <adityag@linux.ibm.com>
> 
> Proposing myself as a reviewer in the PowerNV emulation in QEMU
> 
> Have been working on PowerNV QEMU for sometime, with contributions in
> Power11, MPIPL and minor fixes and things such as dtb support
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Missing:

  "Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>"

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31bcb82e93..1ba161d75b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1579,6 +1579,7 @@ F: tests/functional/test_ppc64_tuxrun.py
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
> +R: Aditya Gupta <adityag@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: docs/system/ppc/powernv.rst



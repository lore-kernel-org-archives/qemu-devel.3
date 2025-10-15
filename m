Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B15CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98UQ-0004bv-F9; Wed, 15 Oct 2025 16:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98UO-0004Z1-2n
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:52:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98UI-0006Ik-Om
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:52:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so250585e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561563; x=1761166363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPc5I6X6oKsdH5ziLNXFRtPd+Y6J3n4ZXk3HdcCgILA=;
 b=dBKXAm8azSXDj8JcYu637qwj6L2uacffFu194hfM1wyHbEVZmldGQIjKAm6wPL/Dd7
 F76lVw+3RolqHAYZQOmaO7LfQvk8lehfmVXJnJIES5CTFam1HPUKjhKY35EBV6alxtGe
 855wXCrUJWKfWOrgIVwbXF21oKR0b2Evst1XJzRyMT4TFcNfs1C8iSgRRtwBbb3vCfid
 p8d7ajyGaFG3PdR2p9ea/JEOoCVIbzT7TmHvlsz6o3eQVvIY9GhOzUpnh2m99wQkjZNI
 sjlw+6YdySoaCeDNumwPSFlIh9dIGkbhqTqRl8XLS5MIyFfnoCrZAP34oPnJwrM32TsH
 rPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561563; x=1761166363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPc5I6X6oKsdH5ziLNXFRtPd+Y6J3n4ZXk3HdcCgILA=;
 b=dRosW5isJ2mlTSGfN7M21jTpuoa40WIg9ubogpKKFmojq7QDdG+4j0q5iD/zCjsblm
 XXeBxpYkCYEpfBhADuks75fFfwMNeDhBgL/er26QusuuQHS4W7YCuB5AQJ2/Fz7op7ZV
 KFqU9Gp8BLN9az4K9BNtQUuM/rjNLyoKjDZIVyqeWWQPSj704fOQhp/SGx52FDhkmsA6
 hsrOGobtxfTMLxdWg/vi9sM3/NxsrDK3ZBYnj0BRsvXyAI/gnMnEaLsNXCz2RJfdHRSu
 18VstQCtwXIYIeuyJmO8sY4gDqA7c3KvYS4zx4xjOZn6q9842CelxOLnANIREh+k8YAX
 sTWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5SCo268AY57yHUQidn3+6sB1bEVeP/Hk4qlsdXOFXKjcwVmdKYHkjE94AwzIRLikD2V7s6NO7OSfi@nongnu.org
X-Gm-Message-State: AOJu0Yy4ZRIxAR6vUmZ7ZGQQo4e7H7yz9QRx+PdnxvDEJ4MKYNuigvlA
 xxU2dUxLh4EYQ+I3FaJcJAFiDHR7lfFkw0EdN5uj2fvxEKDpvpk0SOBQS0RZcNz1jxk5tN6WGYM
 x47IpgfIJJQ==
X-Gm-Gg: ASbGnctd1ovM/rSt8yqcIEiDFXIVeovhCnhm9On+iXqFIzp0BhipzGShqOiaxZuB9qp
 DMBd9mRdw20qzIS4eVmKttp5F1ibWH7H/MogpQB8ITrYMI+Q32KTRHK84Nz8JMJgL6iGqVvx5eO
 8tlDt1vH0vD2jbwthBrEdZ3sn0BUWdB0Ncqk6NuMY7rHdiIG0vEyZ8HEfYFuc5WJKPWDpJfHqHn
 c+ujYTSFcbn95G0mbJ88+vCwRouRWHhbKkrOoyyOyebQlwSjr/Wzdg+WEM/lS0b/vykr9ioEJJq
 gbUqeFFmWrjhMjzgKazVVC67p4CaQMOr+8MFhjpyRxfJCif1FZOvyq/8qQLmusbhUVLCrokXjoc
 eOW3fZP2F2xSErC1EX2ky942Ko6bYlUslFAhBd8kymmZ2Nqf7U0ZzxeHW7wo2SuxmrHDlDtj5PJ
 cTD8+Yoy19KMlZDKd01pSmGiB8VAMYo2bVULR9d2udtsh4hCY=
X-Google-Smtp-Source: AGHT+IHy+1hSlY9xBXJ3op2M2D6EbHVL9sfjCfKGKhisKF8F3tASXW0Awf/kls2pN2c5hnHIHBGxqw==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id
 5b1f17b1804b1-46fa9b075f3mr246306435e9.32.1760561563456; 
 Wed, 15 Oct 2025 13:52:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c3b29bsm43738345e9.15.2025.10.15.13.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:52:42 -0700 (PDT)
Message-ID: <b1aaec8a-c436-458a-bed8-9ae2fe1aaa08@linaro.org>
Date: Wed, 15 Oct 2025 22:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/34] target/riscv: Fix size of sw_check_code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-21-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-21-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 14/10/25 22:34, Anton Johansson wrote:
> The field only holds values of 2 and 3, fix its size to 8 bits and
> update stores from TCG.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h                            | 2 +-
>   target/riscv/translate.c                      | 4 ++--
>   target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAE3C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAzi-0005W5-Nh; Sat, 21 Jun 2025 23:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAzg-0005VW-HS
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:03:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAzf-00028a-1h
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:03:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23636167b30so28389775ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561421; x=1751166221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U3PFNpxgQPNm23+ByoGMfyWTOBHhT/IlMmUfU8GqKAU=;
 b=TXLxq88im3NNZQbi+d6ZoYQqhCpGRoPZ1yJC12zSzzc1IAoVVvj1Cx81C/C1EGQGGY
 nQbiylJkJMQO8XQFHjotzDrk5Qh1qy5nNow35qkywjO+6WIIlSnYKWSWMiH1rsxnbrt4
 tNNvuuEpUwTTOkNNy05lQokDp1g8WY0hGBFPSKHqUO+DFAgOg/SdbbL5o+N+T0ZGIH98
 r3sBklOGH6lFp/XY/B2yMN9XM+oUVwGnI8Idj536HhUcnp0acgTaq50lSbVggLu/NZDa
 IX14hyP0/Wkh5+r9aJLp6f1Rich5ycjmX7sGId4w1DuDEM9xF/1ioPfHvAbXHv2f2b/E
 BxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561421; x=1751166221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3PFNpxgQPNm23+ByoGMfyWTOBHhT/IlMmUfU8GqKAU=;
 b=p/DThZqHUUqQK0Ko1ZDD15PlbSB2z6vwpsALT41uz7C4CF+VhDss/c6gmVAl9eiJkC
 TEJsvvenMLyUrfilTexViFAGPbZ4KeKR3S6q9FFkXCpjuv4mVc0kX4EIZt1cfxuzabWc
 wZU0DM/p4LPxc8a93T/DxficDT9BqqXRjgIFxFL95MtJYsIAhb/hFNvnLAz1UMLHq97l
 unsqdnqM7ujasKgM41oMC+cssixRcGF7/FtqD+Y/WsaOgGEXtcxpFaZil2M99WAN/o+P
 6qb9Fj4w8KgtDrUovw/JVP8V7L4mun0SqbuVRSW9nv0gjv+UyClogTfflsVd2I4qVFON
 AgWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVwOhTVugojMmTGj00bfz56o+RuUCceCKy0QYazsph2SRoxqS5kxgnD+ydfggqVM7qZc5nCrb4zJxh@nongnu.org
X-Gm-Message-State: AOJu0YzaJjp3K2nZCoZVu9GiHQqdVqrYq1vjSgSV6zvn4v0KW9LyT7wI
 YN8hBIdDCqy0PddQktD8J4LGNgwhNQYF/XZ54MwHwCKXNrv4TSkkZOKBN6IUIzQRbNw8/gt4YBu
 XWQ3wF9I=
X-Gm-Gg: ASbGncshFMuz4WZ+oemQpm3nacnjxVw/ZSm731tq8bCVCaFugDhVf4FNzgYVWyYzLqx
 d+ugOP6YY1AVrIHXeCekh8YW3fyBwhfQ6WX8iE1uhS/hTTFBLgB0CpZyzIcq6/HNpbad9RHng+S
 Que5wEzOZGA29LQT/qRQGzUcjSiTK4VmUHZo12uFN3HnxWyJwlZPswilrc4857GeZgUf8X+fLOv
 2dqaiZI7rBTTWcK0G7pwp3HSPMvMxP+JLpuTwJswNYEedu6j9fBDlSidm6IK70mUm90CZvUVyXn
 bHlSd7rZgVWcaUGu1YGuIKjQ6A2ongti6/qnA5eaTEsu5R7jlQs8PYi6O3VDwTooiw6MGHWTE1Q
 xJGPEC21JzVA0UDyFziTlB71wOLas
X-Google-Smtp-Source: AGHT+IETch4M60JgRrgvNJaAl3ZJQlLk/RAzw07CD2VX0mE7StLSpcunQI9cuh9BcksdFhyXqFq5Bw==
X-Received: by 2002:a17:902:c94e:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-237d97cfb5cmr113638295ad.13.1750561421343; 
 Sat, 21 Jun 2025 20:03:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237ee6e8c9csm11757295ad.190.2025.06.21.20.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:03:41 -0700 (PDT)
Message-ID: <d9166c08-76f8-4de5-9193-04d38fde032a@linaro.org>
Date: Sat, 21 Jun 2025 20:03:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 23/42] target/arm: Implement
 SysemuCPUOps::can_accelerate() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> ARM hardware can only accelerate EL0 and EL1.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


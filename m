Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D58CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBdx6-0006uL-Bq; Wed, 22 Oct 2025 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBdx2-0006u6-Iw
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:52:50 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBdwz-0004ug-JD
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:52:47 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c3e26d534fso973761a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159163; x=1761763963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAoR1fPW7L8P5579GewsgGbyeG9xFMQ7kS8pk0R+Zl4=;
 b=N7jTuK4mDcgZLwrRayxyLzK6HhPlNkbMZuhiCCIv7cqAWDZU8yMpq73bCnz7qkJ14J
 IGhIEq2saAqBLKu1+Je1FQCh7PIX/Nzc2+rGPadfn1FI9PbRjfnShkuyrq+g3ycC37JK
 YSuqloMw0Q+EK/KZTeLdz9yTHuYkJkFmWKHxdxq1ibMEW0iUmRKbX1P2lrMTikwivt6c
 BqeIIWT4tNz/NVVONZ4aaEzThnQ68LRHY4rVl9ZmHWMGNXhT3S9T9pnGeqUr4bj6O1MG
 DtThLRFywVqkwspf2dFvLgzmjNuJgtDe4duWbAVH1yqfxUOXYcqn+Wm87ioTwQpHpAwY
 uBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159163; x=1761763963;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAoR1fPW7L8P5579GewsgGbyeG9xFMQ7kS8pk0R+Zl4=;
 b=tK0Wf+MEhibSPDOEz1Emw8XzthXlePJr7tSCNn1KvyRUpMRDWpMXBkLyquxES3SWE7
 DQm4SKuR9BhrPmtonjzTihcTgBLN6yFgbBzgg2Wjh6PtRYDYHB6LIBydDbJoOSBYINjw
 4a/2OA15Pt7tJvGbgJ/xCRuJmPU5RMTZemRd0EMNsKApYIHxjHbwzKEZ8TiNtk4hQAnY
 Id8ov0rBFsIC8tGodKbjMZZJ9ObK+022p/jUUsTkjHgQskNhZ4wUqde8vzXteRwOQbeG
 ICSJOz8e4dJLxP/o4xUrR4waOFn/nrcTiyGS4MR0SiXd/TCgZ+o1PLWgewGjVVveJWEX
 dcNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC9pASOaIZ4jcPT6I9zzYIZQ0Y0p5XPOCtM/omZZ7tGqYeQQhN5evx7loRaVlo/bS/SJRJ7YWbBwxf@nongnu.org
X-Gm-Message-State: AOJu0Yy8ol72aYAFf/dQ72ASlly1fIIlMZYbZ9sw4JfrrJfAQ8CxFFzf
 bNIcIMNF4GQDDrGuJ0AOka33Xnno6nxEsq5FAKykr5DhGqAzVq0/PTmX9coMJ5zYcl0=
X-Gm-Gg: ASbGncvCGW09N6v7hywF2VJlnWH7ym1ruDSMmY7jblhemtUnQGTIW3aRPUMzL6zYy53
 JgS5YGXWIsyzDr6xojFDOW5Dz/6s4JzAZ6to9cyefhvMgmmFVmWRvud9Y1759mrZDY0Dn0XoqSk
 ZpMpXgnS2PmQxbelnQ9GqHZ6DWOa3tMNV1lJRJCakgJiPT4i8CH3YzU/wFpDuX/jv1v7+gILOXn
 qq7a8h8TFnnSUSHm61fRb6zD8ctmlQdTbhxPnUcVqYpj13tKH55vTeqptx4aOjDiVyjRT7rX1EQ
 1ybX0WlOdimdJcBRFBaXOi0XkuDizcpme1dVHH5aXigQDx78BctNcL5PdHS6qcU3hHpDrhJ2O2J
 HXkQrOtKip8qYocdFGjzvdKUiKZ6sKy0Y42gLU3HDw+kn2eD2r/3KFf2hXD/gEjbyPqVblVxgLl
 00D/THQvTyO/QUFUXv1AMTL6Nk/dOLfiECTSstewY1FltCeT5JCCapiWfMsNbu
X-Google-Smtp-Source: AGHT+IF9hi+gVnvWwjXnJCs/893CMhmR2sUJT9wHz1v05kVr6oWSf+T74+UOKdGfYKh8lUfYw+6tGA==
X-Received: by 2002:a05:6830:264d:b0:78a:8b0d:cd29 with SMTP id
 46e09a7af769-7c27cad9784mr12336967a34.13.1761159163527; 
 Wed, 22 Oct 2025 11:52:43 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c3e326df99sm767388a34.33.2025.10.22.11.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 11:52:43 -0700 (PDT)
Message-ID: <4225e42d-e732-4f25-a74f-f95c090948d5@linaro.org>
Date: Wed, 22 Oct 2025 13:52:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/hppa: Add the NCR 710 SCSI driver to hppa
 machines
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-8-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-8-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index cab21045de..5ea7d9b9bf 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -17,6 +17,7 @@ config HPPA_B160L
>       select IDE_CMD646
>       select MC146818RTC
>       select LSI_SCSI_PCI
> +    select NCR710_SCSI
>       select LASI_82596
>       select LASIPS2
>       select PARALLEL

I'm not up on how much explicit and recursive config we should have.  This should already 
be included via LASI, correct?


r~


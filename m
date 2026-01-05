Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0534AC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY9T-0007x7-AY; Sun, 04 Jan 2026 19:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY9A-0007um-Iy
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:08:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY99-0006Ox-5f
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:08:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f2676bb21so188784005ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571710; x=1768176510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzJvOWfF9FsF2v2CY2C5j/pnn7zcB7lKpy+H9JIlqVQ=;
 b=j+8XVIdQ/lrO+yd4W85S51r2gslUIsVqZcZl71bBJOc7H3V/YN/Ed/1GhKqfu5eXsZ
 3k0GGPwtIBO6S1CaoAZZiij9gRm9M64N5bUONiZse63YH9Fnf7RUYFh9bkWIwAO6OiQR
 5RYtIYN1KgRg7bzvMZyjp3TDB8zIS5AwHiqfmG8mLbXwMp4tacdYnMGR2kujs9UQyawA
 HYggyO56AFSUDsNC90fxJskgabzzPUrdwawuw/uJCApbVRD9XSNCHQWvS+05hwNjG6H3
 GcV1FiYkWEMjwy54ShfYhz77oVzFUDauKARh2aEx0cYQTuHVAD68PIvwHTDR7s8jX8ig
 cGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571710; x=1768176510;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzJvOWfF9FsF2v2CY2C5j/pnn7zcB7lKpy+H9JIlqVQ=;
 b=w37T39UGMDNrRk1f7ilif9VxA5d5AFVCBg+Y/mqLmsk6f5LD7S0YzdYegjZRbf3Egl
 cZUT36JdqLaeSZt84LslXNjKMsbeBqIS/Sx3yt1FpY+fkjYcWaGewDN21Xf9Np7U1x5o
 eAoSsT0aDNUsLNUH4scYWaJIyxvJYMbpvnY9JU5x0Z2D6VTrsPlZpPZo2PiIijsYLa0P
 ousvq95gLQRCdZBVJJCTNRllOQqscfrgQe3LrMv4dnR9AJJ4yroQvKmIQdzj75z5wpBi
 xim8LokOHxryuImHkJdkVV3IS+NKfIntB/4RVXzuveJeiaQ/tfxQ+pBbQceTNXi975zL
 OQ/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqs86GCctCqaMTVO6Zc9qURpFd2KmUSriFxEG5jSPHgAQTvxyi2ck3yYfKaeezOdBSS/UDkXe9pYWc@nongnu.org
X-Gm-Message-State: AOJu0YzUTYJzmcA7hFBMj32xNZTnQYwaaO8zU27TQMMNz2vHj++DsHIF
 snC76LUwsBq1uhfONl7CMhUf12QaJcNbaeVDQNIFOMjjuN8zQ7rDrSDzDqJ13eSWVpQ=
X-Gm-Gg: AY/fxX48eM5UxYpf67LHK8g46YNRG35blXZWc16uyhrUoZiIdHyRaHE2B6lLj0YZ8Te
 DNUhoazYZarFGaJC0zVP0VNYi4OHWUx4OLLr8DYWtHPgx2aH5ge2NvcwPMI3C+mhjxooSQjln+B
 x6ktZfZQTygoWHppfB5VbQl26VQU9urFkDnTgXLJkEX4BDDLQuUkkNLGz0S5iTvZVwpXEU1Efnk
 QWLzKC9YD3ps2CQFYGq7bqckK5y6TmeAqtFnbQCJX4LHPChpJwoXyAJ6VABDX4Wd0zff4nGTnzx
 RnEHEfLzECuvZa099RabOPVxPHPlYjnQ5pylIdHdcfjRMzMMPBUY0PmYvNLhcJna63gfmAwpKg2
 iCt6YvmTqs4JdIko2e5QcCdL3XlW6U4lw1gMm22z/47j6OqrW4iw8hGp0UqVuZQg4Sw7wVzXTbd
 1yF6LVg30Jt7xLJPY63/V/1rVldQkkzg==
X-Google-Smtp-Source: AGHT+IEza9n1MOGi5G5SsyU+3gyfesU5T/q/KlkMM/dpzTIJh8KNWflYf6A6sH4nAbjNCTn2BYYfzA==
X-Received: by 2002:a05:6a20:12ca:b0:363:bb19:ed30 with SMTP id
 adf61e73a8af0-376a81dc166mr45241767637.5.1767571709607; 
 Sun, 04 Jan 2026 16:08:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c147943sm40332734a12.26.2026.01.04.16.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:08:22 -0800 (PST)
Message-ID: <287e7670-9bdd-42c6-84bf-22db4723d19a@linaro.org>
Date: Mon, 5 Jan 2026 11:08:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20251224160942.89386-1-philmd@linaro.org>
 <20251224160942.89386-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160942.89386-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/25/25 03:09, Philippe Mathieu-Daudé wrote:
> All HPPA-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/hppa-linux-user.mak | 1 +
>   configs/targets/hppa-softmmu.mak    | 1 +
>   2 files changed, 2 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


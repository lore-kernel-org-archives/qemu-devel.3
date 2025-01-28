Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1B8C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcors-0001Iw-5M; Tue, 28 Jan 2025 11:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcorl-0001GE-1E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:55:09 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcorj-00013B-Dz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:55:08 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso10151606a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738083306; x=1738688106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2hMYBy1WJIXVzxsMLVnXmLob0gaPevtYNeX9qPQnno=;
 b=d1LzOLkEgUJdoImH/D6qS0i8plmLANG756ZqjxF5fSwA2sBNjenIek42p+MKbU1Qxz
 SL6WUBfBiINSKkxrMDyNrDzWS+jscYqJD+VVdhqwVtD7sOCt+0X5iMApdfPwirSkXEMG
 4qmig3HhmE7IX44VeT9Qim4GsZRYn6yDuWJHUC5bGaddVLCqFeq29pJVlqV1hMok7gDq
 p9Nz2QFMxSScheumap8Xv+78BV0xz3WZQmdNp5U1acfKvsZcSS+fTGL4TL3WtQVQlyjd
 wayen8QZwALOOHPzNco/KnKp6soDjjCEehwnUV+KiAWbO4+6rBmNMRytCl8HiLb2J3dj
 ydpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738083306; x=1738688106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2hMYBy1WJIXVzxsMLVnXmLob0gaPevtYNeX9qPQnno=;
 b=kkIbBftjndvpnHpamrNYKbQLiATo3CXdx5JFFW35iyRTypUy6n3rDC1VgZBZCBrrGP
 ra3Yp/9MfmLp1BKYMQU2SFKkNTaezFoVtLpSwHhTthdhnOiqYfZIPwYABGSRD7Jik609
 X6j0B3blFJL1T5Lt9svr/r2kmDa0MObNaQpNegjtY03iEelE9vD0vvK66sbeRXVep2FX
 ZwCucNzzwkR52jZOfng7GDgK0ZXcHe0DWSZiCRSDFerHoPYuJEWipk2yO+huBKTAaQIq
 oPd+VsytSSQPToHx2x4/5mQxGpvTsMxu8Be5X3EL050SSXzzYXugkpoG1lR0WQOuCJ8g
 Rz3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLb67WIiknjxcikvTiqxLkwRyjhKYsi0D0sJaOXBJetVTf80HUQDldRcvdfZTupwgk/en90nEyFVvo@nongnu.org
X-Gm-Message-State: AOJu0YzzzDl4y9d0Ha+hsqyQh6xPH+9kCj1zei8OMd3D+Ea0i/yXJ8u4
 Gu2NWGrk7VOwp/yXZmnwO+7BKYfi8HR0njlPXls7hevGKgDV3ikoBiyG3/IVAJM=
X-Gm-Gg: ASbGncsxIyzMQW5vbyvBjcAmw9I2EwwPnfj7Dtlh12RZC0ITAc70j8IpO0xkalrhgbs
 1f51Ah/I9DnmZNIh1A/poEW7SZ5sV7ebwQhViIucj/CH0UJ5osyHy/1N7WInskqyup3GECzMWZ+
 3COVRaDAhkBFjZcsmOQBkipFNAYuc+xj5EtOgsy5aRAtLLYV01GphijbhuGRz6uwAeGUOwkhGK/
 LO87L/hlqVfgT/SS55B/Qx/6z9CmSCzctF+wZTTCIRX1mYmBFPTCa8s/bVwPAsBqVqtBmZJ59JY
 G5stazqR3RxkX8EtNOKk+hk0HWMUr3AtvgIAQBYxv2qJLdrXs9Sf8PJrBw==
X-Google-Smtp-Source: AGHT+IHriV9ih+mfEZ/RhaYb3WNvgxY31qsc+jwk5ZLS54YUEyo/kmoxS6t1YfCgACeGAJFNhDxmiw==
X-Received: by 2002:a05:6a00:340c:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-72dafbda6ddmr74875363b3a.24.1738083305732; 
 Tue, 28 Jan 2025 08:55:05 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6c7ca3sm9496183b3a.75.2025.01.28.08.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 08:55:05 -0800 (PST)
Message-ID: <448e4b76-da27-41b4-a86b-56e07c97ff72@linaro.org>
Date: Tue, 28 Jan 2025 08:55:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] disas/hppa: implement mfdiag/mtdiag disassembly
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250128161450.12975-1-deller@kernel.org>
 <20250128161450.12975-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128161450.12975-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 08:14, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The various PA-RISC CPUs implement different CPU-specific diag
> instructions (mfdiag, mtdiag, mfcpu, mtcpu, ...) to access CPU-internal
> diagnose/configuration registers, e.g. for cache control, managing space
> register hashing, control front panel LEDs and read status of the
> hardware reset button.
> 
> Those instructions are mostly undocumented, but are used by ODE, HP-UX
> and Linux.
> 
> This patch adds some neccessary instructions for PCXL and PCXU CPUs.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   disas/hppa.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


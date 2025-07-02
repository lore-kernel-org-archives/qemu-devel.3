Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E879C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4s1-0006yQ-4P; Wed, 02 Jul 2025 17:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4ry-0006xo-It
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:19:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4rw-0003mv-TC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:19:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-236192f8770so2123215ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751491191; x=1752095991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2oLpuDzuhdHiQaMDk9scXG+1ZBfQnlbCx000gNoXhE=;
 b=bJyxs7jaRjL0KTqqQCycVHW6zW5wjEKeOK+o4IqgWUkUFxoiXW9bcQa42pH8Yp1g5u
 pfCRutozAfodXg8is/gQAve9JY2O7b9Rp2ELL8nnrpVWtree25rKJNAnOSSZEjVaUrgf
 qM0H0rkib6uG8MPHDQXtnfhOvihtTX8fBuob+eV/ZYkKiJLsytr1FN5Uzs2uNWx2wNVy
 Y+DEDUHyj/EVwiOzzmNZdmqHl7OdWGA18vNShyFgX3w6HJfs/aFP0YcauicXkAt1c1Xh
 l2srgnKZXBI7XA6AktvH+V4wpAb23h5U2+5RBTGm9dh8fOHHnl0gPTr5rD578cRaiem6
 TIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751491191; x=1752095991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2oLpuDzuhdHiQaMDk9scXG+1ZBfQnlbCx000gNoXhE=;
 b=B9IPjN1lGCpn7AFjFVg17NlLQzRkrKbnC8VQSADea4W40s9rfX+l+QAwEaCzFzXoQv
 dI+j9l9fMWos4i8adtCt+bvwisizGMbPPQQohXBelNTUgt5mCjApmWNmlGiYQL1Dk5FD
 icXkzHZu5+Lh/xVVav1wlNA8QY+YoFPHTUAQKlqhP/j4SC/7vLro3JOSzro4cPyIbLNm
 exCccr59ZFNhLg+IEhczzFqTcK+eThUQVCVoO47k3GvHAL5Myu+7Peren7npYnw9DsfD
 qsvejY7VEBboXEnU5cDdqgdDHawmUifwLCpj0j+JA1rPhigatJRdTRARouv+5bCeUsKY
 exVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUnNvqhQu6RkHQc2fggEhnK2UmwAa7V0VsvUONqgZphr5/D4bqRP+21F9LwRQJ8+Hcr6gUYzliF6ee@nongnu.org
X-Gm-Message-State: AOJu0YwU+cwPShnEb/AsbLkD2qOFcxjYTLWsDhtZlWCjxt7mbN0pJtxW
 u/VBBaEpT4eA6KSEo0ryoxSgcWP4BcD0PVqOJ81x8icE1hfx5xCCkNeS501/HSgKGxE=
X-Gm-Gg: ASbGncuGBxnQVfNh6h2+qhpHvne2snXKoX0fPBEgP5M9xO1iNW9bgfKbEt6DrNkdzEP
 cO2C2IGYaG74j+BttvwxOE6o4L2p9fyTV23fSyON1B4qk/oF2m7QOUcJfRl16FDdU0YE8yMcLMA
 r1B21tQPiWOG0mTT0i4uI67VNSUKtQNPHly4PG6V5e7IiNcjzOrIvDoJclyx+FuSGIN7IFoLnWJ
 BfZ8OMqBwAlo8YRnZCRQihaz50f9cw6y4JR8tD70zMhrszgh187MtHmmI3D0A7Z5roy74K/Wv11
 LeDedHlzDtbnS0BEDGzTFUmSPWB2tCJmZWr7mRVP8bXIIQ1qbp0hFZf1UVzttdL2VmtzON8j90k
 ApUm/C9Mthg==
X-Google-Smtp-Source: AGHT+IEveK9a4pLkComAd6bEMhUh5nd/K1YH+GcPSFUDBL56X19TYihBZ8kJjOvEoyFIVMBoN6XXAg==
X-Received: by 2002:a17:902:f690:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-23c7942d9b2mr15121325ad.23.1751491190998; 
 Wed, 02 Jul 2025 14:19:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b95csm142670205ad.139.2025.07.02.14.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:19:50 -0700 (PDT)
Message-ID: <f456a9b8-5e6c-4ed9-aa94-0bb6350052f5@linaro.org>
Date: Wed, 2 Jul 2025 14:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 56/65] accel: Expose and register
 generic_handle_interrupt()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-57-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-57-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> In order to dispatch over AccelOpsClass::handle_interrupt(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::handle_interrupt() mandatory.
> Expose generic_handle_interrupt() prototype and register it
> for each accelerator.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h        | 3 +++
>   accel/hvf/hvf-accel-ops.c         | 1 +
>   accel/kvm/kvm-accel-ops.c         | 1 +
>   accel/qtest/qtest.c               | 1 +
>   accel/xen/xen-all.c               | 1 +
>   system/cpus.c                     | 9 +++------
>   target/i386/nvmm/nvmm-accel-ops.c | 1 +
>   target/i386/whpx/whpx-accel-ops.c | 1 +
>   8 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



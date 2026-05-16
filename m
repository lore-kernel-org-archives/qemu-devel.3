Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A21CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOK9O-0003TX-SJ; Sat, 16 May 2026 14:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOK9M-0003TM-S0
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:54:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOK9L-0004du-4l
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:54:12 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so887061a91.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778957649; x=1779562449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCUB+HD9boEm7f3hBojoYmzHpY0FClU/w2HNf/rumR0=;
 b=sIp88TltXUINneSLwJxOx/78Dtfkvx6YT2G3xLzCQ4KJ7D/VvWZyxL96qQai+X1Vdy
 ZKSqKx8U5GFgvVqBcrFo/lH6voilveNf81PbvO8cBJZFrjsWzn5eXYgrtupz9RJ1M69A
 YJHmmSlnE2pg/6ZSeSQP8HrAbsdyKRUREZdSVcVFaf2lH+30O+s4BeCWOcfyVY1FRLhR
 fMkPT3x5cVxMkJBWj6xfRBunF0qmH7CyJpcoCM3xJ4e/1urCOAkAEYfznw9u040ok1kJ
 WVMKV2A08vHWbE/VwYddaxYU71yRLhz8r2RsqF0xpiOZP70ZRMNJG8OIBlTeWjo0uKnx
 r0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778957649; x=1779562449;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CCUB+HD9boEm7f3hBojoYmzHpY0FClU/w2HNf/rumR0=;
 b=GKlngFsY3S3UAIZz7BnhaSfxgNBeawxWqug9IQiRSYuxzKxSSMOiBo0sfNCwSM1555
 5JXcfdGoPBI7fHCXlkHyex9avmHBwhypHMKRa536hxR1KrRGd/kygFlePDnf0R59LfvU
 itIc5n1hPkUzXA6jRi6cnp+PHXuoXDpJnVw/QnTSlQzIsvDOXK77R0ljWRqByHZgS7zV
 ENDYyQTY9W1aACJCynMMXUynvgEyNLshtUMdDdOJroynjWxjAmSwTlw+ZO6/KebYKapz
 1LEjSJ71K/Xa2FYPsAZcxOwS4Lt2cJaX3TtbYJWj+iy7WmBfM1D0yeVVfmDxDK/lZ7O4
 40nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FT5RBDPLarx9ZUotipKbQizZ2EW4ngLF++vkc/s/V1lt00vhOY8NJ85KS/lJQ72QYiMJwHjcaffoF@nongnu.org
X-Gm-Message-State: AOJu0Yx0oyNhZggM8RRejmvuMF9yxVmvCy4q6j3uVKud/5uG9uHcDBtl
 6iHA136VZpZRTjNIiTJxwsVolomkHV1Ub32W4Mx7V7jylfraF8BfQZs4gAD9eKRDaS0=
X-Gm-Gg: Acq92OE7l5eBeUnibfOnPmiY+v+pLF5gsI7gAgPSXwqd175WFDwcvlRZij5Mqnlafz+
 nflXiNjIIXCysN4Z72kG4OqNxe2+8s5IfhI45f2gOmBKZGdEOp58pttRvHeBzlE/Kgpczd3JAQe
 0xv3fGhR30Y6y3DmUje84tzVsV8VbzD6MqQ3CQO86EFSNiyhZZd+CuMnUOdJ6sOWareg98dOIZI
 gLR+x64Be6gwAKa1337TZNvNbEIQXAHcmH9+a3wbynRmKLGHZTsnkODcaHGnP/ehu8H4pl4E3Re
 PdnLOpgm8rVfw/1Bi5brhgXYaOdQvWPsvtk6Xmxr4Q8+w8aoTiG4G2Q7E5Lf8XQ5AE+GG+W+Lc1
 koRDMReYJnMRsfxbDiQ/UAxXcjFv4OdioD9wpIJBucjgyV4lKrbvesFseX5f6J7Z8mk6ebuPXwn
 /yKS3B7cTGBfURkw/fh5ms6leJ8ZtPbUH3PISisHL+hv+puYA=
X-Received: by 2002:a17:90a:fc4d:b0:368:1979:5e8d with SMTP id
 98e67ed59e1d1-369519cd892mr8909267a91.2.1778957649103; 
 Sat, 16 May 2026 11:54:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951278e7fsm6184861a91.8.2026.05.16.11.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:54:08 -0700 (PDT)
Message-ID: <4bcc34fa-5f9a-46ee-8c3d-0dda3f1834fe@linaro.org>
Date: Sat, 16 May 2026 11:54:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515125727.349675-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/26 05:57, Peter Maydell wrote:
> The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
> x86 and microblaze.  Convert x86 to the newer translate_for_debug
> method, as a step towards being able to remove
> get_phys_addr_attrs_debug.
> 
> The new API allows us to tell the caller the actual size of the
> mapping via lg_page_size, so we do that, although no caller will care
> since it's always at least TARGET_PAGE_BITS.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/cpu.c           |  2 +-
>   target/i386/cpu.h           |  4 ++--
>   target/i386/helper.c        | 31 +++++++++++++++++--------------
>   target/i386/whpx/whpx-all.c |  2 +-
>   4 files changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


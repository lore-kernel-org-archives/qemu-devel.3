Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF71CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 00:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRg5s-0001RR-TT; Mon, 25 May 2026 20:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5d-0001Mn-Dp
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:56:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg5b-0006z2-S3
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:56:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8413ac3d82fso4495864b3a.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779756970; x=1780361770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/1Avm8kyzu/CDsw41SFYI1uhyZ/f55vu9sHKLWuB9w=;
 b=fXXXukAhWwCbCkEGOEetmPdaqHjU14NB3lhpYgc86AxJpym6uJaUWFQyCo9yq0s35F
 MntHVBfAIrdQHY7jk/IRnCi9dbb2+uLtsev04wJSZqNJrY6UccN9APN0Jr5juKO7hY5M
 Y3s4WsUNRq4YuBgrYm0WBtwBYbbkJbkxCpU2bn8xkTo8GEj6xu90yLw0d18SohTcOc14
 OZayQ4eh0xw8aPcsTAU0wOFo25ddwMWpFJqmdz+5efidtlNp2YH5A+IiM9AgIupLQAQR
 71ExYHwsNgO+U1gR9QN65B65WyIBT/pZ4jh42rOmdgx/fgHDtIcWzHOtrvJM/iW2lPgu
 gHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779756970; x=1780361770;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/1Avm8kyzu/CDsw41SFYI1uhyZ/f55vu9sHKLWuB9w=;
 b=m7ljskptgCtPlSZcoHtBeei0CY4KzyFUfwa0+R7vB9KJgHFQufmQN1njnSeSHqXMTb
 NqQKQ/rviNfv9SR81uBuCvpPFhAlePwwL1H2qbSBgaiZaRQMTl5VuXwK+chNw8qqir5c
 QxhTBQlGH4d2RWPgy3YWSmfr0LsFpL9HcVv8mRSY4wc+ek+t1Ha7qPk76phD7IcftNOc
 UxJAIPmJ70YZcF6usZ1/KWQVcjo6j4rduJ9j9YcGILSYoz7Oir9U/qO34QDnYvCKQfZG
 NNWi+w9BWL5pfG868GuiaCKseunC2olTsQgEslJ8aCc04oYUYRxmHkVW1L0ouyfminh7
 EHpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xzjANFtV+vBYg0jO8CmHPorMgPanEU9lnbZMSKWFBppo1HuGsZ+icZ9f+bE7Iq4Ekf7SMxZnYrWcZ@nongnu.org
X-Gm-Message-State: AOJu0Yy2WIdNLSwqpHffunFrKRDzIh8NWIp3Vw9ycoJm9+lOqGNOPVFC
 FAzvnVlEFaEA3xjW3XvFLAgIhC1yCnSQi1mHzP7HN5KDcZ1mFS2ihqtuZmE3gdGdMYA=
X-Gm-Gg: Acq92OGx/xGOqjnboH0LNeyir/DUn/ZaZYk5mA/rOaVouCQ66b9Y+qM99XmeD8a973D
 uGY8HiXyk/iRb60SOF2Sx1GhsfaTio6oYdTlUup6m+XlJJMQTFbLNwO9RTN6KVSA6FtrsqgMJeH
 NKQ07x2U//vaL0/xRKqDh156eecJDHD45UDCrHgmhGzb9888yobfo3ofkN+YqxsN8SdUG0aCPRE
 NMZ/2y9jiYbNb+XmqvqvhRQKR2SeUO8kigjMNuoJcycyVldKjGrY0lCe6l4A3Q/8kH9cd9AFblg
 7BvJPZZ4FLIPRv3aWAQe+gDinRfHgsrO9xCllGl1huPiz/UacGb0FxtmPp7BwHsr/TFyc7lNfa1
 QJqzFycb6lHfZ5uNgDKz3LH8MRrjbKK0iyBI8zDeooJN9vf8QKWX7FvMvZyNOldt19mwNlJGGDA
 ypJaBFyLKCxwkUrqJsvjCegDqxrNMH4bbj29UW
X-Received: by 2002:a05:6a00:4fc1:b0:83e:b47f:8994 with SMTP id
 d2e1a72fcca58-8415f0e87f7mr16932408b3a.6.1779756970330; 
 Mon, 25 May 2026 17:56:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe2dasm10579140b3a.19.2026.05.25.17.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 17:56:09 -0700 (PDT)
Message-ID: <5371f5ac-a160-4d03-a01e-106e58a6b461@linaro.org>
Date: Mon, 25 May 2026 17:56:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user/sh4: restore FP rounding mode on sigreturn
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-stable@nongnu.org
References: <20260525152642.4121729-1-mattst88@gmail.com>
 <20260525152642.4121729-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525152642.4121729-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/25/26 08:26, Matt Turner wrote:
> The SH4 FPSCR rounding-mode (RM) and denormal (DN) bits are not held
> only in env->fpscr: they are also reflected into the derived
> env->fp_status via set_float_rounding_mode()/set_flush_to_zero(). The
> guest keeps the two in sync by routing every write to FPSCR through
> helper_ld_fpscr().
> 
> restore_sigcontext() wrote the saved value straight into env->fpscr and
> never touched env->fp_status, so on sigreturn the interrupted code
> resumed with whatever FP rounding mode and flush-to-zero setting the
> signal handler last installed. (regs->flags = 0 forces the FR/SZ/PR TB
> flags to be recomputed, but fp_status is runtime float state, not a TB
> flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
> problem just fixed for the integer status register.
> 
> Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
> into cpu_load_fpscr() and use it from restore_sigcontext() so the
> rounding mode round-trips correctly across signal delivery.
> 
> Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by Magnus Damm.")
> Cc:qemu-stable@nongnu.org
> ---
>   linux-user/sh4/signal.c | 7 ++++++-
>   target/sh4/cpu.h        | 3 +++
>   target/sh4/op_helper.c  | 7 ++++++-
>   3 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


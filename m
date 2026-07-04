Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487ADC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg69g-0004q2-Lv; Sat, 04 Jul 2026 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg69e-0004pB-Mc
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:35:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg69d-0005SU-0b
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:35:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so1376901b3a.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783193755; x=1783798555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFWMJXpXmfVutf27mDlB7yuqabWZyQvznY7klb+92oY=;
 b=cYQjZEfmQpJ09WjrrqMRn99u6qzvuthywIg423lKyvCdM3bJd6AIcIkSSPO2Bn34aH
 SHM5LSeLU4gRwVEx8HUJb/P1YSboNmc1v022lKLhXPRjLVSGdRvScKOb+woQYN8SJP3f
 fTqkJ4kPqqocpfCFE3KEUhjtOS0TVtgh6o4cx25eoHW15yvTIARyrqS8XmZs/Wn3si7y
 fPnQBaDRvIgQTE1IoX4P7h2r+JKiFr7cRFmbE8RY6sNXBw7GLFctFjIci9Cd2b1RjOWy
 jq/XKRUzUkuQ2+/vKFxrBrJmZ1kyHmFy4BE466Y4jJpNqYrb+1Ezp6LdzEApzhS4kMFt
 YLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783193755; x=1783798555;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFWMJXpXmfVutf27mDlB7yuqabWZyQvznY7klb+92oY=;
 b=BYgxNq70iARki2j+NV+2ZTOLjeh/MXbz2f6RdMytbkEHf8Td3JJ0C5sDcbza6IENNp
 nr0wtX5zBC8j0kvpMXqQDmvyBT/7tp+27D4qLa1fjYxCRRhjqXRJ/MNxPkheN6UvIc3t
 clgyHJ5+lnaxmVjRHKAxYEO7VjA++XASJXzo5zLbXso1RoisChuUWnhjc5XVQV3CUDmU
 UmzkpwaxDLe+1n6wmZ4PmaaoOf4rn1wPPk9hqeKUfYDk7Z/eZjp7z3S3kfne0Hpb00cB
 E1rsSZ/bPO2YNzv+RUxKRpwEhinWo2c9kZiGWCmZwlsLM/7y3TB/nZzyvGf225DRUnY2
 aMBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Vt1afZlLgG8LX/OWcO374QaPcQT0ucMKD9+6QbVSHAl5TgtvBl92vC4c0jjA7RMFxjHRTfJ7vSNwg@nongnu.org
X-Gm-Message-State: AOJu0Yw8tVCb/PtYbWFWUri5uUOecbuxEMWI/tjFXtoesuiIpfT9BYRQ
 42kNW0IbxB4E1cjKXdeD9iGUYC8KDDvSNK0HQNzxv3Ny1pZbOPBcV9S9BqCe6U48K8g=
X-Gm-Gg: AfdE7clkTcBLzHeEp9vXDHkBkf1RI3B71AfbUISmQ8VshpdxxQeFgCTdvqaecAea2Ka
 i83Z4l5rss7Mw5UTrpxpOP4v3c0gGoMt7nWvqtUsw+cRhnKgIInYvNzJwWhRRS+aUs4wMlV0C85
 6JomTGVtam2/gvwm5ZzzpF3Tcst/lSW+2qMdVWOVqGPQcS9EZGunJHR/MYHtAjbQteBorCN5ha4
 LVu2SGa05H4ZmTi9k1iJGD4kIc5PjGU4u3cwULb6PumsJtQet39i2gLnweRAV0kRTtJ1HY0dQmW
 5hl/VjHEHGgfX99i80/ljKAimyVy5IN51XRaEvTSAj9oaEReSz/Qb1JIm/QnhqMK8aMgkBXU7uo
 DoPoPSn0cvAfWjWLyRbiGwOfX9RbvOeyiez/zAQoZWFkv9kbYnAboyFycYtpEOZYDjMMMG7YWkl
 RaVFlvf9psv08O2YLVd/n89JCn1w1dJ4Pp4Cz3PuSpbGOzAOqFmShAHcE=
X-Received: by 2002:a05:6a00:2886:b0:845:e210:3771 with SMTP id
 d2e1a72fcca58-847f86a5073mr3179723b3a.20.1783193754855; 
 Sat, 04 Jul 2026 12:35:54 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b609acsm1477923b3a.1.2026.07.04.12.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:35:54 -0700 (PDT)
Message-ID: <472e1c81-89ed-4db5-8719-b5629c0d3642@linaro.org>
Date: Sat, 4 Jul 2026 12:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/33] gdbstub: Inline gdb_supports_guest_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-13-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> gdb_supports_guest_debug() is only required for system emulation,
> inline it there and remove the user emulation variant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   gdbstub/internals.h | 1 -
>   gdbstub/system.c    | 4 +++-
>   gdbstub/user.c      | 6 ------
>   3 files changed, 3 insertions(+), 8 deletions(-)

You're not inlining it, but making it private to system.c.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 9b25bf58b8e..60ddc146661 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -217,7 +217,6 @@ void gdb_syscall_handling(const char *syscall_packet);
>    * Break/Watch point support - there is an implementation for system
>    * and user mode.
>    */
> -bool gdb_supports_guest_debug(void);
>   int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
>   int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
>   void gdb_breakpoint_remove_all(CPUState *cs);
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 2063b63b2f8..1179c82cb86 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -331,6 +331,8 @@ static void create_processes(GDBState *s)
>       gdb_create_default_process(s);
>   }
>   
> +static bool gdb_supports_guest_debug(void);
> +
>   bool gdbserver_start(const char *device, Error **errp)
>   {
>       Chardev *chr = NULL;
> @@ -627,7 +629,7 @@ int gdb_signal_to_target(int sig)
>    * Break/Watch point helpers
>    */
>   
> -bool gdb_supports_guest_debug(void)
> +static bool gdb_supports_guest_debug(void)
>   {
>       const AccelOpsClass *ops = cpus_get_accel();
>       if (ops->supports_guest_debug) {
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 97eb13e796a..f7bc4e63dfd 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -796,12 +796,6 @@ bool gdb_can_reverse(void)
>    * Break/Watch point helpers
>    */
>   
> -bool gdb_supports_guest_debug(void)
> -{
> -    /* user-mode == TCG == supported */
> -    return true;
> -}
> -
>   int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
>   {
>       CPUState *cpu;



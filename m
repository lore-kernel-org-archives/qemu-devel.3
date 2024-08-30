Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E4ACA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 05:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjucs-0003Ck-L5; Fri, 30 Aug 2024 01:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjucq-00039B-06
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 01:56:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjucn-0000zW-T4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 01:56:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d41b082ab8so1092197a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724997404; x=1725602204;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XqcyJD5DyxBXbyRLYX5PCWo1ecqcyiHZra8ghQOL9gg=;
 b=hNBAuR4UjpBY9Anni7JW0h+LQxh+x0KyH8nQNlXxQ9FeeGVm+CYFzXLKVbeb85qwJy
 hCAVCvydfmXgWnujHAqTxR+18JQoKf3MbZwSUZkswrPXTVlerYZTYhjCckERdTXAne7G
 sP7ANWOSVa/yBOM/MWS9iVOFqolNmgZq98jLZp8E3gHDhucpts0niGXNA32ay164zVnq
 EFVnbKT+s5XyR2Il7OgRGykN1k2D9kWlyrQNshH3rqPxEnDAZdVkzAJC7YeDFyqJ46up
 NT9OthFBiyxMBm6i+o8sErUMsoDHYxWcF25PHBsmHjwrEuOV/yT+puG58Hyw03vpuXPJ
 aeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724997404; x=1725602204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqcyJD5DyxBXbyRLYX5PCWo1ecqcyiHZra8ghQOL9gg=;
 b=blg6Ouzj7dr8MrlGzNe0WopYEbJQsmYuhUOjgfAkQ9v2+9i3p0TreGpHNugaW3pVqH
 hNGgIctAxhzLO4VZJS1jUG/jR1GwZoW1ZlyG08cRmcNgFOP7KkPlV5xR2YXRyEIzwXrX
 dJTRqochKF1RGAMw/nHVQ4xfsWU0zFRQUlY9MNUgP+GHM1JhkarU/p5ZSC35hWYL+f9S
 cgME0dr0j88h8sUVcdy8+fFwd835CUGHe1CTu6PjvctueFBnfRbc2oVDawCQdd8fk3cF
 A1HgM6IQUJ+ARpjsYxBEU9QgavDsw/Jy06YGeYkAhgzNw2GEs5cOcRMT7oJ4YIsuqPrF
 5kBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCORAdRQa+7NG+T5VTLpStM1ZyGgXpZLpbNl7S5I4eJ0LQoKQhxwWqAPkTlQ7RNOxh1n8wQb1YdQxM@nongnu.org
X-Gm-Message-State: AOJu0Yz4QTvGwEtJk9JOHOOhyYR9MFlCuNsDgAqNvMKb4v+xWn2vvYWf
 f6y8JB9zqRrT8qWtqUFZGIb+5UAF799Egj/lDJmVrluylRooh6nQC2jNXZ3C0Xg=
X-Google-Smtp-Source: AGHT+IHEgiEKx2DuVgu3if1os90uQ4eqjODKvqmTGEmBS9VBl38IsG15cbk6E/uyy9DNQIKIegA2Cw==
X-Received: by 2002:a17:90a:d196:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d8561db9ffmr5637201a91.25.1724997403542; 
 Thu, 29 Aug 2024 22:56:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844624dc7sm5321530a91.30.2024.08.29.22.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 22:56:43 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:56:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v12 11/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
Message-ID: <ZtFfGR94f5EwIl90@debug.ba.rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
 <20240829233425.1005029-12-debug@rivosinc.com>
 <abc033ff-7638-4d2d-b2d7-65b3c88311e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abc033ff-7638-4d2d-b2d7-65b3c88311e8@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 30, 2024 at 03:20:04PM +1000, Richard Henderson wrote:
>On 8/30/24 09:34, Deepak Gupta wrote:
>>+bool cpu_get_bcfien(CPURISCVState *env)
>
>It occurs to me that a better name would be "cpu_get_sspen".
>The backward cfi is merely a consequence of the shadow stack.

Want me to change cpu_get_fcfien as well to cpu_get_lpen ?

>
>>+{
>>+    /* no cfi extension, return false */
>>+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
>>+        return false;
>>+    }
>>+
>>+    switch (env->priv) {
>>+    case PRV_U:
>>+        if (riscv_has_ext(env, RVS)) {
>>+            return env->senvcfg & SENVCFG_SSE;
>>+        }
>>+        return env->menvcfg & MENVCFG_SSE;
>>+#ifndef CONFIG_USER_ONLY
>>+    case PRV_S:
>>+        if (env->virt_enabled) {
>>+            return env->henvcfg & HENVCFG_SSE;
>>+        }
>>+        return env->menvcfg & MENVCFG_SSE;
>>+    case PRV_M: /* M-mode shadow stack is always on if hart implements */
>>+        return true;
>
>From the manual:
>
>Activating Zicfiss in M-mode is currently not supported. Additionally, when S-mode is not
>implemented, activation in U-mode is also not supported.

Hmm. This is a good catch.
It seems I was using an earlier spec and missed this. Or atleast
I didn't bother to check assuming that spec didn't change.
Thanks for catching it and pointing it out.

I'll fix the M-mode case by return false.

For case of,
If S-mode is not implemented then activation in U-mode is also not supported. I am thinking of
making this check during extensions validation (in case user turned zicfiss=true).
Below options:

Option 1
In `riscv_cpu_validate_set_extensions`, check for S and if S is not implemented then error out
saying that zicfiss can't be turned on.

OR

Option 2
In `riscv_cpu_validate_set_extensions`, check for S and if S is not implemented then silently
clear `ext_zicfiss` in cpu config.

I think option 1 is better.

>
>So two of the cases above are wrong.
>
>
>r~


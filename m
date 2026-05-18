Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C732CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0TQ-0007s2-I2; Mon, 18 May 2026 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0SZ-0007HY-2I
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0SW-0007i9-FX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso27666775e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779120287; x=1779725087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BSkzU7VQ6ZWnETdfkx0kf2VPyldFMe4A3wxE8DWn+VI=;
 b=AiBlPz3yhfKX+vpl9wIyJcKrxeD1ZUtO0iXypTKWP1NZwA6DakrQ7TRn6k7mtfefIQ
 k/QWutNg88De5uWdRXTyjSlJoX407Adsc4wyFa28Ng7wsxSZ+ZYxtNDkBX10kKKz0v74
 elBSFgg1VHIBOJegoC1MHlRCILWW+TWJ4IwKbAdjvmnXtMB1wTYxGavlort4JJgiI0gG
 iMzcC14j9+fF+KdfUntayKkLqLlyuAwC2AICiOLF4h3tPCBvtExXq6Ohdkw0hsf/1KsO
 Q7IXJZfPm8W8Kmscc+y1Wgg+IUvB/9dF1sZIFtIIjfnGe5maSm3O+4RN8XkYYYS2iwJR
 vMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120287; x=1779725087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSkzU7VQ6ZWnETdfkx0kf2VPyldFMe4A3wxE8DWn+VI=;
 b=TFlRStHBj14FCnD1MWyJN2AhBnYRG05lJbVa5LdgPv1+RBkYE01Y0TzHRoxO2NwY2J
 h8QYOGLYKPfzmWsS1GlkvsWGvOvoh9GiIXQ827dncxE9DfGlCsbKUuxsm+64z1tWNgFL
 XEfgU5cIojh1gwYd4L/gaG4ZLMzO2uoZL4zE2Z49mIrSbiS+r4MlIhGVTocxvMWHrj+X
 4QwXg6eZgNg2Q+fUEke9Q6BMk/Z5RKVwdxKvcaCnu0rQPM4AmT1OVk+mKHk8HddcojNX
 /gzut2mIommrLQbY2c5qZc67gh6YqPqwdLKZcTxiRjA/Z9dmIfy5tByMKTmolq1v9U1K
 j5EA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LCKUogkaxshK3xM/G+8IRP8OZqDoAfSR4SjZMweBr/rTD4udZXjJXJXnRf9TvxIRJJnuJ/DeewCG9@nongnu.org
X-Gm-Message-State: AOJu0Yw/UYsKG+WAljZ5GKE6BkfVhEqvPCZw6jwPO2MOs9zwM+T9YKRn
 iP3fcanSUcdehG6jPuCqPw0nPLGZo2ixOYLVxQ84SRpZdjf2LQdG8eO7KVV0Jx5B6pk=
X-Gm-Gg: Acq92OHvjwIWrifJl0LEtbKGhIS9HAzcQ7eh8Z8mjkfq1ohvwF1Kg9SnpzXhVWMQgeB
 RAoYWthNuIWBhPXtEAJoYnYWOJQe9HHZojSM5QjZwKWzqcxmAamFiikxiz0/9AMPhyVWCQjbnpz
 PqaBYM8tufbnJXDgUpOtqBaqKcMGHPn8A0GupmnTtpYH+IqqwMs4OX1oNLSsM+fvrCmZ4lzgDUC
 UxHNfV0q7z3KtjbV1k2muBXTleXamoxvrSP6CYZh5PfEPwLcOmVfMXoIWKzFkctnjbJwvQbJyFT
 yYnG0uQP46/ahpR7FGT4PT8auc5kUL3wW5DDC6zLOIN6Tw0y3lIvm913wCwxemJGFgOF0vVtF1/
 3J8G0zEFGkFSwD8YGj8E2tEokgF+3NvTB+0197f5XN/3UpLImarZizY/adpekG6Po7eIZje2+Gu
 T8mZjvjBkNrQVYbpxRhiwRXTzAKPcnOjTaBe1ewGCz4KD+etwgIyNF0xZdffDTUWwbXeq2B+Sqw
 a8I
X-Received: by 2002:a05:600c:1914:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-48fe4dac5efmr237944945e9.4.1779120286793; 
 Mon, 18 May 2026 09:04:46 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm37061050f8f.2.2026.05.18.09.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:04:46 -0700 (PDT)
Message-ID: <a259d807-70f1-4dab-9032-551aee09ea40@linaro.org>
Date: Mon, 18 May 2026 18:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/mips_gic: Avoid Coverity complaint in VP writes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260512111536.3437645-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512111536.3437645-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/5/26 13:15, Peter Maydell wrote:
> The MIPS GIC does a check for a guest error in the write path for the
> SH_MAP*_VP registers which triggers a Coverity complaint because it
> assigns -1 to a uint64_t. The code doesn't misbehave because the -1
> case will be caught by the following OFFSET_CHECK(), but the code
> could be improved:
>   * there is no need to special case to avoid passing 0 to ctz64(),
>     because (unlike the compiler builtins) QEMU defines that this
>     has a specific behaviour, returning 64
>   * the OFFSET_CHECK() macro will go to the "bad_offset" label and
>     print an error implying that the guest wrote to an invalid
>     register offset. This is misleading about the actual problem,
>     which is that the guest wrote a bogus value to a valid register
>     offset
> 
> Make the error check print a better log message, and avoid the
> special casing on ctz64(); in passing, this should also make
> Coverity happier.
> 
> CID: 1547545
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/mips_gic.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Patch queued, thanks.


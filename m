Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE9CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 04:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5caV-0002mN-WF; Mon, 06 Oct 2025 00:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5caS-0002ln-G4
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:12:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5caP-0004vy-Q6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:12:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso27482895e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759723951; x=1760328751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5k2zVZPoomL5ClOhZsRuk1CRanvZLXRyOFE08DzG/8=;
 b=rBMLKYfABBJG0V4BA3OV3bJOE89iXdTF512T+J08PdFpBM6wjc/wUCxbqA61NioD3U
 hcEwBJ/FiIHa+LDdNqoL0xfg+o4WFlqA8W7H7fCn1HTPQDQO0oqzJ1HUefhuM2aSH05m
 2HhKC06rnxYGpb9GLXdXdNkfRQGl91w5Jy5ksG0uiBAiNJV+AitX0j85YCl49UUfYF4c
 z3RYeWrbf/wDUOSpXCqKeC9KKbudI404jasLliIpKan0uBtiFG5FSyFvbo1KiKRxjfEG
 OCJajWfqgWYzez/32E7eWdxPyFbvU7x0Zaxlv8QgU7j6mFcCSQBFr+jZ/J96KvISKDEY
 wnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759723951; x=1760328751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x5k2zVZPoomL5ClOhZsRuk1CRanvZLXRyOFE08DzG/8=;
 b=EkizJyFL4ZTPz8/l90JRv8z5yHypBjUJG+57ZUWTjKkuPsi6GgApTxNPpmh80RKdWE
 AFT3q8K4c0C66MsnYA0df25QIIpmbHvKywus1D55DTwuUkH+lzz68AWdEO18G1xBJzms
 +Vbn7llsLxmQoO3DwDI/GnH/jXlecDVO4TbezcNNjN/xYFdL7AbP430dMHD7FeHkyTJa
 NjIBQdKSM8kBGb+L18RX52GCiYoqjC94nUnMD6hKIKld9rMqV5O3GImM6iJrJdihnmlj
 r0QbTXBFWgwYkumaFongrkVdlwx0UwIXdPv8HjtFRaUK79Iy/VjvZgpLxpGBUPIJu5Qk
 PBrg==
X-Gm-Message-State: AOJu0Yw4zZrkqJ0YH1noUhxuHB+UgC0aGj9/ReLkLStRBfn6pUCw3vUc
 IdrXRaz2O+lk+t95JiKIo1Qgs22zTVd42EzCoVFKLGzIX24D1xvIGU4BzQkZ/kGqCPRWEuV2aCh
 bf9IWUk7x5Q==
X-Gm-Gg: ASbGnct7kAEKqkKCCEuPQUMAjzSjkZjBsURhZcOgZ44fW0Ty4LdpkAuUsVAjMWF4giM
 ocmY/zm7wj0EPrcpvGEus9REYNKHFfUEfBQgFgpmug5TG04axeMXILvzzb417P84wWn29OEdKCo
 wB8l7Tp7DUESQaFaZVc8S9NGAtdZc0rJJ5hhgI0oBEOGwacOFWtnFBDtXK1bhJneRZtCJhqYxVK
 vv87KS99uuoTeJysmlQvUyhmMD3uMubm9bZxSBYJo5nS+SQ4r+tLAUPtwZGQcQGhXAuUDp+Wj8Q
 FEv7e4SnVYB4nquRJLI+jai5Xq2YJB9+g0gs6YEqJ5jP4DTNffnZ/BPmAjmZHg+wdARNJkG6JFS
 OD6+TlAN0j3h1uRH7iTdphiy6vD4VRkl6yzW3tLE4pObjVLS4xi258ETbJueu3CjSflvpHrUY0f
 pMNQu4GNgAlS/LCc65rH6Ija0pVRYk
X-Google-Smtp-Source: AGHT+IEibd69y4sK8Msn6mxNka7aBjCe+u6ar0mcYImy/QOUSujjnfPkK878EX/jztgeWCMjthRgxw==
X-Received: by 2002:a05:600c:6818:b0:45f:2cd5:5086 with SMTP id
 5b1f17b1804b1-46e71103fd8mr72965665e9.3.1759723951241; 
 Sun, 05 Oct 2025 21:12:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5e4922sm130891085e9.1.2025.10.05.21.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 21:12:30 -0700 (PDT)
Message-ID: <5ae373d6-c9f9-42cf-8a5b-df87c8ccf6e2@linaro.org>
Date: Mon, 6 Oct 2025 06:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/alpha: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-trivial@nongnu.org
References: <20250925005137.59378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925005137.59378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ping

On 25/9/25 02:51, Philippe Mathieu-Daudé wrote:
> All these CPUAlphaState fields are of uint64_t type (except
> the @fir[] array which uses float64, expanded to the same
> type definition). Use the appropriate VMSTATE_UINT64() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the Alpha targets are only built as 64-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/alpha*
>    configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
>    configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: "target is" -> "targets are"
> ---
>   target/alpha/machine.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/target/alpha/machine.c b/target/alpha/machine.c
> index 5f302b166da..6828b123ca1 100644
> --- a/target/alpha/machine.c
> +++ b/target/alpha/machine.c
> @@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
>   };
>   
>   static const VMStateField vmstate_env_fields[] = {
> -    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
> -    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
>       /* Save the architecture value of the fpcr, not the internally
>          expanded version.  Since this architecture value does not
>          exist in memory to be stored, this requires a but of hoop
> @@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
>           .flags = VMS_SINGLE,
>           .offset = 0
>       },
> -    VMSTATE_UINTTL(pc, CPUAlphaState),
> -    VMSTATE_UINTTL(unique, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_value, CPUAlphaState),
> +    VMSTATE_UINT64(pc, CPUAlphaState),
> +    VMSTATE_UINT64(unique, CPUAlphaState),
> +    VMSTATE_UINT64(lock_addr, CPUAlphaState),
> +    VMSTATE_UINT64(lock_value, CPUAlphaState),
>   
>       VMSTATE_UINT32(flags, CPUAlphaState),
>       VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
>   
> -    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
>   
> -    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(palbr, CPUAlphaState),
> -    VMSTATE_UINTTL(ptbr, CPUAlphaState),
> -    VMSTATE_UINTTL(vptptr, CPUAlphaState),
> -    VMSTATE_UINTTL(sysval, CPUAlphaState),
> -    VMSTATE_UINTTL(usp, CPUAlphaState),
> +    VMSTATE_UINT64(exc_addr, CPUAlphaState),
> +    VMSTATE_UINT64(palbr, CPUAlphaState),
> +    VMSTATE_UINT64(ptbr, CPUAlphaState),
> +    VMSTATE_UINT64(vptptr, CPUAlphaState),
> +    VMSTATE_UINT64(sysval, CPUAlphaState),
> +    VMSTATE_UINT64(usp, CPUAlphaState),
>   
> -    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
> -    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
> +    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
> +    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
>   
>       VMSTATE_END_OF_LIST()
>   };



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492FAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfL3r-0003Bq-Oa; Thu, 02 Jul 2026 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL3q-0003BF-EI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:18:50 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfL3o-0004h9-QU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:18:50 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c89636920a3so960842a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783012727; x=1783617527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqToSBy41mnzcjysvSgtm9XyEJhTvlEkcGx+xp8VYoI=;
 b=X8eqhysM7mhvdQnRY3thlEVCpyguMOsoqVWOVgJ8Agoh8d5sZ68xt/q5L4rWroxeSM
 r0aEZu8IEgebzl/5eNxOSZllZKCiABrnBdt+tWj7glDLKTQ1apZpWrx5fNDMZEeg6gt3
 zzYfpPTBlBIneTPECSgrbxKqjzrX2iYLYTyZzwh24m9be4uxdHxo8b6AY/51r458oG0E
 5kNzTciEW2ZAdx+d0zv8+QQJZ5Q0H439pfSJQFohOtZYZ7heMQHpyGuDV/yKt+N9zlt6
 Htb0rvMAkmYfPsFRB9jDY+/YTAqh9CNQjPCaDN+TzHO53PhIVMrAr0kwAat6AbY4fsR8
 GV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012727; x=1783617527;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bqToSBy41mnzcjysvSgtm9XyEJhTvlEkcGx+xp8VYoI=;
 b=egmuBqFYLuDz02DDMtHZa7TKt0ki/y+3g6VoVCHqyOyzbWs/wviriQXncncJyL2AMf
 ZSAjMMJeNgE1K3ME5pxidinttx6CMu7hupctllWLlWCkNqwrBFezArm184LRgKkrzVvZ
 lyYPxMtpmxT5jg27dNRx6FhcGMCuUaSfMtIdZ3xnVK8ybk2GqypjNtSdrSsISQ8JNuo3
 UYAXVT/APOkA+gFd/kEFsiW0uCXJmYo8VhdxyMPuxmlt0T/GSma5bscs2UGUfWYdbJv8
 5Zk+6ASSynyBUE1sA20LrIMjHu9Z1LZpSU2bhowItayFOEYkWDTbzD05V1knbhVfpSxJ
 zoVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BdxDrHWMDhUUmnUpFFhTe/oDGhaeNpOSOe/d0MmTvJjv1/VXZqtyF0xUhwZg2jGUPST3lmGrVb56t@nongnu.org
X-Gm-Message-State: AOJu0YyIyz0THe1Jit2HRoj7Cd6pny04wnl1ImWLGwC3gR9hMcHWGCAR
 P4LAAMzwf0C2MyChfNka/mIV1oFUar8cHiX4jmJDA/Um42WkN7B1iBpUqlgePpL+ZSs=
X-Gm-Gg: AfdE7cn+rTT7R2Pzb/G6oyj7EfUVZSPznY22GmGpd+cHtGXjOSDhsTDt1JBVlVsHXAy
 kb6pqfC72XSjtvCWeM/VQFV9WEhZTQuC+IKTo3S4JolLaNHiCcVSnJBYmpZ3FB36nOjI14S3Scz
 i7guksj2T7mFH135KeEHoRThOP9nolAdgzMgN4qzWfgREONA9lMRNU3wKdhZyI9Xb7nG8gec0dr
 NLZwmj8BVqVIR++FQ/4i0dO0AeVMg6Ixj8VPKaxGw3BWQCxB0ILuv6bF/3jxNVwUEEaS7deId+J
 Wr2grrC6T2iczBNdsL5oPaG8nNaypIGBwOwKkdc/Sedde1Nk4SWkrdTOKRSUskAgoKA6z/qEUY/
 V9piR7JeOuQgAVqXReL6BgekgF0estp5ufw3GdizmyD2PbiM5rlist41Ax4ukvh8ztkSybiFoF4
 p+PoCng2w6tz+rdlx+Bvl5Xw/auVQt/BKLgb577h3LSQAZ/Doz2QeqqVI5zw==
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id
 adf61e73a8af0-3bff422d1d6mr7115660637.36.1783012727197; 
 Thu, 02 Jul 2026 10:18:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e920d7ffasm1502529a12.22.2026.07.02.10.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:18:46 -0700 (PDT)
Message-ID: <9b9d1942-38af-4b64-8ebb-21b2d7761af9@linaro.org>
Date: Thu, 2 Jul 2026 10:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] accel/kvm: Simplify kvm_init() w.r.t.
 TARGET_KVM_HAVE_GUEST_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Simplify #ifdef'ry using TARGET_KVM_HAVE_GUEST_DEBUG in kvm_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/kvm/kvm-all.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 5d55cb45cf7..6cd5f95d06e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3037,24 +3037,23 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_vm_attributes_allowed =
>           (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
>   
> +    kvm_sstep_flags = 0;
> +

You don't need this, since the global is zero-initialized by default.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       kvm_has_guest_debug =
>           (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
> -#endif
>   
> -    kvm_sstep_flags = 0;
>       if (kvm_has_guest_debug) {
>           kvm_sstep_flags = SSTEP_ENABLE;
>   
> -#if defined TARGET_KVM_HAVE_GUEST_DEBUG
>           int guest_debug_flags =
>               kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
>   
>           if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
>               kvm_sstep_flags |= SSTEP_NOIRQ;
>           }
> -#endif
>       }
> +#endif
>   
>       kvm_state = s;
>   



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446AFE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJh3-0002kI-QN; Thu, 05 Dec 2024 16:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJgy-0002jT-7w
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:47:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJgs-0004fx-H8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:47:22 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1153834f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733435236; x=1734040036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S7oloZtdAFlggY7iYEm/VYD6hoPyI4SX55Z1OM7NXHI=;
 b=esusp8GX+yvESpVR+X7SVP7or4RWLnZpPLP7GjrvnJKUH3nC70pVUZhtHyGY1H4O9m
 Q+ApY8dRBgJcZRui0nkBr0G/R+93RmJAoCb1dAtRwwj0IFHch29Fc7vxN8Myjw+SfABp
 E1pAc5zm+q3a7/HgRKNk+qRRA7yl2OXTxvlda9gBJgGB3NsTFs+srzq2AE0puHXRApAz
 U3c4c/2edTF4NFdJ1sE0ee5gFzDLkLpg+1qgIi2hoKAl9v28T6/DJTtoSXCYUoCC4m3c
 PZZtl2aSLtTQL95W8d6tOErmLLQ2usQxmqlscQBVRXIMFD7g/bEsqq1R3lT4TvOfXZ+Z
 wX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733435236; x=1734040036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S7oloZtdAFlggY7iYEm/VYD6hoPyI4SX55Z1OM7NXHI=;
 b=fJ1oJMIE8Qmr5EV+fs/FXvVWm1qi/eLJnMp/pRMUsu3WLfreEOuUcv2e0twPR9PqQ6
 cYFccVIzfcvr8oEwpg+56w0Y1gFXlmLeH842K1qnvIt6LsgHfoVUEE3QBfKKXOJc3fZZ
 hEOp9ovNsF7Iw5nqr6uvrvtQZvYROZ7taxJcwdutB0FkLo6hS9AYggYlQD1QgWf6W4O3
 8n5aJAPua9yKD24GjCP8oWG8i11fGFj+xJHxR+vueF6XNFgrxiU0q3Mt9dY4qIqomD7h
 OI6tFwnEritZY8PETk7KFgrb/wP6lL5XzDeV75REJb33NB2eSCHNqI0XiLOzGxhBRmAH
 73Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcxa7Y2zOdSBe48JjnAHEBZymQMp2daE1dt2hB1eW9YXmvP2H9XzhOp27PWjMqZOH5CprO8KeGDrrQ@nongnu.org
X-Gm-Message-State: AOJu0YzzdhJc/eUC37R1zAADCVg/tFXqGl9e2soGcP2GEDM8Cg+2sA9k
 RML7/ar0f15erktU+B80tCudpSCuCRIL5xRuk/qIyDUBkHM6WlRY/aJs1prnlCs=
X-Gm-Gg: ASbGnct/YRDyx9V8ngqLP/K/b3Tr9fMtPApejmbcbprk6ZGemNMHiL0AI43Dq7FQUvE
 pxZzGI2N0LfryL/4pyzmKB5Bm3db3VMO1KweDl19n4ps7Ldxw9ojs2cctGJGtYDyt0WlNmVJ3EP
 hJuQoLWLZBNtDiRPpzpF6IWYftqRkZCJCBj84MC4SIvFG/+jo8sW3nVadrSxoFdRTPy4RUhe/cS
 CW3uIiu6aW5UvIXei/8kqgYsWBQSgELE6tUI/oNNJhVKiQAImAkVzyAc9sOeZA7FQETq3fIroFf
 ru1VfK74RHR0nL60pQ==
X-Google-Smtp-Source: AGHT+IGUeXcPeKrzv7fW+qiEz+ipxnFA9sLwlFUbe5YhNXkWiTHGefXmGoK1mP+xoNEQrkoa6rBGqw==
X-Received: by 2002:a5d:6d84:0:b0:385:fb53:c67 with SMTP id
 ffacd0b85a97d-3862b33e4a1mr480936f8f.3.1733435235933; 
 Thu, 05 Dec 2024 13:47:15 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46cb2sm2958327f8f.62.2024.12.05.13.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:47:15 -0800 (PST)
Message-ID: <d130d7d2-acff-4dfe-97f7-346174fa079f@linaro.org>
Date: Thu, 5 Dec 2024 22:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/26] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-5-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Jean-Philippe,

On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> Returning an error to kvm_init() is fatal anyway, no need to continue
> the initialization.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   target/arm/kvm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8bdf4abeb6..95bcecf804 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -563,7 +563,7 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> -    int ret = 0;
> +    int ret;

With your change we can reduce this variable scope ...

>       /* For ARM interrupt delivery is always asynchronous,
>        * whether we are using an in-kernel VGIC or not.
>        */
> @@ -585,7 +585,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>           error_report("Using more than 256 vcpus requires a host kernel "
>                        "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> -        ret = -EINVAL;
> +        return -EINVAL;
>       }
>   
>       if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> @@ -607,13 +607,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>               warn_report("Eager Page Split support not available");
>           } else if (!(s->kvm_eager_split_size & sizes)) {
>               error_report("Eager Page Split requested chunk size not valid");
> -            ret = -EINVAL;
> +            return -EINVAL;
>           } else {
>               ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
>                                       s->kvm_eager_split_size);

... by declaring it here.

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>               if (ret < 0) {
>                   error_report("Enabling of Eager Page Split failed: %s",
>                                strerror(-ret));
> +                return ret;
>               }
>           }
>       }
> @@ -626,7 +627,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> -    return ret;
> +    return 0;
>   }
>   
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu)



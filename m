Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F58C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLMV-0000KF-Qf; Thu, 02 Jul 2026 13:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLMU-0000Jf-M6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:38:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLMS-0002BI-02
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:38:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-845e47133c9so518922b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783013882; x=1783618682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LvGx0R3T+lYHyCwPn53IOWPHWQ/HhjPuyD4cwn4b9I8=;
 b=H1WZoNsYpmYL5faYUy9ndEQEPGRlhJX1DnwerA3zV4OaogmLtR+58ZXCoL/LtHFyZy
 aakOAmMj+R7PFMX96LR695HjyfGV2Qzww6zpRcdbRJG03pRkR/GGxyaA/QP02GE8NtHp
 f7lpgVNskY8AKNU6CqOzTQ66xbucju7Z2G5oyfc2zWxd8ypQDUVTL+juZsRlv88Z65UK
 zYG18J7hkN9nz6mJ5FBj/o6KU/OWAE9smfT+bVBBZKPxIoLRyug4FgRnSwms3j8fnvu5
 T26aKok5glUrZvjq3OsL2FjRMxCd+Yi/2wPwcbzeQ7547onADfbJVbgo9yUnm3KlClC0
 C3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783013882; x=1783618682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvGx0R3T+lYHyCwPn53IOWPHWQ/HhjPuyD4cwn4b9I8=;
 b=OxQ2WHWVpVZSRhU87pLsBHIUu/W5P4AEnK360rB24mx3vmV1jQQJJOX7kE0mp/sXDF
 GjxYatRPM5sE+mF2j7tk7X+CRPb/3rYjLUaEVDsg9hlwjfHeVgxrDkn6H5bDaPHcn0JT
 aH2GR3CHRODa6OLPQJkp370mcu363adEEIrYPbmxy9qBMsXVijs63pW9wzq3/muliQ6V
 2XT8sZGxYR7E9jjlH6iXdGmfZgpLy6LIbsknPjLrdcSBeQ/dTbpi9/u+5FOOOUM5Rbfu
 Pb022o3FnqQeidH1r7XXo8PKJMHIn9E+RfJxmZB7ImGEEfmDILnLR6HO682hnFbS++0c
 5vZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBkI5Oezo4DMzJiB1Z3iDJNnCrIqo+5lqAC3IUTPbjCWppypXLOfiiwlzYb7RNWKawXz91Vb+w5SJ3@nongnu.org
X-Gm-Message-State: AOJu0Ywm+SsF5uKXesJTymSF3QPHNBU8FUClROBJBezKjC9IFvsrliWh
 vTEypR/qAPnKkDb18f8f/WUrYGzZzsSgI+seVvXoLGxUEKcGPYqnyKJFcda5JhwJ7d8=
X-Gm-Gg: AfdE7cm43Fbhyfx4WH+b/cnTsFudaYguIlKOejQn1rxDM82BUcNL09Ewod6WJbAZPr3
 Xruq/U/5zBnnyoXj3RqJTk3gqRslUIOaaMAIAAsQqU5K3ExtyDO1ImFLunlqy026qyMuYhRJG6L
 mrzCPelg0J2slKVh82xjclB5lzwzFFyDeXp4YNYCzxxxVFPks94sOIgaRWJVgC92kfuK2anfQDf
 LkD1+D5p22Cw8r1noam2/UO9f1rEmqW7cs1CRGp31cCfx85pL10zuB+hTv+XDBKcVYCdKRp/0UW
 12Sp6ri/1SurMdUDp8pBTFWmvYW9eai3Ac7IYqAtXexnrfj7Wair/iZYBMcMXOcZp90tpTZHPkk
 KPUFYlUyuOj4dbTK5Vaf3Ow8v9FuvjmRgw9OcVJ+PPVtjEMQmT9eesDbSXaGLHzyw3o+16A4PmO
 9ylq1h6tetQybCSl8oNrjdhgwYc7hH7gqFeDYTL7zeI6EoDv0/wbotM+NnMw==
X-Received: by 2002:a05:6a00:99d:b0:842:50fd:4c13 with SMTP id
 d2e1a72fcca58-847e177a490mr721520b3a.4.1783013882110; 
 Thu, 02 Jul 2026 10:38:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb983871sm1679122b3a.41.2026.07.02.10.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:38:01 -0700 (PDT)
Message-ID: <f827368b-859b-4051-b194-aa072eede360@linaro.org>
Date: Thu, 2 Jul 2026 10:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] accel/kvm: Hold have_guest_supported in KVMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-16-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> Prefer to store per-accelerator variables in the per-accelerator
> state, rather than as static variables. This is a good practice
> to allow concurrent accelerators in the future.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/system/kvm_int.h | 1 +
>   accel/kvm/kvm-all.c      | 8 ++++----
>   2 files changed, 5 insertions(+), 4 deletions(-)

This doesn't really preclude concurrent accelerators, since there will only ever be one 
KVMState instance.  But it's also not unreasonable.

That said,

> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938d..49e90cc0235 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -113,6 +113,7 @@ struct KVMState
>      struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
>      bool coalesced_flush_in_progress;
>      int vcpu_events;
> +    bool have_guest_supported;
>  #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
>  #endif

you could sort the members by size to avoid extra structure holes.  There's a lot of them 
already due to existing poor ordering.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


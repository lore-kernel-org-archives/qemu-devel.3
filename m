Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57366C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0F1-0006PO-Ed; Mon, 17 Feb 2025 07:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0F0-0006PC-Mm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:28:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0Ey-0007Pt-HI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:28:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so44632895e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739795326; x=1740400126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n9pR11CqElgBkGL518PlgwWMuY2BtIqMUUGOLOFfaMs=;
 b=sj5KGchPjcOwr8tUf84N/4XgC3LwLPpeJbpt6qGcj8HMEk4HWPHG5+hp95WS/R2Bcj
 YtWtYCLwzwUYhnTd6/zrvZMDqoiz6jRtsOWTsmjN+hW9DXwG/uQyTrTs8k/bBG5IpYjz
 E2j2OM5u7Xd//tp8yVEUxlMdY6tHKH0hWvZD1sce/j5IeJQJlsl4detur6ePs906eFAL
 2VHizYm6NqT6HrI1Nriyr9R8LeInbyGcJ/Pn6G5AF11bskiS9A8aNwVtsYBpYERIWUme
 N366ASRRLTOP/XssjhO5PzZjlj/PuRN0HP+6QRgOwA0SOU58t+1YSoVDbfEdPVcIU7ul
 GsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739795326; x=1740400126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9pR11CqElgBkGL518PlgwWMuY2BtIqMUUGOLOFfaMs=;
 b=aARpsL0jF6baxeoWYf0NDQ67dElkaKIvSbEDJmmVjRrxLoo8yRhmUcgtyL/N5eeuYx
 KGayaAGJktPHNAG2owLMHf2WLtHKQchpVdE2p58+h0WPGW5JH18qujGfHdX8iJCoYPzt
 FrfviawaEv6JTbFKCuAXXa4YTxZDGBenmUpaHtuwf7cMp9bIjNdc1iYzEBjsuZKWxogz
 2TIcA4pfOaugLNXaJTROpyuzLXHKbgPPZYKgh7QdUfU7IqS1opmhVJ5fNAeVIjmqAaQ2
 ke3lVs1qMcCJwoW134GhVZYb3Jg4szTgoXLQQY/6MsUQCA+Q1w4q3f1xCuaiOACOFTmq
 vNXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0vjAUWa/O9Xi80OMYcFoInya9+l400FvWSAOdmNCDkBsSm9i6Hc6N2f7utsGZZFT24xnF/Ir+rtUR@nongnu.org
X-Gm-Message-State: AOJu0Yw8+3NLvj1IGiWoCTQUkr+/Z4e+4DY3r4gNeJ/aasJQw+1q5Q3L
 4161yhmNkXqFbwNjhHOzSGoJsXWM1+wK7NMNweAhkg5XxGkYRl0amqWcQ0un4lI=
X-Gm-Gg: ASbGncv8DScUJOg+X0TRNhW+Z1J3Y+YWmp5kzxXxrt16st8/pCcSWAQnz5K+H5VEEBM
 bn50MB9kwdzN8o8s6jlbBLG/Kw7YHjMbPfc4cnv+qfgW3YE9cdKsz9sbgc8CAUyHEq2jT8XgWs+
 LKr1zPB9cpbzx+ErXpz7yEE1SA9nOb1C8odqK4Cs/ztFiiINw2mVGRheLdFrYcK/fCo5AC7fjOI
 9QbrpPsenobc1WDGBUe+9sAjFfNF6PldWnv82+fP8lzZn6FX9Yirnfj/z7ShwIlhugEyHs61WZk
 2mJBSVuL/NI7B4eWPYDXw7U5v6u0hoBS28I=
X-Google-Smtp-Source: AGHT+IHDM++yfLfonwXfte8D9fUTHHCdi1GORP0f/fZvACbx3IbqhzOo46EwgHIcdZW9LWqNOacc0w==
X-Received: by 2002:a05:600c:190b:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-4398ef65927mr1335245e9.10.1739795326036; 
 Mon, 17 Feb 2025 04:28:46 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617da91asm122701335e9.2.2025.02.17.04.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 04:28:45 -0800 (PST)
Message-ID: <051e10cb-7cb1-430d-956d-b508b7f7db5a@linaro.org>
Date: Mon, 17 Feb 2025 13:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace assertion with error
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Brijesh Singh
 <brijesh.singh@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>
References: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217120812.396522-1-pbonzini@redhat.com>
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

Hi Paolo,

On 17/2/25 13:08, Paolo Bonzini wrote:
> It is possible to start QEMU with a confidential-guest-support object
> even in TCG mode.  While there is already a check in qemu_machine_creation_done:
> 
>      if (machine->cgs && !machine->cgs->ready) {
>          error_setg(errp, "accelerator does not support confidential guest %s",
>                     object_get_typename(OBJECT(machine->cgs)));
>          exit(1);
>      }
> 
> the creation of RAMBlocks happens earlier, in qemu_init_board(), if
> the command line does not override the default memory backend with
> -M memdev.  Then the RAMBlock will try to use guest_memfd (because
> machine_require_guest_memfd correctly returns true; at least correctly
> according to the current implementation) and trigger the assertion
> failure for kvm_enabled().  This happend with a command line as
> simple as the following:
> 
>      qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
>         -M q35,kernel-irqchip=split,confidential-guest-support=sev0
>      qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.

I'd expect sev-snp-guest to bail out early enough.

Is a KVM-enabled check in sev_snp_guest_instance_init() missing?

> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   system/physmem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9daad..1ddf9fb10d0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       if (new_block->flags & RAM_GUEST_MEMFD) {
>           int ret;
>   
> -        assert(kvm_enabled());
> +        if (!kvm_enabled()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
> +                       object_get_typename(OBJECT(current_machine->cgs)));

Common code should be SW vs HW accel, so IMHO your check
should go within sev_snp_guest_instance_init(), removing
the assertion here. That said I have no clue about SEV.

> +            goto out_free;
> +        }
>           assert(new_block->guest_memfd < 0);
>   
>           ret = ram_block_discard_require(true);



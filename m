Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACAC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 20:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shEGT-0001xh-Ov; Thu, 22 Aug 2024 16:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shEGQ-0001xC-Q3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:18:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shEGO-0008Hw-Uw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:18:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7143165f23fso1058066b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724357910; x=1724962710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnaxyR8kAteIvFvhL7+fNGnR5GwuUXZ9C4MPnlK0WFE=;
 b=PSeQuXEShofgRdgzS5ef/1l0D6vihffZ+dlQlUt6dxGUj165N2uwu/9/1pxnrEp+Ie
 R753cQxcC3zMbyFzVbmKnGMKtlVJMCzptD/PxW8Qu+mYtyQLTSOpSXGTnsmSA77t5eeO
 Xqj1rcUCuViiETYQZhtV+TQUWvobagF6rPpFozkM01rbb+j3+Aph28vyNEKQo6p7puh4
 8jxeXIXLKKBkVG/VEMZqFwcEo8iG8+XpBQg9v6AgO1KyR+uQYdcyoiWVNPHrKalD7OkG
 ljtgAX8Zeu6QoTkZKvJm70zMhJaCe8Ab+oXa3iEr2iouGHmw3tMJXPQOstuxibNA9/ya
 pd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724357910; x=1724962710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnaxyR8kAteIvFvhL7+fNGnR5GwuUXZ9C4MPnlK0WFE=;
 b=LqkepdIq+XQRFxtF/Clsd8+arBL2tncq0v4nMtJt4Lv37LJlaKy0s8rVA6vbWcOR7f
 BKRxPbowLqtJA/ivhpJA7SdfpYXNcXBPpfOdMCn52Vs2PiaxKnuif6vhsbDCDE900qrt
 MtCPBRTWbawRMz6ntsEv+Mfhg6njLoGoRjtEU3Vr3MuaH4Qe/u0M9wokWjsV2/78gexq
 kM1lw2/fiiu5RY+Wmr7964WHpWGw+T+Er8OGXh1IUPaXY/S5ldApgjx67zI8ORjFCb0q
 pmyjNTRYm0oqujBa++RKz3IwD9HLMg2eEqAdOaOU0cNvVB1ogGcE44tJwIUhHRj1Madg
 jSlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjMMy1G2W+dZBrcPnYZCR7SYUYGuCXHCiZrx/c8qvTjKOWceoM0GaAw3CnJfrEoKAbj6ytr6SHuRtj@nongnu.org
X-Gm-Message-State: AOJu0Yy9/lRvanB0d5ddAsjUtgHZNqAkFUAkDLpBjogjBC7S2n5sHdmy
 xw623U6BldOxgCsRJxWwHLFsv5jiBit7irHpzvmODAPE5oTBeaErxGsAOK9bRUA=
X-Google-Smtp-Source: AGHT+IFUNbpAvpArihpx4r1MvwdSucQmw710uS6sjc19T4CXdRdF264q8CDI0F/ZVPcpYewEeJWS4Q==
X-Received: by 2002:a05:6a20:43a9:b0:1be:c9bd:7b8b with SMTP id
 adf61e73a8af0-1cc8a02bc5fmr230922637.45.1724357910342; 
 Thu, 22 Aug 2024 13:18:30 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ac9815dsm1531923a12.13.2024.08.22.13.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 13:18:29 -0700 (PDT)
Message-ID: <35103648-5200-49fa-aa67-f3f784323146@ventanamicro.com>
Date: Thu, 22 Aug 2024 17:18:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Fix the group bit setting of AIA
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 yongxuan.wang@sifive.com
References: <20240821075040.498945-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240821075040.498945-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 8/21/24 4:50 AM, Andrew Jones wrote:
> Just as the hart bit setting of the AIA should be calculated as
> ceil(log2(max_hart_id + 1)) the group bit setting should be
> calculated as ceil(log2(max_group_id + 1)). The hart bits are
> implemented by passing max_hart_id to find_last_bit() and adding
> one to the result. Do the same for the group bit setting.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f6e3156b8d2f..341af901c5b0 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1695,6 +1695,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>       uint64_t max_hart_per_socket = 0;
>       uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
>       uint64_t socket_bits, hart_bits, guest_bits;
> +    uint64_t max_group_id;
>   
>       aia_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, false);
>   
> @@ -1742,7 +1743,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>   
>   
>       if (socket_count > 1) {
> -        socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
> +        max_group_id = socket_count - 1;
> +        socket_bits = find_last_bit(&max_group_id, BITS_PER_LONG) + 1;
>           ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                                   KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
>                                   &socket_bits, true, NULL);


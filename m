Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C6DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFY5-0005dt-2m; Wed, 12 Aug 2026 16:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFY3-0005dF-78
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:27:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFY1-00082D-Ae
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:27:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1412913a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786566456; x=1787171256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kn9sY51YzfgZIkd/aLp6tiP757t/3JZZGNEZHEzmvbc=;
 b=vi9PYaWVPKMk3yZz47qF3kK1gP4WCO2FdW9xSYgjB2k4JEGaaAxyUtm3Mw1YV65mYD
 WTP0nn/eelWDBHwBp7oJXz53B9j4/crSgx44Zx9gx0rY83pMJcHuKbd+lm9HJ5EKQMK/
 t5In3q6p6hlUsMillXD+1+7G1ttc+L7bp8deLHgaZ4QngPoD+uzrD8XIo62KNJL8ooB7
 Ekz1eYRrhXGllfBYbKEGg7jkMKHuCybZd/aYZ319G/abECO3EqiL0bFNSiG933wH1M2v
 WlniZ4tpoQaSpytQykbI7YyDlmz00pOzpGH8koG7yzQIFBWg+HEpT7nmLLR+m86lmEPq
 6wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786566456; x=1787171256;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kn9sY51YzfgZIkd/aLp6tiP757t/3JZZGNEZHEzmvbc=;
 b=cHH8HzgUiHt/QtKgqjlUx8fqQucPrK7byoG3s6+fWpQmdlIBmXS3Lya05nx4UXVuur
 ebz7H921LqkeXsVn4H7FMIwrViXm7vOaXmt+SM82ZCFfD81iccAO+xl5VS6bC/l+qWEs
 mGYM7z1GSFFHW6x0uKqJo7ojk3oZtEqysikn+ebVhVp6PbokS0DHbBZi7AYSGbF9LdWa
 SzoF8P1fwebkHvw6Enf+TTi7ngpf5DnjgrMcBNeUNrwtnxwSG/Wwse+SVmv4w5x9WG0g
 fRhgs2kYuFia8GhUFndlc8egtprwtCDcBtw56uwp/8XjEneyZRpWt7FUNadmUzaDx6Kk
 jC+A==
X-Gm-Message-State: AOJu0YwgA3CCfWD4gH5hBOwPOdQ8R1LWqVe0Q2BPkoDtRjjCBlQFYZgU
 pR7Ow8AJ5wpA0AFLBWjADSaq4zGVN5bMeaPlyirnRXxBvjv8Oj2qZ/PA4ZQiATkGkbpm8vJbaC1
 WCRJJ
X-Gm-Gg: AR+sD11PhlR90xvI+P1ltzfHkQHaUto35ofkRtq6CGpzk6jQp6Dz2jokoh/5mv0KUwL
 cu4uNMWEb2KWBjho6aEmVBmrWIY3TPUGcqyZWvbl+zh6Mc1kF8Rj6DWLRDdQxFp602Ah0ao9qv7
 BYBwm6xTk+6HiH0GeQvZDFJuLa6zlDwG0zUPCKA7BaU7MlL1NJKnfiWbrUWd/GujlxVrDWOCmWz
 V1ed5EuNwUhPsv6/0ViySyLabDIeD9/JUfTHbPiPnzJylDn8fPfcmr3M6SJRW8EyxIA6UM0+hXm
 X8vnaecE/vsAFl/MJLRk8MPtu3q3R23zax6kf9br1x6L1YY3pLQd0OkksLwNOHhvidcNTC2IwFo
 vyYE8vRXRMKhsV5jlQnngPkybJaDGK+qxTdeT2V9EIuZ0Z2+/REuiYry4NBWklGVw/9dhCRSDrz
 8lLQInSkws3QhXSyuTcXi3qmkva9LVivn2sWC6NwQlW3BQn2IN2i2qjtx/7Tk0gj/1RGPc38KGM
 tA4oxxMXGYRa8WUaR//jsuAOoP8UsS+OQ==
X-Received: by 2002:a17:90b:35cc:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3931e2ba863mr1025974a91.21.1786566455563; 
 Wed, 12 Aug 2026 13:27:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f2a7b6fsm237420a91.5.2026.08.12.13.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 13:27:35 -0700 (PDT)
Message-ID: <ae5c387b-a12c-4a13-b3d3-7ce1a91d81d3@linaro.org>
Date: Wed, 12 Aug 2026 13:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc: Fix arm kvm gicv3 selection
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260812200308.289238-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812200308.289238-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/12/26 13:03, Richard Henderson wrote:
> While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:
> 
>    $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
>    ...
>    qemu-system-aarch64: unknown type 'kvm-arm-gicv3'
> 
> That patch did remove a test for TARGET_AARCH64, which is fine because
> it has been a long time since we supported KVM for AArch32.
> 
> Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/intc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index a1401cb521..faf63a0145 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -48,7 +48,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
>   specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
>   specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
>   stub_ss.add(files('arm_gicv3_hvf_stub.c'))
> -specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> +specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
>   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
>   specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))

Alternately, we need to adjust

config ARM_GIC
     bool
     select ARM_GICV3 if TCG
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN

Though I'm not sure how ARM_GICV3 + WHPX would ever get selected?

Alternately, given the very tight connection between all GIC revisions and the cpu, how 
does it make sense for any version of GIC to be non-selected?  Just remove all the GIC 
configury and include it with just TARGET_AARCH64 (not vs TARGET_ARM, but vs any other 
valid virtualization host).


r~


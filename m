Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC63D6AAF7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8MNK-0001XS-5C; Thu, 02 Apr 2026 14:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8MNB-0001LW-FP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 14:02:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8MN4-0000XF-3U
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 14:02:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4888375f735so9984615e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775152940; x=1775757740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Cqd02rloH4qWYkodiVboVkNgAG3Np1UDG5yCBlvtX0=;
 b=gvWQiK1qfqx21gqj1+xy6nRx8qRPo7uA0mQGxMtBZvbRipBSZPjzmrQdPVj+Jm0kfb
 xDXTO67OiIXpoBmHlkYly+czSiYuix0SDfPojYLXBYqAp+XOzFVK7LWo0/SS3t95Ym91
 iDOMII674ohN6j3vAB8wVJBAuZCEyq1Rlig0HN3ytnMERJDnZKiMfkqAxLOHeWnBviMD
 UHcu1wZLDX68Ru2N3QkuhIGh38odsJ0/WIMKbbR2lP5hFwcC44h31W82IMum0bOhp04U
 SyosVSIt1PLT6/uOfjc4Hh2U3VICHznceZOexAHbRWntIV3/TecV10J4jRftZHvQMX+s
 hBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775152940; x=1775757740;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Cqd02rloH4qWYkodiVboVkNgAG3Np1UDG5yCBlvtX0=;
 b=UP2c5w1D+Hdmb3TYDOOUk/GpaKbdbc23ga1vl22akVqgfwwEnWUQG+nRz7Eb0A78p7
 fqVHSzIL7Cz3E3FEwUF7DXNNY/KsprsWLUt5/2zeKHfFLAd//eh78SNJlQ19oS1UKlg4
 fsMSM+6PH73nvJ0ZeTph9mc6Jxt6yN3+B+JeV2ODg3vLzqRCNMdLiH43eQiEiUUoub8g
 YHgNjU5GHhUF0j4Wp8OHkVcZ1YNgXJwjw8edr44lISgVEMNTH6aegwSkFx1IOcqhnyUa
 cy3didjGcoD3kNspPWM4a5h2SW9fh/eDYwqYrx5ElLb8MLIXr9TEg4P6/+DBkaZJEFfn
 NYbA==
X-Gm-Message-State: AOJu0YxiIOZHqQzzM/S77KRFSBcy9mgKN+92nG5pcR6ZUhp7R8NhvOLd
 guKi2oH+RvwrnsTAhiq6JzoJbJ+hODC/vXsfkXBWfCWLGmdRazLl+nuUGPbdFxA0TwlG36GGZmS
 YAdZZF1Y=
X-Gm-Gg: ATEYQzw4+80iqHc0OVPkYFCx3XFZZzHIoN1N7nSlxZo02NFZY0j6NRDUtql/z01TE+a
 yhnkaFu51bLZVv2KMCZXtMfZfqwzPFINKh43gJz2v3IYNOGQ2gjpuHe8yGSD8f4L6MfinlpP1g5
 vGJl/fifu7UyZQioSV4riKtwY5tTXakiTTlAo8r7AedOLyJWVcpiYHbbrZRHEvUHz5E5yTW5jhm
 pPeJJHpAeJrkt+x5oX6QCYUT1lusy/aTW13n8Gs4e+LFYwZAAwfTyjrdoc/o9v6nSoolaqEKIez
 QluIuY3z6vSp4k5V2b284HEnXo/tUnk6Cj5qnsNiucVIv2rdDCzFrdceUVDXYtQerY8n+jlr5MI
 3QL8EdVBpvbbxvQIpQFo0+mHKr7/oLxCPIq4B2CZKEDvzqab9vsGH4Dr6VYcPw91O2MB5yQ1wr0
 LtvtPgs2QZ43t3aXeEouPjHw3Vt/jpnv722MynhfI61LXcDPHyrjQwdKdKlsE5L4BDyw==
X-Received: by 2002:a05:600c:4e88:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-4888358809emr146323355e9.11.1775152939887; 
 Thu, 02 Apr 2026 11:02:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8ee2d3sm74726695e9.32.2026.04.02.11.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 11:02:19 -0700 (PDT)
Message-ID: <66240c1c-07b8-4faf-84a4-0275d772b82e@linaro.org>
Date: Thu, 2 Apr 2026 20:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v2 4/9] accel/kvm: Expose all non-target specific
 declarations
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260402170434.94783-1-philmd@linaro.org>
 <20260402170434.94783-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260402170434.94783-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 2/4/26 19:04, Philippe Mathieu-Daudé wrote:
> None of the declarations guarded within the COMPILING_PER_TARGET
> checks use target-specific declaration. "cpu.h" is not required
> since some time (maybe commit 4fb54de823e "meson: build target
> libraries with common dependencies"). Remove the restrictions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/kvm.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 9b722ad931a..c33fb160b5b 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -225,9 +225,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
>   void kvm_irqchip_remove_change_notifier(Notifier *n);
>   void kvm_irqchip_change_notify(void);
>   
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"

Prerequisites still missing, sorry.

>   /**
>    * kvm_update_guest_debug(): ensure KVM debug structures updated
>    * @cs: the CPUState for this cpu
> @@ -450,8 +447,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> -#endif /* COMPILING_PER_TARGET */
> -
>   bool kvm_arch_supports_vmfd_change(void);
>   int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>   



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D1ECD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCE8-00039B-HA; Mon, 15 Jun 2026 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCE6-00038Y-KU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:40:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCE2-0002eQ-Lc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:40:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8419ab3a297so1620674b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781548797; x=1782153597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4uSeaseIUvaR8noinvpUmzwNlCw3sL9mi20faAx6qy4=;
 b=x47/w4N8a7Ocw/ISN9ASJMaMm6esRDkB2aahkzycmW699rDEThia2rKJry3oLX9ROe
 CZ3HygX9C9qZZybCOmdpYdIFH1d08/4ziPMAqasEFFop8V3XLQwwi/v8IwSvBrsT4YvI
 xip0DKbQ3Sn0gEO2s0HtdX9n+MqRJLlhkgpKOw3BgA/eQ3TVZbv9rK4Z5scLlD8+Y5uM
 rxTUlMLOGg1W7SaKp9OaoWQdsLkm2bqhd6iV6lncmdSY0w/e3hH7SN5HN+LkpCd3i954
 h4UIeykZJTe1vxa7jGH4w5d6WkVD9p7WTz8V5HuBfwf2wf/UpEi4milLODHrx7bB2sYh
 GWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548797; x=1782153597;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4uSeaseIUvaR8noinvpUmzwNlCw3sL9mi20faAx6qy4=;
 b=icLXCKvZUcHq88xsYZzQci0rWIQ1jf3KXx1cOva8VX90ii5AP539DMcXM59M+k7IuJ
 W+5Ubw6cPjK2kOsPge+l93tpKWCdN8Fqi8sJhS9UQmUH2KoIJUTkQsCrr55OSQTLJj7R
 kaR2nxOtugDBc4xG9uBrUjKjczYuuTwXsFLSIn09UGY3tXH9Cj0Q1B6xtATOOnn8W5AD
 nd7W0a5z2td072ChGHZtXsp95fHQwbk/+FUU2r2FlLFk2RL3Bbo7sbAOBZ1UiIxhsWJg
 Cb4izIzlrLgPFtJItADKw718ZufaPeDmzzkCcjvf3yZeSDMqXVbsHrEp21nhyGscOheA
 FsCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+f+cpdC7GOnFNi2mG6F7jePZ7InMk8NP5YcK0rg4KSUmc3n7iJ4WfrlJSj+UrJDJSm6uRAVs2hNUc@nongnu.org
X-Gm-Message-State: AOJu0YxTvQbQqo/ipyYbU/wlBr2eSwjlrLrrKFi2SfBjzn/7SUcDBVG5
 ppOCbHFEMTXtlIOFHkq70mGVWntRA0s7aXNzCHOBlGlyxZuQxbyAOub4pPZj8x8MMG8=
X-Gm-Gg: Acq92OFYtF19oNGta3sN3bFS/csgPoReFN+BN2eFh+G57loATGi+xn+p/O0K8E5CC8L
 uEyEdLnmqwshKAzzGdSmKTy3429LEZOmr/HNIc3e7TZV9F0OMniaB8ADU3/TmFgmY1W2jumwk4f
 e83OHBAzMuim5T4aclzofN4XvQYYO23bfsQ6nV5BrtLY1IgqXGh9COZEcalV2TQ0MBdt8rQ57M4
 bITnxwenvdxRuqwxYoDRJfdZYsRPz1FHc5TZ7AWTvymiV+KroXScb9IjesAXScQBotks9lRouAq
 MjwixssMV2MyQqNNhcCJJr+eWg8HUF/Rthh73eyLRwA17nAAub5v9ORRFr2GZQYVw7swKvhWyl/
 zdfb7l6oUAxtHRMBrn8HnHtHyzP/IICdJYxGo2oJwTKmu3LYG2Tz+tgV62DfDV6k2ko2iT4YQyN
 0pk6sBa8psBUfleZJU2PvOdc/UEsRBzyFy8vjZvrY3DFiroq9PnVyLEnjb6GzVoDw7EHAApqEEk
 wk3fQY=
X-Received: by 2002:a05:6a00:32c3:b0:842:4bb9:5fe8 with SMTP id
 d2e1a72fcca58-8451539cbb8mr161555b3a.3.1781548796510; 
 Mon, 15 Jun 2026 11:39:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b0226acsm10776215b3a.48.2026.06.15.11.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:39:56 -0700 (PDT)
Message-ID: <803df8f4-8b24-48e2-b3ff-3e30be677d5e@linaro.org>
Date: Mon, 15 Jun 2026 11:39:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] accel/kvm: Replace legacy cpu_physical_memory_write()
 call
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
> replace it by address_space_write(). Both if() ladders only
> differ in the address space argument: rework to have a single
> address_space_write() call. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> Cc: kvm@vger.kernel.org
> ---
>   accel/kvm/kvm-all.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96f90ebb240..f4f0e64fbd0 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3178,16 +3178,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
>           struct kvm_coalesced_mmio_ring *ring = s->coalesced_mmio_ring;
>           while (ring->first != ring->last) {
>               struct kvm_coalesced_mmio *ent;
> +            const AddressSpace *as;


Really const?  This doesn't look like it should compile, since address_space_write doesn't 
use const.


r~

>   
>               ent = &ring->coalesced_mmio[ring->first];
> -
> -            if (ent->pio == 1) {
> -                address_space_write(&address_space_io, ent->phys_addr,
> -                                    MEMTXATTRS_UNSPECIFIED, ent->data,
> -                                    ent->len);
> -            } else {
> -                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
> -            }
> +            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
> +            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
> +                                ent->data, ent->len);
>               smp_wmb();
>               ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
>           }



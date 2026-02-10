Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E44E94626
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 00:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpbZe-00060b-6W; Mon, 09 Feb 2026 19:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpbZX-000600-Nb
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:25:44 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpbZV-0004gF-1S
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:25:43 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c2a9a9b43b1so2075461a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770683139; x=1771287939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Colt130nD1noiKDWS+SAYetwNy6nxeSAj9L8rg6UCGs=;
 b=Kn7Klc/WO2FnytPCisQJaV1Fpn8GDKK5cO+SESl5bfSlvtSbC53/EKDQik8yfKSXyG
 EjvDtvDX7MCkJ1E/zK2BK+L0HqtfjKUXpN2yzIzph7dUY9iOtvfD8BTLU6BApJ0jLxFh
 ne27Px44978cfsHtOL7fXQH6TkCjZv+pbeJ9wZnkMYjZlSb6UHi/LFMxb+w1vqPOgdj2
 I3g6MriX1JBYFavwfDc+Qf1tN8TKUmipNJy0NadzoXqw2xXZFWnWFHYlJWgH2PCklHi+
 79JB/54Ipu1TGv/wYt+zTNAaOIdwz6KykPsgSIt2XiueMmvhZzsn4ul6kQ1nD3GfS50j
 z+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770683139; x=1771287939;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Colt130nD1noiKDWS+SAYetwNy6nxeSAj9L8rg6UCGs=;
 b=MkrfMphVl+uAtO6ob84YKhvBxsa9IQv1WxQPzJp3VxBSEU3IxbDg7M605UfMckvQM4
 JdoyvhIfQ3Zwugjol2LULe56FG5NMEVR9x08ByrMGXv0O0FJKUTFhrkYjr2YlfclOM0t
 wKjNuZsWzdR8te9+0f49i9UmkP8bDwMnyVXW5CkmQrx0xP9jFTT+3qr/VOl3O7GRH9i4
 IQIz3Uwwy2mjruhSLpT5rEPEKDwVoe7lWp3DXEPdbTJHqNJm/lZcFyqdLRSDVRxL6a7K
 ofa9BL1znKb8gMTqhW/PCC7Y0LnaucnEbZ1lTS4JMpXlu8h2hRU0m+585CbagQdIDrDA
 3mBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzC/pSjAdMIZ/G5chqp3eoHFYKYkETzKyOH+uj+kais/67O4LduDi0AgVQrj0xIOYV119dDyvFLM9N@nongnu.org
X-Gm-Message-State: AOJu0Yzu5l+90Feh7/tcX4KPsZePbnn+Ypq2HRX1/zAQz61DDHGvu2zk
 8e8g9OkFO2qgbO4oFjV52I6BjY6pyqxD1elLmlABcQTn00wSnbNnWf2qFX43T5ZaafU=
X-Gm-Gg: AZuq6aJav3/+5ZRfyQ746UKBchJXuuyXKMt9U2x6VMmCycoNV2RUwCWRa7W6nJXuDId
 9sd80ZAti3kDaSbaL3ECyz4BEAKNgcAcvfPaZ4rMVC9jqpQufZ9ymanxtE+GGk2tpyLVwGxWYZp
 5rAb7ccpGbzAwyRl/8ipUGIraypu5/f5FOeTlQ9FZxCKvY3mP8PD92Fiic/lZNfe2cg/Pj/chMF
 2L8Z8cXT4wHARzE9HExhNNg2wjoczGULzAPkt1JqOgdJca8kfJlA9GtqSkuyIpvM0uLkaGOTjfN
 NRQBVWVtKrePF+CLUf8orP5PHvT0ZwHNBn6MQ0QXHQWrscyfEAdoyvRmIvYAq+ukQPzpci0r+6K
 keetHcdMSlfDPepLTzZfHj8RC2M+NFCCXzG+TnN5FIOne8zpXUB9TGFfLWy/qBPyFGb/FFGh69F
 Qtpx1oC8cY2H9EZjkTNSXepKQIV+Wj8oqF51xZVAdcupPAr7bwKnRTm5vgtl6NELV7B+tMA7IFU
 Q==
X-Received: by 2002:a17:903:18a:b0:2aa:dee9:1ad3 with SMTP id
 d9443c01a7336-2aadee91cc5mr58535865ad.11.1770683138683; 
 Mon, 09 Feb 2026 16:25:38 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:bc29:21c6:e150:bc42?
 ([2001:8003:e109:dd00:bc29:21c6:e150:bc42])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm98466615ad.68.2026.02.09.16.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 16:25:38 -0800 (PST)
Message-ID: <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
Date: Tue, 10 Feb 2026 10:25:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260209115846.2276651-1-jim.shu@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260209115846.2276651-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 2/9/26 21:58, Jim Shu wrote:
> RISC-V WorldGuard [1] will add 5-bit world_id (WID) to the each memory
> transaction on the bus. The wgChecker in front of RAM or peripherals
> MMIO could do the access control based on the WID. It is similar to ARM
> TrustZone NS bit, but the WID is a 5-bit value.
> 
> WID is usually implemented in AXI AxUSER signal (user-defined signals)
> in the AXI transaction. As we have a secure bit in MemTxAttrs to emulate
> the TrustZone NS bit, which is implemented in AXI AxPROT[1] signal,
> I'd like to propose to add world_id field into MemTxAttrs struct.
> 
> Since the '_reserved*' fields in MemTxAttr are for padding the struct
> to be 8-byte [2], we change the reserved fields from 3 to 2 bytes when
> adding 5-bit world_id field.
> 
> [1] RISC-V WG:
>      https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> 
> [2] Commit 5014e33b1e00d330f13df33c09a3932ac88f8d94
>      Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   include/exec/memattrs.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 52ee9552491..6bde90d482f 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -57,6 +57,11 @@ typedef struct MemTxAttrs {
>       /* PCI - IOMMU operations, see PCIAddressType */
>       unsigned int address_type:1;
>   
> +    /*
> +     * RISC-V WorldGuard: the 5-bit WID field of memory access.
> +     */
> +    unsigned int world_id:5;
> +
>       /*
>        * Bus masters which don't specify any attributes will get this
>        * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
> @@ -66,8 +71,7 @@ typedef struct MemTxAttrs {
>        */
>       bool unspecified;
>   
> -    uint8_t _reserved1;
> -    uint16_t _reserved2;
> +    uint16_t _reserved1;
>   } MemTxAttrs;

Hmm.  This really overlaps the secure and space fields from arm, and possibly some of the 
others as well (e.g. user, requester_id, pid).

I don't really have a good suggestion for that right now, but it would be nice to not keep 
expanding the count of these sorts of fields that somehow specify the originator, but 
clearly cannot overlap.

I'm reasonably sure we've had this discussion before, but nothing has come of it.

Time to paint the bikeshed again?


r~


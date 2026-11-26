Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A41606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XdKC2ipi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWRlX-0000P5-IK; Thu, 26 Nov 2026 00:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1xWRlP-0000OR-32
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:11:19 -0500
Received: from out-5.mta0.migadu.com ([2001:41d0:1004:224b::5]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1xWRlL-0008Iw-G9
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:11:17 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=aN8tAXRgk9ZjGDLouDtMFlUFq8ml0cS1HQJSJewlS3k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795669869; v=1; x=1796274669;
 b=XdKC2ipi3oFpb3sUK7pCdmnVEgRHX1IhR/kZ/IXK97lX7gpFzvY+vXKWQ5FHSyMAxOpWSE4x
 cZcYBiH/8+OqoXVPjSQkixQVn40eX7k8G7Ra842/DyMD5g2Rm+RvkBY08chefiByRPQmrotQfDd
 Entlh5g8eOXlm98q8ryEJ02o=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id fbe30ccd47a2f16c;
 Thu, 26 Nov 2026 05:11:08 +0000
X-Mizu-Trace-ID: fbe30ccd47a2f16c
X-Migadu-Flow: FLOW_OUT
Message-ID: <079c7160-0374-4cc9-bc76-ba5f7f216ecb@linux.dev>
Date: Thu, 26 Nov 2026 13:10:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/65] hw/intc/arm_gicv5: Make gicv5_set_* update SPI
 state
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-25-peter.maydell@linaro.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260327111700.795099-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::5;
 envelope-from=zenghui.yu@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3/27/26 7:16 PM, Peter Maydell wrote:
> The GIC CD* insns that update interrupt state also work for SPIs.
> Instead of ignoring the GICV5_SPI type in gicv5_set_priority() and
> friends, update the state in our SPI state array.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c                | 64 ++++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv5_common.h | 40 +++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index d1eb96fce0..9ca1826253 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -490,6 +490,19 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
>          put_l2_iste(cs, cfg, &h);
>          break;
>      }
> +    case GICV5_SPI:
> +    {
> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
> +                          "priority of unreachable SPI %d\n", id);
> +            return;
> +        }
> +
> +        spi->priority = priority;
> +        break;
> +    }
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
>                        "priority of bad interrupt type %d\n", type);
> @@ -524,6 +537,19 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
>          put_l2_iste(cs, cfg, &h);
>          break;
>      }
> +    case GICV5_SPI:
> +    {
> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
> +                          "enable state of unreachable SPI %d\n", id);
> +            return;
> +        }
> +
> +        spi->enabled = true;

spi->enabled = enabled;	?

since gicv5_set_enabled() can be invoked by the GIC CDDIS emulation code.

> +        break;
> +    }
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
>                        "enable state of bad interrupt type %d\n", type);
> @@ -558,6 +584,19 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
>          put_l2_iste(cs, cfg, &h);
>          break;
>      }
> +    case GICV5_SPI:
> +    {
> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
> +                          "pending state of unreachable SPI %d\n", id);
> +            return;
> +        }
> +
> +        spi->pending = true;

spi->pending = pending;	?

And having roughly read how we emulate the pending state... If the guest
has executed GIC CDPEND, which generates a SET event for a level-triggered
SPI, this SPI will keep pending until it is resampled (Ack doesn't clear
pending for it). I noticed it when I was playing the IRQ debugfs in a Linux
guest -

	echo -n trigger > /sys/kernel/debug/irq/irqs/<SPI>

resulted in an interrupt storm.

Could we take R_LKBBQ to ignore the SetPending in this case? Or resample
the SPI state appropriately (e.g., at Ack time)?

Thanks,
Zenghui


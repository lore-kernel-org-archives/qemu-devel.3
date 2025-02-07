Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B338C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRMu-0003E7-VH; Fri, 07 Feb 2025 11:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRMp-0003A5-Ck
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:38:11 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRMn-0006YX-1B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:38:11 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so1993655276.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738946287; x=1739551087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kAm+8KqVWhVPm/FTHeR78fkBlnBEZqi3WmpJ5OUjub4=;
 b=sVkIHzGRMMu3SPL9x3NMZ6mEQZCr+5otl68ylEAjzVjhbPol4LCe9gFVHKKftV9ICa
 cZn4nkDGssXrhdYenqyuJwTBG4sUWuiEYgiebMQKfzV9LKXa4kUNk+mQOcz2OK0Fk5Gf
 UO9jAYmi1bFBpTu+GoZHdS5E+BFpFN1G/ljGIoDYSRaz41GEGH86KEXM4i9prNf4W3KL
 9ncKguIL6Qb4pnYOGXwxC/T24sV6+q1hOJSDzoEQ5xm3aFogwJU6MKOIfMJ7bOxZib5g
 UKCzPUpZVxLMTDoomozfyE1wRwYo5zlT7WNWW2ZIySIjVFgQZ/WqTBKsxjV9Y7s8GOza
 sAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738946287; x=1739551087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAm+8KqVWhVPm/FTHeR78fkBlnBEZqi3WmpJ5OUjub4=;
 b=vM4y5/z2gywATcMZQUw40WtdlDIAlhJJvKjOufgZAwtR4xSPOZ4fK5RuY3WkVr+Rgf
 0UDKIWf2oBSuckhjZETZHkeRBO0jrMMez8YKbpIidlfqDcIfbWQNzF93QXf0uEi2BJ8r
 pEBRy+TEWEXh3P1ZzJJ8+K7EQVNGp9gBWTphGfoeaThv+dw/YVw4aQB53yTsvR3cURz7
 0QsA8mZIeN+LrTsnQmX8BkP1KpKuj4hPaIqSEK9Ehcg7ETGEXGL8h1o7TgsVsw3DOWLz
 E5xgCzxtR6CTa1LX81KorLZP9rXsujBIlW8HYuLWz9TWeFuH67/1gpy1WA1NtHdOx3Sf
 EONQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLfG/qDy2quewGk53WLc+KV3UV1tdkP1p5I/mCzMvE/f5Iw0S4gDWTSdShwXU0CvSVeDwcCmXyARz@nongnu.org
X-Gm-Message-State: AOJu0YwpLi6e0r1BhixBIybg4yWDYYAD17meMpC8lk3vjUXYzfemi/eH
 0jBr1oL97YsiVCOFMPMZsELVjZIv4HmHIoOPeo0ucmGtDZffZ0gYTjTFwZ2xo21t8sy9og4E3oC
 OJRo68mgQPMNiAv4875kj64GaRMdUssA+8tgDJA==
X-Gm-Gg: ASbGncsox1L/qbElvwo0B1TZnIpaIMygvio2A/xV+a4DBlmqU877hU9mP/XciRc96m3
 EqJwqEjvW94T11OpreaSYLG6PPxkJMZ6AcYM86DtaJsmBJiutQ7cnClLw8XlR7RIla60+at3fBg
 ==
X-Google-Smtp-Source: AGHT+IFWFTvf41uVF3h65M2ZzMX4kat4Tlvty4g4q9TxadtqHvkoL3xhrou1Yfcyi3HQwckodQcRJh0aKyWdfUVhKyw=
X-Received: by 2002:a05:6902:2686:b0:e5b:3b7a:fcb4 with SMTP id
 3f1490d57ef6-e5b46b7d66emr3320873276.1.1738946287287; Fri, 07 Feb 2025
 08:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
In-Reply-To: <20250206142307.921070-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 16:37:55 +0000
X-Gm-Features: AWEUYZmnqP8S6aBg0zaVPZKtAHoxLWNEwTxS7fJ_Lrt0VeWRuuqsHzAQPdh0M8M
Message-ID: <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com, 
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org, 
 zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 6 Feb 2025 at 14:23, Eric Auger <eric.auger@redhat.com> wrote:
>
> Currently the iommu may be reset before the devices
> it protects. For example this happens with virtio-scsi-pci.
> when system_reset is issued from qmp monitor, spurious
> "virtio: zero sized buffers are not allowed" warnings can
> be observed.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c     | 9 +++++----
>  hw/arm/trace-events | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index c0cf5df0f6..7522c32b24 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1870,13 +1870,14 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
>      }
>  }
>
> -static void smmu_reset_hold(Object *obj, ResetType type)
> +static void smmu_reset_exit(Object *obj, ResetType type)
>  {
>      SMMUv3State *s = ARM_SMMUV3(obj);
>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>
> -    if (c->parent_phases.hold) {
> -        c->parent_phases.hold(obj, type);
> +    trace_smmu_reset_exit();
> +    if (c->parent_phases.exit) {
> +        c->parent_phases.exit(obj, type);
>      }

If we need to do something unexpected like reset
register values in the exit phase rather than the
hold phase, it's a good idea to have a comment explaining
why, to avoid somebody coming along afterwards and tidying
it up into the more usual arrangement.

If I understand correctly we need to keep the whole IOMMU
config intact until the exit phase? What's the thing the
device behind the IOMMU is trying to do during its reset
that triggers the warning?

thanks
-- PMM


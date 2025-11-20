Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0ABCFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 19:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMAIN-0001Z9-Ex; Thu, 20 Nov 2025 14:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vMAIL-0001Yj-Mp
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:26:17 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vMAIJ-0003TN-BH
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 14:26:17 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779d8286d8so719815e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 11:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763666773; x=1764271573; darn=nongnu.org;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7c9o6MF/Kk0aX+c5IDscmsfuxHyDlGG383uPqNfAbZ4=;
 b=Ny5VZaqrpaTjqOKcq4nwhn6Xj4ZXCaO3Hm4MIE3BZIs+kxKqu4NzpTdsSby0BgekBq
 6yXUiS3V98Bj5AsoLhT2S9D4k+jdPUfTv8HNHH2iT6keBsgCJ9v1q4+kfSi90GIbih8B
 fg6QdSgWdo3PoZ2lKZrUm2bPUGF+9vCOfmrH8S9hL3OrcGFgdsV1kzuwp2SV6bVUOPbu
 xw0QjiDHYHzB8BHiPlWGZaZavzkizxPr3EwjD8kl7Kmhpt3hWmzY9WC7aHlgnfeimYJi
 ZyFZ067qVQhaEuJYtxDl0IP/9V+S39BLzEI44aSGAKt8oz3MJz51zdCj0s3qLPMwv/MH
 2tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763666773; x=1764271573;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7c9o6MF/Kk0aX+c5IDscmsfuxHyDlGG383uPqNfAbZ4=;
 b=KeTQ36N8aNWFE3AeTDTl95Pv9bJ3Q1CcPsIWTbwPGodaVphPPtJI3J7mbOZLv48aRa
 tIgVRY+aGSwmmNUWh77zF/pKHcPOj1i9R3YUnAz9ge1yAMqqAvWSflrXBbiLQeSZ0irR
 Yj59/nBGDk9i3Fqze4gBfT6uQR6hPjfN8pO4uLvZapp4CZe8FeR5mY4PXjcBfdg5VXus
 LJ4D+Aqrc9yTINT+9tZXPjuhh1xo80hjYnzhmvchXQ1vvI9mIVHJHRkIQH31mfgshSbo
 0ZKxRdSwWk6h/2bRGhalMRpMmHCcrKes6dSuizRy7RD5qfI6XevrsU6olrOy0pcSr2Y2
 4Dgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTdPfZ1O0mhAnlYCadN62d0o5alGqjfpBCDPNDfTyrCaC3cTGUQIf9SKSCKk41MMeN6eXENPZHJaAD@nongnu.org
X-Gm-Message-State: AOJu0YyY6obqVo+25znivSu9So4l8R8dddqgMxXerRmdGwz5iqFvjr9Z
 zqqRv9HLBKryasgMxNMe6QnziiXyzKOEb3KkT1Zcu2WB54PNl/GvSgWK9oue+pQYnC4=
X-Gm-Gg: ASbGncv0bOTMvlO9URBUqx7J+uhRNVvIgWmQXPNcw+5W3wXjpGSM7BfHmQtEDKs8FEV
 1ho3pX9/vnrioAkQB4plSVqz0RN+vasZuMqQSfJuz4ztFXY7QT6kgRBZlR2jxfWbllufId3K60/
 nBQdRyjtcvBZzrHvDVdsv2ZTuP4NmFeeNmCDNiRYV7fPYYuuNivm82jJmrB5PtD20VAJqdnk/t9
 8MtpXX25oLz9sT7kazdAaiBMYes59k86Ozup7uIoF2XcFZFOiGqxK073/MRYHQHwjtydnApmqMP
 rE/WgnrTVsEDvTE9kNUy+TXret/qVcFRWYpXownUrSbloj7bc9jNOVUhGwa/L1DNtQ3JpdXwAnk
 6TFN70fTbMAK0kTG+jfbnyVV2faA5oeIW1TwuaxGlQQvcrsEdgPdxvMVgPcZkc29NxBWlDGi/P5
 4=
X-Google-Smtp-Source: AGHT+IF+uhTAwRFbNpoCewAkVOzfTzykN3GjejXijF2ty9eReA93tThGXVB05csjoG8OCLwzGHSoEA==
X-Received: by 2002:a05:6000:4305:b0:429:d084:d217 with SMTP id
 ffacd0b85a97d-42cb96a5449mr2254273f8f.0.1763666773034; 
 Thu, 20 Nov 2025 11:26:13 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7fa35c2sm6347043f8f.25.2025.11.20.11.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 11:26:12 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Nov 2025 20:25:44 +0100
Message-Id: <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <Alistair.Francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Nicolas Pitre" <npitre@baylibre.com>,
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, "Atish Kumar Patra"
 <atishp@rivosinc.com>, "Atish Patra" <atish.patra@linux.dev>, "Vasudevan
 Srinivasan" <vasu@rivosinc.com>, "yunhui cui" <cuiyunhui@bytedance.com>,
 "Chen Pei" <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Drew Fustini" <fustini@kernel.org>, <qemu-devel@nongnu.org>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-19T16:42:19-08:00, Drew Fustini <fustini@kernel.org>:
> From: Nicolas Pitre <npitre@baylibre.com>
>
> Implement a capacity controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
>
>   - Number of access types: 2 (code and data)
>   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>   - Event IDs supported: None, Occupancy
>   - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.=
pdf
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> [...]
> +static void riscv_cbqri_cc_write_alloc_ctl(RiscvCbqriCapacityState *cc,
> +                                           uint64_t value)
> +{
>[...]
> +    if (rcid >=3D cc->nb_rcids) {
> +        status =3D CC_ALLOC_STATUS_INVAL_RCID;
> +    } else if (atv && !is_valid_at(cc, at)) {
> +        status =3D CC_ALLOC_STATUS_INVAL_AT;
> +    } else if (op =3D=3D CC_ALLOC_OP_CONFIG_LIMIT &&
> +               cc->supports_alloc_op_config_limit) {
> +        status =3D alloc_blockmask_config(cc, rcid, at, &busy);
> +    } else if (op =3D=3D CC_ALLOC_OP_READ_LIMIT &&
> +               cc->supports_alloc_op_read_limit) {
> +        status =3D alloc_blockmask_read(cc, rcid, at, &busy);
> +    } else if (op =3D=3D CC_ALLOC_OP_FLUSH_RCID &&
> +               cc->supports_alloc_op_flush_rcid) {
> +        status =3D alloc_blockmask_init(cc, rcid, at, false, &busy);

The spec says the following about flush:

  "The configured capacity block allocation or the capacity unit limit
   is not changed by this operation."

Limits are not implemented, so I think it's supposed to be a nop.

> [...]
> +static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned =
size)
> +{
> +    RiscvCbqriCapacityState *cc =3D opaque;
> +    uint64_t value =3D 0;
> +
> +    assert((addr % 8) =3D=3D 0);
> +    assert(size =3D=3D 8);

Is there a plan to extend support for 32 bit operations?

  "The CBQRI registers are defined so that software can perform two
   individual 4 byte accesses."

> +    switch (addr) {
> [...]
> +    case A_CC_BLOCK_MASK:
> +        if (cc->ncblks =3D=3D 0) {
> +            break;
> +        }
> +        /* fallthrough */
> +    default:
> +        unsigned int blkmask_slot =3D (addr - A_CC_BLOCK_MASK) / 8;
> +        if (blkmask_slot >=3D (cc->ncblks + 63) / 64) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: out of bounds (addr=3D0x%x)",
> +                          __func__, (uint32_t)addr);
> +            break;
> +        }
> +        value =3D cc->alloc_blockmasks[blkmask_slot];

There is supposed to be a cc_cunits registers after the cc_block_mask.

> +    }
> +
> +    return value;
> +}
> [...]
> +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
> +{
> +    RiscvCbqriCapacityState *cc =3D RISCV_CBQRI_CC(dev);
> +
> +    if (!cc->mmio_base) {
> +        error_setg(errp, "mmio_base property not set");
> +        return;
> +    }
> +
> +    assert(cc->mon_counters =3D=3D NULL);
> +    cc->mon_counters =3D g_new0(MonitorCounter, cc->nb_mcids);
> +
> +    assert(cc->alloc_blockmasks =3D=3D NULL);
> +    uint64_t *end =3D get_blockmask_location(cc, cc->nb_rcids, 0);
> +    unsigned int blockmasks_size =3D end - cc->alloc_blockmasks;
> +    cc->alloc_blockmasks =3D g_new0(uint64_t, blockmasks_size);
> +
> +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
> +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024);

Shouldn't the region size take cc->ncblks into account?
(A bitmask for 2^16 ids is 8kB.)

> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &cc->mmio);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cc->mmio_base);
> +}
> +
> +static void riscv_cbqri_cc_reset(DeviceState *dev)
> +{
> +    RiscvCbqriCapacityState *cc =3D RISCV_CBQRI_CC(dev);
> +
> +    cc->cc_mon_ctl =3D 0;
> +    cc->cc_alloc_ctl =3D 0;

Only the busy field must be reset to 0.  I think the decision warrants a
comment that we're zeroing more to have simpler code.

> +
> +    /* assign all capacity only to rcid0 */
> +    for (unsigned int rcid =3D 0; rcid < cc->nb_rcids; rcid++) {

rcid !=3D 0 are unspecified on reset, so I would prefer not to touch them.

> +        bool any_at =3D false;
> +
> +        if (cc->supports_at_data) {
> +            alloc_blockmask_init(cc, rcid, CC_AT_DATA,
> +                                 rcid =3D=3D 0, NULL);
> +            any_at =3D true;
> +        }
> +        if (cc->supports_at_code) {
> +            alloc_blockmask_init(cc, rcid, CC_AT_CODE,
> +                                 rcid =3D=3D 0, NULL);
> +            any_at =3D true;
> +        }
> +        if (!any_at) {
> +            alloc_blockmask_init(cc, rcid, 0,
> +                                 rcid =3D=3D 0, NULL);
> +        }
> +    }

I think it looks a bit better if AT values were expressed as a bitfield
of size 8: (untested)

    unsigned long at =3D find_next_bit(&cc->supported_at_mask, 8, 0);

    do {
        alloc_blockmask_init(cc, rcid, at < 8 ? at : 0, rcid =3D=3D 0, NULL=
);
        at =3D find_next_bit(&cc->supported_at_mask, 8, at + 1);
    } while (at < 8);

Thanks.


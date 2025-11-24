Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C428CFD318
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 17:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNZyE-0004fR-6D; Mon, 24 Nov 2025 12:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNZy7-0004bq-Da
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:03:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNZy5-0003E3-0y
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 12:03:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47798089d30so2352085e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764003791; x=1764608591; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpMGIaOohBIWSN+juWH3bKlLeQUwDFZmhfK7rIQw8bw=;
 b=jFAryUydhmYQGhEJYQj3Q8cmAqqQAhTr4nIbbYuZsqXhUD/d3jFZuYdoAFH87cY3IK
 4+YJJmXoeedGwRoJ21VoFKjKdEuNqyLhuDQP4O7U/ZkII/8JzS9XJEHX/n15vqny/K8x
 7tGQbbceYHmA9O7S3GSzcrYjIXscvMIyPDG9agufGkEpqUcHi6APURt6Dc72DK+rQ6D+
 uRo00LDEEoxgj++ysjM3akAW7Wgda6mKXpYZH2ZWxqGVE4x0NKy7vcbqq5sHuoP/kgI6
 zZWBNamZNdzeUuxx+GU4VHrOTGckHxw28Iyr4ddpEESq/ZfQ2lLh8rt3Ot13iOdTix3P
 rJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764003791; x=1764608591;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpMGIaOohBIWSN+juWH3bKlLeQUwDFZmhfK7rIQw8bw=;
 b=V2shUG5UaVexCJrj0p92zD59H6bm7La8XmMrTcEVAsEnSoCJ+fUCW+q7tdzqlTlMGY
 S1boYXccvXXpG/g3vh2mDjvnMcgaACngHEw123lC5FL0DzfC4yx0jcUp7PBjzFustxh1
 f+UqD8ySr6xTjr0eiEwLFgyKvcb0YnhF9snD1p1pjwiZS6pD2cLmk125InnT9jNUQI7+
 SBCgeaTLe3ZAUvQPaXc9s47TlrplkTrii7R6o77ZO0ykWMRgKKtWkehtGSWgePgEKdNr
 dlOg1ANUFGvww+lyy7Psgxa2M00oKXG7ofaKqHz2zVY5QXT/LgN2HmXegyXey811CbNY
 aiEQ==
X-Gm-Message-State: AOJu0YyAGEA9a9j7RQ1YNx53REH18SfigZZxh/xXU3cdAU3PsMAxqAqt
 s3AKb3W+WJTcMFzhyEmiEZ7/h6NVDQqTAQJQGfLI2SsrnI/umagTEMPmxTr+PrYVysY=
X-Gm-Gg: ASbGncvC/aqU7Zl2NyRUYm3ss+5I+9121tcTgMutbvROX7qcmaReptce1/414tudjeU
 X0vfjeBUDBYUW7FJgX9YilN3Z2kEaN2BiPZ1Fs6yrKXe24q9VkD0E2AFFjo9sd0uttY1bXzZeZ+
 sqdf7K5dUT65BZSKzKlOpcRN/NbOpaUUCTvkSx6DVtm7ZcNs8uotwrgFBhWi9JhUioAAid32RQC
 Iq9JJABJFyiJu7hOmc08iHUym4o0WVYM4rUvaKraP0YMJ/IURWlyvwUdMbMubn+iTU79Xoa0jFD
 D21a/oj0y6BoknclN37hg0dALmW1jNLXOX7GINidsn71Uy85DVjTgnNjz4tcWUpLbHChOjpKTS4
 LKjLcJ7u1BY0Nd9cZdllQlrdatoi+2/9hG/WNRr+c7kE3bX4JJ9z5pf+C2y1OebNzO6qz4LNcOI
 g=
X-Google-Smtp-Source: AGHT+IHsnUiEWgHnUYRxleh6IJNZN8H7wk9vZuXsrKZqmzqPCBAizP93nXsokIqRHwpMI+VgJlIF7Q==
X-Received: by 2002:a05:600c:4693:b0:477:9d54:58ce with SMTP id
 5b1f17b1804b1-477c311cdc6mr67530555e9.1.1764003791192; 
 Mon, 24 Nov 2025 09:03:11 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f34fd1sm30111795f8f.11.2025.11.24.09.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 09:03:10 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 18:02:37 +0100
Message-Id: <DEH356RBYAIG.IS7SP4D5XLIQ@ventanamicro.com>
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Cc: <qemu-devel@nongnu.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <Alistair.Francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Nicolas
 Pitre" <npitre@baylibre.com>, =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, "Atish Kumar Patra" <atishp@rivosinc.com>, "Atish
 Patra" <atish.patra@linux.dev>, "Vasudevan Srinivasan" <vasu@rivosinc.com>,
 "yunhui cui" <cuiyunhui@bytedance.com>, "Chen Pei"
 <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Drew Fustini" <fustini@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
 <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com> <aSDCmrvONUgvzqbV@x1>
In-Reply-To: <aSDCmrvONUgvzqbV@x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

2025-11-21T11:50:50-08:00, Drew Fustini <fustini@kernel.org>:
> On Thu, Nov 20, 2025 at 08:25:44PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>> 2025-11-19T16:42:19-08:00, Drew Fustini <fustini@kernel.org>:
>> > +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
>> > +{
>> > +    RiscvCbqriCapacityState *cc =3D RISCV_CBQRI_CC(dev);
>> > +
>> > +    if (!cc->mmio_base) {
>> > +        error_setg(errp, "mmio_base property not set");
>> > +        return;
>> > +    }
>> > +
>> > +    assert(cc->mon_counters =3D=3D NULL);
>> > +    cc->mon_counters =3D g_new0(MonitorCounter, cc->nb_mcids);
>> > +
>> > +    assert(cc->alloc_blockmasks =3D=3D NULL);
>> > +    uint64_t *end =3D get_blockmask_location(cc, cc->nb_rcids, 0);
>> > +    unsigned int blockmasks_size =3D end - cc->alloc_blockmasks;
>> > +    cc->alloc_blockmasks =3D g_new0(uint64_t, blockmasks_size);
>> > +
>> > +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops=
,
>> > +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024);
>>=20
>> Shouldn't the region size take cc->ncblks into account?
>> (A bitmask for 2^16 ids is 8kB.)
>
> cc_block_mask field is BMW / 8. In the case of NCBLKS of 12 and NCBLKS
> of 16, both end up with a BMW of 64 which would be 8 bytes. I think the
> the only reason the allocation is 4KB is that is meant to be aligned to
> the page size. Otherwise, the capacity controller register layout is
> pretty small.

I understood NCBLKS as the amount of bits in the capacity bitmask, and
NCBLKS in encoded in a 16 bit field, which means up to 65536 bits.
Is there a lower limit?

Thanks.


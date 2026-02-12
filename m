Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C02EE3684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 13:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWcl-0004KP-7I; Thu, 12 Feb 2026 08:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vqWcj-0004Jx-Gj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:20:49 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vqWch-0001rM-Ta
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:20:49 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12732e6a123so1108643c88.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770902446; x=1771507246; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sXwtlr3atUSvJ91fbRKXBMcQsUfUfc5j5y3Arcd1Edc=;
 b=AYQFzRTZbYMb5vHORTppkxNNx0Naq7eJZDxn55OntT7tHTIb3udiZFaiPEPhvluVP8
 WTwJsKMT5Y2F6E/mm9dsufX5PiyzL5bZ8rUp+tM3tA/e//ymA2ShofkoOTjkSKUOQ4kj
 iWoMZ0a7PxkkRIE8L8PnQz/KIt9f0J2uWmip42spoFp/7FCErSUEP4BtZb7uMZ3BtexZ
 +Q1ZDmfw3jvOQ4BqXXSnDpyI7q/EZFQf0M6YhJ/mpK271PenGEjGtvtAfr+Kv4n8rmS5
 Svt8tPCcM5lytYFLFAkBiYrKREs71ITOC8E3JheAZM3Yt4QpoztDHBnpE7k8SPkRdnTK
 xBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770902446; x=1771507246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXwtlr3atUSvJ91fbRKXBMcQsUfUfc5j5y3Arcd1Edc=;
 b=Z0/LM3b/Wxd+D0bvdfu8OWLp2jOxEmVC/iAu9GDcE0myxVELQ4IuGoXkCq+NUEMdaJ
 wggsYwijEGtxbaDxoEvA7AgOpdBvEMKFz4OKq3zYbYmuGNmsuHHWQvQC3Kr61o0/A/0T
 ITRs+QBRAwUbOgdzwIuPcCIgShKgZmyUws3ay2pl6AabuT2cxMLOAgyUiDmPIeykXGYa
 Su3AcHa5yyRYqO864OJovh3KBjfhOK83xxgjpR03I3iMymEEhwCgaBozfyxMFwBzcGNb
 Q3UN6yfEGxoam6jsBhWUGlJQZTpHMYllgZZGeHmGDIlnZADtICfIkjQAm56G5PNoTQ54
 nBbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6FesKDtw/3XP4ENySv1X7nbGm6/pV7R0m88jApbY15GEo3HZhvwjSYgzG75TkEqN2JhLM+uvl6ZWu@nongnu.org
X-Gm-Message-State: AOJu0YzSMYn1UGP0/cbJu9ieDAWF3Tf1LJoGeP/N9s06F6vIjxhv5DKU
 QRceV3L14zWvWYEgoBTazxZaBEXK8tSWs0ggwrH+1DuIJysUqhuQsZLN1yngGI5F
X-Gm-Gg: AZuq6aK5Wi0eh1Q0bmaUXuzAs8xoy0DCE3wLUeazi65Cj82g5uF2xL62kx4VELACwnS
 lvnTXkRyYBu3f7OWuKLdAMjdL2kW13/dWLZxeBHEM4+jNRVw8jjmV1KePH+66ijF3yPRwVZWLdJ
 5jGF+D8iR9Qz/y+CrbIapEOVZsE8jd0iiUtzSTa6UJxbiIv93cIm9whjTxyeHXLezIfudUosq+0
 xXGpPfnQEiI4cNW6M3AVI0KyjqYdCxvE0ssnH3AmgzfEH0RKJ2HvOXuQEGUn/D+3LDnbNJMtIeW
 3zvFPjX3ukGsHE6YSTnQnN7CVjOrrM7m6fFqMbeeSbT6M3iOaifI5AhHPf4KVY9gUGY5P4aucHA
 MWpxWdf/wJohvC9lZyZtGR/WSKwt+lqW6ekHaTo/toObGhLzOmxzOOPvPWwix6vRKlXfNNXoQTx
 A2NNtLQkXUPbMk+1kgyzwecC7ZbOS/Tdr5Le2GtCGULwf1Xj3gnxMOI7FhzQxFhRtow5oOPtEzZ
 v8Zp17wbN2/vP/Ixbldme6KX7GY33ka73tNqT3f7w==
X-Received: by 2002:a05:7022:1288:b0:11e:3e9:3e8b with SMTP id
 a92af1059eb24-1272f7a190bmr1090404c88.50.1770902445480; 
 Thu, 12 Feb 2026 05:20:45 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1272a6942ccsm5083906c88.3.2026.02.12.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 05:20:44 -0800 (PST)
Date: Thu, 12 Feb 2026 21:20:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, anjo@rev.ng
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, palmer@dabbelt.com,
 alistair.francis@wdc.com, 
 pbonzini@redhat.com, gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
Subject: Re: [PATCH v4 7/8] hw/riscv: Fix IOMMU PAS capability to 56 bits
Message-ID: <aY3Thx7dXKKto0Ut@ZEVORN-PC.localdomain>
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-7-725a589e83c8@rev.ng>
 <8bc64219-138b-45d7-b07c-bf627c2151e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc64219-138b-45d7-b07c-bf627c2151e8@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Feb 11, 2026 at 11:59:45AM +1000, Richard Henderson wrote:
> On 2/10/26 21:33, Anton Johansson wrote:
> > Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
> > with the fixed size of the riscv64 physical address space.
> > 
> > Better would be to somehow determine if a 32-bit or 64-bit cpu is
> > running and set accordingly, but I'm not sure how that would be done
> > from the device instance init function. This field is unused anyway.
> > 
For runtime detection, we should use riscv_cpu_is_32bit() (implemented in
target/riscv/cpu.c, declared in target/riscv/cpu.h).

That said, I don't think the IOMMU device should call riscv_cpu_is_32bit()
directly, since it does not have a reliable CPUState handle in its init path. 

Following Richard's suggestion, it would be better to add a pas-bits property
on the IOMMU and set it from virt_machine_init() (or equivalent machine code),
where the CPU width is already known(we can use riscv_cpu_is_32bit() fn get it).

Thanks,
Chao
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   hw/riscv/riscv-iommu.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index b46b337375..c3d48541b7 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -2453,9 +2453,15 @@ static void riscv_iommu_instance_init(Object *obj)
> >       /* Enable translation debug interface */
> >       s->cap = RISCV_IOMMU_CAP_DBG;
> > -    /* Report QEMU target physical address space limits */
> > -    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> > -                       TARGET_PHYS_ADDR_SPACE_BITS);
> > +    /*
> > +     * Report QEMU target physical address space limits.
> > +     *
> > +     * Currently set to the riscv64 limit of 56 bits (44 bit PPN),
> > +     * riscv32 would use 34 bits (22 bit PPN).
> > +     *
> > +     * This field is currently unused.
> > +     */
> > +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, 56);
> 
> Probably better to make this a property.
> 
> The iommu object already has a number of them, set by virt_machine_init, and
> that function already has a handle on the cpus being instantiated.
> 
> 
> r~
> 


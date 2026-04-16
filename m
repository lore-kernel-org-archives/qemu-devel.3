Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F18DF8A146
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 10:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDJxU-0000QD-Re; Thu, 16 Apr 2026 06:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wDJxH-0000PZ-5u
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 06:28:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wDJxD-00076e-DG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 06:28:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso29273555ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776335288; x=1776940088; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qi9XnqqjL5K2l4kSEs0tZfHuwwnHGSBH7vPdyVmSJPc=;
 b=NV3ffbSi1wJtWNlKRKppMeu7Jq3h8NpTTPm7YU2ORIizPoxlSGVzehRxZ/Lhsn4vMV
 KlcfyvnOTZhrR31lspXjVADkhzhK/3zIZtebRO7qCxXBhRKs78lqueYe9ldvAmRQzs35
 c+Y2vCBlWjc8jI+Xs7uxlfJnimFi+Yiikvu3KXmhUkD/jD7utr0PuUSJwoKY4Al+XqSW
 ubPGd6arA+ZaEm6cnawJ2I1IkhWdJxJ7ZmhODDJ5JXBoPjbgaz/xeSn4f6FcZeiMMb8+
 iQW7pDpGe7zAaX9EKpQ6f8zYiNpZVu9Brsov1jejvVoVlkCbOFZjRfS1k8NAPsI9hk7O
 ySkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776335288; x=1776940088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi9XnqqjL5K2l4kSEs0tZfHuwwnHGSBH7vPdyVmSJPc=;
 b=UBQ4X4IVjzJ2nKrn/Ib7F2+m4ATK5y0Hi9gdSQ5RmwmbLDoO5VIXD5lW8AowOi83Os
 PN8TK3lZ/rQwVUbYTY2wFOXmVqyRuTKFMqDMUyf9zUXnUdmw/bCe5r1s4Sxdg4oOEh2J
 P0ULOCJhO2/rIV+TWCoCZstdjd7qtrN2Vll6y6H8SnEIVE8yZiNAASQmfbyXJ3VDEXca
 29vIOf2coZyRNupZXAw9jx+r1w1+ys8r35tNsz8xupdSDU4E7jUJu6UMhy1OcNHWndxN
 YXwQYYLUPJyhSzkhOCnYQYCmvmOgY8HEjMOblmLYbD3O2aFoayT8YpbOO0aHvTmWMw3n
 jw/A==
X-Gm-Message-State: AOJu0YxVMRFMWqUMrjnTPsMOaM1I+O9c4LYWmZiK7yI3P+ycW0f86QeK
 zBWYsrGnQtPtQlPrdFfwVHStgimaflm8raMEwNPJeCXLvuBm5NUn+XttYV1RllPjtFc=
X-Gm-Gg: AeBDieumLmujijprbVPVU129kCA5KQzUhvoW7ZJJCFDQviHVfcMSedekYKXNF4mUeQi
 t1CVpZcBvQolto1+DAb3h74COtwDSMPDiMb4kVobszM3GNor/zuLhIkQe8wgOS4M+bTCKfqYhLJ
 1vbq3wwlnUOi/4ZKp/6ElxuUTFJGUl+yADm8vsPm72ZKvveFlTfJt03chBTLFKgr/IxCSAB0H6g
 AniYppCAb9lhZHWaYy5IYJ0HInCWiX+D1Noj7CyEWNdqPOVqS61sYXvzr1UAmooVXM78141clGx
 WEeaFgMi0r2WQPm9tOWfxcTHhObfJimzO+iCfotX8i6Jk0YhbbZUQoa/wbfoF2uWNfqOnrsSJMS
 Wg+jyRj4zpaNDNNNTFibZnyOOzpkYgArfYpRToO85+0mphZmsMNVRib9Hoz7sdFwHPX/tzSyb6h
 jGHPqWeILGES3EmenwDDB3rzTawKnQXjGPW5ICkwkE5MB7r7GnKiHf1Mj18J6K7Zi4
X-Received: by 2002:a17:903:1b66:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b2d5a18e13mr249025135ad.22.1776335288073; 
 Thu, 16 Apr 2026 03:28:08 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780ef741sm49410425ad.11.2026.04.16.03.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 03:28:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:28:04 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 12/14] target/riscv: rvv: Add vfext.vf2 instruction
 for Zvfofp4min extension
Message-ID: <aeCymertMAq3AZd8@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-13-max.chou@sifive.com>
 <aahK0egnN_1lEWnH@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aahK0egnN_1lEWnH@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x634.google.com
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

On 2026-03-04 23:13, Chao Liu wrote:
> > +static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
> > +{
> > +    if (vext_zvfofp4min_check(s, a)) {
> Missing REQUIRE_FPU here.
> 
> All other FP vector instruction translation functions
> in this series (trans_vfncvtbf16_sat_f_f_w, trans_vfncvt_f_f_q,
> trans_vfncvt_sat_f_f_q, trans_vfwcvtbf16_f_f_v,
> trans_vfncvtbf16_f_f_w) have REQUIRE_FPU at the top.
> 
> Without it, this instruction could execute even when FPU
> is disabled.

According to the Zvfofp4min specification,

"The vfext.vf2 instruction does not access the fcsr and is not considered
 a floating-point instruction for the purposes of the floating-point
 context status (FS) settings."

As a result, the vfext.vf2 instruction will not raise an illegal
instruction exception when the mstatus.fs flag is disabled.

rnax


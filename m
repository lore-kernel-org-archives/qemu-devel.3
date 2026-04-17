Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB87F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDYV2-00016d-SF; Thu, 16 Apr 2026 22:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDYV0-000162-KM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 22:00:03 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDYUz-0003Uz-5y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 22:00:02 -0400
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8a3970f1a0eso1998526d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 19:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776391200; x=1776996000; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AQWE7MVsaiv2wFwGe/YK7MgNNskxHHG7J2504VXZVBY=;
 b=I6XeGG0IG6JPqwUnXSE+bzRajCmQNfN+6rSSBMucnyiXcD8kTwmgKvaqLtYNsY41LU
 4+tUJ9CWa3vgM60miBrxDN46epNq4xc57Flw7R4LCnaU5FF+UEijLvvmlZw5cvGi4CgF
 ildYj6C3JGCRsuq4sdpMDLqKfvPAbmc2q2MpRNsN72Dl4D/maJsKAG0TQ0sugcIxeaF2
 tE1HCseDDoXpoMYHqt3Mf6NxuODJXwAQhc2EzNjlf6SUlf2+PjjqvTmnlnRFP8uMZDlC
 zlcTWsjIXOkGqxNa7VRf0EPIKs/Sr4Hf0YtpB0geL52whGurMzs2KtIBvUVZj8FyH9W5
 AL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776391200; x=1776996000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQWE7MVsaiv2wFwGe/YK7MgNNskxHHG7J2504VXZVBY=;
 b=LZQlDug013+S3jeVsk1xWFDIA1SfXLUmfiuYHa4WdB2u9E5dtdaVXe0rZ0tDjIoBLb
 mGXS5J9mXFxXBqXPO4uNftKJ6S58EC1UaSzWEM14PKZJmKScpgNyXobiKFnaNMhTm/b6
 CWqXt1kAkprL4krE3IzVtpCU5JSWseD/Hvb1RqkSWKzUkC4hTrKZIJlIQgAVTxY1AmzI
 3oHpBM9Fa26iW2kvl60cXVRXaMkoSmew8CgCdgR51u7S7aF/da1ZAOVQuZ+lsVuqHBg5
 bpdtDNfvg9Q1vk9AR72RpTDseWJ3OnjDSDQxY03/DyFd4SRodjquzEUuvwe4gA00tClO
 gMgA==
X-Gm-Message-State: AOJu0Yy/oWGzilOtGDXBMrT32dtE5lJG5pFj6O9Aa5ZMyx6wmiPs67GD
 nmH586Vh3dkheY993JvRaoOfLOP5J123h2iNyDH589pCzGP0ZoWKP+15
X-Gm-Gg: AeBDievpBkIdesEgGWsb9n8yc5+voyZsH4XoLUPJHJ4K9chMb/OX+giX8s5PkFill+d
 RLdyk9WfXQviIXnLQ/5btvTp2mCihSMYnHzSiU+6tbuWkyv+sdWl849ds4HaoOsIz7InsVy7fih
 O+tnOsCjTKCMjMgzH/UfMRaanJoxKdy3yl3bfxevrqyZfEIFpSXa9R636jSOzD2sV0Uhlooau7W
 xX1ZUyad85Lh9hRiYK3OxHLesUiQuVESZE59kiXgoqUQpSBtROmL2oh5fpwGWhjJP6vyLPAjm85
 UoFet+oysUjGxkk7TKDoucVEKuAjK1cpeoP1YmHZ/gmiXOZEDVyxoYWyQYXgK5cud9cYuVymwOJ
 i+lV/984A4tIlRrFdBxXny8mXQyDp8XqypjC1ktoE5qv2LAhCKLlT7W9MkeBPK6oVdBzMEw3rXU
 0fCT2hq24aqVNkw0SU8vaqhGG+Et3X5X5vQEGFG3kZbtUZHni4I4smwcNylHPvx93VP4Jk4OtxB
 wlnLnksExs=
X-Received: by 2002:ad4:5ba8:0:b0:8ac:abc5:8756 with SMTP id
 6a1803df08f44-8b0280d0e1emr15903626d6.25.1776391199794; 
 Thu, 16 Apr 2026 18:59:59 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5ec2dsm77226d6.29.2026.04.16.18.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 18:59:59 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:59:47 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 12/14] target/riscv: rvv: Add vfext.vf2 instruction
 for Zvfofp4min extension
Message-ID: <aeGTU0gaUn8pyOsm@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-13-max.chou@sifive.com>
 <aahK0egnN_1lEWnH@ZEVORN-PC.localdomain>
 <aeCymertMAq3AZd8@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCymertMAq3AZd8@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf44.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 16, 2026 at 06:28:04PM +0800, Max Chou wrote:
> On 2026-03-04 23:13, Chao Liu wrote:
> > > +static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
> > > +{
> > > +    if (vext_zvfofp4min_check(s, a)) {
> > Missing REQUIRE_FPU here.
> > 
> > All other FP vector instruction translation functions
> > in this series (trans_vfncvtbf16_sat_f_f_w, trans_vfncvt_f_f_q,
> > trans_vfncvt_sat_f_f_q, trans_vfwcvtbf16_f_f_v,
> > trans_vfncvtbf16_f_f_w) have REQUIRE_FPU at the top.
> > 
> > Without it, this instruction could execute even when FPU
> > is disabled.
> 
> According to the Zvfofp4min specification,
> 
> "The vfext.vf2 instruction does not access the fcsr and is not considered
>  a floating-point instruction for the purposes of the floating-point
>  context status (FS) settings."
> 
Thanks for the clarification.

> As a result, the vfext.vf2 instruction will not raise an illegal
> instruction exception when the mstatus.fs flag is disabled.
That makes sense, since it doesn't access fcsr, the REQUIRE_FPU guard
would be incorrect here.

Thanks,
Chao

> 
> rnax


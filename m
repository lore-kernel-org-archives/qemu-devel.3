Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3CDC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 02:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW5SS-0002kN-48; Mon, 22 Jul 2024 22:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sW5SQ-0002jt-V8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:40:54 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sW5SP-0000Tq-BW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:40:54 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-66c7aeac627so19578277b3.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721702451; x=1722307251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qQ0NOJeSzk3ksu5vD1QtCywLFHUsOxKCMkXlEj/+kRo=;
 b=RI44JKOu/9X+ET5uSHr3fxWvFMNhkYXKU9+zDXZeUICDtpg4dE++jcc005h41YxAAF
 305uTq2qxaXaB1FMVTPQkHpM3wYCKJJc5V6sX6oUzPinFEdoMW+4lJBEnLb8e5LYfRBY
 SwwoD4D6l+3K5/7FsQXpq9Qbp4ogKiH6K2jp469qwJAe9xO0egTnvzyloHRboA+BH3Zx
 w4wWe8nearMeOeJM29cWSGXFmKhT6IiECSvG/10V4yuV67ucGaTJAzxL4qJq1VdxfD1Z
 kbyRta4f7K6qtpNe/oC/LS3ENem5rg+jiPh9DQ3NUtDgw1yOeurg3CLAnuZqkKaHAkph
 +IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721702451; x=1722307251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQ0NOJeSzk3ksu5vD1QtCywLFHUsOxKCMkXlEj/+kRo=;
 b=dwZgezwHNH4h8n9S0zEDo4aM6V8rzLGebMFjPuaIU1bjtzxm5z/5hLJOyLna0cfybN
 hR6RlcE7nkRpa/nJWscdmew86jfHtu/4K5jdL2X4PVOeAW3YSgxlvB7XjuIdTl06PP9F
 6Ry6YJBLEMudnRwcRJC+8Zwr3HStRuOWJ6Ql7KL1sKIb0rk8kvIo58EdCIm+Wm2IQ515
 aNCyPSLUZPZ0i/ZpJbBoAPVR+qRBg4yh90P9eQ69aIX+7Qy8Cw8wxmerYtR1QlprhoBi
 Om143J7HJqO7bkEz0Juo0jETu6FGe7vGpslbWw03kQEc+KuXpBJO5zeUfBnLOMS2fT7+
 he6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3hB1PSW+l29dhU50/s2VxoAYNYBq2lhSu1dpYgKcGWmhuQGYCeTVuoMAQd+nqP7p2Y0nbnl+ccmRvnsMHX7QnImibgKA=
X-Gm-Message-State: AOJu0Yxpv2uYSvPdfuR/rSQOAJ4fo3EHmvf7+jbC1xmcNt6O/E4xyFEh
 v8WedR8lziJvtYC+auNmfyjBMjw4VmWdsTKVnE5eHUUQwtQeCmDcQdzbwjSW3CAj3E5tdRX0v9U
 lg07PNPogQQBERVA1VCoQOqpuugk=
X-Google-Smtp-Source: AGHT+IEpcMbSTVfMWIruxm7skat5GPqtOgp+Sj8CMm6CrjuXssCOw4GtMkVV7wcF/8OxiUnVvw+U9F4VV6PRgL/E7Yc=
X-Received: by 2002:a05:690c:250e:b0:664:cc54:2f63 with SMTP id
 00721157ae682-66a6a60b38fmr100089267b3.36.1721702451677; Mon, 22 Jul 2024
 19:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
 <20240720142902-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720142902-mutt-send-email-mst@kernel.org>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Tue, 23 Jul 2024 10:40:14 +0800
Message-ID: <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-yw1-x1136.google.com
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

> > When dmar_readq or devmem2 read the DW of IQA always 0UL because
> > "& VTD_IQA_QS". So, try to fix it.
> >
> > case:
> > after vtd_mem_write
> > IQA val: 0x100206801
> >
> > after vtd_mem_read
> > IQA val: 0x100206001
> >
> > Signed-off-by: yeeli <seven.yi.lee@gmail.com>
>
>
> how was this tested?

If VT-D hardware supports scalable mode, Linux will set the IQA DW (bit 11).
In qemu, the vtd_mem_write and vtd_update_iq_dw set DW well, however,
vtd_mem_read the DW wrong because "& VTD_IQA_QS" dropped the value
of DW (bit 11).

So testing the patch is easy,

config the "x-scalable-mode" option as below:

"-device intel-iommu,caching-mode=on,x-scalable-mode=on,aw-bits=48"

after Linux OS boot, check the IQA_REG DW (bit 11) as below:

IOMMU_DEBUGFS:

"cat /sys/kernel/debug/iommu/intel |grep IQA"
"IQA        0x90        0x00000001001da801"

or devmem2 read the reg:

"devmem2 0xfed90090"
"/dev/mem opened."
"Memory mapped at address 0x7f983014f000."
"Value at address 0xFED90090 (0x7f983014f000): 0x0"


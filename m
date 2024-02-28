Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6E8C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKof-000500-IK; Wed, 28 Feb 2024 09:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfKod-0004zh-KL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:21:48 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfKob-0003dn-SO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 09:21:47 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5661b7b1f51so4188178a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709130103; x=1709734903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/0EjhDOUqjjQLZw54uMApzo5f3ifbogZRmzF8GKsk/E=;
 b=Th29sJWGfXG0EPi2+yiyLkZZvxQ/B/6cKyQqjhGfdIeJVMTn17cHMP/ERZiNeDCaHC
 Q+PJBOB91WfxFLI/hJPcBmbiyokJOJn72093xufwn32VZJSL4Uenxt7WDegwgcmbvbru
 IgJkxvHpDldRsagGfOTsZeHEK+07DNFSetoumbJ6t5rtWuKaKIW1jSCmyTvduCy2xy0Q
 ti01+zFTMTPZSYbmCite/F4hzdBvRshgf1pK6ucbWi8Tc7Gbi+5K5ym18de6z/B8JKh5
 ZXQ5gd8RHYhNLitcubGkKDQnXXnIW1FPAqiiBzTteU9JE7Y+dmRn/1035A8K5Fz0/K4Z
 lVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709130103; x=1709734903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0EjhDOUqjjQLZw54uMApzo5f3ifbogZRmzF8GKsk/E=;
 b=r1yIRF6jz7JHnY2NRVoFIYBqPBiYVdPAPvBtOS2etYZAybvL0hQPiQHlVEwvf3W3/a
 GD7zoq7TV0EaYoBZ1D6Eb00UCWw50mF6Bb6W9/s6LmxkrfU6UvaW+hWDunI/uSGvWVcQ
 /JblApp/eCzZr7vlMSv+5glh1yWWcLu+wRYPxT6kqpb45mnjgE7Mch6fnRoDO8enGtGn
 OebhMRBb3pSKeMSOjCuBvAw7mTcYihwebK2lC+9RbH+buss/nIFyacPkCkJ4AjCyAQC/
 KkdKoQXukyxi9xJ31jgCxgxVd7YbXgmRpmuWtANapUl2joDYbpi8eXJv0M5Q0ZMIeQ78
 4XMA==
X-Gm-Message-State: AOJu0YykOoMbESNYmI92PVMKwWlUK05hLbY5UmTPRZY33CkBMRTdWCjK
 lNDOwJaS1gypAAK3swaLJjK1Zzf96RxluZLVhQAIzgO372In88VkA82vMNzoan8gN2xOH9T+ZYN
 AY8I7Ux0EzeGNlpw2svZWUZNsPqRR5H5hMuyJZg==
X-Google-Smtp-Source: AGHT+IHsCn8EGVGbjZc8XFJB158gV4ygJ+S79tluhEry3Bj1cWcCSH7k1v6axYho7cQT8RnoCUqhyBfQbCiYtjabwAI=
X-Received: by 2002:aa7:d982:0:b0:565:fb4c:7707 with SMTP id
 u2-20020aa7d982000000b00565fb4c7707mr5354779eds.26.1709130103465; Wed, 28 Feb
 2024 06:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2024 14:21:32 +0000
Message-ID: <CAFEAcA-EnsmNkLuJb-dVZbT0+2TPJSw94eeEbx7JNiULsMKgUg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] memattrs: target/arm: add user-defined and
 requester ID memattrs
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Feb 2024 at 22:24, Joe Komlodi <komlodi@google.com> wrote:
> This adds requester IDs to ARM CPUs and adds a "user-defined" memory
> attribute.
>
> The requester ID on ARM CPUs is there because I've seen some cases where
> there's an IOMMU between a CPU and memory that uses the CPU's requester
> ID to look up how it should translate, such as an SMMU TBU or some other
> IOMMU-like device.
> For a specific downstream example I've seen, Xilinx overrides CPU
> attributes with ones passed in by an object property in order to have
> their IOMMUs work:
> https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a45643fe2172d6f8ca/accel/tcg/cputlb.c#L1127.
> The object property with the memory attributes is declared here, for
> reference: https://github.com/Xilinx/qemu/blob/23b643ba1683a47ef49447a45643fe2172d6f8ca/target/arm/cpu.c#L1310.
>
> The user-defined attribute represents optional user signals that are a
> part of AMBA-AXI. As the name suggests, these are defined
> per-implementation and devices that receive these have their own
> interpretation of what the user-defined attribute means.
>
> We add them in CPUs and PCI transactions, because some of their
> attributes are set in functions in ways that are not user-facing. DMAs
> or other devices that set attributes (using address_space_rw or some
> other means), can add them on a per-device basis.

So as far as I can see, this patchset defines a bunch of mechanism,
but no actual users: no device looks at these new memattrs, no board
code sets the properties. I don't really want to add this without
an upstream usecase for it.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2041CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgfE-0008HE-5m; Thu, 11 Sep 2025 08:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwgew-0008Fh-Dy
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:44:19 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwgen-0003xr-K6
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:44:17 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-88762f20125so53621639f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757594644; x=1758199444; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yW90efROcsM2IUxTHOGCg8qqBVBwuI5GuHrye/uDWGI=;
 b=iDoy5nPVhuBzEpkOpjE5EdVf1z5eHh3ThuptUulVaDe1K8X9Qijtn053vbrQtDklWm
 UtOgHPD9xzuujmTQHdpdpEKsCzAwOfaQbVrZP9mi+y2WceJgSvKnrk5iOI3QErB9z7sG
 Y6R3phX1hivfRaMCuGDCK8ykdO0T3aXrMJaZerKjUrfqw4XkTukbX2S27lzVRjpL5U9W
 lYb21H1+qXv8chfnVvymaHg87pg1Tzozd656gIOxjd83C3rAd3+9Xx+rnFJSy7SF75TR
 oXntYM8SFVMqvkrNftsK46aqWVlMBjFozSqYKC3p9s2Adxi2AtfUqiO3v/CySDQ3wAhh
 TDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757594644; x=1758199444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW90efROcsM2IUxTHOGCg8qqBVBwuI5GuHrye/uDWGI=;
 b=CLBEXbaC+MosKZsE8WrDR9o2gXbdFgoF4dX510UPwlKjAzlwGkCGgbL6dQEOssIRrj
 zYZ0dc4U6Yxmovb7mPU4RXYYN3NRWdPA5YvnmWkAIyqXZqhHSQuWjZ6W3jGaWP0UvcpW
 u47NJ5nJ4Gr6MTZk46VxiwFX4bpBv3uyKWmvJEqO+LiuvbvfAbcc2vxUq1ZjaKuyOU2t
 Xa5C5tpOPBYQfM21kzgGdqIq+HOeh64F8lbUuJCDz8nH+vp2Q+qDhIQD98rogLqAlOE8
 +GbuMVS9AePEKLsZDQHpXFB7xh93oeYKXvLSpZ4QyZCsQz2DG6/8n+AsV6JQroFqSWVJ
 +5IA==
X-Gm-Message-State: AOJu0Yy7YC2XG+1RfdANQC+BquzzqYnaoNcASmghwsm/vB8ruecOc0ug
 KHM+fVbohflG+S/+rnezz3kWZGo1wIEiPUvB7o2FiAbM/I9+f4kLMLiQtpxkq5t/UUs=
X-Gm-Gg: ASbGnctnwMoJXSOqdE0N08nH4lfa+napmdP4gd3W9mU/cxspvSYEaDVy/wsR2dKl3mE
 GfvybTA02sYVO9e9IZz+Kw3AYGl1QCukQpb2IgvBmBgk1180e6lT9uoqKOcU+phIWPbn1rlPaEx
 9Vyom3fDKPWwvwB8edyFcTr76zWM8rvSaApu9HiOGBFST0xYxGIz1I/0ZqZ3VEJvczd1zEichpf
 0e4fkBlHzXhnOmbU17vR/yil35ohJpXZj8JsTjI6BbBRRYw+Xj8wn6CkQa+L5NWCjDRMONUZciS
 lOKWMfo9EwnVSB0n/Gp+7ZnKT1k7yrGlBemgMD00Jx3ODFSj8IzvDLWwXZdM7L/7mGg8CF8aEuD
 9jPz0CzAvWpjxzTY2/xXmRCVY
X-Google-Smtp-Source: AGHT+IFnQWkyraTMmbqyAiW0x5V5ifu070ly3jVZ1z8ptkdd8K03YxM3hPWXSFzc/ssdjJvNf7l6oA==
X-Received: by 2002:a05:6e02:b41:b0:414:d8b9:5aa8 with SMTP id
 e9e14a558f8ab-414d8b96034mr120358085ab.32.1757594643815; 
 Thu, 11 Sep 2025 05:44:03 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41deede6de7sm6379805ab.10.2025.09.11.05.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 05:44:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 07:44:02 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, mjt@tls.msk.ru, 
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com, 
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: Re: [PATCH v7 for v10.0.0 0/2] =?utf-8?B?dGFyZ2V0L3Jpc2N277yaRmk=?=
 =?utf-8?Q?x?= riscv64 kvm migration 
Message-ID: <20250911-d0793572c80e87bd6614afe0@orel>
References: <20250911083617.1173094-1-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911083617.1173094-1-xb@ultrarisc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 04:36:14PM +0800, Xie Bo wrote:
> This series(v7) replaces the earlier series patch"[PATCH v6 for v10.0.0 0/2]
> target/riscv: Fix riscv64 kvm migration".
> 
> Changes since v6:
> - Patch 1: allow boot CPU to be randomly selected on each reset
> - Patch 2: unchanged; keep Reviewed-by from Andrew Jones <ajones@ventanamicro.com>

Except my r-b isn't on the patch...

> 
> Xie Bo (2):
>   Set KVM initial privilege mode and mp_state
>   Fix VM resume after QEMU+KVM migration
> 
>  target/riscv/cpu.c           | 17 +++++++++-
>  target/riscv/cpu.h           |  2 ++
>  target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  5 +--
>  5 files changed, 70 insertions(+), 17 deletions(-)
> 
> -- 
> 2.43.0
> 


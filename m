Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B48CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4CI-0001mG-JA; Mon, 01 Sep 2025 09:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4CE-0001fv-E1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4C8-0005vH-Oj
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756731814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKB4GPq5/a/dO0dId9uw0/13gbdEKz9SwvtcViYQTV0=;
 b=TdYs7zILiZpVvP8qiyz1j1ROlcy4lHiN0PBvWcFhoxZ6Uk99gjWFiotfvbIEKpNBikIgDi
 riFZmQsXGUq47ZMre0mrIelRHfVHYINvjwcYvWEBSFGR+OmQlxIoy0mclUaoxsDhO8BeBd
 pk0lr+YfwsFCWqfE54gNVJf/FSByz/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-P6KOpmTINlG--tKnTfb9xQ-1; Mon, 01 Sep 2025 09:03:32 -0400
X-MC-Unique: P6KOpmTINlG--tKnTfb9xQ-1
X-Mimecast-MFC-AGG-ID: P6KOpmTINlG--tKnTfb9xQ_1756731812
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7bb85e90so33490685e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731811; x=1757336611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKB4GPq5/a/dO0dId9uw0/13gbdEKz9SwvtcViYQTV0=;
 b=tSIvxmt3S7cw36Xm3Z56gNrOKN4ZmisGnmdOFGz9nKcuOHBmU0qyZ6lmtCuhj4NMra
 exsxf6to9+pecMTwCfLFNW3XtF652komKrElg+tQ5LZN4JE/yR6MZXzVl36iS/PvgokN
 iaIAotZ/XionWRvcVc7WXETS3MU/usvN7Wdc4N0UqZ0NGNCehY2oFMnytsGw8rvJs99+
 ujIi/ljCri5xO4om9J40ruW4LblrtTzB/5FK4mEei9kJHco++966JSLQ5r61yh6g1Fgu
 Ju8eSC1FC1OBYCmF3ThQjmvei7UaiRMV3RDyoA7fY8wHMayUbz0apALLftLUUNddo1U+
 R6yg==
X-Gm-Message-State: AOJu0Yy/MPnpsv/0nZi3Gj6fVOOIqwmXL8dv26qfr9SjnZJTBDtORr+q
 kKu8K+gFWZ3ogheyYt32sRBGX2r/UxznzE62s+MPeqUZ61/6lUynPxbC7OIjE4QNVV+ZcKDUDCB
 d1k2+WNIt6W9F4k/vY5wdDjrLCiLcHp5DQOVF1L4ReEKwaNM7OKHwns9TeWgSc8b1
X-Gm-Gg: ASbGncsxQh3drZ8p/9KttJKzzsxq4N9vVo5U1/yaYLYpk0FoKfVLfJ8QkRp2PaH4IzR
 eB79FUp5XSjMAe61N/IhPTqnbWf3QVbhFG3UKKPvpvq01MIrO/RLZHs0A1MJ7cmCA5UtGAYTjYY
 Utd4ejzY1sjNyAnwFL0T93wtPJ28tSjL8ngKoLHtEZxHO33bqnNQo0ONcWyfpt/xw/TSVPO2RSj
 KZN5fJdr1vB08LE5seSg2bqaJ2/MS/TFM1eMPpN/HGVVsidfZc4jUKIWqRlDhMRg9/MDvqpSOkG
 t4DXIAzftn0oJz+8Me80ECL8xRft9g==
X-Received: by 2002:a05:600c:6210:b0:45b:8d2a:cd07 with SMTP id
 5b1f17b1804b1-45b8d2acf12mr23447375e9.5.1756731811406; 
 Mon, 01 Sep 2025 06:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESbKeHCtfI9WE+7ZnthKPQ/xzFATjtVNKJYlHRtUofE1dbE7Sv/FQt6Tmxs911+2Suj7GxmQ==
X-Received: by 2002:a05:600c:6210:b0:45b:8d2a:cd07 with SMTP id
 5b1f17b1804b1-45b8d2acf12mr23447075e9.5.1756731810959; 
 Mon, 01 Sep 2025 06:03:30 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm237287775e9.4.2025.09.01.06.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:03:30 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:03:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 01/18] target/ppc: limit cpu_interrupt_exittb to system
 emulation
Message-ID: <20250901150328.59e1e57f@fedora>
In-Reply-To: <20250829152909.1589668-2-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-2-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 29 Aug 2025 17:28:52 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-ppc* binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/ppc/helper_regs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 7e5726871e5..5f217397490 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -274,6 +274,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
>      return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
>  }
>  
> +#ifndef CONFIG_USER_ONLY
>  void cpu_interrupt_exittb(CPUState *cs)
>  {
>      /*
> @@ -285,6 +286,7 @@ void cpu_interrupt_exittb(CPUState *cs)
>          cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
>      }
>  }
> +#endif
>  
>  int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
>  {



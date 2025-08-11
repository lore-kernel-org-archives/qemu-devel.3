Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4D4CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVRF-0002Ep-CH; Mon, 11 Aug 2025 12:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulVRB-0002Dj-C3
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulVR6-0003sP-CW
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWLAUcEN9k6urOmsNReqKP6ftsZ+nZMLCMQOBaApZJg=;
 b=Brgd9oHdZGySuLQeN35eKN+s2UKk4VCz4wkY2WUyK3xiQ4dTluZQsTlR8ic7OnefbY5SO+
 V4jtWTO6hv9XhKMfIj296PKX2pQ2e/ABjHXzd/gLyeqTzA8HByz005q+OgC/hJPQAhK1Ki
 1oVyXmRSfq2e1JFpb+Wl0Eh+AQ+a8GI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-dYCTkhuqNG2tq8PCPWWXTw-1; Mon, 11 Aug 2025 12:31:41 -0400
X-MC-Unique: dYCTkhuqNG2tq8PCPWWXTw-1
X-Mimecast-MFC-AGG-ID: dYCTkhuqNG2tq8PCPWWXTw_1754929901
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-88dc297fe74so945214241.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929901; x=1755534701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWLAUcEN9k6urOmsNReqKP6ftsZ+nZMLCMQOBaApZJg=;
 b=iQhcjk/mM9fdiUlMJVtFSyf3RwwL0906wZAmMoSRZk840jRV5R+v4OUM6LSFQ/R0AN
 WdkOJvelgHphUAYtnhziqMahMDx53iwKlAB6OGrDJTyty4tuNKmtnQPNQCy6AqaHeuS3
 aKtOi5hOhsr//AqAJwcDHOyKWkWmKbiLFZWkf1g5hoODhqCvBDKdvOVGSNWLpsheuNE+
 5G6gAa/8TUEnEdpj0QhF2sz5ZaBRsSXYHXbRcXmbvJoZ2Ww8EwU9BwYdgmlnzGgmTQ7I
 f7KEQRgYW1uZryuMweCnnnBtxWa+fRY+jJsBnUusig7NO8roINqQKqu2B/Lq/v5bnexr
 Fsvg==
X-Gm-Message-State: AOJu0YxRryJjed9bik2lvfXrAUES2CPIncbRdgHJf//kso128UmxQqi/
 lbERNBJxJ8J8gVp+NSWOzNvi25J4ybOrae1CgsAjK7Yz0QUbJkZbNlEBjNeDlzjyjuYIzD/ZWus
 OjumDuffWkrxi6cZ5Nj+P8DXOq1v4Mj7vGolxJ5dGYdjrQoxpojWeGHOQ
X-Gm-Gg: ASbGncs10Uwn9/CpC8AJOuYEwFU/oCYiRNNHpTXd002vdUkpogmRbEw4HB0IZP24iTB
 tmQN+Itq9FVUJzBUqKTuVtf2NsjC7DP+E/VGWPdjojoI3TljXLuAgd8K+HdIPCC2mLCXMkHR6cy
 /fPJIFWnzyQIPm0Rs7FRRXLnu+h+TtUqHHb/C8D8QxBo2wYR7mZfbo9K+HXOaxn01p4wpSmdD8K
 1P7WX649RYigtfWNgaho6LjLrv/2RzC4zy+rBinNr19HN2jGDTg63XJK3r7X6KqBwH1OzmhFXkW
 F6h2695FRgg4MfLd0OQq3qILlKNXJytV
X-Received: by 2002:a05:6102:8001:b0:4e9:a01a:ed57 with SMTP id
 ada2fe7eead31-50cbf740fc4mr267163137.20.1754929900401; 
 Mon, 11 Aug 2025 09:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRohMlcHY4gPSVhUglLdbV74mAnk5heTWTqVXL3G16YNKZWdF3Z9xLm+LRgfRVxovNE2dYw==
X-Received: by 2002:a05:6102:8001:b0:4e9:a01a:ed57 with SMTP id
 ada2fe7eead31-50cbf740fc4mr267102137.20.1754929899889; 
 Mon, 11 Aug 2025 09:31:39 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f75596dsm1580154385a.76.2025.08.11.09.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:31:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 06/10] introduce cpu_test_interrupt() that will
 replace open coded checks
Message-ID: <aJoa35wuexHfoCEE@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-7-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-7-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 02:01:33PM +0200, Igor Mammedov wrote:
> the helper forms load-acquire/store-release pair with
> tcg_handle_interrupt/generic_handle_interrupt and can be used
> for checking interrupts outside of BQL
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/core/cpu.h     | 12 ++++++++++++
>  accel/tcg/tcg-accel-ops.c |  3 ++-
>  system/cpus.c             |  3 ++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..d0460c01cf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -942,6 +942,18 @@ CPUState *cpu_by_arch_id(int64_t id);
>  
>  void cpu_interrupt(CPUState *cpu, int mask);
>  
> +/**
> + * cpu_test_interrupt:
> + * @cpu: The CPU to check interrupt(s) on.
> + * @mask: The interrupts to check.
> + *
> + * Checks if any of interrupts in @mask are pending on @cpu.
> + */
> +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> +{
> +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> +}
> +
>  /**
>   * cpu_set_pc:
>   * @cpu: The CPU to set the program counter for.
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 3b0d7d298e..02c7600bb7 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -97,7 +97,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>  /* mask must never be zero, except for A20 change call */
>  void tcg_handle_interrupt(CPUState *cpu, int mask)
>  {
> -    cpu->interrupt_request |= mask;
> +    qatomic_store_release(&cpu->interrupt_request,
> +        cpu->interrupt_request | mask);
>  
>      /*
>       * If called from iothread context, wake the target cpu in
> diff --git a/system/cpus.c b/system/cpus.c
> index 256723558d..8e543488c3 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -256,7 +256,8 @@ int64_t cpus_get_elapsed_ticks(void)
>  
>  void generic_handle_interrupt(CPUState *cpu, int mask)
>  {
> -    cpu->interrupt_request |= mask;
> +    qatomic_store_release(&cpu->interrupt_request,
> +        cpu->interrupt_request | mask);
>  
>      if (!qemu_cpu_is_self(cpu)) {
>          qemu_cpu_kick(cpu);
> -- 
> 2.47.1
> 

Besides the two writters mentioned above, I still see some more:

*** accel/tcg/user-exec.c:
cpu_interrupt[52]              cpu->interrupt_request |= mask;
*** hw/intc/s390_flic.c:
qemu_s390_flic_notify[193]     cs->interrupt_request |= CPU_INTERRUPT_HARD;
*** hw/openrisc/cputimer.c:
openrisc_timer_cb[108]         cs->interrupt_request |= CPU_INTERRUPT_TIMER;
*** target/arm/helper.c:
arm_cpu_do_interrupt[9150]     cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
*** target/i386/tcg/system/svm_helper.c:
helper_vmrun[406]              cs->interrupt_request |= CPU_INTERRUPT_VIRQ;

Do they better as well be converted to use store_release too?

The other nitpick is this patch introduces the reader helper but without
using it.

It can be squashed into the other patch where the reader helper will be
applied tree-wide.  IMHO that would be better explaining the helper on its
own.

Thanks,

-- 
Peter Xu



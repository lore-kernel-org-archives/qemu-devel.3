Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0CDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4E3-00042v-4J; Mon, 01 Sep 2025 09:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4Dz-0003pV-S6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4Dx-0006DF-U6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756731928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkBNhHZPHPQq3WDLq7PG7Ms5EwM8a+YiIb/CCpvE65w=;
 b=ddl0PFCjtQuc4Sr4dnnHvIcBbemIAPLwyEGB9FUA33gx07kimRy7nNuz/3QlAPSJS2a53d
 4u4uSyy68jgckKDFy6K/wVcpvNoQTYUGK4CC5Wi0lDfS5r1iIUiQZVFL1z8Fm29A0z0sx5
 PNDuf3ufc78GyCRK4T/RtL1EXYqLihw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-l7UlCZPJMVim4ldq1j13bQ-1; Mon, 01 Sep 2025 09:05:27 -0400
X-MC-Unique: l7UlCZPJMVim4ldq1j13bQ-1
X-Mimecast-MFC-AGG-ID: l7UlCZPJMVim4ldq1j13bQ_1756731926
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7f0d1449so15372395e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731926; x=1757336726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkBNhHZPHPQq3WDLq7PG7Ms5EwM8a+YiIb/CCpvE65w=;
 b=fbDVkGlME8p4JZc27syvfxcNCVXhg7AvtWnsYowMeHbKUeQAJJqo59V0mADfOm0sxM
 1NymSEcGez42Kg2sVoGP4YndOHMN9HUZGN49BWrZgiUYoRiDZuA+hpYaSUVdNelIO3vo
 Gy9UmqK6I79dX8heGnS0HJqRnMPi05QPgDg0ypvln6FIW+U7jBnP2bLCbtgfV5bWINeW
 i8oBkWfRFXGMKHvMcMXXBr+Ue77dihRfD6hd0ettuxNM3uk7aH6h79HLAG0Cl4jGyC6P
 /s5Bl5VaxF35Z/dAJVXIO3iLROufv2mz2Pl+uTmfTwQRzNN9c4s5cLnM4SufZk/NR+RN
 us1w==
X-Gm-Message-State: AOJu0YwJIdC4Tyo/gZzjeysq8L2X6+9skIa+c35YmovH0wNubSiO+xSP
 iYom5Y3KJ+iqg5if7wTailJyhlPIcWfrl8C8tw1a1EEE+LkdzWuXLzSkzj41GQ+QBEPIYKcqM6m
 /6eOYSqKAqVanbKzXM+3Ji3Pk6ddP26FdOyFzVmXMTWHdKUTmffwU8gRN
X-Gm-Gg: ASbGncvOGIWOnfe9z6Xp2ihF/5QYPidk/JbaIMniMHWtuLCbz178klMjmaNQIMqvrOL
 zrSqJxFav6YGx4EEPR0nHu5Rhb7ljH8rPF/2BjaXRf+jJxBs961zk0AvwFQz1h7WSlyM8FYy8Is
 KdtmsGXgO/Z7N/K9gFtvHlBnRGJVMBRsq3vrEFrMzHdob2fABmIl176JUwDpfV3TIS6CK75uZPU
 zeWhXX8sNmeC8kkB2taZu5P/RihzsMoBVqWewyO19NMX/gjhSbp4jCT61UH+A9fDDkNMKd28Suc
 heD3k7eDdy7hFfesxBxXRLYpMX678g==
X-Received: by 2002:a05:600c:138c:b0:45b:75f0:2d66 with SMTP id
 5b1f17b1804b1-45b8553da82mr59652635e9.4.1756731925696; 
 Mon, 01 Sep 2025 06:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgy/s9fRsj+BHa8dGuIyLgEzli7TV1JRkDGQkCwQMh9wbzmEpuJeDmMLWQL4jhiqpUVYPL3A==
X-Received: by 2002:a05:600c:138c:b0:45b:75f0:2d66 with SMTP id
 5b1f17b1804b1-45b8553da82mr59652235e9.4.1756731925168; 
 Mon, 01 Sep 2025 06:05:25 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab093sm161624625e9.22.2025.09.01.06.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:05:24 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:05:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 03/18] target/i386: limit a20 to system emulation
Message-ID: <20250901150523.0ea8d1f4@fedora>
In-Reply-To: <20250829152909.1589668-4-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-4-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 29 Aug 2025 17:28:54 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-i386 and qemu-x86_64.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e0aaed3c4c4..651041ccfa6 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
>  /* x86 mmu */
>  /* XXX: add PGE support */
>  
> +#ifndef CONFIG_USER_ONLY
>  void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>  {
>      CPUX86State *env = &cpu->env;
> @@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
>          env->a20_mask = ~(1 << 20) | (a20_state << 20);
>      }
>  }
> +#endif
>  
>  void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
>  {



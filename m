Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082B5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEp96-00037t-8o; Fri, 31 Oct 2025 09:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEp8v-00034c-Qi
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEp8i-0005A6-15
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761917150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5A4vcIXrO0+DoGsgFR10gkswUrJvj7BksF5ooRCR8QA=;
 b=fMtMqByZcUqhVGOMtCd4qLSXwAAdnYsiI9XHxaP1lXLflOgybwEsMViQSxi4P2tSKDU1jE
 ylZOvRWKtTmQeWD7feU1tMqF2ES/ICxapMVgRdnBNZPYwyX3LKDbo0gajuWd+bfyr+qUlN
 5N24AQgfdk8BePvDUYW7jDfg+K6xuq4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-p0ICQ8Q6MoOSg0GL3vx2Vg-1; Fri, 31 Oct 2025 09:25:49 -0400
X-MC-Unique: p0ICQ8Q6MoOSg0GL3vx2Vg-1
X-Mimecast-MFC-AGG-ID: p0ICQ8Q6MoOSg0GL3vx2Vg_1761917148
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso7073305e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761917148; x=1762521948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5A4vcIXrO0+DoGsgFR10gkswUrJvj7BksF5ooRCR8QA=;
 b=P8f9qTREQQOqn0DQD7bpQWynTs4haXj8zYPKDfmsHSFlJkQo+hihlOJtAxqhg1rsZW
 r+vVoUZ8Bgv/vivqMzmeTKwSC3nwOO6gkdzM5tTppJ0Bu/pwibZ496JDL+63zuyC4ntI
 fPCLX2aWCG2rKjh/pQ04y9fpc9jI34Yde2/8JCu/NPR4gXo1+c1tEjiR5RynV7nskX20
 28VCQKC/JZdO6Hc8THmu9FYHnZEBxBjZn0k0ZsjJeizdvadjvYOr4R3E22ApEDXzvOjf
 MpWdO59uX1SrUrGjkYd5Xqm9SL5qwkoSk/NeReknLHc1R7MKNLH9dJ8h+kMgM9bc4/Ur
 7AQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzjGjGEKYGeu0PpFhh2WrPiC411PkVPHDm9WI1q9zJTgqKnb6q3+Nv34qceraWlAUkMGSFlVf9exh3@nongnu.org
X-Gm-Message-State: AOJu0YxsIQY3B4Yc2eGxxSDO7vmzRr1WbftrzMD9QC6TVN5QCLJ62GZK
 gDbwDmWIPy6GBxQop5w3k1FHRfEMej/2a2TWZ1iRL91aseO+ss8qijKq5KG+RVGRhafH8BIa8Iz
 Af0FVxBZmKxwOBEQfUlyC06gXqcnPbzt0UJA9ZDLDK1RW6CGaT3bP7Bwc
X-Gm-Gg: ASbGncuEPYFIqlerxyarLBOMH2am/HyjD0S9wpXRzIvfnw+O5dSNWt0ydL43M7KgGJk
 CrI6Had7tPlURI0GMzNzmS0mPn1xK8UQqUPZNUNvsLUj/v41xnMR3Fd1q27MfqfBg935ib1oI1g
 b2cBrttcHOgZd1SeuneS9e4/gptMH6SeQ3aBZk2RuT0/iP2XVcCupDY1CZE8yk9cJotmqDyQVx1
 xrcpaTAYJC/LwBGY00Zhy3VrFWCN5rNAKQa2vOqtQFKmDeS+n2qJcbA0ciQWKXNxD7i9UwGxHvV
 pt/ZjOeeNPBuMZsx9M0DZZ3Ej3SCOXu665JSulUrAIovikVkmG/HSxUrRuSrUlz8nw==
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id
 5b1f17b1804b1-477305a6db5mr38026035e9.8.1761917148392; 
 Fri, 31 Oct 2025 06:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE64A1nYxU+3C6WFnvizMo5GJ9zyOxs5/ZmTCKYp1O6Q4tIVv35LCWO0zuHlCSSEOOxgBluyA==
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id
 5b1f17b1804b1-477305a6db5mr38025705e9.8.1761917147913; 
 Fri, 31 Oct 2025 06:25:47 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728aa915asm91132635e9.16.2025.10.31.06.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:25:47 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:25:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH RESEND v2 2/3] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
Message-ID: <20251031142543.0c7d384f@fedora>
In-Reply-To: <20251007060810.258536-3-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-3-gshan@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  7 Oct 2025 16:08:09 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
> errors, injects SEA exception or aborts on errors. This function will
> be extended to support multiple ACPI GHES memory errors in the next
> path.
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/kvm.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 9a47ac9e3a..c5d5b3b16e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2429,12 +2429,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>      return ret;
>  }
>  
> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> +                                    uint64_t paddr)
> +{
> +    GArray *addresses = g_array_new(false, false, sizeof(paddr));
> +    int ret;
> +
> +    kvm_cpu_synchronize_state(c);
> +    g_array_append_vals(addresses, &paddr, 1);
> +    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
> +    if (ret) {
> +        goto error;

perhaps use &error_abort and use it right here instead of goto
or even more cleaner: pass  &error_abort as arg to acpi_ghes_memory_errors()
and drop not needed 'if's & return value

> +    }
> +
> +    kvm_inject_arm_sea(c);
> +
> +    g_array_free(addresses, true);
> +
> +    return;
> +error:
> +    error_report("failed to record the error");
> +    abort();
> +}
> +
>  void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
>      hwaddr paddr;
>      AcpiGhesState *ags;
> -    GArray *addresses;
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> @@ -2443,7 +2465,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> -            addresses = g_array_new(false, false, sizeof(paddr));
>              kvm_hwpoison_page_add(ram_addr);
>              /*
>               * If this is a BUS_MCEERR_AR, we know we have been called
> @@ -2456,19 +2477,10 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               * later from the main thread, so doing the injection of
>               * the error would be more complicated.
>               */
> -            g_array_append_vals(addresses, &paddr, 1);
>              if (code == BUS_MCEERR_AR) {
> -                kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                             addresses)) {
> -                    kvm_inject_arm_sea(c);
> -                } else {
> -                    error_report("failed to record the error");
> -                    abort();
> -                }
> +                push_ghes_memory_errors(c, ags, paddr);
>              }
>  
> -            g_array_free(addresses, true);
>              return;
>          }
>          if (code == BUS_MCEERR_AO) {



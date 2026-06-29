Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A786C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCh4-0008KH-JF; Mon, 29 Jun 2026 10:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weCh2-0008Jv-Ip
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weCgv-0004a0-8c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782742227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hxr0qwFhyr0guedTxOpnX9RnfhjYWP5gUpLhCe45JHk=;
 b=DZFPi6zFl6Wqd5wbk1FBer5uWnmr1WxXGwZ4s//vtLLSiNF9IFNUZzwobcyqbkeDc9+iII
 pndzavPEGW2GBMiH5fvIWZvKGSNqL4U1Qy75Y3Q4xT30NhEyDn/jKxf6RdaQ/VcU2c3iQ3
 +sgz77seth8dzSEIgoj63iAKoA9hjz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-vLRmNi77PdmEEAXoRhFo0w-1; Mon, 29 Jun 2026 10:10:25 -0400
X-MC-Unique: vLRmNi77PdmEEAXoRhFo0w-1
X-Mimecast-MFC-AGG-ID: vLRmNi77PdmEEAXoRhFo0w_1782742224
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4932f0fdcebso21880295e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782742224; x=1783347024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hxr0qwFhyr0guedTxOpnX9RnfhjYWP5gUpLhCe45JHk=;
 b=ZxrbVtdxEd86Q+KoTQTsl3k+d/B4E86v0WjNyHiPWuejetTu0Q/ZSqZ1Qg40doqXk8
 Sj0Z5t5zaGkeYEFMx/BNn1yLeADNymjPNtwD/f3r+eOqwzQ4lw5JHcv9OB7XWn1qyO3e
 hVKN13nCfTAX+1yN5aZMjVq5mXQQhoiX5H7b9kN7qLFhEwuIJTLr8chHZ7dpxVZiMSf5
 2ll8O0h+0O5EksnN1Sw5JcMNhcbD63Xm6O04FwdkeFLd30H+tt7lm1KVi5sRiWCF1EXg
 VeKQh3yhEnsxhHUrmc4i1d5Rc+2hAOnwfZsxU1BNlNCQHNt9IrNWYYTJLSUrRA8S1RaQ
 rrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742224; x=1783347024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hxr0qwFhyr0guedTxOpnX9RnfhjYWP5gUpLhCe45JHk=;
 b=B8SLGHubkOkr5B0NlO6j21pnAfHfVzrlvMDWMg+dwbeWdcIhEFdZ3WUIPcNQy9lY+j
 sSbnY/qUHjbWrcFpfRZvQjQ6PBegKyKxf2MJ02vji2T/z1NdYJ0fRkACCl4DVJ3xRp0z
 +Lqj4EUGmTdByCAOZJQ7PzVeMWbASRg6ehqOwsJj/GTOUJa6SoQEhCCC0QOl7d6/BJUD
 NnDBUs8zrTZcAgWZ0Z+3e5r9Q7Kr4qC2VxlrHFys/1MEZn0vKqUuZm3afltnoeXLxhgX
 xCIecSrqkLAcvDAV7F7aaxdQfvaTzWmDL0YREzJ+9ecg0OdTSFmCpA/aEa4MpCJ0hhIZ
 FKHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5yCri+AGSTGRpYLPJfsgGwM1vqlkVLRZplvRY73gupV9izwuMMXRNYDr+7bcDEb44GC5Q/IUZmBOY@nongnu.org
X-Gm-Message-State: AOJu0YybXz6KVccXbukaEnx1aoJ64+pRLxWCTpc7/Vcpoc1fM8WNvWYL
 IkjAXZATEXONyygRzPDPb3lwgggcZE6dhw1y3F4BDR5oGrFJ0LmaVK2zL/br9rfHgF+c7i26QPL
 wUfrTBFJSXt7g1rFY+Fm1vvIT1znn3m6Otj13zPyRSt+iRdSIQfWqSVXz
X-Gm-Gg: AfdE7ckhZ/Nt9pUV36FKqRKA8tYrBvZwDZX74FKoU3t3FL6pXlgMbgmgGz2Ek1nyK4t
 KEaCsFPjgoafs2VH0SxERnAHnI2ogaYquW2SkDqQKMJYubQQloS66GSC6DyjUVYtYQCellQBDcb
 jDugovC+wTp/Y62eKughPzJzpqWlTT+dCePvfX2X+OFkGZA78iWyA0TPn2tKU99mDLbfjy2WJlg
 EX4brngqV1TdhgILCx/grOvWZ8A0fjpx988MfQ1aVHxhmE0fLsLZcSWzNc++LM/Iom07ikNJQgp
 dhVFumR0zLSxE2m09O/8Srdv6v6Tbud6ZXhJjghucm7DZwKAnvsvh37bMqBkC9/WQUjZ5b6Z3Hx
 QHpOvUEICBWrqKCr91PBAuckyUV6xVGvUweF0jhLC7Tcc5ekztbUldA==
X-Received: by 2002:a05:600c:8b83:b0:493:b499:3ef2 with SMTP id
 5b1f17b1804b1-493b499407emr39319855e9.37.1782742224173; 
 Mon, 29 Jun 2026 07:10:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8b83:b0:493:b499:3ef2 with SMTP id
 5b1f17b1804b1-493b499407emr39319225e9.37.1782742223726; 
 Mon, 29 Jun 2026 07:10:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fc2ff9aaesm27764057f8f.26.2026.06.29.07.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 07:10:23 -0700 (PDT)
Message-ID: <31c9c54c-0e27-4a68-91a6-d94ff4d8586a@redhat.com>
Date: Mon, 29 Jun 2026 16:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] sbsa-gwdt: limit compare_value to INT64_MAX
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-18-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-18-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/24/26 12:28 PM, Igor Mammedov wrote:
> QEMU timer subsystem uses int64_t, so WCV values with bit 63 set
> overflow and cause the timer to fire immediately. The SBSA spec
> defines WCV as an unsigned 64-bit compare value, so such values
> are valid per spec and represent far-future deadlines (however
> unpractical).
> 
> Windows in GTDT mode writes WCV in two 32-bit halves while the
> watchdog is running:
> 
>  sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
>  sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
>  sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
>  sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
>  sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)
> 
> The intermediate WCVU write (0xffffffff) creates a WCV above
> INT64_MAX, which overflows QEMU's signed timer and fires
> immediately — triggering WS0 => WS1 => reboot before the final
> WCVU write lands.
> 
> Clamp WCV to INT64_MAX to avoid timer API overflow.
> 
> Note: Windows' GTDT watchdog usage is also fragile under
> virtualization. It programs a short WOR (~4 sec), enables WCS,
> and relies on a subsequent WCV write to push the deadline far
> into the future — never using WRR for explicit refresh. On bare
> metal the WCS=>WCV gap is negligible, but in a VM the vCPU can
> be preempted between MMIO accesses while the clock keeps
> ticking, potentially expiring the short WOR timeout before the
> WCV override lands.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/watchdog/sbsa_gwdt.c        | 2 ++
>  tests/qtest/bios-tables-test.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index fb67db9672..ff7adbcb0f 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -122,6 +122,8 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
>      }
>  
>      timeout = (uint64_t)s->wcvu << 32 | s->wcvl;
> +    /* clamp timeout to INT64_MAX to avoid timer overflow */
> +    timeout &= INT64_MAX;
>      timer_mod(s->timer, timeout);
>  }
>  
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 94fc95c8e1..370b0fd2e6 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2308,7 +2308,7 @@ static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
>          .scan_len = 128ULL * MiB,
>      };
>  
> -    test_acpi_one("-cpu cortex-a57 " "-device sbsa-gwdt", &data);
> +    test_acpi_one("-cpu cortex-a57 -device sbsa-gwdt", &data);
looks unrelated to this patch.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Besides


>      free_test_data(&data);
>  }
>  



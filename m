Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A11CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5AT-0007nN-C2; Thu, 04 Sep 2025 04:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu56Z-00008W-4o
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu56U-0006MH-48
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756973634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkcJo3I8OmlqqKYUwb5uJPZw7tJsahONSTnsQCylKp8=;
 b=KTOwl3XtNmIXmTDJ6AFZ5jJ6QQGrnAcPgqdZzocGfz6NzhohODjEyzycnNLznKMfwpS9r3
 PkPYWP0n5+mtVJM+l7kISvNtVkca0nEvB4au0Pwhin/wXdZjhzzk33LeiOBSXqlx/51vrJ
 QIOPQAeewIGynY5dQx4BW7oIyH3PV6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-VzLdRqSzNRWPsSDrUpeANw-1; Thu, 04 Sep 2025 04:13:52 -0400
X-MC-Unique: VzLdRqSzNRWPsSDrUpeANw-1
X-Mimecast-MFC-AGG-ID: VzLdRqSzNRWPsSDrUpeANw_1756973632
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b98de0e34so5862425e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973631; x=1757578431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkcJo3I8OmlqqKYUwb5uJPZw7tJsahONSTnsQCylKp8=;
 b=gYU/K0t04j6ow3EYWOxmuROylXSPGh/xYczy4CNlEAwte9XQYbWLSNd+vKPbexXm2i
 I9Gdr+499TMvng0bcdbNwYdBBYZL+OI/oJ7/ZahNl06fRsxhsp0LB7k7TPOlJWJL6fA3
 edHXuVggLMs/b0dvJnlGgPDlfFP3CcX80yoOPXBwnwM+jzg3ptOikZDxKpqkDrZ2JSt3
 crcUHwbJjhvSvAzc6zptM+6NuBmwbUHQ4CvqlfOituG//tItssiMOdwEKDxDq2d2stjw
 TOvoChCYvaPI9ROKoebBaTT/5tsqGUNTyGBH3y5+rW7KVnAGYfWuwg8iGBLDKc2YfDqe
 O9BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaXsil9FdF4mjyjHNsQPTxXdhFjzQOYqT4c/Twnyn2ibb9WWRtESj11ApqusWEeWmg3YVnyUh5gTNY@nongnu.org
X-Gm-Message-State: AOJu0Yyh0DOe9pHeBXFxKZo4EXjWECK6ihwAykhOc/WctvqPMwwIobEh
 BKTfpVsMubZwUI2uGXMusuPcLUZlNVQsGO5U0d1mrEOY3MUkKVI60SL2RlsTwbhEJbDH6z/TAjG
 g30bO4lj0DX2HD457uwA9lyd1NPTbrWTN3UvmuyLhD8RqtB6zcJ0MqZaO
X-Gm-Gg: ASbGncudQq/c5XkJUCF+e3LXzY2iVkTxG7Yydsi6CEdO3fXmw01ObiWh9FL/WCXGnt4
 vKlAsKxuF88JMQMV+UtfAYVOtwvXa5nZdnDdPntzwzxPtR5Y4fbIbjlBLiVcTY8WJqJCuEMv2AH
 JwBt2fa/87irosTbTL092J9HI74luXGOrjUIE/JfyPugyCSCZohNLO/2VWiA2+ozJwuwCqGxBW/
 iaUjDWTvFhhiTFNUmiz/+VZK3k65bTyVf4Jr7iuVAHZ7+gfO//XNN9ublH72tpwYLddvQ/yxlbi
 DvKspu8okW6pwsrDXXb+GPRH+Dtt6A==
X-Received: by 2002:a05:600c:3115:b0:45b:81b4:1917 with SMTP id
 5b1f17b1804b1-45b8555c359mr158242845e9.10.1756973631512; 
 Thu, 04 Sep 2025 01:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMPM5qyRd3L7iOr32s/BucpbBt7pFDjMDDF/EzV0fdn7Oh7zQ2WNvFJf+TxzwL8aXQJiwoGA==
X-Received: by 2002:a05:600c:3115:b0:45b:81b4:1917 with SMTP id
 5b1f17b1804b1-45b8555c359mr158242495e9.10.1756973631004; 
 Thu, 04 Sep 2025 01:13:51 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6dc1sm357473855e9.1.2025.09.04.01.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:13:50 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:13:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Xianglai Li <lixianglai@loongson.cn>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] hw/loongarch/virt: Register reset interface with
 CPU object
Message-ID: <20250904101347.0599daab@fedora>
In-Reply-To: <20250903023556.3082693-4-maobibo@loongson.cn>
References: <20250903023556.3082693-1-maobibo@loongson.cn>
 <20250903023556.3082693-4-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed,  3 Sep 2025 10:35:56 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> With cpu hotplug is implemented on LoongArch virt machine, reset
> interface with hot-added CPU should be registered. Otherwise there
> will be problem if system reboots after cpu is hot-added.
> 
> Now register reset interface with CPU object is realized and remove
> the reset interface with CPU object unrealizd.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/boot.c    | 13 -------------
>  target/loongarch/cpu.c |  4 ++++
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 5799b4c75c..a516415822 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -350,13 +350,6 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>      return kernel_entry;
>  }
>  
> -static void reset_load_elf(void *opaque)
> -{
> -    LoongArchCPU *cpu = opaque;
> -
> -    cpu_reset(CPU(cpu));
> -}
> -
>  static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
>                                     FWCfgState *fw_cfg)
>  {
> @@ -439,12 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>  void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>  {
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> -    int i;
> -
> -    /* register reset function */
> -    for (i = 0; i < ms->smp.cpus; i++) {
> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
> -    }
>  
>      info->kernel_filename = ms->kernel_filename;
>      info->kernel_cmdline = ms->kernel_cmdline;
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 3a7621c0ea..9edb8ebc4d 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -668,6 +668,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>  
>      qemu_init_vcpu(cs);
>      cpu_reset(cs);
> + #ifndef CONFIG_USER_ONLY
> +    qemu_register_resettable(OBJECT(dev));
> + #endif

I'd put this in virt_cpu_plug() as last step, which should work both for
cold and hotpluged cpus. And drop CONFIG_USER_ONLY while at it.

with that
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

PS:
the rest of the patches are very arch specific so I won't review them.

>  
>      lacc->parent_realize(dev, errp);
>  }
> @@ -678,6 +681,7 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
>  
>  #ifndef CONFIG_USER_ONLY
>      cpu_remove_sync(CPU(dev));
> +    qemu_unregister_resettable(OBJECT(dev));
>  #endif
>  
>      lacc->parent_unrealize(dev);



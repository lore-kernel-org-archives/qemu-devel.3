Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC12C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tawX5-0001aI-Il; Thu, 23 Jan 2025 07:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tawX3-0001Zk-UI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tawX1-00033M-3M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737636116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5FZv+8u+d2GtcDrre/mQ3Ye6vAjYVJKfIBRUFGXtx4=;
 b=YMi5TWHmYbpreA0hUy4AqHE3Y9qRMAS2sMdGD8mVENgPNUfDd+kwjA8C34xQS27VntExps
 3tZb0ph/WLg0Fb8b2IJm3iiAIQI7xGFq4zTwAAuXHBf2xEjZvtv3YcJq5rKSr4DYTLXwiC
 29rg7vki869BxvgEM+6LPmo7X4aHNQc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Jkh4gAVhOfKyJ9uE-gUVTg-1; Thu, 23 Jan 2025 07:41:52 -0500
X-MC-Unique: Jkh4gAVhOfKyJ9uE-gUVTg-1
X-Mimecast-MFC-AGG-ID: Jkh4gAVhOfKyJ9uE-gUVTg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43621907030so6152775e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 04:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737636111; x=1738240911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5FZv+8u+d2GtcDrre/mQ3Ye6vAjYVJKfIBRUFGXtx4=;
 b=mOa7IJ6x07y2PDO4ZvbldZCuxXDOuner5pPayG38GrwhzfrVKo8bEel1z/i7QRUYVj
 zyxr5e3OfI4NxfIq7ez5HgjxB70gJaBPEBnJG3ERRD1+cg2p8GLbzNY4aIsWa2paX60k
 8U2AJV/FHVb1qOLaGiq5I8aNSZqrFVfnKOv3HJ+/ubqnu63WNRa8hOyYkq/xnhGr1EZf
 XaxjGJhANpc94bfItANcDx35+DLw5HK5B1wLOLqs5SS3pwOdq/eVvrTu32vN03PxAjkB
 9xhilDmfMqJcdY7s68EojqkHz648DnyLoSe4l/9qdiSMLHhoQL/5RninvvkkyJBtem0C
 a0yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjQkNhjq/DNsmMa8odrEdnkOXLtXmPpoPaqWAkdQKtuPDkUr2Nao5owkWRz8q01mOh6p2kwak5WsRp@nongnu.org
X-Gm-Message-State: AOJu0YwkZRqjW6hD5UKjtS7xu8FQlyB1P4afmCVOFs0r+CeWIgypOt3q
 zqugdmhDUCiJWsL6b5INzfR6JNct0exeno/O3EdhDWlOaHLebpTepUeK05y6aJvlqclBROdEp09
 Uz53kQ6L+0mknMN1VcsEqFVqxDruqBSz+53KcN7ZnH66rW5jLRppR
X-Gm-Gg: ASbGncuA/EE5fybe5lqVQfgCoh6LWhMF0/qaU8mPejpNIoMon1esQDfuFicGuWwHlUn
 Pz9Jsde0l70BlH8mgLHpUrZFkUmQ60hveDbFJ6Au5kKa/AGv85xTEGZ0pzj5IwAeiwqJf1XHRj5
 sJ0LwNyxMeB9m/q1o4zQ0oPWLEwktTYjvORlgbwKibWpm0U8S4SLszsVK4O5cnAiXl0FVcANI5b
 ZRIwDFFlzb+QEzLYhKUwvhNwu6WFlu4YN0YcXVyT0cWn4VBHE36zXYbgtc25Qw11e332ZED8J+C
 79T7+Ea9tY0YSW1LH2knrJqLiqMOLquxk6XyHKTimg==
X-Received: by 2002:a05:600c:1987:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438913f2f4emr259295345e9.17.1737636110988; 
 Thu, 23 Jan 2025 04:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaf0J1FpGBG9DXD2cCzVrXAaT6T+N0ZijcOGKXj6jeyiABkDxsaVx5NBozYlDdObLnfmJtRw==
X-Received: by 2002:a05:600c:1987:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438913f2f4emr259294915e9.17.1737636110549; 
 Thu, 23 Jan 2025 04:41:50 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32151f1sm19447922f8f.14.2025.01.23.04.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 04:41:49 -0800 (PST)
Date: Thu, 23 Jan 2025 13:41:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, rick.p.edgecombe@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 40/60] hw/i386: add eoi_intercept_unsupported member
 to X86MachineState
Message-ID: <20250123134148.036d52b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241105062408.3533704-41-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-41-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  5 Nov 2024 01:23:48 -0500
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> Add a new bool member, eoi_intercept_unsupported, to X86MachineState
> with default value false. Set true for TDX VM.

I'd rename it to enable_eoi_intercept, by default set to true for evrything
and make TDX override this to false.
> 
> Inability to intercept eoi causes impossibility to emulate level
> triggered interrupt to be re-injected when level is still kept active.
> which affects interrupt controller emulation.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/x86.c         | 1 +
>  include/hw/i386/x86.h | 1 +
>  target/i386/kvm/tdx.c | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 01fc5e656272..82faeed24ff9 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -370,6 +370,7 @@ static void x86_machine_initfn(Object *obj)
>      x86ms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>      x86ms->bus_lock_ratelimit = 0;
>      x86ms->above_4g_mem_start = 4 * GiB;
> +    x86ms->eoi_intercept_unsupported = false;
>  }
>  
>  static void x86_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index d43cb3908e65..fd9a30391755 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -73,6 +73,7 @@ struct X86MachineState {
>      uint64_t above_4g_mem_start;
>  
>      /* CPU and apic information: */
> +    bool eoi_intercept_unsupported;
>      unsigned pci_irq_mask;
>      unsigned apic_id_limit;
>      uint16_t boot_cpus;
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 9ab4e911f78a..9dcb77e011bd 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -388,6 +388,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          return -EOPNOTSUPP;
>      }
>  
> +    x86ms->eoi_intercept_unsupported = true;

I don't particulary like accel go to its parent (machine) object and override things there
and that being buried deep inside.

How do you start TDX guest?
Is there a machine property or something like it to enable TDX?

> +
>      /*
>       * Set kvm_readonly_mem_allowed to false, because TDX only supports readonly
>       * memory for shared memory but not for private memory. Besides, whether a



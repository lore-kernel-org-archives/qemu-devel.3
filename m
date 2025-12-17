Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82329D65C49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVs5P-0007IQ-OA; Wed, 17 Dec 2025 09:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVs54-000787-GV
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vVs51-0006Mt-5r
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765980038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbthGM/G+GWpXtODayU7RTgZ2Jepun9Dt1c05gz+DX8=;
 b=ZCVbdsAC9xYCsbbQPqS7WhbFgM1fNZN7Eo7G0mBd7gjq7CEhK8HBZH5craN364k0eX6MOi
 8ADd44Shs9E+4kmC+16wGAhZLIDlJef55B4ChqwVTUyGXxZpwcsLlPU8I/+CBNPVZFG/IE
 mdKKV9pDp1czy0cpfxsQMv6NDFAbMfk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-wNg4_o-oOjCj8rex7lhvAA-1; Wed, 17 Dec 2025 09:00:36 -0500
X-MC-Unique: wNg4_o-oOjCj8rex7lhvAA-1
X-Mimecast-MFC-AGG-ID: wNg4_o-oOjCj8rex7lhvAA_1765980035
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563e531cso39210125e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765980035; x=1766584835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbthGM/G+GWpXtODayU7RTgZ2Jepun9Dt1c05gz+DX8=;
 b=oVoiIcJIQd0mDaFiqT5VFezy44yi74HZBupwPS7Xju9sryP8KL1Y+H3ylx+xgAq68c
 DiXvNre5M9oxSbEkaYsZGH67BMZGKPQFoDGS7ieLsjyRWsxdBVLEZPzn6gliNPKPS2kl
 8Y66giH2QSfbEMEgqwG8XAPS4l6rDawuhubkniuA+8ua6H24oec+4hKCmU4hmLZkzQpQ
 lDIQrv005q1LBtX9o44usJv7lz7+tsfqCE29MN87gFiuw7brNpRtK5IFWozjCCIkO+u5
 uhS19te9h/aj8X0WL/1ex/XbeXOklnJd5vNCEoWce1full3sIOuhMbJP4cp1mp6LQGh8
 Y44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765980035; x=1766584835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbthGM/G+GWpXtODayU7RTgZ2Jepun9Dt1c05gz+DX8=;
 b=JoXMnVLOpTkzpP6eYtg2dE3xkj3AWdT0eOsvVFAHLatHJoZn9rxs4e3+013LNJAwH4
 9iNMSJuJpfihhYBG8bbKgsQBkBzDbVQ3keSPraj27agIEt3ngak6iKgg8Ohg0h21uzsg
 sMUXb2NT/zcfBabEniUSdaWQcWv/SYzm0NJAza/cIKpu7D1bXmFSuw5eSt1eToCuWy2I
 Zk1slaKuo1oV4T4mcCnO5EgUCI04VjKjP3C9eTUYMziv7VXpHIJ4Ul6X4L9Zb+Tcro3p
 sITXgJrIyU591EAIH/dnpCQCcmJffzUY91ZzDU2hGJuohvfP/OqPUapqChTRWBTUzfWY
 sIAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEfELD32b0bp7dYq1P5yzmTpzouA2FoDM9nlR1Yb/6YRyHuevHvXiXzDJOW1T2Dk8rUll/2bCdRG/L@nongnu.org
X-Gm-Message-State: AOJu0YydiHH0J971ZtG/6bgaeeJ8QrXWA1JLWLBPigs0S9p638Fw4oYO
 wAKR5Rg6oWH246hmJXJo4O9xMOnHaH23IypUbPSKISpeFAydz6yw+YhK412Fl0UMkypry2YXq86
 aNCX3vPWC7uMxf6cKvBp7DOnM8OMwvNhevq+7CgBoHcHArxMbrBK3bVQB
X-Gm-Gg: AY/fxX5QLfctRRs+nsDyyu8aZpvemFWBuKaBN42llm47mjlBCC3+ceItcLwYRaKIANw
 Xi/fEyrTooknCOl1w8NHGFEa8wNOa3PLmLEuomIQcNZO8d0tmoAUQnqBxvWnB1ZJgUcklv1TWZE
 pF6QKuPWN/yof+BHI6TaXgtG8ioJeUlGXZRf8vexth77yTkByIq9MowMXymAGqBmJODfghVLxsB
 L8NU2nu95CxQ7rUUolA+lQkFVkdR0StBHXyzAz0maChfIYarxx52OIloaua/43SQL47VhfcaL4Z
 5rCk/Roop2Gm4sXFtiOOgMqC3QKfP2cjXVSOi6m3SCLGJ33gVljS8enoKu2GbQBkkqtmnA==
X-Received: by 2002:a05:600c:870b:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-47a970ee01fmr121266625e9.23.1765980035302; 
 Wed, 17 Dec 2025 06:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF3Fr/Zcas6umUDcUr9uZT23jIj6/PQ2ws/ggCzapTqhVg7JQ7VBdYoNAD+a6a+0T+RRnEZw==
X-Received: by 2002:a05:600c:870b:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-47a970ee01fmr121266215e9.23.1765980034769; 
 Wed, 17 Dec 2025 06:00:34 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd932a3e5sm30087275e9.0.2025.12.17.06.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 06:00:34 -0800 (PST)
Date: Wed, 17 Dec 2025 15:00:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Richard
 Henderson <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>, Amit Shah
 <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Yanan Wang
 <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Huacai
 Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>, Jiri Denemark
 <jdenemar@redhat.com>
Subject: Re: [PATCH v5 06/28] docs/specs/acpi_cpu_hotplug: Remove legacy cpu
 hotplug descriptions
Message-ID: <20251217150029.3a3bc19d@imammedo>
In-Reply-To: <20251202162835.3227894-7-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-7-zhao1.liu@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Wed,  3 Dec 2025 00:28:13 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Legacy cpu hotplug has been removed totally and machines start with
> modern cpu hotplug interface directly.
> 
> Therefore, update the documentation to describe current QEMU cpu hotplug
> logic.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Changes since v4:
>  * New patch.
> ---
>  docs/specs/acpi_cpu_hotplug.rst | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.rst b/docs/specs/acpi_cpu_hotplug.rst
> index 351057c96761..f49678100044 100644
> --- a/docs/specs/acpi_cpu_hotplug.rst
> +++ b/docs/specs/acpi_cpu_hotplug.rst
> @@ -8,22 +8,6 @@ ACPI BIOS GPE.2 handler is dedicated for notifying OS about CPU hot-add
>  and hot-remove events.
>  
>  
> -Legacy ACPI CPU hotplug interface registers
> --------------------------------------------
> -
> -CPU present bitmap for:
> -
> -- ICH9-LPC (IO port 0x0cd8-0xcf7, 1-byte access)
> -- PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
> -- One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
> -- The first DWORD in bitmap is used in write mode to switch from legacy
> -  to modern CPU hotplug interface, write 0 into it to do switch.
> -
> -QEMU sets corresponding CPU bit on hot-add event and issues SCI
> -with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
> -to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
> -
> -
>  Modern ACPI CPU hotplug interface registers
>  -------------------------------------------
>  
> @@ -189,20 +173,14 @@ Typical usecases
>  (x86) Detecting and enabling modern CPU hotplug interface
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> -QEMU starts with legacy CPU hotplug interface enabled. Detecting and
> -switching to modern interface is based on the 2 legacy CPU hotplug features:
> -
> -#. Writes into CPU bitmap are ignored.
> -#. CPU bitmap always has bit #0 set, corresponding to boot CPU.
> -
> -Use following steps to detect and enable modern CPU hotplug interface:
> +QEMU starts with modern CPU hotplug interface enabled. Use following steps to
> +detect modern CPU hotplug interface:
>  
> -#. Store 0x0 to the 'CPU selector' register, attempting to switch to modern mode
>  #. Store 0x0 to the 'CPU selector' register, to ensure valid selector value
>  #. Store 0x0 to the 'Command field' register
>  #. Read the 'Command data 2' register.
>     If read value is 0x0, the modern interface is enabled.
> -   Otherwise legacy or no CPU hotplug interface available
> +   Otherwise no CPU hotplug interface available
>  
>  Get a cpu with pending event
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^



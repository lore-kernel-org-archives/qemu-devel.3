Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE56FD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ07w-0003xS-53; Mon, 01 Dec 2025 04:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ07s-0003wj-Rk
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:23:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ07p-0004WO-Lv
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764580993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPHGzFu7m+cyDWsE33J604APZPfPlxebXaHZJGvmWbw=;
 b=XvcX7JwlhRq79GCKzwdbmWKH3Fg0ipxWZaCFbBxGXBDyt4CjP6zn6dJkLXyi8k0nslQ2nH
 28NYZ4SQkH1+/Dlh4ms7SLIS5kFeRY5qjR9MtvnlJhvSGf4tOeDPtOCCd/epUJRivWeS86
 l0UjTjvbApIgpH5GtIPc+yjIyQjLljc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277--A-R4lxiP6G86gVsbAlbKg-1; Mon, 01 Dec 2025 04:23:11 -0500
X-MC-Unique: -A-R4lxiP6G86gVsbAlbKg-1
X-Mimecast-MFC-AGG-ID: -A-R4lxiP6G86gVsbAlbKg_1764580990
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so2072601f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 01:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764580990; x=1765185790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPHGzFu7m+cyDWsE33J604APZPfPlxebXaHZJGvmWbw=;
 b=aidlZ0UBzHUnyv2Z1ab0yYAy8PHtgXzbzsmfOXURnOD8DquDvgEnd5wNpZuE3h0bCg
 EDDRkCDobVlgpWCCGds/u+LjdUPoFsOHxBksRBtWaBG7nDdmScNTjRrOS6pwYR5jB9mt
 31q8NnjNaqAdcTBbUnllNjJf4cOASoK5dkSba8BWq8nJDkwCVepmryCSbzsN6ZZILZJ/
 TQDhDLrUzoowLUoKSiW7lXhA7dV5X8Cwmkd1xAc5q5OpMntUOV8cMPwdmCk2nSj6EiyN
 cnb7Nv6AOtVQPjn+VTp98PC+/s1Vl5eO7NjIoSNRCr4AGNvhD/C1D/1qWmvidAQWqhsF
 q6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764580990; x=1765185790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cPHGzFu7m+cyDWsE33J604APZPfPlxebXaHZJGvmWbw=;
 b=juABCkjtztNMHEhARYHiywvMftdoTscIeKYbRLp43AvjkhpWmPMk1QylcjQwmGVqT1
 JJwWXyDrNPZCSf8e1IfhlS3yl7Cz2v0JFs6wG02cozhQuO9c6soWj8e8mCesLABenOng
 RgHp36vkg5kvCD9OO0IA4z0A/5wktfqpIckFia4nsqWKrtKJBpLSIM2JTZcYiE3DadK8
 J/t0MWEQ+u57McKpjlmejtKLZirI+yLGIE+/Ar4XfZwRPC/NeQ4mYL+YxuhDRlIe7CSU
 dQ5DAVfBx7KWiXmTONIiy1ucdRAHSXW/2DNCbwtAUOkYXceusbXHMYXD9aA8qnfh4jcg
 raUw==
X-Gm-Message-State: AOJu0Yx88aSJAOzbxT3e0iIvOVkOZ5js8mDChw966fcqPcff719txu5f
 lLOB8vZlA5BsFVdqjnYDsEWtA5Wkf7dhOu+B1wLJs2lJKFiEqw7OqBHodf15ZBpE8E+Xhr57IuZ
 wBRTCKejRWQM6hNJWUmVxyjcpDrZIj6Lou+4G0irXvDTSlJ1A5cC6lgyw
X-Gm-Gg: ASbGncsmPFaKIJ/FGBQ4yPdCvJ/FO8p60CApLULwDG+cZ0bSrbn/hxJZ5oONyAJ0Pur
 l106fzdpGsF9y68dzL5XHlxvb2VoNPoV71aSLqTkjlJLafx6COgxupSLWuoxtfyENR/ekEyrvk5
 3pXKDTBDU1r5M1lQFT8vOzOWByDW2qls7uje0jaKRztif84hzjyPrZlryuPszVwxprzLzBAyyhv
 bsYaQ0l0SRpc8rI09jljNopepOlRlJzfs+O3dc74ks1gThxhZZRRZ40LaER5YJUHrvpVAIJHbN9
 gSM63orXDWhjZ/+yu3evc/EAwlYFxGjTufx5z85Zc1MAOgj3JL3xIDOOxx5plhyfEk6rbA==
X-Received: by 2002:a5d:5f44:0:b0:42c:a4e7:3975 with SMTP id
 ffacd0b85a97d-42cc1cf3be2mr38956529f8f.30.1764580990451; 
 Mon, 01 Dec 2025 01:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPofmDjU/Uwzz35OA/oVYA9bmDRbanSyb4n5MtZqq1p3HICpPUdg4UBxeGFGh2ikbsbNZYQA==
X-Received: by 2002:a5d:5f44:0:b0:42c:a4e7:3975 with SMTP id
 ffacd0b85a97d-42cc1cf3be2mr38956486f8f.30.1764580989974; 
 Mon, 01 Dec 2025 01:23:09 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c304csm24879703f8f.8.2025.12.01.01.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 01:23:09 -0800 (PST)
Date: Mon, 1 Dec 2025 10:23:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
Message-ID: <20251201102308.5012f5e8@imammedo>
In-Reply-To: <aScevCMDynm1dtIo@intel.com>
References: <20250508133550.81391-3-philmd@linaro.org>
 <20251031142825.179239-1-imammedo@redhat.com>
 <aScevCMDynm1dtIo@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Wed, 26 Nov 2025 23:37:32 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Igor,
> 
> I find after removing legacy cpu hotplug totally, it seems necessary to
> update docs/specs/acpi_cpu_hotplug.rst as well, since then QEMU doesn't
> have legacy cpu hotplug. Do you agree?
> 
> I also attached my update for that doc. If this change is fine for you,
> I will squash that doc change into another patch that removes
> cpu_hotplug.[h|c] - I split your this patch into several parts
> (following you another previous suggestion [*] to make review easier).
> :)

sure thing, whatever makes it easier to read/review

> 
> [*]: https://lore.kernel.org/qemu-devel/20250509171847.0b505c96@imammedo.users.ipa.redhat.com/
> 
> Thanks,
> Zhao
> ---
> From ff3da76cf7de097c42bdaf64850dc4df65b4bf4a Mon Sep 17 00:00:00 2001
> From: Zhao Liu <zhao1.liu@intel.com>
> Date: Wed, 26 Nov 2025 23:06:09 +0800
> Subject: [PATCH] docs/specs/acpi_cpu_hotplug.rst: remove legacy cpu hotplug
>  descriptions
> 
> Legacy cpu hotplug has been removed totally and machines start with
> modern cpu hotplug interface directly.
> 
> Therefore, update the documentation to describe current QEMU cpu hotplug
> logic.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

LGTM

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
> --
> 2.34.1
> 



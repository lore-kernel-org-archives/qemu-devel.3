Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB31E7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFV-0001nb-L8; Thu, 19 Dec 2024 11:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOICB-0007Oa-1P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:12:12 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOIC9-0007zv-Ae
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:12:10 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso736071b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734621128; x=1735225928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWG7hzdDhJuUD9skphyQzgnUhGgyN9QVvereQw940Jk=;
 b=BZo0lxjd0PCH4AiquIGsTDq/rpsX8EFoEI7d+VrrqCFYe/UxX5mro7Lrma2+pFCRJy
 /T7R+TkNkQavADZ9oTiV6iIOA7O4w2l4DSv2UCjJP1J6jnrVr7hvUHYE/O14DtcWvygk
 dyg99tnJicRp2fgo8x1xAMtJOiTF7d5o3Y/y7lTaAPAQZQbcGu7ZNXKYvOEaSWTRLkUs
 6DcfWYp5mfoVMwgtbsi85M8Ntf/SSY5NlIVVp2XDI6wV4AGJowjh2iJ9155pVwkEk0Aj
 KLMq6E2d/8JHZGWPQE6vyoVZ17qifkwwt/I9XlwQU3PYzJFDgDR0r52rdMRs2WBb057V
 io4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621128; x=1735225928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWG7hzdDhJuUD9skphyQzgnUhGgyN9QVvereQw940Jk=;
 b=n3E9wnW5srJANFgfqHLW33TGbdW7C09xXU82EWYJLIYOfH65bbVEvUx1WJwpgWJ1qZ
 MuXs3cYnPDOz1rM7NHmsNwn+saR4wlEBgZ+uFpLVq882gW82+rSEYqLS/AFR5UTVw87G
 xEeHfRYuoVeDEkEaVPQZtU5q4DNNNeLpcr8O9w8QjXKfK29INxHGy7+2Om5y+KpepX9/
 NWTvLGVJuiMQCxuLBVIa0NzfYkSC2zi3L7LEuAZ8S754oEkJwDRGzf/8/WlRUX9yNmPl
 LUgmUbg1TTYJItPNNPMJLEgotSm0fWrwrEqhXzYZ+gqRX72rJQT1rDwaMw1EwJBW4Q9D
 W+rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2x/V7Cwuu4NdhBAiDn8oBhhBqGKKhYwJGKwUXUvR1zAd9Ogtpw3UknAXkTUZuk0qVTOJ7ZIqBZoLl@nongnu.org
X-Gm-Message-State: AOJu0Yxd+l/n83hsgqTg/YY8x7ez6JcdzBD2owIFp9u7i5j1/AWk+3b3
 Q3BSZhOYQDmdgDegp3/293ooXdaAuGNPsGq6THWb8ZIbnaKKT9P0YR2FRXTrQ1M=
X-Gm-Gg: ASbGncuMsn52QyflnzfJg+iZrqwxV6W+KbIzTSXai11dMVyoged9Nx3ThF30R2eQ6QM
 /TBJpQPyJQvzvt9s/ReqWFBx5Abs6Hx8ZytpPSUjK6yXUvN2lYrQkataaZoZGtMi8nSftw2kYkf
 NVzkUtuI6RWum3xL3PWNYYlEaVBmFQzHWoIqRP2NKO0XIF+VnSpQPgDmOqFlllZC2MG2fjq6D8y
 h4iGQkrRoLCNjmPz04jHyuXeTrvwx8ErOoRrvVjEmvM4Pqg+GYQcHFm6wHQEuzrI86WfQ==
X-Google-Smtp-Source: AGHT+IFMRlt2+D2V1plH3J9XioUYtfYIMqAMXzcVTcDaccFXIAbWR7MrqmMwc8YP7x9PIi06AiiwMA==
X-Received: by 2002:a05:6a20:1593:b0:1e0:da90:5f1f with SMTP id
 adf61e73a8af0-1e5c762fabamr5796664637.16.1734621127710; 
 Thu, 19 Dec 2024 07:12:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.151.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad816305sm1403954b3a.31.2024.12.19.07.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 07:12:07 -0800 (PST)
Message-ID: <ec22c2bf-15d0-4006-9647-a63d71655042@linaro.org>
Date: Thu, 19 Dec 2024 07:12:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] Rust, qdev, target/i386 changes for 2024-12-19
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241219083228.363430-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/19/24 00:31, Paolo Bonzini wrote:
> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
> 
>    Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 9f832641fa069a88eb41008694cfa5b62d29bc3a:
> 
>    rust: pl011: simplify handling of the FIFO enabled bit in LCR (2024-12-18 17:52:36 +0100)
> 
> ----------------------------------------------------------------
> * qdev: second part of Property cleanups
> * rust: second part of QOM rework
> * rust: callbacks wrapper
> * rust: pl011 bugfixes
> * kvm: cleanup errors in kvm_convert_memory()
> 
> ----------------------------------------------------------------
> Maciej S. Szmigiero (1):
>        target/i386: Reset TSCs of parked vCPUs too on VM reset
> 
> Paolo Bonzini (16):
>        rust: qom: put class_init together from multiple ClassInitImpl<>
>        rust: qom: add possibility of overriding unparent
>        rust: rename qemu-api modules to follow C code a bit more
>        rust: re-export C types from qemu-api submodules
>        rust: tests: allow writing more than one test
>        rust: qom: add casting functionality
>        rust: qom: add initial subset of methods on Object
>        rust: qemu-api: add a module to wrap functions and zero-sized closures
>        kvm: consistently return 0/-errno from kvm_convert_memory
>        rust: pl011: fix declaration of LineControl bits
>        rust: pl011: match break logic of C version
>        rust: pl011: always use reset() method on registers
>        rust: pl011: fix break errors and definition of Data struct
>        rust: pl011: extend registers to 32 bits
>        rust: pl011: fix migration stream
>        rust: pl011: simplify handling of the FIFO enabled bit in LCR
> 
> Richard Henderson (24):
>        migration: Constify migration_properties
>        hw/ide: Constify sysbus_ahci_properties
>        target/ppc: Remove empty property list
>        target/s390x: Use s390x_cpu_properties for system mode only
>        hw/pci-host/astro: Remove empty Property list
>        hw/ppc: Only register spapr_nvdimm_properties if CONFIG_LIBPMEM
>        hw/tricore: Remove empty Property lists
>        hw/s390x: Remove empty Property lists
>        hw/xen: Remove empty Property lists
>        hw/sparc: Remove empty Property lists
>        hw/virtio: Remove empty Property lists
>        include/hw/qdev-core: Detect most empty Property lists at compile time
>        hw/core: Introduce device_class_set_props_n
>        migration: Use device_class_set_props_n
>        hw/scsi/megasas: Use device_class_set_props_n
>        hw/arm/armsse: Use device_class_set_props_n
>        rust/qemu-api: Use device_class_set_props_n
>        hw/core: Replace device_class_set_props with a macro
>        target/riscv: Do not abuse DEFINE_PROP_END_OF_LIST
>        include/hw/qdev-properties: Remove DEFINE_PROP_END_OF_LIST
>        include/hw/qdev-properties: Shrink struct Property
>        hw/core/qdev-properties: Constify Property argument to object_field_prop_ptr
>        hw/core/qdev-properties: Constify Property argument to PropertyInfo.print
>        Constify all opaque Property pointers

I posted a v2 of this, and cc'd you.  There are, at minimum, two bisection errors in v1.


r~


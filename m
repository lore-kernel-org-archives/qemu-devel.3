Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1FECAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyV83-0008N5-LD; Tue, 16 Sep 2025 08:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyV7n-0007oR-8P
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:49:36 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyV7d-00033A-O4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:49:34 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d6083cc69so51111697b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758026964; x=1758631764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6irUkdVWbPW4o++8x4RerCm+gntlLcvww6kpAKS0emI=;
 b=myB8W63sLuIiPLz+7ZBPu3zPx5f2qHUZhoDF3jCok/oK4b2Qyj7AKICUOVo5+3uPGg
 x+darArXWbRULUttMvnxtbIpGHj+i0q6FIQR5sQM7x0lu4QozXYteaogZSghm3BX2KOY
 BkU/bqqF79g4gTk+/VDe55M5MeIMGOiUu9eIVLlo7kd7At896MryGgkqXrcnTZJNhuA4
 xivKaH4jtYHmGAzi7IO8pxKeCa5XqtnCtr4m+X3RoqTLqDi522AdFnCDXRoOtJqD68Qr
 YST1SFEUzrtoLB8CSOgtyrCaLLHRRfG+BR3mYLV9fquWXCpsKmd7roVttOMjEk3i5ROJ
 FMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758026964; x=1758631764;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6irUkdVWbPW4o++8x4RerCm+gntlLcvww6kpAKS0emI=;
 b=YoZEh8GF1f1t3oSGGMcgzVSNV9eJ287lzEf3Nmtn7JTf1SRdI2gcDBWPb1/dg6NjkM
 9+E/0ibei0b7XE/fkrrFBiQhNM7ox2V1i7r03ksJewO1G5ts3LynAhGGsGeW4kEYnCOf
 fRx3Ea5dp4sJ6/L+fcan+ANScc9a7EupOPciPLHGO9uZtmaLl6lKISyiDLlgCMvHdZBF
 8Jjm8+A5+OEaYUnPYRKaRJtqV8987vCaIjpdPdYJGJUnXkTgPSvFoeKNZU8Zfy7sW4Jr
 YW3gXP+J1WYlI5Hj5aLIfll4YKV3zH3Ycmo/09B3ZNNHnkcoT794UcToP2Qzsiy578lA
 B+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9YVB2Cwy4/5ZwjCgc7KSXndUSRGUc9QRj/W8xrUGEVoaKYwps36mS+b9bC/2vE53r8c2aK2ZLDzBG@nongnu.org
X-Gm-Message-State: AOJu0YyPl19Cc3VJrzct6tsZ+4Bzc2tSHL40W2a970uVAVM6F2UCcLN2
 SY7dZ2w+sfDbNYLugrnQXW+Xl/zvukCT6vxgrt11JXQ2+tIxXbErcZAKBjXzPNwygEE=
X-Gm-Gg: ASbGnctQa+exvjPS0RwTyP7f5kRTLZ6PwQ8wdM/6RSz5SPejtx0aVaxdasyDjkmDVxm
 EHOE1ibysoPVSe8FF0+QQl7cR3e6oQAmHJa57j02DLbdUV2AX51sGcAMzfMyswZyCk/y6cR/HkE
 6YCYmEVnxR5+LuRV2y448m2Sktk8T0syT9Z8ewBNP/vycJzVM6pC72WcjbCfJOIpbuCPxMXCE7H
 IJX1prTWHxuldVjWM4B2PPK2mdhFC6/E0RybVBkNOqOqQ0fM06vUWqWNUgPnX2Z+WLuEdB7hy4Y
 LUolH+G/JOyRtTjR7/4oqpN+XuB2th6b6Jaj1sESotJ8SGXOpsBFTB16CNwG06teRt277rFHYHZ
 25wmbTQ97YYyKx3k3ANWNr3xirVvLjewZYTgF5avhThZcb36M
X-Google-Smtp-Source: AGHT+IFCBv4jJzCF9feEbWKQ/VRwlgD4Gu9QnH4zXySIGPqhoMTPEd9ZPNL4Smioow+yL0oUU8dkfQ==
X-Received: by 2002:a05:690c:e0d:b0:71f:b944:100e with SMTP id
 00721157ae682-73065cb1982mr151037097b3.53.1758026963953; 
 Tue, 16 Sep 2025 05:49:23 -0700 (PDT)
Received: from [192.168.68.110] ([179.225.245.173])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6247cbed5bdsm5063880d50.1.2025.09.16.05.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 05:49:23 -0700 (PDT)
Message-ID: <1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com>
Date: Tue, 16 Sep 2025 09:49:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] target/riscv: Implement SMSDID and SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi!

On 9/9/25 10:25 AM, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Domain Access Protection) extension. It only includes two sub-extensions:
> SMSDID and SMMPT.
> 
> This patch set implements the v0.3.4 version of Smmpt
> (https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
> 
> As there are newer SMMPT specification versions, this patch set is
> not intend for merging.

I'm not sure I understood. Do you mean this patch set isn't supposed to be
merged even after review?


Daniel

> 
> The implementation is broken down into a series of logical steps:
> 
> Patch 1 adds the fundamental definitions for the Smmpt extension,
> including
> new CSRs (mmpt, msdcfg), their bit-field layouts, and the corresponding
> CPU
> configuration flags (ext_smmpt, ext_smsdid).
> 
> Patch 2 introduces the core logic for Memory Protection Table (MPT)
> lookups.
> It includes a new file, riscv_smmpt.c, which implements the multi-level
> table walk to determine permissions for a given physical address.
> 
> Patch 3 integrates the MPT permission checks into the main MMU and TLB
> handling pathways. This ensures that both page table walks and final
> data accesses are subject to Smmpt protection rules.
> 
> Patch 4 adds support for the new fence instructions defined by the Smmpt
> extension, specifically `mfence.spa` and `minval.spa`.
> 
> Patch 5 enables smmpt and smsdia extendion.
> 
> With this series, QEMU can now model systems that utilize the Smmpt
> extension for enhanced memory security.
> 
> LIU Zhiwei (5):
>    target/riscv: Add basic definitions and CSRs for SMMPT
>    target/riscv: Implement core SMMPT lookup logic
>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>    target/riscv: Implement SMMPT fence instructions
>    target/riscv: Enable SMMPT extension
> 
>   target/riscv/cpu.c                            |   4 +
>   target/riscv/cpu.h                            |   9 +-
>   target/riscv/cpu_bits.h                       |  27 ++
>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>   target/riscv/cpu_helper.c                     |  81 +++++-
>   target/riscv/csr.c                            |  83 ++++++
>   target/riscv/insn32.decode                    |   2 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>   target/riscv/meson.build                      |   1 +
>   target/riscv/pmp.h                            |   3 +
>   target/riscv/riscv_smmpt.c                    | 273 ++++++++++++++++++
>   target/riscv/riscv_smmpt.h                    |  38 +++
>   12 files changed, 548 insertions(+), 5 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>   create mode 100644 target/riscv/riscv_smmpt.h
> 



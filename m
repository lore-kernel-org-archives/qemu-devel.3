Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CE1D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQgsA-0002QX-Gu; Wed, 03 Dec 2025 02:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgrb-0002G6-P0
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:01:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgrY-0001mX-Qo
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:01:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so45701945e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 23:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764745277; x=1765350077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIPPQJIkimIrAN/OqDJfIr0BzioIBa9UlO2MKnJW2u0=;
 b=CcRYshNFqnZvFQaChXK27K6LmswI8VnjgdqfXL+t3EeOD8wfKF+W4ux/R81sR5qwLL
 pKK9SmkZ+NfURYukLs5I0uzLdNQZYFN+v3Y7Wq1KGrdHZulrXEZib7NiGugXDBm+SBw2
 nuUJZe5XTrYcpU8CTTlKorh2p7VbBOpAj0Tj3Ohb1LbQVRvSNJ6/EkcPf2Sl+Zb2iR1I
 w5J2lvItY7Gl5cQB/e90C8yBuu9fJ6HEJX59bGNpoPDpGtzlOBWduwm2x98JXfgzmGZD
 VZQMzGpbkoxgeMbHpyx/WRu9XoOT9Gr1BmdwOZyZlkk/0RQZTwiJC42Fo60HBSh9PWwL
 0azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764745277; x=1765350077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIPPQJIkimIrAN/OqDJfIr0BzioIBa9UlO2MKnJW2u0=;
 b=V1slioeiUI0ox4+XEmC+OhwmUbZ9NL/KhX//ZmjVmHR33bO8ayqTGWVjFtzhevLBba
 L9kQGA3cfRjs4LPq6mJGUD9x1MYHalY1SVTTpKLhXtCAg/W0jtN07ZQyMKlS3ny+ATS5
 yBdSWHz/pMlEqYar7GprJHQsz8XDdYMa9O05SP9PtkShBC2+X+HhxjvIaxZ1fCMzlsF8
 T1MYRHQM11u/T0WkrmWTwT8C3Tzjy9WxSiq6mmR5aMqLGfqvsQgpx2oOIGTUcClwMNJt
 DxjVa02/sp34ip+36lQ4fawbqO9EAWx1GBwm31lqeQEtc/7iMweT34vG3ir4LzNu7RA3
 fRvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdEp5xbN6MkI0GDlLwEtmAHvXTSBNSQGA6oGwClek6fDvuHprwimmKscwucrAE2thwjM6oPx0IPbjf@nongnu.org
X-Gm-Message-State: AOJu0Yw8yBXnDql9r56c8egXv9pzSn1lSrYT8ny6W9zywHa9/YzAcERM
 sMty9BFhSJDD3Dppu96uLpHosNrb7kSGIl6hBK6dJJTvBPLGbdwZtLxQ+k1d5GNVAzM=
X-Gm-Gg: ASbGncvAZyrFBB833kaPLOR4KBRDyPPCKX82uKC60OZfTSWcmCNVP4eRzqde4BFI9Zz
 hsC0iA6+to+tyV99R9PxOcCDVj2ueLCAhQXS/sv2Qsv+n7Nc5xdj0cp80X+BQYPF0YU0Sd/zf2K
 rECBfXS7hxLpsRLjIJfILgUM6IlykzwPV/ALcOBrdze7BDhqBuavgl07alxLRWoc658787lA3MH
 fMrdG4DG6In4kKi5h0iY4s8nrT+Hkag63CrqcjfyWF2isFacQkR/eDKjAGJZVjZrgML16TTicL9
 RW9o5DHnKb/hKcAzsSiqxxBJ0SXtcrFDjb33GqSl97KK4RHg+x3QomY9vNLgNuhu9rOGp55+RTf
 CWLgeswM9JyxX2gnxadPNq404YqG3ujp3yUcyfAe9R7axnjT+BB9bNQ0h0hIv0KkUDi9s96Tbds
 GS7iZdar1BGvNrZpU969XOFAVUM5kH/8bvd0Lf/KWyB2QSGP/BtknaKA==
X-Google-Smtp-Source: AGHT+IGG0ZbmprKWSOG88beLIL3qTc9McUoQae5GvpteHCpgqkA6R9gh6l5DCSqW5PcehVkuqjXlAg==
X-Received: by 2002:a05:600c:1390:b0:477:a3f9:fda5 with SMTP id
 5b1f17b1804b1-4792aef1a50mr8425815e9.9.1764745277390; 
 Tue, 02 Dec 2025 23:01:17 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a3e4sm37758920f8f.25.2025.12.02.23.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 23:01:16 -0800 (PST)
Message-ID: <2c2fbaf0-75e4-4e12-a932-7444c8143f02@linaro.org>
Date: Wed, 3 Dec 2025 08:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v6 00/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20251203060942.57851-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203060942.57851-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

New (unreviewed) patches: 1, 2, 5-8

On 3/12/25 07:09, Philippe Mathieu-Daudé wrote:
> Hi Zhao,
> 
> This is my answer to this comment of yours:
> 
>   > Although other callers of fw_cfg_init_io_dma() besides x86 also pass
>   > DMA arguments to create DMA-enabled FwCfgIoState, the "dma_enabled"
>   > property of FwCfgIoState cannot yet be removed, because Sun4u and Sun4v
>   > still create DMA-disabled FwCfgIoState (bypass fw_cfg_init_io_dma()) in
>   > sun4uv_init() (hw/sparc64/sun4u.c).
>   >
>   > Maybe reusing fw_cfg_init_io_dma() for them would be a better choice, or
>   > adding fw_cfg_init_io_nodma(). However, before that, first simplify the
>   > handling of FwCfgState in x86.
>   >
>   > Considering that FwCfgIoState in x86 enables DMA by default, remove the
>   > handling for DMA-disabled cases and replace DMA checks with assertions
>   > to ensure that the default DMA-enabled setting is not broken.
> 
> My series is to apply just after this patch of your series:
> 
>    [PATCH v5 10/28] hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()
> 
> Regards,
> 
> Phil.
> 
> Based-on: <20251202162835.3227894-11-zhao1.liu@intel.com>
> 
> Philippe Mathieu-Daudé (12):
>    hw/ppc/mac: Use fw_cfg_init_mem_nodma()
>    hw/sparc/sun4m: Use fw_cfg_init_mem_nodma()
>    hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
>    hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
>      fw_cfg_init_mem_dma()
>    hw/nvram/fw_cfg: Propagate I/O MemoryRegion to fw_cfg_init_io_dma()
>    hw/nvram/fw_cfg: Factor fw_cfg_init_io_internal() out
>    hw/nvram/fw_cfg: Add fw_cfg_init_io_nodma() helper
>    hw/sparc64/sun4u: Use fw_cfg_init_io_nodma()
>    hw/nvram/fw_cfg: Remove fw_cfg_io_properties::dma_enabled
>    hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
>    hw/i386/pc: Remove multiboot.bin
>    hw/i386: Remove linuxboot.bin



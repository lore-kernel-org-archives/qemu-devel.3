Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F88CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jfd-0001Tf-O5; Fri, 03 Oct 2025 13:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jfU-0001HH-00
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:34:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jfI-0003dg-6T
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:34:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-28832ad6f64so29793055ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759512832; x=1760117632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hSYnfkkF64orw/XjMq2TKkNJ1NbTYKuZnC2iwsA9byE=;
 b=Xqu54pQtX1224bwZWSCRrLtVEv4i5o86s9FzhHzZKKsgsIAYcm3Vr3cln06/5Ry7DJ
 ay575tfB+IO0EPGibd347XPXOEPo33CPOlXJZ7gvpRyD2wIuakxLXd772VdKXNcPFXwX
 hDibQANkSwTdhlHNJSuTpkStW5Gxy9hVR25viADXkdRbIl+F/gbRrxpwAO//k0bWktt7
 iV5yiGPlcqpB37FseqWXlu0nmhiWnhDRM2ueOrsgOaSEz7QWO5SzhM2rVMz7Rc1TrtQX
 LcKVfjYM1wogC+8YKPlGnzSUX1OsS89bBSIXahhjynDvpZ8ALRcrPv/7KfLiRnYmtkWm
 mrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759512832; x=1760117632;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hSYnfkkF64orw/XjMq2TKkNJ1NbTYKuZnC2iwsA9byE=;
 b=UewvdKpP32GYG0dioATG2BHV/hMWJtHQY5JWJr57HZh5ldKhFMsv8qDOc+mEAyHNCq
 RxjiH76dgsO534iZ7LlfbDzfRpv6pulCASpufuVZaddVtMBCvxcOp7zn9aqiBHc87OtB
 AN+D0X1vaWf+AO2T4svlVRuZ319FYjN9gFto4cv1U7IFMThIxyAM4eXn0DIRCY4EBYvU
 oSdM2P5MBTSmcDt0AGguNFVaWQ+LMACDh9VwCo52o2CsJ0+nxPX2cOl9SNTUw0gmmCY1
 odBKoX2UPB8Mj72xkpgfHxhH3vpf082QNZzfkzVml9RgkTsUoD8gv4QkfJAiiKo+YL+G
 /btg==
X-Gm-Message-State: AOJu0YzG7cZn1eeEQLDl2xX4dtQO9Apo/OpSPjLYgML/GCIdG0+aGltB
 ys02tmAx16AdHq4wDLqAXqALqiZMc1ZlhD5JS9+/Td99bLx0XfBfzF0dSamNmyyzycDF+XK2PNu
 t19P0MGs=
X-Gm-Gg: ASbGncvw2hXUyCse1jz3dG/TebdzolA6/+rPNeKiktySerjxjzM9M0A2VtFSs33A0T4
 JqW5Af4xlTXAqvElKOV2kARW6v+xakU3dUfu+u6s7r6+MHAezDbUZ9SnjSsAtWYXwVMeRqSWesT
 3SD5Qf4sSeZuOPQ6ADKxBtJmzoVEADLSesQEd2s/SQa9ddHC6ymMIwQlhe5vyhraYHu25OXnM/h
 DC5Kk8aNNMapAP8R3BXDTKAHGjb5rk4U/kqh3kNWhEA4wqsCTnTA3mbYo+/UsJ5rpMViYofpFVQ
 AfvsNYyMhSHCKGOExsNO8+70mOmy9lD2nFEeUGJpz0T9Gp+/O9gs/pUw9pSA/3a4B06Hg+TfVkK
 X6UiNwH8VW7d77BvFUYcKZWMbEJNsisazViSitjQjfgZyiHk9vZIOpo7jjRrAODaxDZvvoXjO3G
 8=
X-Google-Smtp-Source: AGHT+IG1kGzmGLuxcgDOxSH8ERMi3rwdYVJysG6VxDEqNnH8HSI5LrDTRaEfINP+3eBECq0l/9pELA==
X-Received: by 2002:a17:903:2b0f:b0:28e:7f4e:d694 with SMTP id
 d9443c01a7336-28e9a61a8cfmr51395525ad.28.1759512832272; 
 Fri, 03 Oct 2025 10:33:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1233c1sm55923125ad.47.2025.10.03.10.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 10:33:51 -0700 (PDT)
Message-ID: <98b20903-1dd3-4ea1-a84e-921f2ce54e0d@linaro.org>
Date: Fri, 3 Oct 2025 10:33:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] riscv-to-apply queue
To: qemu-devel@nongnu.org
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/2/25 20:26, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:
> 
>    Merge tag 'rust-ci-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251003-3
> 
> for you to fetch changes up to ad2a0aa2824b1dac9f61bac33980e866e9a88856:
> 
>    docs: riscv-iommu: Update status of kernel support (2025-10-03 13:17:04 +1000)
> 
> ----------------------------------------------------------------
> First RISC-V PR for 10.2
> 
> * Fix MSI table size limit
> * Add riscv64 to FirmwareArchitecture
> * Sync RISC-V hwprobe with Linux
> * Implement MonitorDef HMP API
> * Update OpenSBI to v1.7
> * Fix SiFive UART character drop issue and minor refactors
> * Fix RISC-V timer migration issues
> * Use riscv_cpu_is_32bit() when handling SBI_DBCN reg
> * Use riscv_csrr in riscv_csr_read
> * Align memory allocations to 2M on RISC-V
> * Do not use translator_ldl in opcode_at
> * Minor fixes of RISC-V CFI
> * Modify minimum VLEN rule
> * Fix vslide1[up|down].vx unexpected result when XLEN=32 and SEW=64
> * Fixup IOMMU PDT Nested Walk
> * Fix endianness swap on compressed instructions
> * Update status of IOMMU kernel support


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


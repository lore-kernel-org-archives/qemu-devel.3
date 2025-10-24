Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDEDCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCF3d-00057n-1v; Fri, 24 Oct 2025 06:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF3b-00055c-F4
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:30:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF3U-000487-Pa
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:30:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso23684455e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761301795; x=1761906595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERBRmlWPHNoHmHmye71S/G5PFJyjUEuPJjFuFtoWsBg=;
 b=HIGG4sM8zMo5pCZSi08/ZVWOq7aGiFM+MOOqgM7qf8e8k7q3Xaf+aG6MrTGeEC96Cg
 lSR49OmvwlWA0rdMT/lolEHcYY0wNhX59oiWqL0C4Ze4d9VyIs39Ttdekbgw4uE6CeNm
 Fhu2nEMbmzQ7kZwmEz9ilzi4DTWCklYmtclAnoJWr7vSdrGTgjtFZxW1Dk/kGxXhg5N7
 8Qtfp82Ix+I8L7g+zBXiofLHoVCNE3BrgmwA0BJwprN96BYMUBWg/jvc84Nmr+mOuAeF
 s6GiR8/1bOPc15+3QtpkCYJJKg7f8jOOghR6m32iu4t1/AgGdsjpa1Vliq3Fce4MX7fC
 B0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761301795; x=1761906595;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERBRmlWPHNoHmHmye71S/G5PFJyjUEuPJjFuFtoWsBg=;
 b=biuFbbN+unpP8ML1lnIKlYmtxvDxgLouc2obMoTcT6kMCqH237ukQ5GZDMDnvAE+q0
 Ugk19HWq/fvbDgC19D3BoBY/fQs1xouVZ6JHoeF7VualPTa6DniMXFUyZClmrcliCBEv
 lDFk/S1uSA/OhOG82W45+nFfdoYlahmm7XP3G/78j6TY5DHidgK7QC2OciJ0phEAFbbf
 IfkE4jnDwhWU8POWariOy87jGL9JJ32961BRIM4EI04C4XHDuqtFjRZwPfW/Kc6pYGOp
 GAEd4Nuv/RSMszS0ZEkDhnLcOrrsnZLaZ4LzwCnygS3z6j+Xh2enk7lMZT1mXtixRZdl
 yjkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBZTiP/YJSC743f+0t//lZ9Ok9roDj4JIriGrxCNcug/MxMsV71riY0VDRFJ7jVoQdsYQHXRHfQpRR@nongnu.org
X-Gm-Message-State: AOJu0YyN0PxJfA6uc2Mx4AYbJpfcXJ72C9NCyo6K0FA5DSB74lVMFIOO
 Lru12uqkLDP/uOVtRkcXV0umg99Ta+cC46cTfoSVH3yLty77iQadq71k/mVnOYkDl4su3F1Eoel
 4a99jChw=
X-Gm-Gg: ASbGnctjIJJvtRdFBW0mpK79BcR1J8HOCoOmJ5O2oEBQgGBhMmrDUA8kzBgvQ7Vy4RZ
 60n3o3Vs3XXKsXZn+4XSWmOJedTNoU64+uoYHOHqWr/4OwAIJNRH1TW+LCHf/jZ3k6wlB2oWeh9
 z8qhjXTJZcqziCDdU231MVGO5KT9innToKKUGquNUGTDsrCf3mbWB9O7UXvQoeuVzrWPBCwK0/X
 ne42bgjk9kiORifi9cMuikl3nCUSAYuDDG+HbKNonv7YnthDuIzZq2Ee845diX9KakGjgdoru4K
 n+HyHFCePg15tXQe1sirfpJ6zTZl6u1QxkjTjlGrDcAmpmvMfL453th5F//K7f9DPNQSGn1xU7+
 lx+/yEF1E8y4KVdJyKB2eq1PQJpqVX/5rdpVLWS9qA06D3i81a1xi26Ikr/L0dDFoYDJzN02hDa
 WsRyr6+AM4SQglL5ORFsMeQwpwDAl/ehex0ua/NXQiW5oJ6FNcjTL3wA==
X-Google-Smtp-Source: AGHT+IG+CZrCLfVU3TFo7Ty7Nvlp6phPIR1g+OaKi6kY/I8Vl+659wd2FLn5HqPgu5yH38Vi8bURlQ==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id
 5b1f17b1804b1-47117917572mr255805895e9.32.1761301794875; 
 Fri, 24 Oct 2025 03:29:54 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff3f5sm8749387f8f.22.2025.10.24.03.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:29:54 -0700 (PDT)
Message-ID: <f899c002-e645-45dd-907a-0fabb1b21aeb@linaro.org>
Date: Fri, 24 Oct 2025 12:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 2/6] core/loader: capture Error from load_image_targphys
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-5-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-5-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/10/25 11:26, Vishal Chourasia wrote:
> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
> 
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/alpha/dp264.c         |  4 ++--
>   hw/arm/armv7m.c          |  2 +-
>   hw/arm/boot.c            |  5 +++--
>   hw/arm/digic_boards.c    |  2 +-
>   hw/arm/highbank.c        |  3 ++-
>   hw/arm/raspi.c           |  2 +-
>   hw/arm/vexpress.c        |  2 +-
>   hw/core/generic-loader.c |  3 ++-
>   hw/core/guest-loader.c   |  2 +-
>   hw/core/loader.c         | 16 +++++++++-------
>   hw/hppa/machine.c        |  5 +++--
>   hw/i386/multiboot.c      |  2 +-
>   hw/i386/x86-common.c     |  4 ++--
>   hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>   hw/loongarch/boot.c      |  5 ++---
>   hw/m68k/an5206.c         |  2 +-
>   hw/m68k/mcf5208.c        |  4 ++--
>   hw/m68k/next-cube.c      |  2 +-
>   hw/m68k/q800.c           |  7 ++++---
>   hw/m68k/virt.c           |  4 ++--
>   hw/microblaze/boot.c     |  5 +++--
>   hw/mips/boston.c         |  2 +-
>   hw/mips/fuloong2e.c      |  9 +++++----
>   hw/mips/jazz.c           |  2 +-
>   hw/mips/loongson3_virt.c | 10 ++++++----
>   hw/mips/malta.c          |  9 +++++----
>   hw/nubus/nubus-device.c  |  2 +-
>   hw/openrisc/boot.c       |  5 +++--
>   hw/pci/pci.c             |  2 +-
>   hw/ppc/amigaone.c        |  4 ++--
>   hw/ppc/e500.c            |  5 +++--
>   hw/ppc/mac_newworld.c    |  9 ++++++---
>   hw/ppc/mac_oldworld.c    |  9 ++++++---
>   hw/ppc/pegasos2.c        |  5 +++--
>   hw/ppc/pnv.c             |  9 ++++++---
>   hw/ppc/ppc440_bamboo.c   |  3 ++-
>   hw/ppc/prep.c            |  8 +++++---
>   hw/ppc/sam460ex.c        |  3 ++-
>   hw/ppc/spapr.c           |  8 ++++----
>   hw/ppc/virtex_ml507.c    |  5 +++--
>   hw/riscv/boot.c          |  7 ++++---
>   hw/rx/rx-gdbsim.c        |  2 +-
>   hw/s390x/ipl.c           |  8 +++++---
>   hw/sh4/r2d.c             |  8 +++++---
>   hw/smbios/smbios.c       |  2 +-
>   hw/sparc/leon3.c         |  4 ++--
>   hw/sparc/sun4m.c         |  8 +++++---
>   hw/sparc64/sun4u.c       |  7 ++++---
>   hw/xtensa/xtfpga.c       |  3 ++-
>   include/hw/loader.h      |  8 +++++---
>   system/device_tree.c     |  2 +-
>   51 files changed, 145 insertions(+), 106 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



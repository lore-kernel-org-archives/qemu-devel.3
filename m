Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D8D15DB7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqWK-0004uW-MZ; Wed, 03 Dec 2025 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vQqWG-0004sM-Rh
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:20:00 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vQqWE-0002mO-Dl
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:20:00 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c75fc222c3so2853488a34.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764782397; x=1765387197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5M32mqkAIot2qvrxmcQG0qzK+Aet+B+6X3OipO/Rt3k=;
 b=gtkDdarCrhPopsynzQBIU3EkIewD8h7+lmFoRb8tZPICwxOvTnuK0xtDzrMvFil7FE
 gKLd9iZ7lnj966HwUaJIMvv6DvPdDvMcsHL7JlzkC3AMeBq/HGwIzLLO3Qtgq1Ck1acH
 9JOZfW2R52gcJ+/cXE71zJ7q0wfyAhDKlQgdJQHiA7R3hMAN1dHvEcTZOufBHbrBnPZj
 aNWm2aDUt33k3HStOTwRp8qOalSuXQJR4rBC3ANdMrmFadkKUUXmqcYOdGf4g6R/RKAq
 q7gnC2C9y0ApyDtQQNxWSTLsZMIwsbjpjrTxjXKo8MMglm30COgBJOWspQDj2vobixLo
 9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782397; x=1765387197;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5M32mqkAIot2qvrxmcQG0qzK+Aet+B+6X3OipO/Rt3k=;
 b=mhZkH3YZ+hwZIfvXstK4EaL1GCADKyDuicWI/8HevlMZFTXXmEnEFaozj652tkEr4W
 BSszTSDF+6wKeAB33aZMe0tAydNnyUsTKdVrSYJd47FTcCFU2IHXj1Det80H2R4SYW5U
 gJ98bkacCA6K/3kKoMgNZ7UXPzm0efmb0K1tfwC6urUR4Q1nV39/8RTeDhQvldJbdgM6
 iML0Z2qXbFOkRxe7LatSDOxy9axOT0oMqnu4XC0ynhcWN9ePlT36pcAyBC5IDtpmsS/F
 FG98VCmFjOC2OFiyGBnX/o5Ml8Q2rvD0Xpa07UFIYf1E+jUzHloczV8OFoIK1A6pukuO
 niYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Xj0EiHigkBqt4Mq1hGSk2m53hxWnqsy3CLTOPcu/eIg/X/y+ruicGePc+mVJKqkLw0gc4ZQhrAPe@nongnu.org
X-Gm-Message-State: AOJu0YxkTX4Rm9+RzG4dzP4k8nTOn9m0Fc9f1e4OupgGU4bHODmvuvYE
 yI0NbDcPJpQGU2773oiF0Ac0WStD5f0k4Gh9i6nm5Fy5UZYMNuGridkOwGc2zZSm0K4=
X-Gm-Gg: ASbGncuBVBHRgnj9M52k9to8FOWR99kghu6KOom03oAR+SiC6fkC1DlKTv902a+qwD7
 M6CRTbCaaIRthqOXG8BzBsVk8MmbI6F5u/zu3kgSb8bnICFGqDGZbro3IYr1SXV9PVhQXTXhn7i
 v6c7yyFYr9S1qwSFwbRG+xoOKSP82H7GYq24gD8QWopqhPtqPT+w7+F3+3pK3TC3K937kJ4498S
 2EVf+l1xmcg5XJn7eFi0RXWVak1ITZyVUjT/2/1hrixnFgTbrKgaiSMcORmzVz6DX7209XScb1r
 Y4tH3Ov3BgRcg0S+LNXaLdIMxv2Y3uTdAebBDUk08pjipVxJjAH/wBZ2ctwTAA0beCV1hDA5UN4
 r5W22ZQaclVwPvRtzBuvH80FwojCt5y7HBW0zDas8p8WcHGE3yY/6IcgrA4dKGOKPRZisx3XLpl
 idz9+AEXOWMKHqQrdc/Qq8wJa0oAQ=
X-Google-Smtp-Source: AGHT+IEup/LUr/d0da63nhvgNSCNupUzv/Zo1YPFq5nmpOGsOr/FxgamqZqy43/R0JAMCttWASK2kQ==
X-Received: by 2002:a05:6830:6dc5:b0:7c7:5770:d2bd with SMTP id
 46e09a7af769-7c94db475c6mr1573293a34.12.1764782396847; 
 Wed, 03 Dec 2025 09:19:56 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.217])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c910025f8bsm8927454a34.29.2025.12.03.09.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:19:56 -0800 (PST)
Message-ID: <6163ffd5-b0ff-4993-9db2-36492702487c@ventanamicro.com>
Date: Wed, 3 Dec 2025 14:19:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] docs/system/riscv: add documentation for k230
 machine
To: Chao Liu <chao.liu@zevorn.cn>, richard.henderson@linaro.org,
 paolo.savini@embecosm.com, npiggin@gmail.com, ebiggers@kernel.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <a303c6a1f48e7ba076bb62d78084d0008ae39526.1764493931.git.chao.liu@zevorn.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <a303c6a1f48e7ba076bb62d78084d0008ae39526.1764493931.git.chao.liu@zevorn.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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

Hi,

This patch won't build in my env:

[3031/3032] Generating docs/QEMU manual with a custom command
FAILED: docs/docs.stamp
/usr/bin/env CONFDIR=etc/qemu /home/danielhb/work/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=1 -j auto -Dversion=10.1.92 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /home/danielhb/work/qemu/build/docs/manual.p /home/danielhb/work/qemu/docs /home/danielhb/work/qemu/build/docs/manual
/home/danielhb/work/qemu/docs/system/riscv/k230.rst: WARNING: document isn't included in any toctree
ninja: build stopped: subcommand failed.



This diff fixes it:


$ git diff
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..2103ff6173 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
  .. toctree::
     :maxdepth: 1
  
+   riscv/k230
     riscv/microblaze-v-generic
     riscv/microchip-icicle-kit
     riscv/shakti-c



Thanks,

Daniel


On 11/30/25 6:21 AM, Chao Liu wrote:
> Add documentation for k230 virt reference platform.
> 
> Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
> ---
>   docs/system/riscv/k230.rst | 48 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 docs/system/riscv/k230.rst
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> new file mode 100644
> index 0000000000..3e6ca295df
> --- /dev/null
> +++ b/docs/system/riscv/k230.rst
> @@ -0,0 +1,48 @@
> +Kendryte K230 virt reference platform (``k230``)
> +==========================================================================
> +The ``k230`` machine is compatible with with Kendryte K230 SDK.
> +
> +The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
> +Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
> +structure.
> +
> +This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
> +Process Unit) smart computing unit.
> +
> +It has multi-precision AI computing ability, works with many common AI computing
> +frameworks, and for some typical networks, its usage rate is over 70%. Besides,
> +the K230 chip supports many peripheral connections and has several special
> +hardware acceleration units (like 2D and 2.5D accelerators). It can speed up
> +different tasks (such as image processing, video processing, audio processing
> +and AI computing). It also has many good features: low delay, high performance,
> +low power use and fast start-up.
> +
> +For more information, see <https://www.kendryte.com/en/proDetail/230>
> +
> +Supported devices
> +-----------------
> +The ``k230`` machine supports the following devices:
> +
> +* 1 c908 cores
> +* Core Local Interruptor (CLINT)
> +* Incoming MSI Controller (IMSIC)
> +* 2 K230 Watchdog Timer
> +* 4 UART
> +
> +Boot options
> +------------
> +The ``k230`` machine can start using the standard ``-bios``
> +functionality for loading the boot image. You need to compile and link
> +the firmware, kernel, and Device Tree (FDT) into a single binary file with
> +K230 SDK(k230_canmv_defconfig), such as ``uboot``.
> +
> +Running
> +-------
> +Below is an example command line for running the ``k230``
> +machine:
> +
> +.. code-block:: bash
> +
> +   $ qemu-system-riscv64 -machine k230 \
> +      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
> +      -nographic



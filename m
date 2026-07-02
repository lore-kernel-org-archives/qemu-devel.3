Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIiw-0001zu-59; Thu, 02 Jul 2026 10:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIiv-0001zf-DH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:49:05 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIit-0000so-Ka
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:49:05 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb945f787so1370613a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003742; x=1783608542; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WqpL4s+8JOX7fCsS3YHLlRR8saME78FEECRlangOkMQ=;
 b=QdTgo64IPFMAtcM23nMXbf+I3GbPHfJNFgij5v6WV+9jiG5ZRFhBJ7jFyvoBOSIpl+
 4aQbuMlDzm3DW4J1sgD4nBi7ZKKYampM8nb0RYUGkKQ6s/TiHAQWJVxX1wozdk1MAAa+
 7AqcbYAXdXcrkQP4hvLP43DPIJ/S153Wq6t/35GgpPvAykQy6LR6rMstzNMtG0fBIXWg
 GmqfQEPRNwZkZeWWVMo7gCN6Ly5pVXZSzkLHGbJHJCmyJV8KrT42uVUVVfKEPazvihRw
 fZdssXE2ysuDA3WmlJivzljUWIbc87cWOtGFJ4vmPgrzjBjgqY6vEqrqXDnhifrdwpvY
 K9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003742; x=1783608542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqpL4s+8JOX7fCsS3YHLlRR8saME78FEECRlangOkMQ=;
 b=OIzGcHiO7nqy/mQvr4k7ERTP3R4zLj1+X7RkTpyTNXWu5b8RH8lQAEYVpMBilQeNJ5
 NI9qyBalw2V3WYaWa7Y2HclYAkPOBZ/YKVUH4Xfzg0Zcb/78PnBCXuDwIaJHOR0zNnzM
 flq6V/n7/BqZ3ABEiwpe0lhh9vagx3lkdiH0AhUXu+7WZjhbmNjQZOAP2vhbKOzKlXPU
 PaAbj7q7BNus4o3YFINCVjI4zLjNdeGgbGfTeoI/flcs3YFWQ4J7gXWnOk/JFctWCE2T
 YCsTXqTFWTowgHOqA8xmgHGhQvU08P3F5/sClSxIpR8pxC/ZeNMwczkcEuL6By/ASVqr
 f8rg==
X-Gm-Message-State: AOJu0Ywz+Hvy9BfokI+iOmhTfwm/QE7ZjyW1Te4XasXhE1+300ASmDlZ
 8YbgNQT/TGfvyuVkijCX5abJXf62j/AeOVk12zc4/yJaEmU8eYq05hxQ
X-Gm-Gg: AfdE7ckUheNahhOvnWOzhJ8neQpniW+50EkKLon+llP9OEvNJ/ynCHRpVJjwNBSni+F
 PdjnWpe+//I46nRxBi11gFKgt8oCPlZsUMzvD8X55wzFoHZ6V4qnZYhHGuK0lULZilJ/dhZ8Duq
 KD8nMy0Fw2B77eYtHSaU4K6EYAcIngM9ZLjvcHJDhEqfS7aAHlJXEW5thulS2TtRpy+D2YNgqY2
 cCh2zVqI9TTXGAYLym5Asw5HALpNLDlsphZrP4wsbAX4/6fL6cVdy7a2AQt8J48xC8yUquVcqTv
 RficobX4pglRlQlSTbZjv1vwzN0vHT5islbP3KTw98sSKsCkBK458Nt9Wl28AFJRyqURgskHfi/
 88qLienV40KAyIk7AQowuASdqPaetnv9Hm8/ABZ6BVXw+jDYRzHzns5OWJnvov0mUGBbGNCD5b4
 7QdLWUGvJQXMSTAbIJ3Qb7wZ2F1o+LaMMfHFXq44drsYRovoJm
X-Received: by 2002:a17:90b:4f85:b0:37e:1bc4:b6ae with SMTP id
 98e67ed59e1d1-380ba868ebcmr6725507a91.8.1783003742106; 
 Thu, 02 Jul 2026 07:49:02 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b85de12sm10735644eec.12.2026.07.02.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:49:01 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:48:58 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 7/7] docs: add riscv-server-ref.rst
Message-ID: <akZ6TwWeBWN1sEhD@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-8-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610214133.1882563-8-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 10, 2026 at 06:41:33PM +0800, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
> 
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
> new file mode 100644
> index 0000000000..0573b4e07c
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +RISC-V Server Platform Reference board (``riscv-server-ref``)
> +=============================================================
> +
> +The RISC-V Server Platform specification `spec`_ defines a standardized
> +set of hardware and software capabilities that portable system software,
> +such as OS and hypervisors, can rely on being present in a RISC-V server
> +platform.  This machine aims to emulate this specification, providing
> +an environment for firmware/OS development and testing.
> +
> +`spec`_ is version 1.0 at the introduction of this board.  New spec versions
> +might trigger a revision of the emulation itself, which will strive to always
> +match the latest version available.  In case the emulation changes aren't
> +backwards compatible we'll introduce a versioning scheme, probably via
> +a machine property, to allow older SW to run with older spec versions.
> +
> +The main features included in the riscv-server-ref board are:
> +
> +* IOMMU platform device (riscv-iommu-sys)
> +* AIA
> +* PCIe AHCI
> +* PCIe NIC
> +* No virtio mmio bus
> +* No fw_cfg device
> +* No ACPI table
> +* Minimal device tree nodes
> +
> +There are multiple ways of using this reference board.  The spec compliant way
> +is using an EDK2 image and a TPM device.  The board was tested with the TPM
> +device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
> +to use this device can be found in `tpm`_.
> +
> +To use this board coupled with the tpm-tis device, first start the ``swtpm``
> +process in a shell (the ``log`` parameter is optional):
> +
> +.. code-block:: bash
> +
> +    $ mkdir /tmp/mytpm1
> +    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
> +            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> +            --tpm2 \
> +            --log level=20
> +
> +And then start QEMU with:
> +
> +.. code-block:: bash
> +
> + qemu-system-riscv64 -M riscv-server-ref \
> +     -bios fw_dynamic.bin \
> +     -kernel EDK2.fd \
> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
> +     -device ahci,id=ahci \
> +     -device ide-hd,drive=hd0,bus=ahci.0 \
> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +     -device tpm-tis-device,tpmdev=tpm0 \
> +     -nographic
> +
> +
> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> +.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index afd86ca2ba..b2aeb39a8e 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -73,6 +73,7 @@ undocumented; you can get a complete list by running
>     riscv/sifive_u
>     riscv/virt
>     riscv/xiangshan-kunminghu
> +   riscv/riscv-server-ref
>  
>  RISC-V CPU firmware
>  -------------------
> -- 
> 2.43.0
> 


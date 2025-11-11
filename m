Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D973CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 23:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIxxc-00068T-N3; Tue, 11 Nov 2025 18:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxxX-00066D-AR
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:39:35 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vIxxV-0007wE-E8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 18:39:34 -0500
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-9486adc1aa9so9424439f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 15:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762904372; x=1763509172; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MClZp1wb+APJJTu8Kt7fW51aMX17E4oy5g9GVGtSrm8=;
 b=WpW9t8fxUgdtDgoKPpO4jxLlzvnLn4jOn4JLnY4QeK1YyqNDJWmMFGe8fHQvbziLrW
 xOK8BNfD9tuCyH8X3ZDq5AzS8j2ZHXq4aEpwfnZRiq14dUMxns+DjHQNB21zRuP1wUuf
 Dvrzg9P1yGcM/m76a094g6xtciDImajwEsWwE+pi5cGnk5cH9z2o4DmjENVIMmMAgfM7
 +nBlypyjYl8MXqHFO9CxFAvwL3kUItFLgfiywQ175evvE3Suj9hUloEU9t8qZj/kYDeB
 eMZHPnoqxGw5yk7zz4qnFolGiVIhzgd8+DqazPA8iDiOjUNFvLVntm8VEMP2R+Yn9ACs
 kFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762904372; x=1763509172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MClZp1wb+APJJTu8Kt7fW51aMX17E4oy5g9GVGtSrm8=;
 b=OyhX7FSY/KT3WiVbfwXJKaaPRn1sZP4PiisKdxuZj2xO7fKjeCWuVtbDftf/HqGmul
 6SqCBFQ0SRcihEm/eQQMcYl0AfEH5IzcGFbvSBJ6qdh2zFGq8W8J40GliJksblYCH1E1
 CC2ML/D+/TVHln6jiurqElYF4nUY3JBcCDEPE6RA8YhaDB11aH1nl7Y66xkVKqRdhdir
 L9icVfxgr3Egvk7uHx5cGrvmqH9HZtKM68JgMxXoj5qgI4+AwMEc2tCQEqAi9Q+X/3ak
 QiXa1JMGtdYhviJvLVe7HAcqEUlE1r84TvXeFx4dAk8BjyrmhrSlHuD3PrcJTblOtjoG
 satQ==
X-Gm-Message-State: AOJu0YzpEBmECOUPEMpAutg/4qJ4Vr+MmF2gGTD4CCyshGZYNx6x6lUG
 PPBY6j6rqb+1TZ5yRnguVBOrcpx4pMLf/FdpIrCpXysJEVHMUHtRHlZt7obmVnY1204=
X-Gm-Gg: ASbGncvFSoD9RvHtXdyEA6JVPB3wUzSwlHmHLOuDM0doucbFlsbf3Zv2nXJWwWRGedW
 YHn5DMN0OBqtgR2qSnDKUq6GVdol6Sp1E7ngSxJzz3Z6UuaTOCm1mWUkkM3xXO//BpzIJeDLkw5
 ngQHE5hiNsE52ZwjlIEPtkj4a+i/GmH/2zjlBGAagU3JMJpo5VwG3IfLzpaAQiInkPflngxfKvj
 57VYT9aAhTizMQGzSwASk4383uQ+Mf+Avm4MtlXu1GgTbIeyO8fLHrN5WeCey4qD+fo4bT0j4f1
 rymAufLpoIgqOS5cJeLq6lqR3KpPuLtf9qM/hs75DRUwHMwM3QmO6AW14gvxTBhD4i/fIo2ufFl
 mCkxPskVOBLlgXCTdp9+TwImYb0lUGM7PoLbgxQ0L4DIXzRo+JVuNe7Eb+zYGe4O2Vc5d2ZyXdf
 QJrg==
X-Google-Smtp-Source: AGHT+IFRxvzqAKPJG9xzL73zHdqqK/XBKTbic+bpiH+SQ/Woun4CtiEWI1SXJBpUXoHtn5UAjb4vvw==
X-Received: by 2002:a05:6602:1549:b0:948:3d23:529e with SMTP id
 ca18e2360f4ac-948c4561827mr160444639f.4.1762904372075; 
 Tue, 11 Nov 2025 15:39:32 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-94888dac337sm503609839f.21.2025.11.11.15.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 15:39:31 -0800 (PST)
Date: Tue, 11 Nov 2025 17:39:30 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Subject: Re: [PATCH v4 5/5] docs: add rvsp-ref.rst
Message-ID: <20251111-82866e9eb0212c08d8d02a0d@orel>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111182944.2895892-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd44.google.com
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

On Tue, Nov 11, 2025 at 03:29:44PM -0300, Daniel Henrique Barboza wrote:
> Add documentation on the new experimental board rvsp-ref.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  docs/system/riscv/rvsp-ref.rst | 28 ++++++++++++++++++++++++++++
>  docs/system/target-riscv.rst   |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 docs/system/riscv/rvsp-ref.rst
> 
> diff --git a/docs/system/riscv/rvsp-ref.rst b/docs/system/riscv/rvsp-ref.rst
> new file mode 100644
> index 0000000000..3889fce413
> --- /dev/null
> +++ b/docs/system/riscv/rvsp-ref.rst
> @@ -0,0 +1,28 @@
> +Experimental RISC-V Server Platform Reference board (``rvsp-ref``)
> +==================================================================
> +
> +The RISC-V Server Platform specification `spec`_ defines a standardized
> +set of hardware and software capabilities that portable system software,
> +such as OS and hypervisors, can rely on being present in a RISC-V server
> +platform. This machine aims to emulate this specification, providing
> +an environment for firmware/OS development and testing.
> +
> +The main features included in rvsp-ref are:
> +
> +*  a new CPU type rvsp-ref CPU for server platform compliance
> +* AIA
> +* PCIe AHCI
> +* PCIe NIC
> +* No virtio mmio bus
> +* No fw_cfg device
> +* No ACPI table
> +* Minimal device tree nodes
> +
> +The board is being provisioned as *experimental* because QEMU isn't
> +100% compliant with the specification at this moment - we do not have
> +support for the mandatory 'sdext' extension. The existence of the board
> +is beneficial to the development of the ecossystem around the specification,
> +so we're choosing the make the board available even in an incomplete state.
> +When 'sdext' is implemented we'll remove the 'experimental' tag from it.

'experimental' needs to stay until the 1.0 spec is ratified. Or, see my
comments in a previous patch about versioning the board instead.

Thanks,
drew

> +
> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 89b2cb732c..2ed337c8cf 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
>     riscv/sifive_u
>     riscv/virt
>     riscv/xiangshan-kunminghu
> +   riscv/rvsp-ref
>  
>  RISC-V CPU firmware
>  -------------------
> -- 
> 2.51.1
> 
> 


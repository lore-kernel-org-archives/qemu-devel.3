Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BA6EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMpT-0003JZ-Vk; Fri, 06 Feb 2026 09:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1voMpS-0003JD-4e
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:29:02 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1voMpQ-000301-LO
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:29:01 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so896535b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770388139; x=1770992939; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O4hz/azmyyJUlUPO03ad1VWmLBfDGeDcIIrxf5r19jo=;
 b=L4oXKbTsXR4sGUFUbb+zW+2YcQwgbw04iI1iKLCMq8Bq7/ljAoc0I7HgIXM57NOGCZ
 g/P9K7KDFOmf2yoWcLLBeJfTWVaXdfB7Xg/hjetDUto1PhlwFNWTHeJj3x1K3Ex01pjj
 WG0jPgjd+g75DEbtfY+rKH+cJAkIqEtK0+xoChoHmJ64xDToraZnU35injudfGr5+ieG
 8h1zfxGz3+/tPIaXEWeQnTdaoWjDvBpXgx+KqHEEAbrit7Y6xPYiRQMEnGdTy6qAizrE
 G7c/rQ1XQJdSel2iEoZ8nYQ7zZ2zM7ig2mqVWWp4dqnPm+Bs+jC2eeaaPd9XcPDs2SDS
 nGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770388139; x=1770992939;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O4hz/azmyyJUlUPO03ad1VWmLBfDGeDcIIrxf5r19jo=;
 b=ZQVbJHuHA3Q7HOqrnDnzyvLOlrHeqp1GGNtvL2U7MaWntUrHkB0Ok5oNLDsqX33EAB
 Cvev61LPscqODfsHNiK3wtEB8CE9E/fu8lPbnGPJX6Yy3zJ6Wj7Y1wY6vXsSHaZVh2qW
 o1njkAdBJcdi6q7Uf5xtzgEDgwgviR1+uSaX+tEKRfacCVM+0Ii+NlbH5T2ttAWEEph1
 lzhAWCVk+zCWm0HwSu6MXroBY6iT/K4oyo67M9W8fxQvHqIR3Uy14pxFDyFG3+18rvY1
 y9MJjUdbIb6Ft1yII6+hsFIxAIaUUuQqnRNToQoQI8ovEO3zwcCsVsRywB25cPrVhuJe
 SdIg==
X-Gm-Message-State: AOJu0Yzb70fF1f50OKHt2USKGQrrCddpGCpl5dQPWPXSF9dx85tmWeOc
 b9DTu8FXZKYyf85uNsczPgX6Q1BV0IdA+3M4YwPrSJV6ByT2WRRuQc/HbzdW2dAzalM=
X-Gm-Gg: AZuq6aIP4Dk3GPr2DhXOsRCgKO4UMecbQGHznH/vmZJ2U1XfzU6gpxnhY/gacoUy+01
 1NMJJFpeEtcMosKL05d4NGiEazfTQwI2D2lVCIy0i97BRSG/T0A0W244m6WjNt/qgTx0Typ50Gr
 fokLHHD0OJkKYHBeI41RqnIRDFACxIAg7W4YmKon+1ThMXON5zSSiYu/bjBOzAjTijZWJ9Ej1UZ
 V7/1klJXPK4l1NtlANMZ7Cf9S4Fqo9DKvbKAe1iXIRy5Fw5qnXzYlCfCuB1z4bkDjkfvnPQWi/T
 iLs59ltvaOX4gY3/1yf20PeqJSWG3mjI4+HztYzZMPO+JLXeWyIqqlAmpJ+lTQX2MBZq/iSdiVd
 ha/lktnhhkcw9EV1iLc17+uE8zivQrOL1XPNhyx8tGZep3UeCfMKPqoTvXgVSZj/mg1CyjJ2aLF
 fYZaRfAwFDVI6uDSjIuU0cVD52CS51+f6Jtw0r8N4UTnqPiJNN7SiP
X-Received: by 2002:a05:6a20:c70e:b0:35e:6c3:c8d6 with SMTP id
 adf61e73a8af0-393ad310b27mr2961800637.41.1770388138861; 
 Fri, 06 Feb 2026 06:28:58 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b2253c70sm2759603a91.17.2026.02.06.06.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 06:28:58 -0800 (PST)
Date: Fri, 6 Feb 2026 22:28:55 +0800
From: Max Chou <max.chou@sifive.com>
To: =?utf-8?Q?S=C3=A9bastien?= Michelland <sebastien.michelland@inria.fr>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Subject: Re: [PATCH v3] target/riscv: fix require_rvv passing on non-RVV CPUs
Message-ID: <aYX6NunB_f3alpLh@sifive.com>
References: <20260206100256.1360597-1-sebastien.michelland@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206100256.1360597-1-sebastien.michelland@inria.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x443.google.com
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

On 2026-02-06 11:01, Sébastien Michelland wrote:
> trans_rvv.c.inc checks for the RVV extension through the function
> require_rvv. However, at least under CONFIG_USER_ONLY, the RVV extension
> status in DisasContex->mstatus_vs is always set to DIRTY, therefore
> treating RVV instructions as legal even when the extension is not
> present, e.g. with -cpu=rv32,v=false.
> 
> This bug manifests rarely because vset{i}vl{i} perform extra checks that
> do fail without RVV, thus raising SIGILL, and with no vtype set nearly
> all other RVV instructions still pass require_rvv but fail the vill check.
> Only instructions that don't depend on type (whole-register load/stores,
> such as vs*r.v) would show the bug by being executed when v=false.
> 
> This patch sets mstatus_vs to DISABLED when RVV is not present (checked
> with the minimalistic Zve32x), meaning require_rvv now fails as intended.
> 
> Signed-off-by: Sébastien Michelland <sebastien.michelland@inria.fr>
> ---
> Thanks Max for your patience with this patch.

Reviewed-by: Max Chou <max.chou@sifive.com>

rnax


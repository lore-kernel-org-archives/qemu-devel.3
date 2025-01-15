Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DD6C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXyu2-00042F-Ln; Wed, 15 Jan 2025 03:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXyu0-00041B-4W
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:37:28 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXyty-00073u-I2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:37:27 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so12559782a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736930245; x=1737535045; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+aoaNiirkzOLXpUm3RNwlkG8qmhF0ZJnIzXPXJrrsOk=;
 b=eNdORhMcYUHi/k1s3Ib4JdXEfz1bD8FLVraVlx1Vu3uWbINsI678BuswL9MjZ6b2s4
 tj/IJ701CGAdPlzvCIPFFehQp9cVvkiO7ZCro1n4dAZeKSHrjO7sWBKsbuzUeVNgafCj
 9+1fTBXtRQfUH8F4bnBmBJ/C+qkrakpJlEWEBL2rBu9RdEQCX46uM043EtAz53Bx6Gp6
 mDMgplLlc9Wmvq2vxeodwnPj4rwbFElFCJxvNnDBTdyalnBkzlbiRVWpkywMKtYYJFtO
 RjptToekXjow7baoS0/XdDKEObEkqWqx95dT0ZF8bdvSHK1kf2JmDFJyfxtQ4ZPA67di
 zq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736930245; x=1737535045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aoaNiirkzOLXpUm3RNwlkG8qmhF0ZJnIzXPXJrrsOk=;
 b=hVLTEzlc6mPxU0Hrw/2GiEqJt639BP3LVRfXFT35bUpl036TzwntrbwMbij7uRzgFp
 jAdNUnMnTP9odyXGUbYucCcOumBSObENTRpcrBDS4K4dqNz7kX6ahOg9RJnaGULoJiGR
 5aUciH0XPHpLtFH6Wqbp4E17d4Tz3JdPiKw+0RBE8ZLawQu2PsbAXYoLDm6bIGDk/tan
 v1q6SaGIqLLPBOvwy/9A4li6ZUEXXrVc6Ohqu1IqgeDDurAxm0bvBXWsCA0q2lwKbNtb
 lJNmcaSTEVtmsEgKltW+rWRDSXDl3TyRhXRMgVH4TLt1Wy9RWdtDaUDeepmuAkrlZhmt
 E9tw==
X-Gm-Message-State: AOJu0YzTUQRgSvIdq9c7P/LMcibClJR+i8520Q1v7HcviWMVM8gjFxjZ
 hwyneidpb/AlSJQYQlXO7K6ven7WRB8bkGSqO4CcVy5yF+k6VQy7FzetfwaWh74=
X-Gm-Gg: ASbGncvQ3vsCidXU3y53xvaVWfkGsGYK8o9gMOquNtpeRWRF+OffaUgiibftiPAlt54
 pl+IOiJKFc2sQS+FIoGV02DM98xgXOsB5rT00U+pQ4tpC0zqfu7uYNu2/Xcqa6btvuc5CFXuHki
 m2n925Mc1YZdvPecajvZMp+LLfVhAzfcah3EEJSNLG0lAFUn/RJyg7AKvtVtmYQMaOqYDsl9ksY
 LRNA7uqMaQUDvKRC+VtKG4Sn5KJO8DmIRSwsOL0ML69XSNaKg9Ze6+up5zk0vybaKXUe3ae3Yo5
 0hJK6b9vr3kcFCO+hcv1/rm3ml7laGBV+0bLs9PT+w==
X-Google-Smtp-Source: AGHT+IHxVDYyKpYwtJ+1A1Bf7wGgyAP+9lfoTaWvf61tYJAzDK5MIkQnvyCIrrxGe1OBeEPQNqxHFQ==
X-Received: by 2002:a05:6402:3217:b0:5d0:d610:caa2 with SMTP id
 4fb4d7f45d1cf-5d972e4779dmr26007286a12.26.1736930244839; 
 Wed, 15 Jan 2025 00:37:24 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c4598sm6958310a12.53.2025.01.15.00.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:37:23 -0800 (PST)
Date: Wed, 15 Jan 2025 09:37:22 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 3/4] target/riscv: add RVA23U64 profile
Message-ID: <20250115-dc4eba2a304da3c590db099d@orel>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190001.1650942-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52b.google.com
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

On Tue, Jan 14, 2025 at 04:00:00PM -0300, Daniel Henrique Barboza wrote:
> Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
> all RVA22U64 mandatory extensions are also present in RVA23U64. What's
> left then is to list the mandatory extensions that are RVA23 only.
> 
> A new "rva23u64" CPU is also added.
> 
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


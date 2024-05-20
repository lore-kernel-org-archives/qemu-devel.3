Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D86C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93Z9-0007WB-0j; Mon, 20 May 2024 10:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s93Yw-0007RN-2v
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:00:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s93Yr-0001GZ-O4
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:00:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-351d79b56cdso1848426f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716213617; x=1716818417; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/8nB0KE9iIsTN79NqvxoOEILL8ZAx+/Vn72nMsp2no=;
 b=hS8f2SJWA9CSpKK38e+dOTA2ksiHnryVSY5EnLGThsEue3qPd3u3kvqv43NRaZ+T8j
 27ExOygtbHTw+7FZGz136Lvp4RcGobFxWOXG0WYEJQMnSINwEytee4G4YJAbEjVrVazA
 IIzPl48wi6ZGKyh7IRdZEjwuGpA/DXvdGUla9071RnehS3jZVuCkR1meK6vUw6jS4zfM
 6WG9WIs3fZ0t77IV8f1mlxJkoAcoDVO/ntVMulbINka8LwNnjinIOASSFbYvH42iI1Qc
 cB5+kb/vEwcZ2xMHU2hcAfH7J++yBwGeUSTWqdwWVfG5eG/wgBpCkWmyelZGV83lF+on
 MolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716213617; x=1716818417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/8nB0KE9iIsTN79NqvxoOEILL8ZAx+/Vn72nMsp2no=;
 b=QH864tGp1x2y59dHRK0zy6bB5e92EqKwCwXApLXAf4ZeQEaHAlTXzaHJej4CUpYWj7
 cK9vmfALebBQmuc5c7JxgqPNMqIMAqhr09smNp7yJP3HKkVzwnUaDAO03hnL5BlcodaB
 mpysLxSr+38z8wJY7wXzTNB4X8hJApdKOTgGn3+2qHBuoH8bUemWNSuwgJNROE/MEN4L
 7WfMPm8GWMjfyfClk/ZQqysJ+X8N2XgMQtRJ3sLVicDFFmLhma+oTKhx2HTNFPVJ2tx8
 1DqHln0M/iblmEO/vkvC4aeWV8pVMMEJ32CQrInXojMNsCi/MaxX9MB2aCeYgadewy/B
 8tZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXryZUuEl7GW1YyCG4HvvIHzxix+02VdXKN16JiyHgee7UgRqB9WZxdtDSoSUMoL3ZrJax8Zj0REwem/RQyhQkK0ssdJg0=
X-Gm-Message-State: AOJu0YwfmeNBOBoBcTuCFEx2FelBstnEyXq3BrePWbEfHMW6HEdc6OG8
 7f07mxnYUTHMJU8YJhhdwfb9s0Xm/et5q6TWbfzcaKoJyf5iZEneoBUa51o2zxQ=
X-Google-Smtp-Source: AGHT+IFLpbWP3ka8QglB6EKizB2vIq+AC0qtpJO8/weU6wWqo26JMk+QNw2LiHAsuTorINsCnQr1HQ==
X-Received: by 2002:adf:fccf:0:b0:34d:3d05:cf3a with SMTP id
 ffacd0b85a97d-3504a6311a6mr19597458f8f.22.1716213617546; 
 Mon, 20 May 2024 07:00:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a5bsm29063380f8f.36.2024.05.20.07.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 07:00:17 -0700 (PDT)
Date: Mon, 20 May 2024 16:00:16 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: "Wu, Fei2" <fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com, 
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, 
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org,
 atishp@rivosinc.com, conor@kernel.org, heinrich.schuchardt@canonical.com,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RISC-V][tech-server-soc] [RFC v2 1/2] target/riscv: Add server
 platform reference cpu
Message-ID: <20240520-ecc94488050a20d80f9c790e@orel>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-2-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312135222.3187945-2-fei2.wu@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42a.google.com
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

On Tue, Mar 12, 2024 at 09:52:20PM GMT, Wu, Fei2 wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
> a virt CPU type (rvsp-ref) as compliant as possible.

We should add the RVA23 profile cpu type first, and then base a reference
cpu type on that. But, I guess we should version the reference type, since
we shouldn't expect the reference type to be bound to only RVA23 forever.

Thanks,
drew


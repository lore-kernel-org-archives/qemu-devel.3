Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CFFCCFA0D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsrH-0004i7-QA; Mon, 03 Nov 2025 06:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vFsrE-0004h1-O7; Mon, 03 Nov 2025 06:36:20 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vFsr8-00031Q-KS; Mon, 03 Nov 2025 06:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=SDigNZuKR1yow03tEtO8tr5ib0msaSg7QthSLFpqalc=; b=fSP6m6XTVfXTEc/
 q2WQawGklHDnfEzWnc0FWmJLvTiIXrMO3O20c89mOJ6awAzx8a0X+9w2kdV/Gqg1OSLjeeV1KVJtk
 4ID3wqoHtYMyhqu4IMwmU2fZ3+KiozUyhzZ+4MujN65IUYN6YIlHCU6w5Nam2Ud35NGRJX2Io8fw1
 eM=;
Date: Mon, 3 Nov 2025 12:39:02 +0100
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, palmer@dabbelt.com, 
 dbarboza@ventanamicro.com, atishp@rivosinc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 8/8] target/riscv: Remove upper_half from
 riscv_pmu_ctr_get_fixed_counters_val
Message-ID: <4gvqyffz655oob7xfl7fyarbshscf5byszryvs3wa6dpxf4pef@7pxirsiqgfpj>
References: <20251103033713.904455-1-alistair.francis@wdc.com>
 <20251103033713.904455-9-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103033713.904455-9-alistair.francis@wdc.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/11/25, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Now that mhpmcounter is always a 64-bit value we can remove the
> upper_half argument from riscv_pmu_ctr_get_fixed_counters_val() and
> always return a 64-bit value.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 40 +++++++++-------------------------------
>  1 file changed, 9 insertions(+), 31 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>


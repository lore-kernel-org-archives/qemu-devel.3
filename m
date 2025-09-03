Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA8CCA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utuUn-0000Mm-0u; Wed, 03 Sep 2025 16:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1utuUk-0000Lt-Ph; Wed, 03 Sep 2025 16:54:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1utuUi-0003Kw-Nc; Wed, 03 Sep 2025 16:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=DDLl+S9eoFM7yC2sYqXrm7QZVei7aW3QH3Plj0ATQDY=; b=JndWoEryKXEHAkr
 XkO8G79A2JkIF2od3mOv27zkJ7wpLK4EKpzCnMFYK/EXEBsfq0Gd0YLp01BO3SoHNWu7YXAX/l8w4
 bkRLnwH2J8rmNx9T9feA5i2l/+LppBHltyPvzIzuVlel+ixXp2tlmqZz0XAes534mrOzqGflQ4idt
 b4=;
Date: Wed, 3 Sep 2025 22:56:25 +0200
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Subject: Re: [PATCH 0/3] riscv: add all available CSRs to 'info registers'
Message-ID: <3lsfiqutjsiy5do7xhvccgaouzg6rgirnzau5tud5uiq4vjbp4@rfcm5dozxzvr>
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/06/25, Daniel Henrique Barboza wrote:
> Hi,
> 
> The output of HMP 'info registers', implemented by the cpu_dump_state
> callback, returns way less CSRs than what we have available in the
> default rv64 CPU with default options. 
> 
> This series changes the callback to add all available non-vector CSRs
> when issuing 'info registers'. The vector CSRs are being handled by
> another patch [1]. 
> 
> Patches based on alistair/riscv-to-apply.next.
> 
> [1] https://lore.kernel.org/qemu-riscv/20250623145306.991562-1-dbarboza@ventanamicro.com/
> 
> 
> Daniel Henrique Barboza (3):
>   target/riscv/cpu: add riscv_dump_csr() helper
>   target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
>   target/riscv: print all available CSRs in riscv_cpu_dump_state()
> 
>  target/riscv/cpu.c | 107 +++++++++++++++++----------------------------
>  target/riscv/cpu.h |   2 +
>  target/riscv/csr.c |  18 ++++++++
>  3 files changed, 61 insertions(+), 66 deletions(-)
> 
> -- 
> 2.49.0
> 
> 

I think this makes sense, less manual maintainence is always a plus!:)

Series: reviewed-by: Anton Johansson <anjo@rev.ng>


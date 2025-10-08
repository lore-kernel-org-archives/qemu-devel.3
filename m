Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21830CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6S5X-0003qH-Cl; Wed, 08 Oct 2025 07:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6S5V-0003pQ-8T
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:12:06 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6S5T-0002rC-Pc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=JixpSjZXc/N9usUpMw9l4ybTlKXDibWLCYyCgEZHDwQ=; b=SKlU9l5gXOdPiZE
 fnG1HZPrIDz1+RsVLU62cJG1SRBuETfWdh4qiJMirUC93pUMtCNiyRD3jBVNzzGBQn+pur1k7N/2b
 Crt5UQANQIW3HZAsM6Suic8d5zD4dw/Qq6+7t05qvOTy5ne+x/JQMFuGOWJ0T6pN/0TV61TVJFfXE
 bs=;
Date: Wed, 8 Oct 2025 13:14:41 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 4/7] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
Message-ID: <ihlbjtjw6cfq6ycusisqutqirzoqtyv5mpsqizsqzvavdydyvp@yauqm4psfqs6>
References: <20251008075612.94193-1-philmd@linaro.org>
 <20251008075612.94193-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008075612.94193-5-philmd@linaro.org>
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

On 08/10/25, Philippe Mathieu-Daudé wrote:
> TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
> 7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/openrisc/mmu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>


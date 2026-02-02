Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D88E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvvT-0007ZI-Hl; Mon, 02 Feb 2026 10:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vmvvR-0007YB-SY; Mon, 02 Feb 2026 10:33:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vmvvQ-0004jJ-CN; Mon, 02 Feb 2026 10:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=kcJgEbkkcdPrw4x8wyXBf/JXILHs8kYvbY4F8xIe1GM=; b=BM2kS2JqtfNVswA
 3K09qzDBkcJkX3K7IMEbb1ksbc+64T8yEnZbsssxmGsSIX+419fhAVfObpy8rIL27sxtL2j3h1MAW
 OSr4i6IK1QBkJ+aZPZwXXDu4AIPPZqlx2rX1VE/sKrUZgev6Be/csLVeV6eOD85GnyySFpcOef9Xc
 L4=;
Date: Mon, 2 Feb 2026 16:36:45 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 05/11] target/ppc: Introduce the mo_endian_env() helper
Message-ID: <aYDBNF0z2pe-8Cjt@hive.localdomain>
References: <20260122221106.57184-1-philmd@linaro.org>
 <20260122221106.57184-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122221106.57184-6-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/01/26, Philippe Mathieu-Daudé wrote:
> Introduce mo_endian_env() which returns the endian MemOp
> from the vCPU env pointer. Keep it hardcoded as MO_TE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/internal.h        |  6 ++++++
>  target/ppc/mem_helper.c      | 18 +++++++++---------
>  target/ppc/tcg-excp_helper.c |  2 +-
>  3 files changed, 16 insertions(+), 10 deletions(-)

Minor comment but the difference between mo_endian_env() and ppc_code_endian()
is a bit unclear from the names.  I think especially since
mo_endian_env() is used in ppc_ld_code() later on. Maybe
ppc_code_endian() -> ppc_disas_endian() || ppc_tb_endian()?

Regardless of namechange, just throwing out my 2c

Reviewed-by: Anton Johansson <anjo@rev.ng>


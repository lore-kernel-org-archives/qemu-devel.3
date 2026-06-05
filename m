Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F51CCD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVSE6-00061q-Ar; Fri, 05 Jun 2026 06:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSE4-00061h-5u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:56:32 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSE2-000108-Bx
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780656981; bh=Hv91Jdt48kB3qGhKj6fHPrSHbXTw38XhE3HhcR+9tRw=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=Y0Z5KQ+sRLJ6Fpz9ZIzlP1CzONERkIxqlXIkQCSKxqUENJBSrDH2sr2IYaHSVWNF+
 WhA1MXCEkP29y9aoLQ1ybSiLpIpy4Ne00lvALtj0agKQuBPxrz8lX7uQEBx/FH6/QV
 NxAYQsIDq8vkOjhdL/rDb0ysbLOHhKE9Eh12O9bk=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 12:56:21 +0200 (CEST)
X-EA-Auth: oxhYryEUKlAPjDe1JoAKtBoQkjyN0Rk669CjjkER2lhlClHw6FIS9vDCkUBjWbh/7m/OVL00QEZxj8fzDrnnLZL3/4CWP9uT
Message-ID: <2b518a5f-b60b-4106-9ba3-59cef23380a0@mailo.com>
Date: Fri, 5 Jun 2026 12:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] target/loongarch: Add macro CSR_OFFSET and
 CPU_CSR_OFFSET
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
 <20260605083910.175647-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260605083910.175647-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 5/6/26 10:39, Bibo Mao wrote:
> Instruction rdtime is to read TSC timestamp and logic vCPU id,
> it is also used by Linux user mode emulation. However function
> get_csr_offset() cannot be called in user mode emulation, here
> macro CSR_OFFSET and CPU_CSR_OFFSET are added. The added macro
> can be called in both user emulation and system emulation.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/csr.c                            | 4 ++--
>   target/loongarch/csr.h                            | 3 +++
>   target/loongarch/tcg/insn_trans/trans_extra.c.inc | 6 +++++-
>   3 files changed, 10 insertions(+), 3 deletions(-)


> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
> index ca988c21db..6e17275546 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -8,6 +8,9 @@
>   
>   #include "cpu-csr.h"

Unrelated, but "csr.h" doesn't need to include "cpu-csr.h", better
have it included explicitly where required.

>   
> +#define CSR_OFFSET(id)                  offsetof(CPULoongArchState, id)
> +#define CPU_CSR_OFFSET(id, vm_level)    CSR_OFFSET(id)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>





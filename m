Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB1CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfiQ-0002lk-5q; Wed, 03 Jun 2026 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiL-0002dl-9U
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:34 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiJ-0000Dd-QD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780469109; bh=imZ+jnCPMxZbV111Gs4dit7KNoIPGTKQZc1yRHrhacM=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=L9kKdcYJxkFfmduAzeG4oAGdnJ3QLHIcKpj444tbCfRC0sX7wdX1cVsXB3H20ZRHy
 xXwkiOr/7O0Tt9BIavTYr0oNnAtxrrFZloUy44X84JZ2qDqs0FfsCOznymtSdN+R9d
 CRIaCWIJOJAgL5YEa/uFSzAWqTG4uR3b8eTVnnQI=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:44:23 +0200 (CEST)
X-EA-Auth: zCXg6a7/3rrNl+2G49aTxu4qA6tTO7IE0x0iR3HSNIn3KOuav/oDpcmRZ9tp57wbY9c4qCN6Aw2R1WkuTt2CIo2eS3MAZzdP
Message-ID: <36a13b71-4e4a-4542-9a1f-a079b0e07e55@mailo.com>
Date: Wed, 3 Jun 2026 08:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] target/loongarch: Move CSR registers to struct
 CPUSysState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602030029.1476299-1-maobibo@loongson.cn>
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

On 2/6/26 05:00, Bibo Mao wrote:
> Here new structure CPUSysState is added in CPULoongArchState, CSR
> registers are moved to CPUSysState, qemu timer will be moved to this
> structure in future. With incoming LVZ supported, there will be two copied
> of CSR registers, so it is simply to add CPUSysState array.
> 
> Also new field sys_state is added which points to CPUSysState at
> beginning, and it can be changed during VM exit/enter entry. There is no
> function change, all is code movement or variable rename.
> 
> ---
> v1 ... v2:
>    1. Rename get_current_state with env_sys, variable name cur with sys,
>       since cur/get_current_state is misleading.
>    2. Add modification with files in directory linux-user/loongarch64/
> ---
> Bibo Mao (13):
>    target/loongarch: Add new field curState in CPULoongArchState
>    target/loongarch: Use sys_state in cpu.c when accessing CSR registers
>    target/loongarch: Use sys_state in cpu_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in file arch_dump.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in kvm.c when accessing CSR registers
>    target/loongarch: Use sys_state in tlb_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in tcg_cpu.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in csr_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in op_helper.c when accessing CSR
>      registers

Patches 1-10:
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>




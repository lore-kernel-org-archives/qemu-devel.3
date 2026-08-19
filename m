Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3A8C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wweWt-0005Fn-RZ; Wed, 19 Aug 2026 07:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wweWr-0005FW-Up
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:32:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wweWq-00071p-1r
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:32:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 85C79583223;
 Wed, 19 Aug 2026 13:32:16 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id mdF5J3TFrDx1; Wed, 19 Aug 2026 13:32:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C69F58377E; Wed, 19 Aug 2026 13:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7AD3F583777;
 Wed, 19 Aug 2026 13:32:14 +0200 (CEST)
Date: Wed, 19 Aug 2026 13:32:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com, 
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 1/8] accel/tcg: cache the result of curr_cflags()
In-Reply-To: <bd54b977-fb6c-4e94-9863-745ce8133f96@linaro.org>
Message-ID: <3d7bf253-a7fb-614b-e1b4-1a4e57f81951@eik.bme.hu>
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-2-mattst88@gmail.com>
 <bd54b977-fb6c-4e94-9863-745ce8133f96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 18 Aug 2026, Richard Henderson wrote:
> On 8/18/26 10:42, Matt Turner wrote:
>> curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
>> and from the cpu_exec() loop. It recomputes the same value every time:
>>
>>      uint32_t cflags = cpu->tcg_cflags;
>>      if (unlikely(cpu_single_stepping(cpu))) { ... }
>>      else if (qatomic_read(&one_insn_per_tb)) { ... }
>>      else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
>> 
>> That is three loads and three branches on the hottest path in the
>> interpreter, for state that changes only when gdb enables single-step,
>> when one-insn-per-tb is toggled, or when the log mask changes.
>> 
>> Compute the value once into CPUState::tcg_curr_cflags and recompute it
>> from the four places that can change an input: tcg_cflags_set(),
>> cpu_single_step(), tcg_set_one_insn_per_tb() and qemu_set_log_internal().
>> curr_cflags() becomes a single load.
>
> Certainly one_insn_per_tb can only be set from the command-line, so that 
> should never have been handled along this path.

QEMU 11.1.50 monitor - type 'help' for more information
(qemu) help one-insn-per-tb
one-insn-per-tb [on|off] -- run emulation with one guest instruction per 
translation block

Regards,
BALATON Zoltan


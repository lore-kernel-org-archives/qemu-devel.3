Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87173C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 20:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1AuG-0004o3-Hx; Sun, 28 Apr 2024 16:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1s1AuE-0004lE-08
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:13:50 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1s1AuB-0002gZ-Un
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 16:13:49 -0400
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout04.t-online.de (Postfix) with SMTP id AC599C7E3;
 Sun, 28 Apr 2024 22:13:00 +0200 (CEST)
Received: from [192.168.211.200] ([84.175.235.158]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1s1AtQ-1r2lbl0; Sun, 28 Apr 2024 22:13:00 +0200
Message-ID: <3835c44b-845e-4c4c-8207-ce46a31f70a0@t-online.de>
Date: Sun, 28 Apr 2024 22:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/38] accel/whpx: Use accel-specific per-vcpu @dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20240426194200.43723-1-philmd@linaro.org>
 <20240426194200.43723-21-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20240426194200.43723-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1714335180-0B7FDE88-1A04CA02/0/0 CLEAN NORMAL
X-TOI-MSGID: 2f7291c9-86e3-4a8a-ac8c-07e1a24bba87
Received-SPF: pass client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_HTTP=0.001, RCVD_IN_SORBS_SOCKS=1.927, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 26.04.24 um 21:41 schrieb Philippe Mathieu-Daudé:
> WHPX has a specific use of the CPUState::vcpu_dirty field
> (CPUState::vcpu_dirty is not used by common code).
> To make this field accel-specific, add and use a new
> @dirty variable in the AccelCPUState structure.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20240424174506.326-2-philmd@linaro.org>
> ---
>  target/i386/whpx/whpx-all.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 31eec7048c..b08e644517 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c

> @@ -2235,7 +2236,7 @@ int whpx_init_vcpu(CPUState *cpu)
>      }
>  
>      vcpu->interruptable = true;
> -    cpu->vcpu_dirty = true;

Hi Philippe,

cpu->accel is NULL here. You probably wanted to write

+    vcpu->dirty = true;

instead of

+    cpu->accel->dirty = true;

I think your patch for nvmm_init_vcpu() in target/i386/nvmm/nvmm-all.c
has the same issue.

With best regards,
Volker

> +    cpu->accel->dirty = true;
>      cpu->accel = vcpu;
>      max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
>      qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);



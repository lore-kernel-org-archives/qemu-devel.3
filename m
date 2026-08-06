Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64423C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrvTC-0001Xa-NO; Thu, 06 Aug 2026 06:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrvTB-0001XM-9Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:37:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrvT8-0005eb-BQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:37:01 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 676AajnK013189
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 19:36:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Hrwek1T2pVxnYm812/B9o6eI81uqv/xvu8DhDIrkrF8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1786012605; v=1;
 b=Xs6WGCbTPrfZ5h08HwpWyHHQKawXMNV51tPADEJmGu5B4jwyhttc8bq4bAeIxlzL
 eXl9cE0BcS38xOpxK/HxBYBGZ+e0aN4pHU9DeWIcurFxZvgTA03/9d2EX/zcNWia
 jnC2n2X/nuG2/Q3+Orzja3P5NpUBlmL/1qXoWRQedRRclh18i0OCD1hMoNo2xKUo
 vbaq9I3tAWwxxGgbM48hzH5nOp0SMbTCRLJ8P1PnyZLhxMW8AnJ14FR6OYvWSrQQ
 wZiE0XcO8mTn28YzObLRF8sVJlS6Uu00+G9i6rWM870ThzCOQadDSTw7RVMtJIag
 abYTSJDxqimNjoGUnfv0nA==
Message-ID: <569c95df-4d78-4df3-a12e-b9cdb9652f83@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 19:36:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dump: add crash_occurred flag to QEMUCPUState
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@qualcomm.com, pbonzini@redhat.com, viktor.prutyanov@phystech.edu
References: <178600606177.41696.3160576684819885412@linux.alibaba.com>
 <178600606177.41696.17514250023045302941@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <178600606177.41696.17514250023045302941@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/06 17:47, Zhengrong Li wrote:
> Add is_crash_occurred_cpu field to the local QEMUCPUState in
> arch_dump.c so that dump-guest-memory can record which CPU
> triggered the guest panic.
> 
> The new field is appended after kernel_gs_base, so existing
> tools that check the 'size' field can safely ignore it when
> reading older dumps.

Message nit: appending the field lets older tools ignore it in newer 
dumps; checking size lets newer tools detect its absence in older dumps. 
The current compatibility sentence conflates those directions.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
> ---
>   target/i386/arch_dump.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 16e47c4747..8ce2c7e9bb 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -264,6 +264,8 @@ struct QEMUCPUState {
>        * by checking 'size' field.
>        */
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];
>   };
>   
>   typedef struct QEMUCPUState QEMUCPUState;
> @@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache *s)
>   
>   static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   {
> +    CPUState *cs = env_cpu(env);
>       memset(s, 0, sizeof(QEMUCPUState));
>   
>       s->version = QEMUCPUSTATE_VERSION;
> @@ -325,6 +328,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   #ifdef TARGET_X86_64
>       s->kernel_gs_base = env->kernelgsbase;
>   #endif
> +    if (cs->crash_occurred) {
> +        s->is_crash_occurred_cpu = 1;
> +    }
>   }
>   
>   static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,



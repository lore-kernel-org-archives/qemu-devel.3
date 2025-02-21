Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10971C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 03:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlJrX-0004Wt-QK; Thu, 20 Feb 2025 22:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tlJrS-0004Vw-6N; Thu, 20 Feb 2025 22:38:01 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1tlJrN-0007nB-RZ; Thu, 20 Feb 2025 22:37:56 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxzOIG9bdnDQZ9AA--.19219S3;
 Fri, 21 Feb 2025 11:37:43 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxu8QD9bdn+5UfAA--.50842S3;
 Fri, 21 Feb 2025 11:37:41 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/gdbstub: Fix gdbstub incorrectly
 handling register R32
From: bibo mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, Wanglei <wanglei@loongson.cn>,
 qemu-stable@nongnu.org
References: <20250218032027.4137453-1-maobibo@loongson.cn>
Message-ID: <dbc7759f-8207-2035-73d6-2d0a6410f513@loongson.cn>
Date: Fri, 21 Feb 2025 11:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250218032027.4137453-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8QD9bdn+5UfAA--.50842S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw45XFWUJr4UKF4kury7CFX_yoW8WFW5p3
 4xCw1DKw45trZrtan3Xa98X3WDXr1fGwsIvan7J34rCrnxX3WrWF4kK3sFgFs5J39rtF1F
 qr1Fv34Uuay2yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.31,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued in loongarch-next with title and changelog changed as follows:

target/loongarch/gdbstub: Fix gdbstub incorrectly handling some registers
   Write operation with R32 (orig_a0) and R34 (CSR_BADV) is discarded on

Regards
Bibo Mao

On 2025/2/18 上午11:20, Bibo Mao wrote:
> Write operation with R32 (orig_a0) and R32 (CSR_BADV) is discarded on
> gdbstub implementation for LoongArch system. And return value should
> be register size rather than 0, since it is used to calculate offset of
> next register such as R33 (PC) in function handle_write_all_regs().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ca61e75071c6 ("target/loongarch: Add gdb support.")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/gdbstub.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
> index dafa4feb75..471eda28c7 100644
> --- a/target/loongarch/gdbstub.c
> +++ b/target/loongarch/gdbstub.c
> @@ -63,23 +63,24 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       CPULoongArchState *env = cpu_env(cs);
>       target_ulong tmp;
> -    int read_length;
>       int length = 0;
>   
> +    if (n < 0 || n > 34) {
> +        return 0;
> +    }
> +
>       if (is_la64(env)) {
>           tmp = ldq_le_p(mem_buf);
> -        read_length = 8;
> +        length = 8;
>       } else {
>           tmp = ldl_le_p(mem_buf);
> -        read_length = 4;
> +        length = 4;
>       }
>   
>       if (0 <= n && n < 32) {
>           env->gpr[n] = tmp;
> -        length = read_length;
>       } else if (n == 33) {
>           set_pc(env, tmp);
> -        length = read_length;
>       }
>       return length;
>   }
> 
> base-commit: db7aa99ef894e88fc5eedf02ca2579b8c344b2ec
> 



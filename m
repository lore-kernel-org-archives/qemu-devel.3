Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32550E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 08:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN6YH-0000aE-5w; Mon, 16 Dec 2024 03:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tN6YF-0000Zs-9g; Mon, 16 Dec 2024 03:34:03 -0500
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tN6YD-0003ft-8A; Mon, 16 Dec 2024 03:34:03 -0500
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id B6CCA4F7AC1D;
 Mon, 16 Dec 2024 09:33:41 +0100 (CET)
Message-ID: <0f098c77-3f23-4f9a-82ba-8cffdfdf38fa@lauterbach.com>
Date: Mon, 16 Dec 2024 09:33:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] riscv/gdbstub: add V bit to priv reg
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alex.bennee@linaro.org
References: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1734338021754
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 15.12.2024 22:37, Yanfeng Liu wrote:
> This adds virtualization mode (V bit) as bit(2) of register `priv`
> per RiscV debug spec v1.0.0-rc4. Checked with gdb-multiarch v12.1.
> 
> Note that GDB may display `INVALID` tag for `priv` reg when V bit
> is set, this doesn't affect actual access to the bit though.
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   target/riscv/gdbstub.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index c07df972f1..18e88f416a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
>   
> -        return gdb_get_regl(buf, env->priv);
> +        /* Per RiscV debug spec v1.0.0 rc4 */
> +        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
> +
> +        return gdb_get_regl(buf, env->priv | vbit);
>   #endif
>       }
>       return 0;
> @@ -226,10 +229,22 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
>   
> -        env->priv = ldtul_p(mem_buf) & 0x3;
> -        if (env->priv == PRV_RESERVED) {
> -            env->priv = PRV_S;
> +        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
> +        bool new_virt = 0;
> +
> +        if (new_priv == PRV_RESERVED) {
> +            new_priv = PRV_S;
> +        }
> +
> +        if (new_priv != PRV_M) {
> +            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
>           }
> +
> +        if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
> +            riscv_cpu_swap_hypervisor_regs(env);
> +        }
> +
> +        riscv_cpu_set_mode(env, new_priv, new_virt);
>   #endif
>           return sizeof(target_ulong);
>       }

Thanks for the submission, it works as expected:

(gdb) info register $priv
priv           0x4      prv:4 [INVALID]
(gdb) info register $sstatus
sstatus        0x200004022      8589951010
(gdb) set $priv = 0x0
(gdb) info register $priv
priv           0x0      prv:0 [User/Application]
(gdb) info register $sstatus
sstatus        0x8000000200006022       -9223372028264816606
(gdb) set $priv = 0x4
(gdb) info register $priv
priv           0x4      prv:4 [INVALID]
(gdb) info register $sstatus
sstatus        0x200004022      8589951010



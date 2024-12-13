Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1A0E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1c7-0002f2-Df; Fri, 13 Dec 2024 04:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tM1c0-0002ek-Mc; Fri, 13 Dec 2024 04:05:28 -0500
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1tM1bn-0006WS-Lq; Fri, 13 Dec 2024 04:05:28 -0500
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 00AB1426D093;
 Fri, 13 Dec 2024 10:04:55 +0100 (CET)
Message-ID: <5d28f5aa-bb59-4198-a6ff-495a0ea9a16a@lauterbach.com>
Date: Fri, 13 Dec 2024 10:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: Re: [PATCH v3] riscv/gdb: add V bit to priv register
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alex.bennee@linaro.org
References: <tencent_D006B250779A0740A99BB51DA4A8F95EBF07@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_D006B250779A0740A99BB51DA4A8F95EBF07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1734080695009
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

Hi,

apologies for the delayed review; I've just gotten to it now.

On 06.12.2024 01:14, Yanfeng Liu wrote:
> This adds virtualization mode (V bit) as bit(2) of register `priv`
> per RiscV debug spec v1.0.0-rc3. Checked with gdb-multiarch v12.1.
> 
> Note that GDB may display `INVALID` tag for the value when V bit
> is set, this doesn't affect accessing to the bit.
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   target/riscv/gdbstub.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index c07df972f1..8cc095cda3 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
>   
> -        return gdb_get_regl(buf, env->priv);
> +        /* Per RiscV debug spec v1.0.0 rc3 */

Now that rc4 is released, you might also cite "RISC-V Debug
Specification v1.0.0 rc4".

> +        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
> +
> +        return gdb_get_regl(buf, env->priv | vbit);
>   #endif
>       }
>       return 0;
> @@ -230,6 +233,8 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
>           if (env->priv == PRV_RESERVED) {
>               env->priv = PRV_S;
>           }
> +        env->virt_enabled = (env->priv == PRV_M) ? 0 :
> +                            ((ldtul_p(mem_buf) & BIT(2)) >> 2);

Looking at the other places in the source code where virt_enabled is 
set, we should also check here if the H extension is active.
Alternatively, you might also consider using riscv_cpu_set_mode():

Message-ID: <20240711-smcntrpmf_v7-v8-1-b7c38ae7b263@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:04 -0700
Subject: [PATCH v8 01/13] target/riscv: Combine set_mode and set_virt 
functions.
From: Atish Patra <atishp@rivosinc.com>

>   #endif
>           return sizeof(target_ulong);
>       }

In addition, we need to swap the virtual supervisor registers from the H 
extension, e.g. vsstatus:

"When V=1, vsstatus substitutes for the usual sstatus, so instructions 
that normally read or modify sstatus actually access vsstatus instead." 
(privileged spec)

With the current patch, I was able to read and modify V, but the 
registers were not changing:

(gdb) info register $priv
priv           0x4      prv:4 [INVALID]
(gdb) info register $sstatus
sstatus        0x200004022      8589951010
(gdb) set $priv = 0x0
(gdb) info register $priv
priv           0x0      prv:0 [User/Application]
(gdb) info register $sstatus
sstatus        0x200004022      8589951010

Take a look at riscv_cpu_swap_hypervisor_regs() which I believe does the 
thing we need here. Note that the function is supposed be called before 
the mode switch.



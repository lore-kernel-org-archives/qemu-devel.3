Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB61C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrVAO-00024L-Bf; Wed, 05 Aug 2026 02:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrVAI-00024C-Mn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:31:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrVAD-0005II-R3
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:31:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6756VKO0031308
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Aug 2026 15:31:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=66OqmjzRlTufnbZFzjwt9xZOU3R2KpgVlZDMV2fJz7c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785911480; v=1;
 b=syuFxb794IEOEnoPeWvpzPiLXgjN3604lHD3dH0mYXtEFlafH+9LtYtMvdVaKot8
 qmEr/nA0OLtFZOUo8EDoD+6R4/3QgPYsutb0oXVw3BXddSii06+Cv+/ETvPiAZWI
 nQDZLsveqXw7DssBFjGXXFPE1Cj48r8bRQN9d/HYn7XY353a0oXqIVIHsB1poqj4
 xkV4FqdKLWLVT8okqGCjoOpPvVX6P4bEIx80s5hjUfChyMCQCkY6JTuaYe7hphvE
 E1Ycc3qnK8R0Tk3s+yV14xErYYGYqiP6PYf1273K1XxaY6+F6S1IXRG3oDM4+F93
 x0s2ihKo+lg2bbuuMrfKWg==
Message-ID: <1a682d10-25a6-4de7-b0ad-e72c7fd75b2c@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 5 Aug 2026 15:31:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] elf2dmp: fill ContextBuffer with faulting CPU context
To: =?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?= <zhengrong.lzr@alibaba-inc.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, viktor.prutyanov@phystech.edu, zhao1.liu@intel.com
References: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
 <20260722014840.36671-3-zhengrong.lzr@alibaba-inc.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260722014840.36671-3-zhengrong.lzr@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/07/22 10:48, 李峥嵘(村叔) wrote:
> When is_crash_occurred_cpu is set in QEMUCPUState (version > 1),
> copy that CPU's context into WinDumpHeader64 ContextBuffer so
> WinDbg opens on the faulting CPU instead of CPU 0.
> 
> Also extract KiBugCheckData from the guest kernel to populate
> BugcheckCode and BugcheckParameters in the dump header.
> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
> ---
>   contrib/elf2dmp/kdbg.h |  9 +++++++++
>   contrib/elf2dmp/main.c | 32 ++++++++++++++++++++++++++++++--
>   2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
> index 002e3d0cd5..15e4fb1140 100644
> --- a/contrib/elf2dmp/kdbg.h
> +++ b/contrib/elf2dmp/kdbg.h
> @@ -195,4 +195,13 @@ typedef struct KDDEBUGGER_DATA64 {
>       uint16_t OffsetPrcbContext;
>   } KDDEBUGGER_DATA64;
>   
> +typedef struct KIBUGCHECK_INFO {
> +    uint32_t BugcheckCode;
> +    uint32_t unused0;
> +    uint64_t BugcheckParameter1;
> +    uint64_t BugcheckParameter2;
> +    uint64_t BugcheckParameter3;
> +    uint64_t BugcheckParameter4;
> +} KIBUGCHECK_INFO;
> +
>   #endif /* KDBG_H */
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index a62abadcc0..302601065b 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -338,7 +338,7 @@ static bool fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
>    * A dump may still contain valuable information even if it lacks contexts of
>    * some CPUs due to dump corruption or a failure before starting CPUs.
>    */
> -static void fill_context(KDDEBUGGER_DATA64 *kdbg,
> +static void fill_context(WinDumpHeader64 *hdr, KDDEBUGGER_DATA64 *kdbg,
>                            struct va_space *vs, QEMU_Elf *qe)
>   {
>       int i;
> @@ -373,6 +373,10 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
>               eprintf("Failed to fill CPU #%d context\n", i);
>               continue;
>           }
> +
> +        if (s->version > 1 && s->is_crash_occurred_cpu) {

version > 1 does not prove byte 440 exists. init_states() in
contrib/elf2dmp/qemu_elf.c accepts shorter descriptors and then discards 
their validated size, so a truncated version-2 note can read beyond its 
descriptor. Please check what's done for kernel_gs_base.

> +            memcpy(hdr->ContextBuffer, &ctx, sizeof(ctx));
> +        }

ContextBuffer is populated only after PRCB lookup, ContextFrame
lookup, and guest-memory patching all succeed. Partial dumps therefore
lose the header context even though the QEMU note already contains the
faulting CPU registers. Please select the header context before those
best-effort operations.

>       }
>   }
>   
> @@ -512,6 +516,7 @@ int main(int argc, char *argv[])
>       uint64_t KdVersionBlock;
>       bool kernel_found = false;
>       OMFSignatureRSDS rsds;
> +    uint64_t KiBugCheckData;
>   
>       if (argc != 3) {
>           eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
> @@ -611,7 +616,30 @@ int main(int argc, char *argv[])
>           goto out_kdbg;
>       }
>   
> -    fill_context(kdbg, &vs, &qemu_elf);
> +    if (!SYM_RESOLVE(KernBase, &pdb, KiBugCheckData)) {
> +        eprintf("Failed to get KiBugCheckData.\n");
> +    } else {
> +        KIBUGCHECK_INFO data = { 0 };
> +        if (va_space_rw(&vs, KiBugCheckData, &data, sizeof(data), 0)) {
> +            header.BugcheckCode = data.BugcheckCode;

patch_bugcheck_data() in dump/win_dump-x86.c fills BugcheckCode with 
LIVE_SYSTEM_DUMP when BugcheckCode is zero. Perhaps we may do the same 
here too.

> +            header.BugcheckParameter1 = data.BugcheckParameter1;
> +            header.BugcheckParameter2 = data.BugcheckParameter2;
> +            header.BugcheckParameter3 = data.BugcheckParameter3;
> +            header.BugcheckParameter4 = data.BugcheckParameter4;
> +
> +            printf("KiBugCheckData: 0x%016" PRIx64
> +                   ", BugcheckCode: 0x%08x, Args:"

Let's use PRIx32.

Regards,
Akihiko Odaki

> +                   " 0x%016" PRIx64 " 0x%016" PRIx64
> +                   " 0x%016" PRIx64 " 0x%016" PRIx64 "\n",
> +                    KiBugCheckData, header.BugcheckCode,
> +                    data.BugcheckParameter1, data.BugcheckParameter2,
> +                    data.BugcheckParameter3, data.BugcheckParameter4);
> +        } else {
> +            eprintf("Failed to va_space_rw KiBugCheckData.\n");
> +        }
> +    }
> +
> +    fill_context(&header, kdbg, &vs, &qemu_elf);
>   
>       if (!write_dump(&ps, &header, argv[2])) {
>           eprintf("Failed to save dump\n");



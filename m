Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79637C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBAOe-00057W-V6; Sat, 03 May 2025 06:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBAOc-000575-Ma
 for qemu-devel@nongnu.org; Sat, 03 May 2025 06:47:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBAOa-0006qO-6H
 for qemu-devel@nongnu.org; Sat, 03 May 2025 06:47:02 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A57BF55D26C;
 Sat, 03 May 2025 12:46:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 53dVJEWUMVC9; Sat,  3 May 2025 12:46:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF17155D267; Sat, 03 May 2025 12:46:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AD619745682;
 Sat, 03 May 2025 12:46:53 +0200 (CEST)
Date: Sat, 3 May 2025 12:46:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, wei.liu@kernel.org
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
In-Reply-To: <20250502214841.242584-3-pbonzini@redhat.com>
Message-ID: <e3fe51ee-5953-e8f1-42b9-95cd857ed9da@eik.bme.hu>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
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

On Fri, 2 May 2025, Paolo Bonzini wrote:
> decode->op[N].ptr can contain either a host pointer (!) in CPUState
> or a guest virtual address.  Pass the whole struct to read_val_ext
> and write_val_ext, so that it can decide the contents based on the
> operand type.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> target/i386/emulate/x86_decode.h |   9 ++-
> target/i386/emulate/x86_emu.h    |   8 +--
> target/i386/emulate/x86_decode.c |  74 +++++++++----------
> target/i386/emulate/x86_emu.c    | 119 ++++++++++++++++---------------
> 4 files changed, 109 insertions(+), 101 deletions(-)
>
> diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
> index 87cc728598d..497cbdef9c7 100644
> --- a/target/i386/emulate/x86_decode.h
> +++ b/target/i386/emulate/x86_decode.h
> @@ -266,7 +266,10 @@ typedef struct x86_decode_op {
>     int reg;
>     target_ulong val;
>
> -    target_ulong ptr;
> +    union {
> +        target_ulong addr;
> +        void *regptr;
> +    };
> } x86_decode_op;
>
> typedef struct x86_decode {
> @@ -301,8 +304,8 @@ uint64_t sign(uint64_t val, int size);
>
> uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
>
> -target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
> -                         int is_extended, int size);
> +void * get_reg_ref(CPUX86State *env, int reg, int rex_present,
> +                    int is_extended, int size);

Stray space after *, checkpatch should have cought it.

Regards,
BALATON Zoltan


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X76GSpGD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJQw-0000ei-V2; Tue, 17 Nov 2026 08:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJPx-0008Gl-8N
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJPv-0003WR-AG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rPCROzIKBBfGv4lGfsY5OoMLFosb0AZ/GALWvKe1Aig=;
 b=X76GSpGDm4/dc9RRtl7TqoziOuXdsT7HGqtSyPtR5pfJdnQzyQchxh+FoIESVZXaHr7YbP
 Ahc9oyaxX8i1fD5Apwk7Xau1hJpdtmU9Ht1WO/GQGj5VQLPJvSTo96i0uz4Ecb/3o1MdZQ
 xnQiYrToUEyIicywp6eoLd11Jm+g77w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-_TFsqOpaOg6Y2WAeyGAppg-1; Tue,
 17 Nov 2026 08:40:09 -0500
X-MC-Unique: _TFsqOpaOg6Y2WAeyGAppg-1
X-Mimecast-MFC-AGG-ID: _TFsqOpaOg6Y2WAeyGAppg_1794922808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482C31956062; Tue, 17 Nov 2026 13:40:08 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FD6A1956087; Tue, 17 Nov 2026 13:40:07 +0000 (UTC)
Message-ID: <9b284e2c-fe31-43cb-af2c-fca0a4dca310@redhat.com>
Date: Tue, 17 Nov 2026 14:40:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: validate MOV CR0 writes
To: Neuro <neurosaki987@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <CA+6vzYSxSR-B+a1friO6oDDXXpt2DZ6C1jEKiUFLJPPR2BuntA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CA+6vzYSxSR-B+a1friO6oDDXXpt2DZ6C1jEKiUFLJPPR2BuntA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 13:54, Neuro wrote:
> Guest MOV CR0 under x86 TCG can complete without the architecturally
> required #GP(0) for three invalid writes:
> 
> 1. Setting any bit in CR0[63:32] from 64-bit code. The operand reaches
>     cpu_x86_update_cr0() through a uint32_t parameter, silently discarding
>     these bits.
> 2. Writing CR0.PG=1 with CR0.PE=0.
> 3. Clearing CR0.PG while executing in 64-bit code (CS.L=1).
> 
> This patch addresses a specific CR0 subset of the broader CR0/CR4
> validation problem reported in:
> https://gitlab.com/qemu-project/qemu/-/issues/3294
> 
> That issue already identifies the lack of input validation in
> cpu_x86_update_cr0() and cpu_x86_update_cr4(), explicitly including
> the invalid PG=1 with PE=0 case handled here.
> 
> Implementation:
> 
> Adds nine lines in target/i386/tcg/system/misc_helper.c, inside the
> CR0 case of HELPER(write_crN).
> 
> Three checks reject non-zero CR0[63:32], PG=1 with PE=0, and clearing
> PG in 64-bit code. They trigger #GP(0) after the existing SVM selective
> intercept and before the actual CR0 update.
> 
> - The high-half check is compiled only for TARGET_X86_64.
> - Uses HF_CS64_MASK for the paging-clear condition. Checking LMA alone
>    would incorrectly reject a legitimate compatibility-mode exit from
>    long mode.
> - Raises EXCP0D_GPF with error code zero and GETPC() before updating
>    architectural state, ensuring atomicity.
> 
> For example, MOV CR0, RAX that clears PG from 64-bit code now faults at
> that instruction, leaving CR0/CR3/CR4/EFER and the source RAX unchanged.
> Switching to compatibility mode before clearing PG still succeeds.
> 
> Architectural reference:
> 
> Intel 64 and IA-32 Architectures Software Developer's Manual, combined
> volumes, 325462-093US, September 2026:
> - MOV control-register instruction: combined-PDF pages 1321 and 1323.
> - Volume 3A, section 5.1.2: combined-PDF page 3263.
> 
> Validation:
> 
> Base: 97c88c61d45dee6e1f9bc160a338048189846d28 (11.1.90)
> Tested commit: 01ffa5267193c62e1100091e8f9c83b237303fa3
> Host/build: native Windows, x86_64-softmmu TCG, MSYS2 UCRT64 toolchain.
> 
> - Invalid-write differential (102 cases): across max/Haswell configs
>    with 4/5-level paging, 102/102 probes now correctly raise #GP(0);
>    the baseline missed all 102. ROM SHA256 was compared to verify
>    identical inputs. Targets include a noncanonical-access #GP(0)
>    positive control, no-op CR0 writes and legal WP toggles, checking
>    error code zero, exact fault RIP, retained source RAX and unchanged
>    CR0/CR3/CR4/EFER.
> - Legal-behavior differential (6 VM runs): all passed, covering
>    compatibility-mode MOV CR0,EAX with nonzero RAX[63:32], WP toggles,
>    legal compatibility-mode PG clear, legal PE clear after PG=0, and
>    normal long-mode entry/exit. Guest output and exit status matched.
> - Project tests: 180 passed, 4 skipped, 1 failed. checkpatch.pl reported
>    zero errors and zero warnings. git diff --check passed.
>    The single Meson failure is netdev-socket (Broken pipe in the Unix
>    stream reconnect subtest), reproduced identically on the unmodified
>    baseline and on a clean separate checkout. It uses -M none -accel
>    qtest without guest CPU execution and is unrelated to this CR0 change.
> 
> Review boundaries:
> 
> Please review the fault conditions, compatibility-mode operand width,
> fault atomicity and intercept ordering. Standalone i386-softmmu, nested
> SVM, physical hardware/KVM and other invalid CR0 combinations remain
> unverified.
> 
> Signed-off-by: NeuroSaki987 <neurosaki987@gmail.com>

It must have taken so long to write all this text...

Paolo

> ---
>   target/i386/tcg/system/misc_helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/i386/tcg/system/misc_helper.c
> b/target/i386/tcg/system/misc_helper.c
> index a77da59..eebc4b3 100644
> --- a/target/i386/tcg/system/misc_helper.c
> +++ b/target/i386/tcg/system/misc_helper.c
> @@ -87,6 +87,15 @@ void HELPER(write_crN)(CPUX86State *env, int reg,
> target_ulong t0)
>               ((env->cr[0] ^ t0) & ~(CR0_TS_MASK | CR0_MP_MASK))) {
>               cpu_vmexit(env, SVM_EXIT_CR0_SEL_WRITE, 0, GETPC());
>           }
> +#ifdef TARGET_X86_64
> +        if (t0 & ~0xffffffffULL) {
> +            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
> +        }
> +#endif
> +        if (((t0 & CR0_PG_MASK) && !(t0 & CR0_PE_MASK)) ||
> +            ((env->hflags & HF_CS64_MASK) && !(t0 & CR0_PG_MASK))) {
> +            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
> +        }
>           cpu_x86_update_cr0(env, t0);
>           break;
>       case 3:
> --
> 2.39.2



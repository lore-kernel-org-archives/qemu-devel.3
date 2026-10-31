Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d/4sLOxi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Xf-0006Mi-WF; Sat, 31 Oct 2026 04:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xN4XE-0006KC-QV
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xN4XC-0002FO-Sz
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793435633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6yYrwe8VcM3t/AoMV/ywyfTTjXOmLf8bZtCG9ZI51vM=;
 b=d/4sLOxihnSrhbT/smHXfbNa7MhPgjI0iwpPMmzQMzL8dnCfGgYJiw+g1psgGw3A31euGX
 3wqbSTOd1F8Bx7LbaXEHxXt2xPnOT+hoLPB/aBLAIp52wb5LV7jnXOUQjLzAAYfftYayaU
 ZJ//sHP8iWU0fYLYzm6ZDcTHd8Hxeag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Rw0Cg_PPMZKbDnIdAy2XPA-1; Sat,
 31 Oct 2026 04:33:51 -0400
X-MC-Unique: Rw0Cg_PPMZKbDnIdAy2XPA-1
X-Mimecast-MFC-AGG-ID: Rw0Cg_PPMZKbDnIdAy2XPA_1793435630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 468011955D81; Sat, 31 Oct 2026 08:33:50 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCA4F1800444; Sat, 31 Oct 2026 08:33:23 +0000 (UTC)
Message-ID: <050e339c-e1a3-442a-91fa-1f79aa9ae9c1@redhat.com>
Date: Sat, 31 Oct 2026 09:33:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
To: Andrey Polivoda <apolivodaa433@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20261016122113.226920-1-apolivodaa433@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261016122113.226920-1-apolivodaa433@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/26 14:21, Andrey Polivoda wrote:
> According to both Volume 2B of Intel 64 and IA-32 Architectures Software
> Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
> VPINSRW instruction can be encoded with VEX prefix only when VEX.pp == 0b01
> (which implies 0x66 prefix).
> 
> Currently, QEMU allows decoding VPINSRW with either VEX.pp == 0b00
> (which implies that no prefix is used) or VEX.pp == 0b01.

This is not just VPINSRW, all MMX instructions have the same issue.

I have sent "target/i386/tcg: reject VEX.NP for MMX instructions" 
(https://patchew.org/QEMU/20261031082849.1306244-1-pbonzini@redhat.com/), 
which I already had written but never managed to send.

Thanks,

Paolo


> The first case allows the guest code to crash QEMU, since vector_len()
> returns 8 in this case, causing the following assertion failure:
> ../target/i386/tcg/emit.c.inc:3092: void gen_pinsr(DisasContext *, X86DecodedInsn *, MemOp): Assertion `vec_len == 16' failed.
> 
> Real hardware, however, simply raises a #UD exception when executing VPINSRW
> with VEX.pp == 0b00.
> 
> This patch fixes this issue by modifying the decoder table entry for PINSRW
> to require the use of 0x66 prefix when VEX prefix is used.
> 
> Fixes: aba2b8ecb905 ("target/i386: reimplement 0x0f 0xc2, 0xc4-0xc6, add AVX")
> Cc: qemu-stable@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
> ---
> Note: checkpatch.pl reported a few errors:
> 1. Decoder table entry line being longer than 80 characters
> 2. Missing space after colons at the decoder table entry line
> These seem to be false positives, since the affected line follows
> the style of the decoder table entries.
> 
>   target/i386/tcg/decode-new.c.inc | 12 +++++++++++-
>   target/i386/tcg/decode-new.h     |  1 +
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 3845fab5c8..5b9a4b4fa1 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -290,6 +290,8 @@
>   #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
>   #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
>   
> +#define vex_p_66 .vex_valid_prefix = P_66,
> +
>   #define UNKNOWN_OPCODE ((X86OpEntry) {})
>   
>   #define X86_MAX_INSN_LENGTH 15
> @@ -1391,7 +1393,7 @@ static const X86OpEntry opcodes_0F[256] = {
>       [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
>       [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
>       [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
> -    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
> +    [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66 vex_p_66),
>       [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
>       [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
>       [0xc7] = X86_OP_GROUP0(group9),
> @@ -2760,6 +2762,9 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
>   
>           /* fallthrough */
>       default:
> +        if ((s->prefix & (PREFIX_VEX | PREFIX_EVEX)) && e->vex_valid_prefix) {
> +            break;
> +        }
>           if (!e->valid_prefix) {
>               return true;
>           }
> @@ -2772,6 +2777,11 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
>   
>       /* Now, either zero or one bit is set in sse_prefixes.  */
>       sse_prefixes = s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA);
> +
> +    if ((s->prefix & (PREFIX_VEX | PREFIX_EVEX)) && e->vex_valid_prefix) {
> +        return e->vex_valid_prefix & (1 << sse_prefixes);
> +    }
> +
>       return e->valid_prefix & (1 << sse_prefixes);
>   }
>   
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index 5f76b0c1b7..d021754d9a 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -325,6 +325,7 @@ struct X86OpEntry {
>       unsigned     vex_class:8;
>       X86VEXSpecial vex_special:8;
>       unsigned     valid_prefix:16;
> +    unsigned     vex_valid_prefix:16;
>       unsigned     check:16;
>       unsigned     intercept:8;
>       bool         has_intercept:1;



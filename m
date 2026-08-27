Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5299AC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzjbo-0001Sp-96; Thu, 27 Aug 2026 19:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzjbm-0001O7-OI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 19:34:10 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzjbk-0000F6-Tj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 19:34:10 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso436168a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787873647; x=1788478447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x8U1HGO4ntsRB94xWkG6RdwbkZEn6L+guYsMW38dCig=;
 b=EMA7Coj9E2Q4hbdOziy5EQNJho4eh0NygxMtIEhRNSFiRZx/zj4Vm/qNWsxzzv5dPf
 ip6hCfaSRd3g0g2j9vrlADIGEXm4RkYi+8maBGgAclgch/47V8jp3s81qvqkSf/v88GI
 32G5cIpYSZd9uDHSMonlkbUDpBm3WKHcx19oH5XndIAtwEFtJvSzV4m2+DGW5vxJ3Zx2
 CpKBiF6c7iIQcRSUfVmE0b+HySjX6GXdEdWGfslCOZjuuqKSlOp+ubHQxRp061L11jWn
 70gj3um6UV5n/8el0GXM5Q7UoLrnHmUg8G8YPO4TRSqeTm9c2ULVXZRGQun8Xb9VGqJK
 pY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787873647; x=1788478447;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x8U1HGO4ntsRB94xWkG6RdwbkZEn6L+guYsMW38dCig=;
 b=qQCNF1p0YnxfIGhjmVQJdN4YftN8I/LFnGBcrBrBTRw5I7moROS+KgLmbbV7OMkPaU
 ZpwqoBAz2s6tQoFo6Fx/r1uh05Pi7Ys3po4144D1dN9+UHOe97EsLythDnnVgPDkRc3G
 IXeJvDyifT5AOeQABngxaMRiU1Zvfmvy1gpR383OwqS10nqNUgWDLoUqsrmJv2NhXthg
 jcydHyV7K61cK2imfarPbunymQzrrlwSnFVv/I0XbIIY7AC9BatZswnPlAkCnuwaw0E5
 n/XB92s1gHpgV6ZDrcLiBULTgPeA2qhPqM5lJM7cWwr9Eas2VJeUYqma4JcxmXzSAvLZ
 48gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBJFxpjdYgFsduAJnH7Wp2ffpu1JRQ91yNOPcJYM4hlOMy6j3sUIf0ZlqO6T8yVqI5fzogKgg0e6s3@nongnu.org
X-Gm-Message-State: AFuF++lF6Z13vXOJJjKaTA5JW+WY73WeVw0tnZPOdOE+x+bEcET8FBMw
 gVsFRsrzZYjr1g8j04ycACgKeYseRzwxTv8H5KXmHe6zNJHHKjdpeNRI0/PRWrPFDD4=
X-Gm-Gg: AR+sD119mqdbfrrYj3gMJEA04kqfximTGQMs3/wvEpewF8rLxhyf6A2ly6mtRxRT0+8
 mbVY71kfzKg1xYwx9lbWI/0sGKNWAAfMofSNPeQb9BVU3LAyzpBVj4tr57+1GFvvYc4ncagaTKl
 wqoTF66MrrYhKmcJRT7e0/Q61WttUcbv/qwzEq2qW3GlWmn/5324dmyEwV638A4F3orduurJy0+
 ReZ6A09YtUOQAUCjoeSfYhTtjHDV0JjYOXQUZCa3k8eQecYQFwSgGFYMwhECmSkA1UVbTqDQDg+
 hvt3ZNO2VrCWRrtHPS9s4fgC2yEFrz3AQQNLD8geGkg79yRrgstJ12w+kOfOkzrNiA5FInvTVkm
 1wQqjpN8y5KWia/SvEaSx/Qw+1WcekvV7PGcISnD75qkl77uaRbhlyH9sZru9S5CdlyBik9AzF1
 JBum9TjcnsFvv57+nfrVBONYE5IGAcDHZxReTXQVNVmczuJ2KxcNBIL8FjQeRrwpoz/6OrWQoai
 7LZoigFpPG9DwzHdNpCWkLdGVpw
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-396d0e27e11mr5472987a91.1.1787873646734; 
 Thu, 27 Aug 2026 16:34:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm4831948a91.12.2026.08.27.16.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 16:34:06 -0700 (PDT)
Message-ID: <b6265b43-8f26-4703-9ca1-88214c06905a@linaro.org>
Date: Thu, 27 Aug 2026 16:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] RFC: tcg: probe the TB jump cache inline instead
 of calling a helper
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-7-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827050241.3713332-7-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/26/26 22:02, Matt Turner wrote:
> +static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *tb)
> +{
> +    TCGv_ptr jc, ent, tbp, ptr;
> +    TCGv_i64 h, tmp;
> +    TCGLabel *slow;
> +    uint64_t fpair;
> +
> +    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
> +    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
> +    /* One 64-bit load has to cover both, so they must be adjacent... */
> +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
> +                      offsetof(TranslationBlock, flags) + 4);
> +    /* ...and aligned, which nothing else currently relies on. */
> +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) % 8 != 0);
> +
> +    jc = tcg_temp_ebb_new_ptr();
> +    ent = tcg_temp_ebb_new_ptr();
> +    tbp = tcg_temp_ebb_new_ptr();
> +    ptr = tcg_temp_ebb_new_ptr();
> +    h = tcg_temp_ebb_new_i64();
> +    tmp = tcg_temp_ebb_new_i64();
> +    slow = gen_new_label();
> +
> +    /* ent = &jc->array[tb_jmp_cache_hash_func(pc)] */
> +    gen_jmp_cache_hash(h, pc);
> +    tcg_gen_shli_i64(h, h, 4);
> +
> +    /*
> +     * Not cpu->tb_jmp_cache: the probe reads its own base so that the main
> +     * loop can poison it, which is how conditions the probe cannot test for
> +     * itself force every dispatch back into the helper.  See
> +     * tcg_cpu_sync_jmp_cache().
> +     */
> +    tcg_gen_ld_ptr(jc, tcg_env,
> +                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
> +    tcg_gen_trunc_i64_ptr(ent, h);
> +    tcg_gen_add_ptr(ent, jc, ent);
> +
> +    /*
> +     * The pc first: on a hash miss it is the field most likely to differ,
> +     * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
> +     */
> +    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
> +    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
> +
> +    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
> +    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
> +
> +    /*
> +     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
> +     * and compare covers both.
> +     */
> +#if HOST_BIG_ENDIAN
> +    fpair = ((uint64_t)tb->flags << 32) | tb->cflags;
> +#else
> +    fpair = ((uint64_t)tb->cflags << 32) | tb->flags;
> +#endif

I'd use

     fpair = (HOST_BIG_ENDIAN
              ? deposit64(tb->cflags, 32, 32, tb->flags)
              : deposit64(tb->flags, 32, 32, tb->cflags));

Whenever possible, avoid ifdefs to make sure all paths compile on every 
host.

> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
> +
> +    /*
> +     * cs_base is a second word of target-specific flags despite the name,
> +     * and the pc alone does not imply it on a target that uses it.
> +     */
> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, cs_base));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, tb->cs_base, slow);
> +
> +    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +
> +    /*
> +     * Emit a second goto_ptr rather than branching to a shared one: a temp
> +     * live across the label would be spilled and reloaded on every dispatch.
> +     */
> +    gen_set_label(slow);
> +    ptr = tcg_temp_ebb_new_ptr();
> +    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +}
This is pretty good.  As a follow-up I suspect we'll want a tcg backend 
expansion of this.  For instance:

   - x86_64 and s390x can use memory-operand comparisons.

   - aarch64
     - use shift-add insn for env_plus_off + h * 16.
     - use ldp to load (tb, pc) and (cs_base, flags) in one insn.
     - use ccmp to halve the number of branches.

etc.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2302C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzjHR-0001ob-SR; Thu, 27 Aug 2026 19:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzjHQ-0001oP-PH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 19:13:08 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzjHN-0004oE-Dn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 19:13:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d049069377so5145125ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787872383; x=1788477183; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JtM5kJ51Yc/0Y9wWnzG1BvXOOhvjG9Zp04Rv6YxYpsM=;
 b=TYVK4sWlqSRYHEabwd93+upyzFT6MoK2yZswEVFY4Ze+nbs5gRGQ63ZJS///YBI+hs
 qkOgYG7QSngEdJIkgGRdY7itTp6RVD5EGRb3R19yVirC2Et0O9E0nUxrBhEMPZ70xsUc
 OtwdCi08lRugABQtMAM9kv328dytomTeCQZauAHAjX3Gdtyc7bQ/W7a34wquq6rqEsfb
 mJmtoqXoscDO7M1eoUP4uFfUXScUwqLzFD4QjlNpPLtJPPjaqhv5HtXg7ndwSOciW6ZO
 9OEfglgX4QEJBRFgpzczi90uDDw8wSGvgk3YvjL0GETsfW6zkYtCjSbctOiswJwzmbSt
 3ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787872383; x=1788477183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JtM5kJ51Yc/0Y9wWnzG1BvXOOhvjG9Zp04Rv6YxYpsM=;
 b=mR7xS3KMih4Rh6UM5hZs32BBJapx/I4Zg185WHxSwmy69eFeyHaxNn2eaoa73FfoSb
 k/HrvikRa2FxDssZVXZFdJHjAXEW4c/YGeT1L8/9JjI3KqI/ojBnee1jWffFQnLPXXkX
 bQk2PRs42r9qJkjsiDpo+scjwX6bdIm7iMu31oFKMfEm8oz/hih7GhwNenLlsEnfMCAu
 r9hhBmu4q6XXdsI1H7mo1awIbmWlsoYhRndHJ7KJizZHFMAykaGQsWwb8+zgpHi554Ux
 g9lqVNeoW3qFFVFeIS3qSiJRCtY6vp2k8ESyI+4gVWBtyYlWjNrb00+QYtkC8CU/jKDV
 /LsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU8AlE05MkReVaeu/Nav4mRsdXH3e9MFOuc8tg6ezrWuTBeUU5uciJv/WFI19JBuNHpX938Cmt/j8x@nongnu.org
X-Gm-Message-State: AFuF++ki6JbxXNBqqQxEIXZgUW65mDIILNQ9Jk+qD8Yv7TUD0/PHxeMo
 8t7qcSWpH6v97FmOuBDeyfRbTzqGSAId8eIsfm5Tv+NOJ42RMfDfBRT4HUHugxFR4Kc=
X-Gm-Gg: AR+sD105lD7tpGG23bHuJr/hwmG7vzXqf8JdJuBWxLaihg0zJ57fTWfWrS74MCr+TxT
 IyYGZmrXLqm5VzwSKwYJzKN9YsA0sj9UKEbkfdhiM2mDo0cqchaNz+RviefYIbn0tL2JcXsSwJZ
 W+TpVmO6haaYXlMD57beo7XAWSj18DuciNoVpeWXnzynFUL0EQmomNPsUwkCM7D1spIjVflaYVV
 z7rm9itEsU/2E87bTFQtd1EeSBt8XQNhvVbpqoq50lULijZ6qlwZ+7LzkkD2QyEmKk6Z1NchDpV
 dt37Y91tuzKhyG6dzZqy3XIH5TA3lmvEDJNmzDGCTYxsFVFS8RXHmpOyZKhk2QG3Pnnk+FbKKmE
 r8P1QPKDw3ROnIm53qK/45NtUkRT4oFK6T6RRIvYIvGBXZrBiOEspGCl8oagHq/O2CBLB+nTZMg
 P1E2+pm1Wy3i5ZRAQLo/jIh5mycEtEZ7LzxWURXq/JGsfdkocXkGFGrOloErBYPHMnplNFh5+wA
 f8VA1oXCcX6D3vY3FPchxPGd4P3
X-Received: by 2002:a17:902:f788:b0:2d7:40d1:e14a with SMTP id
 d9443c01a7336-2d74ce1cab4mr48554595ad.0.1787872383013; 
 Thu, 27 Aug 2026 16:13:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70498c8c6sm21140685ad.28.2026.08.27.16.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 16:13:02 -0700 (PDT)
Message-ID: <dcd678bb-83ca-4a41-8230-66fd72278bde@linaro.org>
Date: Thu, 27 Aug 2026 16:12:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] tcg: pass the destination to
 tcg_gen_lookup_and_goto_ptr()
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-5-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827050241.3713332-5-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> tcg_gen_lookup_and_goto_ptr() takes no arguments and emits a call to
> helper_lookup_tb_ptr(), which recovers the destination PC from env by
> calling back into the target through TCGCPUOps::get_tb_cpu_state(). At
> translation time the caller already has the destination PC in a temp, and
> knows the flags, cflags and cs_base any destination it may reach has to
> match, because they are the ones the block being generated was translated
> with.
> 
> Pass both, so that a later patch can use them to look the destination up
> inline. Nothing reads them yet and the generated code does not change.
> 
> The contract on @pc is the whole of the interface: it must hold exactly
> what get_tb_cpu_state() reports as the pc for the destination block. Five
> targets keep their PC in a temp whose value is that pc by construction and
> so can pass it: alpha, loongarch, mips, ppc and s390x. Everything else
> passes NULL and keeps today's behavior.
> 
> For six of those the TB pc is derived and passing the PC temp would be
> wrong: avr's TB pc is the word address doubled, i386's is eip before
> segmentation, riscv masks it to 32 bits when xl is MXL_RV32, hppa derives
> it from the IAQ, hexagon adjusts it inside a hardware loop, and sparc puts
> npc in cs_base. The remaining seven -- arm, m68k, microblaze, or1k, rx, sh4
> and tricore -- look like they could pass it, but I have not convinced
> myself of the contract for them and have nothing to test them with. Each is
> a one-line change for whoever wants it.
> 
> The common entry point takes a TCGTemp rather than a TCGv and reads the
> width from it, because the translators that are built for both values of
> TARGET_LONG_BITS -- arm, s390x, microblaze -- cannot include tcg-op.h.
> tcg-op.h wraps it for everyone else. This is the same split as
> tcg_gen_qemu_ld_*_chk().
> 
> v4: Split out of "tcg: probe the TB jump cache inline instead of calling a
>      helper", which did the API change and the inline probe in one patch.
>      Requested by Richard Henderson.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---

Ok, I was a bit surprised at your claim that only 5 targets qualify, as 
there are plenty that have a simple PC.

However! The subtlety of the interface, that we are asserting that the 
current TranslationBlock flags are still valid, now leads me to think 
that it's a mistake to adjust the current interface.

We need to introduce a new interface to which targets may be migrated. 
This won't be difficult, but it's not entirely trivial.

For instance, target/arm/ has

         case DISAS_UPDATE_NOCHAIN:
             gen_update_pc(dc, curr_insn_len(dc));
             /* fall through */
         case DISAS_JUMP:
             gen_goto_ptr();
             break;

where DISAS_UPDATE_NOCHAIN requires the helper because of state change 
and DISAS_JUMP does not.

This is subtle enough that we probably want to verify that the flags are 
unchanged with --enable-debug-tcg.

Perhaps tcg_gen_goto_jc_{i32,i64,tl)?

BTW:

> --- ./include/tcg/tcg-op.h
> +++ ./include/tcg/tcg-op.h
> @@ -49,6 +49,18 @@ typedef TCGv_i64 TCGv;
>  #error Unhandled TARGET_LONG_BITS value
>  #endif
>  
> +/*
> + * See tcg_gen_lookup_and_goto_ptr_tmp().  @pc may be NULL, for a target
> + * whose guest PC is not directly the key a destination block is found by.
> + * A translator that is built for more than one value of TARGET_LONG_BITS,
> + * and so cannot include this header, calls the _tmp() form directly.
> + */
> +static inline void
> +tcg_gen_lookup_and_goto_ptr(TCGv pc, const TranslationBlock *tb)
> +{
> +    tcg_gen_lookup_and_goto_ptr_tmp(pc ? tcgv_tl_temp(pc) : NULL, tb);
> +}
> +

This needs adjustment.  As we migrate binaries to single-binary, we 
start building bits of code once and stop relying on TARGET_LONG_BITS.
Notice where we include "tcg-op-common.h" instead of "tcg-op.h".

The simplest solution, IMO is to define functions for _i32 and _i64,
as for most everything else, and to have a _tl alias in tcg-op.h.


r~


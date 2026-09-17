Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6314AC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Inf-0006YQ-Kd; Thu, 17 Sep 2026 16:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7Ina-0006Xt-Us; Thu, 17 Sep 2026 16:33:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7InY-00045x-Ft; Thu, 17 Sep 2026 16:33:38 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68HKXDFh079285
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 05:33:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QtAJ/F433f/dMldZVGQ7McQrO8EIPVAwjghZix6O/FI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789677193; v=1;
 b=k98soOrJog9R6hMArHhru10KrHwYPQc1xAngZI0/ROOslL8LaM7ZegZLochZ/9DH
 rLrWoPvzsbEs9Wk1qrLMZ+iFI/yEtcgKN9jm01v++4BZEd7nlKqV1pYhnLTidSmV
 x2sLMRjZ1n7xRCYrGbXhiC6K01YVgsP1VKQZ9Irkc/XdVLiS1a1fP2M19wSh84Rj
 d4EQhFWrUb5p0aguKXb+25K2MbW9bwUltkrYC1kLNiQb7+IoSIluTHKLFJ5th2j3
 eKaWeyeXXnd6QVQPmp6oJbdx5dm6S+722A1kFQOiSY+wGlrLKBsGV3Igjo+l2AIP
 ZCsxGdcw1t71EyV2+FVk/w==
Message-ID: <1870813f-648f-47c5-b40a-14cba75f69af@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 05:33:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 03/10] target/arm/emulate: add load/store pair
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Lucas Amaral <lucaaamaral@gmail.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260916100021.73825-4-mohamed@unpredictable.fr>
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

On 2026/09/16 19:00, Mohamed Mediouni wrote:
> From: Lucas Amaral <lucaaamaral@gmail.com>
> 
> Add emulation for load/store pair instructions (DDI 0487 C3.3.14 --
> C3.3.16).  All addressing modes are covered: non-temporal (STNP/LDNP),
> post-indexed, signed offset, and pre-indexed.
> 
> Instruction coverage:
>    - STP/LDP (GPR): 32/64-bit pairs, all addressing modes
>    - STP/LDP (SIMD/FP): 32/64/128-bit pairs, all addressing modes
>    - LDPSW: sign-extending 32-bit pair load
>    - STGP: store allocation tag pair (tag operation is NOP for MMIO)
> 
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>   target/arm/emulate/a64-ldst.decode |  68 ++++++++++++++++++
>   target/arm/emulate/arm_emulate.c   | 111 +++++++++++++++++++++++++++++
>   2 files changed, 179 insertions(+)
> 
> diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
> index af6babe14a..f3de3f86cb 100644
> --- a/target/arm/emulate/a64-ldst.decode
> +++ b/target/arm/emulate/a64-ldst.decode
> @@ -10,6 +10,9 @@
>   # 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
>   &ldst_imm       rt rn imm sz sign w p unpriv ext u
>   
> +# Load/store pair (GPR and SIMD/FP)
> +&ldstpair       rt2 rt rn imm sz sign w p
> +
>   # Load/store register offset
>   &ldst           rm rn rt sign ext sz opt s
>   
> @@ -24,6 +27,9 @@
>   # Load/store unsigned offset (12-bit, handler scales by << sz)
>   @ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
>   
> +# Load/store pair: imm7 is signed, scaled by element size in handler
> +@ldstpair       .. ... . ... . imm:s7 rt2:5 rn:5 rt:5          &ldstpair
> +
>   # Load/store register offset
>   @ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
>   
> @@ -128,6 +134,68 @@ STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=
>   LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
>   LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
>   
> +### Load/store pair — non-temporal (STNP/LDNP)
> +
> +# STNP/LDNP: offset only, no writeback.  Non-temporal hint ignored.
> +STP             00 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +LDP             00 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +STP             10 101 0 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +LDP             10 101 0 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +STP_v           00 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +LDP_v           00 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +STP_v           01 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +LDP_v           01 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +STP_v           10 101 1 000 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
> +LDP_v           10 101 1 000 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
> +
> +### Load/store pair — post-indexed
> +
> +STP             00 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
> +LDP             00 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
> +LDP             01 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=1 w=1
> +STP             10 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
> +LDP             10 101 0 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
> +STP_v           00 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
> +LDP_v           00 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=1 w=1
> +STP_v           01 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
> +LDP_v           01 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
> +STP_v           10 101 1 001 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
> +LDP_v           10 101 1 001 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=1 w=1
> +
> +### Load/store pair — signed offset
> +
> +STP             00 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +LDP             00 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +LDP             01 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=0
> +STP             10 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +LDP             10 101 0 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +STP_v           00 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +LDP_v           00 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=0
> +STP_v           01 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +LDP_v           01 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +STP_v           10 101 1 010 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
> +LDP_v           10 101 1 010 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=0
> +
> +### Load/store pair — pre-indexed
> +
> +STP             00 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
> +LDP             00 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
> +LDP             01 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=1 p=0 w=1
> +STP             10 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
> +LDP             10 101 0 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
> +STP_v           00 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
> +LDP_v           00 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=2 sign=0 p=0 w=1
> +STP_v           01 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
> +LDP_v           01 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
> +STP_v           10 101 1 011 0 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
> +LDP_v           10 101 1 011 1 ....... ..... ..... .....        @ldstpair sz=4 sign=0 p=0 w=1
> +
> +### Load/store pair — STGP (store allocation tag + pair)
> +
> +STGP            01 101 0 001 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=1 w=1
> +STGP            01 101 0 010 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=0
> +STGP            01 101 0 011 0 ....... ..... ..... .....        @ldstpair sz=3 sign=0 p=0 w=1
> +
>   ### Load/store register — register offset
>   
>   # GPR
> diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
> index bf09e2a67b..6c63a0d0d1 100644
> --- a/target/arm/emulate/arm_emulate.c
> +++ b/target/arm/emulate/arm_emulate.c
> @@ -122,6 +122,117 @@ static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
>       return val;
>   }
>   
> +/*
> + * Load/store pair: STP, LDP, STNP, LDNP, STGP, LDPSW
> + * (DDI 0487 C3.3.14 -- C3.3.16)
> + */
> +
> +static bool trans_STP(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;                   /* 4 or 8 bytes */
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset; /* post-index: unmodified base */
> +    uint8_t buf[16];                           /* max 2 x 8 bytes */
> +
> +    uint64_t v1 = gpr_read(ctx, a->rt);
> +    uint64_t v2 = gpr_read(ctx, a->rt2);
> +    memcpy(buf, &v1, esize);
> +    memcpy(buf + esize, &v2, esize);
> +
> +    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDP(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[16];
> +    uint64_t v1 = 0, v2 = 0;
> +
> +    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +    memcpy(&v1, buf, esize);
> +    memcpy(&v2, buf + esize, esize);
> +
> +    /* LDPSW: sign-extend 32-bit values to 64-bit (sign=1, sz=2) */
> +    if (a->sign) {
> +        v1 = sign_extend(v1, 8 * esize);
> +        v2 = sign_extend(v2, 8 * esize);
> +    }
> +
> +    gpr_write(ctx, a->rt, v1);
> +    gpr_write(ctx, a->rt2, v2);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +/* STGP: tag operation is a NOP for emulation; data stored via STP */
> +static bool trans_STGP(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    return trans_STP(ctx, a);

This uses half the required immediate offset. It delegates directly to 
STP, which scales by sz=3. STGP requires scaling by the 16-byte tag 
granule, independently of its 8-byte register elements. Consequently 
both the destination address and writeback are wrong for every nonzero 
immediate. Existing TCG trans_STGP in target/arm/tcg/translate-a64.c 
correctly uses LOG2_TAG_GRANULE; ARM ARM DDI0487L.a C6.2.366 confirms it.

> +}
> +
> +/*
> + * SIMD/FP load/store pair: STP_v, LDP_v
> + * (DDI 0487 C3.3.14 -- C3.3.16)
> + */
> +
> +static bool trans_STP_v(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;                   /* 4, 8, or 16 bytes */
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[32];                           /* max 2 x 16 bytes */
> +
> +    fpreg_read(ctx, a->rt, buf, esize);
> +    fpreg_read(ctx, a->rt2, buf + esize, esize);
> +
> +    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDP_v(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[32];
> +
> +    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +
> +    fpreg_write(ctx, a->rt, buf, esize);
> +    fpreg_write(ctx, a->rt2, buf + esize, esize);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
>   /* Load/store single -- immediate (GPR) (DDI 0487 C3.3.8 -- C3.3.13) */
>   
>   static bool trans_STR_i(DisasContext *ctx, arg_ldst_imm *a)



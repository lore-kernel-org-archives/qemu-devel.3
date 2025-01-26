Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B343EC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 23:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcBxZ-0001ST-NU; Sun, 26 Jan 2025 18:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tcBxY-0001SC-Mp
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 18:22:32 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tcBxW-0003tN-If
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 18:22:32 -0500
Received: from [192.168.1.8] (default-rdns.vocus.co.nz [202.150.110.104] (may
 be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 50QNMAZd2451778
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sun, 26 Jan 2025 23:22:13 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=b9mr0FPp header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1737933735;
 bh=fo3uu4bFpNbLsb/IqyGIoOzJn64LHNfENsZEMwnUWTY=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=b9mr0FPpQMQg8MtX2jW8/7mBsVx3eqwW1cDCbWeve8kzNm4QbjaRH/X6veiz31feB
 BqoEIcfwJeFcmsE7ru5+7FGjSl1ZFPJ6xDBRY+DimlvLFTgc9n4yFq1V09E6Y6unGa
 fngoE/e8ESavPZVrlWk5TnNGXll6+BdnbfQK/IidWIyg3bpJX24rhZvvIgP6f0RKwp
 LRbvE5p9n9lMKXbuDO6uwtWM++Mv+jivVHhvhtPuG07ZxtBwPj4fcKVgZ3mVmUsXkT
 Vnqlc2SX73l7q1uUikQHgiS7B9URKlbRzdykHlGOuveoZBSIio3T3xPvVMgFW/whxx
 cPJ+slNZmDFzg==
Message-ID: <404403d2-ffac-41eb-964d-92ffc02b5dee@anarch128.org>
Date: Mon, 27 Jan 2025 12:22:04 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] x86-disas: add x86-mini disassembler implementation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250124001032.1073926-1-michael@anarch128.org>
 <20250124001032.1073926-5-michael@anarch128.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
In-Reply-To: <20250124001032.1073926-5-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/24/25 13:10, Michael Clark wrote:
> +static x86_opc_prefix x86_table_make_prefix(const x86_opc_data *d,
> +    const x86_opr_data *o, const x86_ord_data *p)
> +{
> +    x86_opc_prefix tp;
> +    memset(&tp, 0, sizeof(tp));
> +
> +    /* extract prefix and synthesize width prefixes */
> +    switch (x86_enc_type(d->enc)) {
> +    case x86_enc_t_lex:
> +    case x86_enc_t_vex:
> +    case x86_enc_t_evex:
> +        switch (d->enc & x86_enc_w_mask) {
> +        case x86_enc_w_wig:
> +        case x86_enc_w_wn:
> +        case x86_enc_w_wb:
> +        case x86_enc_w_w0: break;
> +        case x86_enc_w_w1: tp.pfx = x86_enc_p_rexw; break;
> +        case x86_enc_w_wx: tp.pfx_w = x86_enc_p_rexw; /* fallthrough */
> +        case x86_enc_w_ww: tp.pfx_o = x86_enc_p_66; break;
> +        }
> +        break;
> +     }
> +
> +    /* find register or memory operand mapping to modrm.rm field
> +     * so that we can add mod=0b11 or mod!=0b11 to modrm mask */
> +    tp.modfun = x86_enc_func(d->enc) == x86_enc_f_modrm_n;
> +    for (size_t i = 0; i < array_size(o->opr) && o->opr[i]; i++) {
> +        uint isreg = x86_opr_type_val(o->opr[i]) >= x86_opr_reg;
> +        uint ismem = x86_opr_has_mem(o->opr[i]);
> +        uint ismrm = x86_ord_type_val(p->ord[i]) == x86_ord_mrm;
> +        if (ismrm) {
> +            if (isreg && !ismem) {
> +                tp.modreg = 1; /* mod == 0b11 */
> +                break;
> +            } else if (!isreg && ismem) {
> +                tp.modmem = 1; /* mod != 0b11 */
> +                break;
> +            }
> +        }
> +    }

I am already relatively strictly following QEMU conventions for
single-line and multi-line comments. I don't remember seeing a
checkpatch.pl report for the above multi-line comment. I wonder
if the constraint is restricted to top-level comments? I left
this as-is due to symmetry with the other comments in this block
as they are single-line and it looks better. this is very pedantic.

so am curious about a determination on the commenting convention.

I have a disagreement about unbraced 'if' in switch because IMHO
the QEMU rules make combinatorial logic sparse and hard to read.
I also typically put the first brace of functions on their own
line so there is space between function signature and first line.
those are the two main rules I break. my coding-style has lots of
switch statements because I rely on switch constant analysis and
jump table conversion because it tends to translate to fast code.
also I linearize them explicitly because not all compilers detect
a constant stride for index canonicalization in switch constants.
that is where the bulk of the checkpatch.pl warnings show up.

> +    /* explict second opcode byte has mod == 0b11 */
> +    if (d->opm[1] == 0xff && (d->opc[1] & 0xc0) == 0xc0 &&
> +        !tp.modreg && !tp.modmem)
> +    {
> +        tp.modreg = 1;
> +    }
> +
> +    return tp;
> +}

fyi I have made a x86-mini-v2 branch with the changes I
mentioned in an email yesterday but it is still in flux:

https://github.com/michaeljclark/qemu/commits/x86-mini-v2

I still don't expect this code to be merged any-time-soon.
maybe in the future if QEMU gains the ability to run TCG
full-system under hypervisor with accelerated page tables.
I'm also considering digging out the most recent QEMU or tcc
TCG that is fully MIT-licensed as a starting point for IR.

the patch set may eventually become compelling if there is
a complete TCG supporting all AVX-512 vector ops. maybe this
is already there but I am not reading the GPL code in QEMU.
I am unsure about that code because a lot of code is by-file
licensed. it is questionable when the provenance originates
inside QEMU as opposed to MIT-licensed or dual-licensed code
(like FreeType) that is clearly of external origin. as a
modern embedded TCG would be quite useful in Rui's chibicc
or the MIT-licensed version of tcc:

- https://github.com/rui314/chibicc
- https://github.com/absop/Tinycc/blob/master/RELICENSING

and I am confessing about a snippet of code. this may look
familiar. there is one enum and two functions that were
derived from TCG X86 but they are unused. so I should add
Fabrice's original TCG MIT-license header or remove them.

I am pretty sure I checked the provenance for the version
of TCG that I used but I need to add an explicit reference
or delete these definitions. they can't really be written
a different way because they are more like reference data
and invariant logic based on X86 ISA constraints:

+/*
+ * test conditions
+ */
+
+enum
+{
+    /* non-signed */
+    x86_never  = (0 | 0 | 0 | 0),
+    x86_always = (0 | 0 | 0 | 1),
+    x86_eq     = (8 | 0 | 0 | 0),
+    x86_ne     = (8 | 0 | 0 | 1),
+    /* signed */
+    x86_lt     = (0 | 0 | 2 | 0),
+    x86_ge     = (0 | 0 | 2 | 1),
+    x86_le     = (8 | 0 | 2 | 0),
+    x86_gt     = (8 | 0 | 2 | 1),
+    /* unsigned */
+    x86_ltu    = (0 | 4 | 0 | 0),
+    x86_geu    = (0 | 4 | 0 | 1),
+    x86_leu    = (8 | 4 | 0 | 0),
+    x86_gtu    = (8 | 4 | 0 | 1),
+};

+/*
+ * invert condition
+ */
+
+static inline uint x86_invert_cond(uint c) {
+    return c ^ 1;
+}
+
+/*
+ * swap condition operands
+ */
+
+static inline uint x86_swap_cond(uint c) {
+    return c & 6 ? c ^ 9 : c;
+}



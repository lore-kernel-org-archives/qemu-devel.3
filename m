Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F6C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzzy-0005up-5a; Tue, 25 Aug 2026 18:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyzzx-0005ug-7V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:52:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyzzv-0004KZ-I0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:52:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso10634a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787698322; x=1788303122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CAMK9mBMD35BZVe8X61+1Yo4AFTJOmj8251U50RM4s=;
 b=EPY1+jRHLjLVnrugS7fhA/UYgExvg/hXx0WXpwi341y6x4paVCxBvMJlvndYyC5YIu
 VuVXx72cvohff2GG9kAuVyGMokFaVXWzTM6Va+pVztTSdwi5Z8xdgcvu96fqdie8kd5e
 GuCN84/O2u75xDMc5fTEYAglYyoAHcniO9oXD9iN49SnU+TIC92Q4q2gku4O4yroD+Fe
 TwuqiXamJRMO0XK7+qmAG31oO/8V3o/vB3R0zBRA3ovRCa/QzvoH5285ZJdnY1JXu0oJ
 ojaaQRSKKhim0wJmOjtkHo+94yiMCzDCs+08SEqgmIMyHlyS8d0MKLs6c/ze7QAERmHM
 SfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698322; x=1788303122;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CAMK9mBMD35BZVe8X61+1Yo4AFTJOmj8251U50RM4s=;
 b=Gsp7DlHilx5MH7Uc4lciMkBp8aqW+jTO99zHzcMR7qCPbWpPXBqZxGop0MkiToijV5
 +cEqAK4Xn+fdI9gL5nu/F4pUTgcujrQ1nSoe7e5d9ZzBJIY2O7RCmg/idqUROuzh+bKK
 nUEPdJblw4+aU1mlfkLhZgM4EDXkb4Gx8c5Sw80h/4KZ98sg+C/BhkyrSNDLf+kg1ZxN
 X7LB/lJQk0tIQPtPvzRx/pA5T5iq1W8TqiYsj9KU3V7o5r+OsHoTcSzxmdRmFInRfuBI
 jMoGITlQOtq98NRR8eurJYgBLmC8xcH8gTNDqqdfN7PkdZlyY58vOjuTLFCh7iQd2YHO
 UciA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1D1RMo4+AYHwTYmK5MV7Tbh+kwIbJsHLY48E46FodO6s6Jcn0EuBYfnLmi3BrI6LQ6gfGbwTB/cl8@nongnu.org
X-Gm-Message-State: AFuF++mZtx7XNHphkefa37MXt4WgCuXPe1QI5/fkaut9Ba4xQcrJWHYI
 fBlrj99loDU2ggUJ3dKLZEU/QmzKxBhgQKPEGtU6gmWw7HZWkJc40e3qviBWXdPOw2k=
X-Gm-Gg: AR+sD106w1K6N/6V05LL8Np+GtMBMHuqIl7T71HKlzwV27zVgzOQ8SSUnlZ50Dvy1PO
 ATkLHs8abKoH+228EkRwq43BOmUwYhkS72rOmi7i+KdUWraPEf9w5pSTcIkyP0PdcLwmoYgZBV/
 ZSwzPzUt8g2uw/D/ikJYgxCjoD3kMyIZhHZxBXnco/iEmRadl/5++L3YHtp4ymDjJqnRnwww/ey
 Q/ILlOLHCLNa877yLtY0+ogBWqA2bKjA5DBF1pdgxE99U31arsT7g9kMokn6tW236Iw4goNYTqk
 MNcbNEiIfvgjd435IvoxXHydUTUoUEnFlkkG+c8d3kce1VpQC6c++0ViYJGlTJAuzO+U3cY4jMJ
 liHMJkmLPX6gvD9wDdZYplt17RR8LvG+u3z/ghO9mBVpeaT7VZMgbvW7BZcQKZlfWTKsg0uRiph
 Ihw0kYlSr+vTjQh0x4pAPLiJCjerXmKAsyeq6/NOyCYgN5MKsZt9FSlHheoQPwsTmYSM56L4Hse
 ME0deecVUfLYSMIUCNZsnPTSBha
X-Received: by 2002:a17:90a:dfd0:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3966d3a8f3amr5156251a91.8.1787698321580; 
 Tue, 25 Aug 2026 15:52:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39662c80d6csm2405143a91.1.2026.08.25.15.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 15:52:00 -0700 (PDT)
Message-ID: <4645e775-b0c9-45a2-a064-17fabc3db431@linaro.org>
Date: Tue, 25 Aug 2026 15:52:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] RFC: tcg: fold a guest displacement into the host
 addressing mode
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-8-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260822190818.1829249-8-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 8/22/26 12:08, Matt Turner wrote:
> RFC because:
>
> - Only wired up for x86_64, and only for qemu_ld and qemu_st; the i128
>    qemu_ld2 and qemu_st2 pairs are left alone.
> - Requiring that no slow path exists is stricter than necessary. Recording
>    the displacement in TCGLabelQemuLdst and emitting one lea on the slow
>    path would cover alignment-checked accesses too, at no fast path cost.
> - Softmmu wants the displacement folded into the TLB comparison as well,
>    which is a bigger change than this one.
> - A one op window catches everything the frontends emit today but is
>    trivially defeated by anything scheduled in between.

Plausible.  Several times I've considered exposing complex addressing 
modes to the translators so that things that do LEA are kept intact for 
awhile.  There are plenty of host-specific code sequences for x << s + y 
+ c, even before we fold that into the memory access.  Then expose the 
host memory path to tcg ops, somehow, and finally implement a simple CSE 
pass.  But yeah, hand waving is as far as I've ever gone.

On the second point, I guess you also assuming the offset is also 
aligned?  I.e. for X + 8*N, you can test X for 8-byte alignment without 
constructing the complete address.


> +static bool tcg_target_ldst_disp_ok(TCGContext *s, MemOpIdx oi, int64_t disp)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    MemOp opc = get_memop(oi);
> +    TCGAtomAlign aa;
> +    int64_t ofs;
> +
> +    if (tcg_use_softmmu || s->addr_type != TCG_TYPE_I64) {
> +        return false;
> +    }
> +    aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16,
> +                                (opc & MO_SIZE) == MO_128);
> +    if (aa.align) {
> +        return false;
> +    }
> +    ofs = (int64_t)x86_guest_base.ofs + disp;
> +    return ofs == (int32_t)ofs;
> +#else
> +    return false;
> +#endif
> +}
These compilation mode tests belong...

> +static void __attribute__((noinline))
> +fold_ldst_disp(TCGContext *s)
> +{
> +    TCGOp *op;
> +
> +    if (!TCG_TARGET_HAS_ldst_disp) {
> +        return;
> +    }
... here, before we step over the loop.  You might as well pass MemOp to 
the target function and not MemOpIdx -- nothing about the mmu_idx is 
relevant.

Ideally, the atom_and_align test would also be done generically, not 
requiring each target to replicate that boilerplate.


r~



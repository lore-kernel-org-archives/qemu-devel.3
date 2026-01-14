Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90936D29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzSo-0004dM-6c; Wed, 14 Jan 2026 06:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vfzSl-0004cZ-RC
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:54:59 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vfzSk-00039c-2P
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:54:59 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f3fba4a11so3761806b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 03:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768391696; x=1768996496; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VGffOxOrw9UyELeIDA7uiw+8Jb3eo6s+wE/VdLml45k=;
 b=KA8uTOStDwp1SAEEbV6gNrLBA6O+2EkIljxSixYF5H+1rQrQd7EvIkTBQFQ5sYe9ZS
 bbZjNsjoK8cgdGKADqIuodA97YjLSi/bqGmAJykdXtvcoS1Z7X8oVtC6AyWiiLZs+fVY
 KhMB9JKMEEUEWX5DgWeWeoye5I8kkYLYkhJ3p9VTTaGUmHi7wAU3Yi1/gAf/9hqHfm+s
 0W4zUrnmyHwm1ieYUOmLqBoYALCwy1drDbhw/jYbH/pzfEbek033eWu66UrtQMa6Xg64
 IXMz6/Q3iQfV3u4nGKwlvDfqrc38LXXC/XBL0MGWPLiOIYANRPkgbCBLZOB9pdAZjuNM
 NYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768391696; x=1768996496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGffOxOrw9UyELeIDA7uiw+8Jb3eo6s+wE/VdLml45k=;
 b=RCtDzHNfKG1Lf/cf1J2Y03XGc8BCVexanoSDnX3g0KryP6uBs8tbs3QKoPWfuWFeLB
 gyGHnYXBhpqqbgYXm1P+tqtUEahOqzplh3YYR1hu2fjcTj61ZGuxovsSGDs42ugPr495
 /qxQFgithehBJ6T/TiPIlUvCPO5Sw2f2j80Zk3CxiY9DRpkX4n40MEJJXG42VjXmnHYo
 YMS4vNi1lGmS1rixyoPt8WrjG8+dy3hispSA2Jvov/wYigq73Y0AWg1PVSgMBImVRF5n
 FRNUijv9k3ERCf0ASWOTGprSfhgn5VA708peAwrQO092IAeAJzHajRbJuBO4Xs0KMmmu
 lBow==
X-Gm-Message-State: AOJu0Ywl3Hyu/bj6pvAEHt/A7WPzlzqRW/v1GdEknQmygJSF1+afIUk0
 7qhBDlhKYJQoQTkhWSuCg3YT6jmwpVjlQ/HNmLYaM8wGjJnA2SLpeV8IQi0j0l+69fg=
X-Gm-Gg: AY/fxX5h41dmZSaOr2QAJp4BUzsW+Th2Wzq5dBVoV8ObqNmIuIXH1/iAU+QnTJLcthH
 0gNTBH+7rHIx9V+MzYENzR1LwQNX7zrNxS5CRhk5WEqj+XJFQtJJyGbgq2QIDoZoh2OIKl5RayJ
 pui2/Ai3n+IRRGRZQHSbKEPz1SU1zvT8iFsr8e3PKSRBru31CZDBFhJcgwCeOH1xePK+cnuQU1R
 92rmdG7vx5+idoXaah40r+dCk2dYWwRX5Nrlr6smGCiobXB8gBg4AVjrxRtTHPFjbpcqsr+DCtx
 NJGw41CsERSkJ/n8C+tfWwKtgITDBHSAyXSbMiSujT/SNgFLb/WQ58tVwZJXAqJm9FiMT/odOL4
 NpecLAz3K/G8Xlf1Gf4cGmBKwMQaUK1q/Qv8r/UFWPZjNGKqoO8kuMiJN9oORHW/6JrLYyB1ev4
 tjVEdMxmIimH8FIyI3Z2rOJxY0cRe15/zCaY0jfCy8WVDDRqopsW1K
X-Received: by 2002:a05:6a00:4008:b0:81f:45ff:48ac with SMTP id
 d2e1a72fcca58-81f8200d5a1mr1992700b3a.62.1768391695608; 
 Wed, 14 Jan 2026 03:54:55 -0800 (PST)
Received: from sifive.com ([136.226.240.164]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f421174f2sm11527041b3a.1.2026.01.14.03.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 03:54:55 -0800 (PST)
Date: Wed, 14 Jan 2026 19:54:52 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 02/18] fpu/softfloat: Add OCP(Open Compute Project) OFP8
 data type
Message-ID: <aWeDnxmDpoEIJvan@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-3-max.chou@sifive.com>
 <bfdd6d82-e252-45c0-8eff-a93430691dbb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfdd6d82-e252-45c0-8eff-a93430691dbb@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

On 2026-01-10 13:57, Richard Henderson wrote:
> (0) We really should clean up this code so that there's not so much duplication.
> FOO_is_quiet_nan and FOO_is_signaling_nan really should share code.
> That would have caught the above.
> 

Thanks for the suggestion and I think that maybe we can remove the
FOO_is_[quiet|signaling]_nan functions here.
These OCP FP8 nan checkings should be different implemntation defined
behaviors.

> (1) RISC-V always uses default nan mode, the OCP spec declines to define
> SNaN vs QNaN, leaving the 8 unique NaN encodings unspecified, and RISC-V
> does not do so either.  You assert later:
> 
> +     * RISC-V uses only quiet NaNs in its OCP FP8 implementation.
> 
> Is this out-of-band discussion with engineers?
> Because it's missing from the (remarkably short) document.
> 

The RISC-V Zvfofp8min extension specification (v0.2.1) explicitly states the
NaN handling behavior for OFP8 conversions:

1. Canonical NaN Definition (Section: Zvfofp8min):
   "The canonical NaN for both E4M3 and E5M2 is 0x7f."

2. Widening Conversion Behavior (vfwcvtbf16.f.f.v instruction):
   "No rounding occurs, and no floating-point exception flags are set."

   The specification's explicit statement that "no floating-point
   exception flags are set" for vfwcvtbf16.f.f.v provides clear
   justification for treating all OFP8 NaNs as quiet in this specific
   context.

3. Narrowing Conversion Behavior (vfncvtbf16.f.f.w instruction):
   "Since E4M3 cannot represent infinity, infinite results are converted
   to the canonical NaN, 0x7f."

   This demonstrates that RISC-V uses quiet NaN propagation semantics
   throughout the OFP8 conversion pipeline.

> (2) Arm does specify (see FP8Unpack in the ARM pseudocode), doing the usual
> thing in taking the msb of the mantissa for SNaN.  Which means that E4M3 is
> *always* SNaN.
> 
> Both architectures then immediately convert to FP16 default nan, however Arm
> *does* raise invalid operand exception for the SNaN, so we can't just ignore
> it.
> 
> Given that there's exactly one RISC-V instruction for which this matters,
> vfwcvtbf16.f.f.v, it seems like it might be better to simply adjust
> float_status.no_signaling_nans within the helper rather than introduce
> ocp_fp8e5m2_no_signal_nan.
> 
> > +    /*
> > +     * When true, OCP FP8 formats use the same canonical NaN representation
> > +     * (0x7F) for all NaN outputs. RISC-V specifies a single canonical NaN
> > +     * for both E4M3 and E5M2.
> > +     */
> > +    bool ocp_fp8_same_canonical_nan;
> 
> Similarly you could adjust the canonical nan around the 4 FP16->FP8 conversion insn helpers:
> 
>     /* Default NaN value: sign bit clear, all frac bits set */
>     set_float_default_nan_pattern(0b01111111, &env->fp_status);
> 
> In either case, "bool" doesn't seem appropriate.
> 
> FWIW, Arm retains the msb set pattern as for all other fp formats (FP8DefaultNaN).
> 
> 
> r~

Thank you for the review feedbacks and suggestions.
The suggestion to handle the canonical nan and quiet nan within the
helper function rather than adding global state to float_status is the
cleaner solution.
I will incorporate this change in v2 of the patchset.

Thanks a lot,
rnax



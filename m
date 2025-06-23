Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B37C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeTV-0002P8-Re; Mon, 23 Jun 2025 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTeTU-0002O3-9l
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:32:28 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTeTS-0001wR-B5
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:32:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ade5ca8bc69so688644366b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674744; x=1751279544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJDNYTAh75lxrgIAADIpRJHCrBDU0Cri29E202H+t/g=;
 b=wY33NmRbsH7TEk8Ce+XPan1QUo81ohX7DfPZ+nBCNrjWIn5gQVTblYhLxk8CGUZ0zj
 S540QGTqxOBExdTAA+nLHw2pzCvWCX3ASd23Ebti8/LtLbmDt/hrzPlNtWOsv+b3JjJK
 GcXFXXRfBFLV/RdfhlsFz7mIJYBAzAPqoomzSVmNVtrQL46v69YTjsX0AtVXofv1fJZk
 Ataaa1B0hHIKeEEek87DrC6G0AZNeZb4kSNUhdmmkiWi+6k/DYoO6+7NCybSY1PL1CSb
 WEzCBo3jw6xIzPx6KtjDNxtxS7elJuA7SSKuw4eBZ/NyoAzkP9EVVvk5y0CTJFPUSA99
 Gihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674744; x=1751279544;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fJDNYTAh75lxrgIAADIpRJHCrBDU0Cri29E202H+t/g=;
 b=etHPKbqzYUm4CTcLCV8Gv2KbJqOk6vNMMAJ0QFsgMcH0r5cYRku72fdDI7dbQOqd2W
 mVnC3HEApgq7X2ttFElxKwnbf1UM7AG00WnfwrZUnkNrx60/KGmN6uiRoeuiBvxJXP3C
 +L77VC2e89WFTy6XdqRX1MuMHyx2CVJzeeYIaXMldF7BNuwlcl87fqlJdM+f7ywS+19M
 D+NkRHjhuGZzsG8JymecyyRHYt5L0EUlC1SminmAmUgeAoAeg5rLd/yF3wOZC6yVEKsr
 zgS7pGMrOPAZSfh02Yoz0EiuQsUINH0MTJJFUo1kDXdBFq4S0LYyqhilwOamDfv3sqhG
 02BQ==
X-Gm-Message-State: AOJu0YxRmrnNug5ut8B0NVzOSubKCp96lsWB/48Ono9wr9QRiVCkCNcj
 N2F28imFcz+C7eJ8H3ztLaOdk1lECn20oswx5r+vJOFJ8crUwPmor9HF7lMi5miv26HiprVS7IK
 hjl6krAg=
X-Gm-Gg: ASbGncuJX5b9tfTEsW3QkXLpYzKyPFI0V1ee8qRC6BRpqVlxWcfAHfJHCyBG8aF23K1
 pX9CTMULytp5JxQcou21mXVbdaxf8c6ApcgH2kcTnWhSI6YOVcgSNy5QZgcbMEXJ5i7URRMtKDR
 4IyBEtLsaaX7k1e+EbH1+zID5bBaNRDbrmbG+h/8m7qZnelSB6uv/yyHoF8uScadG/5aTJvlB8J
 3MFci/uoq1Mo7dOuywYyHWYJKeH3TIvkyLiTOYrKeph0bNB6Pq9V62WZ34/oo8Fr/Y5QLSUQvd5
 ncs+OHi8TIqPbeO0kZs5g9m/Eo53RFzoohSC/XwYVjoH2m2YR+kxWOQfiI6KMg8=
X-Google-Smtp-Source: AGHT+IEzy+QPbr7oZ1lNEJTX+yT0SK4sDFyK9+uE4VI+PuFRDFcS6l5It65aHNLFzj8gapbauJMIMw==
X-Received: by 2002:a17:906:6a08:b0:adb:3345:7564 with SMTP id
 a640c23a62f3a-ae057ad198cmr1072884066b.35.1750674744394; 
 Mon, 23 Jun 2025 03:32:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7fc5csm687415666b.30.2025.06.23.03.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 03:32:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAD505F815;
 Mon, 23 Jun 2025 11:32:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 065/101] target/arm: Implement SME2 FCLAMP, SCLAMP,
 UCLAMP
In-Reply-To: <629c93ff-5849-4937-9b52-3d2116f90035@linaro.org> (Richard
 Henderson's message of "Sun, 22 Jun 2025 13:54:04 -0700")
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-66-richard.henderson@linaro.org>
 <629c93ff-5849-4937-9b52-3d2116f90035@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 11:32:22 +0100
Message-ID: <874iw63g09.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/21/25 16:50, Richard Henderson wrote:
>> +static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
>> +{
>> +    static gen_helper_gvec_3_ptr * const fn[] =3D {
>> +        gen_helper_sme2_bfclamp,
>> +        gen_helper_sme2_fclamp_h,
>> +        gen_helper_sme2_fclamp_s,
>> +        gen_helper_sme2_fclamp_d,
>> +    };
>> +    TCGv_ptr fpst;
>> +    int vl;
>> +
>> +    /* This insn uses MO_8 to encode BFloat16. */
>> +    if (a->esz =3D=3D MO_8
>> +        ? dc_isar_feature(aa64_sme2_b16b16, s)
>> +        : dc_isar_feature(aa64_sme2, s)) {
>
> Missing !'s.

It gets a lot further into the run but we then fail on:

  Program received signal SIGILL, Illegal instruction.
  0x00007ffff65d6690 in kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2=
vlx2vl_sme2_mopa ()
  (gdb) x/5i $pc
  =3D> 0x7ffff65d6690 <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2v=
lx2vl_sme2_mopa+496>:    fclamp  {z0.s-z3.s}, z26.s, z24.s
     0x7ffff65d6694 <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2vlx=
2vl_sme2_mopa+500>:    fclamp  {z8.s-z11.s}, z26.s, z24.s
     0x7ffff65d6698 <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2vlx=
2vl_sme2_mopa+504>:    st1w    {z0.s, z8.s}, pn8, [x26]
     0x7ffff65d669c <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2vlx=
2vl_sme2_mopa+508>:    add     x26, x26, x23
     0x7ffff65d66a0 <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2vlx=
2vl_sme2_mopa+512>:
      b.eq        0x7ffff65d66bc <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f3=
2p2vlx1b_2vlx2vl_sme2_mopa+540>  // b.none
  (gdb) x/1w $pc
  0x7ffff65d6690 <kai_kernel_imatmul_clamp_f32_f32p2vlx1_f32p2vlx1b_2vlx2vl=
_sme2_mopa+496>:       0xc1b8cb40
  (gdb)=20

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


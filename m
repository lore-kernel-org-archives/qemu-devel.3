Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA14F94CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFOh8-0003NO-AF; Tue, 21 Apr 2026 23:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOh2-0003Mw-Sq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:56:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOh1-0007wO-Bs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:56:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so1775266b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 20:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776830161; x=1777434961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oMM/avElxT/DcLUTEluaFzyOWK8qWJicpG5+kUka7EU=;
 b=zjJe5eC+f5osG4saJ2y0xRw3TRPYHTgaNS9mWxa0TOHYR1Qvdf8e9xNOnuWRlfMO9s
 OHVeWzmkozGn/usro56OTEME5taMuqPUlKoitPG/x93us0Rrd488RX3zUVoiIDsv8E2Y
 tQC3BXuAxECDWx11MQ5UIecFDcR+yjLPvtDA9HHJHSsIU/LQzIp+g9J8J0hQFH6GmldY
 diXABtq92zqC/sqyhSIbqXSNKFmME96uSeSLDCJqqqtstsfYgt+li2JgJb1bhdV303wo
 SLXRVfLSJkuhFfHmjG9CWpz4lkEZeNINZNgJoSrXN2UYjrtwl1OBLOgYdJ2gTijZi/dt
 cgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776830161; x=1777434961;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMM/avElxT/DcLUTEluaFzyOWK8qWJicpG5+kUka7EU=;
 b=exy1LVj1d2wrU0KMi2Kfji0ZOMHw55Uze57TRoi6Tjb71a+jZaw6Q7bwlR/eOohAcM
 SR1VsyVUx8ymFuVCRXFtNdV6+ZatChUnSv4utfbVidpxJ8j24t6wfZembAPbYve3YatN
 RI2cK3ULHvgxqw6zHoTL3SYtLP9+D9MbslA5BF2gSYhXGL4IVwwxKEj/Pp3LzYgu5DEw
 O8biXES5xPMaySW14Cu09Y+K9O1VdhTXlDGqBIRIVoTeVMKWQqnw8vFP+II4ntf7AEyy
 X8WA0mSDv1oKnuO2j0shw+j7aRtLd+WExKmlOlPWd/LQw3IsGyMqdb5YTfpHV2ZZovv+
 pL5Q==
X-Gm-Message-State: AOJu0Yxrq/trMn1TZaxniMrK4SPoypT38at8pYVCO4AhwEEnKj90tIb2
 SXNobijfh48rVaJcMBpwcS2Qt+QKhx1gM5Bey33BJiTs3BTtOCRxEM9pmVzaH5t/ufwHNpnUYb8
 DsfvdRes=
X-Gm-Gg: AeBDiesNTwEch2Hvsbn64GqZE8YL+I51t/Qkl9yPARxj4SUGnIMRvSigs6f4YTQndV3
 3yucmClZAgS/mMKZqSe0eBaTqg6qTuVahOCOIwkTBL/z/kbvY3db3epP9F6xEmRucOZ550c4h5C
 mIqaMXp+DOGr7VA+7DlSXDpdx2DfyZHGDo+XTjVG0Qf0Ij1WXRbOQp/NsILa15YfSrK7LMH3Ehi
 LUi0al4IKDqUMDCKnNiw3wReiDZG8dho6YuVIGylXALYCIF1kQH3IQt7ek/D+k42UEHu0zToQYL
 HKyrfOdIHFwKRJyZy/ONVLy9Irz6mNYWx2FedOUK1nfQWR0/sW6q4bmdpm2pGVlZtkSfa1hsBK6
 2eMXc7WVfjfNYaXyEoMyut62VM+4ZntxgN7B0EaPu90SUIBxCLe4MLToi5cZlJBdg8GbNgiayvh
 FDSpsgr4zUO+AhqLLo/E2yWuLi4uChleVL+CBWEgm/0L7jk/rtPwc=
X-Received: by 2002:a05:6a00:8510:b0:82f:9e98:136b with SMTP id
 d2e1a72fcca58-82f9e98218amr11351420b3a.19.1776830161147; 
 Tue, 21 Apr 2026 20:56:01 -0700 (PDT)
Received: from [10.72.56.227] ([144.130.159.192])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981c07sm18405300b3a.1.2026.04.21.20.55.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 20:56:00 -0700 (PDT)
Message-ID: <4b76083f-cbf4-484f-935f-7174a9d4a3c9@linaro.org>
Date: Wed, 22 Apr 2026 13:55:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] target/mips: add Octeon LA* atomic instructions
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-6-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-6-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> +static bool trans_lai(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, -1, a->rd, 1, false);
> +}
> +
> +static bool trans_laid(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, -1, a->rd, 1, true);
> +}
> +
> +static bool trans_lad(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, -1, a->rd, -1, false);
> +}
> +
> +static bool trans_ladd(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, -1, a->rd, -1, true);
> +}
> +
> +static bool trans_laa(DisasContext *ctx, arg_laa *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, a->add, a->rd, 0, false);
> +}
> +
> +static bool trans_laad(DisasContext *ctx, arg_laa *a, int unused)
> +{
> +    return trans_la_common(ctx, a->base, a->add, a->rd, 0, true);
> +}
> +
> +static bool trans_las(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, -1, a->rd, -1, false);
> +}
> +
> +static bool trans_lasd(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, -1, a->rd, -1, true);
> +}
> +
> +static bool trans_lac(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, -1, a->rd, 0, false);
> +}
> +
> +static bool trans_lacd(DisasContext *ctx, arg_la *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, -1, a->rd, 0, true);
> +}
> +
> +static bool trans_law(DisasContext *ctx, arg_laa *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, a->add, a->rd, 0, false);
> +}
> +
> +static bool trans_lawd(DisasContext *ctx, arg_laa *a, int unused)
> +{
> +    return trans_law_common(ctx, a->base, a->add, a->rd, 0, true);
> +}
> +
>   static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
>   {
>       TCGv_i64 addr = tcg_temp_new_i64();
> @@ -376,6 +534,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
>   
>   TRANS(SAA,  trans_saa, MO_UL);
>   TRANS(SAAD, trans_saa, MO_UQ);
> +TRANS(LAI,  trans_lai, 0);
> +TRANS(LAID, trans_laid, 0);
> +TRANS(LAD,  trans_lad, 0);
> +TRANS(LADD, trans_ladd, 0);
> +TRANS(LAA,  trans_laa, 0);
> +TRANS(LAAD, trans_laad, 0);
> +TRANS(LAS,  trans_las, 0);
> +TRANS(LASD, trans_lasd, 0);
> +TRANS(LAC,  trans_lac, 0);
> +TRANS(LACD, trans_lacd, 0);
> +TRANS(LAW,  trans_law, 0);
> +TRANS(LAWD, trans_lawd, 0);
>   TRANS(LBX,  trans_lx, MO_SB);
>   TRANS(LBUX, trans_lx, MO_UB);
>   TRANS(LHX,  trans_lx, MO_SW);

This is incorrect usage of TRANS(), or a mis-feature of the mips version of TRANS().

If TRANS() is changed such that 'a' is not implied, then you can expand the macro here:

TRANS(LAI, trans_la_common, a->base, -1, a->rd, 1, false)

Otherwise, isolate common usage within each argument set:

TRANS(LAI, do_lai, 1, false)
TRANS(LAID, do_lai, 1, true)
TRANS(LAD, do_lai, -1, false)
TRANS(LADD, do_lai, -1, true)

TRANS(LAA, do_laa, 1, false)
TRANS(LAAD, do_laa, 1, true)

etc.


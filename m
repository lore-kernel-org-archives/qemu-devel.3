Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C4C79F8B
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 03:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x33nV-0005OH-LN; Sat, 05 Sep 2026 23:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x33nU-0005O3-C1
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 23:44:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x33nS-0006FY-Ok
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 23:44:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1735093a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788666237; cv=none;
 d=google.com; s=arc-20260327;
 b=Vubk/3urNmUaFHfRkYX7VvR8wcC3Fb7cZxbZmwhFgygfD2kCzlGnpQlZbdyh8evtcQ
 1PIP2FcnWa0AUayDBb2Bs5YfS65OMUyy3p0+sUYfYvHCza/hAbi6C6YnXqqSpR+l5yAD
 UEjxWNceDQjn2CN8bm68NY+kobyu2/sIbwiJlBFNdcjEop8BDOwQhWJZ4CG5hS0neqGc
 sXFH8R6oZEYANJ7OBpGEV2ur6yanEIWfPbJ4gyq49SLCOj17jP6T22eR8/gHrCHlHt56
 uZIF4apF8DTxgmkSUqoR1OBCLhDrBLftxZf8Wb0+pCV7+QI27o+wPAVDdWlTJamatmjZ
 mmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xHO8pCk/PGul4WjK6pHwxopazczPugQYLb9RWHnDvXQ=;
 fh=9bZF49n7Ry20Puk4B4Mm8twO2cDLo0zOliqLKlB0dV0=;
 b=FvNaC9fci1PIjOq3vRg9i500cFMihvPb9gzjAkR9PUYtu8PiewEzk5FkJGNNpG/pY4
 mxtQ1uJ4J4Lq8jky4htFKBW+0XvAygJjxhY/ylPnvD3IapEdhipfA8WM2ZAQkI1W9fwH
 mwspi2ZzK3/SS2skJc6DyB3kN+8FuOmK8fPVXnikVLXLhs0DvNnu35HwadWlf2Qka2PX
 2LyoU5ydUas8VJNhjfwuteAc7VwGZF90r2UfSjhJLNZd3rCJO50UFM7whlW0+vdRr+gV
 9iMvhD3KS3+8leulUzUvWYS7K8OB6Vr7DgabsGAOlKmD84/KLXGpIqWzLUVzAN+QgB8G
 /yKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788666237; x=1789271037; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xHO8pCk/PGul4WjK6pHwxopazczPugQYLb9RWHnDvXQ=;
 b=S3dXXm3wLEGvyVcuYFGD2SbA9VgougYBTXS0ExQp7epVN1jTKecxvN3p1LzJWN4T7S
 9ZKx9zbSYa+4iHEA8Sgxp71/+YRuB7Jc4UTyn4uSkDiED4QafIKGkjR5j0MIxo3PlV4Q
 yZEBnuTQ+FM9IR5PamZ/vEZeGr44MarRRwNx6rzXscZ32CHNyvbWgZmT7jX1kwhJ3e0o
 Fm5Q3hdjHs2W3ntJy16xAkHiszg82Nzjbg/oRQBmilDCx5emJ19YEUiKuaHlsEgO9Y+o
 Nkn8na0GgP+2ht7WbBwDCrr3+WIfSKatbxXjhWyRc8oxUvuWdKu0Tz/vreYSRTrj+343
 DzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788666237; x=1789271037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xHO8pCk/PGul4WjK6pHwxopazczPugQYLb9RWHnDvXQ=;
 b=dvdGot/59lxZodP6FU3V1xy5J+qXCo9AP/16nZaXVcjmrxPm+3I+RQ9FwFhWvYVTFU
 dCtpcfy8ZbstU/Qy+iIn7b+jONMqEma8i4qKF1CldGfFlALdmLszptkPoX6LxEtsPT7m
 K/ljEdujeU8ZwQyHmbqSOskLx08oSYS3nDNHOdBZy8t9ZYsISkS37fr5MOYFAI6U63ha
 STCrVp8HE1HfJmcurfJHV3fcYWgTgEz4vC8YxfavFXDA6Vg6ztpx75xvBjE9uk+FnpBv
 CfB6QMK9MiTKMhQFYLxaTmMokYA8QVmoQ7WPe1Nr7qe7Vsd/Xqn5gilBsYAFZRbiYT2j
 gBpQ==
X-Gm-Message-State: AFuF++mh+TP4KYFZrqupcBB1ryFuEQAhbbf6klcqlApc6VRcXl/pU0EM
 W4H5YcrQkL+YIN4DTOeGPQe1TnTZDiRf9YjpC3+l7fdgJx2ZfqKsnY6Igaq/K1DoDbTECR0G9zL
 axKuA2WnDTe46r0ncD2pFCQS11Qw6Bn8=
X-Gm-Gg: AYBFou2odYC1mS1tD6RZJ7rGX5gSwU+zUjiPxlXHO7JLeD3DsnsaN5VbQbZquM7a/Va
 DkXkkD14OOLqMHGSWnNMYjmgKwqzqqVQgxCeNjzp8TRVizKp4l47paqZvAbpjQpbXt+Ib7M2yAN
 WqSoqtW7KesuC4oZDaKYcJt+GlKrdRGihIFui8BUXlBVJCqdxrRQl2LbC6yxLcT5DzwceW+WMIf
 M1CN+brdao6t5MELZ4dIoq6klBRsZf0VJK/Car62CUzswF0CrEgb+3lgJM+w6VvDfnPglbaalO3
 pYQ8zHo5FR6f5zoOQ3+mlsh9vYHqlydVFsDqFazATZct1XRRlnK7jtN5I8Hx9SPZi5q4+f1yxTB
 w
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-39b261ba63bmr23938857a91.11.1788666236644; Sat, 05 Sep 2026
 20:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260905014629.991586-1-apolivodaa433@gmail.com>
 <CABgObfa4+CzMVN4xj=71cfJL6eMdMWqCoEvQ5RKvPNcR79XO4w@mail.gmail.com>
In-Reply-To: <CABgObfa4+CzMVN4xj=71cfJL6eMdMWqCoEvQ5RKvPNcR79XO4w@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sun, 6 Sep 2026 13:43:44 +1000
X-Gm-Features: AcwNN1U9Fq4BDCbGa03ZWh9b2fwYP773csg3Z23C_gWRPalWSpb8tsduUKJl-t4
Message-ID: <CAGscdFt0cJOaB+5P4YcSEbC7zAw8ZCnnfFQWBki-P+KXVtW-gw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: ignore VEX.L when emitting VROUNDSS and
 VROUNDSD
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=apolivodaa433@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

>>
>>      case X86_SIZE_ps: /* SSE/AVX packed single precision */
>> -    case X86_SIZE_pd: /* SSE/AVX packed double precision */
>> -        *ot = s->vex_l ? MO_256 : MO_128;
>> +    case X86_SIZE_pd: { /* SSE/AVX packed double precision */
>> +            bool is_scalar = (e->s0 == X86_SIZE_ss || e->s0 == X86_SIZE_sd ||
>> +                              e->s1 == X86_SIZE_ss || e->s1 == X86_SIZE_sd ||
>> +                              e->s2 == X86_SIZE_ss || e->s2 == X86_SIZE_sd);
>> +            *ot = (s->vex_l && !is_scalar) ? MO_256 : MO_128;
>> +        }
>
>
> Oh, this also applies to VMOVSS, VSQRTSS, etc. but that's actually correct - they're all VEX.LIG. It's worth listing these instructions above the declaration of is_scalar.
>
> Paolo

Checked which instructions are actually affected by this patch:
```
$ grep -Rn ',\s*s[sd]' | grep OP | grep -E ',\s*(x|ps|pd)'
tcg/decode-new.c.inc:999:    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,
H,x, W,ss, vex3 cpuid(SSE41) p_66),
tcg/decode-new.c.inc:1000:    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,
H,x, W,sd, vex3 cpuid(SSE41) p_66),
tcg/decode-new.c.inc:1056:        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,
      M,ss, vex5),
tcg/decode-new.c.inc:1057:        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,
      M,sd, vex5),
tcg/decode-new.c.inc:1079:        X86_OP_ENTRY3(VMOVSS_st,  M,ss,
None,None, V,x, vex5),
tcg/decode-new.c.inc:1080:        X86_OP_ENTRY3(VMOVLPx_st, M,sd,
None,None, V,x, vex5), /* MOVSD */
tcg/decode-new.c.inc:1163:        X86_OP_ENTRY3(VMOVSS_st,  M,ss,
None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSS */
tcg/decode-new.c.inc:1164:        X86_OP_ENTRY3(VMOVLPx_st, M,sd,
None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSD */
$
```
After running some tests, it looks like the behavior of (V)ROUNDSS,
(V)ROUNDSD, (V)MOVSS and (V)MOVSD is actually modified by this patch.
(MOVNTSS and MOVNTSD do not generate different TCG ops with and
without the patch applied. However, the VEX prefix
is actually illegal for these two AMD-specific instructions (tested on
AMD EPYC 7763; material for a different patch, I guess))

Also, VSQRTSS and VSQRTSD are actually raising an invalid opcode
exception when VEX.L is set
That's because:
1. `vex_special` field of VSQRTSS/VSQRTSD opcode entries is set to
`X86_VEX_REPScalar`
2. For entries with `vex_special == X86_VEX_REPScalar`,
`validate_vex()` raises the #UD
    if `(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) != 0` and `s->vex_l` is set
Intel Core i3-6100 and AMD EPYC 7763 do not raise #UD when this
happens. (looks like another patch material)

I will send a v2 with a comment listing (V)ROUNDSS, (V)ROUNDSD,
(V)MOVSS, (V)MOVSD as the instructions affected by this change


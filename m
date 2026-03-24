Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E63FEC0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57T4-0007rP-OB; Tue, 24 Mar 2026 15:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57T2-0007qs-7A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:31:08 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57Sv-00061F-8v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:31:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a1230c60eso2086834a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380657; cv=none;
 d=google.com; s=arc-20240605;
 b=dQE4rCpIJhAtyoOmSbvtGpDVH6jiGgad9b8NPOPkbRVOgnTW3qnXNNhutjX4oOVEhQ
 +k3tP76MWBCsd5fd6nDdv2Yq07YSlUg3Jwcbjrtakqq2NCiWXezdA49GrOe9XKRnAXk5
 EdL9gP8Fyq5NM9+qfrB3miO+9Z2pVYB6oODwoxe/CRxeuIe0Zf9h7jN0PhvgbIXelfov
 E+t4Hvat01WKF+XdB4Rnl+vRzEE4OjXJDbH1lnW12Ds2/kT0C1lNft0YYVVgw2TZO6mS
 rwYkJLNEVdGnr4BFVyF4Uk1oK4Yt8M96ElPvqAxndnDPv0Z9dTK230y80npcFjq+DWSk
 aQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZodM9HydkhfWbfAAq4I9XWXt0cEUxAYNXK5uUz3BdIY=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=QeN/pr2DpWjAJdwWRLk/4uliYNyLtzeLKlD0l7JRZ3ef7elQ55Hnw6YpuPRF1xiCy4
 BlQSjs3jNRwAEg1fZyCQkSZO18PdCQ5WAjL2opYqoJrWsZMOVcHpxrdR11dNuU2wliIw
 fmPMLBUwZRLW6eF0cQjn1At3gWfVg1TrnXf+viTnAQsjJCLLUiVAkZXOIvfuDGuCXTXv
 0hzometnYGo8Unvr2MYFw1yZN2ivZB4c910aEoulijjdyddTtepM436lpkbQhSGnk/DC
 KhIeckIzZKyqYe0L6nWTEMtEKyas6JU/ANlIYItNyqSCRs4wFcvdy4+m+uP/OHNSWOZ/
 X4TA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774380657; x=1774985457; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZodM9HydkhfWbfAAq4I9XWXt0cEUxAYNXK5uUz3BdIY=;
 b=gE/PMAFWTEUu/uq0JNz9nifR9P4CvjXMtRZj9KrvyproMT9zCatDI7x/7SQn7hXOM1
 YNmpCAvPsb8q4uhp1hNrtgQcHJtcqKPhG+SlcAYcg4oOEFrj5XtL36igMDSRNkH9Ws6L
 hv0jyZnDr9waf1tr0d1I4h+QZkiPpR81t52q9MJFDyYML/9myHGYhYeK7WXqCQnM2NeG
 ydkMzWMncKOeBqY2fCzfH9IOn7zEHg0B9HlQRrzLajMykY74Ja+zFIi63s5ZqnZNYupw
 fXefLOD3dj78RrbwU7xzvJrk+4cM6ju3Vgu5DrAQVQpr0j9Is6eRIzeFmkoVhyzN9wEz
 6ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380657; x=1774985457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZodM9HydkhfWbfAAq4I9XWXt0cEUxAYNXK5uUz3BdIY=;
 b=HPwypyLtbbjalb7u+LSSuEchCJPdk0+vMop/INB431HBweZlaXaYKij4mlHnkAGlnz
 KtK5PRKcwC0F/oFbydXDoyEucuvX+zPMlAxYdKfYS0ESGyRmVsWXtxSNQNBGZgXbOcSz
 J8M8IO+CdfWRiQBsccGI6LpGZ4w2PhjW+zMpwGJsjaIOoNZefq67F6iHsL2QEORQkZrC
 MOlo/1L1/eIaDniibujljj7gW94c2pUQvwewGMYUcpnddNqm4V/vAXlFQWKck43xBQsO
 Sz5r6ESHC6N0tPGEJNZ8PlsnqfUXDmRZvf7+wkSx3W1J4UkmUhsATaC/a4iEv8Vyw3oi
 ERKA==
X-Gm-Message-State: AOJu0YxYQ2dMnIJ61Fov8GT/DWLwzScMlGe16f53/jD43E51Y8VpnAHw
 NrIAmK7WrTXwxDrRlFpMUcNOjiE3Lv8aTa7XoHDitQzi7kPvsai4LgRW+VL+Fmix0D83nF4dMDo
 gCgzTKEXuqrQYD6h+iD9mOO0i0gUudhY=
X-Gm-Gg: ATEYQzyY7+LceYR/yJE+tYiY+4yDe7YKnaWxi4VsruMtbb2pMBY8RdEERAHJciOZZAL
 Bu6xdjevg9zWmHIBAP04K9JsCg/k6KrhAYwGyUa1s/xB/fvRzMQvY7Khd4+fOt1gP8wZbuGU6AQ
 VtgXBnRI7vqfMS+U1h1SiDez0d5WzflWBlIG7CZIHlMNp+LwpFQesz2G1AT/Y+hMX2sMa2zAS6H
 yrJ8IxVBHzvDoBWjt0C2nxXe7yKdNrHle09m+YOSL7btReh3nwD6q6HwRjNCWCrGpCQQvlSW00E
 0n5mVrlN/nGIb4EQ50rRx73cKRcVT9jcRIQ1uMQ=
X-Received: by 2002:a17:90a:e705:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-35c0dca9c83mr523308a91.10.1774380657279; Tue, 24 Mar 2026
 12:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <b3c261d1c76838c3b6c593ae77dc0b1ed1459f32.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <b3c261d1c76838c3b6c593ae77dc0b1ed1459f32.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:30:46 -0600
X-Gm-Features: AaiRm51_GyVRlcGLG5uyM8Bdp4_KgkTCxndN-JDCCrOLQjZJ-DY_T9i3XawVcd0
Message-ID: <CAATN3NpWTU_Aqn+EruVRRMjEjCWNs4g+fO8fWq=kVqDze=kD8A@mail.gmail.com>
Subject: Re: [PATCH 12/13] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000c605e2064dca30f1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000c605e2064dca30f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h      |  15 +++
>  tests/tcg/hexagon/hvx_misc.h      |   2 +
>  tests/tcg/hexagon/fp_hvx_cvt.c    | 194 ++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |   3 +
>  4 files changed, 214 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
>
> diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c
> b/tests/tcg/hexagon/fp_hvx_cvt.c
> new file mode 100644
> index 0000000000..7497455ac6
> --- /dev/null
> +++ b/tests/tcg/hexagon/fp_hvx_cvt.c
> @@ -0,0 +1,194 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
> +
> +#if __HEXAGON_ARCH__ > 75
> +#error "After v75, compiler will replace some FP HVX instructions."
> +#endif
> +
> +int err;
> +#include "hvx_misc.h"
> +#include "hex_test.h"
> +
> +#define TEST_EXP(TO, FROM, VAL, EXP) do { \
> +    ((MMVector *)&buffer)->FROM[index] =3D VAL; \
> +    expect[0].TO[index] =3D EXP; \
> +    index++; \
> +} while (0)
> +
> +#define DEF_TEST_CVT(TO, FROM, TESTS) \
> +    void test_vcvt_##TO##_##FROM(void) \
>

static


> +    { \
> +        HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0]; \
> +        HVX_Vector buffer; \
> +        int index =3D 0; \
> +        memset(&buffer, 0, sizeof(buffer)); \
> +        memset(expect, 0, sizeof(expect)); \
> +        TESTS \
> +        *hvx_output =3D Q6_V##TO##_vcvt_V##FROM(buffer); \
> +        check_output_##TO(__LINE__, 1); \
> +    }
> +
> +DEF_TEST_CVT(uh, hf, { \
> +    TEST_EXP(uh, hf, HF_QNaN, UINT16_MAX); \
> +    TEST_EXP(uh, hf, HF_SNaN, UINT16_MAX); \
> +    TEST_EXP(uh, hf, HF_QNaN_neg, UINT16_MAX); \
> +    TEST_EXP(uh, hf, HF_INF, UINT16_MAX); \
> +    TEST_EXP(uh, hf, HF_INF_neg, 0); \
> +    TEST_EXP(uh, hf, HF_neg_two, 0); \
> +    TEST_EXP(uh, hf, HF_zero_neg, 0); \
> +    TEST_EXP(uh, hf, raw_hf((_Float16)2.1), 2); \
> +    TEST_EXP(uh, hf, HF_one_recip, 1); \
> +})
> +
> +DEF_TEST_CVT(h, hf, { \
> +    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
> +    TEST_EXP(h, hf, HF_neg_two, -2); \
> +    TEST_EXP(h, hf, HF_zero_neg, 0); \
> +    TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \
> +    TEST_EXP(h, hf, HF_one_recip, 1); \
> +})
> +
> +/*
> + * Some cvt operations take two vectors as input and perform the
> following:
> + *    VdV.TO[4*i]   =3D OP(VuV.FROM[2*i]);
> + *    VdV.TO[4*i+1] =3D OP(VuV.FROM[2*i+1]);
> + *    VdV.TO[4*i+2] =3D OP(VvV.FROM[2*i]);
> + *    VdV.TO[4*i+3] =3D OP(VvV.FROM[2*i+1]))
> + * We use bf_index and index in a way that the tests are always done
> either
> + * using the first or third line of the above snippet.
> + */
> +#define TEST_EXP_2(TO, FROM, VAL, EXP) do { \
> +    ((MMVector *)&buffers[bf_index])->FROM[2 * index] =3D VAL; \
> +    expect[0].TO[(4 * index) + (2 * bf_index)] =3D EXP; \
> +    index++; \
> +    bf_index =3D (bf_index + 1) % 2; \
> +} while (0)
> +
> +#define DEF_TEST_CVT_2(TO, FROM, TESTS) \
> +    void test_vcvt_##TO##_##FROM(void) \
>

static


> +    { \
> +        HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0]; \
> +        HVX_Vector buffers[2]; \
> +        int index =3D 0, bf_index =3D 0; \
> +        memset(&buffers, 0, sizeof(buffers)); \
> +        memset(expect, 0, sizeof(expect)); \
> +        TESTS \
> +        *hvx_output =3D Q6_V##TO##_vcvt_V##FROM##V##FROM(buffers[0],
> buffers[1]); \
> +        check_output_##TO(__LINE__, 1); \
> +    }
> +
> +DEF_TEST_CVT_2(ub, hf, { \
> +    TEST_EXP_2(ub, hf, HF_QNaN, UINT8_MAX); \
> +    TEST_EXP_2(ub, hf, HF_SNaN, UINT8_MAX); \
> +    TEST_EXP_2(ub, hf, HF_QNaN_neg, UINT8_MAX); \
> +    TEST_EXP_2(ub, hf, HF_INF, UINT8_MAX); \
> +    TEST_EXP_2(ub, hf, HF_INF_neg, 0); \
> +    TEST_EXP_2(ub, hf, HF_small_neg, 0); \
> +    TEST_EXP_2(ub, hf, HF_neg_two, 0); \
> +    TEST_EXP_2(ub, hf, HF_zero_neg, 0); \
> +    TEST_EXP_2(ub, hf, raw_hf((_Float16)2.1), 2); \
> +    TEST_EXP_2(ub, hf, HF_one_recip, 1); \
> +})
> +
> +DEF_TEST_CVT_2(b, hf, { \
> +    TEST_EXP_2(b, hf, HF_QNaN, INT8_MAX); \
> +    TEST_EXP_2(b, hf, HF_SNaN, INT8_MAX); \
> +    TEST_EXP_2(b, hf, HF_QNaN_neg, INT8_MAX); \
> +    TEST_EXP_2(b, hf, HF_INF, INT8_MAX); \
> +    TEST_EXP_2(b, hf, HF_INF_neg, INT8_MIN); \
> +    TEST_EXP_2(b, hf, HF_small_neg, 0); \
> +    TEST_EXP_2(b, hf, HF_neg_two, -2); \
> +    TEST_EXP_2(b, hf, HF_zero_neg, 0); \
> +    TEST_EXP_2(b, hf, raw_hf((_Float16)2.1), 2); \
> +    TEST_EXP_2(b, hf, HF_one_recip, 1); \
> +})
> +
> +#define DEF_TEST_VCONV(TO, FROM, TESTS) \
> +    void test_vconv_##TO##_##FROM(void) \
>

static


> +    { \
> +        HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0]; \
> +        HVX_Vector buffer; \
> +        int index =3D 0; \
> +        memset(&buffer, 0, sizeof(buffer)); \
> +        memset(expect, 0, sizeof(expect)); \
> +        TESTS \
> +        *hvx_output =3D Q6_V##TO##_equals_V##FROM(buffer); \
> +        check_output_##TO(__LINE__, 1); \
> +    }
> +
> +DEF_TEST_VCONV(w, sf, { \
> +    TEST_EXP(w, sf, SF_QNaN, INT32_MAX); \
> +    TEST_EXP(w, sf, SF_SNaN, INT32_MAX); \
> +    TEST_EXP(w, sf, SF_QNaN_neg, INT32_MIN); \
> +    TEST_EXP(w, sf, SF_INF, INT32_MAX); \
> +    TEST_EXP(w, sf, SF_INF_neg, INT32_MIN); \
> +    TEST_EXP(w, sf, SF_small_neg, 0); \
> +    TEST_EXP(w, sf, SF_neg_two, -2); \
> +    TEST_EXP(w, sf, SF_zero_neg, 0); \
> +    TEST_EXP(w, sf, raw_sf(2.1f), 2); \
> +    TEST_EXP(w, sf, raw_sf(2.8f), 2); \
> +})
> +
> +DEF_TEST_VCONV(h, hf, { \
> +    TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_QNaN_neg, INT16_MIN); \
> +    TEST_EXP(h, hf, HF_INF, INT16_MAX); \
> +    TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \
> +    TEST_EXP(h, hf, HF_small_neg, 0); \
> +    TEST_EXP(h, hf, HF_neg_two, -2); \
> +    TEST_EXP(h, hf, HF_zero_neg, 0); \
> +    TEST_EXP(h, hf, raw_hf(2.1), 2); \
> +    TEST_EXP(h, hf, raw_hf(2.8), 2); \
> +})
> +
> +DEF_TEST_VCONV(hf, h, { \
> +    TEST_EXP(hf, h, INT16_MAX, HF_QNaN); \
> +    TEST_EXP(hf, h, INT16_MAX, HF_SNaN); \
> +    TEST_EXP(hf, h, INT16_MIN, HF_QNaN_neg); \
> +    TEST_EXP(hf, h, INT16_MAX, HF_INF); \
> +    TEST_EXP(hf, h, INT16_MIN, HF_INF_neg); \
> +    TEST_EXP(hf, h, 0, HF_small_neg); \
> +    TEST_EXP(hf, h, -2, HF_neg_two); \
> +    TEST_EXP(hf, h, 0, HF_zero_neg); \
> +    TEST_EXP(hf, h, 2, raw_hf(2.1)); \
> +    TEST_EXP(hf, h, 2, raw_hf(2.8)); \
> +})
> +
> +DEF_TEST_VCONV(sf, w, { \
> +    TEST_EXP(sf, w, INT32_MAX, SF_QNaN); \
> +    TEST_EXP(sf, w, INT32_MAX, SF_SNaN); \
> +    TEST_EXP(sf, w, INT32_MIN, SF_QNaN_neg); \
> +    TEST_EXP(sf, w, INT32_MAX, SF_INF); \
> +    TEST_EXP(sf, w, INT32_MIN, SF_INF_neg); \
> +    TEST_EXP(sf, w, 0, SF_small_neg); \
> +    TEST_EXP(sf, w, -2, SF_neg_two); \
> +    TEST_EXP(sf, w, 0, SF_zero_neg); \
> +    TEST_EXP(sf, w, 2, raw_sf(2.1f)); \
> +    TEST_EXP(sf, w, 2, raw_sf(2.8f)); \
> +})
> +
> +int main(void)
> +{
> +    test_vcvt_uh_hf();
> +    test_vcvt_h_hf();
> +    test_vcvt_ub_hf();
> +    test_vcvt_b_hf();
> +    test_vconv_w_sf();
>

Several more of these were created above but not called here.  Marking them
static will flag the errors.


> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
>

Also, add checks for FP flags.

Thanks,
Taylor

--000000000000c605e2064dca30f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 15 +++<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br=
>
=C2=A0tests/tcg/hexagon/fp_hvx_cvt.c=C2=A0 =C2=A0 | 194 +++++++++++++++++++=
+++++++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target |=C2=A0 =C2=A03 +<br>
=C2=A04 files changed, 214 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c<br>
<br>diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c b/tests/tcg/hexagon/fp_hvx_=
cvt.c<br>
new file mode 100644<br>
index 0000000000..7497455ac6<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/fp_hvx_cvt.c<br>
@@ -0,0 +1,194 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_types.h&gt;<br>
+#include &lt;hvx_hexagon_protos.h&gt;<br>
+<br>
+#if __HEXAGON_ARCH__ &gt; 75<br>
+#error &quot;After v75, compiler will replace some FP HVX instructions.&qu=
ot;<br>
+#endif<br>
+<br>
+int err;<br>
+#include &quot;hvx_misc.h&quot;<br>
+#include &quot;hex_test.h&quot;<br>
+<br>
+#define TEST_EXP(TO, FROM, VAL, EXP) do { \<br>
+=C2=A0 =C2=A0 ((MMVector *)&amp;buffer)-&gt;FROM[index] =3D VAL; \<br>
+=C2=A0 =C2=A0 expect[0].TO[index] =3D EXP; \<br>
+=C2=A0 =C2=A0 index++; \<br>
+} while (0)<br>
+<br>
+#define DEF_TEST_CVT(TO, FROM, TESTS) \<br>
+=C2=A0 =C2=A0 void test_vcvt_##TO##_##FROM(void) \<br></blockquote><div><b=
r></div><div>static</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;=
output[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector buffer; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D 0; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;buffer, 0, sizeof(buffer)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(expect, 0, sizeof(expect)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TESTS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D Q6_V##TO##_vcvt_V##FROM(buffer=
); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_output_##TO(__LINE__, 1); \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+DEF_TEST_CVT(uh, hf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_QNaN, UINT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_SNaN, UINT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_QNaN_neg, UINT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_INF, UINT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_INF_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_neg_two, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, raw_hf((_Float16)2.1), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(uh, hf, HF_one_recip, 1); \<br>
+})<br>
+<br>
+DEF_TEST_CVT(h, hf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_QNaN_neg, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_INF, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_neg_two, -2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, raw_hf((_Float16)2.1), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_one_recip, 1); \<br>
+})<br>
+<br>
+/*<br>
+ * Some cvt operations take two vectors as input and perform the following=
:<br>
+ *=C2=A0 =C2=A0 VdV.TO[4*i]=C2=A0 =C2=A0=3D OP(VuV.FROM[2*i]);<br>
+ *=C2=A0 =C2=A0 VdV.TO[4*i+1] =3D OP(VuV.FROM[2*i+1]);<br>
+ *=C2=A0 =C2=A0 VdV.TO[4*i+2] =3D OP(VvV.FROM[2*i]);<br>
+ *=C2=A0 =C2=A0 VdV.TO[4*i+3] =3D OP(VvV.FROM[2*i+1]))<br>
+ * We use bf_index and index in a way that the tests are always done eithe=
r<br>
+ * using the first or third line of the above snippet.<br>
+ */<br>
+#define TEST_EXP_2(TO, FROM, VAL, EXP) do { \<br>
+=C2=A0 =C2=A0 ((MMVector *)&amp;buffers[bf_index])-&gt;FROM[2 * index] =3D=
 VAL; \<br>
+=C2=A0 =C2=A0 expect[0].TO[(4 * index) + (2 * bf_index)] =3D EXP; \<br>
+=C2=A0 =C2=A0 index++; \<br>
+=C2=A0 =C2=A0 bf_index =3D (bf_index + 1) % 2; \<br>
+} while (0)<br>
+<br>
+#define DEF_TEST_CVT_2(TO, FROM, TESTS) \<br>
+=C2=A0 =C2=A0 void test_vcvt_##TO##_##FROM(void) \<br></blockquote><div><b=
r></div><div>static</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;=
output[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector buffers[2]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D 0, bf_index =3D 0; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;buffers, 0, sizeof(buffers)); \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(expect, 0, sizeof(expect)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TESTS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D Q6_V##TO##_vcvt_V##FROM##V##FR=
OM(buffers[0], buffers[1]); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_output_##TO(__LINE__, 1); \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+DEF_TEST_CVT_2(ub, hf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_QNaN, UINT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_SNaN, UINT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_QNaN_neg, UINT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_INF, UINT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_INF_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_small_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_neg_two, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, raw_hf((_Float16)2.1), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(ub, hf, HF_one_recip, 1); \<br>
+})<br>
+<br>
+DEF_TEST_CVT_2(b, hf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_QNaN, INT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_SNaN, INT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_QNaN_neg, INT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_INF, INT8_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_INF_neg, INT8_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_small_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_neg_two, -2); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, raw_hf((_Float16)2.1), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP_2(b, hf, HF_one_recip, 1); \<br>
+})<br>
+<br>
+#define DEF_TEST_VCONV(TO, FROM, TESTS) \<br>
+=C2=A0 =C2=A0 void test_vconv_##TO##_##FROM(void) \<br></blockquote><div><=
br></div><div>static</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;=
output[0]; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HVX_Vector buffer; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D 0; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;buffer, 0, sizeof(buffer)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(expect, 0, sizeof(expect)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TESTS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hvx_output =3D Q6_V##TO##_equals_V##FROM(buff=
er); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_output_##TO(__LINE__, 1); \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+DEF_TEST_VCONV(w, sf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_QNaN, INT32_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_SNaN, INT32_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_QNaN_neg, INT32_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_INF, INT32_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_INF_neg, INT32_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_small_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_neg_two, -2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, SF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, raw_sf(2.1f), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(w, sf, raw_sf(2.8f), 2); \<br>
+})<br>
+<br>
+DEF_TEST_VCONV(h, hf, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_QNaN, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_SNaN, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_QNaN_neg, INT16_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_INF, INT16_MAX); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_INF_neg, INT16_MIN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_small_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_neg_two, -2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, HF_zero_neg, 0); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, raw_hf(2.1), 2); \<br>
+=C2=A0 =C2=A0 TEST_EXP(h, hf, raw_hf(2.8), 2); \<br>
+})<br>
+<br>
+DEF_TEST_VCONV(hf, h, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, INT16_MAX, HF_QNaN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, INT16_MAX, HF_SNaN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, INT16_MIN, HF_QNaN_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, INT16_MAX, HF_INF); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, INT16_MIN, HF_INF_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, 0, HF_small_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, -2, HF_neg_two); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, 0, HF_zero_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, 2, raw_hf(2.1)); \<br>
+=C2=A0 =C2=A0 TEST_EXP(hf, h, 2, raw_hf(2.8)); \<br>
+})<br>
+<br>
+DEF_TEST_VCONV(sf, w, { \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, INT32_MAX, SF_QNaN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, INT32_MAX, SF_SNaN); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, INT32_MIN, SF_QNaN_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, INT32_MAX, SF_INF); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, INT32_MIN, SF_INF_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, 0, SF_small_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, -2, SF_neg_two); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, 0, SF_zero_neg); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, 2, raw_sf(2.1f)); \<br>
+=C2=A0 =C2=A0 TEST_EXP(sf, w, 2, raw_sf(2.8f)); \<br>
+})<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 test_vcvt_uh_hf();<br>
+=C2=A0 =C2=A0 test_vcvt_h_hf();<br>
+=C2=A0 =C2=A0 test_vcvt_ub_hf();<br>
+=C2=A0 =C2=A0 test_vcvt_b_hf();<br>
+=C2=A0 =C2=A0 test_vconv_w_sf();<br></blockquote><div><br></div><div>Sever=
al more of these were created above but not called here.=C2=A0 Marking them=
 static will flag the errors.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br></blockquote><div><br></div><div>Also, add checks for FP flags.</div>=
<div><br></div><div>Thanks,</div><div>Taylor</div><div>=C2=A0</div></div></=
div>

--000000000000c605e2064dca30f1--


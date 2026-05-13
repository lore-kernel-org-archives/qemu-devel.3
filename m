Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92EECD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 01:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMyef-0000C0-GZ; Tue, 12 May 2026 21:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyed-0008Oc-M4
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:44:55 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyeb-0005nn-UL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:44:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso7543346a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778636692; cv=none;
 d=google.com; s=arc-20240605;
 b=c8OUm9DcU5fcsbQC70OuqXa9Hs1mqsASY5q3UyfdwO4YLGPCTk3U5YnaPeLjgpyWnn
 H5piKiWx67ybMUDAzguQ1ZorwBujqjGuBX5QfCT0hoYf4FJaeAHWGRoqW/g1s3wBNPTP
 cWeOQxfEacctevEsU8bBhxrbxIyBm3IFpB1v3NsmumE41j/FZERLeXBqmHe4QOxTPOUj
 jrG2OgoSWSRobV6G9QAGW77o4kdCx2/b65Hx4Hvqkhr943ji3kWGRe2oG/UlWjYVqVxM
 t6WwpDfENjVxswqlHoswGVxmPpteaYnhdQk15ZZlActYWbIVLztBL8V6rqBZSLdkojvF
 FkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3HFOMOPEH1uVrgWJY0g+AfRpRe++JYxI9ttbyOGlsaY=;
 fh=DJARXRaNDsuZRmRP4n3GqIPk3qdh/8boWVr8MgWN56s=;
 b=B9NnXr6YxEODQpQnSyJOsLddp/uXeCwNLV+m12oTGfZmZea6mrQemfe36Rjwv9+e4B
 wncN6WSolNe0OE96WVnU/aTZaHic9V3KTt+MlJmOK6uuTLaCPh3IogF39ZQnvSaYCluD
 z+tV9HKTi5izAIAB/yHehEPdotb9T2sGOrvKDYSMQWCNsK8IH+iea5mygILUmN1NaSBD
 64B8hP9xjXxuJZPfEox6KGokPKqFBplxzPEelF+MXsBDi2UkwMOJytqkrYijvfL8ed/N
 2JlzJMhGObAqMT4TKCFWVKOWeweXoukzSvWqtVHJNW3D2tGkwraA5b68nX3UcY2nBijk
 Oygw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778636692; x=1779241492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HFOMOPEH1uVrgWJY0g+AfRpRe++JYxI9ttbyOGlsaY=;
 b=AhTZBWFz2buySziPngT+Hk7dG9xGpc+S12ad0l33DRgOvFPk/OeKcNYjVjXlxeqXnA
 Y+VLOn1sdblLMU1qAWgPJhbig2csD4DSOHw48nobilsu4bBafkgVq2ZMzhnxOPsE41Uy
 Ru4iipMhErDpEKzVaHAH4pKeSggI7qYGEfee5pBrsog/j2aSqCPVTpA6/qnjP6Dk7YeJ
 31+YFRJ4I8tt3K9495hRqjYjE9EobntA7KoJ7qjLiaQi1kr2dpWCn59pnIRcuMBSeZ+f
 fNnylUdhfK6w20gr5X3hTObxwjMnhQsrh0w3hyC76Ng0zsFF4mtF9xM8c9ptMntr01Ci
 4LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778636692; x=1779241492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3HFOMOPEH1uVrgWJY0g+AfRpRe++JYxI9ttbyOGlsaY=;
 b=HYzuoE09Oc7dp+clqUg1uklzySuIlZLm7X45Wny7JpRIRY9/fP8SN/E8IUj4WPKfuv
 Gbm+U0jLSV+Xv0hytYpffcwmEL1zmGwxiR2T4gRMvyEyBcXZLsvzYE9J/+0vE/Q6KPyO
 htUeQeGxlcERYnFa2bF+hVnGW0+0SM2yNdfSPTX9oBoEBZ5xmjcO/5TDTInw2PjQRYRo
 jh+ndOLo7IogrgBXP/ooMrsxDzyO6kSBcMwLMHCp3nljfhe8sdpg3HfhLnQog3zKGrA1
 Grh23sv9JwSObdf1jIl1wfaXOE3XRLpJGCTykvJTgaGUvih6QuVQVrjnlc2W/9nUO1TK
 0mNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80qxSVLyUzuaZV5zVLlF3jCho36GYoYYDbl/h5EznM2Rrc9SijM749hkESeD3B/DDFYmvnM1ob8Hhu@nongnu.org
X-Gm-Message-State: AOJu0YztDnScQjwZAFbsNEQmmvYSKk+gfcxf/rnORBKMArRwfqOxRolp
 4AohRSwnO3f03DVMlWGBuP5FbAZTe7mnjFFbuYQqObHIvpDkn9BOpY5yb1R4rXfLz8lDxz3IQ3D
 z9F9TaOzgXsg7CDcDJOi2xVbFM9xI3Po=
X-Gm-Gg: Acq92OHPUq3+ln69WRf2TBMIPCX7cxGtGC03g7TOjSW9eOpjCf/1xEB+yiokH6zKBdK
 hE5m+7DOqwJgWrJmGPJj96+NjZfZXCn2NUasEL4I0OxHYBvp5+bVUc/nsITDxp0JpOd9DOHbPC7
 hxJeSKXMczQ4QXqOYQewDY7Xr6j9vhpiSkNuaZUfZIMfbXpYWmlMH/cz50hCe1wxXyHRSUpkAPB
 hqU1bBn8yFwwON8y+EbcGjXaU+29Mc3/JvFzDc3Fw931qVduQiNanXHdinepUjEfo2nTia8RiAO
 f9Swkf5ZoUB+n81qGfdEqloQB3rdhruQtWwDKw==
X-Received: by 2002:a17:907:9704:b0:bd0:125b:cbb2 with SMTP id
 a640c23a62f3a-bd3dfb5e64emr41254266b.7.1778636692103; Tue, 12 May 2026
 18:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260511072705.3015986-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511072705.3015986-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 11:44:25 +1000
X-Gm-Features: AVHnY4IMTyL3zKUkqmr7a3rqEpMm3U-CVnXjCKgDMYCTJm7AkHirdhqplcfu6HQ
Message-ID: <CAKmqyKP=UB7_KVXB30DnnVjkC4JBZL1ddLig0zQFNJcTtDNQAA@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Allow mseccfg access based on ext_zicfilp
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Mon, May 11, 2026 at 7:56=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> to the RISC-V Privileged Specification, mseccfg exists if any extension
> that adds a field to it is implemented.
>
> Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> with `zicfilp=3Dtrue` but without the other extensions, accessing the
> mseccfg CSR will incorrectly raise an illegal instruction exception.
>
> This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> is properly accessible when the Zicfilp extension is enabled.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa=
-manual/pr-2561/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: Removed mistakenly added #include "cpu_bits.h".
> v3: add a missing space after the Link tag clon
>
>  target/riscv/csr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..e1cd4a299cb0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -783,6 +783,9 @@ static RISCVException have_mseccfg(CPURISCVState *env=
, int csrno)
>      if (riscv_cpu_cfg(env)->ext_smmpm) {
>          return RISCV_EXCP_NONE;
>      }
> +    if (riscv_cpu_cfg(env)->ext_zicfilp) {
> +        return RISCV_EXCP_NONE;
> +    }
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> --
> 2.51.2
>
>


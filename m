Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC49DC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvd7H-0002ag-TJ; Sun, 16 Aug 2026 11:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wvd7D-0002Zt-U8
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:49:41 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wvd7A-0000Bc-RM
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:49:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2405349a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786895375; x=1787500175; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3lc/YXYVyNQukkSpYFLMckwJnPwBfw9sW/bakKCVwuQ=;
 b=mFiDouEmYywLS0TjIpFmqZVU67jie45OlcsBWJrzdXzBGCYAiYLVROz0hJaz86ggXT
 tfbUe42EPQMoJnrR3bxyXnugm+y2/2Qx/4on6MHOefwmrXB92EkKbumSKP6fdmwDi9Fi
 w2eHBKO5bR8iKKB3qmdHW9s6pXhpLhA2/ri91eo3DoF0SGJvOew1maPP8X2rD1PN8vAi
 hiC/OORYqSqpjBjJ5nw9SQVRNnwmKMQzPbv63tVpbDyPN+lbp6m3dreKmWnk2MkK+IMc
 B2Sg3dsfW7L4vSWiPOnc6qKgk0zk/qA7SgeyKUsNpkllinCdNd3K1TMEcdL2q3xtfZxb
 e0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786895375; x=1787500175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3lc/YXYVyNQukkSpYFLMckwJnPwBfw9sW/bakKCVwuQ=;
 b=AghN7CaA/eTevFz6YE3OJRhrrzoSBYv7GnBzb1sZexzxLU2nFSKOMU7reKqwaEPyNM
 N5k3VKa8ng8TMDKQYxhHeKbiLi08DpZv3gkX0vf9qLbw6lFhHlkk1a7W7atZn+dNfHQq
 gspKhmUcrbmNsFBtihAuQCvAG+oWKShg7bUffUzI9O0IAeFtSa9gwPTtrbCjhJMEQE9z
 JANBBBiZCMhI/DBMQd5CMICzCasoigRWHLaIYElrkvItL4oWuI/kNnAq2QpQdBKAYgto
 FDlmSzpSbah3+3Da2YLBUkq/8V/a4Yau92DfBQIeFxIwE7FuOFaLuf5KRTIM5wKRqYTG
 iynw==
X-Forwarded-Encrypted: i=1;
 AHgh+RorFGMHJ27EoyIJUI2ajmTzpu8Lzr9b7UH6V9W9s7bDzfQVRaAugMJs0DYJfdIAbYV4YFG+4QMkKr/f@nongnu.org
X-Gm-Message-State: AOJu0YyKzOwTGcqJdjiWFXCsQ9Mw2kTetyDdb12ZwEhL3FDgnU/2ZYD7
 qlwmZU/qB9IJuMieql+dKoiQ6u4UnYIZZOBLXQMDa5jDTEp2UTkiI6XWEmcbu0keYME=
X-Gm-Gg: AR+sD12IoI4ovWnW1HOA8gGWSddp8sMXPWNWT8WSHKWJs2FvhSVSrBHUZXqlziBmCSI
 9xZNo1NHJViWymntrf1rE9Xy2ULFGbZ2NmVeieexkAb+/aaMltZEJm+Nga9aB6Cnvjqr96M4G4B
 UE2z8ww1q2RqOZyQSieTXi4uxxDe/iRf8INm/b/9tlvYL7TTSssZsiytfiF9TXCuxib0skUyRXj
 YZPWhKoDQRVODH2aZD98EBtf6bCev5EnKPM0Z2AdFQ1GDJy52Ks28b5vfTg6Lb0X7GCKrWFdUvG
 tU3QSKe1VCKNVLG6soZ9wWRhg+1bFeeur73qJcjL8Nndy/al6jVxZadcXXzfE3XbX7Fvw3btiHw
 0WxRtcbxsoPsWYvVZ0XhgYpUwNlXiQy/8QgMZkFSJS72Rp4ZIaI/3QE/fTjGe3Xq99mc0Cjm6O/
 TY4EiBDoIy0f/1iw8cPsrm+foDgobVNpJGl7XYUSPmC2hXqKyDOp3f1mIabZY5n9pgLgyfiyLDP
 sGOVDOyE/zcJ03NB/bEFPPzX4hNlYaTV8c=
X-Received: by 2002:a17:90b:17d2:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-3933e60c1damr19032544a91.14.1786895374683; 
 Sun, 16 Aug 2026 08:49:34 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e31b8fsm1832531a91.3.2026.08.16.08.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 08:49:34 -0700 (PDT)
Date: Sun, 16 Aug 2026 23:49:31 +0800
From: Max Chou <max.chou@sifive.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/18] target/riscv: Add packed SIMD helper framework
Message-ID: <aoHbEVwVvB9BMSpW@sifive.com>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1032.google.com
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

On 2026-07-17 10:06, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>  target/riscv/tcg/meson.build    |    3 +-
>  target/riscv/tcg/psimd_helper.c | 1656 +++++++++++++++++++++++++++++++
>  2 files changed, 1658 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/tcg/psimd_helper.c
> 
...
>  riscv_system_ss.add(files(
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> new file mode 100644
> index 00000000000..2948bbb2a86
> --- /dev/null
> +++ b/target/riscv/tcg/psimd_helper.c
...
> +#define GEN_PSIMD_VAR_USHLR(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
> +                            ELEMS, BITS, SAT_FN)                          \
> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
> +{                                                                         \
> +    RTYPE rd = 0;                                                         \
> +    int elems = ELEMS(rd);                                                \
> +    int sat = 0;                                                          \
> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
> +                                                                          \
> +    for (int i = 0; i < elems; i++) {                                     \
> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
> +        ETYPE res;                                                        \
> +                                                                          \
> +        if (shamt >= 0) {                                                 \
> +            WTYPE shifted = (shamt >= (BITS)) ?                           \
> +                            ((WTYPE)e1 << (BITS)) :                       \
> +                            ((WTYPE)e1 << shamt);                         \
> +            res = SAT_FN(shifted, &sat);                                  \
> +        } else {                                                          \
> +            int right = -shamt;                                           \
> +            if (right > (BITS)) {                                         \
> +                res = 0;                                                  \

Here may has an issue that a rounding right shift past the element
width does not degenerate to zero -- it saturates to the rounding of
the element's MSB.

According to the P ext isa spec:

  "The SSHLR instruction performs an unsigned variable shift of `rs1`
   using the signed shift amount in `rs2[7:0]`. Right shifts are
   rounded, and left shifts saturate to the signed 32-bit range."

    if sshamt < 0:
        // arithmetic right shift with rounding
        x  = zero_extend(64, s1) @ 0b0            // 65-bit
        y  = (sshamt <= -32) ? x[64:32]
                             : (x >> (0 - shamt)[4:0])[32:0]
        X[rd] = (y + 1)[32:1]

The operation Sail code shows that every right shift at or beyond
the element width collapses to the same x[64:32], which is the
element's MSB, and then still gets the (y + 1) >> 1 rounding.
PSSHLR.HS and PSSHLR.WS have the identical construct at the 16- and
32-bit boundaries.

Maybe we could fix it liked:

           } else {                                                          \
               int right = MIN(-shamt, (BITS));                              \
               WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;               \
               res = (ETYPE)(rounded >> 1);                                  \
           }                                                                 \


rnax

> +            } else {                                                      \
> +                WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;           \
> +                res = (ETYPE)(rounded >> 1);                              \
> +            }                                                             \
> +        }                                                                 \


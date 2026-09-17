Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57BC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7J4i-00020c-Aj; Thu, 17 Sep 2026 16:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7J4f-000207-Tp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:51:18 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7J4e-0007Gl-7V
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:51:17 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1766so1067483a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789678274; x=1790283074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S1NLi4QS0kW/YsWZ9DyyaAD9U0xrPbTu7ggvIBtsciY=;
 b=qDca3R5on6JxTLG6HZb7QtP/palISPTao9MA1TTSdm+fnMsvPgZixaw4dalQheXS1Y
 DFCI1Zuc6W51kyvZzcKqO/rnaLP2rxmp1Lk1cwvm/Db0ZqBpwKmNIoMr3Qfl+7LQE+zy
 /dQOSlQNgnpEUfEdNipnYerPtesD3BSTtgjoSrze42O5blStxfcPPqmu+F6izelRBW97
 A9Afzp1kOTOBJSM6Jfc8iJQW7OZdL5z9i5wysVZrkWqL/yMoleMg9pelKY/0ghgh/qS/
 9yGhjo5/BxznUz5XTT/C7bjKzMuT67b4WpVsrSIReW3GlE6TVPYmmOCTGt3vA72Q9BU+
 FIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789678274; x=1790283074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S1NLi4QS0kW/YsWZ9DyyaAD9U0xrPbTu7ggvIBtsciY=;
 b=1YA5Cw4vUid7kZI5c+cy+0bw20E9H1W7TLoWKe4XL1NkJxp2XTvRayFI223cdPMBc/
 va3KQ7A91jS1dp5vqQpimFmJG4I2tJIj+J5GMbd4nj5FN1QGRT68XywPa7LhR02zK8Zl
 CH1TSla6x6eZDjsC361r902sKDiLxZX/16oLyxJ7OJrzTDe2A3NpG7nZvYmQrSyKR3q+
 5YHSjZTRkTSpcm5ip//VVLv2xTDQ3v+nDOWauoFhPYVUVHk54QIGd2Eu69ZNY3YoExuV
 /8po9uK/Br4MP31CXGycS8id9VFrfQyVzmeUd/vPP6yCdYZBRqCJY9zEMpMe31iat9lr
 ElJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMza38jjRfney8KEji81M1g3k9hnFWvApGq8NshE7rkSzSxHsoP0Vi5MKv0RBhJbzUrC1NOVBSS5Wb@nongnu.org
X-Gm-Message-State: AFuF++kkcIff/9xgcfSsT3p5M+yGgoXZR8W2Ba8+M6X463UuPQXufJvb
 NmxE/3vj/30fEh48ulPAhQnGOgPEQFej+QVWILkwW4xSRFzanNW10RKFTf9nU5Z5ITY=
X-Gm-Gg: AYBFou0MXjr+74eUWIiYWksVx1rl6yq111Awzvovqyh61VCcfbz2djzh0LcX4VKI3tU
 sFQd+Go+ozQteM92TXuzSEJ7okLoW32qvZjnJRUj0LNXFDEka1zcl19ViQtgUWospfviPu/0x1N
 Zv6wCBkT0Jd9cOSP9lSNso6BtTL5SnMv74mXdCVKLx+45baFlKyLF2cETSfVOa0IRdw2sWKSQW/
 eaW+P7mw8dm1wFHBrFV5oCJTsvO+Y9oYY1RvtGLdLaUMuQCgFc05SLHn0HYCzssdlBG+ULobCmS
 vW4nGqQtmiTZmclEUf4yGe1Wzj5yyJVRDfZOcylBDEicTCUVf1QnYaN8GIRd84uWhkjYY9s0V3R
 +jpktu6BY4m8uJxIO/75srFXj6L/bQo4sTn8goezs5HWJmNYKbsFJa5hv+rxdMGpd78IJgpydrF
 PgG3L/ZqxhFzbIhn6DpyitdwKE+mxmDU0jBsMewpbwHlqq2wmGK2lDgyYcH6tlEvCfZTx1fwA+4
 CcpRkGQgcGzAp8tYg9KISmItwcBCYj9HIKhctePHsxMyao9iABTuJAkHxDOrg==
X-Received: by 2002:a17:90b:5291:b0:39d:e54c:a28a with SMTP id
 98e67ed59e1d1-39e54bba9e8mr812124a91.8.1789678274228; 
 Thu, 17 Sep 2026 13:51:14 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5a4b:653b:1dce:569f?
 ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm20571690eec.24.2026.09.17.13.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 13:51:13 -0700 (PDT)
Message-ID: <48d3cf9d-4d76-41c8-aa73-e1cc57db3f40@linaro.org>
Date: Thu, 17 Sep 2026 10:51:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/riscv64: Set vtype before whole-register vector
 moves
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>
References: <20260917133755.1049697-1-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917133755.1049697-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/17/26 03:37, Max Chou wrote:
> According to the RISC-V unpriviledge spec,
>    "vset{i}vl{i} and whole register loads and stores do not depend upon
>     vtype."
> The whole-register vector move instructions reuqire legal vtype that
> trap when VILL is set.
> 
> The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
> OPC_VMVNR_V.
> 
> Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   tcg/riscv64/tcg-target.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 2ce9d47a633..e3cfedb579d 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -778,6 +778,10 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>           {
>               int lmul = type - riscv_lg2_vlenb;
>               int nf = 1 << MAX(lmul, 0);
> +
> +            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
> +                set_vtype_len(s, type);
> +            }
>               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
>           }
>           break;

Do you have a reproducer for this?  I ask because I still wonder how 
this can occur.

Given that

(1) all vector registers are call-clobbered, there should be none live 
across tcg_out_call_int (which clears the remembered vtype),

(2) the first vector action with no vector registers live must be a load 
or movi (which will initialize vtype).

Performing a move between vector registers when all such registers must 
be dead is... wrong.  It indicates that there's a bug elsewhere.

I'll throw an assert in here locally and see what happens...


r~


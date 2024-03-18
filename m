Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D1C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJrF-00079d-S5; Mon, 18 Mar 2024 16:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJrD-00079V-Kl
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:45:20 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJrA-00057m-Ex
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710794713; x=1711399513; i=deller@gmx.de;
 bh=+Vhe3ybfi7sU8n0Kmk+CeoRM4m92AKhUTXho9MZnuZc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=GE+LarrDJ2RlwEA65Koq/ZP9rJnjI2h9ypoDhEe3gF5g4SYJGAyOy0B7xTFOnKq1
 FUMDCfm6ki3KpGy0l+uBz2VPA9xoU1E5o7Ha438lJcCKk/kYrSi+qC/GjjxNTBLM/
 cuSa670Iw5ExN80+md5uVVX9F8YABZRaiv9weVTkTIh6LJyC6sRASxyiSDGpsJrI3
 34P60Yn0q4qWaaRsYur/BZX/cGF1V7vdDp8+vdmuERVLtPy8aRI4ohq2zcRxLemKe
 qzADK9gLNdCNCEG418+lqyQcShf29Z1pILF+kzbkrp9Eb2lvjHVQ/+FOnbHgc2iKU
 C9RJgsdu7tHZ1Q2/aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1rSb6v13kW-00JrTd; Mon, 18
 Mar 2024 21:45:13 +0100
Message-ID: <298a0835-ff36-48f1-bf98-6b3d8c54f10e@gmx.de>
Date: Mon, 18 Mar 2024 21:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/hppa: mask privilege bits in mfia
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-7-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240317221431.251515-7-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OvzOBorg+Uj7OK1X6MEGIsCt+NB5u9s0iDbk+Y1tCWLJ9r26FRu
 /5Nfx9jzdfqiFKQ1Ri2qA/11ohiqzMZ7GBPq0+n46g19Kwv2DzjkVsuUWQSf4i6pjcbYSIO
 aze+jZfhmTk1eTmD/pzf9vYfWMLBbhdb6cQjGnM1lRGrWhTfbtWLW7m1r69ySlPGtkcUcST
 zaWv1DksEz2byXE8Z5DEw==
UI-OutboundReport: notjunk:1;M01:P0:dwH6Q4NZlmg=;f8gSp5kakD7pAYXptzWJWddwFFy
 D0FgbfHPMU972GS5sLgaDQZId1z2WkqlCsfLTQNOw1lIdoxLtrNwpIiwDY6gjC0KaVDGXuZyp
 q+Gb+Vqx1JAgxZoq6DiLgXCti5CCdOC0Whrv3c3anN+fvDuxnDgSSC+nm3sIakjVZJPNdsGO9
 F8ZIdwMVTagx39jKz2cPL8HZl85BTP0k09E8rQ19ohUWuijSHNpTDIe94mcgI/ebqf9B13hoP
 VkvLX9d+MQNBr306FzY6AY65GIVgPA7wvOVQ6FafTrrdikOiOJNFubfrwdHlGOEu5fxGEMjRw
 u2BT3SW+MqsGIrvyJxu2t4e0wy4rADHAf3DW0NHDWAgPhMmXTb+RfOX4tzu3a0SwV0oabIxIj
 aLd7M+Dx0AxCyZ93hbfJJlm7j4W4XerfquSiyJUYM+UmHBu8dmdBnHSOKlUx7I+zB9jNK8otQ
 Mht0hVcdpr56+OqIF2xP85fIJ19lpTpLBws7i4USUX2iNxAuWnDloe9kYpXvMjsgIH5PIJZUD
 XfYXHYFvULqOIeFZyaMN8MOEIDTqyggQLyGDURbwW8U2puv8coigBZJY+uLgnOsgtM3xu8gYK
 28MGw4BS6PYPD0lZvvNZhdnzttH0S8wNTn2drne9zp7P/cGdgEVnfFFvTzg7EDR6C2g6SzHKp
 bkBOcd+E9FkoB90wRV1e7LMnjK1HAP0OGLoZ+PnBQ/TOCCgX1PVaKFbExCpbvQV4bcv1Z0lgg
 5sy9EtFzvMrhABR6zQWe4X5ODn0s20V0HAXSuQVhgeHzLY54QaN0MtXB9dq8ctRGoBh7XdL+X
 Qw9BNZFPZ8FC7rSZ5ztvvUoeVBADzW5Ia7D0pmVmshX2Q=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/17/24 23:14, Sven Schnelle wrote:
> mfia should return only the iaoq bits without privilege
> bits.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge


> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index a09112e4ae..e47f8f9f47 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1962,7 +1962,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia=
 *a)
>   {
>       unsigned rt =3D a->t;
>       TCGv_i64 tmp =3D dest_gpr(ctx, rt);
> -    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
> +    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
>       save_gpr(ctx, rt, tmp);
>
>       cond_free(&ctx->null_cond);



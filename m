Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D4CA5FB1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBalK-0002HA-6q; Tue, 29 Sep 2026 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBalI-0002Gv-7L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:33:00 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBalG-0005Wn-Ik
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:32:59 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a47d6146d1so1152739a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790699577; x=1791304377; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SQIJACSPZxrbxV6U3+nLb5F9/PRZU6Wz/Hmu+O19uy4=;
 b=U9b6XKdXZC487AxM91B+qdBDrrd7qIDBNOYr0RnZXXlfB/pj+LhcGfTWzTuVwil4l6
 xhzjqQhCt5HGOUOZNj6ybMyWqMAp1Tcf9RZYfpJDefWTEg7Z+vbwkMmdy8sHDGiV2Npa
 K8I+oiL42TqGU58/nKYyJD4dAYgz+UvE/SxkkWUxJa4NwWinp6x+j/oYxHUFIb3Gky9m
 HAoW1kK7X/Rw/fdg8gYHmKpVu+AKeO0SQom1ZveP7x4h/YWRiCJLjq8XECi2hpgbnlrL
 tuUBcGCNNeM7BckCpXAL34ywEHQsiPDMhGPoRNV1Fi2m0d88cEkThsBMtMDZ++vZdEH8
 SsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699577; x=1791304377;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQIJACSPZxrbxV6U3+nLb5F9/PRZU6Wz/Hmu+O19uy4=;
 b=thIsTtts+SgW/hClOJw/jybxSIBqjFgYK4QFmpEhNgxaqfCbhIoYz7ZrDsvBNfzjXQ
 tVk76NHK9p+hQXGoeTuGYCeu6MOJS2L5x5f/ybKKmWRC9nc4yX2AIUu+6Oe0xmMv7Umf
 l+ZN45dQH6FIZN43TTHk2tzrUH3x68SW7uRpFhXQNIUxyKCPFhgpCrQQ8PV5LhSkLEo7
 +DdycKq8Yclue2c45jj9vMi2Z8xqripLR1dZrhaDzMMkJjiUFykGKP4nag5IdiWE5QYK
 ZTM63wQuMsos0KsuzQi+tGrrJFme397juxzspLTUr5v2njFnTBGSKZOEcx3x0gptFiwh
 PS9w==
X-Gm-Message-State: AFq9FYKt5CzvTg3UwYeaf4O9MtJihOkiv1rn7n3DzHyIdr+U9AuiF4HM
 HFqLv/U/FKxLgM2gUuUSYS5RAfv/xupazgw83v+HFRS3EimGDRvcg0V1q1Kg/VO1DlM=
X-Gm-Gg: AYBFou29Frg+VHfEuvW81uN4MIWrT5/K+HNwx5Ftw5aGNr0p0rTc87yNyUKEdsXtv5N
 8qVpRr92v+FQ7RHl2ATd7O+3loFB3NGcxlPqdHstd3av4R+Rsqu9lCfHeAdcD1aya2svZUw8kgU
 gUKZabHHXzzKQ1Fp0V/wCA0s6h1ByNRyeprteIBjqloxXhYyakhL6nodQsnZTQ9zF/EEknRdGNv
 Xmt8RT22+ek4N2H+0r1MVKofwovIPAMIT8aCc8fYeo/bsyNuBGN6jQNplBw/xJnlLPsv8nuvy0D
 eeB0Wr7dT1UGtzFQVJmIXta4iYP3xvS9olk1DU47c5WJG8fOSV0AVLiGccp8ngpM708CZEplK4N
 qfr9U3XbmsXiwANssu4IoiZMEa7EnO25npoE4bzvM6HRoWGesnKGKuk5ObzGGFk0JLVu1Qab4Zw
 5iN8mXDuJiss7jdhe0tZtM5NHTao0JBETNOMR7IMpTFJtYZbvWpVreXMM9yc3ZEezoPfan7AMIP
 d8lIbRd78wBkaluCaRybPQ=
X-Received: by 2002:a17:90b:2b4e:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3a49dd72c3bmr1470057a91.40.1790699577065; 
 Tue, 29 Sep 2026 09:32:57 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4bf194959sm14605a91.0.2026.09.29.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:32:56 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:32:52 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 11/11] tcg/riscv64: Fall back when AUIPC pairs are out
 of range
Message-ID: <arvoIoyJ9qBu65Ue@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-12-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x2b.google.com
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

On 2026-09-13 14:08, Richard Henderson wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> tcg_out_movi, tcg_out_call_int, and tcg_out_ldst only check whether a
> PC-relative displacement is signed 32-bit before emitting an AUIPC pair.
> This does not account for rounding the signed 12-bit immediate, which
> can require an unencodable positive 0x80000000 AUIPC contribution.
> 
> Validate the split and emit the pair only when it fits.
> 
> Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [rth: Drop 'ret' local variables; update tcg_out_ldst too.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 54 +++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax


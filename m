Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22A5CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsMl-0003Yx-Bn; Tue, 09 Jun 2026 05:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsMj-0003Vq-EB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:21 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsMh-0007Rm-Vo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:21 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6608c1a4215so6143285d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995799; cv=none;
 d=google.com; s=arc-20240605;
 b=XP504SMtNAmADKRywrNIbJMg9NP/hPfmZripAZON9V/nEiNgBhHoY1z9Hi3IWsKY74
 zZpTj2/cc3YkkCzhSpVqF86Kk52fj5LiiIHmcuXIwDCY6eDjh2U2jrieE6OZqN/LSiBJ
 jOuNTXaW4SnSKp+ObPB71PPiIfDrRqQF32vlLPx++b6TuDJMVQV6mSpuhZarmnLwwCJU
 0Ks9Ct0o3HV9zNNgUuiSKAbfephREpt+ASitnz5l6TN1mz2AUKJNBQRHlZEaYbC9so3n
 mk1NYIBCAj0jI39msrPWj/pMucXYyWsTcqKJ/hOW5gu8+wZ0T5ygFxNznVhwtslvdqzy
 GvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7vFFNgG6Y1h/fjTGy+dIXyOOOesTIEGCz6t9x/u55ns=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=BSiK+UNqImSBtHqh8CgPMnGblFOhMcck3g0c5Vqf4sRVN60Q1plr6NsfgGZt2vBoR/
 kZ/AMqHmIKiS3yurKCqsX+LTWuG7S23LngbKWTKkaFNXHIAD1k3OQnh4UsHAR0frhXXZ
 7WMdjPBr88PaM8cxUsAWSSfQu6gYMq+GrjtIh76z73ZNSYTQtta1MGOs7MwbsAd+BDkT
 j8iRiF12xiGVmdS+v46DnGoD8QAMAx1WMBTXIy0UJh22pTOy/tisNo4gki5ujfgLpoKm
 BAM8ByKRIIojgoV5UAIIaa3YNqAKPP4sVmrYr9JbfeLUuIVN/6kwSZpAROzs/NcxgxuS
 M9gA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995799; x=1781600599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7vFFNgG6Y1h/fjTGy+dIXyOOOesTIEGCz6t9x/u55ns=;
 b=vltaHCY4Kv+Tfp0gKNEPpTB4BcOycTTFfJA0eiF1+Jh3CHBJ6ncUmOZui9QQe89bYh
 w2AVmIHT8jG4PUBcSLCqx+MfGHPXGFuzV5+Q2gzygfmIbZjl9LgATWoeX0qsNX5HRRzK
 1huZlKQJh/Ba5dLuYvI08kPR9XLlic+InU6AUEleGgzU9EDPN+0i7g7k3YSOcmiOIUto
 6aLRnctM81/SXP8Nz8LO9XYyKx+dcYJCLBlbsavoDpRvT5/Cl2H04aqyl+tfnlzxaBrt
 xj3nL/fGoCR3Qj+i8onlW/TsvEBV6ormLyuJ1fcZA03u/u/gS3eEB+kiz969eWsGDIff
 MDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995799; x=1781600599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vFFNgG6Y1h/fjTGy+dIXyOOOesTIEGCz6t9x/u55ns=;
 b=DzfAC7M41z80ShiWlHAFlzRB8uTE/mmFDMGwi9wbFZSmpVu5nwEfYLxiIr81/+1sWp
 5NKNULxep5ACXOnCpoxNxsE0/AIoJeAD+qyVsdIoSRbBeKQmA0CHLPrELdf8Fh36djJw
 xN9QTdpyhcHrkvG2DVSdmo+0tFejxM1D4GLN24hNgeQGQ92xFU033+DcOlZ0CEffC2Gz
 vmPKgjwonO8sgKL9KNraVOAY8SPtkVQznNTeoMGr6v29vrr2jAtYLMlyCE2XLudSttQ2
 x5rWAS4BBXplfnwAyfV7IOyiRkSJrTztGY0R27tOjexsIA08YkVT5+dTJKAoi4fzygvu
 Jrdw==
X-Gm-Message-State: AOJu0Yw7D9K3j1Rgt6xVYE8QCe7HWRzskjdYbg1T2s9BJsKV7iD4WPL8
 Ow80xtd92A58doHqNDRWDMUHon5nRn+JF9QQgIQTB/hR9slQaxlt2In7DROisTihPdi1B3Fe9wW
 Glhy8NYF6LIzHULsZVjrr5vZLAPKwMURRprUdIMrGdw==
X-Gm-Gg: Acq92OFsP2odxAdkIzmpbO1Wf3zREOmidaaH7Z6fbX3YkVviy6hdbZQRhrVzxGjC3H1
 fGsCZN4a1jx5DdI3sxuGQYeFqquO9I7cRCk8hl6p7QmIAj6/1ChREj7+rySvAXFUtzseGAzWJo9
 GlzQnlmvnMvSZwg0vjDq0rt5nAi00i3MNL4GbmUJvOPwLesESFVkRljK9jPF0Mvg2gS8ek37kLe
 5TKSLWHGWXbzb8lzWwE0EtA4kY3d+xuXwdNRtUdvbEFIKCRH37YZF99J5mxV0Wa0pfnN2jHdwyA
 9UIE/bPKBB+kTXhFsZPAHIGlBBZnq69Q0dEhJ1k5Voq1WBtnjpwxiV/kDV5htXeNqu18l7SZc08
 wPA==
X-Received: by 2002:a05:690e:12cb:b0:660:5b90:b43f with SMTP id
 956f58d0204a3-6610afc78bamr12353051d50.18.1780995798610; Tue, 09 Jun 2026
 02:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-19-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:03:06 +0100
X-Gm-Features: AVVi8CdgDE6mL4HmO5gjahxZR8cgWbrdO2fcNxgj1fVmINtf0y7z1kAEi81iOpw
Message-ID: <CAFEAcA9G=7823dyxTNdpmx_06O-HR8=Vo7JFZK4eECNhvKVOvA@mail.gmail.com>
Subject: Re: [PATCH v9 18/45] target/arm: Implement FCVTNB, FCVTNT for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index df2b89cad6..63fd1fe3db 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4104,6 +4104,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
>             a, gen_helper_sve2_fcvtn_bh, false, false)
>  TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
>             a, gen_helper_sve2_bfcvtn_bh, false, false)
> +TRANS_FEAT(FCVTNB, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
> +           a, gen_helper_sve2_fcvtnb_bs, false, false)
> +TRANS_FEAT(FCVTNT, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
> +           a, gen_helper_sve2_fcvtnt_bs, false, false)

Also only streaming if SME2.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


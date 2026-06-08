Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71732CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWBD-0001H9-Ax; Mon, 08 Jun 2026 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWBA-0001GT-QD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:21:56 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWB9-0005ev-CM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:21:56 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6603246b66dso3996554d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780910514; cv=none;
 d=google.com; s=arc-20240605;
 b=XFSc5Ly+egO8PtCAPtYNRpU/LcrlO+AD+PDBNqXH2lHKvmajz0cMv2+/KzKakEguRx
 TzD72/FiF5b+kcaYrxCaAukvL9iiK8sgyAzYeZxDGeYGveH3cVwH5dHtAPeICpPKh1rK
 VCT6wBtWTlk4LJqBfQjGKXpcA7nM3OR8+YrPfsHv+M6s/muqdZ/8wVLY9Z4CFFwZU+I6
 2GP0kTUouV/4mltnamsAa8LZhildLckkwwNJFAiZHSdrLgNHfGAVxChbbZ40sRenymZq
 5A0B5D8PhnmxYpQBMk11D779yWMxGeRVGswG3YmAAzGq9PE2FSNtG1/ER/6mdRBLJ+ag
 kKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WWPKMY0+USTCpI/OCDKc06CKJ8GwzXKsv+QkNY7ckKU=;
 fh=YBFN6sLm21gmJxCSu10/1CqbRgX6DuaJxwQ6OELLRx4=;
 b=MvhtDsXKSwPfJaEK+HitO6RTQ6B25ZHAwU2ecnOp+7sGMsrrxQOrH27i1WkJUHcNsC
 TfDR1v6k5n0Hrz3fXvJsnSpwbNQlbfb3g4TaeDUK5iGZ6z8rgwFTuqEFCr3CuyDMer4W
 LS7OIYFHwmnrt6UYFtcLlaZ0cFJKkQshHb3bo4ADCTwAT5gsGwE1CZM+N7D36WT4lYzN
 q43ZF8fzW8AZv45CMLxjxL2b36/HRqBVuVfotR4jCdt4Yq2BC/e76neeXO6qR5qvwaLv
 0mAzAdbtS/xGFVbuaSp/pzVIeAGu1Ia5fZBqm14Ohm6Hpqw1PrwaUogszoSYWFFxoeU+
 A4oQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780910514; x=1781515314; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WWPKMY0+USTCpI/OCDKc06CKJ8GwzXKsv+QkNY7ckKU=;
 b=ACgF8J46CTszmvc2nYASjI+itakcg1H/wpklzj8eGQckdF2z6e5gpKyhB+iEwhuSRv
 dwJFuBps+s92Gv+oD4mJDF62VmfDK+PyqDaO87VOOqMKqF34B7Nf3lP2ZRfHwgIjhCSQ
 rnzPdh+R+DIfLRqLyVJ3nodnoBFpsAJkYa5oad9I/jovF03gbRvWZ7qFfle12ItgC5zL
 oKx5N8GdbizFjiFW+X8pWhSRfMFZPLC+uKlWZ4Rz2LzoN0pCOtuQkmws/npAWRw6NJym
 sXvy+j6jLyQU/IBJLH/98SKCi/D+akB0eNZaAnRjD9IEadqWMRbiiPENdk/inpHkJY9X
 EupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910514; x=1781515314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWPKMY0+USTCpI/OCDKc06CKJ8GwzXKsv+QkNY7ckKU=;
 b=Mv7kqvIdjzZkQAv4uJdZ4wYGhN4/MDkWNzkMTXxsQfUtxC4jgPicLYrESTOxlLq0v3
 BwJOAbsnrpdYR1+BMNP0vln/USY3akeNh0fno13q8EB5+4twET1q29M+bHWwJBQP2X5O
 Dl7uR1KKGpK87t83+u6dXvDXek/86YpSoO00k8oG0HogMIJfMEu3o/YAHPjhWD53e6RZ
 OwbXhekzZjL8E10HmJRScLRuqTukbHY8e4JOUXAJ//F+mbcKVMtgMSdLJC2p+LH33vud
 gW1Z0nXTU5fFawQam63oHBrZvp7mWjcQRJEO32j/aN7X8Sb4PjAlkLO/ovZuxFoldJnu
 K38g==
X-Gm-Message-State: AOJu0Yzjbdj82ythmtM04SOmk5oH0LqK7doNNVD6vN/Kz2en/SHISxpE
 mw1pkBvNbIoNYFrpSDtTa8K0o8qtBl1Bbp22T0Wvmcurwm44aHO5wKnBwPsm1NQ5Kc1MbjdrIvK
 zWkqs/meP1Rc5BqmGTSPyGAKnxCB+sZrsTY4EqMIR5w==
X-Gm-Gg: Acq92OEzAEaPVNDeLH1tD1l8MHkBVV05mPGmDTigs/FeyJDi3jNK7J6zcEJSts0mc8X
 QPpwgQV7ShdZ8zBDBg2x/nSTRYKbRDajLqSyLV5+BHrhkngJU2N8zYeiMabgQwhMuj2QPpTYWpz
 ALc+T+GImQNy/xF04UykmvNva2FHOetTvENAKRxGQAcq3Guu0OqRnqK6MChGAeNcJm/ov9myx5+
 FkXSQd7JR22YSNVq2iY+3fAFAhGQfnJSHpyGCujVQ3W6f1Hauz0/KjQue0UiOlWTZQG19R6acte
 KsAu1LdNzpVdDaM6AcqD4CXv6hHprp5lcVhfSrR8IdfeHUVWiuIIxfq515LgYtqO/FRcTD/x9Ok
 /qQ==
X-Received: by 2002:a05:690e:400c:b0:660:41fb:6728 with SMTP id
 956f58d0204a3-6610692f192mr11997613d50.0.1780910513919; Mon, 08 Jun 2026
 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-24-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-24-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:21:42 +0100
X-Gm-Features: AVVi8CcnXDyRE9OD8olIbzo_B27EuV-GmM3z8YdJIEJ3h_gJAcr3rXOx5YztA0A
Message-ID: <CAFEAcA8Wx4-=MwOiwTK5=nwVmri3a54TZcD6er9XLDXhaCA6FA@mail.gmail.com>
Subject: Re: [PATCH 23/25] scripts/checkpatch: ignore spaces required around
 some operators in C++
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>
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

On Wed, 3 Jun 2026 at 21:55, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> C++ has a different style when it comes to space around references,
> dereferences, so don't report it.
> Also, closing templates with >> gets wrongly confused with >> operator,
> so just relax this check.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  scripts/checkpatch.pl | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2189db19f54..c74ec070c53 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2621,6 +2621,23 @@ sub process {
>                                                 if ($op eq '::') {
>                                                         $ok = 1;
>                                                 }
> +
> +                                               # Ignore * in C++
> +                                               if ($op eq '*') {
> +                                                       $ok = 1;
> +                                               }
> +
> +                                               # Ignore & in C++

I think it would be helpful if these comments said why we're ignoring
the operators, the way we do for the one about ">>". Why we should
ignore "::" is clear (it's an operator that exists in C++ and not C),
but * and & are both present in C, so we should say why C++ is special.

> +                                               if ($op eq '&') {
> +                                                       $ok = 1;
> +                                               }
> +
> +                                               # Ignore >> in C++
> +                                               # checkpatch is confused by
> +                                               # >> closing templates
> +                                               if ($op eq '>>') {
> +                                                       $ok = 1;
> +                                               }
>                                         }

thanks
-- PMM


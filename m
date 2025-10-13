Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFBFCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Iqq-00044w-7Q; Mon, 13 Oct 2025 09:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iqk-00043Z-LB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:44:32 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iqg-0007Jd-RM
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:44:30 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63605f6f64eso3372459d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760363063; x=1760967863; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BAGXyK7tz1U/Aykx0FVIpMivs1OHmAVxS7OdT8Q1bBI=;
 b=u8Wlf4ndqs8oMto2CxGIR6CA+JXv4YbkcLTuPyzmRzbWDo51SAYxstDyTNdvsoLEJq
 CFlYCuN+UE6CPgCkdaNEKXWaWR2E65RnweqP1KKuqpZfE4NNGYnjnajEYSrL6W9I0nYO
 B1sQvI3eF6JT9lXI3Q2qOEj0+o368rXwwxk4tfVzWNyf7CLTQAdYXh/VhNto8dHkUNLI
 +0/8keqCNP3aJcPOPydD6k+3JLfhCuFBoPVGvboXcs9QCik6aCrPv0VjsLfPvj4jIk7e
 VtX94742HgLdV17fomaLVidtMSujpbw/Q/+57W+sb4r2HY4o+1/hzEiezAmlqcfV0dnp
 hZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363063; x=1760967863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BAGXyK7tz1U/Aykx0FVIpMivs1OHmAVxS7OdT8Q1bBI=;
 b=f7Xv2oMDPI+R5uybxuDGhskNqiw7k42jgfCKykXroPsQnlwaKHm400wVfTYig1lTeO
 8uuaRstKQc5Xf8Cp7orSqTYgwMvKHrqZSpIlB65+NJY0zcTIGNbsiDomhUMwwFS42DId
 ct/H/ygx5rvwwcg0/8cYbfAk/H5MPKv8O2DH23JK3+ykTl/BCMtOmSquy2ahy11KrAU6
 w/Zf+Zli7e+bdFQArm2qVXqHrGQ+O1VdviK2P8suBP4tagmWw8PNIBJO35cOfsxhwuzs
 rbsTDyOPIH2Rahq3DlID7da9kcI44grxNsgU9cjlvx/T5oetSG5bDz1ui+dBQxzcES8T
 jzBg==
X-Gm-Message-State: AOJu0YzNxCyOV97fyD+ZhFprETfgihWCFGmS3MU8FvXt1SKEY8VpdK2y
 EuXGRCpmSRMwxbDlMIjOyj4hrnU4jj+LfFmrOP7ANqKT4bk0zozl1PK2wO+hQ2GXIGd3DOTVX60
 HO8zWVM3X9pMdknA0t7v7JACust0oFzYNkzuIuosfQ3Xfa8nPXHCy
X-Gm-Gg: ASbGncsAHR6sgjomc86x/L6OAdENf5yqoB6bEk6AXNvb26kged5OGJEtSf54HCPFRpR
 LaLpnjgFEqSXF7WtaJDYuTXcIZC5hBky8uwmrVGGc6/MquJpnKguIDkO9CI9rkl8CJxX4qPIT20
 JGcEO3UCVp5cTGs/lvKQoo2KG6J0+q7SaxUi81j9Q7IosjH6yJk/G5R+iIyEQcL1ZMibcV04Uyv
 Sbs9Cuxwfsk1jpRvLKiN1mQxG8FGDmHJ0yseUxkTA==
X-Google-Smtp-Source: AGHT+IFKmTL8zz436WWy5ETIXB4P8iMmJJBDkypskIMAkQosyAHlEe73AhCUDXF/UNERHaJV3my+GENlQzs+WkUS+Hc=
X-Received: by 2002:a53:bd52:0:b0:636:5bf:2e30 with SMTP id
 956f58d0204a3-63ccb8dba95mr14472075d50.38.1760363063211; Mon, 13 Oct 2025
 06:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-5-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:44:12 +0100
X-Gm-Features: AS18NWAheio6E_cLD7kKcc6waSAb1n3BbpI1QKEZLuU_2zJFzxZ4wVCz1G6VYWI
Message-ID: <CAFEAcA9+ZNZ1x4L_V-UZcX94TAZx+3kBwQFzCoPfeaToAUdNfw@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/arm: Drop trivial assert vs attrindx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 10 Oct 2025 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We just extracted 3 bits; the <= 7 test is trivially true.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d4386ede73..54c45fc9fe 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2320,7 +2320,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>          /* Index into MAIR registers for cache attributes */
>          attrindx = extract32(attrs, 2, 3);
>          mair = env->cp15.mair_el[regime_el(mmu_idx)];
> -        assert(attrindx <= 7);
>          result->cacheattrs.is_s2_format = false;
>          result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
>
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


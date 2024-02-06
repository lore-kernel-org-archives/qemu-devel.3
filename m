Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67573C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMqy-0005M9-QI; Tue, 06 Feb 2024 09:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMqb-00057e-NP
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:54:54 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMqa-00011A-2C
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:54:53 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-560037b6975so3810651a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707231290; x=1707836090; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wsqqsXRUhKI/xC7kkr9yybEJ2gmcsZkQMLVYDMvexT4=;
 b=eRfePh0DX5VHh8k+Nd9TNnX6pQEHBH6127ZBcup/YknjzTtJUU0d6C/DZXBVUTBnU/
 G/XJIOQTa1/e7bR9krNk6eP47cnTvNbuMJOcJswggkhvrEsARNRkd4Ax13Od2c59ZhEA
 5+L4DJBmlPPy4h2YSsoDwWgv+OI5GHzaouTlN0DuTTaQjC1i4ep4ZhY5Au3ITXTyVC3T
 H8nnRM6kXqH2KdwDtryIrLDDSIaEnoXcDrXzHL4h+xaEkfpIf2xscFyFCCaCCAWI4j4P
 CgGDWZa4ruVgJSfUWKDlak4oiiwND4cKMxfX9ZmQalJgq2Tuw+1yzDRT5fl9sXBBMnwy
 rt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231290; x=1707836090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsqqsXRUhKI/xC7kkr9yybEJ2gmcsZkQMLVYDMvexT4=;
 b=mwk+b/7MR1O8Q7zYTi4q0PM/SELdivkfd7W1VLJb81FI+eJr9yboYyqvFhmjcM1d/a
 9ONod8uvv1u6H3TM+Ff0NP1+qZweDTvTXwvPDXgMQZW36iG47Fwob/osIsDcFt2dly3s
 ZeRbQqxq9JndUVSGKAwxxlEydYqd0IxR2sc4hv1GXGDkkbK804ixXntPfEe2wBWtUTlz
 nYiXhX/wvkoYsEYUSZ7qkIFtDxNmwpAFwPc1rGxTTvCM4n8YFId0B6h5riXQcmZwLLgh
 2ze1THg58SMitmABTSeq6M+nvtVkIpjZWfEEaP+jgRUNo+5sV0+QsxR5bHMB33HxXUkB
 uiEA==
X-Gm-Message-State: AOJu0Yyj2TYVrAtsOUDXFCsgZgWLKsKeCgvskicF9A2TgQFDl5hZWPeJ
 uhNryYuf0Ea1R1Z4agRGReloOADuShTROgxX/1BcJ1VjzLw37F26Cw3vXBiWhOkdW6okfL766J0
 nqLEcAYFQxZFDQiXROpv3naRV2hs/R1uPo8DnQndQE9tEp9LX
X-Google-Smtp-Source: AGHT+IHNcig1AZpv9DbLjZbWOoOm4ceAbR1HpuaOU/DVo3MdFbnVMHoNEu/Bj5lBicrrriaR8NEac9puZKe9MAhvcGU=
X-Received: by 2002:aa7:df94:0:b0:560:79bf:85b5 with SMTP id
 b20-20020aa7df94000000b0056079bf85b5mr1871650edy.30.1707231290512; Tue, 06
 Feb 2024 06:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20240206030527.169147-1-richard.henderson@linaro.org>
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 14:54:39 +0000
Message-ID: <CAFEAcA_+H-HHCN=WiwNjvOKRuVU=A-TnsosCSf9aTF_VjSgR8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] target/arm: assorted mte fixes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Feb 2024 at 03:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The first patch is unchanged from
>
> Supercedes: <20240131003557.176486-1-richard.henderson@linaro.org>
>
> while the remaining patches replace
>
> Supercedes: <20240205023948.25476-1-richard.henderson@linaro.org>
>
> While digging through Gustavo's test case, wondering why it
> should be failing at all, I finally noticed that we weren't
> overflowing MTEDESC.SIZEM1, but underflowing (-1).  Oops.
>
> But I did find a few other points by inspection where we
> weren't properly handling or supplying MTEDESC.
>

Should some or all of this patchset be cc: qemu-stable ?

thanks
-- PMM


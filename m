Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E963AC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSRi-0004UV-Fm; Fri, 23 Feb 2024 05:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSRd-0004PU-6l
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:06:18 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSRb-00060F-Bp
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:06:16 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so203481a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 02:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708682774; x=1709287574; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rp52SdDT6BnjPWI6muRKRuIN+xMSCEAFJDu9wfrhvcw=;
 b=dNwdYhKhBSqogs+md/S/E9ZPbeblgcfrSDu/KkyZqv5MSjVw44fJgWlwCJZhewXKbT
 1tmssbYd7JhH05g9devjz+5dWTRgVYtoHZxzismRs6/IIE1FxqAJwrwAj8Rn7+RoP18u
 ySELssxTHbvA+rNlqYKMHBALDJn2AOfZGR+vFGpKqF4/KcKrGGMy1lZusf3E7BQ2TgdD
 C89QO/poVPVpV5XkplomK/vR/Eje5vLB/IZhPctjWvz1LXBZV+6iKMgf8nMTw916Enoi
 TUvTKKAY96ln1NUIZLQHwkJEd6+bMhssbWyI/O7Tz8niCiTQBWH3pgxXWKGNqGlDu1LS
 9NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708682774; x=1709287574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rp52SdDT6BnjPWI6muRKRuIN+xMSCEAFJDu9wfrhvcw=;
 b=mEu4C+DIYMiA7qu/ub01E8sQpTImiNh4Op8KIYdUnvZu8ZAXayeTL2wqwqD5u5ACK8
 N9HGTT2tabNki4lmTmsZtqbc3sUhybcjqj5eIFTSAnIrnaz1o3+zIIf3SnepHpuMoEOF
 15wnaN+iAQ3LAZIZECX1U3YbmHF4EyIPz22vzzGrWbBkTbBMOGcNEFTuv3weAXaAsXJb
 MURN7xGbCuqzdG6eFONiJ8MC7wv6A2LdBLbfr0vA4/ZF65xDAAJaps65bpGDCP/z5l5i
 ggKavtYrIEG3fl/IQ3Dg/5sSrVOLbP/TuuQ0ataourNq2fNgiKrMOwVbdB3HaIRLpFM7
 Y9GQ==
X-Gm-Message-State: AOJu0YxMUoiQ+aeQB/52fxQgmVSALpCjxG0asmPPtZ2xSeo2nPFiPgHI
 Q2lvlghsnb8uAYjrVwRQ95a09BwcQEh0yTHBAaPc6mpbMZ1ZePjd1bPhhLbKcGOF0i9Z4t2ZXYM
 PKnODmE7U1x8gfh9rQQupnqyWRChg4ozqYUhcwg==
X-Google-Smtp-Source: AGHT+IGdwPBhJgrky7J/LtEVWTjJxW4gGC2WUJBdaHj4lsla3gP0+/oeqC1dWh5pbFfXXW6+fL5BAMbaGHpfDcN52Sc=
X-Received: by 2002:a05:6402:b39:b0:565:2468:7394 with SMTP id
 bo25-20020a0564020b3900b0056524687394mr884100edb.1.1708682773910; Fri, 23 Feb
 2024 02:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <20240220134120.2961059-4-rayhan.faizel@gmail.com>
In-Reply-To: <20240220134120.2961059-4-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 10:06:03 +0000
Message-ID: <CAFEAcA8oHuiYJnJkg9KXWiZvGmW7=xbrVK4CFg6dGec03ziZTA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tests/qtest: Add testcase for BCM2835 BSC
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, pbonzini@redhat.com, 
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 20 Feb 2024 at 13:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> Simple testcase for validating proper operation of read and write for all
> three BSC controllers.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


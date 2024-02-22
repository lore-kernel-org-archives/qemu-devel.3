Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0110C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9a8-0007x7-Hi; Thu, 22 Feb 2024 08:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9a2-0007w9-4F
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:57:42 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9Zy-0000Fs-Ii
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:57:40 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so2389115a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610256; x=1709215056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jDPcUci35H3C/VnE3OFjdHJIAfHNt88JWRtO5LfoxiM=;
 b=ihG4pOj+2z24Y+3FmaNskBYWA2yzXACyPA0MrOT1Qm6TJ72xfVA+2V7wRvFTD1QIPo
 kyF4E6I3xz0y1YSM5hisLXTpTKllgAQMYOyQEQE9zdYvfG03AA8Py83Z/g9EX64XXw4t
 ojBaK85rYccm+ICiTB/TzbV3LaPKjEN47J8Hw3Ku6pePZj2/QAKmbHF/OUN4ZAi9oMa4
 MoeHeQ0idEXj2N9RDIRsrsRzVaqIx2Svq4OGXPI0Vg2O4ikpYSnyen588LBm0qXmPq6Y
 X2H0zg1cIYWbLkorOD5N8aK+bp1lVa38sAbobpr8EG3O+C2ckrsXVeHaurmPJ6Wte0wS
 a16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610256; x=1709215056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jDPcUci35H3C/VnE3OFjdHJIAfHNt88JWRtO5LfoxiM=;
 b=oQeSR45qunkDW9qatKHZidFErLBwDLr4TyaSDqwiD7SNj+Fqk52uLyCfKA9cOv4xb9
 /ohlzIazuNu6VL4xaG8OFUlDYXh1qembPddJjtC1d652icOL4HCfFnhslpXbM5VKNq5E
 +Ls/SKPcJXFE47HJW6iV4oyiFd+O3SuNNsKVOXn2rvrWaynxMnVRkb3dx2lizGFaVFYd
 1Kvc2sAuT6sweNV4t/gdSraYGXoRVdIT4Pg+aVbi5d0iiVknimyFc0mw7Gn8zglDdrEJ
 uE03b7lEfWvtf/63hfnYeLRiUzgiE+IYDc+SUwsoG86Htk+a65+MLsR06M7wbXKU3H9E
 VofQ==
X-Gm-Message-State: AOJu0YwIRBAePCcoAD/ZbTi2qNrhBC5hfXssDfGWIA5Q4CWrV35oQklk
 fVd0FSAHvByHVqqYOz0VfPDhxHl473LiIhrKY+6DIgyeegeJMdIzlhzyeF1MGTYhQ8ZR0Wff3mj
 yQ2O8hCU402893E8lbe2fbBt3D/Etn9xrav7E1w==
X-Google-Smtp-Source: AGHT+IG6LFbvG/jcdqnApq7CRXRRJ49zKTdmYl6xnYz64MA8kMmKo+nKMcywUjLZqhbjEc5Fnd50jy3Pn2U7zJb6SEk=
X-Received: by 2002:aa7:c643:0:b0:565:3a0e:5455 with SMTP id
 z3-20020aa7c643000000b005653a0e5455mr1260547edr.37.1708610255383; Thu, 22 Feb
 2024 05:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20240215153311.186772-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240215153311.186772-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 13:57:24 +0000
Message-ID: <CAFEAcA8UAeCPN6bJXZhprvESDaXG0DqoXbtdF3_6ZnKwM4inQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Simplify init since PCIe is always
 enabled
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 15 Feb 2024 at 15:33, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> There is no point in checking do we have PCIe if first thing after check
> is adding PCIe card without checking.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)



Applied to target-arm.next, thanks.

-- PMM


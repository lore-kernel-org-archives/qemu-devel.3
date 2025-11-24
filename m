Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92959CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTqj-0002KO-8r; Mon, 24 Nov 2025 05:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNToI-0000T6-AD
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:28:45 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNToD-00026C-3l
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:28:39 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7881b67da53so39749547b3.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763980115; x=1764584915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hyjjylEO1+Bxvt8srtSXcytEioak2OYTpLYSTUsVyg=;
 b=ufhLQF+0fnVZGhbRKIhs+EwRs800oQcAWMGBIBrwnBZdx9iGt3kjYnPrqXl2XoXeoh
 3MybLzMF7r0gk3+YGl3TMYAfkjeVG292tb21mpzwF8H5hsrFfuq+4xd7LKOqXNEGkcBd
 7WzXZ1SMhcWSAO9h2hoH2O+hhr4t+T5UKBgUU6HdNHfdTVtkU00qAR4SaxifZoQvV2rP
 EdwkH4PoO2wjTeHLCJfwoHMHaRNJLF6GqxpyDRlMI0pmBHWlcoW+3IECIciT+Ga/wzJE
 JDhPobZph+/9QLsdoExa8MKiAvtqH0mVpZ3zHqVQgt+M9YUGnTkncujizNrzLODu6d9a
 1VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763980115; x=1764584915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hyjjylEO1+Bxvt8srtSXcytEioak2OYTpLYSTUsVyg=;
 b=tQLPfKwSyFeOFEgpw6TW7HzxJnImGPd3Q9tMhWMciPXX7LaKs40yCQDn+FQpfFpAKN
 KyJI6Vic+GvqShNegUiq+clwGg10VkgohfNmYxU3GG1mkwtPEmV6Zo5x2xp+PXqdsuLE
 5q1omYsH48OQcIzif69XFa6X5Syp60akzGVsV/uOrpazKX1SaqZoxUrqw4ID10ghm/CO
 8ikFLNHt/EcpOu3E2L4CdVFeS/5oMKu1KxsHz5FaepmNg+XmhzqgbqLxFHYwHffszByL
 23HFciJVaY94vo9AiP5t0E7CyTRyhDf6LjxVA4RDYKKoVTLPNUprfhGZWqRpzHiy3wjR
 qUpw==
X-Gm-Message-State: AOJu0YygzBF6mWcDOCUZOVin0POyDNXeb04IRyhsXPMaTxSUcU8i1ust
 nohwJw8Xtw/AlPSPaUirj3f1WYkDy+ILUF4cH6VRGt25c9rFDxvHc7y1CVEYuYAPkYw7+4ALLGc
 uHUXJnqgoaFAhHovwHDZTD5JtxCZcDczYElYBxL/jdQ==
X-Gm-Gg: ASbGncvc3b/gTsUk+0McfhVX2CY4AEg//HTML6PQDzIGzJn6sSvmGzWl/atE7GeA0mC
 NSJV0qDBtZURHu63NgPZsp/5ZLGY9K7mercC7g9Tyf5v3/4VDUG7SNv0ZnvKlZSFkdfPpGu0Dax
 pC2XkmV2ul+c3WnnKghH9T1E28yYgCNgW9uC/lRAtzsrBYFcLmDrzwpcdott6WNbrj6uvB+Qs29
 RUKOH5cJJbrwRp+m0jEB1+Z0E9p99FqREDMRSl2VDUsmNsvKly4Ajhfie4d/cooO55MaKH3
X-Google-Smtp-Source: AGHT+IFMBcLlHuxHDoFK0cwo3jStOECfk+AIUKxqXsfJy+dt3v5PxN/rMusM+lwycwDYsqx8rTrHlpUO3rhCPI5b/rw=
X-Received: by 2002:a05:690e:c4f:b0:63f:a3d8:1b24 with SMTP id
 956f58d0204a3-643029709b7mr7193882d50.0.1763980115108; Mon, 24 Nov 2025
 02:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20251121093509.25088-1-philmd@linaro.org>
In-Reply-To: <20251121093509.25088-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 10:28:23 +0000
X-Gm-Features: AWmQ_blBP_fuX2EAOZD-5eT_3-WYhhRS_d01IaB_w_UAEjXzAgqGt57sJfB2YVE
Message-ID: <CAFEAcA9oiYmHifz6-2PCCbYcZ35eDAO1AvP2f1xJNw7U-v3-YQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/exynos4210_fimd: Remove duplicated definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Nov 2025 at 09:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> FIMD_VIDWADD0_END is defined twice, keep only one.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/display/exynos4210_fimd.c | 1 -



Applied to target-arm.next, thanks.

-- PMM


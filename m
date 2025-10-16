Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3EECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JuD-0002yP-Ls; Thu, 16 Oct 2025 05:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9JuC-0002y0-6Z
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:04:16 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Ju5-0006l5-Pm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:04:14 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e11347fd9so184311d50.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760605446; x=1761210246; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IcymViIMbHOz9ezVPTAlrr0iHbP3vKqF/BfZyhqmAaI=;
 b=flnKmzYgZg7G9a6cgRBWI2sWZxs/PFGt+7wKX2JJpEICv4VeaJ7jm49kYpuNmedsUZ
 3jTawCd+LwdepGV5Lf3QC83QPx7CWDC992JeT7/A4pFF8ggWDlJaXZ5+vR7nXA4LLTnT
 CImjvK5jRJzL5C07nPR/dcndkceBY6Rd7N2KSJNIrTpPvV+HINfHR+m3KjlQs3tDeVkP
 NNXQtyMGDvrnumRxc+TGM5/Xx6j6uApqnjvnhGZ6vT0LrJx5K7xNpdvkUYpxEKJEW+AM
 CO5OyHsX94EPGVgLLBWABUbUzn2KrxHMBC/3UjCiUknf2SfHrPqz3FIi25sFGWVBzymx
 HGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760605446; x=1761210246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcymViIMbHOz9ezVPTAlrr0iHbP3vKqF/BfZyhqmAaI=;
 b=w67UHx01P/EngjytZl3gNpp8jyQKkJUBrc1kOx39fjJIretKh/DsAP2P6u5x0Kn0UL
 OJJ6xrqq6w5UxCIZPEWH4xADk5zstWX1mp+O2wvskSdVvNS0skWg+mT5otFWjKxBIPf4
 EW5qOxjsb1bkE21Qs43BHAyYd4Hu0hfebOBH/+Kb2QvpiPCkVsI4NMD9866Eqbr43HWS
 c3tiNuuVYkJoFM7ebyQNibRH6Kcao98LHJWakvZNGIc8sPSrOUbxb0wZEq3mDLiIWRZX
 YlRMaVKhGl9l4g8zr4Fs0EZdboR/+gMOt8IBhGzemox4TKFH05l09z3kJFlq2Ox8WX5r
 JL7A==
X-Gm-Message-State: AOJu0YyhstWe1zkk0OvonllTGJovUqh+Ozy1U7GUlUmP50Q9ou3UWTWi
 /Ye9CTZFVpoT0pNorTOM4aD8n1BXGs+nJ6I/q+Vap7C1b+iICLF+8URQcEYrg6Ipz/gxc64cWui
 qz8Pk2gMMXsGCqTGolL/v9novdOPgboysp2uZPlGMrV6in8obg5xd
X-Gm-Gg: ASbGncvJbGrTwVJhxyRZcx2PJDtbPE67IaAVRpYkKFnOiQFy3UewYPYYJXq7E6VghIx
 vUXxyP2DPzDvzGlsbgA9X1MMyIKm0GJ4S8LK1tzpbGvcPpKiV4yB54hqe3Fy6ZF/YmhI9fNhKjL
 9Ewqace0sNiA1mwKcMRG7FzOKfvrkWbpZdh/IwW/7n4ezBpfpGthS9IBPjbx+PtF9dn6XDahmnH
 FTXxGLOchsR+2dyi6EwtCq+efmf57RH4zXaqwv7RU1mL8XqoCO4bDh/kGztwjXJsg==
X-Google-Smtp-Source: AGHT+IGCessBEORPPfwYnMf0LLrtRb7K1FqrPtN/+O+E++Iws006whXIpU9HxhJ/lCdYIytdWhmBrB5tYNd0DF8IW0Y=
X-Received: by 2002:a05:690e:12cc:b0:63e:f05:afcd with SMTP id
 956f58d0204a3-63e0f05b6famr745908d50.68.1760605445768; Thu, 16 Oct 2025
 02:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
In-Reply-To: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 10:03:54 +0100
X-Gm-Features: AS18NWBwiUYEFqDfVwz4CUfeWq8xWK3BepX39YIcd6Tu6VTqgDWv5JiRai8mi4Q
Message-ID: <CAFEAcA-rKUJsEbEr8CVOd2_p-Cmowg=f2BJuADmwaaLq=zDVEg@mail.gmail.com>
Subject: Re: Reverts needed to get qemu 10.1.1 and 10.0.5 working for me
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 15 Oct 2025 at 11:34, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi all,
>
> I lost track what exactly I reported, so here is a summary of reverts and
> patches I needed to get qemu 10.1.1 and 10.0.5 working for me.

> commit 7a7e0ff6552fd5ca60d31d302fde492c7194208b
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Sun Oct 12 20:26:29 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Sun Oct 12 20:37:24 2025 -0700
>
>     Revert "hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response"
>
>     This reverts commit 4474802b0cd59fa14b603b953fa0bc8cc92783c0.
>
>     The patch seems innocent but causes net-cdc connection failures.
>
>     Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This is weird. Do you have a repro case for it?

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1591CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfr2-0001Yi-1c; Mon, 05 Oct 2026 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfqs-00013I-Pi
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:23:23 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfqq-0001cC-1n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:23:22 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab41af29caso9301667b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791195799; cv=none;
 d=google.com; s=arc-20260327;
 b=AvfrRmISI+cTLZZsVgmXWHSA053Dvz8gA+L5Mj5u/TCHprcXu5Ft+6FCpKMYiUEZlD
 YNAQadnOVBAxhZw4JQg8SonXuneXPdpZ0KFNRsZ6yWZhlQ8dswByjewxelbovopq3bc7
 YZVYeJHzmE/VHHeatT70fCQ67YzKkNZyBAFgaPA8Z6++onhIRARw4qIk1xe2ewTkVIZs
 ooP10JLYsB4HflnWvTCsiVnbRin7VhTxDOFqaJIPY2tnl72xXuSDMetAovD3POWxg3lF
 xakx0Z2I0/yg0fB9pn63O9/Bz8dRTS4noQM2u6605RF9obtNtpKTY9fklRU9lTvlM4BX
 HxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JY5AhUvRIeC8DPXhmcL74nL/Q5+jZSyAmHm3WFUmfDw=;
 fh=fYbink0dv2K5JH7y7l0ooFc+Kby/5lHeieI3AgvMwzs=;
 b=Pt9FuDpL560OCcfMmTrd7ZahZX1k2Nr3cXe6e/Eai5NL+8ezlD/YaEeXd9ExkbrK67
 2BDow9pCvgAtMNdHT5pmtvKPmoTkQdcY/GqGMElT34UZxIRkDw4Fq5NenLXWNeqr6Xtz
 NKGdUJ4XgO4dMw3GS7j8W9nXsPzzmFjRllSK+0r9jncpGBjCyW4pyJ6JMRbps6yhYNAG
 3RsXB7ShJuq+yiKpSlizKRUWaWg/S9avDZ9Zm1xLcdMMCI34TmK4JQRS1CeGxN85GX6H
 hQs/sQS9ilzKko+RJ1No3Dfce9mW+z5NxYDWPMh/hdCFuHbvX0Hk5kgWYPY6h34/x+mR
 Andg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791195799; x=1791800599; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JY5AhUvRIeC8DPXhmcL74nL/Q5+jZSyAmHm3WFUmfDw=;
 b=hC13d+uefsREdUpMToLHUGM56nF0UoTdrh20prERH/TfDf7vgNjUUofGifd4YxARDL
 ETxjXUC0c2mqLfVCt8A+JlR3bvnwo4rUi4CSHRWOU0uzP/Toinkx5Vx/c4bi1yrUlkl7
 Kv/3ar4GlWj3XyLy4YNkwVvAdfHbwYF7rNI+F9yqsuqPPb9FVCzVdHPrapSi0qORORTI
 YleQ56RTJXGn0Z5OFqrbKWOSw2s57d0UH0zQJ/+yEsvdJLQqaFu4S63ivIFX+GPD5OKD
 A2CzicDHTiFtgD7nV/p1lbDKoGLc7OyiwvC2eOumjLN0vwiJ2GZ7t3YbfJObfqTGU+O7
 yTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195799; x=1791800599;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JY5AhUvRIeC8DPXhmcL74nL/Q5+jZSyAmHm3WFUmfDw=;
 b=BgWwM9Jj+3IOl0KHiw1Bw7mXldB5ONrfd2IpFi6I6vIDpqdN78s+Av5CFpk/NslDq2
 GGCA1HqP412oR4p5tZjKj8bLp7Cjuyre4LBUQaBJk8syEPeK1Ni97t+p3/kpQYV45rti
 7y73rTBACYAPVTNOvndFu3UEqxRpO0BDq21YnjztowjkRRyQthQ8fDF/ts01w5ZNNf3I
 tEYFUVNfyqYAABNrcRYzwN8UPyQVpmAjz+ZYGHw9WoU5QuiY73pwYdvC56HmHTAonZLg
 bM3hSaZXDxZQWxsOAoO756SR8B2//ySKeyBqYFwrcuHPVBSEoVQ4+UiXF4DXmMcceubT
 PrMw==
X-Gm-Message-State: AFq9FYKobiKr3zYxam/Usv+y3VskcOqvTm0jX768tox9n3B6ZR4Ji6Cs
 voEqwd7v+xbGHIEJCRl09TcED/ZixZt+lPAY5xQSgswAIE2egD0Jb5b1tsi9g4Za6HY8MSQmBur
 P6ztYw2/E4X6ebKqNlPLFV23bhMzLLULvrNrnedUU3g==
X-Gm-Gg: AYBFou38QtCr8Mr46Pu9IQ72n3cBXCXBI/CQslDfno1N24zl4PsjVqL/t4X2PYIk66b
 JjK7J5se8L9ABOiasBNHvYf91LEAaPlItMWeRCw/w1dJYyp7PDNDUNTtOh/5doRuOfUGEUzkhmh
 abfIYds3UvgLys5smwLsimFAFTVTNl7JNfY/Gsnhky967NhH6lWfsrWeDQQR+G0uYeXNzdr3Xc7
 Wu3dbMp7/TbS8On42lJnMfq3w2XboPYdf0RwbOuC2IEflqnFFcpmYYrtdGUUB2qEAOBQo8GS5j9
 gqwHnYg/M8V7p6JSj0Nch0Qk2b9sCRXM9SgGv2DWSd/I12kpHCiTvzgy6ScwCmyl+qkN3DegEDG
 akjAojDKf0Apfu03EhVcd6FLZxEcMUkLvTe0wUyQ=
X-Received: by 2002:a05:690c:c3a9:b0:882:1d1e:9aaf with SMTP id
 00721157ae682-8ae394b659emr36708537b3.29.1791195798634; Mon, 05 Oct 2026
 03:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-5-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 11:23:07 +0100
X-Gm-Features: AclHuK-NjQ8FmVGML3rIHMMCx2sM6WMtR-F1Y-Hv0YrYlvU6el4EICqs9bKtX9I
Message-ID: <CAFEAcA8B1yu+xWj1iAP7fOPB-o+B9LjzKWYfxA4fNd67c6JaQg@mail.gmail.com>
Subject: Re: [PATCH v3 04/31] hw/watchdog/wdt_imx2: Remove redundant attributes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Oct 2026 at 11:18, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Since WDT and WDE are write one once bits, their values always
> correspond with their respective locked attributes. Thus, the attributes
> are redundant. Take advantage of this observation to simplify the code.
>
> Note that removing the attributes changes the vmstate structure which
> constitutes a migration break. This is allowed since QEMU does not
> guarantee migration compatibility for i.MX devices between feature
> releases.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h |  2 --
>  hw/watchdog/wdt_imx2.c         | 21 ++++-----------------
>  2 files changed, 4 insertions(+), 19 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


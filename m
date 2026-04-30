Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE81FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITUk-0005iY-CX; Thu, 30 Apr 2026 11:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITUi-0005g0-CT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:40:04 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITUg-0001wB-C3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:40:03 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651c5d525f6so943657d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563601; cv=none;
 d=google.com; s=arc-20240605;
 b=PqdlsjBOfV0kFvVU1fQ5gV2OYpsUgkVBSrZQqL2Lx8dIdNTj5vKYRhgJ2fyDNc/PdM
 OPXdODraazYplg4crCQB0EN120gqRt6sOsMMCKy4HsV1/oahPGReZa2buiRgBOsoHI2f
 y84KmZ1N7zqFkzOiqpmniQM3HBUUN97qFZafLFeEEmlA4rVfB+EGAh7OczH5i7CApFa7
 FzdmKwGIoyJAg/wO6KhL6m6zSdC2FU4U1AH8F9WqpjL/jL531kcEll0JxCwIH9dVJc21
 2J8HTBDePVlve2nZW4VFnpXIqIjzo66d7H5ptDMUGkXs00a0mXjiMlZQYNNISlUHjaJ+
 M+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ReDWy72RBwlCfXkKdQA2a7wP1OoBOa5MlmjTpVb60nw=;
 fh=BBXXBmZbsnh1iUcPA7aYGot0GnoKedpL6BO7ZAJRQVM=;
 b=GhYNZDqFFziJIyr/SpinZO4/itoGbMjURABwsLUFVJ8ku8NwonnoSy/S3LcH+Z9rNP
 dawCIkLukn7B5Ec9S1RSXOUEoHNSmNjUBtstMkP7aiuiGnXLx6vErrdoFH1SO8H0z2PU
 GY1jM8gMbzbcqR8vXR+TQNDdprRdChZtwJD2n/rjQfbgauhdC+yhoZ8Z2X9KHo/UIfrj
 dCXg0Q6JqTTsIHdMfv10UpxKR8nnk4AtAAq+j1+hEglGF0pUxfJlcCX1xCnKZP89JXIi
 PAx2s0Zqy2slm7UYqOE8/Fr0aXuK8CGKd2wIuL+DB9z2mRG8yX799RTo8jXoJ3T4a0sB
 G9JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777563601; x=1778168401; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ReDWy72RBwlCfXkKdQA2a7wP1OoBOa5MlmjTpVb60nw=;
 b=VwKL/nJkikvNyFYp6LoqNCS5hZOwiL2C2KoXYAYje169uarkMz39pDaRv8szXZDR4d
 4sV/ERlL6OxZWOcXp8SVJL6xG0G5MUL5hA48sDc2UZR6f3SvxJCEYmX2HenBFIfaipY1
 mJF3ua8PUnD+xvZjIyqJv+SUdPUcX09tCG91Z1+2ndKvJXy8kz1N/wkVRPfaDQIL63iq
 RpDyR/WHdJlJpteD31M+Q7NMskWvN9c13V0OzFESNuMMNIWaTZLbzp8XzRtuT75X17a/
 8Cpb69OON7wIVmOhqHnVzaat756y6RQSHNn9s9twpsUZ5yFA4pdzPntW5Hu1YsQlKVw1
 BmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777563601; x=1778168401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReDWy72RBwlCfXkKdQA2a7wP1OoBOa5MlmjTpVb60nw=;
 b=nXW9EtVB0ch/KbMhaeNPQV88auDf6ny+0z90muK9D0wmoCJSIltVKadQT52GHcFIMY
 EylXsh9cRPle1kNe1W/7hLG9sZBGRcXqz6UQoLqXLo6n0gZRkv1yuIkx05+6jIOVcSSw
 EqKnUaTTQ5YN0ACem4aODYVibjsU4LmUX1a0gChBQeacpTGG3U5hdeo1NdJzyDPQ7N0B
 C84OheAm8vksSDYRqWtMzeuvdcz8lz4UrGKnrFSB7eoqZgMjE3fpd8vLRslWPkpP6xFT
 7BFaIoR2Lpx5ROFDSlkORIuuVtFqIkaZI5HBtk0d9vccoeMu9NYXQ7D1BoO/+FBlL9Ws
 2qOA==
X-Gm-Message-State: AOJu0YxQsfoEPJ9rqgO2lIS5pxl66/u85RS/y35aQvL4CSS9cywvd0O7
 NFj7qJLuSUZOgRoyd3BL27ygMWXrozjWZnDnS0RlrwzUlY2RgBLos6rwisLl0sgxF6v/1dzkIhI
 O/mxPkZzGz3XTOupB9KI1uCmyqG1K62TRm5+smMB7mA==
X-Gm-Gg: AeBDieu6y1cjOFJ5hBAu/oL0a5xQYr9daiDfp5210aij+0wI2l0sfSV3fMFOHdGvsMd
 b62qpyOQIlwA9QsxqjxvsEHmoOCwfamizYeCc2cDjATdvS5Xw7YmjQurjAwNOeivehYjuNjf+wD
 ak68eNpB+jmma0W9XgBmmsNV2hI+lqG2+WilDdkILc25S9uaYDQx/5xfuX/HESQT6yT6eLVZC/f
 gvcqFX0aV/aO0HAutm92SHQXkJtrBRsR1ytdC6mv7XxZzg/IKMHqEDpg2B6LxhR7F2Crosb5G5T
 qrs6xpcx+W7meC2VlrmGgLnSbEimDiRNoEHE0VRWv91j1JfKBBC0cDa7IeZZjF8KGkA7+Z/YiB1
 6Nw==
X-Received: by 2002:a05:690e:1206:b0:658:ac79:ad4d with SMTP id
 956f58d0204a3-65c18f55fe5mr2776193d50.47.1777563600816; Thu, 30 Apr 2026
 08:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-4-shentey@gmail.com>
In-Reply-To: <20260308203516.160103-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:39:48 +0100
X-Gm-Features: AVHnY4J8zxXW6fxl_n0y_3WVqX0LkzYyp3tUTgzLovV3Dib0GiEAegikkClToJw
Message-ID: <CAFEAcA_cYDwOFP_h_pKyUQ0kKmT671iZiNntzMC5O5tF=1cC=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/arm/imx8mp-evk: Fix reference count of SoC object
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> object_new() leaves a reference count of one, and object_property_add_child()
> then leaves it at two. This would leak the SoC object if the machine object was
> destroyed since the machine is the SoC's sole owner. Fix this by converting to
> object_new_with_props() which gets the parenting and reference count right in
> one go.
>
> Fixes: a4eefc69b237 ("hw/arm: Add i.MX 8M Plus EVK board")
> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/imx8mp-evk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index b84ac91a17..cfc3038c36 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -74,8 +74,8 @@ static void imx8mp_evk_init(MachineState *machine)
>          .modify_dtb = imx8mp_evk_modify_dtb,
>      };
>
> -    s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> +    s = FSL_IMX8MP(object_new_with_props(TYPE_FSL_IMX8MP, OBJECT(machine),
> +                                         "soc", &error_fatal, NULL));
>      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);

Looking again at this, is this really right?
object_property_add_child(...) creates the object (refcount 1),
adds it as a child of the specified parent (refcount 2), then
does object_unref() (refcount 1). Then in this code we call
sysbus_realize_and_unref(), which calls qdev_realize_and_unref().
That function:
 * (indirectly) calls bus_add_child(), which takes a reference and
   hands it to the link property on the parent (refcount 2)
 * calls object_unref(), as its name suggests (refcount 1)

So now we have the object with refcount 1, so it doesn't just
vanish, but on the other hand both the QOM tree parent and the
qbus tree parent think they own a reference to the object,
so our refcount is wrong.

I think the existing code here was correct: we get a reference
because we call object_new(), and then we drop it by calling
the realize_and_unref function.

I'm going to drop this patch from target-arm.next.

-- PMM


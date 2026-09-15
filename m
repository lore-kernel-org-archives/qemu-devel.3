Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6881DC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T7x-00063D-VR; Tue, 15 Sep 2026 09:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T7t-00062a-VS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:23:09 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T7q-0001Ny-W9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:23:08 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab2029eso3013257d50.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478585; cv=none;
 d=google.com; s=arc-20260327;
 b=saUIgkE1x/NDMXg6AK+iJ8Is1zHG9W+j73GeOxMLMA3QOs5r080BpA3Ek22jstJQBt
 7XxYnxt6odlkymQFi4IywT+29Cu++1uaMrAtkvp+U3T09pRz44rwBwQ1GPcZNaFVIRYg
 iKLzQ3Rtf19DOz55VMEsr64i/cTsHGT1ZkbH1vXr4HyJsac5tl7dFahXN9Yc5SWgeVdF
 gcdbbf3AGc+97VJqSlVy1xJ/Gzc4nyBlGh8FHHYQVqfwXIuYglftAVs103fmeSVFZB2S
 KytDQ7erFzBvVq8sxLHDr6WfwWbLthi5ZN7pnF5giLz+g3f2vb6LQRZxSAVNg60pS3eY
 d4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zm7hFCcvMRATtxpOOptn5yuEGAzWjEqC9Z/T3zc2rn4=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=Hp8tzmBr2EmPBNV0/vuRlHU4EronjE1ckXaqOhgeu3Kf7p+v2XkBO6W+yKtBFioALI
 neziV88p82ck+kVG9zNCbnVPo5uIAxy8MjVIIxtWfJ0KZqQXGveDIHB9+6IMYLWYh/Zw
 L5olATgZ0rzg+4rnmk+puOEZI5V2sNObe+XTEJ4aDQZOXJu+jK6upePWCm42mkLcqrlF
 E/C3gqTtJWiynSIL2mKWc+tdiQnyzivN1kAlqRwL4/U6qfVoOZLICF5C+GEgIUrz59Tz
 kWta01e/w51vepF42c2B18MsAoWczkz58CCeoGqN5qulY7//uzOHIKYKamVhDTqY3Z0X
 MUJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789478585; x=1790083385; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Zm7hFCcvMRATtxpOOptn5yuEGAzWjEqC9Z/T3zc2rn4=;
 b=GYFfmXGP3oHsVvyDzlSpQdlcSWMpAR8qsSmHGUafxWyB9RfDdesh0FUbR15uMQkqeT
 Ey0Z4CYteSNy5eMJjyDnvOSQEFkrN7MIJte7Mxd/aYkxuKPgilW2eXdHvl//XXKMOS9l
 HGL90wZowWrFiLW7st2b3Gu/vq98Natw8uo3mBQxkAavm97bR33Px6fsyEIbEg8OKgcv
 mC8mxOBUlWF54QNcQGZq/PwxhHoTFs8c8L/h+HyU17T/vHJpPpJdJzqYM1wBlPeSYXC6
 26mONPMymZZhXN0izLXDw0WtL3midO1M5uQntCQtB9tjlJtMzToIUFPWebXFIXovcyI2
 JbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478585; x=1790083385;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zm7hFCcvMRATtxpOOptn5yuEGAzWjEqC9Z/T3zc2rn4=;
 b=Xzv4g4pYfrMslPapC1dAjPnx6HHaBJI8xWqQI96bi7bFFB8CMDX1VZvRe/7ACrsDOP
 PxLDseKXp2dwlrzMmcGHkgBDeyf9825ZWvajvI4fkWRRUQ8Lu/7wyr4i2w3hV/vqDi8X
 Fkp8CQqlsmVueGj8GtrD3g3dOjuyhRs1DykYT63/K982grKxgTkpxPEAXDmOqBy1yvg5
 np1Koaizn/X6tdY4XIXG86BADbk6JeS1xOGVFsLxwNOTp0dS1Bvgz0IvVRnZvjKbXfrM
 FQF413wJJU8riADgnMKGIY9Y9ybQWTVxQNogOLgcNQGCaBbExc3dynk8/1gSt4V4XFRj
 YntA==
X-Gm-Message-State: AFuF++kuFySAF6/udNLPpist6Y6QOks1ndhIqHY6m0fkG3nqchV4v1UB
 wfndPeq4II9Yf0Whzt7Q9Z1ni9CylFgJpQ2/6N+qzaLI55xPJPrAgbTRW9l6R0hpLJaEe614TRh
 TDNtTgb+pNJ3l97kMcbzyOrW7CX1TDkGGWD4tVSGgX45w67JWrzgi9kY=
X-Gm-Gg: AYBFou1yWdb756SSOoNKj55UaZGRTPl2RCoemQ9Wa0dIGuCdfKybIq0o4qrXsMCo9SY
 U84YYcQS9ZKsqjb5BjAl3O5ZTu6Iw+FC6zIewqn/R9sMq7YU/t7A1huEU1Ol8vzqQW8JaiumuvW
 l11uDTplPy25GsIHAc2mIFAEL6PIv7kuvw+q2eT6jDXvJgS2+WErlTCOCdsfagNPA+mMBoxqyEG
 hUCelEoiKuTP8YpLV/MUtCEy416VxUcdOI3oHUTopy7YHO+OruqmfgQ5LiMwRYPsiJOjPrnVkMi
 1wS48B6CdLKsrBCNTKFppAUovF/2zx6f0H0L8UxJlPo6b/VZclHasC/zqgIMSatMgbd+SNtxZL1
 QFhC2YkVIZ+VKFZMXCXHVr1laUV3vbamVrKOr4uo=
X-Received: by 2002:a05:690e:12c8:b0:66d:132a:875f with SMTP id
 956f58d0204a3-6714e088222mr2226628d50.47.1789478585351; Tue, 15 Sep 2026
 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-6-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-6-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:22:53 +0100
X-Gm-Features: AcwNN1URoW9lEtypQTmGSNjzOHiUmk1QghvUUKmXc6uqBj5pFThsbuNjPmj2HRI
Message-ID: <CAFEAcA--HZowfkeqscvKiWEWbP8g4EvT1=4OHswG=9EZWvXaSg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/6] target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 20:28, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> The PMSAv7 walk accepted any non-zero region size field, but Armv6-M
> requires a minimum of 7 (256 B), Armv7-M requires 4 (32 B) and v7-R
> retains its current minimum of 1 (4 B). Introduce rsize_min based on
> ARM_FEATURE_M and ARM_FEATURE_V7 and reject smaller values. The PMSAv8
> path is handled earlier and remains unchanged.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


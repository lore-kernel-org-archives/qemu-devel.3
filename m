Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F13C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHW3-0006SC-8k; Mon, 27 Jul 2026 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHW1-0006Ru-NM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:20:53 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHVz-0001U8-Dl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:20:52 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81ef8255cccso24150017b3.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144048; cv=none;
 d=google.com; s=arc-20260327;
 b=E8cvabemNfszR98mX30a31axhvu8zGhMS1Dm5Z8Y1EAwCic3jCPvw6YnsWk1/68PuJ
 CHwKPcyK9RaVRaNDrD5959qfGU32XXtDnCvhyvFXP0P6T1Orlpz1jBzahkDR1tThSDdU
 6lGd7p6AjQ4yUv3VA6xQ4FzWLLJZhjhKEcnAMre0/RCC636lI438HNoc6T06npyQXXUl
 snZBnvbac9aknN9BU+4CZIJFTUvSvyFn7mpeknhQ7PSV1AkkHZ1/eO5YzSyTh0Ux79Xr
 uNvHMaSSRCHnEYZgFsrvY/Ix3Gp5ruYABK2bgb8qAnCoQJnKkpIG4MU1rJyRTDPYQqmE
 ElqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xqI7HhcyJ6XrlVL/ZlZh09d/YZ6j9hkuux8sXuC2GD4=;
 fh=LWS5mFBf8aNk91q5EFo0cmGOk9DY9KHuv1LUbmmJ0gE=;
 b=lwLZz12KS1jrqVM/CywOVcWgQQrvwnPvdc3PA5sEG8MFTbmPDl3/0Mdi1DGd2d/o7/
 h5UlcqcMniGyhbmGsRgRRTgRMokKTXcY6+mpQ3Fhl0H574uS31ubXSO0FOd8WlH0Y8ZG
 g9IkkBSEO0uXqi8s7EXJtYMpmBTiQOiWLncZ2nUO4VyMBAhYMGMcBSSc71dcOl40tZtP
 GNFZcGP2dmv3aHAgRFXn0PIs+syL25SMgJPogrWwsFY2JjcbJ5f/Uemv8Ds0gi/2aZlz
 CFPEpXUDDAKAWGTLvxeQSAfn89Ib++zH8AUh7XCOo05oih0S2mqOeBWYaUDPBlZ77y43
 +nRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785144048; x=1785748848; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xqI7HhcyJ6XrlVL/ZlZh09d/YZ6j9hkuux8sXuC2GD4=;
 b=ok+aEGMVASU9hQta0qBCmQPW4uKlc3Bl5ysCrI2wqZShIzKDvCEMDI36Bj0M/rodUH
 uvTUR6aV/2WJ6WAnITAhf7SRrIFjqJQ99Hi27KVWGkj2IkNNy64nr26k1MXbUGDN6re9
 jNkCpbymSu/YrrqERN3eDzTjZGm3qQ+ApNnsLIo1xetf0BxZtYCZJQ3JYSwhyduWkDSL
 M4iPkwrILpwJlL8uXx1jvRr29Ssn1WHIVBejxiDi+DMWXBGrrafQUz7f1BfdJ/2Q1AK7
 YAuxArahQdI4rlyLND0m7xWB1yZrHR0tMRXpSsPtUm2Ep7h6BQ5I7PCsIYJleZiDiMdA
 XtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144048; x=1785748848;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xqI7HhcyJ6XrlVL/ZlZh09d/YZ6j9hkuux8sXuC2GD4=;
 b=sQWDH71lqFIbwbbMlmFHCpEqsHIBMvoX/m9DsFuhSCiDGElWx2k1upu8EFdjaT0jak
 IH8aT32wilJf/RwP4gV6xU+UXepcBsTfR8GHLJmve3h3N8TEHu4JC31W1xT/0Tvs8Q07
 AH/7oK1zM5ZwH5U0j+FFmIgDOswro95gP1/h+NKeZBDemAvUX71mcd9E8T5Sq2nPdC4s
 gljMNGHPNVFxizk+BaGi6Yg3r8ZiBNCLX/z5PFe6r5vVwB9EVlkeuMkBd7RZNUrQ8QZ0
 GF38n/rpBGdn3Du9I8VddNCTH4xZ7EL7Fz64To5NSM/6RwidsfiMDx0/uJRHyK74B3A1
 k4YA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSG49+IjXY1jlS2JGNPbn7b+PJsPwz3J+cyzKuV+NdIqdYxHBoiIJhSZNo2Eg7KbRPywixZMW4ldFa@nongnu.org
X-Gm-Message-State: AOJu0Yy3TjFMA+lrk0D/dqTBm9hD2dhhj2McsQE8/DXYZuFNLdd7+Z9t
 oLdE/nsQid2r8/MI8rWiNZEFNKt225s9CseOHSHuBMYGKNW9Ln3JIfwyxIrzSrXxjYV0an8foIY
 qv67y4NzlsxbAL1wo7d2aGLAX2LOzxbaC3BRNa1DlaQ==
X-Gm-Gg: AR+sD12TSkSfbFcLvBR1EURp0EUrfqp1odLnWMhX85nRAaff6hRAJqOxEX5xxmznDox
 HlFmLUGxz0mzBAwdq+PFMIxch62W9uuLy8wXJ+sPhw8CZAYAPkXVtiN8D0tmY7FMEa+zqZx4MZK
 mj12OclbUiRIgzYbYGb0/bnFUg2raiDE56m/PbmYg+oXjiVq4pfN/TRoeMsRfIqUvnSh5roAMs8
 ypXmrqEgUvKZCQq22RQjaTkkquCzxoHGVqAE9YQV/lijDwtEM/ryfMbHXdakXbU+M4iNDvpkcQK
 z42ITC/4+rt70cuh9D1zLgkW8R+A46H9CLR1T+jwO3Avkg==
X-Received: by 2002:a05:690c:2784:b0:81e:c758:eb5d with SMTP id
 00721157ae682-81f69e2e972mr24171277b3.44.1785144048435; Mon, 27 Jul 2026
 02:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260726005601.2513662-1-mattst88@gmail.com>
 <484d9db5-7602-4f1f-b323-0ba0e5c86219@linaro.org>
In-Reply-To: <484d9db5-7602-4f1f-b323-0ba0e5c86219@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:20:36 +0100
X-Gm-Features: AUfX_mwjpURuc16eT8uHhOoD8p3BCyU-z4P7Sa-rQbK7c8sMF6l1loBmXsG429M
Message-ID: <CAFEAcA_i+zBEBQHgrjzyTCf7WdpLaFC4eh4uJEFwkUtheBsZKA@mail.gmail.com>
Subject: Re: [PATCH] target/alpha: do not trap on Inf inputs to bare FP
 arithmetic
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 26 Jul 2026 at 19:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/25/26 17:56, Matt Turner wrote:
> > helper_ieee_input is called for each operand of bare (non-/S) T-floating
> > arithmetic instructions.  It was raising EXC_M_INV for any value with
> > exp == 0x7ff, which covers both NaN and Infinity.
> >
> > This is wrong for Infinity.  Infinity is a valid arithmetic operand;
> > operations like Inf + finite, Inf + Inf, or Inf * finite produce well-
> > defined IEEE results with no invalid-operation exception.  Only NaN
> > inputs and indeterminate forms (Inf - Inf, 0 * Inf) are invalid.
>
> No, this is modeling actual Alpha floating-point, not IEEE arithmetic.
> Only normal finites are handled in hardware; everything else needs software assitance.

Do we emulate that software-assist in linux-user ? I couldn't see
any code for that at a quick glance.

-- PMM


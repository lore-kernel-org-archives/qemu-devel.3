Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40F2C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgce-0003SV-0m; Wed, 05 Feb 2025 09:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgcc-0003S2-T6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:43:22 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgcb-00061B-Dl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:43:22 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7515df1faso323487466b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738766600; x=1739371400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weVsRZqqPDY73JXORY8ZDDRRCBcZnbP8mOLmyNiHeLI=;
 b=qX9Qs8yIEj+doNUDYrsASS6LmmIQaMPRxdo505KQ8bELaRd2eoaZsFJIQv01ggm/g9
 /YwFBN0fUsttfN/g2PNEwDvuhfkbqkNX6eO/b2jaqoqTjxsmVak5y2L1Fynn6dpevuG/
 8G7NlKG7wDHy4DrcgOZSkBK1z5Az8oIU1lXaTZit9fljttBDEJvxpwP/Q7cWhZ2/mOgN
 FS+rRQLRu7phSEy7+655bYg/FfE2BbcDVxwdV2LhmBjaRDK9vK8rvRf4SSKO6p7HW/CR
 mxe9t6o64SF4WEWbY9CtcGhKssvJ2cBtAv+1GUFoLanZIIeFyGNHu6JZsEZEH3r17NG5
 6yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738766600; x=1739371400;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=weVsRZqqPDY73JXORY8ZDDRRCBcZnbP8mOLmyNiHeLI=;
 b=g2vSz0sc58LsVl8dyVTxTFaXyVALGIFfTydW3MZeeLFZprJDMLMp9sxvZj5DGD83ef
 BMYDAszv6XY0KMNvn1zsaVaVY85DAVxKB74808S4IJDCJRYwMbNEtRlM6r+KNfSKLiTA
 qEqiSksNVFDhXDqfVDHABCjvxB95csV/B8YK0l3Rw6wZOucDtCahQwTHfUtGsN5tjW9x
 uejHdMgJwuLypxl1XEPR5ktyufgjCsBMauoCMorCrI+58HVYVtYxrPkLH5bPoHzE0J0w
 0Q1UB44b1gD/pq6Jbcl4Gey7GkDcLpW4q9ikw8g4NmDjtvyZJIE4ILYQW4PhQjwLB364
 MPcg==
X-Gm-Message-State: AOJu0YyJByBFrQoaUYJudoiT8gPtada2IRY0F7r/qNWfiY1IdW8oMNeI
 YGGP/qAsO06A1ObJwFlg5JTBspynE6ug/wz7/PDrmVFyw6ccb3vMFXQydpZ7Hh4=
X-Gm-Gg: ASbGncs2KqyKwNLFjM9zR1wXGkQXi0F5zM0YnmTOIc9vS2VIimG3oDVnelNa3VmGraG
 T4kmt54fcQzv3hrN2TvXviEjPtWx6bQB2+uNfELP7uPUyKy2JnaqY551MNODasww8/r3jVAwjad
 d32qZk3CmGIyAZOnbgywXrGvXfeUVepzPuZyLuSaxjJc3l82hV640kk8wXGVDFrrwKjF1etctk+
 0S1feiFnwIfJVOT+BtGf16v8SUbFMBVsNstghaUzUVSVgurHycmQcvPNWagr7IwUtLX/D1mhsCC
 Me0vOWLfZSeW/6Pj7w==
X-Google-Smtp-Source: AGHT+IFkoa7vIEjTE3iVCX1YX1Yn1PV5Bf1cCDYyaOsc0oayi9Ng9jitmrQWZIRg8gzA01wzlfjplg==
X-Received: by 2002:a17:907:6ea3:b0:aa6:a844:8791 with SMTP id
 a640c23a62f3a-ab75e346a37mr292318666b.45.1738766599986; 
 Wed, 05 Feb 2025 06:43:19 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47f1dbfsm1109979266b.78.2025.02.05.06.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:43:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E080D5F90B;
 Wed,  5 Feb 2025 14:43:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] tests/functional/test_aarch64_virt: Fix vulkan test
 without egl-headless
In-Reply-To: <20250205141140.97437-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 5 Feb 2025 15:11:40 +0100")
References: <20250205141140.97437-1-thuth@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 14:43:18 +0000
Message-ID: <87h6588nax.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> The vulkan test currently fails if the egl-headless device is not
> available. Let's add a proper check to skip the test in this case.
>
> Fixes: 3d30f882ce ("tests/functional: extend test_aarch64_virt with vulka=
n test")
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


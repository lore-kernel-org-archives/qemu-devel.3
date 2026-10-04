Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AE5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOyj-0006iD-Fb; Sun, 04 Oct 2026 12:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOyc-0006ee-Cz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:22:14 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOya-0001nR-FU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:22:13 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab42612328so6024657b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130931; cv=none;
 d=google.com; s=arc-20260327;
 b=XwWYoOJZLAyuoQe85iv6MWG5z4xmFdnKcwGNI7GqA+uUGYpa77qB55A3685O2A8l3h
 DLx9r6DVSbe/y3CYxGvzjDzwLt/76baV4f75J1MJvcwZOFXESeBEyq4L0OFfmt52V6hq
 5MCmOgYojf4/f0t3EhMNXnLTbJRSsRIHC1DTHCDHX0smP9oX/CZXZUhQjtzdGUJvXJU3
 O0bxzO+FzsVGN4NulKtC4atxkz8gcnvpH3Lh3mppKvbj5/arr67iggE7W/fPSWvxGOhV
 scW0BC4ORAJ5eClywr2ZFoSagsfcPOgL+tedzA+bgiH5L5JXPjYofKPkj8iICAZFHoRh
 aaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MDtcUjUbrU8VEFojMzmBTwAgi9SbbpAsq0gZUYFKZoI=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=iOJYtJzNmwQKn/ZJlDKj2u0zDwqS6cr7abzGoYOM11yPywQlQOZA3QFtOrk5V0KFq/
 qCWwgH3q7RgK5wVZphWsuyJA9FJm4L3vbHmYoLScaFIb2Yr+xb6HoA74hn9gkcPAS+BK
 eUTmX/9C1OcrtUc9Em7BirAHuX1aHnn1vWDf273y7W0bXRxMHUi4EWlVuEaA9ST/JrvB
 vNU119JUK+TJpPRmF52SwcflrFuVt2Hbue30CjxWhXvZMajrOHp6q1QOYmvKYmKwjTVu
 ZCTVYw4d3vQy43vLt+0KmSBRUqpmH8rdGSHCTdQPzf4aPIw0do8g9sRiejGslEmHa/ZT
 u0cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130931; x=1791735731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MDtcUjUbrU8VEFojMzmBTwAgi9SbbpAsq0gZUYFKZoI=;
 b=PyC1p8TJsw6fzLpq8xup0q0DxhwtaylGNr7Ao1n3vOecnO5tI/zhD8W6dbkU2yzL0y
 tVmeZnwERTmYK1hJOmkyZbbvwNi8F1bOTwz8dahLkN2JJrCdgskUPVXckcabSt4La/qN
 fRc7EviCguZ/p+IydTZbzTZ05mFG4+4pEBFB4EY+5PhQhXrNXJK0a0UiHtswLr/SCp56
 lAi0IuLDqlag3ecS2W5Qr1QZkufwYqpkUovZi1cQrhXgnBmJ0Lc3pUBmmwRB4nBzGlFy
 lnr+FzkN5BXSr1fEEn0+vHxeEVlsLG1YT8t9wrer9mxFEb4m9dkCgBUAWU1R9/Ml1xfl
 m/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130931; x=1791735731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MDtcUjUbrU8VEFojMzmBTwAgi9SbbpAsq0gZUYFKZoI=;
 b=Bcv85NqCcSmfMANj1v+Gy2h1kklQMcdcCetMktMaAqyCivJ0n1cTZIYbfZIRV5z/XM
 bXDGnsKojTP9y4+OOANMpoJbCi4nt8SZU7Nr0J7DryorQFG1yXipNZX2pdDux+Ysofip
 AjmDowtSfrSdejqYwe2ByE/QTqk4AUODx+f47vtpQx6QsEwqmQsuWda3p3OimCI1+deQ
 Hm/8cBEw3A0n97HxcfDrkLHWb2fDzLafT+DoJ5PYJ5sFL+O+x6gOseG+N8zYMLuZCOE5
 7SbUDEkg2GUDbEVBUvrStF8SGWq47BDCMtzvTBabvSOEphlnTnkgHi09meYoDTWdDnkl
 ofhw==
X-Gm-Message-State: AFq9FYI2cUwXf1/svJxvj4M3iQSo/RI+VoTiNof5Uni+cAQtH3Ce/kdR
 gPH+/TGuQIzHNPb3H8u0jVkqDx3UqzXp+n+Wo/9ENeggMXyONBo8VTILN9IMwLXc9tL/BS7vdOJ
 S1++DeVbX7iXlaVqx9/S7nRuS4M83UmA=
X-Gm-Gg: AYBFou2rpSyxtHholOR1LSloSrWQAFnhfB0MyE0dW4WUQT8NKT4ZfrnmfdGfsr2VbKj
 P9tmFFL/n5/bvWGxwRwQVI/uO0pAviN9iAj1ld07Ryvp46xxBOU1Z6U2sLJriSe4W/iSiuigMiX
 Tl9lvrH1GWCYPum/Ejkm7f/W4Q5XOw9ikh6qIbAr3wdshjQo3mzvyfgW72JFsoVAt0FRGiSfq0V
 qyzaUin3oF6clQ7Au/yeZmrjeSyyyksdh9B2ofZ/1FFyZxrxOeL6o9IrkLVi09x0wxq5tPHMCrd
 UBK3dToE11iSDKIN0WmCfNJm8tVAjKcL8WWLDJZyujvR4j6lwJ8Xiz9As3fsMw23m0hUci2APeW
 BaZFk/9OZn/06MXI=
X-Received: by 2002:a05:690c:a74e:b0:8ab:3918:33c2 with SMTP id
 00721157ae682-8ae39c0ab91mr22612747b3.27.1791130931265; Sun, 04 Oct 2026
 09:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-23-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-23-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:21:59 +0800
X-Gm-Features: AclHuK8y0yb4FmFBGfXqW6ob7sFRzSDSA7q4HApxB1kiE_3y9m36JAZMdq05kTU
Message-ID: <CAEUhbmUYV-ukvhDy3XUE769a7zfWo-a2AksrXgEkaoNoWiU84Q@mail.gmail.com>
Subject: Re: [PATCH v2 22/30] Kconfig: Extract config FSL_IMX7_SNVS from
 config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config FSL_IMX7_SNVS to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 5 +++++
>  hw/misc/Kconfig     | 3 +++
>  hw/misc/meson.build | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


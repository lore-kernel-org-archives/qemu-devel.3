Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF1C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojqn-0001Hd-I0; Tue, 28 Jul 2026 11:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojqm-0001Go-Jo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:36:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojql-0002JN-9h
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:36:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15dd4b9132so584200566b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252970; cv=none;
 d=google.com; s=arc-20260327;
 b=jO37CN1vckwOMQj9fziWLvj898q0Z/a5JSig5W8BTo1BHzXQ/3CP76uvFysH1akgCs
 dV7XbPl/QdIEpGL7oWk1W3SUiBKzdAUZCNypGdM63FjBmubj4t5s8E+9FtWaO5s0gqQU
 i6sYYrxk7QxKx1Z7CMnq259LIaiLiYrDTYawMgFPWygZOI60KXXZRCSPeIIdQzotoWuM
 ww3Fhc3F7gUc8Imlo3jdH8CUiyO774Bnt3Ha4UAmea69rxIyRRzRnKy4zbz1aJAgYTVn
 MSE4yLa/AjSwGDpxWjfjlS6Oqw6BjMk6cXxM07CFWoFoLKGob6aGxqcKuFGTidef0MTD
 Frcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dLcCLcTgzyeo8IoOvGz4mAtND1LVtYwj/xRC8TLH5Qw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=e0FMiZK6K36DHZLX3WepY9zmBjYcOGt4WNRcDKPDSZow/EtA3l+y8qfGlH1ji4CHEL
 4rYWkwO3tdevK90lwXYmOgm+afF9BxR26FaFLj4TY1e2ObGYkv/14m27XIWmA6Egg36v
 21WTHRqEcX6iytqUc18KxOS+HHgyRaimexSrOiKSvGCPW45mKOeBtHB9NefQBaLWVb0G
 qqg+dBzqB3TSMcZI0hebr8R/4G3vHg5gcp7D2mp48uknGGZrM5ttOt37N3eSDh5Phc5D
 sGJT/k4B5al8Oxu8wBXm0xBCY7icEAZPp4SLplUiWFB0j4q5UCf/JS7SinL+DcGj0B00
 LKrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252970; x=1785857770; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dLcCLcTgzyeo8IoOvGz4mAtND1LVtYwj/xRC8TLH5Qw=;
 b=qBP3xVbRjjJnKhaYTWPj5zXKSmVyWkAls3CZU/lF1PqZRhxSmtZpyTGmhvfy2ttp/Q
 fjz6/xHDlF2d2/m/1YjADdMwzz1YN2zMj3N9OynscNd6i0zZyCIzIHqXW0GSKBk9rMa/
 LwLaRIlw+wLQU8Jaz5uK0yjT+fcTs/4L+uvzdKy+FyAYabcW48ZeGoY4wlUxzpaWF3Rq
 F4SiPD9X4psBiif/ay7i8XerAIuFm/kZgBPn1lSV0shyOxFqNFRRGm/RymtOhgEnS3Jn
 qsaNFWjzdBSTGO1/rN+PUNbCC/gDtMWVBSzwjNWdTINAtikex/xKnOzON17rvmE+b7a0
 MiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252970; x=1785857770;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dLcCLcTgzyeo8IoOvGz4mAtND1LVtYwj/xRC8TLH5Qw=;
 b=XYpGn9u/MwbbW6JbTNuVblNaG4UdOvwELKoGDd7k8YX7vOdd/yY/wQCsgDkpPbh97J
 QjwSuPiTITiG12IxUjLF9OID4oGpNXaCLFaMoq7T2+et/IQESIw5nxNA0eRgQbZ8MsUe
 oJrVqigFE9scrTPwYKlYkRTZ4H4l1qrNdv2yKFyU0Qxts3H0rmeRTaeuXKdM8+rxoHwY
 XicVOxK/9meYh1XGjToUu6wryyNPPatCuKk2Dzhm1SB9xjyt9r4PdIwTT7Haw4jIPAKb
 zhL1m0DjnGcOtIeV33Kv0h98PKptpRdbMU+wkj6qKCqGa8zXWzvn0pho3SwbnSBH3X5b
 wbUw==
X-Gm-Message-State: AOJu0Yyz1Uqwz0hoDQFvZXOE1z7T9x4de6nOO8+5C3u0NiWzmdvsq8N5
 iH2201yiV1egT8mQMAB22e4EPeuiiFNXbQi30CV5lVNfJhV2Z6KnoEmEQZQQMzj3YK6aw+HulJs
 yxr0r4Z7ohSn57StqzuxPOtguAPKfuu17tAjzb6YjKw==
X-Gm-Gg: AR+sD13o9NZ2KYlwOSXbi6O0TvSMQ8j4u3xpJ4i+jFua9IZE4OEMXj0S/8DgXoXCNuT
 ez0oBM+4KPBooa6JkIDqvsOKrJj/kDl+SCkXmm1Ybalme3ViHvL3CrJha6mYYIsgAuuiAEVGDXF
 BvEU4Iq/0O49P/T9Lc6uD9qtzqo2gHba1jEp5Q87Ga6d6rJQroAFmiGO67ebI3uZVbQXyI9JXu2
 4sauOGCdmpfmpTCnU0Np5Uh/fgh6rNfXnXgqKn5L1xDYZE/SrNhuYH9cddqwWmU1Vk9o2Xg/bL3
 uk4RtaElbLEfkDw59h+CcjFoGIDVKkaH3lLCbSWIgVCy7A==
X-Received: by 2002:a17:907:9309:b0:c15:ca27:5818 with SMTP id
 a640c23a62f3a-c1f72115255mr181469666b.28.1785252969896; Tue, 28 Jul 2026
 08:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-14-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:35:46 +0100
X-Gm-Features: AUfX_my6W4ZypxGPWeKkoZqYvLEUovUQVTHXjAizzFrVXoUXEdu1PUNf5S6c-qM
Message-ID: <CAFEAcA-RZ1MzFUCuP5G3gPMdU_VBeRNTscUDo626UXCoUYyBOw@mail.gmail.com>
Subject: Re: [PATCH 13/20] target/arm: Rename isar_feature_aa64_sve_sm4
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_sve2_sm4 to match
> the feature name: FEAT_SVE_SM4.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E83ACD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKAv-0004ud-5w; Wed, 10 Jun 2026 10:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXKAs-0004uA-1h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:44:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXKAo-0005A9-VJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:44:57 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso987926466b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102693; cv=none;
 d=google.com; s=arc-20240605;
 b=kKtLbCwimTPbr3MoV2FgFuOy/et/CoNVwFy/KvmDYKS0w86eTbD+6MdX+h+vtKT/Gr
 XHBXGVF4GL7yegGfs/TdKVtjdL2dNl0KE5rLzvCMxOWIPjOE1fYsrs8eaSy7dlmuKOYB
 YCnTyAB4fzaNakVh7XmT0xLlTrWLkt0YPhnIAXIZLv8YKY57geM7awfo/pkpCyuq8wxJ
 GKMO0F320RM+1ut+6NWjSrSyKCs/sndxL1TyLyAxvlf80m9VcxdvYm0qv8uboFlwTJaL
 V9AZKRUk6Z6C3XetS9Pnh8Ep8F4EjWHJBOAAAoPvBwpRzSrfFXJpL2xOxTG3IAG/xh+s
 dYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WH2suyGrVwKp8TBKLRrVayQSilUAn0jK/Zs/palhL+U=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=kZSsk3OAYvKpUIdRLBfvLGFHv8bnqJiLDDXDW4oq+VA0wXzgelhHjS2x2pBxmVApPU
 c2znsdv7nn9ztiASTYTcEed5KPKXodHqAC/4801B6D1ogsTZqC3ynn2ITdryF0j/Dl6M
 jAFD+bkOJqlvOFXpKY2F6V+nmVzqdzOIp9Cj0x+nh3G1/p5Ntks+J3/CdwG4j/K2tc3F
 dxvQscYeAlT6exCRDtXmBL3HrdgEftaowVXH2/+DOUWkdc3Ku+wNLzAVV2scpsMvi27V
 ecd9YLlmtrjrUKFVMurv9oGsWy4tENaiXayYYK5tBzDmNaoEdtCdZNtIoOhNjNbmnirK
 T43A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781102693; x=1781707493; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WH2suyGrVwKp8TBKLRrVayQSilUAn0jK/Zs/palhL+U=;
 b=G9N5rJXdqWsZo87W8rRb+/1HkF3+113ls0tYQ2zPf1X0526jg0mlrBmt+KmQWtXkOW
 b+Yo7SvuPNZQoXsJl7cmSzVIA/26fu/ZM91leHr6tFhIOphhi+a0W2XY/ryKXwLk7xTI
 O1i5AwaKREhbsf3moemxYsfj0H8H9A4F9gRBsIO8C/+f+RhgelRKnYz5b5F1pelZQ7KB
 Yuo79xssyrePBSbcW8R7LhMFpBAte83XXYc0+RwDp2MxFJI9AmbOvdYxS28sjFa2GOJP
 wA7E+LjZAvuUygR2FRbd/S14coHWrujiHR/pYeBIxPp17iwVS5EV3sjjD8/i/WtoOmB5
 L1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102693; x=1781707493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WH2suyGrVwKp8TBKLRrVayQSilUAn0jK/Zs/palhL+U=;
 b=seYw/hRApkKYZBd3lStWuy0YcoRILXP3h6n/ZXmT8fcvoWEbChkBKXxNY/GOjNQ+Kq
 kBnLsg3Mlt/ZrX5hjgfYZgOpPAl+Dl13FyrcSwiz1F8whMeBvYAPciMugFxe0hByqHCq
 qO7EP/yejLP0F/sGARn19KaGIxdRLfqjgZFddJOUJ+JdLZksQnnDo8s97hpodIXSeF61
 rO0SBusX7aW27Qm8q1yOVCLGuGEssw3PGDo2n26gz8J58avyFNbMffdMhlER3liVA3jO
 yNCfnxc4DV17tA7+T+mV2oLir8siSuKa/gnsxpl+p7jhud81C2Fz+dQ8TScg6s9AC+th
 fDyA==
X-Gm-Message-State: AOJu0YyAyyvYgjEZzyxZz648EcSX2kKR21/h+k1CzDB2rTM12byLqxoT
 JhGX3SAbKgAPZ8JlZrAFYSkJ9Gfx0Kq2M5FHRu6aX003M27adz/gIda4oi3YRNJ20Ujts3BntIq
 NH+bCsy0lnIeI9ErAvI8QHltbZEInyZOgE/ld+Np3u5fCc+dNOTOL
X-Gm-Gg: Acq92OE7EsqCqLGrbDqe6Cc9qGweLJnHL6e97Evc2p/3Rk1ocjmslI3GrWJxrd8Mkev
 Ue2HvA4lAQ3ei9EpxMC1hLATAsT/JwD94R6W6sBO/hOlV/wrrqCdcucdsh/EoHVtRNaCMgvABjU
 ieRUGNLhnXaMsI7bErDc2cKdeITEx6mWCkRRtGSJC+pY0Kl7r748LNRnkH9ZhO8YszMjb/Ntjl8
 TDkGe9tspNUHS4+2QAktim6Cc3ym7BjS0X5ZA21F9S8LBmblCfiWWroDva3Akcad47/qyMev01l
 k4kX0ySJUo9hKXujo9bZid7nOhZ3EhrMldJYDCWiUcz6nZNWd2Jx1USALamVur7XVztDexrz+Xw
 ZoA==
X-Received: by 2002:a17:907:2712:b0:bec:5865:6c63 with SMTP id
 a640c23a62f3a-bf37234ab8dmr904048666b.26.1781102692667; Wed, 10 Jun 2026
 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260609192110.752384-1-richard.henderson@linaro.org>
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jun 2026 15:44:38 +0100
X-Gm-Features: AVVi8CeV1Vu7-0FrZRzBrOafxPXGsdhgC9TVZESSrwEqtaZRDVeV3EzMG4oslMU
Message-ID: <CAFEAcA_Lxo-6KDDJTrxpEfbYGrimxai4LciOmSC3CgfPVmYOAA@mail.gmail.com>
Subject: Re: [PATCH v10 00/45] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, 9 Jun 2026 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v10:
>   - bfdotadd_ebf and f16_dotadd fixes
>   - streaming fixes
>   - comment fixes
>   - All patches reviewed.
>
> r~



Applied to target-arm.next, thanks.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFA0CCD18C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8edL-0008Ce-40; Tue, 14 Oct 2025 09:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8edA-0008Ab-Vf
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:59:58 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8ed7-0004e2-98
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:59:55 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63605f6f64eso4349654d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760446788; x=1761051588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGAb+4USIiQWrIYxqWxfsLF1eArRgLsM7HUF2jQ9eV8=;
 b=E3eQFDm2RBDn6/qlzTkPwpKLXOYtr94IGojST20oI7M4Y3eDlySCYPyhXtlKDOVn3q
 nMEoWARlffoQX9JdBfgtYXNTpFazxKtWFpIoBKovYV2T9nd+PrVVDfkFoedzCKAdaGYh
 SB5z3NxAOyuXAMNUKUEvdQBXHov+lvuCS9w5Y0cosCOby6gNLZi62kepdN0sjvDpgtqW
 yV+Fy9aJAnH7VOoU3QIZO900KvE9dIP8hprxiHZhAU4dBfHYCk6FbMquBrzCQqRbM/1G
 vMVUHYXF2B1WvnJmdTGanjrBLF3cy1NrUbOT2E5AfOSfSgCMC6rjLZwVte/qeNVDqTE3
 yc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446788; x=1761051588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGAb+4USIiQWrIYxqWxfsLF1eArRgLsM7HUF2jQ9eV8=;
 b=OGIdNiStqKFlHIrOhwL4YqZJFxUri30psiCRi7Xvqlei3ndZQTF/zumuV6SXjRDx61
 P2o8F8A3GAJWd1g2/LzsLMIF+XJg/KnP7HFIu5JOOHyX1gw2rM0oG96d9529Ho7un5Hx
 zlQrXanb+wLKLCawYyzafeIpZ7jFkTXx7isACEbmHfB9axdwymwB60ToBQArug0sb/JJ
 s5NNOqEdTmJ8wASsUyeWw69OV5yHlQMB6HOjERVPj2xmUMGuWUpHJLRASp/4EXLWtKme
 M4za4wQXbkyIg/nJqb3M0mBaq4ir49DMHqMoyh86IHtatP3Qmgt0aQIxHRIAKVXfRGnp
 7rDw==
X-Gm-Message-State: AOJu0YzyxNbZMEPWYBY5xY0nONckdToDroyzCs7QKNHwkUvXBXjxAPlH
 M2IJEmfeWqFlXQcxFaNFCWd4Jl/O11E8POuA2EbCtxjiEYfQE8iTlhZer9gptZcB2iYtTUR/jXv
 fGKhB5Cij0cmYeE8gu8iwnuGmfSdssc+D9dXbc6VEiKdCmsKd6769
X-Gm-Gg: ASbGncuoc2ROY1BX1nnlxbDEi014yayqkfQ/5rosYSNnFVfsADTqXqfxwcx9O9F+940
 xmjE2zYMPtGEVepZ2QZczQXQSjUuA4mceLGq5VJBDRwJqLL+gQJDyVLTPfViKJ27Z2LtAFcVX9m
 Mf1hWmbJ+qSFR/HnEnV5I23B2zbSEd0rhKaSkUysQcalUnu+k/3LRQ7aliJFePwE4mcXdS3eLPK
 Cfv1QPI5faXjxbyRC1mTyVe/Zg9iqULH4IMZBgYqA==
X-Google-Smtp-Source: AGHT+IED4DPQdBK7ONm26OmCpKVlBffbLSUSkcJilcgE42YRs0GaEMyY5HjOGbcIqDd1U1OSOTWygdg0r2hHPeNy8JI=
X-Received: by 2002:a53:ac49:0:b0:63c:e72f:d354 with SMTP id
 956f58d0204a3-63ce72fd63cmr12424599d50.22.1760446788372; Tue, 14 Oct 2025
 05:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250729111226.3627499-1-armbru@redhat.com>
 <CAFEAcA-UrCD7mrmX_4dCK0urMmY5+qs=Y268WerQVq1c+7nB=Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-UrCD7mrmX_4dCK0urMmY5+qs=Y268WerQVq1c+7nB=Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 13:59:34 +0100
X-Gm-Features: AS18NWAkDU_I2OBOHorXRS1aTrsOfZLJKRYRT_z0zRWC_KiBP47Dd1fp0k_Ow-I
Message-ID: <CAFEAcA-01WR=jgdiCY57P_88ez-mRw07ShU0eWyzLPB+WbT_xg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 14 Oct 2025 at 09:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 29 Jul 2025 at 12:14, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > xenfb_mouse_event() has a switch statement whose controlling
> > expression move->axis is an enum InputAxis.  The enum values are
> > INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
> > case for both axes.  In addition, it has an unreachable default label.
> > This convinces Coverity that move->axis can be greater than 1.  It
> > duly reports a buffer overrun when it is used to subscript an array
> > with two elements.
>
> I think also that Coverity gets confused by QAPI's convention
> in generated code of defining enumerations like this:
>
> typedef enum InputAxis {
>     INPUT_AXIS_X,
>     INPUT_AXIS_Y,
>     INPUT_AXIS__MAX,
> } InputAxis;
>
> Coverity thinks that INPUT_AXIS__MAX might be a valid
> value it can see in move->axis, because we defined the
> enum that way.
>
> In theory I suppose that since the __MAX value is only
> there to be an array or enumeration bound that we could
> emit code that #defines it rather than making it part
> of the enum.

Also, there's an argument that this function should
ignore unknown input-axis enum values. If we ever in future
extend this to support a Z-axis, it would be better to
ignore the events we can't send, the same way we already
do for unknown INPUT_EVENT_KIND_BTN button types, rather
than aborting. But it's not very important, so the
g_assert_not_reached() will do.

(In some other languages, we'd get a compile failure for
adding a new value to the enum that we didn't handle.
But not in C :-))

thanks
-- PMM


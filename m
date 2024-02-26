Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AA8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeZN-0001gc-02; Mon, 26 Feb 2024 12:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeZD-0001Vz-1y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:15:03 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeZB-00038Q-Gh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:15:02 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso2345582a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708967699; x=1709572499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dp+jQbsrI400DLhHhmhFBG8YGQmp3xWwD1ad2M6YXP0=;
 b=KyANG8soiIdvCq5j8wRJL/JFxXmS9keorhETvEGsHRNluZdsd+48zmsByLRlHZMCfB
 sT+O7+Jh7jlDlmqcpP/OMb6k+y5NFh6p7hqdZ8rVCYQyjom0M2dd2NuI3czOPw3g0g3n
 yS9inWwxikogPMol/mcZcYzNJT5x5RNxN476VHrK1XmA2u2ORAdTnsLVKRFKMZpdRv/q
 8s7+Sxn+nxoTivHZwxskgq9y6Smv2atgV5cteiE3FPCKVC1S/5IyYYOWsgbDLScu+Wq4
 f+ZnbhqkH4gh8GZne44dRyrLwUOLGB6GRVxKHUbFMlcPxWZoVuJCcz6wIeYFqZyDBM7H
 JFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708967699; x=1709572499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dp+jQbsrI400DLhHhmhFBG8YGQmp3xWwD1ad2M6YXP0=;
 b=P2L9MCOzBii6aU/CL4BLcVyIC4KSwn7ms4zN2h84s3tH/f3zsd9DfPnHwV77o+qWbk
 1CKKuCm+CYDIClvBZoz7Fw00YuPGi1xekEuJKnzWqN91lj0tzI9xjDA7CZ0kPDLCy9XF
 Faf1hqS9/GL/gBnFE/xhjnqWXW/5QNaodprQU7VzlOakPNb/H15y7nFb+fo9RARiqGpj
 7A8uUaUGEq46PJttD6i8HyVU6QvIRXx8V5bDDFbOPJ8kGlcQztv5oAXkbRG4khFNQUvX
 vr+t7z+odFB1ck6gvbjTvfZbTop8oZm+t4+vuFsLYeAgN3RtkPwhhj5e+FLFjZGTSdEX
 1Cxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfwQ0lehTtN6VbDxadrKbX/3L6GgrN0fzmYI3g7PNe3hGXH1kQvqrwjb3XGlHcqjZZanMKNnNPP6RkTsuu84ZmnjJwxE=
X-Gm-Message-State: AOJu0Yz4UOnLcDFESyeywfDO0lBjsBcfEpa4/odRHSPNOA6XLXo57JrL
 uP2eUFdbD+eTPYujJie5KKNAyQ27GnHsU0fu0+tSCr2wOG5ZtBqgDtCnn/49kfRfO1y1dRhpGIf
 m2tSubj7mPSJP+y58jSmsKQoX5OML3kmk/VQLVzn1ek8Fj0nU
X-Google-Smtp-Source: AGHT+IEA7QsfnpLsInc144eNziEPGWFrUfl4KLiQRlUiNN1vIDIiKe/c04gGffcrbZHF9F87pywbNMTpMv6jUvvNJ4I=
X-Received: by 2002:a50:ed9a:0:b0:566:131b:5b5f with SMTP id
 h26-20020a50ed9a000000b00566131b5b5fmr1356902edr.26.1708967699696; Mon, 26
 Feb 2024 09:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-6-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-6-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 17:14:49 +0000
Message-ID: <CAFEAcA8YSfLgGOGb3d=reYOPYE7jLpDmU2MtEO_G_idJzE15Kw@mail.gmail.com>
Subject: Re: [PATCH v12 06/10] ui/cocoa: Let the platform toggle fullscreen
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 24 Feb 2024 at 12:44, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> It allows making the window full screen by clicking full screen button
> provided by the platform (the left-top green button) and save some code.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 408 +++++++++++++++++++++++++++----------------------------------
>  1 file changed, 181 insertions(+), 227 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


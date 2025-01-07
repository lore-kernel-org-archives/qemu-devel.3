Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D36DE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 22:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVIBz-0007jg-0H; Tue, 07 Jan 2025 17:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVIBx-0007jB-7B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 17:36:53 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVIBv-0004Fz-Ne
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 17:36:52 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so22653635276.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736289410; x=1736894210; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N241ko3mBat1dQriBDWreCij5xSrjTHvxl/OHD03dxk=;
 b=h/zT7eNBJxWhS08MNiH6B46olv+zuJnD1tJ1qQp4PIr0MFslahchfQoRsrbWeSUDL5
 D0lmCAK0c4YiQIN1BskV92wQtSyCsG4uyQIifhi9zoKZYKvjnHRUPcji/Xt+T1u27HfM
 U9nWrFewLUL4AEPNRKsIUIZrzizo59fT8ggremsNxMPHYic7DVLCU8qc023vNZlHtLnR
 mlwqwD6enhF0L+xqff4XYgfx8eaG+ux+iIySOgTmTC/ig5PhD35c0W5fiOaobuO6EkOf
 RrqrApq/AeRzqp6yQSTsQQmb/hDpwA/+SOtkwZqXWDK3ijIJd8br/93WAULX/B2Y21R5
 v7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736289410; x=1736894210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N241ko3mBat1dQriBDWreCij5xSrjTHvxl/OHD03dxk=;
 b=YfIW+x6mczRHtLLKw0XJIAYq+DdP1IjVYz00HmB9VRlgtHF0yWsPovwdugWeyArSjw
 tcPkPTTxEKfk3AnK70pN0tf4KMC7T8bchwYT2P+QVaRvKTvMe6Ief0+4IVkNtetG4OuK
 ORGJ76Jjc2kVRGUkf2ryvaylxjRING6154Q8kEaSK3Qf0Y5kzuHnvT9CkHDKCv6hm6tW
 Hq/b+jZOEDj+rCqPXt+ya4rGj6as5bjzjqU+e+rL9XVYwFXMFUSqJsGGoE/eudLfUr/B
 AnOq5A/Cyj6bwE9cqu+1grVa8cOeMKyVQFp9KMzmDGS/7p6b4bUxiPBNvDwH+a56WISo
 6f/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXP/xySfuZfyBiJy8bJDMP1aCUdzWIqL2d+knaCIhf0IehOv9wzG5QkSbEMR67DJxARF0UU7CyZq80@nongnu.org
X-Gm-Message-State: AOJu0YwusNxlGoV/SSX8eJmwQckD3rlgnH3xq4wfD028/wOBVGhoy6Gj
 s45f1uvKbWOaMWmDhHtdfKRru7gFyvEJrx5mDv3ZUcMyUxkAAGviWvy4GpijvBEESw6fHpI7DJd
 ZHJp/NVuMXLP97xtZ0u8coCqm6o4jU+JSF+GCSA==
X-Gm-Gg: ASbGncuSgi+sMN7S2lFjfg9er9eSHqLsCZpLg/GxfMXPROtNNiJDsCGHsJ4p42EEvgx
 lMAgT9xyKupY5/9tZEeKETP/6X41gJh1eAnSaz28=
X-Google-Smtp-Source: AGHT+IGwxRNbzOHzovcornMsa7cSCwT+tNnfFdkQQPShSNA5dZbZogaZIaJlwZHwwlpyHVzruKMjCADWgevTk0dSkTc=
X-Received: by 2002:a05:6902:1886:b0:e53:a95b:98d2 with SMTP id
 3f1490d57ef6-e54ee227f94mr579672276.44.1736289410548; Tue, 07 Jan 2025
 14:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <2e956389-289a-4806-8985-ab846d808736@kaod.org>
 <b520adf4-12f1-4261-a48f-bb74589bb31d@linaro.org>
 <a7c967ce-6bc0-47e0-aa25-cc89dab29cfb@kaod.org>
 <CAFEAcA9e5PFNoNh4u7paY5k5RnMgJ-3c++eGJd4u8CjjvDCvYw@mail.gmail.com>
 <53d67dbf-b595-4442-81e7-84267aa8e511@kaod.org>
In-Reply-To: <53d67dbf-b595-4442-81e7-84267aa8e511@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2025 22:36:39 +0000
X-Gm-Features: AbW1kvao-OSrFjrvLlCeougddZRu-3ILtDjF3HoNrbR0Ri3vuvdD7Ywk5sY2Qgc
Message-ID: <CAFEAcA8Dz6b0fVjhEntNbbbb4UpBikUXsOmzU4WNabbrac+6Sg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce a new Write Protected pin inverted
 property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>, troy_lee@aspeedtech.com,
 yunlin.tang@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Tue, 7 Jan 2025 at 17:55, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> > I would not recommend using qemu_irq_invert() in new code.
> >
> > I guess in an ideal world we'd implement a QOM object
> > that encapsulated the the "not gate" logic, similar to
> > TYPE_OR_IRQ. (Though for TYPE_OR_IRQ we made the mistake
> > of making it inherit from TYPE_DEVICE, not TYPE_SYSBUS_DEVICE,
> > so it doesn't get reset properly on system reset and so
> > the "what happens to the output on reset" is still not
> > really correct.)
>
> I see how this would work with TYPE_PL181 model but I don't
> understand how this could work with TYPE_SYSBUS_SDHCI since
> we don't have a gpio line to invert the level. Am I missing
> something ?

You have a gpio line, i.e. a qemu_irq, because you're passing
it to qemu_irq_invert(), and you could instead connect it into
a hypothetical TYPE_NOT_IRQ device. qemu_irq are GPIO lines,
the type just has an odd name for historical reasons.

-- PMM


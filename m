Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeN0-0001gc-2l; Mon, 26 Feb 2024 12:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeMi-0001La-JE
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:02:22 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeMh-0000i8-6F
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:02:08 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-512ed314881so3183309e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966925; x=1709571725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mDQlHq0G8B8G4OTR+Cvh2hLL3vo9Xrq+fM4d7Yiqtqk=;
 b=jCt1hHFnR7r/KnHKVbwS8g80b8/3yq7Z935YHkQqbN9RtH5lOjDUAcgscqPXf4bhNz
 NbglNudJbBbOqGj7Z/FsTzs2QG35XkeToeINqzIV2fZQPIH0XSwUHhTcJ/oJodMaNFTE
 ggMFnSyKdqJryQ59inHnKURQY4dyAA6qA/EWaiBB8YCWYde1OqnFgiUeGDQuCJzpYmLz
 O+W6IRhSfugXteCaznxWa2fdeZUoYuPG9ke65TLR53ZrUYiPlN9kZEj97FOeVmQQuiyJ
 yHMz4E9T7upv3FCCPJnCpRL/svaZvRT5YlJVgkgKQZXtNwN7dLNHAnvPr2mBdUtI8/9W
 xifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966925; x=1709571725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDQlHq0G8B8G4OTR+Cvh2hLL3vo9Xrq+fM4d7Yiqtqk=;
 b=MudXkY2gNIc4+rAKRuQaCP4nKJOqre7iZRO5NdcIm3mVn9uTpVAgvIxVY1ORa4MBcr
 Qv8AIJBuqyseBNxHzJhfoiAbF40QiDsbipvzVRWdYeihL8hk36VcUr5htcMs51+tfaM+
 wwCqO1S9PWkbPlQOpgqMaXoxIzrbpW13RCTBSuB1jPNmYxwAyBwpfNoCVLkYf2OPtV7J
 Wp2QOaDiIyFg2Ixl0PAnV4Sme3DyeUT0rbHdG65tLconKr0lwtBOdEzGoqttPsY9NyHN
 8+acDRzQ1AC2Z44vtTpzi5+s61sYKzbia5yc6ehR6XJOdjeBW5B41T9JgZf0QyBN7GxY
 JVYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr9VXbQmWBeeQ8HEEBdBUmcqYcNgcBVCc4JyfHvuL+t6J/Gn8hv2l+EkA70BmSsuFHzspqhtws7cumfH/HmRZ0Zxev2v4=
X-Gm-Message-State: AOJu0YxqGaPdWZQE4cQa/9Dp1ZjK/KuTVQxfSP3tm3BzJsvuU3Ni0jlz
 m2CDymh6QYV/1WDoxhaLZRdtLrlSwQ44XAB2cIEHZACFXDZEjokCiLjX/2Xjl3t215dkx0B1Yz5
 1suLYRmcoIScw+C14lbXxbHKKnsAZ+3a2Kd+hVg==
X-Google-Smtp-Source: AGHT+IH1knRZvYl5gVnOXEz4DUsh4YV83puaE0PF1c7spwBz+0vcpJe7q5gx/XBSWHFNuI8LdSdS0w5T5GlrRk7NcZo=
X-Received: by 2002:a05:6512:3ca1:b0:513:b6:df58 with SMTP id
 h33-20020a0565123ca100b0051300b6df58mr1390605lfv.38.1708966925256; Mon, 26
 Feb 2024 09:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-5-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-5-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 17:01:54 +0000
Message-ID: <CAFEAcA_Q+PpyEDNARShyuFHSTByfaaGbQUGWHQYFwh9zENeX6w@mail.gmail.com>
Subject: Re: [PATCH v12 05/10] ui/cocoa: Fix pause label coordinates
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Sat, 24 Feb 2024 at 12:43, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> A subview is positioned in the superview so the superview's frame
> should be used instead of one of the window to determine the
> coordinates.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


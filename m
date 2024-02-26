Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DEC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeP7-0007Pn-N5; Mon, 26 Feb 2024 12:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeNm-0004dQ-5b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:03:14 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeNj-0000uZ-HI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:03:13 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso4272506a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966990; x=1709571790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LTGWpjkS+rBg/3w0lgwfOKkQiyMzwwqkBos1vPgYBh8=;
 b=jasVThGSYcJVBbIqc6zQU9+WVPgYipgxmC7/PnaM+XHTg8tYTeoJk0wqaRoAlw+HLm
 RtFisN/RMpLLUX7SrI5JXJjfgnWUKtbs+6W/VR8H0sfe/GnH54+/oXa6B+9wrJnGeM26
 Dm2TQ0U8HeRGOx/AQfI8ep2+NgHv08H1r9H6ySCM15iL5uFn3a50dw0yJyJNffIMYFNJ
 yzaifgJHJ1xtL8S7uTiWfmGlL1PNN6tEB19t36ur90PZP2ityg58bOiOa5hC3bHn9FP6
 WAJsr9c+YlcHIyB1eTqVSBlGuLvhcnZmEY8Z0Jy/7UtRPk3FQLhmPQ35+XYxSZJ0hWrt
 /ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966990; x=1709571790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTGWpjkS+rBg/3w0lgwfOKkQiyMzwwqkBos1vPgYBh8=;
 b=O4LUIISLSsRmM2kp8U0UdKDBKsaBHKL+I3E92rjlb6Fx14wB2YZ56RmDRY58pwgR44
 Vwr8qv/fowllCIxailX5w9C0eLzPu1snJ1IcaGZAGMISgI0ClA4ebz5c9u8Z8zL10n7I
 +92/P9M6alg1trqVhWkmEoh0A5Gqoum23TzhFv7n9Y7a1oN++ysao3p1F5yELUqkNxjp
 7DY5Yc5h1NUYlZ7lBR634OtBYY1Ki1FoIpGMkvTtA/0C56uzu3dFKp2+U4RYSq4WzEL9
 uKZeYyZ0d0Nxz5FIuefn/dykmun4pzHlw86teeoGeKb4sO/oXlXeUX9imU60xJwuk8XQ
 71dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzUqopwI8ouD6ESAbRRRU15IQ50YF/bv3rD/jJ2a+dspyXC6pO1fOsqFLu4Sn2hOae7KNZ1dRWUYksbfjNatV/c66zyPo=
X-Gm-Message-State: AOJu0YwPXAr3MdITbwuazEwpvVt0EwVd3QmEZt8r8UoHQQoHsaUlgpxK
 ZNGksXLoOgNrWHHy11jhThir/Acc5Dw/WFlBCHk9tFxM7/4WuIrMEz1xU4ZGyjx44DJ/bdqlrV9
 0gmwXb54JF0wp7j5sFo7zAcRf3jOdLsN++2d7SQ==
X-Google-Smtp-Source: AGHT+IF2j7hCmOTsKAT4+yJBZsVfALeTT78WM7LPKV8vpkTqmdjZzq7sDYU2rWIXrTO3N7gMdruL+PZy7RMioNabk8c=
X-Received: by 2002:aa7:dd06:0:b0:565:7ce5:abc6 with SMTP id
 i6-20020aa7dd06000000b005657ce5abc6mr4141199edv.40.1708966989946; Mon, 26 Feb
 2024 09:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-10-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-10-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 17:02:59 +0000
Message-ID: <CAFEAcA_YTAoEiUDazdAMV1ikgXzwoYaBg5bNQJDbVWUFT7vwLw@mail.gmail.com>
Subject: Re: [PATCH v12 10/10] ui/cocoa: Remove stretch_video flag
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
> Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


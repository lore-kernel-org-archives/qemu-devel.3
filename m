Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58EC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYtV-0005Ir-Gu; Fri, 23 Feb 2024 11:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYfV-0008Ri-Aq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:45:04 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYfS-0001YV-Rb
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:45:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so791228a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706697; x=1709311497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OFrg0IBE8NWD9ilXgxLCsyY0rk2YMPmyszGTfwc2OgE=;
 b=cJPOIyahsKU0qiFt3PbDtQELQWWu93Bc0UZaNGYAVihSZqBny5PTZdvo+41ws/mgZ4
 ACf5E76wfOEO2Ikzxh4X22YVgg3ULlgabXa3pBOAYYwhEhCXTys5mp8dZ7NAEvArBPLY
 TZhkAn/PxxXDJvLnCdMUp1POocoaafTWONrl36uSWOGjBdkO8fLrsnwfOEC4ai1NXMUw
 /MKYEGhosB2TnsDo1ERf01fEoDUujwAQqleLYBTgbhmCGNJ9+RywOJt15ZZTGUxiX9LS
 lCr+tARW1Vg4u0KBfSOnK1kPTOp60y/5GjUWezTPwazj0Y/pUcRKlS7gS9ZNyiZvrrik
 UM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706697; x=1709311497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OFrg0IBE8NWD9ilXgxLCsyY0rk2YMPmyszGTfwc2OgE=;
 b=wbdJSBQ9Skq/7tGd8U7nEAx7Jii28Fs78v2n+/vwsw/fSpWSIFxObCLVi0Byhsq+3e
 w+KGXuVpRCWBYSmU0RGv1XW/ZwI0jEgxR2F17Aha5085TupT5Euuo//wqHjzCshd9jsh
 WW4117NAEqSOBLSwMoROAfDurCu/tS3huLS+mbdTz+9M+TWlDE8TnJRHJCuBpWQ8RI9o
 pqOveQTmv5Wgf9zMlX3Xw8JYnNtzZ7/YJUNY/Hw+JZYgFjyluSXxISW0ex0K+wy4qpwP
 CWCqSIYKL6K6HGhiryk/HyyHNMeA0yZyAIt6ZW2YmPgUO6ugGSMMlthLMO/VYBu/d31S
 JriQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWueLiKCI+EFkk2qMHLsgUVlVaffkdbD7jrdz+LcX8Q7GetlIoY0deDQIAxlwXCFDOqje07/X7hk9KiRUBdDQ8dQjy//u8=
X-Gm-Message-State: AOJu0YxJrirx1+pKke47cLYXVuNMb58tPCFLl8iCQmsin+CmjIvuiFUJ
 sf/jRKzD3U12Lvu2VtMZ4s3cX3bLMmQMM0DudiThVhpjzQ2rW5xlA/dduWLwk+qnE5JFamydZu5
 RQFHN5UZ1ObM9C5CnEhXNvbOYcJcmnMgFD4hZow==
X-Google-Smtp-Source: AGHT+IHFo/iy7wtUmYSTE4FqcQ7lOIcTThOBlFpa3mrw37BvwE39JyorzTR9P+wFFeL740phwlS5mTLQ9O3rMLmXCGQ=
X-Received: by 2002:aa7:d989:0:b0:565:833b:639c with SMTP id
 u9-20020aa7d989000000b00565833b639cmr250793eds.23.1708706696972; Fri, 23 Feb
 2024 08:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-10-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-10-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:44:46 +0000
Message-ID: <CAFEAcA91wZ2S83gASvnAmH+db48B7ubh=3vcvb5w4vaM=3An9w@mail.gmail.com>
Subject: Re: [PATCH v5 09/41] Add GPIO and SD to BCM2838 periph
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:22, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 143 +++++++++++++++++++++++++++
>  include/hw/arm/bcm2838_peripherals.h |   8 ++
>  2 files changed, 151 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


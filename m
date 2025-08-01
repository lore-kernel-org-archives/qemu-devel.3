Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E641C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvRu-0005hd-Nw; Fri, 01 Aug 2025 15:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqe-0003I1-37
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:16 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtqb-00072R-4f
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-718409593b9so21283347b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070432; x=1754675232; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=868NPspYkfdWEAOIg+RDkE3D6p2mKG5XtRsuB7ygNQo=;
 b=sIziO2V/JKPmCYhhI0/JRxqGMgWpbHvHDuFOxCaRj8e9fz9wNDdeLP9UJQC4wh4UBI
 4KBY88Vije7/5jJ+9x760SpndOEGJbHcpxo5ZTQbLTps71AXJKQ0m2eWWBn41UlBEQXQ
 6q7bHd1H1y41sRnWDrYenQ/m2WzFozTJAKnLRRW2dpGl9GMo8ExvdqC16goEiCoCSAQY
 eNyGUAU2XPJszvX3zgLOZOvP21CY9g1gHFXGIqEhTljmBFk/IqhWoG63GZz0g94hcSbe
 Ekar1eBPeTgQ3naI3OsOUotEIRYS7h0hFDWWCxqCvh6UMn/wrFgit7SnIUFNEwFLycaC
 yhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070432; x=1754675232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=868NPspYkfdWEAOIg+RDkE3D6p2mKG5XtRsuB7ygNQo=;
 b=W3qNs8o2xS34rn+KfS0ENZMuBas9UEyL+pzcG3dvcZDkZlAeobIUJ5wHO4PX8/Q+Zl
 esGnvYyYWmzWRI+mHE/dSTefkaRrR1GftiIM4D9sxrj5mls0a/FyZTC5pBxLknIHk7Ag
 htajr+o7h30sJdPoxhzm49206Fpr31ck+HW7qhTrYqnYxhVszwvKhN2V6/G3L6U/ziz2
 HKQwlBXw/3Tkvv9cY12vHffAVn50j23CsbeyLvDLyU4C7+JpDNncNuGTBDqyr77TvjAA
 F73npXYZH7IN2hXQRMSAxbLpttfMLHFt91hZjZT8k0u9SHuIaKczeYc+zcTBy155r/ce
 cs2Q==
X-Gm-Message-State: AOJu0YwJOWXuXE8gcoWuxZGdBVlfRjUP/ekke3Bo71yVoIQ8+YEErY+c
 NoNf5lia9IuFBlDTB/cFw0i2JiPF6fQuX6mK6HUcZLCjOgeLBkFVPZKJoTrO9JhKr48zFgKKQnX
 c0rTUs4K752OTzgKozqBHBHUHrMj5C0GinNXPJWy/ezuFhzgv7HlE
X-Gm-Gg: ASbGncvJxd8VsuGHFgw63SsjDzIFNID7WmIcZf77yXLw97XBBIQioHOeuAYWsQUgmpk
 Fy60ccecax+eX4q/tFK/TeOtfZv8pCBehOrtMUUomcHy/iYfvBHo7ljoHpD8OwxHh1Go+NBtCwK
 z0KOmTXGVNNR1SOwq5gEihr3C7wOC34mycEZJ6T6UXFus1EDbQHuaC1xlWyCcnjehU1JhW6PyY+
 KDNfKBe
X-Google-Smtp-Source: AGHT+IEiMvkPPf1GJ9qdp1oAtxG+w7aqEU7Oy4SCAE5jZq7i++/HHfXu+2AoMWB1UGLVdYRqJ/3HWjUNOEstYjjzKmA=
X-Received: by 2002:a05:690c:1a:b0:71a:22e1:b32c with SMTP id
 00721157ae682-71b7f5bc0d9mr6734887b3.4.1754070431855; Fri, 01 Aug 2025
 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-46-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:46:59 +0100
X-Gm-Features: Ac12FXwxapvJJV_htiwDHlG6Fip7FnsR9LlvQt3V0AB1iSF6awbUk6n6pGgXUyk
Message-ID: <CAFEAcA-P_x_UT2a7Z+3sJj+S7OFgYfLv7FJOAoc3T8n+2+6rWw@mail.gmail.com>
Subject: Re: [PATCH 45/89] linux-user/ppc: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 30 Jul 2025 at 01:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                 | 24 +-----------------------
>  linux-user/ppc/target_coredump.c.inc | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 23 deletions(-)
>  create mode 100644 linux-user/ppc/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


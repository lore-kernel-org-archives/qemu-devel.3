Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB54C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDq-0007V5-VC; Thu, 01 Feb 2024 11:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaD9-00063I-TX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:46:48 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaD7-0003JM-MT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:46:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so1590694a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706806003; x=1707410803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA/kGiDfzX1A5w/wxeINU1T2jPUfKCLdYrO6nr1TyFg=;
 b=trgYBEH1QkqEVCutqWfyRMk+W4nd7qUvGUXwgu+fUCYkx6rB3xEE8caKXNvT3oZN8y
 i/MTE/S20TzG/Qb0CXxa9k50OUMZSIQTigAtIjlOhvay8Sv7ipUatsFK5Cpgr5XCSjCj
 vQ5kf0yO4UASPrVDs8lPx/2hmPDga3I5Q40dMv3gjln5MfXSMqXwBcl+kHWAuEPYvVCl
 w/zrTdVXMnj8RGzvC3SxdRQfnRD3zf6ZuT9Qp9OxHAfNTajlft5E1B1zy69myXyWtVH9
 ZavP63zs3WbryktNBex0MT3LcondxmghUI07aBRanq4tecFYf39Ors8L4pVGuhM/ow3t
 CMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706806003; x=1707410803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uA/kGiDfzX1A5w/wxeINU1T2jPUfKCLdYrO6nr1TyFg=;
 b=h3vuznbst+GyFC4RsXi6TtQzUNwF78tC3an0nFxaXB+pIJWE5UdvjSuhgPYkWFSuyQ
 Mh4hLN6YuBprBZl5lDBhbIdyvytHjRs17Z2V6osxGseEPNWmJuUrl2DsTDamu0wbwMjY
 gmH9mBTivl6h4/Lsn5c3rBE/QDAzxbutZDZvvlFcFoKIunMHcU0MEtn96HZ0Ijd2lxJa
 be0W5VbAlMNfcWsSMhWvcxVcxSvD4o5q1ztKPOUIdblO/P3g0Vk0KrbfX+UsY9JVU22J
 QeJtq/BsG4thdsmn54MWfSGgjZhfxGssBNAWx0qFx0s0ETX4xOFeyq2v+uPW9ARae69p
 Zs3A==
X-Gm-Message-State: AOJu0Yz39NERDmXbqSYrgHdLUNKwUHHMqDZ5LbzbJW6FFM1TJlPrWR10
 E7f1vUOogJAOtIpiqA33y/zkhbavGNsCWa5+HBNbhgOOUmGeS/+GJHPf/x0Z+dDJfk8RzVe9flo
 H4Qaxp0qlE7P5zVxH4K+OCPyo/mab1mNDkIw42Q==
X-Google-Smtp-Source: AGHT+IFs5dKEIt0IjraLfYUeWoiNAcwT/i0Nwamo3YHTdTu+PSEUZT8zUw3jFOb52TsyOe+VonVy7iLvd59nlpqYUoY=
X-Received: by 2002:a05:6402:1a2f:b0:55f:a102:55 with SMTP id
 be15-20020a0564021a2f00b0055fa1020055mr2817393edb.10.1706806003004; Thu, 01
 Feb 2024 08:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-5-philmd@linaro.org>
In-Reply-To: <20240130190317.25692-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:46:31 +0000
Message-ID: <CAFEAcA9V7wQr=LEvv2DYT5SabPe2H3+V2RMQPHRVZ8avrse9ww@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm/stellaris: Add missing QOM 'SoC' parent
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
>
> Since we don't model the SoC, just use a QOM container.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Ah, this is where the other qdev_new() calls are sorted.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I wonder if we should add a variant on qdev_new() that
you can pass in the parent object to?

thanks
-- PMM


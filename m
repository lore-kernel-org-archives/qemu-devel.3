Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D670FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMqH-0004p8-4I; Tue, 06 Feb 2024 09:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMqF-0004m3-N9
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:54:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMqE-0000yv-4r
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:54:31 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56077dd7936so2467368a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707231268; x=1707836068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VjutBhRlYmo1DRGC7Mrvt3EGfc0jRA5QdNLOuXPjKa0=;
 b=HRvjRo4E9cx2JIFp9+Xzv8LPOhyTg0uPZnEKH3A6p42DzmD4Pf6n5NHh0bD00lxinT
 FoEH/MJS5pYYKICAkYfCLCc+rTb3Z5IQUHGEydaWrXPoRE53LRHJlEGI/tScBgNb7Mz5
 /u2pLLM/gatBgX7o/gUodGV2MvrRayn+OXvo3QGgaRbkdHlxg1SiogU2RUdAxQJPiRFN
 KASGPNo39e6eA8ERPvI3L7QE6XAufaNJJ9UVEgh2Sgg0Kczydkca7pKh+PsKrwqQM2V0
 wDSB2aKkDGIg+QOLJY6rzY3sTmzWi0gdb3ZoUCjF0UprUUPHgYYa3S8jVkHZJe7+RpKO
 /e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231268; x=1707836068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjutBhRlYmo1DRGC7Mrvt3EGfc0jRA5QdNLOuXPjKa0=;
 b=JW2OuOl5u/rS9jEBl9Mav4L+1nHqfqXxGJ1jiCtgGDdzCufYf3mz7K85gXkIGpL8Gt
 R+4Yve0fdLfK1f8vuiuxw/taBz4Nkuvao/vL7GJvouSgO//gaE0VlEmjXAV2gnFEntUs
 tH0W9q1D37hGpJ8x9hYWmMXB2ujixZVHksTPRFfp3mVyihdcak/sYHouH+JES8Y5QzxT
 n8hXS2ttont2hLz9QFgNsxybhW2XdBI+RVEE4ke8ZvJOkQR9yftHUDi2Xw+fdFoKJCcz
 RKoFRX5sTkHPgGVTF5UkGe+v5Hqxc74qb8SaG+nFyp88dpFbGAldOeH5ZyLqivP0Rboa
 QO6Q==
X-Gm-Message-State: AOJu0YxUl979Cm3/UsEhKESlADHX5TFjhra2M/C9c4xMxHGof/CYvAQO
 ZnnaVO2iPnZ7fipRUbZh4XlVH2pchgO4PnrC/tKkpQS24PqY+t5FKl8ZRBIApmtDaqV/UTMHw9y
 ez4l1682rNDULhxiAea8+kM8Vupin8g5SP/4M1w==
X-Google-Smtp-Source: AGHT+IH4hOXJELUROOKjefczaY7l3Y7yglGI4GFH6w1R3JsH01rbTj19BnLN1fY2zak2xuEcGvDSz5LeWBSOTu1jM8U=
X-Received: by 2002:aa7:c713:0:b0:55f:e682:9720 with SMTP id
 i19-20020aa7c713000000b0055fe6829720mr1817322edq.25.1707231267766; Tue, 06
 Feb 2024 06:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-7-richard.henderson@linaro.org>
In-Reply-To: <20240206030527.169147-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 14:54:17 +0000
Message-ID: <CAFEAcA-pZJt=+3CyGN1E+-_+-2JeyzgdQDFv4ZFsN+8QqF+=2w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] target/arm: Fix SVE/SME gross MTE suppression
 checks
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 6 Feb 2024 at 03:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The TBI and TCMA bits are located within mtedesc, not desc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


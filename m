Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03408C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkVy-0003gt-Rq; Fri, 04 Jul 2025 13:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkVw-0003eX-RU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:47:57 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkVv-0000Hm-6g
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:47:56 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e731a56e111so999343276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751651274; x=1752256074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kbPcFz0yVBYdMqdUt8IQXgiKBKOoByKR4H2dND3V97g=;
 b=NbswVKSHwGZXBy8tBuaTBXrbkjc4zO2Djn1EYYjf1+K6bRDFNVvfWk/D3++N7po3XF
 DLaMuIOPARY5nR/5OMAa1qErtcDEK2rAdev+zOqk8m5HWvIT/omY9H3Rk283iQBA0waY
 PpwmE3Q514iNehC8H+ANyT4BprsFMdQWFU5AEfF6LYBbGZLrV+R7awXtdJWa0LujbQt8
 bYJ/+CM6FXwRdVlsnpYzvMm72Xh+ZlWSldeJKt8UUTgnnp0SFfVk4h96+AxcHpeRuivr
 h2biH41wml/WFD9o2aF9UiAId0j5hINaFHJuLHKzdIq9m2RWLj8QBkM11xWjYmp3XvVo
 qC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751651274; x=1752256074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbPcFz0yVBYdMqdUt8IQXgiKBKOoByKR4H2dND3V97g=;
 b=XdV58Y6cOw/ZMWQp94Zqtm0dAQ4fJAPApP3ua69iMGKsipRFGQOnFhCuAsaNb8lz0i
 6JZ/uFkLV1egdBPdfCdiGkRwaOy9vOSG6f7TvUl7paCM4mEM7J1QcZcCgVHBxebtUGQ/
 C3rmXtMv9HgEVS4LgZ6Dgbax2Z6R9Nv7RYsWo0kSuAJpy0g0fQHncUTGZO4nRmqLE+pR
 rcEivXEKWUDXODLhWmXsMjfB7KXO6GX52H7f8wt0w+7fbbgRW6JOWpbWh4fgGexlQhwq
 roB9YJdYrVFbymtyLw42QYxdXpX2jL74WJ16/sYrKEcxprI/S5kMb39LpVof6YZ6bLtf
 Js9Q==
X-Gm-Message-State: AOJu0YwOwq7MNO7kuX/4412tMgUEgVNd4skehZSJx25JFwFrFYjjquXf
 9QenK3CQDi4dQ3/dFXiMylvWaEshds0XzIGOVV8f4qmU+emCMm7bdlDDHDheor9X+fKpwKSkzG6
 j0SFf6+nw3iY14C1XfkSO+LHQcOAWIlQe0+fD9Xvj+A==
X-Gm-Gg: ASbGnct6rIqGY1eUbb5plpKZ/95y/IaVTilRdQJZDC/J930BUK5sMlSWdJ6Z2Col5e7
 4D7/jg+t43mJoBDCkncLWmQRNJShIPAHGPUsDFQP7iySY60NwWv6rCI9YpQJvHmJeA1QFCPBrZ5
 dS2voyPVm0dbqUHu2JYaOZGZFgtWt/sqlspqX/jGP2qXYuKHMXSNkjnK8=
X-Google-Smtp-Source: AGHT+IFVP6rzcym4dWsvJOmBhRNRzmGLToGfkhMlcx0pPvQOUggAjodcN1ScyLtFUblzQ+2mdnH51ugHW5hXSl0sB9o=
X-Received: by 2002:a05:690c:3382:b0:712:c55c:4e48 with SMTP id
 00721157ae682-7166b5d4c63mr37421207b3.8.1751651274062; Fri, 04 Jul 2025
 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-11-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-11-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:47:42 +0100
X-Gm-Features: Ac12FXzFjca56YNU97fN8EJ-ekuC0QH5Dm0sTGjY9xSfF6KMyzla8AheT_CsLsM
Message-ID: <CAFEAcA-DBKyxL4By6O9tN7epppGWo5Y5mJ3Ku8CqxrrWzGNEug@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] MAX78000: AES implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements AES for the MAX78000
>
> Signed-off-by: Jackson Donaldson
> ---

Your signed-off-by line seems to have lost the email address part here.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


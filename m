Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31785C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYx1-000189-0S; Fri, 23 Feb 2024 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYi0-0000fR-FY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:47:36 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYhy-0002Fh-Oc
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:47:36 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-565468bec51so1966612a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706853; x=1709311653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=llXsudmdYQAx5QfO0HXhkgqlqTsadywEAWz29qbJw8E=;
 b=THFyZ0bUAX/JeW6eF0ayyVSJ6WGvt0abosdMJBcUT4XE1Z/u7KS9Nq8q4mOdWgPTy/
 PwdNm48z6Qy9koh62scD3UYHg5FIHEkdkVekdsKHCR4ooUZkqdNSe/8PM/+lMI5kVuZF
 D9O+q4TazgMj4VNWIXaWqXPo9usAv+qgujUz18vSuM8Cq4UAkC7GEB9nbxq9uCC2PsJv
 VmHU62/bQDKBHKBXaUhSJCHCqKBN9Kyk8rp1uYO+tbA+RLuUV36lDnsluxGxO3L3ivnR
 C0DRxX2CSLX1bnBg9X5x0hgZ2Gmxa5DZPJhp1WYBBQke7VqJMfJ1q7Pd7R1sFhlgpcV8
 ORyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706853; x=1709311653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llXsudmdYQAx5QfO0HXhkgqlqTsadywEAWz29qbJw8E=;
 b=R1N2yTs+SAq8/heFDuWnlM7/iIHxQnvRd8vTf1mQa9FL8NJ3iWAr9bCEXTSenrfuIt
 y//zEJgGkA5lpJm0B4904f9ENPsfIXNvV5hVTqRxRotJo3u/Lw/sJrxBqxUHIwhUYze6
 PNdYJUvIlbCIDMa5Ay5Js2r48WY28roykvoBLNC/uMVIVZX8JOUqueCJ8YPVJYNBQZDD
 B293V0oYUgYZDQh1RJKgmIX5oHvHJJuxBA2iYQqggcHgHJn5qzvlfeYesYacTh8r/W9B
 JfvqIo3gWKxtFDl9N2bY3lxqQF325XiTZzVv+aFpgBlvzb7N0/pP8CDDxgMTx+zJNF3A
 BUYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYkAfjmWeXzbfyVlBeyWmbIbju+DCSxv/87N8G0rXzcukMteNkIT+e4ErTwrrZlFPR7KLLGEriMFZxm6/zPABuWZcn5Rk=
X-Gm-Message-State: AOJu0YzANOa9VWQiD0FvJTaTZVxHAIGuKTt0Cw72QR7x+Zu+jP35LHip
 oXYfdtB9wgV0n7FrIFB5phhAiJBA+DMbXEjNOvc42nYYhgTSBMGZy6RzHd+RBEz4WoWJVWRVfPR
 S6QM/NhAMg5fgS3M3E1GuyOoart0BJySWtp1LnQ==
X-Google-Smtp-Source: AGHT+IGFGiIg5DaqkXk+xQecfC5BnXAf+/MOPsvM2aJQtY9kpBTO6Hta6d9qcfsbP6fY6JB8BmxHAYYDIB4ktIxHwoQ=
X-Received: by 2002:a05:6402:40d1:b0:565:949e:1530 with SMTP id
 z17-20020a05640240d100b00565949e1530mr135399edb.7.1708706853260; Fri, 23 Feb
 2024 08:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-13-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-13-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:47:22 +0000
Message-ID: <CAFEAcA9Fc2oHp+vVxRgY0PMGeHcEW187rFFK5-4viQGb3hHgaQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/41] Add memory region for BCM2837 RPiVid ASB
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 19 Feb 2024 at 01:23, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 3 +++
>  include/hw/arm/bcm2838_peripherals.h | 2 ++
>  include/hw/arm/raspi_platform.h      | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


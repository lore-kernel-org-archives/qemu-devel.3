Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723E8C83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 20:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDj8-0003TX-Bo; Sat, 19 Jul 2025 16:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDd8-0005K3-9w
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:58 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDd6-00019C-UJ
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:53:58 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70a57a8ffc3so30229517b3.0
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954836; x=1753559636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9D5qZUnKTyQJ2MvjR7JMt0t9hds06G9wzD4CwT7votE=;
 b=CaNoZFifMwR6Qimicz6HbRxnhtsnnbwFB6d5kFHkkUd8OQYx9QZC9zrnD7NPsXn31m
 KwEY2yqo2dgy/DqTaI2MROgmdeoevieX1jfeA0Go9GVc4brlY6i1ZiLPjWIHPpw0HeuQ
 w+HEiyTVPp+Nw28OZTBTYFXDJfaFoI5EpshsyoytaqRC7+nWWa49pXeCvfQdEca9YALy
 CrjeTpBMkuJez9JxemgD5He6PVu+7WkO+CCKm6EkuiMAS9xQrKoUJBwcliBEeNZpwaLC
 s097FLJvZ4o8d8CyaK3FREluI9gbgRX7jXqdf4BTmisjM02L6Q9XnfeEct2jQe7Mwnlu
 PtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954836; x=1753559636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9D5qZUnKTyQJ2MvjR7JMt0t9hds06G9wzD4CwT7votE=;
 b=niGKOenbB3E2cRSSl3cFT4/bopjUVP+fLD1Zk1wOWNVqoSE/7jxhr1eQeBznhjx8zl
 yKFpH+1b6BRU1YkLrBpl2bwHGCc1TW7QWqnNhRWjDqvr8K9b5dsgH76H0t7apyRa2b38
 1w7yDXRuNVb/DFyanJVYrFVN5iSsnUnS8tu3N9MUKROd1cdSYNoTtNNRXzqCM1AFaZxg
 sYXbv1t+Wyb3vszXcsG47w76gVEbGIkAZM/yqmazx2fAb5Ww2e1NDnBqn5bRhtfJkhC6
 XhPyyi9PmKSQycNirTy/0TtnhSL9I+zN4Hn5Bh0v8bwEK25OAFABh0I5kn3B44VKTjWN
 tI8g==
X-Gm-Message-State: AOJu0Yxre6VHutOnaqphMv2QZzKV797Syeivw/1/Hxuh3udwFMkt9CIW
 JHULKAKMFB2ACawUhpRgzw/QhL+3CKckjnpXWfgvZ3bUBroThEgpVDuG6HOya0tv4C1Mjlc5hpU
 8syn8ll/Fv6Fo8+kI8IEkshrjkF8PVV+Qw1/FbQA8MQ==
X-Gm-Gg: ASbGncuEobKgETfDggpypqCQmCsK8NwgPYvgCeGKAO9lYXwku/hdWKRZDd6/sk5lgdC
 GdxdIVSPy0EOwibWne2w5MeNIEtYVwSg/1eHDbG5mjabpVo4ZHLGwm6SBtCHQPeEhlu8bIaS9qM
 gPouwT3EuSQfsp9rNTbP+WIuHfLhE8cg0q6nBKekDAPID2Y/Q1+TDJkh5ouOr/MpwwacfIpxOqO
 Wm4VqWQ
X-Google-Smtp-Source: AGHT+IFcGIqjH8ESR8bPXIfbEil5pWxblFcQhC8lLLkwAp6im90oy/lAUltl6mU5MZesE9qSLKU83T4hM4WTvt46uMU=
X-Received: by 2002:a05:690c:2601:b0:718:3b9f:f1f0 with SMTP id
 00721157ae682-719522bb7d5mr90590097b3.26.1752954836046; Sat, 19 Jul 2025
 12:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-6-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-6-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:53:43 +0100
X-Gm-Features: Ac12FXy3GJ0Z07B4q5eXlorjDOBIxCZC69xyfl7rvUEUOCI-_j62ULkr0WVhzKY
Message-ID: <CAFEAcA_XHBgGRXOU+SByLEC5DTUuoqLcOiuGs7pSoGk2JSwyuQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] net/passt: Initialize "error" variable in
 net_passt_send() (CID 1612368)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 17 Jul 2025 at 18:51, Laurent Vivier <lvivier@redhat.com> wrote:
>
> This was flagged by Coverity as a memory illegal access.
>
> Initialize the pointer to NULL at declaration.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  net/passt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/passt.c b/net/passt.c
> index 43c336e5968c..32ecffb763b4 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -124,7 +124,7 @@ static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
>  {
>      if (net_stream_data_send(ioc, condition, data) == G_SOURCE_REMOVE) {
>          NetPasstState *s = DO_UPCAST(NetPasstState, data, data);
> -        Error *error;
> +        Error *error = NULL;
>
>          /* we need to restart passt */
>          kill(s->pid, SIGTERM);
> --
> 2.49.0
>
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23A6D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAV6-0000RC-Io; Mon, 01 Dec 2025 15:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAV5-0000KI-9m
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:27:59 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAV0-0002US-Ph
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:27:56 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7866bca6765so39082247b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620864; x=1765225664; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/cXOqcTHWg5xIOq4JHr3BIC8GY2aXAWhAp1dy2M3CQ=;
 b=TxtvJvVqzUlKdSZTM3RjUqotCnd6xlUxoTdM5CnaJJ2DB7HJkmcaxIBsRGONdiq5VF
 rBuqV6uWSJc5CQY/pnRrVi26VSSC0g+Txz097v/6qOnl6vXDouAjz1KA6M1kqsckpPbs
 8edh+bWBb04iIfBEJsOjqE+EtT3hZPUGf4kVuI1fp4yjv09gfugYYjSlcRlBii4ki9Lt
 OaXAvRXPl5Tal3FARN2D7UW0p0NsFuzje8hPjNn9JG9dDn0vMsWNZNw6yARI4ukzO0kq
 Td5UXFa+0DiozfxZawAqnIV79DVfYE6I1VXkV4LlBDq0hn79SjwYmEbviZIVrel8Ob4W
 iz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620864; x=1765225664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/cXOqcTHWg5xIOq4JHr3BIC8GY2aXAWhAp1dy2M3CQ=;
 b=J3I/9R1tdBnGtGgj3GMZW9LoHes7sUTLsPRzLxBWAfUnpmah/JjUM6UFKeP6M0HzZA
 RAoe8vXfoQLGgIt+Sk9dhpvUKJ4EmueC9d/2520B8tS78z1IuXIYLjMm/TNnimO7zCOX
 nMsJL7BF0TPrKBtCQjfLaLas7rIkOAhgAarbokHZBEpH2PkIDcsk5QK5p61Sde9YqUq0
 FN4ckN5nXJWIsl3fshhmvdx/WEdZL4LejMevt+ZDnu14bA3IWAxHffe6B7U3B+MakMtt
 JhSlmDkDv4PKUJlc6GLvyvdfYChdyntK/pVfbnGMs7Xr4Q9jsvD4u2Ms9pnZtiheAcON
 FZow==
X-Gm-Message-State: AOJu0YwmzhmJhTQ2rHTntryjJPELuSr4pbwkzrxz+DpxF21lX3gZkeJ2
 THOQFSwfl+dhCDWFcWw1eaDLlyJzHs6WJ7ZS6qbSGKdFQoTifFY4Xj8T1kCK+uwNY00jqcgF+kd
 fTN4YkkgWKZ3EZtkZRGMCAOFvEJ/klB517mvPKwUpVA==
X-Gm-Gg: ASbGnctXNCAmPRzyh8oc7mxKIQ8V7MiB4Sl1eKZGi2r+D2K2yk9z1rFZv1K2T9EFVWM
 O2PUHG1QmuwZ233iLg+t0ByB0F2rhH5nkK10DOi1fS1db3U2/Nk261Dq93IYZq9BRQ+PpJOeedR
 BPuI5PUj/TY6Ht4R6PVhllwg15QOzvW2CNBG61fEfKFCm8j+lSSXx5z3rhQKVJbC2yubV49V0Zc
 X1ka6NDBT7ph8oKadK3voXPQ+XWU2lEYsA6RzQcH1Xmqus2j/r3TI6swQPaMGZNDjzPuHQ7g7DA
 IkH/m6Y=
X-Google-Smtp-Source: AGHT+IF3Ogq4vB6jXh8SRSKLO2QTQ72EuYsQ02aO77G+YeH0zO/LOaSmUDQmZdPZvZ+E1/iIdm05aUzjRuenoK4p8sQ=
X-Received: by 2002:a05:690c:e3ca:b0:787:c12e:4f32 with SMTP id
 00721157ae682-78a8b54d699mr325039337b3.49.1764620863989; Mon, 01 Dec 2025
 12:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-4-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-4-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:27:31 +0000
X-Gm-Features: AWmQ_blWftAk0Mcxet75fBuDDjkSeB9gETcbi26fSQmR0ulDjoIWRQ66GTzwXsI
Message-ID: <CAFEAcA9k_6udnRBdOS2U2E+dAnMPgO0yawJv1=Qe0A63fvRaSQ@mail.gmail.com>
Subject: Re: [PATCHv3 03/13] hw/arm/fsl-imx8mm: Implemented support for SNVS
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> SNVS contains an RTC which allows Linux to deal correctly with time
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>  docs/system/arm/imx8mm-evk.rst |  1 +
>  hw/arm/fsl-imx8mm.c            | 10 ++++++++++
>  include/hw/arm/fsl-imx8mm.h    |  2 ++
>  3 files changed, 13 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBEBD2C13E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Llp-0002HD-PX; Tue, 05 Nov 2024 10:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Lln-0002Gl-J0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:03 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Lll-00061z-T1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:03 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cec8c4e2f6so4001253a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730821620; x=1731426420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sh7qoYQW0zvLjiM8L2zCtFYW5WaOEkW5SLyx6GEvz44=;
 b=GsyESCUfMtXqqqW+EITL2w+fsuA2jszMari4hn6avFebOt750R2BsF8tuAGfYytrog
 zYiNjAiCWCw1p+FTRrFvDXdT4GfwGrM94L+GsdtxPb4Beov3Pe76o/v4h8rxMFWQwxVE
 cngelR9Wh9hTo6V50MHcOZu0HWpsoSrQt1kA9QWEwaiKjOWJAqpDfWMtxVgK5EKZSxpV
 rxUR/fTMox6dPXpQRFC84ZDrL4uSiDGAtud+tv0Tp3rQVGexKWqaq+LsvVlK+iJavmr6
 VUWIzXzKdsu32LXm1xKfteaLtbqp/NUV2/vL+Xa7B4vIvd7IyXxM4sat+4nVz9TuD0nr
 gN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821620; x=1731426420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sh7qoYQW0zvLjiM8L2zCtFYW5WaOEkW5SLyx6GEvz44=;
 b=srb+ndYtwXb2nmUgt+krjrxEyYClW8EQB5PLmObtFXJHTfoShPmKzZwfD4QSX2ojmO
 X5Wywm2iN73TKgyq7ACN8PVHjGZoRe/gk/KTt0sVMM0iXAdpHecOXP4/bNn4x8cLVq85
 jmR6RhMSAJG6eXiHYva8EGMQZJ8lCJwk+nVm2FohFdzKeYMMt8D+eq2jTcNUxNMly1ww
 4AQ0U6xxDIM4Y8Qyc2aJ+tGpHf/uMqRMxkf1jwCCCu0GWPmxvyiQg0XywUhQCMq/nwnh
 HmrZyDnrL3O6Rcw6YgTSPZ3a82MqfAy/9DLkRq6esk7D6Ufysw6Oxi+fprLrkVdK68V8
 U6xA==
X-Gm-Message-State: AOJu0YylAyHZR2gTYEeJxHnxssvrx3yjLXLkCZR+/WOanPtRLJaPOLSi
 WFpOaNTGFOL8+WDWNIMFqkOk0BvQLgN5sa44LdhOw2J0GZevqAUD6HmYOso3tT2u+u8h82hZY9f
 +zKpVOktJBb4QfuEdQ4r945QpofU0Hxx6iHqn2Q==
X-Google-Smtp-Source: AGHT+IFHoJobG4KxZIfUolkRDMGSDbPWMTNvevnYWQfVrdRqw3KhAs00BZNBJy8ymDkt2MSJkzBFwbv43I3Ey4WgMlg=
X-Received: by 2002:a05:6402:2548:b0:5c7:2209:e937 with SMTP id
 4fb4d7f45d1cf-5ceb92649b2mr12329156a12.12.1730821619912; Tue, 05 Nov 2024
 07:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20241104181306.2329-1-its@irrelevant.dk>
In-Reply-To: <20241104181306.2329-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 15:46:48 +0000
Message-ID: <CAFEAcA9P3JTzjLJE8taeA5UXezRaA0iYEthMbyDoDgD-n94Kqg@mail.gmail.com>
Subject: Re: [PULL 0/3] nvme queue
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 4 Nov 2024 at 18:13, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc490791:
>
>   Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-11-04 16:01:23 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241104
>
> for you to fetch changes up to 8f472a0e7a3c86a890e12e883a69abc65945419e:
>
>   hw/nvme: remove dead code (2024-11-04 19:09:45 +0100)
>
> ----------------------------------------------------------------
> nvme queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


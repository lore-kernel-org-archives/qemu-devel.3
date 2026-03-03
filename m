Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB9CEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNz8-0000Up-AT; Tue, 03 Mar 2026 06:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNyn-0000QR-AI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:32:11 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNyh-0008PU-Cq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:31:53 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64cb577e79cso5560628d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537510; cv=none;
 d=google.com; s=arc-20240605;
 b=XjDwSSyOYDVKRpwHf0J8lYO+Gb1CZSBEzdCVq4Gg5URBlcfmAldBs/CJoD6/z+x2l9
 mhYQNKdEoZ0ct71yB8NlKYoeBJOTmIky5necHbK2KX5xMXci5LtVQbK77UzCyTMcIAmC
 valIbQaCmJvR54+FEiy3nWQEjEzSmDkzfC9ppyuEL4lZslS/x4ZTLUEDVs7sf9EF6V03
 AjPmBHtYFQRmvIlR0N+i0pD/96SoUcQeaJHsyUxGY1j00kB5Xt5IUmS+rpSLNV/8Pa2y
 uCQmZA+Qko8Irx/xhSeS+pXHZ63xGeNpq6IfgfgShx7nMh2SqIlGSmBjEoS2qwzQ0//z
 Z2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JHXfHR3rs04a5cc5C/jMgXKlfnt1eqHrGzpqZ7zi+vs=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=Vd/n3CNGN83r2m3/rY3zKy5i/F5EkeBovKjREPCUc8esPHnsS/7R8ZkQZty/fymUbp
 axUEk+Rn4U191TNksDVI2zxP3Jhsju0N2Yc3BiPzHMLL2tQNiK+ypr4hB/vDVucjw2Cw
 KCIzMQ1YzbPUWcZdAXRhU/qoNX/X6SqjEStn5mFuwE4a1fjerrgDDz/gcCdF4ENrzFAz
 gY9WGHtK+eTSXtGdCp0JJGwqVAnMeRnL7VSjkFSaaQd6JPL3aN/4zxxqqUoBO61uRASf
 xwbFb3WY0Suv18bykfC9WuNtiXy+Xqg1fIVixke1zoOH0aLSJ6UF+CRCQyHog0+xFGhr
 W4Sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537510; x=1773142310; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JHXfHR3rs04a5cc5C/jMgXKlfnt1eqHrGzpqZ7zi+vs=;
 b=iGUJ7xGzuPOP07Rr8LLPRt4a9cBhIvWlZqkOkKTN/8JWU4IlG19pkcZUA24p7MI7sK
 IHOBkUIu9ru2cE/u9XIntrcdkM0TLEjHOv5QXUN1DJ+OXdNFY1Ls9H10DRvF/f8DKx7A
 kikgko0R8KgEtQjVWqfLtiiHlx324ZbW4WjEpCvbuVyHq/fc9+smw4hk5XEHtPyFTXbV
 g84HRFqzo1jOgEtEoc3dVnsggnN7P1hG9higovSpBNbdlLbuxvbF/GgCwCbSKsfGpWl7
 TpPwPln9CXp8CnyeJ4jyOSMLPrE3RRSaNR2CvnEcFPIqExncXVoQ6gP8I/pVUJ93Aftq
 ULHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537510; x=1773142310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHXfHR3rs04a5cc5C/jMgXKlfnt1eqHrGzpqZ7zi+vs=;
 b=dfTqFJEeaq1K7sTH9BZzxGnkHC4CGffuWz9FNHLY+dldgzgRZtzkeGxpDOOkrilv/l
 DPiX545TgnB9YcX8Xn1TX9B2uBDdeukfbS5azhDH4iJFd0l41qOlrKUCzwhy3ds4LzNy
 +zjlk3anTTYpz8hdF3dMnGg/Qvy8BBW6uR0eso0sD+6RRSOwUCGulUlveiZQ4VpZzzh1
 X6PF0CvxsNwdRZsKZ1LQLd6IiPTMqVgQ2lJYprpqyAWCD+pe8h8e/UmMWDwMqkkLLG16
 NT7GBf9qRm63Ea2C1ZgVbpgQycU+Xa8hCtNVZoQJGtzHRzhsmvSz3G8PUHQ2YSmghQk/
 FdSg==
X-Gm-Message-State: AOJu0YxVdgKCOrIoEOaM/Wn8hOPIHepvS/KFOcCVCRzslfwMcn9puGSw
 cDKM3B/hJ+v36TWj3RPkCALK7gdgpJg6PdZtK8zwPgGiedc84v3u7g43U26BhL2Js58piQKbmtq
 as2eh0E+/vJUSP5uihhqb+HvK/h7hUAMkLihGffD+Gg==
X-Gm-Gg: ATEYQzz1H98zmu1MeO5NIEyENnkqD3smeC90RVTDSA7rEl8n8DR5VG5n0YJVba6a2Va
 6g99cYQlxq/LtztrFTGqSK7xcwoZ3h2k6+Sb+YU8XGK8a/RgutbhrCkwIxFD7YCQ0Dn0PHn5rGb
 f4rDp3ie409ZliCTLHZDOWfauDfZpEyeti87BiqrQdCZrsV1ypfOHWjEUTDzhso+2yESN67cFCe
 5GHFK8ua6kfuo5lxohkNshXczPC90XyXRNh9wyfH7KVh6x7ndzN32K2h3+f8CZDzUa99P6pJGCe
 75OFtXHvaGcUDRmRaGojQDF8l/p6BGKmxEHAAnLrlkDL2d/BgNCYVUTHdQd3TvY7/nw=
X-Received: by 2002:a05:690e:4488:b0:649:c308:90b8 with SMTP id
 956f58d0204a3-64cc2025934mr9848749d50.6.1772537509877; Tue, 03 Mar 2026
 03:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-8-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-8-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:31:38 +0000
X-Gm-Features: AaiRm50yQbep8sAM07nVs53xXKAgzKqgwavS-IHNVmMD1nNXzsQYvfYhSoWOjQ4
Message-ID: <CAFEAcA_g=GJ1MGLak7muj2fvGm++Q2qZoqEKtJGqORWkV0c6iw@mail.gmail.com>
Subject: Re: [PATCH 07/12] hw/char/serial: Remove redundant reset
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> There is no need to invoke the reset method in realize since the reset
> framework will do so anyway before the machine starts.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 485b98f03f..0f3469a1e8 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -934,7 +934,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
>                               serial_event, serial_be_change, s, NULL, true);
>      fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
>      fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
> -    serial_reset(s);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

It would be nice to make this not do qemu_register_reset(),
though right now because it's a direct subtype of TYPE_DEVICE
that would imply having all the devices that directly
instantiate TYPE_SERIAL arranging to reset it in their own
reset methods.

thanks
-- PMM


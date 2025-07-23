Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CB1C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYsf-0004hf-Pz; Wed, 23 Jul 2025 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueYre-0004Bs-B6
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:46:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueYra-0008Hv-On
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:46:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so12366601a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753274783; x=1753879583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVgQntOgmn0uN4Wrfbn2/3pazcvSzF4L1ECVrBsy8ts=;
 b=zDmemiuD50/6+6WkuhZOl/BDBGJli+pMH18yEsOlBNSHCavimWhl9khBBy/xRvATqr
 qIqUE8gGzHJFe30DnQ1k0JcHQ9YNUe9STLZFS2DHcHV4KoCtLanqF2ajBxCqDdO79An1
 jwPRcvi4s+KrwqmpyXWBAZc44tMkxRNDmMK5Jl9JcNC5KWsOi+jOZmStUJ6DvhFDAbIE
 o2RgbN/DRE8SaV7LUNyOeEy0K/HWdfcrLNHdGA9eRc9CXV3IWyfqk9uY2a14OwrFg5oK
 jeZHRnVONkeibIAZV8Qngc56sDaVP6hEcLtYtnGyO/zWO6kIw7rIHEHvQSX4mESB4qcm
 D/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274783; x=1753879583;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xVgQntOgmn0uN4Wrfbn2/3pazcvSzF4L1ECVrBsy8ts=;
 b=uWS2lWs8q0rCTaFxlgQec5qtUvrw3mhbrKkIOd/GNaacpIVRSBvscXaboL6dMrg3tv
 oPSudb3vy6k23km6QiEPygTmJTi5XbrCZ14lVSKaDxCva/agbioqVKopnHtHR0rqOUpp
 f/vs9xHxRa7YLCqq/EO5r9u4KvLF5tvqxBcx4aOI0LI5YXWA4APvDljmyGjpX8tbjjXC
 YbDROn+2ZQi3nWJfQ8Ruwiqk0YjzdU+GZdPBw1RMrqm8woSJG3HqJZsH39uiSoBdmtZh
 x7JYiP+KSLmLnaugQCLNCY2yGamekUrESSnMVVJFUqeF4Afu8gPNQVxoHCGNgZjbTIAZ
 FQjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY2xpCsX8phtXSABaeQOsBeqUGbcaRMdAhEUAfZ4WmJaiL6W7znfHt6IJOde6t5FM3JvGaHqM8iz65@nongnu.org
X-Gm-Message-State: AOJu0YxNhVgJN1sNM+rOCXVo1NSuzCSSXl8WL/q5Znt8L2ggpxEEKWUo
 zek15svVne91yq3WirDV0VTs7jOdwZ2Yqb0+gEzJDd4kfJKYcjoLbnbFZACsbiwKSuxYvPC6elE
 sIqjD
X-Gm-Gg: ASbGnctWx5LBKcnA+JhqIoP1UtluLmo2D/+p0hBIGkvzcFC+YGdy+esTBaYHENJs8T3
 YIRoJ4nGtxoQljzMCSu81gljms4ztu9TAKuTzXdePeaaiVXotnP267uiwvaF3smzFka7UOdlFmF
 gHp5+1C0uLdXy7q6tDY1rI4jOfFHjSCs/0JrtE5TYFK2cRxec3cAhhQ87x4w+3pLBHpdkzqYIlE
 y6zmbxJkAIo2FiCM1HlUGWxIBnKYgiMeGnIlVza83uhvt+McaXXL4V4XSfeFuLVKwhR1n5gQMiV
 tf9HRamBSxz7NojZL9s7IapriTQyM8b3M/L/hZ2mJLp0PhUmXRO3yI/4ThbolwYS6Aat48sXl+L
 pyTV36PsarkY2kR0fZda9u3U=
X-Google-Smtp-Source: AGHT+IEGn+8CVJu9kLZTLUJm+fQxuPUBHQ2r/VwSGJZTE3uJyi27J9gFOblh6eYkRDvSwKWfZsCECA==
X-Received: by 2002:a17:906:794b:b0:ae6:abe9:4daa with SMTP id
 a640c23a62f3a-af2f717a556mr328898866b.27.1753274782605; 
 Wed, 23 Jul 2025 05:46:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6cad69basm1053078466b.145.2025.07.23.05.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 05:46:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D597C5F782;
 Wed, 23 Jul 2025 13:46:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org, Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
In-Reply-To: <20250722090547.109117-1-ben.dooks@codethink.co.uk> (Ben Dooks's
 message of "Tue, 22 Jul 2025 10:05:47 +0100")
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 23 Jul 2025 13:46:20 +0100
Message-ID: <87seinulb7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Ben Dooks <ben.dooks@codethink.co.uk> writes:

(Add maintainers to CC)

You should get your patch workflow to use scripts/get_maintainer.pl so
they get CC'd and reduces the chance of it being missed in the fire-hose
of qemu-devel.

> If we get "ssi_sd: error: Unexpected response to cmd" then having
> the bad s->arglen would be useful debug and does not add any complexity
> to the code.

Generally we should be removing the old-style DPRINTF debug and
replacing them with tracepoints where they are warranted. The main
problem with the old style DPRINTF's is the format strings tend to
bitrot because they are not enabled by default.

>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  hw/sd/ssi-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 6c90a86ab4..f1441d2c97 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -183,7 +183,7 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, u=
int32_t val)
>                  s->response[0] =3D 1;
>                  memcpy(&s->response[1], longresp, 4);
>              } else if (s->arglen !=3D 4) {
> -                BADF("Unexpected response to cmd %d\n", s->cmd);
> +                BADF("Unexpected response to cmd %d, arglen=3D%d\n", s->=
cmd, s->arglen);

That said BADF is defined in both cases (although the exit(1) for the
debug leg is a bit aggressive). Is this an error of the guest
miss-programming the device with invalid data?

There could be an argument for using:

  qemu_log_mask(LOG_GUEST_ERROR, "Unexpected response to cmd %d, arglen=3D%=
d\n", s->cmd, s->arglen);

instead.

Phillipe WDYT?

>                  /* Illegal command is about as near as we can get.  */
>                  s->arglen =3D 1;
>                  s->response[0] =3D 4;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


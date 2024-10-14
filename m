Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA01D1625B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KZV-00046g-9o; Mon, 14 Oct 2024 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0KZQ-000460-Bb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:53:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0KZO-0005Vz-Kg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:53:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso3795444a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728910384; x=1729515184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WVXDycQUZRrNMXnJ7zKhQ1aD88B9Ro1MR8lFeX8DosE=;
 b=j33zmXhHb8xyKdFUVTEMaBg+GJ7RbDgshEVdCaQYmGqvlO1Qvk+zm+L4JvdNVxHZxZ
 cwZXFsfiKQuOoXV/pi2AKOXg6vMUle9IqHPwA/D32Eq5DAklLjf4mYIpGAcS/9Ri7GdZ
 /96JK9ZHmXTVDSC6YcO5jZ+X3cG/2Nwqc8YE6YgHFqPEoVKYDs+AvyfRSk8ux1RVuVP3
 qealj3IqVOZ9CSbqVpYlGP11FKHHSufMK2r1PUSHNip6uLyyMOSEmAC37OsOu9pXST8J
 uhSHO3rvN8l/lvihK7BeW40EQZv0gkNCrWFHffE4woX3jWBxQELwY+T5/DKjiDbZ0+YP
 eAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728910384; x=1729515184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVXDycQUZRrNMXnJ7zKhQ1aD88B9Ro1MR8lFeX8DosE=;
 b=SMHzFoBEHQSgOmDk+hRxLQwd/Ak0GM6bCw9Mc7Gm7OyQFAV8MK4RixDcJd8MxKiE27
 NqO3JxsrWs4pdSYAIzfh/rsCRP2vXTpCJkCkRqjO/TUMbMV4H36sx1TvWeMAstv+PT5U
 REa+OB8Tb2k3CA2ODtGXtv59nlNEJpLMnAfgKU/+H4ze96G8jcQd26whUYxRnsYIMWhX
 ruZmNwEhdvhAaX/gQ3+Yewsu97GwY905J4fa5AMX3LZ1jDtXup6jnr8TxdbeBvYK/9Nz
 PEYbM+lAJSM/7IqUSvON8bzCzDWmQZyZAjv8anvzNh9Nvedf+uOAJugol8U0O1r9c7Rf
 dCdQ==
X-Gm-Message-State: AOJu0YyegwB3RW6AivmvCr49GHfvwEDOJzniCPuyvSL3hP/v8KXJxXEY
 6UNzGxxqmfMxxL85hoeD3uShPP0x10dfBru8KE/SR7FTiKhh8eDMQPPmYAFZno9aZjfNMs3Zjox
 W3Wcs6Oe9uPXc5zadWI5Hq2kMILf4V5rnuCiB1A==
X-Google-Smtp-Source: AGHT+IEUMKqRtCQG8QCstmPeMmtE7+LMyU7PmyTI0+XJvy+lrbOy32k6+r2+cAFNkyMrByjz9hOa6xQAoBIJpG+R3jc=
X-Received: by 2002:a05:6402:13c3:b0:5c9:2a8c:8961 with SMTP id
 4fb4d7f45d1cf-5c948d48286mr9182269a12.22.1728910384267; Mon, 14 Oct 2024
 05:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-5-shentey@gmail.com>
In-Reply-To: <20241005205748.29203-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 13:52:53 +0100
Message-ID: <CAFEAcA-qhDAje+Jv3gR=B-vZ2cJ7FaB+nf9Jh_t00n_7OL3nVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/net/lan9118_phy: Add missing 100 mbps full duplex
 advertisement
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 5 Oct 2024 at 21:58, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The real device advertises this mode and the device model already advertises
> 100 mbps half duplex and 10 mbps full+half duplex. So advertise this mode to
> make the model more realistic.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/net/lan9118_phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
> index 1c2f30c81a..4815a4da35 100644
> --- a/hw/net/lan9118_phy.c
> +++ b/hw/net/lan9118_phy.c
> @@ -145,8 +145,8 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint32_t val)
>          break;
>      case MII_ANAR:
>          s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
> -                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
> -                               MII_ANAR_SELECT))
> +                               MII_ANAR_PAUSE | MII_ANAR_TXFD | MII_ANAR_10FD |
> +                               MII_ANAR_10 | MII_ANAR_SELECT))
>                       | MII_ANAR_TX;
>          break;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


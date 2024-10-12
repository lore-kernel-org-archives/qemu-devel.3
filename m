Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC2CF2568
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 14:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szcmf-0004cP-AL; Sat, 12 Oct 2024 10:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcme-0004cB-8F; Sat, 12 Oct 2024 10:07:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1szcmc-0007CV-Fg; Sat, 12 Oct 2024 10:07:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so1254986f8f.2; 
 Sat, 12 Oct 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728742067; x=1729346867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgIkR0DOZrDSIrMwIkDRUb0TbppctC9X9/nRHWqBGvo=;
 b=ngG8crGoMWphN93hwsaaBRu8wY5tcLJYmUHk6s4rb/Ou6r60d5MNvLOt49MM13GAsd
 3+px3Pt+BxL5Wli1Fs1icNPkYBs89gxzUoKq4WuaLnQyDi37iKbJbsiOVHwuMQzvBuCj
 HNsBWMMBoDkNkv7sCNGysaf6QBJ7jYCZVzWUaFdNaBszGpCdqa4+YRF/6Z7fPhsbJiCg
 0Bmp7ANIt6WZS+kPHBn3Xsvj/7/qpcsj9rr6UEWY6RtcajXXbd3yW89+YAvHYv7PXKct
 5SdVxqryRp3dEvJL5fxY5xit6JosNFsmd93BLNPIyHWeyLnNQ/dDpQ2+I8LOv3VWx5du
 2wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728742067; x=1729346867;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgIkR0DOZrDSIrMwIkDRUb0TbppctC9X9/nRHWqBGvo=;
 b=A/3P3+v7mjJ0Ak9yCkA2iCJrLqqcLK3DjJTiGHOGI7ZHeP3h5e3JaXSQeZzH7fnwN4
 TTyd0wPAuot/S4PRYmZi9UmcF6FIhqz4kt06X29Cq14WW4iXbNSm86Mk+l5YCIP0VxVL
 YiuzMJLHMOS2Jt1yF9zPN1rOajIXM7TFftpcflWgoDyZ4i5FI1DdEuKwfKgFfOLJXLDb
 EwBSUHu3FWrcAt9nd9u3eBDTvy9X8/fgk1Lx+LyEe9fI6M5XDy5hWXmvP/pFP5ADJXSj
 LhCksaHYhvHOnMA5jbH/OGX3w6u2G3SbwIDXkTh6egLQ0qSrEWJg4oQ5rc6vBuhzevKi
 KbpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI73yA/0H1pV8XcHLtni/Xcfzp+jnMsnchKjo7YQvNDxl5n5YKF1kDzhD2AyRQzEDU2/eDx6hqDw==@nongnu.org
X-Gm-Message-State: AOJu0YxB6jlVo/um6IgFui64qFJ4ulRXVrju8ARtCRO9oq4wxR282SSs
 OyUuYeFELvrGhLTdKXbMMlSxZ3nEZItL6uz5egRTzYb23GAVsMwldqI2GQ==
X-Google-Smtp-Source: AGHT+IFFfrYvI7OrD5EuQuHg5C0gUy5e4bpe6rzVfhXtAvCQYuVceYJVV4vrY+iDzKRiy2/EqYp98g==
X-Received: by 2002:adf:f2cc:0:b0:37d:4517:acbb with SMTP id
 ffacd0b85a97d-37d551d5265mr4285817f8f.17.1728742067052; 
 Sat, 12 Oct 2024 07:07:47 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-117-250.77.11.pool.telefonica.de.
 [77.11.117.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm100761985e9.24.2024.10.12.07.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 07:07:46 -0700 (PDT)
Date: Sat, 12 Oct 2024 14:07:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] Consolidate lan9118 phy implementations
In-Reply-To: <20241005205748.29203-1-shentey@gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
Message-ID: <D9A7DF9D-A506-431D-82D7-23136A94EDDE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 5=2E Oktober 2024 20:57:44 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>hw/net/imx_fec and hw/net/lan9118 implement the same Ethernet PHY with si=
milar
>
>but not quite the same code=2E This series consolidates the implementatio=
ns into
>
>one to fix code duplication=2E It then continues to make the code more re=
adable by
>
>reusing some existing constants=2E
>
>
>
>Having a dedicated module for the PHY allows it to be reused in even furt=
her
>
>device models=2E
>

Ping

>
>
>Bernhard Beschow (4):
>
>  hw/net/lan9118: Extract lan9118_phy
>
>  hw/net/lan9118_phy: Reuse in imx_fec and consolidate implementations
>
>  hw/net/lan9118_phy: Reuse MII constants
>
>  hw/net/lan9118_phy: Add missing 100 mbps full duplex advertisement
>
>
>
> include/hw/net/imx_fec=2Eh     |   7 +-
>
> include/hw/net/lan9118_phy=2Eh |  31 +++++++
>
> include/hw/net/mii=2Eh         |   6 ++
>
> hw/net/imx_fec=2Ec             | 141 +++--------------------------
>
> hw/net/lan9118=2Ec             | 133 +++++----------------------
>
> hw/net/lan9118_phy=2Ec         | 168 +++++++++++++++++++++++++++++++++++=

>
> hw/net/Kconfig               |   5 ++
>
> hw/net/meson=2Ebuild           |   1 +
>
> hw/net/trace-events          |  10 ++-
>
> 9 files changed, 254 insertions(+), 248 deletions(-)
>
> create mode 100644 include/hw/net/lan9118_phy=2Eh
>
> create mode 100644 hw/net/lan9118_phy=2Ec
>
>
>
>-- >
>2=2E46=2E2
>
>
>


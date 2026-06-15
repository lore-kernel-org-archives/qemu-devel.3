Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC32CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6H5-0003QB-LS; Mon, 15 Jun 2026 08:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ6H4-0003Pt-Ll
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:18:42 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ6H3-0003rr-0f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:18:42 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660e9ea26b9so3319035d50.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781525919; cv=none;
 d=google.com; s=arc-20240605;
 b=DnRK+ZWauv16PiIhZoh2iOV90AiDPAZ+ox9yJ1F/TKBZoO04qefH1kjT4G5B1lKtsC
 3kNWrelnr5/Bez7EhFkFI5BsfdRFCvT/yCF4br6mzre/hPRALW/iY08uC/Z83lbwQIcf
 hzidk5poYjDqV1FXaSTkrIR13F1gwlx76ZG0sxktA3bhLy49+lGj+kFlQvQ/wPSjdQet
 zKsl1O0srV9zHqB4FdRML5ba/o/ok56RiM7XPXDHyeSv58N+EMbtocqXPw9AOVPf2MAF
 Y6mjumd7Gx0k2ULri8ypxZxODbqIQDb15GqZ2pjPBiLM6TQXEIo/K2S151E16zX2ceu+
 2vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7SzBF98pEmxkKVc3fcTH2J/ZOuXUs4Wufa6y76QZkwk=;
 fh=waM909xNckwKm7pPQFH3nLBAWEC+k9YWzSA1XeTt6rM=;
 b=X/QoAmBcF6JONq1jQ0roL16HVBkke++5qRcl19CPxLPlGenx1EJBcYukNqCBUg1een
 D9BiwxNUlNd5w8FssgNF4ic+ihYp+fctUWq0YXqYkuBLU+7pw0tGJcWJ9maQWr0x+1Gi
 pPKVlotvPR1V5gV4v78oo8c0UWZTmU7YQ+2FJ8usx8h1yA4qZn8s5fOROiYKNSTkyTv7
 hoWdpdEUj9o9S7h5X4aLv0NHaMjHbAMgBGt9gSwaNnHmIWinmqevfR+L6auWBb7dsykA
 k+qTiwYMUgyI3inLZNw+7Sn2SLaXV3N6g9O+hUbBZHfqVmp+oF2NomdyoM3tJieQz2Cr
 z5bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781525919; x=1782130719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SzBF98pEmxkKVc3fcTH2J/ZOuXUs4Wufa6y76QZkwk=;
 b=IUPI1AvzQSJ8HZWugVMdtud4PkpxRng2feWgl6xW6EIqYBl6e91jJkHNCO9yP6jjor
 sFL4/kQAPlYfFH/+o775pppGEY114rtPjlST9l5J9ALYkHDUsMVeMM9MEiq6dDcaGxTS
 Q/nr5t9KaQ9h6QL3WIBkPt049e9XmLZG2UZWk1NgMJ41eGDUN+vhkfZLgtOZ/uqTt/F6
 d4sX7jG/OBbFeX6ccL8KiZ9SR5QcKdoOQo6bteFHDIq/Urj2PT07FV5iOc33yb/hfBkV
 x455vKPKsppOvxUDc9thl+4FiVWBYrF2IwdsOaEl5g5EGjkHZi9w5B397+UJtOb+WTFq
 aAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525919; x=1782130719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7SzBF98pEmxkKVc3fcTH2J/ZOuXUs4Wufa6y76QZkwk=;
 b=KZDSY2lscULEhZ42L61V1xuWwxN+JOBSb75GnoMBnYhfDfLcABoPlquqSXu7IcIg8g
 PW0SqN6yQANyyfAKIp9NekKhkuHei+aXu6RH9TAjkf1EVv9RBaXNw0QM5tldtNbTH9Av
 gTVIUU+Z+150B3pZT6Z2A5VPGRlZXlF+sWR53sB4M+cbjgMLCCbXhpxe7vwNzw14clRM
 nLv9HTM89/NRD9U3fIQMx6/mHgjL29SQZvm427gVN5frIG6sp353TTv8V3ClDY1m73fZ
 klY7VMVhsilYuaeXb7yfgfEdc7HT5tF8QwQxO91HTeNwp3aGgv4ah7AA/yxXlxW7AJI+
 4+rA==
X-Gm-Message-State: AOJu0YzFZB/yvYUh32njAerFwD2hqYSsRVrT+YwzHxvQiLxlRX93DPuP
 tIJcQG1STIhXfk8Mt0R3DxvxrimIQGhzYeNE+HaOC6d4Rb1kxYU0QvPK9ZAGI2iEz1nNOwfYEdZ
 atgsQHnwPRX7sf0mpUkhN7cpFuX3gDQKU7WodFuVMKg==
X-Gm-Gg: Acq92OFouJzF8B7VMAMPrUifawMkPe1oFwCTxTXxjQBpO1SdETRbgpZBY/JrgnMfy4y
 1t+e9hSxr9GtMGRjhK2JI9PbLI0HahTiTUBIoTL1hazjqwpdK5p3iCm4S9KeS8+SEZRwiShfZjn
 bdKiJ025bTYF7HB2j0GhbuWgQCPE34K8SYX8vdiKIxbYDw/ZV8FbSkkOL3rxZ5sknyFaxSe4JJe
 LtGR+3qspxyHboUBQpb6aYZ1ckmieFH7zakqwznRKUmigIHkxcajqS41o90mydUiZZkVTJ46SRx
 q4lWppNT69fZCDGUpkZ8Iaiyt9VXijsF9mdJqwNNFu4VtNQcq11zPVfgqp9L1h/XWjQ=
X-Received: by 2002:a05:690e:b4e:b0:660:8e61:1a5f with SMTP id
 956f58d0204a3-66284e3748dmr9011653d50.16.1781525919306; Mon, 15 Jun 2026
 05:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781111270.git.matyas.bobek@gmail.com>
In-Reply-To: <cover.1781111270.git.matyas.bobek@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 13:18:28 +0100
X-Gm-Features: AVVi8CcSB1jIm5O4ojDUihCBSn1i3fRmVvzDDlqpEunZgx0Ryu_YRgGyAcDr8sg
Message-ID: <CAFEAcA9aX4nhhGW-CxABO80rja9OG2LdwXyJs37=1eyFwPg_ug@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hw/arm/sabrelite: Add FlexCAN support
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>, 
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, Andrey Volkov <andrey@volkov.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 15 Jun 2026 at 13:15, Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.co=
m> wrote:
>
> This series adds emulation of the FlexCAN CAN controller, version 2,
> found in NXP i.MX6 series SoCs. The controller is integrated into
> fsl-imx6 and the Sabrelite ARM board.
>
> The chip has two FlexCAN controllers, but the Linux Sabrelite
> device tree enables only one by default. Linux kernel with both
> controllers enabled has been tested to work properly (using a custom
> device tree).
> See docs/system/devices/can.rst for an example of QEMU command line
> invocation.
>
> More information about the implementation can be found in my bachelor
> thesis [1].
>
> Changes from v4:
> - renamed can in fsl-imx6 to flexcan
> - corrected attribution for definitions borrowed from the Linux kernel
> - rebased onto latest master
> - Link to v4: https://lore.kernel.org/qemu-devel/cover.1779986496.git.mat=
yas.bobek@gmail.com/

Have you fixed the clang sanitizer array-overrun bug that
I reported against v4?

https://lore.kernel.org/qemu-devel/CAFEAcA-diz0Bh1Ah87MPXxkDcvxF58tACTcxxJw=
68xtw8pTfLw@mail.gmail.com/

thanks
-- PMM


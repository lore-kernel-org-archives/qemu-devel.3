Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041CC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 17:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUVkT-00021z-9D; Mon, 29 Jan 2024 12:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUVkK-000216-2x
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:48:38 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUVkH-0001MJ-4Q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 12:48:35 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5102a2e4b7bso4453856e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706550509; x=1707155309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0KEpqOUsYiFWCBV1l2GNOAf6LCouu3EVBhy0hKzAuw=;
 b=ZXbwLDjmvCe1U0a/BXdCHbQftYY/8IPdq7UvSMknQGHL58QrpC3iIqkez0CkIJmMQy
 mvhbBmRZDIxpQg5DXxpPdATZbfAn6Ax0rekZmiiRqdSkPDIVvG0Id8M35YB2nwTceakF
 76jwtMrf8rry7XBUovtHFn+Z8KNjl3nDfsnnvutOPkna7Yt2Xp+QWPz8XZRkuV4iAwvx
 CD9qRi4BgbT2gSYz/7BsOm5lbJMbpzMDQwUqJOJoRT/ptXOewRQR3vb1TspkTOGvzdRv
 VK+fNOv93gT6O4tujwyQEJ/nSzl3RbicPO2y7wtFj3bPJxcG9sUGOHjToqaUhaLEWFDs
 08FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550509; x=1707155309;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0KEpqOUsYiFWCBV1l2GNOAf6LCouu3EVBhy0hKzAuw=;
 b=eHyO6plZU6gHa8G1R8CxUqfXbPFS7Rr6WflhGBLedreSKW3OVtuxfaDIzUqRnwiRay
 EPih9rf0fUFWmIu4pY8xy7VSVTEw3cTvlu+Tkdgwjf3QChtbBu3wANcykbWXD8oKgtjB
 9gp0pgCZaoE0ioidYudvEYmtlQlEu4cS5cbH13mkV1seEcb09xZ4Pjg2vqsWq8Xv4Wa5
 5jeAM8Rm5mABYAHb11FkdLGiYRHllpS93nWmvaoIpGd3SMsw4iNhaqRFqvDI6ymFCbhU
 OHgPDlDZYoTxEitL8OZzRq5CTJhRrmP0Amz1CpzrzJd4LZ+YxoCxWnM8vKeu7NRs/8Tp
 fCcw==
X-Gm-Message-State: AOJu0Yzy0cUzTmhriwY8d7+aKj6rME6mky0IWaymOe3cUqMBMQMaztO0
 yMO+hI08rhLMa7sesB8xpzF8t/8x64qTaaGj3gVlvWoV3CIroHPpvyj01gYV
X-Google-Smtp-Source: AGHT+IEKk5y7+mbCO/9RDratkprzlEdjwIYd3e4kbZu41N5QtQ+mUXq8JuZ8Ejd/I9FyDuj921BXqg==
X-Received: by 2002:a05:6512:3f8:b0:50e:76d1:b9c5 with SMTP id
 n24-20020a05651203f800b0050e76d1b9c5mr3619885lfq.60.1706550509407; 
 Mon, 29 Jan 2024 09:48:29 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-068-073.89.12.pool.telefonica.de.
 [89.12.68.73]) by smtp.gmail.com with ESMTPSA id
 s19-20020a05600c45d300b0040d5a9d6b68sm14705672wmo.6.2024.01.29.09.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 09:48:29 -0800 (PST)
Date: Mon, 29 Jan 2024 17:48:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: philmd@linaro.org
Subject: Re: [PATCH 0/4] mips: do not list individual devices from configs/
In-Reply-To: <20240129133751.1106716-1-pbonzini@redhat.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
Message-ID: <03B07185-06C2-49E9-8E70-D2499D2238A7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 29=2E Januar 2024 13:37:44 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Back when Kconfig was introduced, the individual dependencies for MIPS
>boards were never added to hw/mips/Kconfig=2E  Do it now=2E

There is also: https://patchew=2Eorg/QEMU/20230109204124=2E102592-1-shente=
y@gmail=2Ecom/

Best regards,
Bernhard

>
>To simplify the task, include a couple cleanups to the SuperIO chip
>configuration symbols, as well as a change that makes USB device
>creation available even when building without default devices=2E
>
>Tested by comparing old and new kconfigs; and also by building each of
>the boards one by one, with default devices disabled, and checking that
>the board can be started=2E
>
>Paolo
>
>Paolo Bonzini (4):
>  isa: clean up Kconfig selections for ISA_SUPERIO
>  isa: extract FDC37M81X to a separate file
>  usb: inline device creation functions
>  mips: do not list individual devices from configs/
>
> configs/devices/mips-softmmu/common=2Emak      | 28 +++------------
> configs/devices/mips64el-softmmu/default=2Emak |  3 --
> include/hw/usb=2Eh                             | 26 ++++++++++++--
> hw/isa/fdc37m81x-superio=2Ec                   | 37 ++++++++++++++++++++
> hw/isa/isa-superio=2Ec                         | 19 ----------
> hw/mips/loongson3_virt=2Ec                     |  5 +--
> hw/usb/bus=2Ec                                 | 23 ------------
> hw/display/Kconfig                           |  2 +-
> hw/isa/Kconfig                               | 18 +++++-----
> hw/isa/meson=2Ebuild                           |  1 +
> hw/mips/Kconfig                              | 25 ++++++++++---
> 11 files changed, 99 insertions(+), 88 deletions(-)
> create mode 100644 hw/isa/fdc37m81x-superio=2Ec
>


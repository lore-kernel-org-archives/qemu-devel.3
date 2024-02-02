Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396F5C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtwE-0001m8-Pu; Fri, 02 Feb 2024 08:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtwD-0001lm-9C
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:50:37 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtwB-0004gx-Ke
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:50:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso2708729a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706881834; x=1707486634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAa6DHlW9fMifpfgFla4dpxHkFu9hAjc2PIyHtjRQ5o=;
 b=H3M4qQV6FDaFtQESTecpZkuKJoGyqWVA+aO2UCQlBJqbJ4ElrY1/j2HWqonFgk6I0+
 Dgh/8c6GFq2JbRd7ekgZ7pJZAE4cRwdY2/elL/tugVYaVDilN2tV0r+jF0UeWUvPiW0T
 89ZeKlJ2tA0/HSYjxfauoHo12BSbVemE65SSfmxIwj062iCbLc3LScoLZLGzfSoBS51n
 OZnNCO4Axvxpnkc6hd+3OI5krwtQesSDQEt+Brh3tkrsybvvUjEpdIfDmQi9sCyLoG8b
 QP91tEWZf+qvOwlgaBNPgkp5XgFv/QulYDJ7K7pqecagH58VHC6++30/q4k+t2d6yb21
 HapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706881834; x=1707486634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAa6DHlW9fMifpfgFla4dpxHkFu9hAjc2PIyHtjRQ5o=;
 b=E5IAxqOoXlS+nwgYonD1ku+ttT+iCF+1ZaEKZYi23Rdc/4Q36vDo5sVr2w4/lei6p7
 7/ziXQmj4A2um1bjEftoit63a9Ewt6MeAa13xNe7FC5Yu1BORnZc29M3xZy5Y8uvfWmU
 n986e082wic/E08xxhm7+QFHTcl3qlfzQZxmue3pXNDbbIyCsV8T+pp+ok/uQ4FC2Y5v
 0Y+mUs848Yp0zoUyPKO13Q/HnKjbYOVhQhs5bFT47yx5NF9NyOul+MiyOLJZBok+teaj
 UaIgcD8KfPcvLyhhElI5ZKfLBSTI7loi/IhhYXknopBVjmBWb4X00WPRWdgQULzLKsPc
 fYKw==
X-Gm-Message-State: AOJu0YzX7ex5C+xU7+MxXKwvQwTlpG/rbgtPdYeyfCvBQ16JGJ8qDUF9
 adrcArJzZ1DlKF/AfJQWcOlqtwz7CtMZdftuJOUvNhV7jpoGbeW3tGcn7tgu1ufce6zIr582zux
 DpmOOAHnyO5+PdNXOEXl0I0wNdxBZ4igs8qJF1A==
X-Google-Smtp-Source: AGHT+IF33fj71fIcd0eRQqFaeEZ4hrCKZYcwaP2dJMn3eON6H1eyInV8/v7GGBxHK2XJeBOH8cxuziVQ/71Rus2dcRI=
X-Received: by 2002:a05:6402:3d7:b0:55f:fe85:ed4a with SMTP id
 t23-20020a05640203d700b0055ffe85ed4amr877231edw.34.1706881834314; Fri, 02 Feb
 2024 05:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20240201141253.806055-1-clg@kaod.org>
In-Reply-To: <20240201141253.806055-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 13:50:23 +0000
Message-ID: <CAFEAcA-pkSRWRLvmxGL=v1H-UV-VemGkXJEXAMBASfkfnJ7A8g@mail.gmail.com>
Subject: Re: [PULL v2 00/17] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 1 Feb 2024 at 14:13, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The following changes since commit bd2e12310b18b51aefbf834e6d54989fd17597=
6f:
>
>   Merge tag 'qga-pull-2024-01-30' of https://github.com/kostyanf14/qemu i=
nto staging (2024-01-30 15:53:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20240201
>
> for you to fetch changes up to 649b8ed20543f1b7f7e3dd8fd409092639bb345e:
>
>   hw/fsi: Update MAINTAINER list (2024-02-01 08:33:18 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Update of buildroot images to 2023.11 (6.6.3 kernel)
> * Check of the valid CPU type supported by aspeed machines
> * Simplified models for the IBM's FSI bus and the Aspeed
>   controller bridge
>
> Changes since v1:
>
> - Endianness fix
> - Renamed test file to match other filenames
> - Fixed file list in MAINTAINER
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


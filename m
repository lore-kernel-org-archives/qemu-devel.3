Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EE8C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdDHU-0007iJ-Fj; Thu, 22 Feb 2024 12:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdDHS-0007hb-Hi
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:54:46 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdDHR-0007z8-22
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:54:46 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512d19e2cb8so73496e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708624483; x=1709229283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=URr/vp1iUOexEEjosHVLdNV2K5nUv92WfGvhsd57vXM=;
 b=CnFU1cZW4LlzJhFNsZNTEdZtgzcg9dPN3VJI02ZE6ftH1ypMyA6n1jr73ouuuq29ER
 zebPJgpFSnidrpG56LeQlTbmuC6YgK1n69LMcEw2h169STJ3scpaKfMBTCulzZv1YjRY
 mwq3cv9ZtOIZTHZB4KNk81WMrJNjk5lY0Nb82UeSQFCHQXcudZnwcS4XEl3KYPouzaM8
 sXVIyR+JXAwwrBmYfZZNifYK7mWYSS3Y3WyKW1KYhjapfk324AcFk1AEX5x7D45p6dDJ
 SBNDSsvP9jpZz/veD9k5XNXQ0a2yTNwTAQYn8JmOlBOqV0632ypFUPPf0V6rZ0zeViu5
 087Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708624483; x=1709229283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=URr/vp1iUOexEEjosHVLdNV2K5nUv92WfGvhsd57vXM=;
 b=H525HoxeUkXz9XaqyUcHo0DzAetuTReOrcGlJgy27m9jOK6ogGrVECGhV8gGUENqfY
 Z8M7msHoSgMkmyaFU/n6VJpbX0Ao/04RtWuLHwyw9VbzGLoTcIpZvRUO1fLxihwWmXJO
 +NfqSVD4u0GXKfc2qSxaKa82mFrXzszfbxyIaE0drLORHH+ZM8Eu9LggGU500sCuF3qq
 n8k9v4Gz9/Mx90r05sFWMOe1w6Da7l7MdEa4gELvoTf9tz7ZYF5a31Rud24tyls/RRWB
 +UDf+ZHEBX7aldX1qF6xE9IL7QmBZd5gF3NvFjXfTJOoajE4gWX+JNH8XxMfHKy5bHtC
 xdWg==
X-Gm-Message-State: AOJu0YydACgWbJu2OG8C6vdgseY9s7WFYiPCC3SROUAmlrskfc6CY1Kv
 Gl7J+HjbdGf0igsXuvT6UjmHM8V4AuaIezQ/fi2DpKHNfn/kIsfbAtEDQNYabqhxDh3Gv4BHfRO
 M9/V4y0u12Y7RIo8LrKTLe1WvOlXRhCyya7WMag==
X-Google-Smtp-Source: AGHT+IGRdH/CyiNg5bMbiXOyTw1JhQKm3q2JmULIqqfHKWj2QYS17zMK+sH7VygA39/SwYa0UzBKi8t59yFXbX79r0Y=
X-Received: by 2002:ac2:4a85:0:b0:512:9325:d8fa with SMTP id
 l5-20020ac24a85000000b005129325d8famr11284393lfp.21.1708624483002; Thu, 22
 Feb 2024 09:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:54:32 +0000
Message-ID: <CAFEAcA-eQSsXmmLzD=_+1z-YDrj5yg-MdMPLTwzFjRcm1q8ebA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] OSPI updates
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Tue, 20 Feb 2024 at 09:17, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> Add a new 2Gib octal flash mt35xu02gbba. Add an interface for versal
> virt board to swap the default flash.
>
> Changes for V2:
>   Added type checks for provided flash part name.
>
> Sai Pavan Boddu (2):
>   block: m25p80: Add support of mt35xu02gbba
>   arm: xlnx-versal-virt: Add machine property ospi-flash
>
>  hw/block/m25p80_sfdp.h    |  1 +
>  hw/arm/xlnx-versal-virt.c | 44 ++++++++++++++++++++++++++++++++++++++-
>  hw/block/m25p80.c         |  3 +++
>  hw/block/m25p80_sfdp.c    | 36 ++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 1 deletion(-)

Applied to target-arm.next, thanks.

-- PMM


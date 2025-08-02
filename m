Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A992C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIsL-00057G-IZ; Sat, 02 Aug 2025 16:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIpK-0000uO-Cw
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:27:47 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIpI-00040t-Ol
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:27:33 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71b4b36d0bdso18959317b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166451; x=1754771251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zA3ekZB1wj385G3r8IysCTDxY9GVEK5/PRskUZLE9iY=;
 b=fxNWMgXu46lMIYrgYHk+GSJzP7/WTzYGABp3IlgocMFWn6knGyX7sdwnEwDxGyRQ8z
 Y/n1DI6btcCFsQfM198WGczvSdhR676ZN5h1dFq7JKlnUKWqtpdbKJ9AF/8rr7TTEz7C
 nZOchcEkYrEtJ4KEdjDGFFpE53F+zBEGnUC8RqxyzocxcsFiI/JjJJrpTkylk+CzX+Zb
 a59we0UrJkmRa3gzzdXalX4D/OFARbxldiwKLSrGmQHJmZ5vmOIaU0OxVZw4JsUPgMTO
 bCpcFMn3kvl1Z4+TvHtGA/1BXl5y1epMnb3ISjEL22JQBEtYaT+xQRiZUovAbTmAw2U/
 ACpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166451; x=1754771251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zA3ekZB1wj385G3r8IysCTDxY9GVEK5/PRskUZLE9iY=;
 b=iIJR/8MRAyHErefG0GWkUMYL6j2Rq4WmydyyZ08dlLbVDkjX8dp7zEfxS0LYH4KnsF
 6rWIe9QUXBsmoUtQ73FczlB2s05PQovFev6QZA7vFceUxWQEqhctdwOmnlfDMaw/E2Rf
 AGqyXcVAGFZbubdA8ZrY3/SUa2T1lFIndgqjVok6l7G9n2VyNCRDjJ6AWGamyPjuec3V
 a0pR0C7qzbrPXMwKUbRzRXVQfAshmTWi5YdQ7oRaNfuRf+Mj/+9F0UWK/1bo/ceG/Xxk
 1kXBA2dXymG3UMMkiv80VNK6diIFiUMRP9fqN/LvuuWsJWKROwfvpGi6fcWv6oEy2kHD
 hkkg==
X-Gm-Message-State: AOJu0Ywkv5gcqtruxXjtFVlRoRIkeiVrQ43qqfBi5ALPuELqXS4Bd2w/
 uVqPhcTB9sJyjmPbIB+SHPU0XBtHj+dF2fDfhq8XmiVILiBWk9SQIyJDBMl1RbCjwCWxeVf2Wph
 LkARoTCvh7lNm9YMzaSdaC5HhiG9WyFJviP2maWbttg==
X-Gm-Gg: ASbGncuTGhdxtzcvIZFbWA1+FTi4iwVwA/vMQw5qbgS/qaXQg4ofF8QQtXuxiY1MqCc
 g+uzgjmAXB7dzzFhnahltLMJOeli5RwKO7Vvy2gSbAfyTx+Ut6QCKbLF/61ky1kMrNbZBrI/DsY
 u54JsTiPwWiMSPwRK+JbgF1cyJVKB+pG+xIvxSlFKoNSoFyqYsbAl8l3IRURM11cupUQzq6jSSE
 MT08d9c
X-Google-Smtp-Source: AGHT+IFtTWRPf0YxfBrahBExrmpfvBAh0ng3+WyOivbWUiQMvkEiaf6d+RxDaCA8x5Q7LIpu6sYyFBjlUPU1SRAUC0U=
X-Received: by 2002:a05:690c:d8a:b0:71a:a9c:30dd with SMTP id
 00721157ae682-71b7ed28c46mr73694047b3.2.1754166450921; Sat, 02 Aug 2025
 13:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-69-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:27:19 +0100
X-Gm-Features: Ac12FXyB-JAoCUh6KdaN-f34t9w9b7-6iCodXtIal0qtDSZD2nv1z70PV1cmcbo
Message-ID: <CAFEAcA9DKACV_pnngbAATm7fuBj7RTghc7HB+z-DjpSRtB2p7Q@mail.gmail.com>
Subject: Re: [PATCH 68/89] linux-user: Move elf parameters to {mips,
 mips64}/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 30 Jul 2025 at 01:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mips/target_elf.h   |  5 +++++
>  linux-user/mips64/target_elf.h | 12 ++++++++++++
>  linux-user/elfload.c           | 20 --------------------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


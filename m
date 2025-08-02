Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D2C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ8t-0005ST-Ui; Sat, 02 Aug 2025 16:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ6m-0003LO-OE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:45:49 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ6l-0006nL-4i
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:45:36 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8e14cf9e2aso2764292276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167533; x=1754772333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Paal+RWsK68F19aefmtytC3YJ6l++abOPX1eoQrwhFk=;
 b=sh/eRQyR9XhdZV55XSlp8WFF7JwbyO3H9JQC7yFvYgA3kcqY0MA+iDEl+M9NaIsekq
 z+UhcLQlQlbNLy5XDI+zs341I2mUJOxUqGmbr8MMEXfNk0zvpffWizO/yayMNC2vkJH2
 Sv2KHKC2a6xiOODwDqvxyCd5CZh+PgAPHuo0ER5ywgCw/BMYjX5VtZylITX3umkQwgzc
 7R2gc8zKms+mMobfHRXl7ENp+3UwFC9kxRwGxM2guRHTXqmTwkQmwZrFHJMSTQtFHYQ9
 JLnohqr9dgV0YkTdw5Wq704SrW5hU5ePBZMemPS7COP6AoO1AU59zFzIu2bzT/6cLrs9
 S2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167533; x=1754772333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Paal+RWsK68F19aefmtytC3YJ6l++abOPX1eoQrwhFk=;
 b=I+k+rumzVt6Y8GIsbpteBlsnIsRVRqETPOUrS6QNraDdD7+nzn+OxL+5Z+WkSsch7l
 +z6pp11CRBCII4rNsQaSGPw0RueA9LOVxxptKc81YTxmKVzwi5dTiqIHDI5k5Sw1214X
 DhqPxKv0+N9oD+V7pixil0SNw9UWOdORFBYl4g5E1zrygBbN8+x7kv2bP/GV5ZEkuSJU
 Si6jaN+we1sBDLMRgRHTAD+xZ9Bv/HjgelKgXArscr8C4BwUtDP4PAKeCUqPIAiuOzU/
 9VTbUDjxe0YNs8aReslsArqC3P9TjC9FRgY9GZ6DtWHI4mf5q/BTmNN0x/N8oIUWtrQs
 3plA==
X-Gm-Message-State: AOJu0Yzzo0T20qzXoc9luQTWPWCYl2RrZ40iC69rJnMKAJMpHAHHBBSG
 Xkv77mvsQJpH3Pj7vj39Ik7MIuD05wOgWTmFRyYv5AgPeyaXcRk9iCR51vV+x6Bp1N6eIuYBD2F
 wNdvxC7ZeKtVJ4bsvAZsrR1ACPcnT/pqejzZsQFlOqQ==
X-Gm-Gg: ASbGncsI442tsSlk0k2X9PKkfgf7kN2T9h2t7RpsP4XjRm1d87AMydePvJJ7gyatA/z
 3DwJ3uEZHPzv8t28EoDBbLZTQj1OL64V0xVfQ7FXDyq+2Q0IjLWjNjHrh0bFoUpy9nEw5gpgjBs
 qm5g1CfQ/Q9N4OMO/GihJmulg2cI3BiVEG3zrnB/XDMkGYSq9mwTqG+kMwnIAYvFzhGHcvVB8zb
 m7Z1XF8
X-Google-Smtp-Source: AGHT+IFB6DCMBAvlBumRqrODz19FjVC/fsJODT7X3KPrXppx2V38Fou4tA5qTi857TyirQbnGyt4P7l6TbTOfutAP3I=
X-Received: by 2002:a05:690c:3109:b0:719:f41b:81f8 with SMTP id
 00721157ae682-71b7f84891dmr33434247b3.19.1754167533588; Sat, 02 Aug 2025
 13:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-90-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-90-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:45:22 +0100
X-Gm-Features: Ac12FXwDs1f56Jy1mMX3lqG9XbtD3zd2O9Z6ba_grmY2H7HsmRGWjfHOzpFx2VI
Message-ID: <CAFEAcA-pwk1n0pw=bj8CsqRb_8qv4E5poA=TwpE6SRCYgRe2VA@mail.gmail.com>
Subject: Re: [PATCH 89/89] linux-user: Remove struct target_pt_regs from
 target_syscall.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Wed, 30 Jul 2025 at 01:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This structure is unused, and would only ever be used for the
> ptrace syscall, which we will never implement for linux-user.

It's not 100% impossible -- IIRC valgrind does it -- but yeah,
if we haven't implemented ptrace in all these years we're likely
never going to do so.


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C18C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxVZ-00076F-BY; Wed, 20 Mar 2024 11:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxVW-000759-8x
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxVU-0006ai-Dn
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:33 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56890b533aaso7826517a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710947130; x=1711551930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eotH6+RELIXOjdjy/MmEvAOcz+5fQKpxBSxzQgsUj2Y=;
 b=A7l4vYWryE9+pt0QvAu3veIVvJPPwxEkjMw4J2YcFqzBb8oEgWE3OS+vWD/352pNux
 GQOtJ/c3J1wvfEt3eI/iD+fV1GK1aDDrhYuSuh8Vs4RBM4TUnE5IVw60VvgljxnVOehf
 +8cM+0QLSLBXJFexK4uBPlI6k4hDPkbjPE6OHr5Ih3XKX2onzydPvgGkMUt9sAT0gVHQ
 p6FgdljR3rNO/euDRRxGkpmnWIlcy0O9zv0EkSir1jaKI4quF0ANwF2HYzL0rQiYjr83
 50WyQ6yFs/XoYxUNnjQDugTlcX0OhwqERTGniSWs34cgKAR6cJnsXLzcJKB58nI1XdVn
 re6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710947130; x=1711551930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eotH6+RELIXOjdjy/MmEvAOcz+5fQKpxBSxzQgsUj2Y=;
 b=HGUjMqs0iTSZbmN7ORejs2Y7TNub1+byJHIQksHrxQ2mWoSWvs0wXw6g2kgXFAofAn
 WQt8NzQXnXE2ht0F0Xs2++o4g3I5YAn8NJhW0WfuxIlJNFsA+A3S20nwRV2cN6aMbpd+
 loFAea+yoP6DtJGQpMShbBIFaUFTaZ99Wt6t8vGjprHS+LIXNvanxM24lCmKgzVHiVMa
 8TqXx3RT9XJTCQNud35DAAXSoaAAkX2ti+M75PsByV1703Chucib60JVbCpwv2MeomyI
 oJe72OgiukAMgAtMR0DIsXhDrUUBryAbrccNMi6ISxhzcIaaqpUualERtcGbWsoanfta
 rGDg==
X-Gm-Message-State: AOJu0Yx4VHz5Yl8pqLPWcK5Kv9MzuBwKfxVU89GVxu0Nj8y3217rAe3q
 dC/c7rQ7IWXHRrihQ4XxhyGG59x2QA3VpDOWomuCPxRpVJh98ajsUS8wx7nIXnQvyPNSAlI8Yvi
 Qm4GHbgP5+kWV55IeB9fzyNobg6XcERIb//3lwg==
X-Google-Smtp-Source: AGHT+IFga3DqWVZifOLy4uEd6Haac8vJssSD2a39K9TQF/bm3YTtFVtVqQ2NaQ71ygmbNqlRaurtMHqqbdKoBvl/NOo=
X-Received: by 2002:a05:6402:1cc4:b0:566:348:fc4a with SMTP id
 ds4-20020a0564021cc400b005660348fc4amr4230617edb.32.1710947129992; Wed, 20
 Mar 2024 08:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240320024010.1659193-1-gaosong@loongson.cn>
In-Reply-To: <20240320024010.1659193-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 15:05:19 +0000
Message-ID: <CAFEAcA_2dZPVJ_j1qxG=YpCR_6xwNohh=BSG3p6L9wpo+kp1+Q@mail.gmail.com>
Subject: Re: [PULL 0/3] loongarch fixes for 9.0
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 20 Mar 2024 at 02:40, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:
>
>   Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240320
>
> for you to fetch changes up to 77642f92c0b71a105aba2a4d03bc62328eae703b:
>
>   target/loongarch: Fix qemu-loongarch64 hang when executing 'll.d $t0, $t0, 0' (2024-03-20 10:20:08 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240320


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


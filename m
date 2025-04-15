Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D39C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 18:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lIk-0005an-36; Tue, 15 Apr 2025 14:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4lIb-0005aH-TG
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:46:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4lIX-0002Iv-I6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:46:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso10943328a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744742776; x=1745347576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvmk5p8vBgoOpLDZoarJqbTicElefr6kQ2wo9+Jy26w=;
 b=bbTZy7OrIQ1W+8MUAwqJeakIOnU3nw0Q7zm0G384/0jS8ot3nFbUNbJT1VqYekEqxK
 2iPVlG8VJH2lM/mP18MopPYDSoC3SpVbxb46dWpc+L0MEt8ren5gyLVZZc84V2gcFPWP
 lSl7E/A4/DreyE23o5VpbrEaXYgPUPp8uf3v0y4wIDpaVBQZBZNj962Te6RJczpSzEvO
 4DQnuElh9fVW9/RQP/448Mi40L18a+HGGty2tbEuRYZXl8ydXLFYI59Mk2sWL3QgfRhn
 1vbCdwtfwG9/0oR7yU4nG7Z28EAXZ4IAjJlr08rpLBlmb4/zHzWEn+nJdtfNbOG/ZwFv
 XT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744742776; x=1745347576;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xvmk5p8vBgoOpLDZoarJqbTicElefr6kQ2wo9+Jy26w=;
 b=TtJ0hOSg782AYinbnhvvRtjhbrvuUWjc3hB3I3ixJjDWM1TSYv7P0tEMj1MDmQSEsF
 brlYkgwo3RpLNJn468Tnr7AB3UFGCqDyseD8syycZqbDZEtteWAAPjfFhycHQ0X3PwD+
 j1LVVcXrPBkhCBtaqyUI8zR16lVh+ep6k8fXIfhNJ8yxK0/mbkOsocng+O3bPQL5Hd9i
 coP1qScGMIh/kvn2oXF/yvbHs6uAmpAfnGXsuTAN/USOb4SgdpkcSDHJ+mckwP19r739
 TlVLtGZ+bkwnTngzgjtoc/X7sIWgfSY/araZImnqxrFjvTrdSVZh1BOl0hXW2LARw4dK
 K7ZQ==
X-Gm-Message-State: AOJu0YwZIOQv9Nby/BW7x68vZmWbz+bFEjN2ZBibp1cZ4D7WmrqJp8Un
 qXuzmqfZPbJ46WYzw4bpsf3qS6JqopwXXJrYLNshwxLbX2ii0CpWO6dvZ9KNQQA=
X-Gm-Gg: ASbGncscVZqjcEzuyTkfMW5KDGHGX79wOI6+CMJtauCHdlZCHwjUs/LEkfW9JWnOYfF
 UHVvcMw72QcIVsRSBKo3LMr48qYrG75EfP5OBFinRukjjZg+VTvR4ZV3Row5ZCJRyC85KMxjSjr
 y8kdvWOpFop2j2eYWZE4z5CxtyngH6LJQT4AEQsLIQEvIXhWzxQltxl1pK5ouGUjawboX2tWAlo
 xuQMvPB6Haxb28IjOa23RJsx8fP9BJ6JWfrWElL18j0sn5GawgzcBzaIHe/wUvWFWeI6VOXnDdG
 Zv3YSDZqslbyowvNWaIXvZAC8KIye7VkbMvWCihRev+dezyU8GBquQ==
X-Google-Smtp-Source: AGHT+IHkHcMMA86OT6hGORHrda18ioULEo8x9RCrrRZODWXkh6KNjppVdK2vn136Caa4q0J82Y5xbA==
X-Received: by 2002:a17:906:6a1a:b0:acb:34a4:b15c with SMTP id
 a640c23a62f3a-acb3831e7a0mr12399966b.32.1744742775751; 
 Tue, 15 Apr 2025 11:46:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1cb42casm1124821666b.88.2025.04.15.11.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 11:46:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5467C5F915;
 Tue, 15 Apr 2025 19:46:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Michael S. Tsirkin <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
In-Reply-To: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 10 Apr 2025 15:26:35 +0300")
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 15 Apr 2025 19:46:14 +0100
Message-ID: <87v7r5clft.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> A hang was observed when running a small kernel that exercised VIRTIO=20
> GPU under TCG. This is an edge-case and won't happen under typical=20
> conditions.

Should I (or MST?) pull these into a tree for 10.0 or should they be
grabbed for when the tree opens with a Cc qemu-stable?

>
> When unmapping a blob object, its MemoryRegion's freeing is deferred to=20
> the RCU thread. The hang's cause was determined to be a busy main loop=20
> not allowing for the RCU thread to run because the kernel did not setup=20
> any timers or had any interrupts on the way. While fixing the RCU thread=
=20
> to run even if the guest CPU spins is a solution, it's easier to fix the=
=20
> reason why the MemoryRegion isn't freed from the main loop instead.
>
> While at it, also restructure the 3 stage cleanup to immediately respond=
=20
> to the guest if the MR happened to have had no other reference.
>
> PS: The hang can be reproduced by running this unikernel with TCG=20
>
> https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0ebe=
9395827e24aa5711186d499bf5de87cf63/virtio-test-suite
>
> v1 to v2:
>   - Add patch by Alex to prevent double-free when FlatView is destroyed=20
>     from RCU thread.
>
> Alex Benn=C3=A9e (1):
>   hw/display: re-arrange memory region tracking
>
> Manos Pitsidianakis (2):
>   virtio-gpu: fix hang under TCG when unmapping blob
>   virtio-gpu: refactor async blob unmapping
>
>  include/exec/memory.h         |  1 +
>  hw/display/virtio-gpu-virgl.c | 60 ++++++++++++++++++++---------------
>  2 files changed, 35 insertions(+), 26 deletions(-)
>
>
> base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


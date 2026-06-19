Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26179CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZNQ-0000oo-Dn; Fri, 19 Jun 2026 09:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waZNO-0000o8-6Z
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:35:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waZNM-0004vy-Lx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:35:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so18085535e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781876113; x=1782480913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRccQtMM4wDRft7V1ayAUzMdUAZaqB2JxRVUulG5evI=;
 b=gXZevICURrrlV5tsjjWW6ZXuvx5hDu0cBdnpwlrFeQvNbtvNgtye/myRwp9w8zrFmA
 9erBS98/hUgyek222M1cfKwgHuBS5H9wNUpePqogku5uj8ZRfyCkJw+B1V/JwbS4CbUE
 txNryfxNcpixrxd+WR8o3syoqNFDCJKK2ulV3OiUFEi6QaObB+1Dg2npUR/iyxIrm1zt
 9iqPXZgqj5ucGQT51PjN5r9sZfCOAL8a4Gvp7GRysGsy5lsXkh/OixHVcEfMFX0jxW9d
 43Ucnl+41i52vYpJJW86vkp5m26Gr7MDlMuKmPJObAOsdIxKFOpht/yPMroKtKF9YICK
 i3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876113; x=1782480913;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRccQtMM4wDRft7V1ayAUzMdUAZaqB2JxRVUulG5evI=;
 b=ZziaOn6Loz6kbFpKbRxBwsV6iCJxuc5H7ImNOeyzxN1MdzaS3cX2uWjfR+VabYgfL+
 hECXDrHXVru2p+6fA0pKG9RpDkrte7Av8MiL7uJPzsefFVrxMKpSl8FGgg+6yAv86yIj
 xEULCYjKZSVImxZNZwX0W3K4ggPSeUlUxnRZCKT3n3WxjyTUluKNFVnxE8B9XvEOfzlr
 RvZiyjXZf01F93RLQGcQ2Y3oXXPPrFknHCV+aEF1CIkrZMmZebfWJUB4BUDkA1ZLJ6r7
 HTRKstAIMHpOg4doDvnLgPijq2y1YFXo2xq8Hg7sYSJ8891vpTJjzsCmvYK+FCajJb9o
 gWGA==
X-Gm-Message-State: AOJu0YwWi/54ZdzI3zdGcSAojOjKKqZLr4f0Elm+Umq5lMWw5RNrfi/H
 7VaWWk11x7Gs/8ZWwLBb10YIFZ8SlKiubwBoe+FMLNwUw2d0ePOCxMaEtqXhDxuGyIM=
X-Gm-Gg: AfdE7cms/dTarmih8Z2sIhdU/wtqC0+I1hvuo4RTr2rN0wsb+9I2bsctb7LzqLIwR7h
 qXSmjA+ZK3B4G3obLvMEx5QOcRTWg9YOGFI4ykKVo3Z9sbsuUBYI6zeci4vx4+jnjfy2W/m3SHC
 yFiTmYD0rmfla64QfgrhLXUs9qB2k7XAgGqlmKkuIA+hedxkBLn04GCmkpouy8RLbNpKMzqPK/f
 YUVrJ4XpFEBj0sG45xOU4Q3gjSlZrA13JAF36qP3ZKdpcV6FIXj0jFGAFJDy8JxYtKPB6tO9Dja
 9iSBWCbE4F5zXjtoy+B7YNb+1+9HJS1EpanW3fA8tllACD6inq8xWqYQ6h7a0T1uoDQv8DXYFGP
 yKXyQJCCU1SlLU9Nw2NAgux/pHU5U6JyA8rbAM3E4oaHV4qVMDQc0N2aItXqdGNYCW9RrR2vm6k
 uw0EnGDbDw9W9b
X-Received: by 2002:a05:600c:4713:b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-49246678e86mr10379435e9.8.1781876113462; 
 Fri, 19 Jun 2026 06:35:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm70094885e9.7.2026.06.19.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:35:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCFEA5F7FA;
 Fri, 19 Jun 2026 14:35:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Thomas Huth <th.huth+qemu@posteo.eu>
Subject: Re: [PATCH 0/4] testing: some minor QoL changes for functional tests
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Sun, 14 Jun 2026 11:08:58 +0100")
References: <20260614100902.885698-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Fri, 19 Jun 2026 14:35:11 +0100
Message-ID: <87a4sqfyb4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> I spend a lot of time trying to recreate functional test failures on
> the command line where I can add gdbstub or run under rr. Invariably
> this involves running the test with "env QEMU_TEST_KEEP_SCRATCH=3D1" and
> then extracting the command line and tweaking it.
>
> I finally got annoyed enough to look at the command line code and see
> if I could do this a better way. Ideally I could just do something
> like:
>
>   ./pyvenv/bin/meson test --suite thorough func-arm-aspeed_anacapa --cmdl=
ine
>
> but for now I'll stick with copy and pasting a line from the logs and
> saving a few seconds removing all the QMP and console sockets.
>
> I've also included the pylint change which is now reviewed and can be
> picked up. If not I'll grab it next time I do a testing/next sweep.
>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


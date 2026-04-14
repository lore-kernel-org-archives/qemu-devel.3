Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262BF9D0D0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCe6x-0001XX-Tq; Tue, 14 Apr 2026 09:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCe6w-0001X6-7Y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:47:26 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCe6u-0008U7-Jd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:47:25 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so4247381d50.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174443; cv=none;
 d=google.com; s=arc-20240605;
 b=VyDcXKWpOhfGbJMC3JRn5JcuyEj6rhSiV6JfaAUrKlyAnAkJ5r+UZe7qSfgBuh3t0a
 sYkneeighQIukqJTRhsKuvZc88YwHI7dLClNToURizZWrBRA6LoFu1MjVG9XQV1EiJjv
 95y+cq7aAcVCN6Wen7/FxkKIGabfxnUHxaUx8GMo9p5NwVrVUqmi9NjOzQjiB4JonI4m
 tJWg9EaEowDiZxPuetvULiZBNdOyqAB8ctA1K6x7/tsLafZFt6ZX+RRrn/kwNRaZPXE7
 kUM6BwlmolebMZVLXGNk/lbaDFkcOeUgWpygcjUrCLzmkTz0ZOdtXnMs0pFWeQnySTfr
 jsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kx6hXMCK7i29sxgp9fDiDv1RFf91cX4uP4hQP6MR2Cw=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=X4K576ngjTa/pYRW5/2iclHZfLS23pEph0FOY6dDgXUJJMXnvb1YePQdOONTPSgobv
 jaqPB+qoUwdTFl5qcVpEJcZWmo1Fx+1JoaFt7cQyIp9OM0ErMtuKVpM+X6LswulSCd6K
 YFEILpXGw4c2/NRMdj7oQQy6LSqeTiKb08Bj4l8ngK5rSHZClFV3tcyBJzB/jJyFp+fM
 QuE2N0uVmFquQzjdSHW8z/E2gb5KntsX4v+e8DgwIrxERxR4cjWKnBHm+Qf3jM0SpkhW
 WpUqAN1hvkD/riUkUKyTeIDLCsuMx0G3qyjU2onM5D/ZgMOelbthOg7NI1dOoVBqMtw+
 ULAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776174443; x=1776779243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kx6hXMCK7i29sxgp9fDiDv1RFf91cX4uP4hQP6MR2Cw=;
 b=Es+25lrv34kJF1D05AKy73ql1Pa8qbEJV0nTSdJ9CiY7PEh9cfCnLzISda6epxlWow
 kkWYknmdQnLOGZywoIe4hqYqt05f4mGtV6D4cSLD2TIXqzGQWZOVam94HgDY4acKaNak
 2xcVL7omowjfESy9xzqo96ZNYf2YwC82T6fc6nl8/2ctHBfjHoxyN15CWJcPgnyknT+g
 KHmkbP41BKn5zX9Yz4RRh2R5MZUgiFbNMScvaV4U/GXtjyQm6TNy8y9J5+Osq9lI1xKf
 HzgNUWuQ6o8lAEfy4aHfJmG0m5VpCGtr/hRYgCt3cKEOYfGbeHzNb4+aGCZUyAgnzuS3
 0nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174443; x=1776779243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kx6hXMCK7i29sxgp9fDiDv1RFf91cX4uP4hQP6MR2Cw=;
 b=JCkogLh7L4uuwybQyIqYJMaq9EXAL+SHGMeKHJagNWg59DrqKIHp+0vBGjnBbjq0Me
 nAMCPSu8z81dDyVlLMkfEEmJisfAawdGzBvf6/Ot3Y7oyX6yMOMEUBGPLh3bcZ+pBpJj
 zGaxo5FVp5JWiQ6vl/9n0VZFbdXLtt5HJYv/seIXPDylM9kr6EWVVczqTQ7Jw04d2Bvq
 Vn7MymXJmWO759PVO6xwulNYQSNZQfAB3ZcoFpB0yxXd+V3yK6u2Q+o5y/AeNMzNvkHU
 cCM1qHIh9TqhUHhWmG6XJa2UcrcwxZjBSE9LhGDvQ+0ULAWxdcTXwcN0pmn9CuMW8Pz5
 q6Aw==
X-Gm-Message-State: AOJu0YyIKrWN9yajiG7iQeHEF2gvQdYifPTo62NYyQweP9Q1CYYQg4fL
 iIckJpxq4nhigqDngIlPgdBeSH4PiC2Y0Q0EfBiryWYI6d9euoKEG6xmNguwNTHBzxTcautCfg8
 +QSnhG//DQD5hOcz1Mq1QF8XwfheIFOM/adY6tSij/g==
X-Gm-Gg: AeBDievXO0L2cF4JJoQ3kKGhjyEF1K9r+2OeDyqvXp3PZ4hiAeqnT10t+G0Bs1v1rHu
 0+xbi8yvQBH9cezos8QOTO+EEXRS2+mtLgfDEzVQYV0NFhzNqwFNV+raLjxZjZjwu53z4q9f83v
 RWlrsJEYL/8u1yQUGnPO8FVMHW8CqNqwaHsbLYZJsVBvSMBbNlTkRAMQ9UdhNlS3uglot7YKM79
 Ul4xMBxDzICE5Pia5P3UUxJ4rlidq6SrvaUgHkjKWnUJhrmgbtLoIlq/cQ4lajJwN/EWTCtJC8w
 vc1fDvTVbVubgOfFuC3ICFrFbFo+ANd7sOQf/Nf5Ik6QgtEZzQ8+jN0mlsN90t7J5ow=
X-Received: by 2002:a05:690e:4011:b0:651:c782:6a8 with SMTP id
 956f58d0204a3-651c7820a22mr8329145d50.15.1776174442638; Tue, 14 Apr 2026
 06:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260414132100.53861-1-philmd@linaro.org>
In-Reply-To: <20260414132100.53861-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 14:47:11 +0100
X-Gm-Features: AQROBzCKDUIwTh8NXk3cE2_VBir0NjJDsIGNgzwuQmi5t_OLZIDDNRJmdBTCPL0
Message-ID: <CAFEAcA9-oUv7sycLCCtL-Css-2mi+5T-UBs4aKQB-KF6P-zUpg@mail.gmail.com>
Subject: Re: [PULL 0/3] Misc HW patches for 2026-04-14
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 14 Apr 2026 at 14:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit becd22fdc2a071783d9e04421526633772b3b9=
8c:
>
>   Update version for v11.0.0-rc3 release (2026-04-09 21:18:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260414
>
> for you to fetch changes up to 31ebdb207f99bf7d72abbbb82fced15d161a548f:
>
>   ati-vga: fix unsigned integer overflow in cursor bounds checks (2026-04=
-14 11:35:13 +0200)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> Few more VGA & PPC fixes.
> ----------------------------------------------------------------
>
> Junjie Cao (1):
>   ati-vga: fix unsigned integer overflow in cursor bounds checks
>
> Mohamed Mediouni (1):
>   hw: q35: fix VGA text console with SMM disabled
>
> Vivien LEGER (1):
>   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
>     node

Are these all regressions from 10.2 ? For rc4 I would prefer to
limit it to only important regressions and maybe very obviously
safe fixes.

thanks
-- PMM


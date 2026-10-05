Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7723CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkG4-0007cj-So; Mon, 05 Oct 2026 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkFm-0007LE-QD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:05:25 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkFl-0005is-9z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:05:22 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8abc87cbd93so13158687b3.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212720; cv=none;
 d=google.com; s=arc-20260327;
 b=T2YJOTYgug8fLuTheKq7amXI5TmkgK64j2PNQAdCNrA7SocC1aSPq+NqQMGBzax+lW
 aelncIc0Gxor2bLVgKG5MgiAN2j6jccqMWj4QfCB+mxciU7mPFPusW87KHDBta2EH9F6
 EvVqXTUcidJd/rO1iRgP6Txj/IDn7fwaG9epnU31cawHFhnCsrJeZOXfYKFMZHMzVqn9
 B8DjymSZ8a7HtoadehXC63XrN+va67VK6KccFsYztlzCXq8MOhUJ/bq5KwPZ/3386T9G
 P3UCCPOQ3/JqT3cv6byYao2yrzzg6A2kY2hqXTOVHU4SbW1AWZvWbjhUU1/TPE2uElyv
 c6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4KcoWNhRKkBGA3tAv9e6pyRHghGbdQKqmQsVa9lTQvk=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=ogGW/EO++WG/+97AocULq0SkAJ+B+neP6Hrss6wa+3FPvF5/PX9sZY6GbYlqlUJgks
 MpmaqHyCDBdZruPrHBRI/y/HUkyh/eflYXAYwi2bugSX9bleSBfkDgu0RI6DymfeJeX7
 7di8BjVZidhAJColWRTbFD+gMrPcBT+D+JJ+dAYQxwxHx59cBUgkZyRHcnlm1Rn2lEP5
 e441kWqq3COXBmcLAketFWEx0jx6fWDtJRY3ONk3zmPV/kr3Rxg1u1g6/By+P4EkTj7F
 3cvNmvWzYM0ZMGpxKcCqISuub2m+dezniRPAoYXfLzGD6ocwDk57wxzDaMtGjq3UDtys
 hC/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212720; x=1791817520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4KcoWNhRKkBGA3tAv9e6pyRHghGbdQKqmQsVa9lTQvk=;
 b=rt5htrV+aW6H72YNSBDwq504zXLZYo8Oa6Q5hroT7c8WGVguXG531UCtYLnhqwArW3
 FvXf1ngvNdEGTxPSELI7oma++7QLwTBi8t6HKIPgc7WEa5vyDn2BeRLzuWnLBDnSYRyE
 dCxKc7WpIfAOfl7XdbDpnTo6Tj/MTeyVgA5WUSNTo05PuY1/hgSR618PrBLq+cGaiIhX
 DNgvNWTgHF7ayWp7+q1uP8vTnFOEbU1WRkA7eJ1R0cwPwCdU73tKMrnjDPmVlvmHCziS
 3tMcazP4M+MGaoCQu727+UxzhrfFGlt0wEYAjo9zYwdJA6qaQkPiXTn6w3+l3060khga
 PYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212720; x=1791817520;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4KcoWNhRKkBGA3tAv9e6pyRHghGbdQKqmQsVa9lTQvk=;
 b=FZGlRc5L6txlmRNrWq1u6r+oQW3axBzXT3mQA7DUX9X9q3ai4elo53mJfWj1kHcs93
 ly3a3of7LSAojDrZv50EEajYBeuqXZ5WC2DI6i3zQXt5hlF1GzKhCIi135OG0KGp3isL
 3p7eXva5pJ2VcoeEU6V6MvWFLlsCWB2iX/N7ZLcVLytyE2MrXp6dNLtN9AbsXrdjHtZN
 KiRFj6FnsuCcviyNcWKLMXF0poVqrg/EN3xBQixh+lMYCGHU0hP1y4/LT1RHIrGa51TX
 jrN8cQC9c3eNgVDk2WCjylyRpIGkUGcEbKaDUKY/Ytcqt2OpBHSXO+BFYgSxAlBPBLe4
 iccw==
X-Gm-Message-State: AFq9FYK7NmjWzR7y9gU9BFfrMM35Ul8Y8OkRxPgnqQfV6mBxu/RnOusu
 PZ96a7ZKoTbdqGsCzYkbu5I8xRiKccCSRz6c2uQhk78zDdcHPmw1nCw6QHduwgmoDo6qi7wxnx/
 /Rgrz6bOExtKTcbPQGRmibXpVUtBy3vQ=
X-Gm-Gg: AYBFou3r2zLGy2cvklzUyu7Y03ycsnlHKbrkxN9m+RU1CJSICn19lKfzStWCvDV0oWu
 65Yidbi2IzTKWV4XP4aHuheEEM3EKTEH2eHCW0LTLLxi3a+2AtxysHbR/XMjUN/h8RB4V5nu/mh
 umHtpbLOI5E8x6JbQdDUNCOtZbtd7JiZwZsGS7RpTdAXzYqlE8oC4sQbjZqzgwmuFzOUNtQYJor
 P2M6cvpYow/EmqLWLOX7uSucyeDQb8AiV/buuLLgZkH7JXGNxYQoi7onmS/iWFPJwlX2UkQ/3xw
 oHoq0ydSwPPbFsiaQlvnp8laMQGIee0Vfx5JGtPj9TDjYQCcHPlU8+oGZGeUN8n90GA9pOOq7D6
 QjO+D82LUD6eCmMu1l9Iw1uz5eA==
X-Received: by 2002:a05:690c:e3ef:b0:8a9:97ba:26b9 with SMTP id
 00721157ae682-8ae39bfdf0amr49927697b3.41.1791212719962; Mon, 05 Oct 2026
 08:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-12-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-12-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:05:06 +0800
X-Gm-Features: AclHuK9bi0TYBNlCb_SKzXAJdc1S974UXVFyUjiee_wD455NwAjxXMeB-7ZPE9c
Message-ID: <CAEUhbmWSkX0Hj_X9+o8SY0+PB-ZXU7sD7P6rXHBtrGucugN59w@mail.gmail.com>
Subject: Re: [PATCH v3 11/31] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Oct 5, 2026 at 6:24=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> The test currently exercises the Linux kernel and waits for the first
> daemons to be started. At this point, basic hardware is initialized and
> if the log message is reached, no driver ended up in an endless loop,
> thus the system should be usable.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS                                |  1 +
>  tests/functional/arm/meson.build           |  2 +
>  tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


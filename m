Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B9FC4450D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjf24-00063f-Pg; Tue, 14 Jul 2026 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjf22-000635-Ju
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:26:50 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjf20-0005lR-W2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:26:50 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-80bb41f7f3cso11613827b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784042807; cv=none;
 d=google.com; s=arc-20260327;
 b=TrkjtL2yVqlFNxfzTJ7qt2ZPDEbpwOVGEYDPpW3qXlt8sr0BN1+X/UGUzfVvc+PrBI
 kOFsDybun5q3PGXxEONFRs1I1/TEJ/2WOd5aK5vkWytLckW572zcdxKfBZzir6+4QEQ8
 f2rmZS6sebXPwBKdUuoLkik0N/nG0Ell+8JZsFj3SWsDGrt1XbDoFqF0Pp/6kJ7XgxQ5
 wB48tu1S+AIR31y6cxyUQMQNZw4yfT8Wgnm2cb/Yahe+L3QGmtamcXg5+K/O57z5jpCW
 Pbgxfjfxzfn+X+fnGQqcKP40R8YfzVYQ6BF4BJYvHSrFLCkvA5lI7xlKtfEewUnKQmyG
 GBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z1kAMXC9Fsrzsu3wy6G45NcKTFRzU/dYRQXjW306SC4=;
 fh=PgvuDsSrN5tO339qb9tpnPzNGxQ+CWeig4WyWwbLr+Y=;
 b=maRdRjI6VScIZC+plnURx3zcmG13q50MnoR2e8VAe6qjWH7PU1MJZXq4dbwz1LEWZL
 0k0Z1oHV4xp7jyaGCRD86aTwMA3ztqV5lCWwmEBTNeWFY64D4KS3Mz4WyMlUNZagAJlr
 IW/Crm3ApBuvhX2IgasrJnhghFglkX6mc77wWuk0XKLxuVUKGXpI+AZwAqVgZLvCdP5u
 sdmw7dSWADtjHfXcJsA3/CTbCSUQZzVgm+fxrhn1d65auXD2clAAsm+cpaebKOB4LWbD
 mn3NMB7Pg81A0gRBH+uZ9ZDRzkbvybMweHRQeOpPGKDL3ZKM0Ndk5g69YzSn6QNs/IeU
 Trcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784042807; x=1784647607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z1kAMXC9Fsrzsu3wy6G45NcKTFRzU/dYRQXjW306SC4=;
 b=DL5az2F4CeXTlHitqaoGMoo1MEzD7J8mcuCK3Btc0CfxsgypRBHGwFyoQYPmcAEsNc
 CeMgmZ+ybQBXjrNq9MTiqmmSUGPrIXzO6RYY9kIGO1VUqxKKlvAwFUGgfBSNtc/02i00
 87CZfs2kXdD1R3QK+A5sb8bPMD1dvYwr0u13meliHoQmNHb5BWABLlD08UzoZhHFiNU7
 W/3Zlu+0865oqtph1J3IFYcKKkiutshis6iWlHqZ3ALFbbhWLO5LrP+zwer+2D9kXQpm
 SCCGgI+11sP0RvawlmvfPad7btdWCEIc1vXjqy1TZ+1jjEJ+vMpqDjaPJh8OxxEWucHR
 cavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784042807; x=1784647607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z1kAMXC9Fsrzsu3wy6G45NcKTFRzU/dYRQXjW306SC4=;
 b=hk0yXVd3cv5m+DSNxGJEbkT4MYXvuzg/BbGE8LW6n9JKxf2Ad+M+H3jX9yJGRNHOSO
 0AIGRdVWhDwMc6apwJfVhwYcfWnup7okJIubFgO8rANC+fivKCU372grkFPMVlTwJ8P0
 om1+wDTjtcga/5jOjui4f+rI0x/Yv5zToxfmDnps2EKrWFcSjveAiZvq51+6o88rpmtv
 +wR9q8KH+5a4wgi7h7JhQ9p+foZpUyVRa8oy+FTD9S8t0vBJl9RccLdmU7SQm+VrZFrr
 qBKIw3xDnLCn1QyV/2Zcn6+Va83ppZwHnVLEYmYvi/c9UU2p5bp7HLdZP2lkZyP0vFvs
 L0uA==
X-Gm-Message-State: AOJu0Yz/YCdAClqrAKYhidJBFxKN4LZvdQcox8lneDW1starNcOH9LHv
 uvlq23r0OdABpp7rbX+nzNpAHlj8YwYm14Jm342A7+qxQ++bbe20o2jb1v5YQvUGL/sXzwfiif/
 IT1rnlnFiyCMWWKni7Cg9rYGWusupBOk=
X-Gm-Gg: AfdE7cntANKB2UkhjPF2oh9S93jMC4f8qqTASOKt5tE9Vsk6nUUxG8LmZKGLuUdT3Q0
 ySG3IC92GdwvSfcwPaoWsM7/IHGrOYuhRl82SWiZf9pT5cfUFLs+op1c7ijXlWL9EoSuS3a/M3R
 JPg2G8WYK2Odca9E1gJhWKPwGXQEo6shrZs4UveuUfBJry3FuoUQuGrdbTjX5LdxwQ1RZlV4MJ6
 q+z5gURadc4MdAqE6CyxqEXNInVN6HnGPRmxZVsZyeAS3WRZD2/91bsMHptAteFbOZ3wfMe
X-Received: by 2002:a05:690c:3746:b0:81e:4aa9:d02a with SMTP id
 00721157ae682-81e8ffee750mr101117027b3.6.1784042807533; Tue, 14 Jul 2026
 08:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260714124621.522948-1-clg@redhat.com>
 <20260714124621.522948-3-clg@redhat.com>
In-Reply-To: <20260714124621.522948-3-clg@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Jul 2026 23:26:35 +0800
X-Gm-Features: AUfX_mxvqEgfqLFCJSor1aV2Ajst-Sde8_xQ3mDERUwuxYV0Kld9Qgo1Qr_KCHo
Message-ID: <CAEUhbmUmRVkhJ_fa7astC=5dVCcHS4N=B5MgZ3c1R3iVrdxRCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tests/qtest: aspeed_smc: Add fast-read test
 coverage
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jul 14, 2026 at 8:47=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Introduce a spi_ctrl_set_fast_read() helper and add
> read_page_mem_fast_read (CTRL_FREADMODE with dummy byte) and
> write_page_fast_read (user-mode FAST_READ) tests.
>
> While at it, replace the license boilerplate with SPDX identifier.
>
> Link: https://lore.kernel.org/qemu-devel/20260708111544.1440761-3-clg@red=
hat.com
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/aspeed-smc-utils.h | 23 +++--------
>  tests/qtest/aspeed-smc-utils.c | 75 ++++++++++++++++++++++++++--------
>  tests/qtest/aspeed_smc-test.c  | 39 ++++++++++--------
>  tests/qtest/ast2700-smc-test.c |  4 ++
>  4 files changed, 90 insertions(+), 51 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


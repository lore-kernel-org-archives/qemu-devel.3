Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC9ED5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kfV-0005uP-Pj; Sat, 09 Nov 2024 07:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kfA-0005gR-FQ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:34:06 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kf8-0007J3-Gn
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:34:00 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso3707259a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731155637; x=1731760437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=atABj/PbIpgDX6iYoiprFb5EFdPdSSRiRVA3vJG0Jeo=;
 b=MIcrerrf/LFNSqWKfno9b+UEmfsdmkt3iEWrSQAOaSdHxJ79I1MpwRnl+8bNWmsC5t
 KaaTCZV9xAD83nspgnZt2n9F6t0LnCI9kzFT9J1Gy9WjtZTOTMaJ5MR2/GNmAgJX/PYc
 /+S2PfeIWCroAFclOkCNHMxAMh+EuOc+HSae3/IaoZqn1ZEOd+3GFNmpUaJTzkrwq4O5
 rYMNe9PTdtnWPd/UnLmwt4QKM+ZvOSWFxKZoqjM8eDArfe0q/Bwn+6Zaemjm+t3al74U
 t5KBIVdXWRUIKGUjeGMGel6ZY6Cd2ZHFKyP6VhAvd14YB/m+MDJmizpfKJHltCHge08u
 NP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731155637; x=1731760437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=atABj/PbIpgDX6iYoiprFb5EFdPdSSRiRVA3vJG0Jeo=;
 b=ZVxkrH8aYa2N9C2jPSl3CiuJqDul9d14726O3vOXJtI3vh9K7L0cI39swOKZE+7FKu
 Qj0HckVxfCGTrtxRSRaqXwJ0UVYAPYKvnwxpqDa214CFg3JOcI+CWo0aWpX1CT20OLDm
 Ou+AMXQV20DWRGjlAcrMd+k5lf+eEIJakr8It7htHhkrXoaNGwP4QIcILsOdpp+udCHN
 1tJ+aLfJwNRZOC3vGjme7hWBhG0c746N9drIclxw6CkI3n7Q2g2S7BVDT4h0jrvKewiC
 rerOYo+0lhERMQLVH6dRM7WiWoHr0Hgv+YmlnMXwwU9Nq0kVuBsYZB/SYpvYZ+TjJjYN
 scqA==
X-Gm-Message-State: AOJu0Yx5Rmc4n99e9+BIkBPUes5VPDRo0+5cxVML0XjY647g7aawSw/c
 efUB5eMK2ix2r7SpRIdB2yX84pQ+Q4HrBJrsthqMZgqdTF1Kp6a8FSAnSEjQ2bMw8EDvzu+UM48
 ZWM+kM02QjPO9eK09OeBJrKQb0TJdVzXE0NcLMfC7CabZ5DMp
X-Google-Smtp-Source: AGHT+IEGrEPr77FtuESVZgnkFrGyGddMxXLreS6c981eWtviM8OCxLZN5jvYWb3PIfR3lJKaJ1Y7KEk/0Jvhk1gaiX4=
X-Received: by 2002:a05:6402:5cc:b0:5ce:c936:b71d with SMTP id
 4fb4d7f45d1cf-5cf0a445989mr4246399a12.28.1731155636665; Sat, 09 Nov 2024
 04:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20241108104312.534448-1-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2024 12:33:45 +0000
Message-ID: <CAFEAcA9tx6Gcq8hc=FUqbw9Qw4TDMcTgK=Pc0MAhobkkcT55Bg@mail.gmail.com>
Subject: Re: [PULL 00/10] Functional test fixes & next-cube cleanup
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 8 Nov 2024 at 10:43, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:
>
>   Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-08
>
> for you to fetch changes up to e7e76150a2e9642adf6763bcd8ca9a2a5d3b74b3:
>
>   ui/input-legacy.c: remove unused legacy qemu_add_kbd_event_handler() function (2024-11-08 11:06:42 +0100)
>
> ----------------------------------------------------------------
> * Various fixes and improvements for the functional tests
> * Refresh CI container files with the latest changes from libvirt-ci
> * Clean up keyboard code of the next-cube machine to get rid of a legacy API
>   (I know, the kbd patches are a little bit borderline for soft-freeze
>   already, but since the next-cube machine is experimental anyway, I
>   still opted for including them here)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


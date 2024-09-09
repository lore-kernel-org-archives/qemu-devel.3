Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE33ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sndAF-0005F4-Ol; Mon, 09 Sep 2024 08:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sndAD-0005EM-Vr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:06:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sndA5-0004UL-Ps
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:06:31 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso10159731a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725883588; x=1726488388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qwDVvxa1AFK4oNNPAV5vfceahRgm4gF+672onMNgp5I=;
 b=Tlty1WoIJviYWbjxTQMwo98XtQ1JX4sV5YVavUpXhurCkAjmlsOmDGON6t+llYICHW
 i1Iy40VaWNJGDbshWsm6dWbRgHO+qmJ3Ynj8Nsy85dZ3Kl3cV4+mOZ5r7X5f+VIp4XJ1
 /yCX/hph3WkjWQocqEvRq9kJw4zxQX0lLy1Uwx4osKm0Z8QTBQNHKCKgb+/cm4JYiB3/
 FWiQJ8DX7dMh1OhPSCU5gIb73Etl9YxzU/7q+DaJRm0zbYf/IygFNODtR4lP7XV10h62
 GrK/SnB5ZUxddcHSE3Mc7mF11gaerAYOjuUhr7QN8MkYJI2lpfRwciubwYnxzalfIGJ9
 ftbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725883588; x=1726488388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qwDVvxa1AFK4oNNPAV5vfceahRgm4gF+672onMNgp5I=;
 b=DyMvCAT4lA3sJuhF7iI8R2asvrCbj4sJCBlhx7HMBHY82dlMcut/0+xPXw/PkzG6Pq
 KdLMdZKMOwQ5Vfj5S/RFLvxS9MScHmagKmGnbRNaxJCFhD8XRnzLpdG/legmdjNj14TE
 g7giGG0VT48zEhoJedzylA7FttDjOijwcvA3Qsg7iTdir00d39sVrsoQwYVZ435GNjRv
 zdYvJrN/xBsZpMB0w5dldppJ0fymSW5qyZcqldisVfO3LGwYrexC3/edgxJuF4koI5/m
 BEyaf1fTxiUM+6Gopmdr2uhCgrLkYdQgD1oNOwdrWQK/pwKGTPUCWxFhXmZeFliMRDG4
 AItw==
X-Gm-Message-State: AOJu0YyIbZ704wK3xLLvNUtrWl7MuMYMyJcP9Dv5ElK3F1ydX3uthZWI
 ENE5p1hb7zlanb9Zs2sam+IzZptMfb6EMofzWJrHyPHjR1bK1ncppHyjWOKJtIcrrJY/HZ0nI6A
 aBKMOaYXbnbQeKmXQElhdGexjvItPL/QJvmvvzbRDbtTUapBg
X-Google-Smtp-Source: AGHT+IEPjYFndIuHMK8DmAX+JywYj8kJZ12FgFy7r01BeET5msUUs49TBz/ZczhsI5MJD+O7SlXFhX6dOiqEXm2TO8Y=
X-Received: by 2002:a05:6402:4014:b0:5c2:6e51:9d1a with SMTP id
 4fb4d7f45d1cf-5c3c1f9cbbdmr17703846a12.14.1725883587746; Mon, 09 Sep 2024
 05:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240908131128.19384-1-huth@tuxfamily.org>
In-Reply-To: <20240908131128.19384-1-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 13:06:15 +0100
Message-ID: <CAFEAcA8cP2TwhNEUTFQ7MnU2ij36V0hTszbf1JizwnWj4HfYdQ@mail.gmail.com>
Subject: Re: [PULL 0/3] m68k patches
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 8 Sept 2024 at 14:11, Thomas Huth <huth@tuxfamily.org> wrote:
>
>  Hi!
>
> The following changes since commit 1581a0bc928d61230ed6e43bcb83f2f6737d0bc0:
>
>   Merge tag 'pull-ufs-20240906' of https://gitlab.com/jeuk20.kim/qemu into staging (2024-09-06 15:27:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2024-09-08
>
> for you to fetch changes up to df827aace663fdd9c432e2ff76fb13d20cbc0ca4:
>
>   hw/nubus/nubus-device: Range check 'slot' property (2024-09-08 11:49:49 +0200)
>
> ----------------------------------------------------------------
> * Fix Coverity issues in mcf5208evb and nubus machines
> * Add URLs for mcf5208evb datasheets
>
> ----------------------------------------------------------------
>
> Peter Maydell (3):
>   hw/m68k/mcf5208: Avoid shifting off end of integer
>   hw/m68k/mcf5208: Add URLs for datasheets
>   hw/nubus/nubus-device: Range check 'slot' property


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


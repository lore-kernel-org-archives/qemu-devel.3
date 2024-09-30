Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C534ECF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFWX-0000gv-Dh; Mon, 30 Sep 2024 08:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFWV-0000em-QA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:29:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svFWT-00038C-Uj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:29:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c88e4a7c53so2114289a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727699344; x=1728304144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0V2ooaSZDv2XXQbSvVndMiwMWq7csaOW49gY/30mtH4=;
 b=uUkBWpV9L7/qnCWhxwIKx77AuuNIjlqSQoBP7UF6s2hwkKdPa+AASmKuVusTWB3Yug
 KPxES7hIryzwm7ngZT4IvTxgA2t5oxl4QTjDgrNYdqZMEL/Crv/w8fEOB/uW6a9rRqde
 HCFjzOX/NtOcacOastqoRqEG5Gtur55pBb1y4lyfnLDQG/CyPt+pleaQ5qlHEZBzAKAK
 LNUz+Sx40GyCxeClQoZiVKyJ77kNrQSjVzSL49o2//E2XjVpOkaD9jKnh1fz7gM+W2DH
 BuHY27NiZEMbvI+J/6+Njsi2iEF76Z4rsGm5Wt3q2O6zw7ci3IG3wIjr1QBGTja6cqVy
 6IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727699344; x=1728304144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0V2ooaSZDv2XXQbSvVndMiwMWq7csaOW49gY/30mtH4=;
 b=M6LCHajZfuKaMooGJauuE/0j4xPAujKCV6iZV4gJsnmOY93/UoVX99E7zzXvnEuGOM
 iha87SxUPp1F9BCIgwdnqto0hPSCTlCixCkcvGLsz447kwL85/tzZ+ii0l5iYKxahNSE
 qZvZA3QTv8iJBZD1eIoYOwDhIX8JILQqp2vcBTByvB586D1r3NDZY754SZ3taZ03+oOQ
 GVEwctW8cS3WcYuZGPR9g97IAq/xf0CBo2wL4hn8jKDM8y1l5oZibOOWvufvt1oCYBO7
 8BK62pZyRk4WXeqr6fcY55mmJXLGHoWWYLW+vkLsbpg77/GVRpdGLC5hIJVBlv/8b1fb
 ++hA==
X-Gm-Message-State: AOJu0YyZYZdNLjKv2rek7wIE/aSXiP2pt4TpnKHmgdzoPKQ9rNycJhBG
 rb4MEekN9PRJhfTR6Ni0ApPWHxxE/DlzIq4Z/4rDHQxLcf2C+gfHG4fRggfQZwf5sAtgXJrLFxu
 hfM+wXH+t5qmcCfQ59j95fZlNWZ6YkVz0JQuXeQ==
X-Google-Smtp-Source: AGHT+IHw1L4YHlIla0+UOdzgCWGeoK7Ciy7opfQClLIJ2KeefnfK7kqYhC6BqiGizUDftU7cKirJ13aOmezLHuWhFRs=
X-Received: by 2002:a05:6402:2687:b0:5c3:cc7d:c29d with SMTP id
 4fb4d7f45d1cf-5c8824d381cmr9885928a12.6.1727699344179; Mon, 30 Sep 2024
 05:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240927071051.1444768-1-ardb+git@google.com>
In-Reply-To: <20240927071051.1444768-1-ardb+git@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 13:28:53 +0100
Message-ID: <CAFEAcA-ba6OaxgmO5HeEOu=kNNwL9sVjzOSJAFbW2X586_+QvA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Avoid target_ulong for physical address
 lookups
To: Ard Biesheuvel <ardb+git@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 27 Sept 2024 at 08:11, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> target_ulong is typedef'ed as a 32-bit integer when building the
> qemu-system-arm target, and this is smaller than the size of an
> intermediate physical address when LPAE is being used.
>
> Given that Linux may place leaf level user page tables in high memory
> when built for LPAE, the kernel will crash with an external abort as
> soon as it enters user space when running with more than ~3 GiB of
> system RAM.
>
> So replace target_ulong with vaddr in places where it may carry an
> address value that is not representable in 32 bits.
>
> Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Applied to target-arm.next, thanks (and tagged as for stable).

-- PMM


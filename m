Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEADED68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC00g-0002K2-Qc; Fri, 15 Nov 2024 12:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tC00f-0002HQ-2r
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:21:29 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tC00d-0000yT-D7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:21:28 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b18da94ba9so172678485a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731691286; x=1732296086; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiWvHahej0WBsUn+pdMeCYQV8JXwtBnAYjBTpPrxFug=;
 b=fAWrsCE2CyIuVhOfMZFBy76renILKvWZaS1caM7L9oKnPTiGZhhlHLrybDlhf1WlEC
 71ckomag81xRfKX84IJr21xw3vvvsMkWL65sypntI2rKryqGEAjG1eJj7TYsTQQNanzq
 MUsUOqP/CTfZwC6mCSpzfslBTkMLuStRG2poa4uyzUgXEa+COmK0fXAnQVv+ms1YdqoW
 a1JJ19xI8kPl08/A5cqeCBPTcaUOmGHsRdMlQWk1PI8/yJ5CP6j4VCtNSKixh5nBVvw8
 A9bq1ycg+mg6oEKihj/1WseAAfeVL+WDUWych0GEStwqo3PUY8Ato8zp9SOrH2il/YP3
 iOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691286; x=1732296086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiWvHahej0WBsUn+pdMeCYQV8JXwtBnAYjBTpPrxFug=;
 b=I69RnlEFI8RAH70ZemS+/Zxs+B2g8/Wyw8KxpsjwRTNGwCXk2mqYhU6SwkTqSID5GM
 qa0TCG1B9OkC73FlGLHJG6UVxSPIpr9XyZql/r8vjMKo56ifZ+7+mVy/Koe4IH970xX6
 Y+aZNydZ1JcuFpICuQrsApX5nk1MC+ebxn2sVKUDLvGzm0pSifuM70yPGrU6SBJM/8UU
 fZYYejPlkxphgeeGCoK2PNS8oeZtL8NT8x97gs7hgcuPuLNi53+x4k/uWTJfgLFxvsDV
 K1hN2/Qw0Wa/cWBAuiIuEFFLwMaF55FFnU3fkI7iNQGs0mUJEvn0KD9aQFhZ7/y1+K7m
 HwFg==
X-Gm-Message-State: AOJu0Yz0+FQi0I4+vNFyzoMdXPLfQORvXADSGVqkXujo9XUB9qHPUHlN
 ptF/ACeQHcJMeTH1WE/LQU3NIDFTGQbBkPzsnbLJgR1kRXrJ5AKGrhoKrkKgdgOgzGFaghhDiQA
 +135HAkxCJyxL/FYJfAK2FsPRAdE8AsBo9R8Z
X-Google-Smtp-Source: AGHT+IEVdsdPTDkFIF1pEBjGRiI4wzR43Ozbig8C79WM/ac3saYoilgBRizVN5C6mFbOoZQhiDed644avEfJ6ALDsco=
X-Received: by 2002:a05:620a:19a9:b0:7ac:9b07:dbd3 with SMTP id
 af79cd13be357-7b35a464ec7mr1232809685a.5.1731691285926; Fri, 15 Nov 2024
 09:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Fri, 15 Nov 2024 09:21:14 -0800
Message-ID: <CAKbPEtafvSf1ACPRQj2-eEGS_Son53rmyqZ_8vH8gx-uK4o78g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Make WDOGCONTROL.INTEN the counter enable of the
 CMSDK APB Watchdog
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=roqueh@google.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello,

I forgot to add the -v 2 to this patch series. This is the second
version after Peter's feedback. Shall I resend it again or is it fine
like this?

Thanks

Roque

On Fri, Nov 15, 2024 at 8:03=E2=80=AFAM Roque Arcudia Hernandez
<roqueh@google.com> wrote:
>
> The following patchset tries to address an issue where the watchdog
> counter was running as soon as the device is out of reset. This
> created a few problems with the firmware under test. It was pointed
> out that the firmware under test was already working on an emulator
> using the real RTL. Further review showed that the WDOGCONTROL.INTEN
> is also expected to be the counter enable as it is defined in this
> page from ARM:
>
> https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watc=
hdog/programmers-model?lang=3Den
>
>      |       | Enable the interrupt event, WDOGINT. Set to 1 to
>      |       | enable the counter and the interrupt, or to 0 to
>  [0] | INTEN | disable the counter and interrupt. Reloads the
>      |       | counter from the value in WDOGLOAD when the interrupt
>      |       | is enabled, after previously being disabled.
>
> The second half of the patch is focused on adding tests for this
> behavior. It was required to modify the test to be able to run some
> test cases in the MPS2 since the the stellaris machine had 2 issues:
>
>   - The stellaris machine did not run the counter out of reset
>     because of the way it is reset. The function
>     ssys_calculate_system_clock is not called until the reset phase
>     stellaris_sys_reset_hold which is after the watchdog executes its
>     reset, so the watchdog would not start the counter due to the
>     clock not being set up at the time of reset.
>
>   - The Stellaris machine uses a derived watchdog and not the
>     original CMSDK one which has a special behavior where it cannot
>     be stopped.
>
> The MPS2 machine on the other hand uses the standard CMSDK watchdog
> and could expose the problems we were dealing with.
>
> Roque Arcudia Hernandez (5):
>   hw/watchdog/cmsdk_apb_watchdog: Fix broken link
>   hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
>   tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
>   tests/qtest/cmsdk-apb-watchdog-test: Don't abort on assertion failure
>   tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enable
>
>  hw/watchdog/cmsdk-apb-watchdog.c      |  38 ++-
>  tests/qtest/cmsdk-apb-watchdog-test.c | 328 +++++++++++++++++++++++---
>  tests/qtest/meson.build               |   3 +-
>  3 files changed, 329 insertions(+), 40 deletions(-)
>
> --
> 2.47.0.338.g60cca15819-goog
>


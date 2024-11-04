Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8AD132DC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ylM-00030o-8t; Mon, 04 Nov 2024 10:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7ylK-00030Z-Lx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:13:02 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7ylI-0000hU-Ul
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:13:02 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so6401210a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730733179; x=1731337979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us5AWBKQWPEF3MTl3Vlg7m8VPLdGEoNyuWlrPb9j35Y=;
 b=pXAfbO5laLfHUnTbT5BmVnNsekGTSYCfH+bxxH4uvNv+Q2n/1VIQm919gEJwwJmZc3
 a6RV172z9fFnbwVx7xfvYQVfj5cNxcmjorB0e/iWHXAXkAwcdeGOh4qpso54/W+RDTIL
 +8qd9RDjeOn7WzrjPuJX5Jtf3BK67BDJcrjSPl0yrqZ/tjf47OcnY9hJF246ferwCgqt
 0pd5b8T4MbtM60PmF9fZC7Ts1TUPAxvs1rmO6tmcy51/SepCLgvKyjcMFyAKobtCgADe
 K1r8VkD+QghCCjSikJ+iMjRRu9r19BkjJJNteUCNkwG57qJawvE86okHpSbxgKOr/U+p
 tD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730733179; x=1731337979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=us5AWBKQWPEF3MTl3Vlg7m8VPLdGEoNyuWlrPb9j35Y=;
 b=m4yU66XkLLx4yTT0w/Jqi70BG9nEPzeqEMUc2l5kUu/RbX2b78MLde0Jt/9hvgxC2a
 s5N2lqg2liYiwMOGdLNKONjEFReGPeFngNSQRl5VO1rkLToXHA5Eqi1XtJ36GfLv2oTw
 eeZQ4eatuLhxk7/pMIk2S6igxXj02b73vOFwzIJFNxEQOfWfc37wBVUf+SLt8tgL8Bz6
 8JOxQDbDoIaVrnFj6U959j4JE1vxSHr3eCQF9lRjhxpp3YJVjzWTLgmosJhcjExDNvlN
 8mAdD/VjhB3aAotCwkkF/ovy5tZxEuQBKAKVdrxly+Wqu8VuLFIbhOdEwHOsyAmvgqIP
 zJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1rf2N7VHXgpGHOK7qDPnlVfgexmfrYYaRIIUjNBJjV2PWiG1mT5S6nP15+czhhveBCv4jOtC1CfIW@nongnu.org
X-Gm-Message-State: AOJu0Yx2TqawrovNcXYJcovD+jRJj80t0FaX8jkzOzsoU6NQccs/Lsvx
 7+NBtWgQ9D4xewL+lcRRUR+XvfEavx/31Lhzrp/SOd87Llz1K4l3mJHRLQS6/lWFyIysrnlMx3y
 kEkaL6eLYtHPnj9+pRo81YPiusUzDoPD3bOKaPQ==
X-Google-Smtp-Source: AGHT+IFdvne5Xir2A/KCUyfFT0Ycl+5iTF4+UKlk9uuS3pTC5/IiUlx20OmLJYwOeEzTS8ZTnOa8jf4/Y9FGJXRJ2pU=
X-Received: by 2002:a05:6402:3482:b0:5ce:d378:b098 with SMTP id
 4fb4d7f45d1cf-5ced378b241mr5331729a12.5.1730733178995; Mon, 04 Nov 2024
 07:12:58 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
 <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
 <c88e891e-153e-4fc3-bb10-6b9dff5e7789@kaod.org>
 <89e98def-7e7a-40a0-ae38-5bdd5c634592@kaod.org>
In-Reply-To: <89e98def-7e7a-40a0-ae38-5bdd5c634592@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 15:12:47 +0000
Message-ID: <CAFEAcA94oNvNs34UOwbSPWG-ZAWGVO_woprnFesNnH_BpbJE+w@mail.gmail.com>
Subject: Re: check-function failing on func-arm-arm_aspeed
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 4 Nov 2024 at 13:16, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 11/4/24 13:19, C=C3=A9dric Le Goater wrote:
> > On 11/4/24 13:12, Thomas Huth wrote:
> >> On 28/10/2024 18.14, Peter Maydell wrote:
> >>> Trying a "make check-functional" I find that the func-arm-arm_aspeed
> >>> test seems to hit a timeout:
> >>>
> >>> 18/18 qemu:func-thorough+func-arm-thorough+thorough /
> >>> func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
> >>> signal 15 SIGTERM
> >>>
> >>> This is with commit cea8ac78545a.
> >>
> >> C=C3=A9dric, is it working reliable for you?
> >
> > I have never seen this issue on the systems I use. Let me try again.
>
> On a (slow) ARM SBC, I am seeing a timeout indeed.
>
> The log file contains :
>
> 2024-11-04 13:59:01,219: Starting dropbear sshd: OK
> 2024-11-04 13:59:01,628: Aspeed AST2600 EVB
> 2024-11-04 13:59:01,829: ast2600-evb login: root
> 2024-11-04 13:59:01,847: passw0rd
> 2024-11-04 13:59:01,850: echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device=
/new_device
> 2024-11-04 14:00:13,916: Password:
> 2024-11-04 14:00:13,917: Login timed out after 60 seconds
> 2024-11-04 14:00:15,418: Aspeed AST2600 EVB
>
> This means that the sleep workaround failed :/
>
>          # the line before login:
>          self.wait_for_console_pattern(pattern)
>          time.sleep(0.1)
>          exec_command(self, 'root')
>          time.sleep(0.1)
>          exec_command(self, "passw0rd")

Those sleeps are definitely dubious, but I did try a local
change of bumping them to 2 seconds and it didn't fix the problem.
Looking at
 tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2500_evb_b=
uildroot/console.log
in the build tree (which I assume is the relevant log)
it did log in OK, and proceeded through the test to try
to power the machine off:

2024-11-04 14:39:59,092: cat /sys/class/hwmon/hwmon1/temp1_input
2024-11-04 14:39:59,110: # cat /sys/class/hwmon/hwmon1/temp1_input
2024-11-04 14:39:59,131: 18000
2024-11-04 14:39:59,131: poweroff
2024-11-04 14:39:59,139: # poweroff
2024-11-04 14:39:59,323: # Stopping dropbear sshd: OK
2024-11-04 14:40:00,615: Stopping network:

but that's where the log ends.

Digging even further I have just found

tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2500_evb_bu=
ildroot/qemu-machine-cgjbonzx/7f39a8515f90.log

which has what looks like QEMU's stderr output, which reveals
the culprit:

../../net/checksum.c:106:9: runtime error: member access within
misaligned address 0x55a2d1887a5e for type 'struct ip_header', which
requires 4 byte alignment
0x55a2d1887a5e: note: pointer points here
 04 a8 08 00 45 00  01 48 37 9a 40 00 40 11  e9 fa 0a 00 02 0f 0a 00
02 02 00 44 00 43 01 34  19 56
             ^
    #0 0x55a2cc1f87d4 in net_checksum_calculate
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../net/checks=
um.c:106:9
    #1 0x55a2cbcf00ad in ftgmac100_do_tx
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/net/ftg=
mac100.c:611:17
    #2 0x55a2cbcf00ad in ftgmac100_write
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/net/ftg=
mac100.c:843:13
    #3 0x55a2cc7af5af in memory_region_write_accessor
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:497:5
    #4 0x55a2cc7aec6a in access_with_adjusted_size
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:573:18
    #5 0x55a2cc7ae717 in memory_region_dispatch_write
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c
    #6 0x55a2cc7e5c85 in flatview_write_continue_step
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/phy=
smem.c:2786:18
    #7 0x55a2cc7dba0c in flatview_write_continue
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/phy=
smem.c:2816:19
    #8 0x55a2cc7dba0c in flatview_write
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/phy=
smem.c:2847:12
    #9 0x55a2cc7e4efa in subpage_write
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/phy=
smem.c:2425:12
    #10 0x55a2cc7afa66 in memory_region_write_with_attrs_accessor
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:518:12
    #11 0x55a2cc7aec6a in access_with_adjusted_size
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:573:18
    #12 0x55a2cc7ae717 in memory_region_dispatch_write
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c
    #13 0x55a2cc86f2c8 in int_st_mmio_leN
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../accel/tcg/=
cputlb.c:2489:13
    #14 0x55a2cc86f2c8 in do_st_mmio_leN
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../accel/tcg/=
cputlb.c:2524:12
    #15 0x55a2cc85d2e0 in do_st_4
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../accel/tcg/=
cputlb.c:2694:9
    #16 0x55a2cc85d2e0 in do_st4_mmu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../accel/tcg/=
cputlb.c:2770:9
    #17 0x7fb73a213e05  (<unknown module>)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../net/checksum.c:106:9 in


So the network device in this board has hit an undefined
behaviour which clang's sanitizer has detected and
made QEMU abort.

The test framework here seems to be severely lacking:

(1) If QEMU exits with failure or crashes then we should
report the test as a failure, not a timeout
(2) If QEMU prints warnings or errors to stderr, we
should collect these in the main log file, not buried
under a rock with no pointers from the main log file
to that rock
(3) Ideally we should print at least a summary of that
failure to the terminal so the user can clearly see
"oh, this test failed because QEMU asserted or whatever"
without having to dig through all the log files

If the actual cause of the test failure had been
better reported to the user running the tests I would
have figured this out a lot faster.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A2D6C287
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDU9M-0004ZW-2p; Tue, 19 Nov 2024 14:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDU9J-0004ZA-TG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:44:33 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDU9H-0008Ce-Hw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:44:33 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cfe5da1251so1198834a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732045469; x=1732650269; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hPxO0nzaXC4tKTHUoARj0kOvOkHR0Af4n5PxQaCEMIM=;
 b=qe92aq971sxltXIjAhcldky2hW/HaJyWZbqvJAlslMZakUX4eHbGPH/DdhFI5v0gYs
 5Jp7Sey/ERg+lZk7/1BExoUA1nMra11R510tiSTb/Yd8SAJNQZTsXurb3iLD8UKUTpac
 LoR+ogx8CAv9+HHzxHHJx614/rqFKDpAFqTRNjNMgoKDmKElaBsLH+E/+A8/SQv9zzJL
 3vA0v6Kq9pLUhwnzSFT03MreuRtfjBJJYL+J2OppzeRnbXxatsXs+LznIl/enkMsRWmg
 xZ8ORJbA9Dp3+sKAcl5DF8G8RTT88H9Cre5xU0jQhR+DuWTZtB44TrwlFquG0Cr7r6BL
 E6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732045469; x=1732650269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hPxO0nzaXC4tKTHUoARj0kOvOkHR0Af4n5PxQaCEMIM=;
 b=URrZyU/HYL2KWeDLEA4J6zpHh/+W8eHsxzPMmPKjvQ2ZzP57cMNhGjkO293+Uc1lmZ
 k7z0v+eWQy+EX6jdgIMyYs/gRrCoYLmqbi041FrTqJ7MuzCC3Y09w5zZNdsaG6n+U1Fq
 QRWNlbO6FE+MfYhRbQ+y05K7wm+4V21q6HsRc9MlEFjxuYZvzBiusahiJtyon6DpUzb3
 MhWTlDSvJqjj31Q7u2mRjoZnXFWqyWv8Rb1ZQuJjw+D8LZbFsgis2V4NWgvYy7LnV/2f
 jAmhKDes1nxkSukKSlqixMVvAKdkkvYzBGkFcrjVaJF2luAHStRkuvfqqv3UiGc7xzKs
 brlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+HOm8kNO9jJCyMhWyc70cvmNTzYyH1s/PvbQli/RmXtbcDQ6Tqc0Xgf9ObFLlUjdRYlxI7eVY5+o1@nongnu.org
X-Gm-Message-State: AOJu0Yz1lwNp8F99eFAowKgbyMbZHEPNS1jM9uIoDZWXQnGeUNowyk2w
 tKSbec3o3xw/jX2Lso/sh1ibbaVFHfiz5BX0z91VrY16GBf6DYH//B7a/edoRKB+2Dh6xrDH23q
 AZUDjBoLLitolLBA//4uor4h8BDEKE9CWLr6gOZSdLwH0cu+UECo=
X-Google-Smtp-Source: AGHT+IEgnGelztGuz5YBqIHm8H7tjVABXm632B1S+3zemdn5RSP4uy2yK3n2O5G54b30k7aGmiOGUfu/zdH1Fefgg2M=
X-Received: by 2002:a05:6402:5242:b0:5cf:eaf7:276c with SMTP id
 4fb4d7f45d1cf-5cfeaf72aedmr1145502a12.12.1732045469309; Tue, 19 Nov 2024
 11:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20241119172718.363904-1-kwolf@redhat.com>
In-Reply-To: <20241119172718.363904-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 19:44:18 +0000
Message-ID: <CAFEAcA9fVoeWyhYydD9a64vytkcY0VipBmT_kiVpdGc9_FORWQ@mail.gmail.com>
Subject: Re: [PULL v2 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 19 Nov 2024 at 17:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
>
>   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c77fc64e67f3f3050ccd487706eb5f1dcc3ec7d5:
>
>   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-19 18:23:06 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix qmp_device_add() to not throw non-scalar options away (fixes
>   iothread-vq-mapping being silently ignored in device_add)
> - Fix qdev property crash with integer PCI addresses and JSON -device
> - iotests: Fix mypy failure
> - parallels: Avoid potential integer overflow
> - Fix crash in migration_is_running()
>
> ----------------------------------------------------------------

Hi; this failed in the build-oss-fuzz test with a lot of
AddressSanitizer leak reports about leaks from an allocation
triggered via set_pci_devfn. Probably they're all the
same thing; here's the first:

Direct leak of 108 byte(s) in 27 object(s) allocated from:
#0 0x559ac9152c1d in calloc
(/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-virtio-9p+0xca8c1d)
(BuildId: 96bfdcd076cb68d4f42f95581b14d11718bed747)
#1 0x7fc4e6bf8871 in g_malloc0 (/lib64/libglib-2.0.so.0+0x64871)
(BuildId: 36b60dbd02e796145a982d0151ce37202ec05649)
#2 0x559aca4773e0 in qobject_input_start_alternate
/builds/qemu-project/qemu/build-oss-fuzz/../qapi/qobject-input-visitor.c:391:12
#3 0x559aca46fa98 in visit_start_alternate
/builds/qemu-project/qemu/build-oss-fuzz/../qapi/qapi-visit-core.c:119:10
#4 0x559ac9343b33 in set_pci_devfn
/builds/qemu-project/qemu/build-oss-fuzz/../hw/core/qdev-properties-system.c:824:10
#5 0x559ac9ff7707 in object_property_init_defval
/builds/qemu-project/qemu/build-oss-fuzz/../qom/object.c:1591:5
#6 0x559ac9feb0f3 in object_class_property_init_all
/builds/qemu-project/qemu/build-oss-fuzz/../qom/object.c:557:13
#7 0x559ac9feb0f3 in object_initialize_with_type
/builds/qemu-project/qemu/build-oss-fuzz/../qom/object.c:573:5
#8 0x559ac9fec69c in object_new_with_type
/builds/qemu-project/qemu/build-oss-fuzz/../qom/object.c:780:5
#9 0x559ac9fec69c in object_new_with_class
/builds/qemu-project/qemu/build-oss-fuzz/../qom/object.c:788:12
#10 0x559ac99cd111 in qemu_get_nic_models
/builds/qemu-project/qemu/build-oss-fuzz/../net/net.c:951:27
#11 0x559ac99cd86f in qemu_create_nic_bus_devices
/builds/qemu-project/qemu/build-oss-fuzz/../net/net.c:1186:29
#12 0x559ac9c032e6 in pc_nic_init
/builds/qemu-project/qemu/build-oss-fuzz/../hw/i386/pc.c:1256:9
#13 0x559ac9bcdeb5 in pc_q35_init
/builds/qemu-project/qemu/build-oss-fuzz/../hw/i386/pc_q35.c:320:5
#14 0x559ac9334b8d in machine_run_board_init
/builds/qemu-project/qemu/build-oss-fuzz/../hw/core/machine.c:1622:5
#15 0x559ac9907a03 in qemu_init_board
/builds/qemu-project/qemu/build-oss-fuzz/../system/vl.c:2629:5
#16 0x559ac9907a03 in qmp_x_exit_preconfig
/builds/qemu-project/qemu/build-oss-fuzz/../system/vl.c:2715:5
#17 0x559ac990da48 in qemu_init
/builds/qemu-project/qemu/build-oss-fuzz/../system/vl.c:3750:9

https://gitlab.com/qemu-project/qemu/-/jobs/8415761320

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A853CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smENY-0003HQ-Mv; Thu, 05 Sep 2024 11:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smENX-0003Gx-I5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:26:35 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smENV-00066a-Qd
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:26:35 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bf01bdaff0so1044743a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725549991; x=1726154791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0WTXR1MqRJMiI6tvGrXZd7AqrTXg1FmhDa5FZ+T+Xo=;
 b=vyi69HjkOk08KQV04kauBl20EnBhKuRtwbb4ufhFdx/7wss/4qLsvAth1bJ0Ckp27m
 9uhCtTqe4vyYi1HqfxoMnK+GCekbNBsjQM04jDIWjwkRjaWugahBfILzEEDDnUSvxMiO
 Wlj8YVR+ddplV1z38GBonmtbEwILGEo6QcDMfiKbZAr9DEvHG7itJ4eLwdQh0ijeKZ4y
 uc6pvsbckyPIK6IxUzafXk9DiQ+5nIzitjoBocTUU/khJPpvgz48l7NzFb/otqYCbYMe
 Yj9qKESZcPO5y1YLYOv/Pi+7Czv58IZPGqGf3Ow1jjP9ZwMBbokeVwKfP2FqGyI1Ybrd
 iELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725549991; x=1726154791;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P0WTXR1MqRJMiI6tvGrXZd7AqrTXg1FmhDa5FZ+T+Xo=;
 b=xO3IB7RtVdH6qeASSCAaJlJ+fhC2lmIPvdEm9OsjDjC3IxzA31MrLhKTRLJ6y3EPwH
 OVxpEdBIMeaxvSJ9kxSBSYKiOzEKmuq7nmfG6t/XXIytFoXSvVWphXe5eHoCcXNaUduk
 nywvHdVHPqlV8m8ESALGt8y2ByBhSBIbaxa6G776FNt/YOvaV2YD8mAeOrgMTH5vAaAC
 8/Xl01p3aQX/Ij0JRfaiAMM2G0FWDVo37Hmt8EaOE/X+H8crPswQi0vFJLmMYC2NPiG/
 bGuNHDQjHD/z7lmgRkNq1KMONUANjh6JuMTEhC19Kvi0WDkublkk0KmLB+1HOaiqHXkk
 QADg==
X-Gm-Message-State: AOJu0Yxfk6gWopIH+bR9RjKwwHgnOgtwITZrc9q+UGyMpGsxgL0OSLmf
 az3ki2bm9U6hKx/crT2pkcRECp8cYOXcbbWhZqDk72Rv/6nGFW5tQYco0GO8Rqg=
X-Google-Smtp-Source: AGHT+IHuxb+ac6LVd6ayJGG/KwWUVC1Ps5UrRkh3iVXOA5VbE5lEwTi9HekuBP26cmGXIZb5YJ8zfw==
X-Received: by 2002:a05:6402:13d6:b0:5be:e01c:6b5c with SMTP id
 4fb4d7f45d1cf-5c21ed2ffdbmr19062633a12.4.1725549991355; 
 Thu, 05 Sep 2024 08:26:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc56bb3dsm1352163a12.45.2024.09.05.08.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:26:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BEA405F8BA;
 Thu,  5 Sep 2024 16:26:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH 0/1] plugins: add API to read guest CPU memory from hwaddr
In-Reply-To: <20240828063224.291503-1-rowanbhart@gmail.com> (Rowan Hart's
 message of "Tue, 27 Aug 2024 23:32:23 -0700")
References: <20240828063224.291503-1-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 05 Sep 2024 16:26:29 +0100
Message-ID: <87y146ruje.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rowan Hart <rowanbhart@gmail.com> writes:

> This patch adds a single API function which allows reading from a guest
> CPU physical address.
>
> I don't know of a good way to add a self-contained test for this feature
> to tests/tcg/plugins, but I did come up with a small test case to
> demonstrate the functionality using peiyuanix/riscv-os:

We have bare metal system tests (hello and memory) for i386, alpha,
loongarch64, aarch64 and arm. If you fancy having a go at implementing a
boot.S for riscv64 that would be super helpful for the check-tcg tests
as a whole.

See:

  tests/tcg/i386/system/boot.S
  tests/tcg/alpha/system/boot.S
  tests/tcg/loongarch64/system/boot.S
  tests/tcg/aarch64/system/boot.S
  tests/tcg/x86_64/system/boot.S
  tests/tcg/arm/system/boot.S

for what is needed (basically a MMU-enabled flat memory map and some
sort of emit char helper, probably using semihosting in this case)

>
> First, grab and build the firmware code:
>
> curl -o firmware.S https://raw.githubusercontent.com/peiyuanix/riscv-os/m=
ain/03-Bare-Metal-Hello-RISC-V/firmware.s
> curl -o firmware.x https://raw.githubusercontent.com/peiyuanix/riscv-os/m=
ain/03-Bare-Metal-Hello-RISC-V/firmware.ld
> riscv64-linux-gnu-as firmware.S -o firmware.o
> riscv64-linux-gnu-ld -T firmware.x -o firmare firmware.o
> riscv64-linux-gnu-objcopy -O binary -S firmware firmware.bin
>
> Next, grab and build the plugin (just dumps from phys address on first
> instruction executed):
>
> curl -o dump-riscv-firmware.c https://gist.githubusercontent.com/novafaci=
ng/5abc08052fab671a0fb26547810b4c55/raw/33772d614d6e36eae30e3405af34f149d7c=
c608b/dump-riscv-firmware.c
> gcc -rdynamic -shared -fPIC -Iinclude/qemu $(pkg-config --cflags --libs g=
lib-2.0) -o libdump-riscv-firmware.so dump-riscv-firmware.c
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


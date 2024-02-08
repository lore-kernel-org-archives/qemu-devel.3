Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1152C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7uP-0002dV-Ks; Thu, 08 Feb 2024 12:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7uN-0002d3-PF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:09:55 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7uL-0003dr-Mc
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:09:55 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so156087a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707412192; x=1708016992; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SMEM1+aO7sDqVu+5d5M+Aeob5TecBo7kY4ZtDI/FNOw=;
 b=Mm9+tVSRoZAbo76YQmYxukan3Gai59K1YS3sHhpfAb9ForM4dDHz7dj5ZPJsznVOWj
 j3IMNTMCPRNI2tqoaWqZ0R9EmPcv9JbbcVxD6Y8HrwHQS8hLB7dqJkbFQ7gusGJ6u9Yh
 4rzGui0+4FK1cn+nRkAEiyQahxzHODzOeQRpqYfCZRMMkoBM24Va5PwgzErErmNA76c2
 vWonwdTiDH/j3qciBUdzZujgKrsrpOJhAd0bASNGh1Gx60w1+avUAL02ME1dCjOyMOGJ
 UUoQpU1rsNxXvBPdhSO0Rxa3JZBUEr+8tgDhyBWbPm9aNNG19pTHWSccKfTpDxSBK519
 o8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707412192; x=1708016992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SMEM1+aO7sDqVu+5d5M+Aeob5TecBo7kY4ZtDI/FNOw=;
 b=PS2/uoUNK7R0AUzkvcL+QFAqa/r32zTx6Z6/SpniYB/ntpRVdE0uD0fvgpqCBcllFQ
 /mq3LV880X+n2aCRA5qGlRwoQBzVEX/oWhhyR18UC5VRq9tBPWvo8Wa+TTsT7c71AHM8
 Yt5jsBA/AK8asB3hW6gBsMHc1IYlJi/h/eNLEYqQu3lCxTokVqBWkPa2Jer+xluxWndT
 6s8qQ3uR7dc9b1F2JJOGkhacBOrKektX4AGRgYzi7kHhwSxOAWV0XKGL1l1NVwyt18cg
 Jojaxnt5lXdjv70DxGGqJT8/BHf8UDF8FU8Oe4aNCj45JN34Ac/WS8OupGxBzc5nX1ov
 9rZQ==
X-Gm-Message-State: AOJu0YxJI8W8+KbXUy2USvhrjeg24pNNTqtD10tgoOqrbAuOT4BwM4j5
 DwYnUNQP/4P2nSOIQwyzViFQhv3ZYLNo6svNO9cZZC3vsx1rrtqT/rSRpK7DKcBgCePLODOGpe1
 PKIhxbuOUQ5t130lmnL6fUX5I7S/ztdvziALMiybKDIYgbDGh
X-Google-Smtp-Source: AGHT+IHlMqbYVd+lGXw5fatwRwfH9SOaFpSNQF1KFlM79Ioe5CtP9GoivEne8v1tshEKQvzAzLLLHACNGkc96CTMEXU=
X-Received: by 2002:aa7:dccf:0:b0:560:ea74:a67a with SMTP id
 w15-20020aa7dccf000000b00560ea74a67amr3642669edu.17.1707412191932; Thu, 08
 Feb 2024 09:09:51 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 17:09:41 +0000
Message-ID: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
Subject: migration-test random intermittent failure, openbsd VM
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

Random intermittent in migration-test when running the tests
in the openbsd VM (i.e. what you get from 'make -C build vm-build-openbsd')
Any ideas?

106/847 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
           ERROR          157.51s   killed by signal 6 SIGABRT
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
qemu-system-x86_64: multifd_send_sync_main: channel 12 has already quit
qemu-system-x86_64: TLS handshake failed: The TLS connection was
non-properly terminated.
qemu-system-x86_64: TLS handshake failed: Error in the push function.
qemu-system-x86_64: Failed to connect to '127.0.0.1:23083': Address
already in use
qemu-system-x86_64: TLS handshake failed: Error in the push function.
qemu-system-x86_64: TLS handshake failed: Error in the push function.
qemu-system-x86_64: TLS handshake failed: Error in the push function.
qemu-system-x86_64: TLS handshake failed: Error in the push function.
**
ERROR:../src/tests/qtest/migration-helpers.c:180:check_migration_status:
assertion failed (current_status !=3D "failed"): ("failed" !=3D "failed")
qemu-system-x86_64: TLS handshake failed: Error in the push function.

(test program exited with status code -6)


thanks
-- PMM


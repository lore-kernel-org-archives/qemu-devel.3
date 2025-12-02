Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC17D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOyr-00043V-VP; Tue, 02 Dec 2025 06:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQOyq-00043A-T1
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:55:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQOyp-0003lA-1U
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:55:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso60834775e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676536; x=1765281336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac12UTCXddYOL6CDSST5F2w3W/OzSVPul3qZ3ssgm1E=;
 b=r9I+6+QDDV1VD2LBvulT+WIy6r6SEablpg77n2CI9vcMYVNzeOKBYiysL1bJpQaI1l
 EnkxO9o9iK4wT7GAYQ+d1FaVmrukBmuWpv9WrdtuUsDsW0ccUl3gob5eNUV8he02emQS
 ngcjMuO2mmg2r3xnGsXdJhDc/+OFVGnM4svtr0n3qAdILARQzuE5KXts+SzrD2PMstIG
 9qYINfCcyJeCxTdfqzYzEyXsQFmFKLWv78RlJBWmltr1JI8pSz5DPOeSBJARSWHyWV87
 KjndusWSoy7eIdMoLOmvYprqwcfp7apOoFsT2wcfgy1wVUn/AjYjhYx2GFw2Dca6JWLo
 MwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676536; x=1765281336;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ac12UTCXddYOL6CDSST5F2w3W/OzSVPul3qZ3ssgm1E=;
 b=aT5fC812z0ixSgF4G+VgRx5eLLeokWjDizBjEM6Jneso0j+ts+IZqWwgqa5SzSRy9E
 ccO/qdfDmHBsiiR+whwzlDUXl89ka/JuL4l6gVED3ZeqOBenClqMXjZn6sUTSrrw5oJA
 cMN2/zXNViH9mc1y+kgHAk+qjMKOGIDUF9qbYvwQtmlaN30dQY2YKgs54r8IsQD8vdtt
 PnXOtCIU+tDB2JmhKH84ewXJm69wTaf6pNPC2cT71pckDcqqbtxSjfKQlRwVxFcZjqNB
 bGoTooUNFpznWCh2U0QuyIMcSCSFzhSeBQm/dxNzFA1SJsG11FPPGhtCnx+RcUHK/Xxj
 iYGw==
X-Gm-Message-State: AOJu0Yz+qg+AEqLtNvfsuKE27h/t05Khlw1OS+uyEdc460TE+TXKhJ1Y
 OoohPm09jUl1tJIo5NWW3zcjgGZ6Zg/Cb3Jm8qtAbaTeVDucj42GJ/RtJkbLKIoAeos=
X-Gm-Gg: ASbGncuz8qhfhjnZkJSdBtRbZJjyVdvks+dIqUZw/MpT50kYAqASO/PVU9l/3qE5UEA
 H+/RGTZQWiL0KRCGZ1/JoQFFs8LX7Yb3tKlQQV7ztjhpTpSY1V9EddDcsYw1ZK74QXJLwo85okH
 HcyvQW8qeuE6VwpywCwE7XrFnM3otl03wRb8yI8Yj7GlIBZFhFd/A0/vLI+Oqv0xcwwEN9bfE9t
 4LsrsgiSNUShTFR9MAThKdiAwV6qhBU2T/Bsr88rms0x/+lmqUXiOYyo/fkWsIaR0CkSirOe7wB
 iLRaiBsR/H6TzF2nIwamFU+ZG0PXKul6bf3lcKbQQiEbBRn3hY+o2mgHZwkUTCBM/dCrcSifZrw
 ibh2bixNSsudmFCsS7vWh+FwZWNDr3gUXmx4PWZj19I1ZkxXFDaYu/EKIZn9qdApsa6vWth0KTH
 kfFJyWOe7dBfA=
X-Google-Smtp-Source: AGHT+IFCDUDThLkYUY58RB5NIFQ+i/1gJumvkiKGE0dlR+VpXu9YgFQ3OeNEFoAXZnDfnu8F+SbYWg==
X-Received: by 2002:a05:600c:3ba1:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-477c11160cdmr443420645e9.22.1764676536236; 
 Tue, 02 Dec 2025 03:55:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47927a1944esm13607495e9.5.2025.12.02.03.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 03:55:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A3655F7C3;
 Tue, 02 Dec 2025 11:55:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH 0/2] TCI fixes
In-Reply-To: <20251202011228.503007-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 1 Dec 2025 17:12:25 -0800")
References: <20251202011228.503007-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 02 Dec 2025 11:55:34 +0000
Message-ID: <874iq9umh5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The first patch fixes an abort running qemu-system-riscv64 with tci.
> The second patch fixes a make check failure Alex noted vs ppc32.

Well these now work thanks:


/pyvenv/bin/meson test qtest-ppc/prom-env-test qtest-ppc/boot-serial-test q=
test-sparc/prom-env-test qtest-sparc/boot-serial-test
ninja: Entering directory `/home/alex/lsrc/qemu.git/builds/tci'
[1/9] Generating qemu-version.h with a custom command (wrapped by meson to =
capture output)
1/4 qemu:qtest+qtest-ppc / qtest-ppc/prom-env-test               OK        =
       9.75s   2 subtests passed
2/4 qemu:qtest+qtest-ppc / qtest-ppc/boot-serial-test            OK        =
      13.80s   5 subtests passed
3/4 qemu:qtest+qtest-sparc / qtest-sparc/boot-serial-test        OK        =
      22.36s   3 subtests passed
4/4 qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test           OK26.63s  =
 3 subtests passed

So have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.

>
> r~
>
> Richard Henderson (2):
>   tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
>   tcg: Zero extend 32-bit addresses for TCI
>
>  tcg/tcg-op-ldst.c            | 222 +++++++++++++++++------------------
>  tcg/tci.c                    |  19 +++
>  tcg/tci/tcg-target-opc.h.inc |   2 +
>  tcg/tci/tcg-target.c.inc     |  14 ++-
>  4 files changed, 140 insertions(+), 117 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A933CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbvW-0007PS-LI; Mon, 08 Jun 2026 11:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWbvO-0007Kc-GK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:30:02 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWbvM-0001or-93
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:30:02 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660e9fe3c3aso2052567d50.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932599; cv=none;
 d=google.com; s=arc-20240605;
 b=KlZU2f/6Tdd4o2O69GtcOo5iJang1xhC0K89rodR9h28sh4JlP1dIwiPlJeJM8KD7F
 TL8DGlx7vGNg66rEtRLlhagOtiH63kiryoobSQpBGROb2Uf2xV9JRuZii7DQn/L7V1Yu
 LeJlRLZhH5/+sbORaS1nkkPCxoNh/WMOoUxP/z3eqV04qtMwSrnBbOgeVv+einEIsY7d
 Jwmtyc6+bJMOsLhs2UnD1kxD1EQZsWAZ3FzNEfh7DeRK635QScQl/cly93TB+MudTvXn
 fZ19A4wHp0KH5sJ9rDIrZQoWvqqHNyOqBxE3vQuIlkBgqFzWrtOhJM+6ArAIZk7JBp8w
 J0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0CoVzQ4m1dRXDzC/qP0v4XMrwqdRUgDDiAFqTXZnByg=;
 fh=DicXIikCBABaEawXujt0nHn0nx5T4c9/NfNuW1VKzPc=;
 b=ge+2qoLBvSUy5Lww0H4dU7rzSmJ5y5t2SvSrSbsCYHrWrSxvm/nktndLvH/DteC6Hb
 zwQviOwnptNcpWT7R7v/wacOngolzFcXmP1dFndfdv8XyuHPzYkSwLfUUSQ46Oa3gN96
 MRObuqvQD2IJqvi0FxWMCmvnMhx1lKXAraNihDdOvDaO1YiFmDf3+JgCgw+rNrveIR74
 jNIDCILLBDt9R/FrpEjttzwKhGciAZJ6JeYelxNaE98nDD7087FMaQntpRuyMoODnopU
 gwgjcvhUBcjx8X3CFjnkY+4FfeNpcMCztQVHOnEZCU/K+sA/kBswDRWph/SK0OeJ2pUm
 b6ZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780932599; x=1781537399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0CoVzQ4m1dRXDzC/qP0v4XMrwqdRUgDDiAFqTXZnByg=;
 b=UM/BcKUCJX68ys1JbKwu1wFXsXM0TYUt35o/BUYbPoLg4Y6FOgqFgF8ZWwCdUsXTP/
 FMmN1ccx1j5orqUiU18M2fhnMFqeUlbMSIl8U1UAue8cABEXkVePcgpDP5hwlr+CH0I3
 7PGTjOEnWvkufdkrM/2o7uOx87WnKTmtJyppjkjqe5dDU8+yH7waFs81KVwm3MQ0DXRA
 EtVyd1jA/o2DIJQsDLOHZ+vlvsBmAdj68jm1fl/wDcSdzoIc7EUmvCHFLX8qGFhfi9Tj
 2g4mfWK+GVasr2UFIbb/p7Y/Piay3/z1Tm/2ACi2orhbGG+HKOGydyefXiu5LlY9dAmN
 sYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780932599; x=1781537399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CoVzQ4m1dRXDzC/qP0v4XMrwqdRUgDDiAFqTXZnByg=;
 b=tGJ0KcPMoPsJhAqBgh/Oo62tcl4ldmOToX2v8nT7tGACYjspd0O8NIeAdhXx009D85
 Ailm7EBaYqV4LsM5/l2PFA5r7rwnFUac0wlFJbPvB8TMkrL0cDDxnBYOM3e8hNaHKUVv
 lER4EI4rm5+Z+yK1nivhTQhOGHKdBEdzhv7yc1uI9gSJjGXIRi5HX5u7QUvL2LGcYW6T
 lKdv56UauDWs2UyfV9K9ce5AMM3Idt4EkqUu6C2MuCOQIgoicVaA5PfpB0O2tZBE6NOS
 n+EjBumy3ifHy3JGIaoX5X607K2C62ETCbAt5S5dm10ONrIHEHcEVVf3ZjjCzbqbmWvV
 X00Q==
X-Gm-Message-State: AOJu0YwqCNoh6Xrs+RoUxE+PEZch75mYaOJugkfxU81/kCUCYORp4fM9
 eKOFdPHALyThbQN97fwd1e7LAuNpgQ6aCa2fVAc68p1qUNmAL3AX2ZGCA3Qq5fDDibio6qLsNb1
 vYtm2Cf42sxxAG9XT3+VQVtCjakfZdP6lfYlvY/m6zA==
X-Gm-Gg: Acq92OFmvk6FHWEax3uJINfv8PNb8Jbhy1PfakcxMSFqTe3S2P6uYNxt48bIxFucVe1
 JdNjuHUukS8KljYe66qJMdgxIpXTKPd2tfLZ4wBgAcmpCpUIcBhKdq94cc63eCZ1H3Ia02ChuwW
 AYpiHOKjRFZj/PQEtoIy4hbp9ZYdj5JKhSCDX3pu/+O7YfkoZrxbvvXrJ+ang14jSVxsJDUyUmq
 qMv8m68MkeOwZ+aEuaD9Bf5xVd9ni+R6SFvlhcfq0lwP5zr+QpS43JejQNYsnH3H6sqVCLQoS8c
 sHrZS1YYgeYO/3bTojFARW29K6gPwgjkMS+9XMdU/roL/v9il/Uc5MKjs5RiCZAHMi06Epl+9xH
 LBw==
X-Received: by 2002:a05:690e:1448:b0:660:a41d:d180 with SMTP id
 956f58d0204a3-66106f255bfmr13918592d50.21.1780932598781; Mon, 08 Jun 2026
 08:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
In-Reply-To: <20260608-testing-macos-v1-1-42774498936f@meta.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:29:47 +0100
X-Gm-Features: AVVi8CcWgXj4R9xyiwCRJgDzLiI9aRdhgdCNLup4t2yGHnic_eDrvV40ZneqEe4
Message-ID: <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: Emmanuel Blot <eblot@meta.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 8 Jun 2026 at 16:25, Emmanuel Blot <eblot@meta.com> wrote:
>
> On macOS, plain QEMU binaries are named qemu-system-<arch>-unsigned.
>
> In libqtest, qtest_get_arch() extracts the architecture by splitting
> after "-system-", which yields "arm-unsigned" instead of "arm".  This
> prevents the QOS graph from matching any machine node, causing all
> QOS-based tests to be silently skipped.
>
> In the functional test framework, the same suffix causes the arch to
> be parsed as "unsigned", leading to wrong output directories and
> teardown failures.
>
> Strip the "-unsigned" suffix on both code paths.
>
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
> Address issues with liqtest and functional test framework when run from
> a macOS host.
>
> Unsigned binaries on macOS may be appended an `-unsigned` suffix, which
> confuse these components that rely on the binary name to recover the
> guest architecture.

I still think this not the right thing to do. The "make" process
on macos should produce and sign the binary in-place in the
build tree, so that users and test cases don't have to care
about this macos specific weirdness. (If the signing is
location-specific and we need to sign again for "make install"
that's fine. But we should produce a working binary with the
usual name in the build tree, not a non-working one or one with a
nonstandard name.)

See also this earlier thread:
https://lore.kernel.org/qemu-devel/CAFEAcA_txOHPLK+J546yjCmOEv0-ptaVkCEk5GfeL13DdqQd-w@mail.gmail.com/

thanks
-- PMM


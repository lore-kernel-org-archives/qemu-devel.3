Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7937C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJBj-0006qQ-9A; Tue, 06 May 2025 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJBh-0006pk-LX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:22:25 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJBf-0007O6-IA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:22:25 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-708a853c362so51203707b3.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541342; x=1747146142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64Rnz8AtchK5mAHs45/m7F6frCvc++RT+Fb+aXU37TA=;
 b=fL4YA10d2OoHjs7tQGAEdJ7Je23GjAcsJhy+2RIENH/XxSqaUQrrhIjl+b32q1u6m5
 Ba/4ODhbYpsZ0JH2gCyqimxhdy6uUUbbTD3be3KDbv0HrHUdKwFz6DeWYLK9fkUeqDBa
 TTzuS38oRu5Vh9SiOmhoIn7HvN4OR77vv1ZGxaKg5MT/bdBI6qCIw6n1Rnlaq0E4Gzz2
 p/qAKAXxd+ULMgQdq6GMO2NVnp34RrcIhf+vBsDuAq4kUt7hsnpbHMQWr7fGlG4yGtx4
 ebb3Mb373CmWUW/ZXEaZd4n6oXdnV6444W3UGCFpxlxQB28BV/Wr5F/Ry0U8kcr/ltxo
 CLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541342; x=1747146142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64Rnz8AtchK5mAHs45/m7F6frCvc++RT+Fb+aXU37TA=;
 b=AHgFmjKw3/LhnX2F203EAKFnXUOHDMUJlrnBRRumUwEog5cmHAG34ey9rHQRpn7hZS
 1ZezcA6Ke7tTTUrP60xR7f3t0cf2DfYoV+olsba3vcbfEWNZbH0RuVX739OQsRwwp/tn
 k1lwZ13HpHPRV096duqav/VqGfZ0dD+fAkoC7BJQ1LIwEIDmQND1oAOH0WCWjcsnLvfo
 AfqKAxwKOn5lencc/RudNox6Z9BdskBSVtXzn4q+CggXJ0korhhXrVXst4eakdsqINPc
 W47gjLmJRyFt63CuuBe+HvwPUgK2ReOtfjE8loFVfRwtJzWkah9P+R5OyweyAtWWn2OM
 S8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+Q3uMA0bot3SKQJ747Lc6Wz/HVal3iWbMKVKNKMJ+WH8MaPbloTMX887UXXVWwKcL/oXQ0jtZF1e@nongnu.org
X-Gm-Message-State: AOJu0Yw1t1OGHZMSlskVn8OHWQEtGQkmxhk+coqI+qhpPIyC3SJ4AqTy
 D/cABNmUL5/QcOcX3suSHcaQBwSNKuVgrExWffu/RXCreRJwm91xlr6jDzJAUk7bRBDKGPixoOE
 23OMQQCT7fjK3zqQs9y1XiUMRuS8Z+L8HrgNvRA==
X-Gm-Gg: ASbGnctGnTEquI9MhA2ZHiYDrTfszqVzXmPEsl1iFLv+T2J/gPBjPgIbRnjd0VT4SUP
 hFecUchj94P+vDXKghuKi4NjSWGn+pY6Q3iXVSOgyAuFi4ksV78ypoCRlJYSQOHPITPcRpQewWM
 jKhELVuKBAbn8pVw87NA93E5I=
X-Google-Smtp-Source: AGHT+IHV37rxY4DxdmcojUEYHteiTtzIypDQbyFCQou3QAzTMtYEKDU5Rti50v8YKlJCG1Km/qVJyQRuPIXtTlEQZiw=
X-Received: by 2002:a05:690c:62c4:b0:6fe:c803:b471 with SMTP id
 00721157ae682-70919c48b14mr48462687b3.16.1746541341783; Tue, 06 May 2025
 07:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
In-Reply-To: <20250505090635.778785-23-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 15:22:09 +0100
X-Gm-Features: ATxdqUF8rVeFBKjoziXfEyTHC2du38Wk199AYHqKl3AJmkbrTmojp2bxdCqWoF8
Message-ID: <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
Subject: Re: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 5 May 2025 at 10:12, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> From: Steven Lee <steven_lee@aspeedtech.com>
>
> Introduce a new test suite for ast2700fc machine.
> Rename the original test_aarch64_aspeed.py to
> test_aarch64_aspeed_ast2700.py.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I3855f55c9f6e5cca1270c179445f549f8d81f36c
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250505030618.3612042-1-steven_=
lee@aspeedtech.com
> [ clg: Added new tests in meson.build ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Hi; this new test seems to trigger an error in a clang-sanitizer
build; would you mind having a look?

 Output: qemu-system-aarch64: warning: hub port hub0port0 has no peer
qemu-system-aarch64: warning: hub 0 with no nics
qemu-system-aarch64: warning: netdev hub0port0 has no peer
qemu-system-aarch64: warning: nic ftgmac100.0 has no peer
qemu-system-aarch64: warning: nic ftgmac100.1 has no peer
qemu-system-aarch64: warning: nic ftgmac100.2 has no peer
qemu-system-aarch64: warning: requested NIC (#net038, model
unspecified) was not created (not supported by this machine?)
../../system/memory.c:2798:27: runtime error: null pointer passed as
argument 2, which is declared to never be null
/usr/include/stdlib.h:962:6: note: nonnull attribute specified here
    #0 0x617e4121b113 in flatview_lookup
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:2798:12
    #1 0x617e4121b113 in memory_region_find_rcu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:2833:10
    #2 0x617e4121a5a9 in memory_region_find
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mem=
ory.c:2860:11
    #3 0x617e411c21ea in rom_check_and_register_reset
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/lo=
ader.c:1317:19
    #4 0x617e411d5ec7 in qdev_machine_creation_done
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/ma=
chine.c:1756:9
    #5 0x617e403d4877 in qemu_machine_creation_done
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.=
c:2782:5
    #6 0x617e403d4877 in qmp_x_exit_preconfig
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.=
c:2810:10
    #7 0x617e403d9a3c in qemu_init
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.=
c:3844:9
    #8 0x617e41301126 in main
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/mai=
n.c:71:5
    #9 0x7faf8202a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #10 0x7faf8202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #11 0x617e3f920654 in _start
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aar=
ch64+0x161d654)
(BuildId: f3f8c2ca821e695937a615bee293c4a5a336a6bd)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../system/memory.c:2798:27


thanks
-- PMM


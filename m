Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591AEC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 09:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ90E-000878-VY; Mon, 17 Jun 2024 05:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ90D-00086t-Bn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:50:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJ90B-00034F-Hu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:50:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35f1691b18fso3298935f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718617814; x=1719222614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8FE70kgeh4OkrneOLHy165B7UwSvv/oNFSmQCf3r6Uo=;
 b=h6KgPqWLvT/JxH4qC8to20kP8yIr85j1Ze/qxWi6Sn+d+rBr0qe+lNA/lnuFzWZI+p
 WytC/Qa9GS+cxV073OBTs2zDSV1NRxsCM9WLUTjLyZuLeQxd4eaoxGbUD8ApNIG487f1
 k/HDzueiKcPS6kDJ1Jr76/7k30yvzlna1hP8L4pJEcBsrP684MFZD0aZN6sKAqdtnm4K
 CcPKRtsZmoA+DmXmjdEl9BNnsm6zIVhgPgIXvhcYI8B84Z87WOZI2j5B/ypGPnwNl5Jb
 orbp+r69iSdUE0onEvtyLOG1XiCZq1Sj2oMAT5FiV5HTJ5/CK96AmX7QuY9ibFRGeimz
 nk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718617814; x=1719222614;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FE70kgeh4OkrneOLHy165B7UwSvv/oNFSmQCf3r6Uo=;
 b=L36rSMcSmvtqlAi9OvsDtzow41ddC6hKpnVaTNksWpL+XEeQwHyS2QoBcbeNhR90rc
 qeOaqHleXBT12z8FZJ1sedxlf1L/WKmgtpH8u4/K9i9hhbYu6prm9crLS7vU/JP/a9GK
 40xYg3QQG+KfYeaaKaDsyPXbxBpxtM96KpS1/9c5GL41NW8yL+/B15soNYWJJ0FwPA1h
 IjbMwxvhTrgDxVi1XRvu/ZObAm1jxceQJ3PDJIyD5vcl/1pakksCV0k6UFAxxrLit3/4
 sH2rdrW79gBGidp77ZSSgqFOe/b77DZao40gzmW8t5Ocvf2FzCP1+2rqT0b6otPH7Ifr
 rxfw==
X-Gm-Message-State: AOJu0Yy9icIYWAdVW6pIDnK8MUWpZtSSqSbHmHIfyoznoov71McCwknF
 LSagXJaGSS3zGMB3c0A2fUdVbsFReEmUD2OZ18UQKU3PpHiSugWdyziBYQdL5TQ=
X-Google-Smtp-Source: AGHT+IFvCT+Vv8GSoAsbJD01P3kQ/1wE52U+K1Kl8JWa1UDPzH9mDb/LaabVHd+s4ovZDKCTXhL4ZA==
X-Received: by 2002:adf:e84b:0:b0:35f:1ed8:37ee with SMTP id
 ffacd0b85a97d-3607a7b0fd6mr6298830f8f.9.1718617813752; 
 Mon, 17 Jun 2024 02:50:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f23cdsm11552798f8f.77.2024.06.17.02.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 02:50:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B72F15F78B;
 Mon, 17 Jun 2024 10:50:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
In-Reply-To: <29b9c8e6-055d-f895-f178-dddd407bdc69@linaro.org> (Gustavo
 Romero's message of "Mon, 17 Jun 2024 04:02:13 -0300")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <87ed8zttge.fsf@draig.linaro.org>
 <29b9c8e6-055d-f895-f178-dddd407bdc69@linaro.org>
Date: Mon, 17 Jun 2024 10:50:12 +0100
Message-ID: <87h6drew4r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 6/14/24 12:49 PM, Alex Benn=C3=A9e wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>=20
>>> This patchset adds the stubs necessary to support GDB memory tagging
>>> commands on QEMU aarch64 user mode.
>>>
>>> These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
>>> packets, which allow GDB memory tagging subcommands 'check',
>>> 'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
>>> memory tagging commands ('print-logical-tag' and 'with-logical-tag')
>>> will also work, but they don't rely on any stub because they perform
>>> local operations.
>>>
>>> Since the memory tagging stubs are not common to all architectures, this
>>> patchset also introduces three functions: gdb_extend_qsupported_feature=
s,
>>> gdb_extend_query_table, and gdb_extend_set_table. These functions can be
>>> used to extend the target-specific 'qSupported' feature string and the
>>> handlers for the 'q' (query) and 'Q' (set) packets. These new functions
>>> are used to add the MTE stubs for the aarch64 gdbstub.
>>>   Note that this patchset requires a GDB that supports the
>>> qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
>>> tests introduced by it must be run using GDB's master branch, since the
>>> GDB in the distros hasn't picked up the change yet.
>>>
>>> Once GDB is built and installed locally, the tests can be exercised, for
>>> example, this way:
>>>
>>> make GDB=3D~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32
>> It looks like there might be some BSD build failures as well:
>>    https://gitlab.com/stsquad/qemu/-/pipelines/1332635371/failures
>
> I fixed the build for the BSD target in v3, however I think that the GDB =
in
> the test containers need to be bumped to GDB 15 so the MTE tests can pass,
> because support for IsAddressTagged packet is necessary. GDB 15 branch
> is created by it's not released yet, so I don't know to proceed..

Two potential approaches, you could extend the configure segment:

if test -n "$gdb_bin"; then
    gdb_version=3D$($gdb_bin --version | head -n 1)
    if version_ge ${gdb_version##* } 9.1; then
        gdb_arches=3D$($python "$source_path/scripts/probe-gdb-support.py" =
$gdb_bin)
    else
        gdb_bin=3D""
    fi
fi

and set a variable exported to config-host.mak to then test in the tcg
test makefiles.

Or you could implement a gdb-version-test command in
tests/tcg/Makefile.target which you could use like the existing
cc-test/cc-option commands to extend config-cc.mak and use that to gate
the tests.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


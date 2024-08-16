Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2FBC5472D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewT6-0003XU-NC; Fri, 16 Aug 2024 08:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewT5-0003Wu-6N
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:54:11 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewT3-0003CZ-7J
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:54:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef2c56d9dcso24356021fa.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723812847; x=1724417647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qPw2LFYVBp8naoRU6cpLZ9ldMf9dHXLYYquXiShw6RQ=;
 b=J0P57QyhYgwwNmq50yJpyGFIJFO7Zgo/LmUzhDLl1GIx0AU2dVp0pm+G2CJMXDAG38
 tU9Q+kNuQmPUrm3sbkn0LZHS0J7ckVH037J3vhipEzc5PhGVkeev/Bn/7RvGO+Q9CekN
 ZYdaffj+OvMGpbcNdYlA1Iu7050L6TszXtxH+lRu4ksQqrnB/UAvRHHCzt2eKqhUp53o
 YlUgxFFjbL/yU/7QBGcSlLJVvRJGPo2mNgC3l93Jmt7b2m64Tw8uRG5udmqVGbi+LbfH
 DKPZF0NH3D9qH7LNgh6ho/+xDHbLFNeqlXZbfUadjGNm4jojiJj2zKleiG275j95Oe7q
 hP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723812847; x=1724417647;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPw2LFYVBp8naoRU6cpLZ9ldMf9dHXLYYquXiShw6RQ=;
 b=ltkoGldfeIDJ/q2YuFbclSMfAOCzXguI50FHeklRNIghjoNrzzS1HKb+tYEJ9PeWLu
 mmxEpQZFlTE8SN+TnjT9C5E2jCyzwyVSRr66h2uW9+/xFJYV9AnZhYI8JgDdvihwKDHI
 6w8PkFYkm++QPcKUy6k0bF40C7FaUQSZPou9/zx6epjN5Dw9JDK+7fskpDoeRwEiULyB
 eGywlIsASMfmyQkRV31yIfiE3VOwoStZdzUz9tpvzWJPhmvcfReaU6atSyw1KV2xxwQl
 6Eykd4KJu+DmdwMsGVEwYgno0d2dn/HveA1ERucMAp60k+CsWGNua601XWxGifc6q3cC
 2Q7Q==
X-Gm-Message-State: AOJu0Yw0/6eNVXFcAAQGbj/Fw5KkG0qszrxu6RjMVpD33CRF9tOepjGK
 wjHlnTmv3l4kZXrblopBelaLlft8lliTJZPeEbl2LVCBe32ULsXtzy6KwAx33EAWomTT3utPVMz
 z
X-Google-Smtp-Source: AGHT+IF5fTpltqD0Q/UcxJO1v9Evf6df0UEGk0kIil/5aw4YebxQusbSElbTHq53elprVe1S/QTUnw==
X-Received: by 2002:a05:6512:ea7:b0:52c:8e00:486a with SMTP id
 2adb3069b0e04-5331c6e94afmr1895418e87.55.1723812846544; 
 Fri, 16 Aug 2024 05:54:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cf03csm250528866b.50.2024.08.16.05.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 05:54:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A34D5F867;
 Fri, 16 Aug 2024 13:54:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay,
 docs, plugins)
In-Reply-To: <f0f5f04b-9ffa-46ad-bb2a-a497de3c1c41@linaro.org> (Richard
 Henderson's message of "Fri, 16 Aug 2024 08:28:33 +1000")
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
 <f0f5f04b-9ffa-46ad-bb2a-a497de3c1c41@linaro.org>
Date: Fri, 16 Aug 2024 13:54:05 +0100
Message-ID: <878qww39xu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/16/24 00:48, Alex Benn=C3=A9e wrote:
>> The following changes since commit b0d6c037ea0a825192285f149af72a73a1baa=
a04:
>>    Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)
>> are available in the Git repository at:
>>    https://gitlab.com/stsquad/qemu.git
>> tags/pull-maintainer-9.1-rc3-150824-1
>> for you to fetch changes up to
>> f39cbfc9f8dcb17e8168735acb6fb75638d9904f:
>>    plugins: fix race condition with scoreboards (2024-08-15 12:10:23
>> +0100)
>> ----------------------------------------------------------------
>> Some fixes for 9.1-rc3 (build, replay, docs, plugins)
>>    - re-enable gdbsim-r5f562n8 test
>>    - ensure updates to python deps re-trigger configure
>>    - tweak configure detection of GDB MTE support
>>    - make checkpatch emit more warnings on updating headers
>>    - allow i386 access_ptr to force slow path for plugins
>>    - fixe some replay regressions
>>    - update the replay-dump tool
>>    - better handle muxed chardev during replay
>>    - clean up TCG plugins docs to mention scoreboards
>>    - fix plugin scoreboard race condition
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (2):
>>        Makefile: trigger re-configure on updated pythondeps
>>        target/i386: allow access_ptr to force slow path on failed probe
>> Gustavo Romero (3):
>>        configure: Fix arch detection for GDB_HAS_MTE
>>        configure: Avoid use of param. expansion when using gdb_version
>>        configure: Fix GDB version detection for GDB_HAS_MTE
>> Nicholas Piggin (10):
>>        scripts/replay-dump.py: Update to current rr record format
>>        scripts/replay-dump.py: rejig decoders in event number order
>>        tests/avocado: excercise scripts/replay-dump.py in replay tests
>>        replay: allow runstate shutdown->running when replaying trace
>>        Revert "replay: stop us hanging in rr_wait_io_event"
>>        tests/avocado: replay_kernel.py add x86-64 q35 machine test
>>        chardev: set record/replay on the base device of a muxed device
>>        virtio-net: Use replay_schedule_bh_event for bhs that affect mach=
ine state
>>        virtio-net: Use virtual time for RSC timers
>>        savevm: Fix load_snapshot error path crash
>> Philippe Mathieu-Daud=C3=A9 (2):
>>        tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
>>        buildsys: Fix building without plugins on Darwin
>> Pierrick Bouvier (2):
>>        docs/devel: update tcg-plugins page
>>        plugins: fix race condition with scoreboards
>> Stefan Weil (1):
>>        docs: Fix some typos (found by typos) and grammar issues
>
> Patch 19:
>
> ERROR: pull request includes commits attributed to list

What does that actually mean?

> Please re-spin.

Should I just drop Stefan's doc tweaks?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDAFC61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 15:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNvjC-0006ZH-5o; Sat, 07 Jun 2025 11:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNvj4-0006Yl-D6
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:44:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNvj0-0007JD-VU
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:44:53 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad89ee255easo544460266b.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749311089; x=1749915889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywTH7+PnQIJ+KKYk8yTe3lNMGMWCZ5XioAyiMaOMghg=;
 b=A6oVFCyVTOJzjR/I06c2JPwscHjg2EoNas4GnUx7zm77HDEQCMOpMfn6j7mvv4uJXb
 zMAlxZ0AlMxcZxF1upCrKEGPuZFs4ww5sbkoMSugFXLzn4qeYH70M93LFrdSqWH9BtrQ
 8JJRMf3vGbTQz8e6lO73g8DjUDYvKdY0zKV4V9thQAco97BYmgC2ZnyL+5utzyBhBv6j
 nHAAJ1nN7HAeHgjG/5X8N/JPfbnH4vYA02IwTKDXX37zdLWghQMbRAMIovxLwUyrr3bv
 UjoSW72xV6IAvOx30NFGJuoBfBsCbp20W2bPVhuE3yHkP0jTw+/vtILtjV5szDqVg/eF
 rGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749311089; x=1749915889;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ywTH7+PnQIJ+KKYk8yTe3lNMGMWCZ5XioAyiMaOMghg=;
 b=f72CBX5kYVPZ0zqaBRUFaEu6zCcgs/B9ZuU/UDixHYKYQBulaOQBy+rUtlPxzPRHbP
 3g5waAI/8I0u85p69+HqAeXJXcKkVppNTU3NPuYPVnL06bUU9zKsVA7Ry/sxeTAldg7C
 qbuk6xMKuI2BKVMkN2NlXy6QZTPCRIcPGdV/XeLHe9gopyRIZKqoLJaVgr3XHLXPVqlp
 ggF8siY4Rl9Ei9jWa11x7UK4l75iPDSKohQ0125ucZ/YAnJfqFxYz4cpo44Xv85sslNe
 y8o5zj12YuyLFwoGJbX1mK+EPcPwZmJ0GzZHo2lk5sjkYp49ho5X3aamlITsx/sJSEVs
 Q+Yw==
X-Gm-Message-State: AOJu0YyEDwaAbWOrsW6STZxVafwLLTVaYBkZ3enZxqaaklq7qPewEn+H
 0ctxHxpWzuTVvbZYeQqhJnxY0ZvRtzwR7d44lys4DpINO4RlbLzb0+1vOtAdwJmz1fk08ls3Ipp
 wZvcau3g=
X-Gm-Gg: ASbGncsP8NFUT9dYKQZKcfH56BVxei/koOSXLTn7ZJ9cyOLMtUm9AdfRTwGYPRfCvoF
 yB8msf/5G9Wb4wNscz6oiM+Je4zA+mCgJ876EQm6mQNFCbYDmVbpLzCi6ZBdzmQSjH69A1jSs42
 BTev6E8BeofQ9F6mv2dXBjn7VOwZ18ECk8FDQYQXOZcMpbIoG1H833x4tD9DzrQAARbSNn1XO/s
 4Kh7zUvpNvf8JrdiH8OkVScW1N3ij1qilp+4mb52W27kduhjMEd5QMMEMwzO6MWRSSYcWGMpIUL
 Q8d1JgIundiz0lQjowhvoH2WzHDqVhyScnM0ge81WxKEwFQV0YPQ
X-Google-Smtp-Source: AGHT+IHes8spsaH4r8a5oCK0Ttip4rC0NArSP3iBntn8bahSniy8PNxAHLkdeR+AYXglF3Tuy/kFww==
X-Received: by 2002:a17:907:2d92:b0:ad8:9ff4:c047 with SMTP id
 a640c23a62f3a-ade1a922afbmr653959766b.35.1749311076159; 
 Sat, 07 Jun 2025 08:44:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc3902csm286883966b.125.2025.06.07.08.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 08:44:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 318975F86B;
 Sat, 07 Jun 2025 16:44:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] maintainer updates for May (testing, plugins,
 virtio-gpu)
In-Reply-To: <CAJSP0QX9-DAzHSsG=aE53=BafmsF2a40toQivAmyOdhWF4aDxQ@mail.gmail.com>
 (Stefan Hajnoczi's message of "Fri, 6 Jun 2025 09:45:14 -0400")
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <CAJSP0QX9-DAzHSsG=aE53=BafmsF2a40toQivAmyOdhWF4aDxQ@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Sat, 07 Jun 2025 16:44:34 +0100
Message-ID: <87wm9n8skd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, Jun 5, 2025 at 12:28=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> The following changes since commit 09be8a511a2e278b45729d7b065d30c68dd69=
9d0:
>>
>>   Merge tag 'pull-qapi-2025-06-03' of https://repo.or.cz/qemu/armbru int=
o staging (2025-06-03 09:19:26 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-may-2025=
-050625-1
>>
>> for you to fetch changes up to 66835968ca7246d385218be9776a80a5136563b7:
>>
>>   gdbstub: update aarch64-core.xml (2025-06-05 13:47:37 +0100)
>
> I will wait for the discussion to reach a conclusion before merging
> this pull request.

I've dropped the virtio-gpu/next bits and sent v2.

>
> Stefan
>
>>
>> ----------------------------------------------------------------
>> Maintainer updates for May 2025:
>>
>>   - expose ~/.cache/qemu to container builds
>>   - disable debug info in CI
>>   - allow boot.S to handle target el mode selection
>>   - new arguments for ips plugin
>>   - update virtio-gpu MAINTAINERS
>>   - re-factoring of blob MemoryRegion handling
>>   - remove extra draw call causing corruption
>>   - support Venus fence contexts
>>   - cleanup assets in size_memop
>>   - fix include guard in gdbstub
>>   - introduce qGDBServerVersion gdbstub query
>>   - update gdb aarch64-core.xml to support bitfields
>>
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (11):
>>       tests/docker: expose $HOME/.cache/qemu as docker volume
>>       gitlab: disable debug info on CI builds
>>       tests/tcg: make aarch64 boot.S handle different starting modes
>>       contrib/plugins: add a scaling factor to the ips arg
>>       contrib/plugins: allow setting of instructions per quantum
>>       MAINTAINERS: add myself to virtio-gpu for Odd Fixes
>>       MAINTAINERS: add Akihiko and Dmitry as reviewers
>>       hw/display: re-arrange memory region tracking
>>       include/exec: fix assert in size_memop
>>       include/gdbstub: fix include guard in commands.h
>>       gdbstub: assert earlier in handle_read_all_regs
>>
>> Dominik 'Disconnect3d' Czarnota (1):
>>       gdbstub: Implement qGDBServerVersion packet
>>
>> Dongwon Kim (1):
>>       ui/gtk-gl-area: Remove extra draw call in refresh
>>
>> Manos Pitsidianakis (2):
>>       virtio-gpu: refactor async blob unmapping
>>       gdbstub: update aarch64-core.xml
>>
>> Nabih Estefan (1):
>>       tests/qtest: Avoid unaligned access in IGB test
>>
>> Yiwei Zhang (1):
>>       virtio-gpu: support context init multiple timeline
>>
>>  MAINTAINERS                               |   5 +-
>>  docs/about/emulation.rst                  |   4 +
>>  include/exec/memop.h                      |   4 +-
>>  include/gdbstub/commands.h                |   2 +-
>>  include/system/memory.h                   |   1 +
>>  contrib/plugins/ips.c                     |  49 ++++++++-
>>  gdbstub/gdbstub.c                         |  19 +++-
>>  hw/display/virtio-gpu-virgl.c             | 102 +++++++++++++-----
>>  tests/qtest/libqos/igb.c                  |   4 +-
>>  ui/gtk-gl-area.c                          |   1 -
>>  .gitlab-ci.d/buildtest-template.yml       |   1 +
>>  gdb-xml/aarch64-core.xml                  |  52 ++++++++-
>>  tests/docker/Makefile.include             |  10 +-
>>  tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>>  tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++++=
++++++-
>>  15 files changed, 382 insertions(+), 47 deletions(-)
>>
>> --
>> 2.47.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


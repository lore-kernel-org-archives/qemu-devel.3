Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6EFFEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzLu-0004rk-VG; Fri, 27 Feb 2026 10:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzLh-0004nr-RD
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:51 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzLe-0003Vh-U9
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:49 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8fa449e618so306027866b.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772204505; x=1772809305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MRxwJdCq8Cwn+oyS8vx9U3DlgChgxgO0uYxGAXSP5A=;
 b=zGIhXdzanXWPKMO4PQ9UoT0vZtiWT3Jk4SZOULk0NaroDXvwvQQ/p+O5e8p8+xZZEK
 Zg/Dyjw0gMQ+K9SfyBCuhQpJZVvYUc8lzxLvGbWLvUQSZ2BvdslkaOgILEJnV1OFeMQG
 A6xeQpt4jC65gMNpIzmaKpvMi6db5FjiFADTMYvvg/VvhS6/HiHR0vr5vwIiDsjoQ7pS
 1/xGCuJUSZ+67SGr58RmfCDQUL3qKbfzjQdFfS/W0Xg2NrwvqGNOR5WbgJ2KChLkLBVn
 hB42kqbHpR4cOfYZQw5Zb4QycdAFIsXyt6+QUkDiDC/Kh0gz0xa4EXedQPTOsb0Qev4i
 hnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772204505; x=1772809305;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MRxwJdCq8Cwn+oyS8vx9U3DlgChgxgO0uYxGAXSP5A=;
 b=vK8+WK6+u8Z7UZfSQ0tBDwhyodtlmGtIhOE7vc7WVCwXMUVNWYIdCkdhgoLXz2VB+x
 cDgmzvtatKR6XWKW2Sxps8KGvR25t3QZn2EwftjHFmGh5KIcaet5RueTsA53Qo/n+8Fy
 sj5U/cM8+ROA4A7Sy+7THo1127KyR/ekR4bMp5Ui+ElRt/+WujePqGwusIAgx164tawg
 Hbpx6jlymCPXfYjLTnkfY8FnH5bpl1h4+vpgAWszuO7xyDrT9XjuHvD/Rc7lQA0zIyk2
 /E0XkUIUqr5HD3ZDMaNBVmicbiK0fjjcHkfApk6k3nNIAGfEQrriZL0MRVLN34objttn
 YvYA==
X-Gm-Message-State: AOJu0YxJa/G9UbA5Fgnhoi9zLTI+h3kW+8xqiLRTH4H3JxktcLR7YlC+
 NK6uDxQqYCFz3Ze7o+SsEDGbdD16k2mv4YSDyKSf0g2AICz64X9qwKatRcLB4PUgZBA=
X-Gm-Gg: ATEYQzxbL7+oevcv1hlAtIYTo7fpDqmYJV71MiYWBUeISa9Dzkl13YJ/EL5vJnnf/si
 RW3WT7mYyIgDjK3j6kbF/Nwdtn3Z+LfqsmiAhh2+TmEQHqJU/ETBBDSQwJgpI2qDaEXF3s0tIFU
 aohJ1C9F5pw0PZxvxnK6+iCeB31gogOOkKoDzMthU5OSw9wJbfU69IbAh6uSblZa3I46vBcb+XH
 j3CkXQXGXXC1wwxrbHqfxzSKbL0V4XtuuIIU0dLk5fC/RCxLonnQFmD2wql8nDScves13KexCI+
 J3PFuuxGF2gTO8N1ESxG7Dttp02vPFZerdZg9isWjBJ/fZDFvuhNU7oITCes1robdLQZkkbiVmZ
 /FaJNCIFFewAF5sY0Rv8HDTkFqSz1TJBY6Kmp0siUqmyM5C3NLmEBTwbOu39M04fSbtL1u8iZQN
 L4RF4HO2ijOq07rPiYQZqntyU=
X-Received: by 2002:a17:907:1c1b:b0:b93:89de:2651 with SMTP id
 a640c23a62f3a-b9389de3ec3mr18568166b.20.1772204504522; 
 Fri, 27 Feb 2026 07:01:44 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae60c16sm154326666b.38.2026.02.27.07.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:01:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82E505F7F3;
 Fri, 27 Feb 2026 15:01:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 0/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
In-Reply-To: <20260227104314.81038-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Feb 2026 11:43:10
 +0100")
References: <20260227104314.81038-1-philmd@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 27 Feb 2026 15:01:42 +0000
Message-ID: <875x7ixmax.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> v4: Move gdb-xml/ directory under gdbstub/
> v3: Restrict meson to gdbstub/
> v2: Check array length
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   meson: Restrict gdbstub to user/system builds
>   gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>   gdbstub: Move gdb-xml/ within gdbstub/
>   gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

with the ppc fix:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
>  MAINTAINERS                                   | 19 ++++++++---------
>  docs/devel/codebase.rst                       |  2 --
>  configs/targets/aarch64-bsd-user.mak          |  2 +-
>  configs/targets/aarch64-linux-user.mak        |  2 +-
>  configs/targets/aarch64-softmmu.mak           |  2 +-
>  configs/targets/aarch64_be-linux-user.mak     |  2 +-
>  configs/targets/alpha-linux-user.mak          |  2 +-
>  configs/targets/alpha-softmmu.mak             |  2 +-
>  configs/targets/arm-bsd-user.mak              |  2 +-
>  configs/targets/arm-linux-user.mak            |  2 +-
>  configs/targets/arm-softmmu.mak               |  2 +-
>  configs/targets/armeb-linux-user.mak          |  2 +-
>  configs/targets/avr-softmmu.mak               |  2 +-
>  configs/targets/hexagon-linux-user.mak        |  2 +-
>  configs/targets/i386-bsd-user.mak             |  2 +-
>  configs/targets/i386-linux-user.mak           |  2 +-
>  configs/targets/i386-softmmu.mak              |  2 +-
>  configs/targets/loongarch64-linux-user.mak    |  2 +-
>  configs/targets/loongarch64-softmmu.mak       |  2 +-
>  configs/targets/m68k-linux-user.mak           |  2 +-
>  configs/targets/m68k-softmmu.mak              |  2 +-
>  configs/targets/microblaze-linux-user.mak     |  2 +-
>  configs/targets/microblaze-softmmu.mak        |  2 +-
>  configs/targets/microblazeel-linux-user.mak   |  2 +-
>  configs/targets/microblazeel-softmmu.mak      |  2 +-
>  configs/targets/or1k-linux-user.mak           |  2 +-
>  configs/targets/or1k-softmmu.mak              |  2 +-
>  configs/targets/ppc-linux-user.mak            |  2 +-
>  configs/targets/ppc-softmmu.mak               |  2 +-
>  configs/targets/ppc64-linux-user.mak          |  2 +-
>  configs/targets/ppc64-softmmu.mak             |  2 +-
>  configs/targets/ppc64le-linux-user.mak        |  2 +-
>  configs/targets/riscv32-linux-user.mak        |  2 +-
>  configs/targets/riscv32-softmmu.mak           |  2 +-
>  configs/targets/riscv64-bsd-user.mak          |  2 +-
>  configs/targets/riscv64-linux-user.mak        |  2 +-
>  configs/targets/riscv64-softmmu.mak           |  2 +-
>  configs/targets/rx-softmmu.mak                |  2 +-
>  configs/targets/s390x-linux-user.mak          |  2 +-
>  configs/targets/s390x-softmmu.mak             |  2 +-
>  configs/targets/sparc-linux-user.mak          |  2 +-
>  configs/targets/sparc-softmmu.mak             |  2 +-
>  configs/targets/sparc32plus-linux-user.mak    |  2 +-
>  configs/targets/sparc64-linux-user.mak        |  2 +-
>  configs/targets/sparc64-softmmu.mak           |  2 +-
>  configs/targets/x86_64-bsd-user.mak           |  2 +-
>  configs/targets/x86_64-linux-user.mak         |  2 +-
>  configs/targets/x86_64-softmmu.mak            |  2 +-
>  meson.build                                   | 12 +----------
>  stubs/gdbstub.c =3D> gdbstub/gdb-xml-stub.c     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-core.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-mte.xml  |  0
>  .../gdb-xml}/aarch64-pauth.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-sme2.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/alpha-core.xml   |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-core.xml     |  0
>  .../gdb-xml}/arm-m-profile-mve.xml            |  0
>  .../gdb-xml}/arm-m-profile.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-neon.xml     |  0
>  .../gdb-xml}/arm-vfp-sysregs.xml              |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp3.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/avr-cpu.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/cf-core.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/cf-fp.xml        |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-core.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
>  .../gdb-xml}/i386-32bit-linux.xml             |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit.xml   |  0
>  .../gdb-xml}/i386-64bit-apx.xml               |  0
>  .../gdb-xml}/i386-64bit-linux.xml             |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit.xml   |  0
>  .../gdb-xml}/loongarch-base32.xml             |  0
>  .../gdb-xml}/loongarch-base64.xml             |  0
>  .../gdb-xml}/loongarch-fpu.xml                |  0
>  .../gdb-xml}/loongarch-lasx.xml               |  0
>  .../gdb-xml}/loongarch-lsx.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/m68k-core.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/m68k-fp.xml      |  0
>  .../gdb-xml}/microblaze-core.xml              |  0
>  .../gdb-xml}/microblaze-stack-protect.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/or1k-core.xml    |  0
>  .../gdb-xml}/power-altivec.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-core.xml   |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-fpu.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-spe.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-vsx.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power64-core.xml |  0
>  .../gdb-xml}/riscv-32bit-cpu.xml              |  0
>  .../gdb-xml}/riscv-32bit-fpu.xml              |  0
>  .../gdb-xml}/riscv-32bit-virtual.xml          |  0
>  .../gdb-xml}/riscv-64bit-cpu.xml              |  0
>  .../gdb-xml}/riscv-64bit-fpu.xml              |  0
>  .../gdb-xml}/riscv-64bit-virtual.xml          |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/rx-core.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-acr.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-cr.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-fpr.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-gs.xml      |  0
>  .../gdb-xml}/s390-virt-kvm.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-vx.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390x-core64.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
>  gdbstub/meson.build                           | 21 +++++++++++++++++++
>  stubs/meson.build                             |  2 --
>  112 files changed, 77 insertions(+), 71 deletions(-)
>  rename stubs/gdbstub.c =3D> gdbstub/gdb-xml-stub.c (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-mte.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/alpha-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-m-profile.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-neon.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp3.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/avr-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/cf-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/cf-fp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-base32.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-base64.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/m68k-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/m68k-fp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/microblaze-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/or1k-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-altivec.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-spe.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-vsx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power64-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/rx-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-acr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-cr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-fpr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-gs.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-vx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390x-core64.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-fpu.xml (100%)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


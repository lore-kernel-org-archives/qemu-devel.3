Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8470C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTfA-0008Nj-GX; Fri, 06 Jun 2025 05:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTf7-0008NR-Uv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:46:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTf5-0004I2-6v
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:46:57 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-adb47e0644dso432591366b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749203213; x=1749808013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpVhRwcU15bdPoHcx4CeJOydrdHRBEXCdYjnxynxe/E=;
 b=uR9PJ02GHZ+WKMcV6imm8OQZaRidEH/GoIL6D+OES0SVg1OmXCsTmGePPlk3hdXUng
 eWYs2O9wdCZ3xQG6Vc4idNQ7frsf/bzL/LQyInsofTaWJNEx4N9r+7q5suCuFqprSrxn
 aH1hGIXS4VCmEK0kENCmDNE6LIWthSx6Ma+BXdSbdgFXBKhulkU7raqm1zrqS2FcYicK
 6BzXx++GvV4mpgi6nw5RmorilZr7hIttXpu+oEgl7uObwJbntBHR6FK/dObvpoAsklhm
 c6iYMUsCT9v/1ZpepPMZo/rMUhnBUzGEIKrx9O1S/atxMSj+988KV2SJ/pwf9v7dCo9H
 oFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749203213; x=1749808013;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YpVhRwcU15bdPoHcx4CeJOydrdHRBEXCdYjnxynxe/E=;
 b=gF9jPIjzOitWaL1nMuqR3naTPMLmUMY10JvM+FqoELKJ5tP+aGcO/BsoQ8VRsq1Zpo
 1EijlXMykTsELdPBQVAV2UnzN0HhLNtHSa7UwqBEs/e6zT/9yIMLQ+/HPNRBMiRPrNcK
 iA/nPfb0Sc1L6rzdYvPTIl/zNu/SLgSPjGL/SFpuR0qmoomeAyyKCs13tiKTvrvLaSA9
 h1UZn1Kp7g1lN9f/KuVLcRhxiMa8TsoEln72kuhl2VhlRNl8/3zXbIN3JMu/XiVMrFRZ
 5JTwtTAyzhxTTnDJTJdD1tYG5YmZBGYw0HejgE286m+5UpUM4zacz6xhssXnCFtePlN7
 QQFw==
X-Gm-Message-State: AOJu0YwTDOfGUY6tV7HtroQmTJeAJgTLkJt9ms9ei8U85d5gOqNBLJqH
 uSUyFNHwAoHfa7S9dbVQF95S1pvFWs732v8ROTiOdzm5ByJ8Ra2B75TfwvVNGIBY4WQ=
X-Gm-Gg: ASbGncsEfxmtbHbS0YUyGkBjX3XvjtvfmtX9r7VqrFCuqCGZ3p947eJYuQbmwcwQRou
 OONWZYlK9na6pb32a14lmqnAzWmJIZSOGatojNTnnmYQx6zDN16tkSoF+RilWCXShN0IpxGB+CH
 nvICePcyox5UTAVe2uVcEh+Jg93IHWagfxohtVaHsRyO3LuDMMalqbmo1HIkQS84j3fW/pGkJ/+
 yzVNVfOrWJI0qCyFeupwqkKRPcCleTxDHtuXJWs5uVSmacK3bSUq9fXA/fAYKrDeYUziBySqqTs
 zFETITwvEImoXzpLdNWT0Ks4KBUToZqSYDmAPHwXMXb7QxvkyIHJ
X-Google-Smtp-Source: AGHT+IHeUiH9xGyUcHQa3goaYaN/5wt0mFU8fcEutRkfBdi+xNlIHDul4XJ97Qt+yMWHM/p7own5FQ==
X-Received: by 2002:a17:907:cd0d:b0:add:ee2c:7307 with SMTP id
 a640c23a62f3a-ade075bedd1mr715956466b.6.1749203212626; 
 Fri, 06 Jun 2025 02:46:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c6a2sm88568666b.86.2025.06.06.02.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 02:46:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 44B975F7E1;
 Fri, 06 Jun 2025 10:46:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vladimir Lukianov <1844144@gmail.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] record/replay: fix race condition on
 test_aarch64_reverse_debug
In-Reply-To: <20250603125459.17688-1-1844144@gmail.com> (Vladimir Lukianov's
 message of "Tue, 3 Jun 2025 14:54:59 +0200")
References: <20250603125459.17688-1-1844144@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 10:46:51 +0100
Message-ID: <87bjr15his.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Vladimir Lukianov <1844144@gmail.com> writes:

> Ensures EVENT_INSTRUCTION written to replay.bin before EVENT_SHUTDOWN_HOS=
T_QMP
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2921
> Signed-off-by: Vladimir Lukianov <1844144@gmail.com>
> ---
> During the record pass, test_reverse_debug writes a sequence of
> instructions to replay.bin. Presumably due to a race condition or
> host's async implementation details, the resulting file looks like:
>
> ...
> 12: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data=20=20
> 13: EVENT_INSTRUCTION(0) + 59 -> 44298=20=20
> 14: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data=20=20
> 15: EVENT_SHUTDOWN_HOST_QMP_QUIT(12)=20=20
> 16: EVENT_INSTRUCTION(0) + 5587988 -> 5632286=20=20
> 17: EVENT_SHUTDOWN_HOST_SIGNAL(14)=20=20
> 18: EVENT_END(39)=20=20
> Reached 162 of 162 bytes
>
> Here, SHUTDOWN_HOST_QMP_QUIT is written before the last instruction
> event. During the replay pass, QUIT is executed before the last
> instruction, which causes the VM to shut down. As a result, the QMP
> and GDB connections are broken, and the test cannot execute its final
> steps.

Seems reasonable to me.

>
> Adding replay_save_instructions ensures EVENT_INSTRUCTION is written
> before EVENT_SHUTDOWN_HOST_QMP_QUIT.
>
> Tested on my arm64. This does not fix the bug on x86_64. The x86_64
> case seems similar, but slightly different.

Hmm I can't run the functional tests due to missing avocado bits. How
did you run the tests?

>
>  replay/replay.c                                | 2 ++
>  tests/functional/test_aarch64_reverse_debug.py | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/replay/replay.c b/replay/replay.c
> index a3e24c96..b2121788 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -263,6 +263,8 @@ bool replay_has_interrupt(void)
>=20=20
>  void replay_shutdown_request(ShutdownCause cause)
>  {
> +    replay_save_instructions();
> +
>      if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
>          g_assert(replay_mutex_locked());
>          replay_put_event(EVENT_SHUTDOWN + cause);
> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/funct=
ional/test_aarch64_reverse_debug.py
> index 58d45328..0ac1ccb0 100755
> --- a/tests/functional/test_aarch64_reverse_debug.py
> +++ b/tests/functional/test_aarch64_reverse_debug.py
> @@ -26,7 +26,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>          '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf=
7')
>=20=20
> -    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2921")
>      def test_aarch64_virt(self):
>          self.set_machine('virt')
>          self.cpu =3D 'cortex-a53'

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


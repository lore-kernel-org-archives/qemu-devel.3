Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B7FC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 21:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRh8-0005tN-3K; Mon, 13 Jan 2025 16:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXRh3-0005qo-I8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:09:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXRh0-0003FJ-Ki
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:09:52 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2353728f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 13:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736802588; x=1737407388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGRKQbXkvNBckWIqEkTi8u5XEkXxyPMSDHo/yt345xw=;
 b=SWLcOYl3c6tv1b9oiiuzmnlnz3HlKTMcbtAyK0NdTvdDRB2+84VGC2KSoQRnoHYJ2J
 2Jx4J270yCV1BnnPZiHKakz8pFrpLSXDW/eS/yLnebMQaQmmBWXC8oUITyu9MqyBRyhx
 +tmsBT9uoQmZx793hllOdQFwzfVd+LPkpmZrX9NhdmkQLIjcvdUCwHLUlmXvpOk3VLL1
 lX+qrvLpH0f7YxyGlDKPMetz7kJP52YEdMlxBXtPoK9LHMsiBlzQNwdKp7SLJRmrbTjb
 6ErQ3iDrq2n1SrHQ0q35ZpBV1feDUthsZQDaw5j5vd6/gprr3n6bkE58oTbxLj+2bum+
 b6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736802588; x=1737407388;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGRKQbXkvNBckWIqEkTi8u5XEkXxyPMSDHo/yt345xw=;
 b=wX8RpcW1dVEaBNHI3pj/ohLPPQvjt39CQFUsL9DhYYpT854LXJWvwO1YjkVsyZqAWH
 xeOG+5AWaxBnCZOXS9WZfO8o4j3KJ8lbvpcMi/rCzdRuUTNRC1mLU6I2wEQKmwboBz9M
 A8vuWPHg/skYYGZrHKKhO5AWQqrMcuG/SUBP1xr+nkXgcPQwcSepp5IILHJZtYDhmxUK
 2L5NX4f7WxP3aPpS5kttXv9+wwRLPrs7S/jkQAFCJ5i1AqbV/409IitGt/UeMpCjhNDs
 nj7fQqz/2jnzMGK5W4WjE6Hy9Z80u8qCb9EOQ7H2fI442zFOHjLqdpi3rNm5w2P65M1J
 HY9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq7sPywhudrik0xoeOQb78sRImP6S9J1pb1iV7fn0Fv6bfN5gfL5yVRfh/bDpbVvv+rW9+rpioKllC@nongnu.org
X-Gm-Message-State: AOJu0Yw7bVlqaDiLgq02BbueCGI1HwEvEGR/GihpmYTSXHxcNyJVxQ3J
 Ewi9sniD/5Fwk3yiA6zGvsQZJuGZR7TVjJLO2bRuYakfOf/iB9wfLTVN/7b4des=
X-Gm-Gg: ASbGncvW4caKtcA4v5Y+jpkCP/R2JIIiC3KP+Cq6SsrgJ0CdrfSGnK9+Xb/GKBhVAUv
 bFrGYdOSh39PVEl3BqC9eIxx/a8GJTTsE1s0KwxmMwW8gTPPBTQcxygP+DX+ugyrRi8k8COP8sf
 CAt5bgfQYfhxhy/1Mb2fduTqspq1pM9rT7nFgfYZpqwnQwCSRtR5vSQPxE31C3iFVlW8qXipwoW
 7n3cosPJqWDo3044EAzoCDfxPDxCAPMkVTs1rrtV0o4BIhunlZ3IzI=
X-Google-Smtp-Source: AGHT+IHnW6pkpPkL9tOSp3ZmZFsIh55R08f1HHTuRmhy5CMJU/YRREN7XWhmBfnT/6U6Lj1fgHM49w==
X-Received: by 2002:a05:6000:470d:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38a870821bbmr19816337f8f.0.1736802588573; 
 Mon, 13 Jan 2025 13:09:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6251asm159811055e9.40.2025.01.13.13.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 13:09:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 39CBB5F713;
 Mon, 13 Jan 2025 21:09:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm
 on aarch64 to impdef
In-Reply-To: <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
 (Peter Maydell's message of "Mon, 13 Jan 2025 12:34:09 +0000")
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
 <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 13 Jan 2025 21:09:47 +0000
Message-ID: <874j22l8tg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 10 Jan 2025 at 16:28, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>> >
>> > qemu-system-aarch64 default pointer authentication (QARMA5) is expensi=
ve, we
>> > spent up to 50% of the emulation time running it (when using TCG).
>> >
>> > Switching to pauth-impdef=3Don is often given as a solution to speed u=
p execution.
>> > Thus we talked about making it the new default.
>> >
>> > The first patch introduce a new property (pauth-qarma5) to allow to se=
lect
>> > current default algorithm.
>> > The second one change the default.
>> > The third one updates documentation.
>> >
>> > v2:
>> > - ensure we don't break migration compatibility, by using a specific b=
ackward
>> >   compatible property.
>> > - added some documentation about migration for arm virt machine model.
>>
>> Other than a minor change to the 3rd docs patch which I'll note there:
>> applied to target-arm.next, thanks.
>
> I just noticed that this series breaks 'make check-tcg', because
> the pauth-3 test is explicitly checking the output of the
> pointer-auth operation. I'm going to add in this patch, which
> goes between patches 1 and 2 of this series:
>
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Jan 13 11:42:57 2025 +0000
>
>     tests/tcg/aarch64: force qarma5 for pauth-3 test
>
>     The pauth-3 test explicitly tests that a computation of the
>     pointer-authentication produces the expected result.  This means that
>     it must be run with the QARMA5 algorithm.
>
>     Explicitly set the pauth algorithm when running this test, so that it
>     doesn't break when we change the default algorithm the 'max' CPU
>     uses.
>
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
> b/tests/tcg/aarch64/Makefile.softmmu-target
> index d08d9b01ded..9c52475b7ae 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -91,6 +91,9 @@ EXTRA_RUNS+=3Drun-memory-replay
>
>  ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>  pauth-3: CFLAGS +=3D $(CROSS_CC_HAS_ARMV8_3)
> +# This test explicitly checks the output of the pauth operation so we
> +# must force the use of the QARMA5 algorithm for it.
> +run-pauth-3: QEMU_BASE_MACHINE=3D-M virt -cpu max,pauth-qarma5=3Don -dis=
play none
>  else
>  pauth-3:
>         $(call skip-test, "BUILD of $@", "missing compiler support")
<snip>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


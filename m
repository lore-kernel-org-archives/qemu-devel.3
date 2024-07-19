Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C095C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjP4-00062f-NL; Fri, 19 Jul 2024 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUjP3-000626-JN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:55:49 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUjP1-0001Nu-TV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:55:49 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eea8ea8c06so24133651fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721379344; x=1721984144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ka3A+ThXKvmFjZZIuNPGK8CeHsT/qqUifGsW5ABgHVY=;
 b=X0WdJvghbnKQQ8F/LxZ+OIKeSk094UCrYCw5fDYWkYxTwJy+WX+kpMHmrSWSMByxEq
 5C+Cm0V7B/JXJobA394PSogoKWcvs9z1wytrQ2blSK8aasPMyXDwfD9KHJhi5D8Y8PW8
 d6/dfJUa6+1qyDAx6/AWA7Zh3mA4E3zMBHHZmqoeZFb2GEfaKJLqac2Nj/0OXjrgIGf+
 Hzmv7HEZvZv2SpuELlxhHRM9yEnRlS2yjeok3FvXnnW4Xn0OKpisOV1AeJ45uWFVCmml
 hEIjmMz7AWs/UO8demMP2UIvvQbNj3asa6XR0UQUnySdxHe7TKV2u4dGGqwVjcQaP1TB
 o89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721379344; x=1721984144;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ka3A+ThXKvmFjZZIuNPGK8CeHsT/qqUifGsW5ABgHVY=;
 b=PA22gBICZoNp4tqWf83JSDWR8zo8n6YIWUPfAsTSzn7oI/nf0Qq96iKafGz17uWKLr
 R5i8uZ9ZfwVPk0rI5zM8LHVtn0N11bVYKnhWQyIGIqEtokQdFMFm2uKqwx0aDhns4nTD
 pje233UwqAIgHx40JyBOHmQCO7R1ex1tqtUWFY0FVSTmkYSsNwYu4t121Ps3Kt2aJhZL
 A3SLRR5+3h0JRgjhbnXs+9aVer70K12TzZQKEFC5b5m8hZriIsLxtWBcxKMnBLcYpkC1
 4PrjRdMYidFLN9fLS02brAh0QudqltTKNgFdeP7TInAmvM9GlRN3eWo80r4wTUw25Wgo
 UXCA==
X-Gm-Message-State: AOJu0Yxgrg+GMa3BCUxRzxUSlY6ZO7NUdsGk9o78c81sgCJ+POEEbNNk
 Yba96+bhLho3E0UP09wXGAGdoRej0cH8jUIVD8nTaxk5Pu1YdTMua1A1Kq8dRhc=
X-Google-Smtp-Source: AGHT+IEYR7lx6jyzBpew6ueYdXie8/tFYn90pH4u+hWrWYR7p4F632euBBwB//G+5sdwpWYF7yks4g==
X-Received: by 2002:a2e:7d01:0:b0:2ec:53fb:39cb with SMTP id
 38308e7fff4ca-2ef05c503bamr32978951fa.6.1721379343709; 
 Fri, 19 Jul 2024 01:55:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692ad0fsm16488385e9.30.2024.07.19.01.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 01:55:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 34C915F880;
 Fri, 19 Jul 2024 09:55:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  gustavo.romero@linaro.org
Subject: Re: [PATCH] tests/tcg/aarch64: Fix test-mte.py
In-Reply-To: <20240719004143.1319260-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 19 Jul 2024 10:41:43 +1000")
References: <20240719004143.1319260-1-richard.henderson@linaro.org>
Date: Fri, 19 Jul 2024 09:55:42 +0100
Message-ID: <87jzhhg3qp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
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

> Python 3.12 warns:
>
>   TEST    gdbstub MTE support on aarch64
> /home/rth/qemu/src/tests/tcg/aarch64/gdbstub/test-mte.py:21: SyntaxWarnin=
g: invalid escape sequence '\('
>   PATTERN_0 =3D "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\=
)."
>
> Double up the \ to pass one through to the pattern.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Queued to maintainer/for-9.1-rc0, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


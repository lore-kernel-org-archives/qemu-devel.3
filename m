Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BDEC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDHC-0000cp-49; Wed, 26 Aug 2026 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDHA-0000W1-9C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDH7-0008Rd-3n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:43 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a3e145e1bfso1353195a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749359; x=1788354159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KGlas5Oq4BJZCup3cwz6viHQBn3b+dHoc1gYQjOtj5A=;
 b=XDSnr6nU/pOtvXu5/Tp3LliGMkDYW/vVkS1/k0LyfvxLeomiHRuvpVPT26RtJJ+5dW
 ZKIg3CNAMvtCx6ISK0rW8znPzwTs1CFqDxSjlIPSXtZIfra9CfhWq7au/Re5G3IEJilH
 cj35hTKdqYL0sFH567YBwPhSSxgV7FcQND5rD1Z38gN2M8/LhSYI1T/lIChr+9T2a7Sg
 zbYwENDiXeiUt9CpDPN1sdMVgEbkLvQQf6zP/efT1j3UCPvwMGeg1xKwK1Dn2THo0jIl
 +ATUviM40ihjVYXcFnKBhBHf2C8xahC3m5GMbQ+qwawYH1cNvgJxNvv/EoSSyjs7Wpkc
 dJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749359; x=1788354159;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGlas5Oq4BJZCup3cwz6viHQBn3b+dHoc1gYQjOtj5A=;
 b=R21TOJJcmlYnWsMP9KR76PeyMDZwaFdRt5yCnevsOpPKzRVzkKcHzKm9Uv9UhCt9tA
 /UbrCt2ktpMOLOyOvVjGwcKFO40N+J8sPGI2r4gJWmzMbFBgta1u80WYMkpFLbWycL5Z
 dO/ZWxhWg77E7jX2b+jKcVEizL/RICiBshlPr8Sxy0leQIW++z/d1QBjrSleNnZGd3lk
 gAx0qImPHpnKDb2abIYgkc/eosfRt1bMF2KaXhJyiJ3ov7uPeY8p3zbSqNPxfT1MFIA2
 DUj6/7ajkK9eWdPHRlXO6bIdAoY+tIn1gizmFK3d0zbR1bK5BICxcQUQ+gyLgjwBzwbX
 5uDA==
X-Gm-Message-State: AFuF++ltcGWMufeW1ScXtHtDeM4h+2WdFDwMxfl5BepOxCqb5zpWrzXq
 XP3ASX4NwtiLuvQ2YBgzkt61ukdl0szPote5vUqEaic23qJlU8+9gjyqvBcaE21gy4Y=
X-Gm-Gg: AR+sD13cLhex+0I3S237KEPknaRe3DzQHbVirKihaMF3Uc5Ye1XdrB7ZB13nmgAZhGP
 bxo0zcJR0gYCogL+GD5V7Sq/0q5oG1+mhRCV4EkTJiK/IMcUqz4pUEAfisQ64T8nP5CFV1HrQAn
 t+TKDmi3GFkccgJRBCtW6JdhQx0EjmzJcbk0l4J/DnQWbwiJ8X6gkSLp4wJWtoUPmb59jWOC6pe
 EjDFEFNojqUBinHLF4J3/zE8NGTXol2WKRVj6NrRYqu34T2jw3eKkBGOlced+9KVQH5l+fwfkzQ
 oNhM4g5Q1uyPCW1L/GS9+4Y6q91JSRrcM1JwUGnZxs8vpb+6lQfM073tMK0ItoAzWMRXzQ4lEu1
 fzYkE0Ilkii+cpndsdjfxMWlk40rvZnfBWJAsZ+pZZ39qj0bPQdjTxC/tkgwf2Y6XFTD2MVfFai
 AA8cfpDLFNKPcNridkZb8K2I104JR6vLMV36GuT/8CZCfe9Za0IrRR+Bl7sMxp
X-Received: by 2002:a05:6402:5287:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6a5df31b7eemr9849174a12.0.1787749358934; 
 Wed, 26 Aug 2026 06:02:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de5f7bb8sm4337762a12.0.2026.08.26.06.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:02:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C9375F81E;
 Wed, 26 Aug 2026 14:02:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 038/104] tests/tcg/meson.build: add generic plugin tests
In-Reply-To: <20260818192309.22169-39-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:02 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-39-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:02:37 +0100
Message-ID: <87cxv5nifm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We add one test for each plugin by picking a different user and system
> multiarch test.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


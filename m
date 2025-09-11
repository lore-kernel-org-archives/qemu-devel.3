Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB4CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 11:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfeP-0004lf-Uv; Thu, 11 Sep 2025 07:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwfeI-0004l8-I5
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:39:35 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwfeF-0003lc-LZ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:39:34 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-724b9ba77d5so6301657b3.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757590766; x=1758195566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otoVpTBqn96xcesy+yVXogw8EffsK/xqmF0AyF5AcGY=;
 b=GqroYH7KoOpTf5Zo3fJS1LfWtnLC5l5QhDVRbuMEKUxmhEcsnvSZ4i92fjrFAhP8Ol
 P6QBHC5TZYIEwsgo4Sd3x8nM0AkDgMFjl8OgGVTsaK0WmJB0HYIvn+ajXt+iTuE3dOVQ
 qHNRcgZdFC2b7BW86NQ1nFUa2KZ78xYhMXNiaKOcerWEO1zFKNr9t0VKZhe9Od88Zu+Y
 iee1fCV7LG5zkfOE6HlUOo8yobWWRiw5n5mpe0Ji8y2MG8/f32DDIvMK2gSF2+O3+Ymi
 pd2tcAtoTtWSr5QjIdsL3JNzD/WfH4qD/oaJ/YWNk5y25olE58t6N2EQe7+YmpHH5OPX
 73cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757590766; x=1758195566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otoVpTBqn96xcesy+yVXogw8EffsK/xqmF0AyF5AcGY=;
 b=hrNQKTBNI7J92N8XqlbxN3j1UdAdO7W2+fjTb3Dt8DaOdDXllxf1iKdrsN7xWffMVe
 ICuyRrb5PQPk1djyX7/Wrc0K3y4TepvaHEq9rroZLq+9ovbslq4BfGjfQySnNJWyGFos
 1zx+xc7cYrSSBtAkWgOPk/eThI4gqT6H2Gc3QRsnOzMIMkB5d99Eqm2E9R9ddOHTqGLW
 itX7zyMvNZWQnzyXSw0bRgG2U0+EhkgicSKRJjbkPdbou9iu/4rFthhTrlsNbNttND39
 W0SJDMBR8PkoTj5qTdCBQ3T0rcB6a2GXOY9/J0EDhIgncgoK6SU915WXEafR4xYT9nO+
 CxDA==
X-Gm-Message-State: AOJu0YzCci9lCBRg0mddhZly5vY5qdr69FUOup7r3YmC1KceZZKEtudV
 N1Evn+YnWDQCJlxSKhqXjbFAJExMLmTOnEuLjNMP7lyySRTydZliUr49vzbd298nzU7b0D59emu
 Zl/DivDxfdoQyxn1v20yAi1bBzeOSFsSWsA3z48iutA==
X-Gm-Gg: ASbGnctIjLB3YpLZbORSLBcdFeN+A/rqvcwiPUHbMpP5gYeetNqVCJo2f7UCPljzjyB
 OJWAJId161iEfjEJjbuhLG0ypL77dC1Uuj2dfp9woegFEtkfRknJ5p/knJ61CWcjat8hmeXxyLy
 jgp3khRy+W+RKlt2W13obKt7dWOn2qOe31iVYGgYYs1+OXNWehJxE/w7okVGqvt9zeh796Zhx1m
 QCLVWMI
X-Google-Smtp-Source: AGHT+IG0se1Ofb2MfKBgsW9peJdePUrVq/PJtfhqJ6IuJz6ErV/KULvMR7y3G9ItBRnuBJjLX9D2DbR/fAvUuk3FwzE=
X-Received: by 2002:a05:690c:6f0d:b0:724:72f0:50cb with SMTP id
 00721157ae682-727f368e681mr184378697b3.1.1757590765793; Thu, 11 Sep 2025
 04:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250908140653.170707-1-stefanha@redhat.com>
In-Reply-To: <20250908140653.170707-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 12:39:14 +0100
X-Gm-Features: Ac12FXxIC7xviU0Oz1FFh8g5mssmR0xAz6Olc3kMj19YU9-OyJE74KTWZMaEVpY
Message-ID: <CAFEAcA_jB-5wmRXUijcr_+hpto3huMZQnKzZA5rHFwS5ZWDSkw@mail.gmail.com>
Subject: Re: [PULL 0/8] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 8 Sept 2025 at 15:10, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705=
b8:
>
>   Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into s=
taging (2025-09-05 09:51:27 +0200)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to b91cbf4e691b397510584b04fd6197284f55b52c:
>
>   tracetool-test: allow to run in parallel (2025-09-08 09:48:10 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> Daniel Berrang=C3=A9's tracetool test suite and Marc-Andr=C3=A9 Lureau's =
test suite fix.
>
> ----------------------------------------------------------------

I ran this as a combined merge test with a couple of other
pullreqs, but I'm assuming this one is the cause of this
msys2-64bit job failure:

https://gitlab.com/qemu-project/qemu/-/jobs/11318561687

# [WinError 2] The system cannot find the file specified:
'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/dt=
race.c'
not ok 1 - dtrace.c (set QEMU_TEST_REGENERATE=3D1 to recreate reference
output if tracetool generator was intentionally changed)
# [WinError 2] The system cannot find the file specified:
'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/dt=
race.h'

and other similar errors.

thanks
-- PMM


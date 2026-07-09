Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E43C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtiM-0003DG-AW; Thu, 09 Jul 2026 14:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whtiK-0003Ck-Lb
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:43:12 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whtiJ-0008CR-9m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:43:12 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-92edb12cdf2so6248785a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 11:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622590; cv=none;
 d=google.com; s=arc-20260327;
 b=P1HavccwMOJvB1Pjo6k6rvkGNCF+4h4eBz/CyqbUaaAcvZOFDqs+hsAbRQXxribMYp
 1W/Zlhj18FkF/3kcApIM2wes3f/aDShrWuht017pOxUkO643iBA+ixnEtcArnJtB8dHE
 suN7SwRrsQF/QB+TXpaMGoCCoO9gH4KkN7thP6PiPD/96Eah8RRqGx/rPSjkWkefv4pI
 ewyRSGiYO6aQL3X9GW0lvt/kAY461nrpu4JvDsMg9fgfUBiC5bLgmBLzTQAIeGGicIwl
 7tqGjFmIvCqN13hl1OrcRnw6x2+CdhftEbLcNIBARxDF6pnjfTNvgXzc9ZauTEFWYnwp
 4JnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zKf7luZYc8hCBd/cSUNCTohnF3HdfKwUI1Mh0LwST0E=;
 fh=py8qWij750+NlEfFcK5ghwGWeGBs72nVcPl8SzkNb0c=;
 b=HRP/Uhp4wXb5Gi8MKxeE5T3LnvrupcsBZM7iJzFI9QZ+3pAa88Y9X6pldtCp7wiWtY
 wNmHhyBbBqDBI683ub6thDdrB/prYC3+METeEhEaA89wEGCdd7FkaXahy1uJnO+1RCJZ
 Mv82/eE01GvolxPgczvFdA9g/ebe9gg+u75zZqN+kbyxKVqJKC+4JEwGN4ieJLYU1lLy
 VyN498yES82qMpLyXrjUy20Wvn+DNtVFmYx6qVW7/P6ArKYl8HNvJmq8p1OtE7aAmRUm
 v0CLv0VEFrouF0Iw2A44ozb2/qj0qhQ3gm8IWp1eW/mzokS50eHdSFdgvp04N7draAwM
 JUqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783622590; x=1784227390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zKf7luZYc8hCBd/cSUNCTohnF3HdfKwUI1Mh0LwST0E=;
 b=qva47jxuogCcXsfa85GObQgwLesijugYzGc/W7dq2pfZqQ0SQg5qlJ6yEj/tEG83fv
 ABJDeBLdU0MV113d8i27tQJKUCGrtb4a2wpq5fgiA98vDytR9OnWJRFT6HPZZIyWPe0R
 DmQ93SYwIjp2RS++pH+EJB9Yubpa3fEodEBwRKVmAtoV3QO2avOtkZv/cu9QyxABcsa2
 2To+5Ya2Epg+Dmqt8iV9TeicAsNlg4rOBzRGWJFUsLeQInafsqUkp37oepMrfS4E5X4s
 JRZ7rGpxSCoJabL/1MVqXmB/6WkHZrVBsdm829BBSJG81H839iY/lTRygfsW9xYiddoc
 4MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622590; x=1784227390;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zKf7luZYc8hCBd/cSUNCTohnF3HdfKwUI1Mh0LwST0E=;
 b=dut+8V4gYPLEOJ0elVEglfIFIHpDZSKjaVHozUSdWuTjK2cuBM/qmDlsXEdroWfaS/
 YPnhDsyTaG75q3S4Y5UjS/jqx30fz3T4BLs6vAdie3SmEbMlVMmSSG6oZUbaRt5kuOu+
 h2nPZMo28g8nhr2rfgX1qs3ggDxV2dbluCTy4N9frJaoQCLS1wWGjAlw9GEVhVFNGEkM
 uOSkyEl6HFyCDI8LyLFr6vfH78xp6h8Rb97/lZbOBPULjhyileNdj7K5ZfPgqmBb1Qfq
 svWUHL/FL//JcjgXZhcnK/BP1j7ZqRl4aRYCdc25zFu+N0T1On22yfhlXeXOWdXQVygy
 KDGg==
X-Gm-Message-State: AOJu0Yyq29Lh6s1mntAECP/XjPxfHcv71DLUjn9d/8a7nbJ9eVBbduWm
 p5GGur/7LNlUJcghwkqS9hBwUdLI5cnOJ3q3URKAW/U9znDbMrXkYyoWXlUYyTfNPXYTQb3pt/b
 DG/Z7RvgO4zmJ+zSy9ksUEn4MH6XVseE=
X-Gm-Gg: AfdE7cnPTNK04WzqCZoK7YxIH+OsRwLzM7wVXf3TqIdoGPuPBNT9Z3B6ih/XeqEP4Ur
 xKQtaP0B+fkUaj3hAquQuZMNFek+z/yV2xNNZmsZqVfTk9YJWPaR+ioSHXdepS3gJar4YEHXgCc
 siRkl3n4TbRLD5Brz/5xr+Xmm0TGlZN6DX45RVivDNzpVn2sXmhs1qWeYdQ39sB5Zl1s+JGbkb9
 vpj/e9bqFFwBe/htrD7GUb3xm3o40ReOX4OSbCPQz6N9+wm3sEtWlzMCsXCs0xmaKosP34XQTdQ
 i509cWjdI5GUETiwOCUMuWSJVJOQYU6SWfWEIbdopks6/RUSmBP3WmBDdrGt
X-Received: by 2002:a05:620a:4506:b0:92e:6c8a:2a39 with SMTP id
 af79cd13be357-92ecf5b4610mr882839585a.13.1783622589589; Thu, 09 Jul 2026
 11:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
 <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
 <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
 <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
 <968352f9-089f-4409-800a-3efef59d114d@oss.qualcomm.com>
In-Reply-To: <968352f9-089f-4409-800a-3efef59d114d@oss.qualcomm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 9 Jul 2026 11:42:56 -0700
X-Gm-Features: AUfX_mwpLCUsUyFi5F9AFn_AcPwVqIDIRH6DOarSz8bHDsPxGFc__wpuUCoNy1w
Message-ID: <CAMo8BfLPahC0T-8U=y=Jacx5zNvO=4jFXiCFfWvYUKtyNVk=Qg@mail.gmail.com>
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jul 9, 2026 at 8:24=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> If you have a chance to take a look, I observed that test_timer.S is
> flaky on xtensaeb with kc705_be. It fails with a probably of 25% on my
> machine.

This is a rather well-known issue that for a core with .clock_freq_khz
that is not
exactly matching the icount argument used to run the timer test it
will sometimes
fail. The easiest way to fix it is probably changing the default core
clock frequency.
The more useful way to fix it would be to make the core clock of the
`sim` machine
adjustable and set it to the value that matches the icount.

--=20
Thanks.
-- Max


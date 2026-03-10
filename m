Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0BEB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyQt-0008Jm-D0; Tue, 10 Mar 2026 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyQe-0008GX-I6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:51:31 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyQc-0007a1-CZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:51:23 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ca4dfdd88so12709601d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154280; cv=none;
 d=google.com; s=arc-20240605;
 b=Pr7Dp6XGMjCrrSyM2TcYL/R/wQlAzEVAYAS/kh8oZrkHk99HBBmg22Y5Yz11Y+hhNC
 tLv0tUUfD3mR7lpIuz5PAxMlyV10WNDj5n9uN06m0loBGmQKUc+sYDMJv8YjTa1urH3L
 g/z6PADgJlI7O9LZaWIKO+2fztFx91t7WzK/ViHUsX+exev1U/o5t+9lCwsggO5+cEM+
 DIUQ86GkTF1lYKHtOoY9hQeb5h3OmtMUipK/qt/NAAg6QUm79HaYGxB6oXpA/mrpZWx0
 kGetOvDHLaYtrk+1oIv0yWA5xsb7y8uJNpfSD84djxeP6odbUNO1+p14fXTd3qhYJt7p
 cEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/lWqJuZaaSE8RrlNBKPQno0k/WGjR8EJilEL1yhQLag=;
 fh=wO6GrStS19GpIkzH2fCODtJdZGiQ83xG6ZcV25quj6g=;
 b=Uz0cHTGHy2abuwLAjUffNcbpT/pO5tSTbQLpDivE7WgFv9I4Evw9GseLfs/pgYgC2D
 rXSdo4U8Zh0dSppnaL4NTMGnc6ANFI1HrAw/E6Hj6Wy011aGvExrK0CT6J9JIRoVEv4y
 NnhksS3TUQWDvH/jobO+POSUr7n1S64yBVi4aC8W0NORK5rSOZaUvZXGd8a/lWDO/c3s
 bNVIJD2XXV2a5lVjzmuwzu/u9EWmzZOTLlbZ1BW6aGrVK+bZk8UrB13VwHOcb67uaF3X
 c6ojSx0NMoLAgls15pBXMlxXmQrqTDtu4ugCsrIcEXMx4J3yp6XCQZ9b248iwNzvdmsR
 zbag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154280; x=1773759080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lWqJuZaaSE8RrlNBKPQno0k/WGjR8EJilEL1yhQLag=;
 b=fFdk1nM+wxspx/PvMxsrpsvoDyXBJD4FAtrdns9hgMZJNKsn9G965mbm1MnJ/panNV
 uKy8/Ayrj9mqup+FQWsyHUU9nWjpZah4CCJWcgMGjrUQbVyIQ+CyzIxUZIIvRZlLwipD
 s7JmAbEQWFUp1J/dkCRKCymOApMDl9mbiDfrnNv3PdhIyUL1m4dRIQmcSYIaJYfynNDh
 Vc/36gkq3t1p2SLjXd2GY+Ca8wpWqwARrOFMbdgoTabwrZGtL9UUHzYXPrkSrVAjMep+
 sgQSKPmUBoavBEkX84fe+ATGeJ74EOPWJVHNKC08D6acJFVACfEY8Fjxr7Hne5DSD+mu
 YwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154280; x=1773759080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/lWqJuZaaSE8RrlNBKPQno0k/WGjR8EJilEL1yhQLag=;
 b=ptNVsuC5eBb6sW4mhxxMaweiyoQop/QnweieaagP4PTTUPG7/35E+L7Upc+jwgDBt3
 B2ZZyPUTpTb6PtWAjxNoaXC0L4pAvM+P3FzycceLtX/+W+3uJ5PtAKqieaPBXjuTsHqM
 QTICYBic0oydIF4EPkpXED9V+9ScyS5L33VcpmzHhAVr3pufIVc5i0FpgizHKJmhjmNP
 z9IETYjqFylWxDiaF5KauUBY0TC5AMvAQDRU1hyc7D4wXjuobeOmKypVj3+kv1qNyJag
 mWMqwFX5s3bgaEYpd35jOtBr+SHfFrz6x4RfrEkkxVNrkzK7xJydXrQlsMnHvLA0CeuF
 lLyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1u0K0xRAw9MDa2PsxqrudhFh+0i/9Jbf3r0i0zxT3pzos3kzm9VuGyFHPeP/E3X117fjbMLG1JN0k@nongnu.org
X-Gm-Message-State: AOJu0YwEWCUIGgDFusx79jcL2Ba0SWOi5DBevKLPb5Z2ZWWTMZ/LJxtA
 QrjPqmCcaVQ1Sq9r6QkKV+5DZSmT1iJzwrnuJcFblfLjizTY39Z7NyPqj2oeO80jLcwG1VX4/LG
 eOydYGKWwT6fPU+8WKhRJd/VHlzA8t7gPjrILzaddiQ==
X-Gm-Gg: ATEYQzyRUDO30oKJIFcg1BWfnz1bNzF+7B1iwRG2ComofbBZTOYNoL6YcpSCc6Posvd
 r2BbwWV6nyGZnubX6AHqPxz1mW81MSD+ZJEuu4eN5gltosYl11H+YfmATqd40nUCHPIln3/LljS
 Ks0h5dLWT/K95ULXCnqnkP0dryuW/TSttI+zzqg78rjvlc3Qbkq7eRvce+V7ql3gkgkxm6BR4Ft
 ZRGlUNAOcNPi1l9Ao6snOnMoJ6+tp+Pc9YWVBGkimpC5o8FchiwU7IMRLgG/xPkECChh/3CKP1K
 0LQbhnBmAneFeEDw7hyKptgJGx4NaLQTGHfNxCxS9zy0aQYZqWEPoeZsJKeq9M7Lx6w=
X-Received: by 2002:a05:690e:e1f:b0:64c:98f2:272f with SMTP id
 956f58d0204a3-64d1436a726mr11331964d50.74.1773154279946; Tue, 10 Mar 2026
 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de>
In-Reply-To: <87h5qn23v5.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:51:07 +0000
X-Gm-Features: AaiRm53TRfbnMRnPXX5W578AqurX41bWVoSBNpQ27nLSP_yyAasaZVxqxtTEExo
Message-ID: <CAFEAcA-vsS0Q9kGVbmwEyLQcoANaHg5S754DNvqXOOnqoY-LMg@mail.gmail.com>
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
To: Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 10 Mar 2026 at 13:47, Fabiano Rosas <farosas@suse.de> wrote:
> This gives me:
>
> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_pin=
s=E2=80=99:
> ../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
> terminating nul past the end of the destination
> [-Werror=3Dformat-overflow=3D]
>
> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_level_=
high=E2=80=99:
> ../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
> terminating nul past the end of the destination
> [-Werror=3Dformat-overflow=3D]
>
> ../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_mo=
del_expansion_kvm=E2=80=99:
> ../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 dir=
ective writing
> between 1 and 10 bytes into a region of size 5
> [-Werror=3Dformat-overflow=3D]
>
> ../configure
> --target-list=3Dx86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,p=
pc64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-s=
oftmmu
> --disable-plugins --enable-modules --enable-werror
> --enable-trace-backends=3Dlog,dtrace --enable-debug --enable-docs
> --enable-rust --enable-strict-rust-lints
>
> gcc version 7.5.0 (SUSE Linux)

This is quite an old GCC, so it's probably less good at noticing
when there might be an overflow and when not (or it has bugs
that have been fixed in subsequent versions).

For all of these examples, it would be fine and I think also
better to use g_strdup_printf() to create the strings rather
than a fixed size array and sprintf().

-- PMM


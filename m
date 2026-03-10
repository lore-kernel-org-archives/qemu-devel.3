Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150CFEFCD9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztRG-00049K-Pl; Tue, 10 Mar 2026 05:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vztRD-000493-VZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:31:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vztR9-0006ZQ-UX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:31:39 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64aedd812baso11335880d50.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773135092; cv=none;
 d=google.com; s=arc-20240605;
 b=Q0rWcG9eRPK6GHtwNEpf31Ur8Ez+Z+c6OCmZorKyc5/NGU+OeeTS+QD5naEiq/h4aA
 oz9/OBgmJ7Tfr9tQNWwuyXou9lKXZWXO4nXmpgz3++XN9rQ2+I0NkB7w/z1kLxcGK0Et
 1EnoWKn5d90OlnCSuRkooRDD7C9XsW9dZx1r04VZX1JZxPLy9FvgGQttSkqLLrg6xkot
 EkhIFTP1huh53C/XHYEMqz3q85XZebXAB+fw1REm/+Bb7y4QlsKpSpy0T0A4VNfU9S0i
 V4cQK5aUzCMLFkx1WU0dSXodvb8701oPN9bcD5/MulCveWiAbfCOA2hV0qzKhKcTvEgG
 v/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xaiAdgqw5KDYU/puLlNfauy4VoMi/CEK+Q49TzbpAu8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=GfyTbtVn3PNiAEjBwJmv03gMo3iKDlDNrmskch95GGuXZ4XpZAygpRMeGTLJmzhg9M
 lrtXCDmcXzueEmYDxLyAFFTCj8RMF8auzbk2xbQ/YNf5QWC1wCf5aeP1FGJl8j+BDkTU
 kczrLNA+EUoWP9fsOYIH79HK/inI+INkrKcLdefCi7l5msSnhG1FX2lTjCGASwohOP/u
 xnoUc2K6od1YAtQRMwygyyhG4RtFNlyPHo8Qf8Jdx/7UOEt8xVScnVQf9ZxlfpaaB+7j
 HLVJPqGiAopzGe1uCQPQa6zk/ZbfPvAxL26jBaSWKxIymwIbjO1IfIL0ekVtFvzqEgZ7
 v8mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773135092; x=1773739892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaiAdgqw5KDYU/puLlNfauy4VoMi/CEK+Q49TzbpAu8=;
 b=lV8mhQS2mmWeL9UZmozNCMma8FFGon8nmmkj6oKFrtWDhnAsP0kohHhpGyXEDS5hEj
 w6wF97IGMwhoq3d6Qxh7bJQFZOqeZlQXK4bYpi1/WSOr9JODgMSpWXaShQQeaG3nFReZ
 icac/pSnKT6dgVadVaLf3xstUtUHzKNDONXpdWpv/Lrb8AdxFv/Xxin/YxWaGsNiIzlQ
 /ij4Icz4ovj+W2xhAGF4d0OhygnfyieneWFwU9tjhx46UGWp9xNNSkXeUTIw5wGu0ymc
 5aa8e401onNCh+shIp8hqXKK5x4e3BlfR4c8gyQ6UoIWpCBLOlVdpRSI+zMDNj3Bc0Z6
 NScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773135092; x=1773739892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xaiAdgqw5KDYU/puLlNfauy4VoMi/CEK+Q49TzbpAu8=;
 b=DIALan+heeonA8kaUIoQj83ONnDVqhMZrFOAA8U957CMRWWRAon5alcacCU6neSw5O
 Cxua3lz/sQLsXlrgmcQ3+180Qo/838Z/2P3lMk69PYOq0Wbvl0gPoiXaBQ5N+yb/K84n
 4k/2eOqcVGB1hWtFAnLd+JqodI6++khLVqZ6Q8M8PK6w9qDMHH0r4fE11dfbx89LwWoq
 t+YknrxoMrdBbUk5B1E8mhbqVdCIoiljLJIF++CrbtRQSMIPFiqKsAVqwiCPupbPRXEI
 /C5kv9lJ1AFIaoNUdsDi0W+lBZM3mDLHEDmRBDSXCHV44oY5VLbvVrfcAcXJiVg3ol9d
 lIeg==
X-Gm-Message-State: AOJu0YzxA59mcz+15APEvcIf7kKeMz5iGyi/PqCHCS3TGU4E0OMphZzw
 EJqJMPo27dsDzr7rYtvlNz/mfI4XS5NyJARMmiphoynu3vMHd39oCcK3Q1mKDNujGZD3a0nbvxy
 yttqEo1wxVEY46O9Pgnaj7sqt7YkanHSu1F1Gt6N1nVPAFPQUyh39
X-Gm-Gg: ATEYQzxbhJJRHtcocJeZDVaMTs/Jlmdi/tld1DxLQekF7CQ+GMepqzRs8rwHb2rcqeM
 QVt2fpM+5AoA7y5NFv40B5rXUXCeAasnxxnN18p1B1hLn/d8Mfc8NWzA0VoqddA2BuZDev8cymL
 Al8LiQnt71s7OCGkGaaeMpB+uHNWmwq6gYtnYhBqpW69mG7cDusFohy3WR4zwykyvTohIyduVQ4
 /X4l0yRZAi5Nx6flrMnJoUypaCVZaYJssuRJJvBOXULSfqrVygI06YL7C6QsMz5cp0MhNPSfBOV
 7IprxduMBb/rmopEKnHJT97vf/5DhjtVgpl3yk4nPhFOEG83jjD3fyLS+iYAPky54Oo=
X-Received: by 2002:a53:e198:0:b0:64c:9d22:fd41 with SMTP id
 956f58d0204a3-64d142ba8f8mr10761551d50.51.1773135092322; Tue, 10 Mar 2026
 02:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260309155219.62400-1-philmd@linaro.org>
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 09:31:21 +0000
X-Gm-Features: AaiRm532L4HB6Onlufk0uksK4Y1MpIBhjT1Y0hYIAwGDsvMrgGlsqQGhYhCzgIk
Message-ID: <CAFEAcA_3RKzDk_5ChFuBtUWYbnxp2nD7dz0VDPp99fSXsi5EFg@mail.gmail.com>
Subject: Re: [PULL 00/49] Misc HW patches for 2026-03-09
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 9 Mar 2026 at 15:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 7608a95d2e0bd8c8d069ab77824d02586dd946=
48:
>
>   Merge tag 'pull-xen-20260309' of https://xenbits.xen.org/git-http/peopl=
e/aperard/qemu-dm into staging (2026-03-09 12:15:42 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260309
>
> for you to fetch changes up to caa5d8257037201f4e546ec833e51863ae07b331:
>
>   hw/misc/riscv_cpc: Free CPU array in instance_finalize (2026-03-09 16:4=
5:25 +0100)
>
> Ignoring following checkpatch errors:
>
>   17/48 Checking commit b362f63b6016 (tests: fix leaks in dbus-display-te=
st)
>   WARNING: line over 80 characters
>   #44: FILE: tests/qtest/dbus-display-test.c:137:
>   +    qemu_dbus_display1_listener_unix_map_complete_scanout_map(object, =
invocation,
>
>   35/48 Checking commit 6d5eb13974b3 (ati-vga: Remove src and dst stride =
mutation in ati_2d_blt)
>   WARNING: line over 80 characters
>   #38: FILE: hw/display/ati_2d.c:129:
>   +        DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, =
%d, %d)\n",
>
> Couldn't test well mingw-w64-clang-x86_64 because of issues with the
> OSU Open Source Lab mirror:
>
>   error: failed retrieving file 'mingw-w64-clang-x86_64-libwinpthread-13.=
0.0.r560.g3197fc7d6-1-any.pkg.tar.zst.sig' from ftp2.osuosl.org : Operation=
 too slow. Less than 1 bytes/sec transferred the last 10 seconds
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Remove versioned machines released in QEMU 3.1 and 4.0
> - Enable X.Org text rendering on ATI VGA model
> - Various memory leaks / overflows fixed
> - Build using -Wformat-overflow=3D2 CPPFLAG
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


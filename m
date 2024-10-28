Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571F3D3398B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QZg-0005E5-TR; Mon, 28 Oct 2024 10:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5QZR-0005DQ-Uv
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:18:18 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5QZM-0002Ye-Ug
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:18:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso5693483a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730125087; x=1730729887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NN1HtcuKk4u4sxYooYNjjpywbUCw7RG+vZTvUxvFaA=;
 b=hQXfuvk4TU65pTReEyIt6mEXlkKWyWl3Q9dprEoYALFuG2bkqCDkiDFEBSBZr6Ofpm
 G3mtEqU7kACsjBN5WA+GWeJvgEipM0UO9im7ZXMgJ4JcNKsfif/QemkBozh/EppQtiy2
 9ygsc9m1NrbiBChSLIGX/SF5HZk+YtkpjVmQ6cAZPqsEVYmWwUBp8LQNqZZg89CSYrB2
 05t+IcE1D/hYDXcyNGRUbuR5cYw9iuFt0Xus3yN2BU6Cc7Z7Bty8aXPsZ2BBnPkf9s+E
 bjbGxtRBRx+EWDT+IVjsJS9hYG9D53nlW5MezhQKU2Ps60KgvO0GYdEFwGEIH8R7A8Yq
 fJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125087; x=1730729887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NN1HtcuKk4u4sxYooYNjjpywbUCw7RG+vZTvUxvFaA=;
 b=wNHFv17O0pUSZZhAukj+oUMZ9wcaCiB5LiCrZfX2RfiezZ6kcfjQoPz+5xqH4cFgjA
 QzlSAYoSLqjpB+KC8kFDpu+iYa12ot0eDGEf3eedX21IGQlRFymcKB40QTbHwK6an3CW
 Z2wnVXoXTyh/PF0Av3fDV4Km6pnSnGz1TCVMmud7s/gLKkf5UjqJ0aCWSUx0yYMwYuqd
 CjcsnCpNwFUHVyCH4kq0TYeGbfCS0n+MFQaG+M+MtqjI8lTJMoOPnVFppkLTlxG/9BfM
 EBPA9PjuNZHBsNZfeYQC33LfZqqfbte/QmvyuA78n13I5bfOF31H/3cgz76Rm8qQuJN0
 BkWQ==
X-Gm-Message-State: AOJu0YwR7jgoQIM9Bmk9KJ7kSZ0INBaEKP4dtiQxWtZ/g2/6+sbxJsPv
 LYnXKyS5fol9QVMiCSkstGwJjI7km3ckh9hPWQiatfE9A+Ym+S2UvFABKoriDbrqmEaf+86McSH
 V2egojF5krAN9Tm/o6pQJ7XJcnhBgiL78kfqwBA==
X-Google-Smtp-Source: AGHT+IE3KuIo7ZwznkrHyccFF6gnnfFRuY85mk8h9FFkhccxfKLgBR3Mf62OSUsihXV+pRWrNzthxyyDhB7RoieMxL8=
X-Received: by 2002:a05:6402:5011:b0:5c9:3026:cf85 with SMTP id
 4fb4d7f45d1cf-5cbbf92077amr7536536a12.22.1730125086885; Mon, 28 Oct 2024
 07:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 14:17:55 +0000
Message-ID: <CAFEAcA82w6FHUFOC=nTudph7-0vz830dT59MGd89YHYvQUSFNw@mail.gmail.com>
Subject: Re: [PULL 00/17] testing, gdbstub and plugin updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 24 Oct 2024 at 10:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972=
d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu in=
to staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-oct-misc-24102=
4-1
>
> for you to fetch changes up to b56f7dd203c301231d3bb2d071b4e32b345f49d6:
>
>   plugins: fix qemu_plugin_reset (2024-10-24 10:04:09 +0100)
>
> ----------------------------------------------------------------
> testing, gdbstub and plugin updates
>
>   - update MAINTAINERS with pointers to foo/next
>   - add NOFETCH to help test custom docker builds
>   - update microblaze toolchain with atomic fixes
>   - update tsan build and documentation
>   - don't restrict build-environment by arch unless needed
>   - add cross-modifying code test
>   - add tracepoints for cpu_step_atomic fallbacks
>   - fix defaults for loongarch cross build
>   - make check-[dco|patch] a little more verbose
>   - fix gdbstub bug preventing aarch64_be-linux-user starting
>   - add basic test for aarch64_be
>   - clean up some gdbstub test scripts
>   - fix qemu_plugin_reset



Applied to target-arm.next, thanks.

-- PMM


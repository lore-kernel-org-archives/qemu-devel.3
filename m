Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5485AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUMC-0003lC-TQ; Thu, 17 Jul 2025 15:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRxf-0003Tw-VK
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:00:10 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRxd-0000g9-VQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:59:59 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e8bcbe46cf1so1194736276.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752771595; x=1753376395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIQ5WgqD/M4tar5f/JqNwEkwk3JLal/n3LfaTLUzYGA=;
 b=JmeqCT/hxunuIz2gucdiFUGJ2QRY5s5/m1LmGsHPJAxiOJuV55sJFv20x5SuYXIkF4
 vZP+7h0UR58um2n967u/G8mwztOqOw81HDrjMN1MEK9CZKxvAFdMJv+HLQ1JK/LokeF1
 AFuKosfqSSoMKXreBPSB0/69Vv9L4wD3fB4tv0OKhNbbuxNyyB+2gIOja4nS2Xiy0p5t
 NkKjjPvOM/GV+IYk4QuVrwm14/h2tio+KyM6J6QAFjssdYsNJG+uLsUG9WIblXCsvSLM
 zxRqisztQL3OFL9eaWJ2N6WkPSfKW6KncFoC1lOX6BMUnKyGfiwxJ1NTsjJZQswDAm+z
 43oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771595; x=1753376395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIQ5WgqD/M4tar5f/JqNwEkwk3JLal/n3LfaTLUzYGA=;
 b=LLq3T5kdk2BzqyvDN2LYZkOM/JfNnvLjkCWTe0srpjHKJGLznFllQxnLqv1GJc0sme
 JTSl5/+9FU6t8LeU5xEkh7T7o9KDDZ2+jfzXxJgtk/GNeACWGCWZnBqpdyIAeMwoa/xH
 7qS2ey3OKaPKa6Oww/2mERXvj4EB3PWx9FwHrwkcbxmnGUQSArMH175LunrK7rHk0FiX
 NgVU+EPNoZyACZDOPSuyhm81/dFrI2Pokg//QL8asHhkjZwwt5mjniVI++3r7OoQLjsB
 BP9czXd/3C6Aay/B7bsQdXNpPKSKJNEGvL1fLMCEuyBX9QEfl2/1ijNAMJxbfANZfxul
 H0NA==
X-Gm-Message-State: AOJu0YzbTsc9UGwkYglrXsEhPifoIf4f2TccsvLqN6sLBE3btFtqh1es
 CidxD6Qv//0YQDjEUaOz+OOZ0UIVhzJRSQDYTzmnlJxu7yHkZjInlmMuSuw3A3yE+4YwbcoEjgV
 4cAqK8nAooqfG6fOnvqbZTXLdifUbgB9TZk1FGLBZqw==
X-Gm-Gg: ASbGnctaNfyiliUKDCKL71I964wiXA8gs//ALn0o5VVlNNoDaLSeX20hPd+B0XUI3RH
 QT6rmLHd0068+QiyHJIS/oexRHIJAZVyLEWDg1vEqT0Yl/CODQsHAwYl29TSltt5OorejoPEhd7
 B/Q4IffromOhy7PL/END0zDfQwR1Z3GBrMUi9viPPR3hZgZ5Fg816MdUcBJkrKAE3j3y5OvcyFT
 HvSUc7Y
X-Google-Smtp-Source: AGHT+IGnHTy2RcMfGqoYK2d4tZSBDfR6EFZOyvywJ2w8PKKnrjffoLIYdE3fpoMcxn2/zVoTOg2d4YAV3JNRp+o9438=
X-Received: by 2002:a05:690c:9b10:b0:70f:8884:a5fc with SMTP id
 00721157ae682-718370ee6e1mr89715287b3.4.1752771595627; Thu, 17 Jul 2025
 09:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250714145033.1908788-1-peter.maydell@linaro.org>
 <2b9a18a9-239d-40cc-bd65-225bad2706d3@linaro.org>
In-Reply-To: <2b9a18a9-239d-40cc-bd65-225bad2706d3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 17:59:41 +0100
X-Gm-Features: Ac12FXy23CXYFPOgo8Z5U2tHioxJcnVfAXch8HJCo6getewcYej3AmsS93IZ7SU
Message-ID: <CAFEAcA8hznDWTOXYMPbBscHmy5F_gKXhaAtyPk1LPcGf54RPXQ@mail.gmail.com>
Subject: Re: [PATCH] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Mon, 14 Jul 2025 at 20:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 14/7/25 16:50, Peter Maydell wrote:
> > In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
> > buggy versions of Apple Clang") we added a workaround for a bug in
> > Apple Clang 14 where its __builtin_subcll() implementation was wrong.
> > This bug was only present in Apple Clang 14, not in upstream clang,
> > and is not present in Apple Clang versions 15 and newer.
> >
> > Since commit 4e035201 we have required at least Apple Clang 15, so we
> > no longer build with the buggy versions.  We can therefore drop the
> > workaround. This is effectively a revert of b0438861efe.
> >
> > This should not be backported to stable branches, which may still
> > need to support Apple Clang 14.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/qemu/compiler.h   | 13 -------------
> >   include/qemu/host-utils.h |  2 +-
> >   2 files changed, 1 insertion(+), 14 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks all for the review; I'll pick this up via target-arm.next.

-- PMM


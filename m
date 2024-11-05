Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9759ED12676
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8GRa-0000wR-Tb; Tue, 05 Nov 2024 05:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8GRZ-0000w4-B4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:05:49 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8GRX-0008Qi-Fq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:05:49 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso3150105a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730801145; x=1731405945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uoV6v6ucXhK+ykSict7926T3V2nZnHEAGLSDp+cl46w=;
 b=GuPTuBMPPsKzMWF9DLb8scnVDriMYZ2+SE6G41mWiNdDBWlJXICI+ETRUmMGYO5SVo
 qjIiC5Tgc0wuw89Uil5nm0F1e2IV49JK/ilOpwER0Zvog/VlEiH/mfPWwgEc6sHGakNk
 hIZBcuGBHa1ksib1neISuw9aMf8a5aL1XGbsW/Yy12kJxDCMJmnQzNumwVXaVYcSplI4
 FucrFlfrFmRSfgU8yx/UMHYlk8+MivTMax1RX9WpJdd7S0oqqJoJwaR1ejAgs/hO6qjY
 St6tsmlZEfAaEKfMGGjb9GWWmAxZnkU5ZdCtOj7OdK5klndPvUncB5sYJJ8dtiDKOT9t
 wTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730801145; x=1731405945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoV6v6ucXhK+ykSict7926T3V2nZnHEAGLSDp+cl46w=;
 b=M7+pEjj44vT2BrdghPOQ9KdVx8rUgg3a24+IdN8ZnIfg8OVNzmGOlSB+7gn06b8E57
 a7CCPq8Zv73FjYqT57tYw8H8ilKaGInqoHP8+9BXSPcU9iKYNuoc0JwhNiukWvfRI2IO
 P/iZjJInTTq/gj7VTDmqLY88e973iLWTygI6qbHbIpl0onsFFeZaUwzw+kDvMONppn4Q
 ByxhLn2WiIT+E+FQyp7lA4i/LqpHE+QeFqnscioDSXyIxfzhg/Rsjvfi/jdMfGr6w+Ar
 65L9NfJvtASkB3JBMfoJ0dhtUZ+/FOFmCCEyxVNtLP09Wmi0woSBgOK5R9QAXNYNRxsX
 2WPQ==
X-Gm-Message-State: AOJu0YxuclkbLb+jeTjoz7qYl4ac0cVcXMZO8a5tJSSOwEioRubrDJvK
 nCXzUUpX1EN7RsbeLA1Eyh6jXoeCw0mjFbUAsi1l6cS5kXhEcGF5GORH7RVBB1KNA5xBnCR/W3L
 8MYKnKXmD8RZaMP7X8uIsDxnW0mY+vpB8rZbr6ASrsA37X4Gh
X-Google-Smtp-Source: AGHT+IHeBdxKdFZUuumClqe/H4AgOczMfS1Gl//1V8GXiflrYIiORDnkXmytR7U7NVlrr/2FlH9IbBHne0/6ewG8Ups=
X-Received: by 2002:a05:6402:42d1:b0:5c9:59e6:e929 with SMTP id
 4fb4d7f45d1cf-5ceb912714fmr18143631a12.0.1730801145366; Tue, 05 Nov 2024
 02:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20241104132425.284772-1-thuth@redhat.com>
In-Reply-To: <20241104132425.284772-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 10:05:34 +0000
Message-ID: <CAFEAcA-SKuZrgH0C_3mGVGhyPa2ET-rF5wad3UiLROmm_+ciOA@mail.gmail.com>
Subject: Re: [PULL v2 00/13] Misc patches (functional tests, next-cube
 machine, ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 4 Nov 2024 at 13:24, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit c94bee4cd6693c1c65ba43bb8970cf909dec378b:
>
>   Merge tag 'for-upstream-i386' of https://gitlab.com/bonzini/qemu into staging (2024-11-02 16:21:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-04
>
> for you to fetch changes up to 380f7268b7ba4a6db73bfcde53082b70add45caa:
>
>   tests/functional: Convert the OrangePi tests to the functional framework (2024-11-04 14:16:12 +0100)
>
> ----------------------------------------------------------------
> * Remove the redundant macOS-15 CI job
> * Various fixes, improvements and additions for the functional test suite
> * Restore the sh4eb target
> * Fix the OpenBSD VM test
> * Re-enable the pci-bridge device on s390x
> * Minor clean-ups / fixes for the next-cube machine
>
> v2: Dropped the problematic "Convert the riscv_opensbi avocado test" patch
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


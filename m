Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7923D43367
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93OO-0004Tr-GX; Thu, 07 Nov 2024 09:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93ON-0004TZ-Eb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:21:47 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93OL-0005kH-S8
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:21:47 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb559b0b00so8703531fa.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730989304; x=1731594104; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXZha86n3C8j/RPyzgmrpswP9sTnM3EtX4JaiPZDZG4=;
 b=pMec3vqufWW/fNJKuTg+3o64wTneWt7bc4E+T7aNB8J1UiNoYyVzSNY4HxlcJ0LIJC
 siI9dGyqir8hBVUXJKUhbZaIjKwy+DOpu+pGKoOoehDTeT4o0nphN5mRCUYaN5nvLUOK
 rS6Sp32uMRlF2SVCO1SaY+csVl09yXwhz6rDlC+AvVx/CbCJ+43yPhMgGcNegogvE2a0
 Tal3492aK3TuTe59wvGJ/vya6H3vu3usyPhV5UvkXkhzrBYkHcC1tD8Yed0wz3x9V2oO
 DNSsTh+KrGXo4uRxCuTaH2Qzwe7WFiaQqghr0HX9D43zFIXrbZa5sarRFaUrnL1yEEUB
 LNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730989304; x=1731594104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXZha86n3C8j/RPyzgmrpswP9sTnM3EtX4JaiPZDZG4=;
 b=O/za9w4GwBp3CmM7UOfFFCbhvMLWVOf0nE5D3Yq4H0N306WmgLW3njwohM1mVqIYjZ
 CTtESmTxBHWDIOMCMEMKHHFcs+9TjkRAB83Ph5yzIizQQyMPbClVpp0yTlT9kAjjCeaT
 MNe+MlfatY+r0CHivQOZKtnng6NUTw+wBkhDzCq+wPmis8yFgh30/i366oLAEWof2bag
 dxj+VJsDkppRwJa7tyb4Ay5Fc3JV9gERyfmoVcfXuiVxp2e6Q8l5gJ01QbfIhnIslJkn
 Qc5hQT9BU76cg2RiNX0TXGbMHFcegzHUhmtLWxqtD7swpL/JIk5mJEDJ5vcIww2SHflU
 /Y4A==
X-Gm-Message-State: AOJu0YwTSkAeu74AgUZ4hskEOdTjMbXE4n+WQisE29OFQWvdE5Ads7RW
 8qu15yuIYRu99KrUa957OCDB0dfj5himxNNFIzDrv3cHpkPlPEen+YksnWE1j2xw1FaVDEIsn2k
 q4/0a7YcsUetzzub5I7djYr0Gb/RCjc9x6XDYu2Uq1X4NLP1c
X-Google-Smtp-Source: AGHT+IEA6fnj9gBBNUUyyndzzFOgQAgFqCb3MQSFzMz16iW0IDz/pCJMKVBuJMWqjVMcmrQX4ZpTxU+v+jQ2TZRabi0=
X-Received: by 2002:a2e:bc28:0:b0:2fa:d534:3ee7 with SMTP id
 38308e7fff4ca-2fedb8156admr119470801fa.35.1730989303864; Thu, 07 Nov 2024
 06:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20241106180742.567076-1-pbonzini@redhat.com>
In-Reply-To: <20241106180742.567076-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 14:21:32 +0000
Message-ID: <CAFEAcA83ZezJPCuA6921-aV5GhffXA5s9DeS8CxzY5U8ZCE8xg@mail.gmail.com>
Subject: Re: [PULL v3 00/39] Rust changes for QEMU 9.2 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Wed, 6 Nov 2024 at 18:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:
>
>   Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust
>
> for you to fetch changes up to 951f71ad67bd474aba6925529daf45b747aac86e:
>
>   dockerfiles: install bindgen from cargo on Ubuntu 22.04 (2024-11-06 17:12:17 +0100)
>
> ----------------------------------------------------------------
> * rust: cleanups
> * rust: integration tests
> * rust/pl011: add support for migration
> * rust/pl011: add TYPE_PL011_LUMINARY device
> * rust: add support for older compilers and bindgen
> ----------------------------------------------------------------
> v1->v2: wrap bindgen check with "if have_rust"
>         drop ci enablement
>
> v2->v3: fix formatting of pull request

The msys2-64bit job seems to be failing on the test-aio test:

https://gitlab.com/qemu-project/qemu/-/jobs/8293985646
https://gitlab.com/qemu-project/qemu/-/jobs/8289460211

| 50/127 /aio/timer/schedule -
ERROR:../tests/unit/test-aio.c:413:test_timer_schedule: assertion
failed: (aio_poll(ctx, true)) FAIL

but it passed on the third retry
https://gitlab.com/qemu-project/qemu/-/jobs/8294803952

Since it doesn't obviously look like there's anything
in this pullreq that would have caused that I have
assumed this to be a pre-existing intermittent.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97808F33A75
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9z7-0005OT-KU; Thu, 05 Mar 2026 09:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9z4-0005OC-UR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:47:26 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9z3-0005JG-Be
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:47:26 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7986d231b3cso107493297b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:47:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772722044; cv=none;
 d=google.com; s=arc-20240605;
 b=SJbZohwZMwraMm1Js6gGidsN2QBJUsBqtMIIEVQfwx2n64+cffjbkyIFX2huJqpeXo
 M3xy0/+UDM4FL39elkw2WpVtDBB8jUIoakc/9IFdLfpEScgq+7WKGD6BmEc6+yqjPHE/
 YEV7qDrYzZN15Wlhp9F6wb8sQQI55hskqIYNsdsfTRfU0lDR5Uj8/TTQkLN9Au0+CdjP
 MfORmoZQv9r2lg0diMOpEv+5tJVzV6lopT8XUKzWyTPv79Z/55rtfOsqgZ6hVDkAQxEO
 TQmY056Lc7JjPusurKZIM+qugqNR+awIX/7lEqx/6oolshtvZugwjctdlB+5CJ/rQRx/
 xDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/3h0WPRfGP1wmv/zzjhrCWJ+5iPwZ1nQZXO/3o0YWA=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=k3GTXAsy/oDwYWu8jrw0alPzhFO/r5gBBqAdZQDh9Hgn6DT4ufHKdOJuVrmRon/rjQ
 arLeiVyJGt0FCzHxNT7iiA4ypwYEJyl8JhUJNfvcRXAp8qfZ4ZKvrq1S495rbxxJsWS1
 7PiZZ2XZn9Lv73t7Bbw8b+WBpr3GeT+rNoHJe672MLP0NcXTh07TEGCUDCWyqP1Dumf1
 8HU8oQ6sWk1dlgO9Cw7auq8Ctl1sxLNKB8jNiBz/tF4kC/QPJ/cgmUyLVDttIDdpRZ4c
 X64Bm7rWMmIhlYcImcrtgC8Yjx9+FAcJgSXs/6iFNyGbZgwCaTs10WWdZ1tAUi950e6s
 oCbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772722044; x=1773326844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/3h0WPRfGP1wmv/zzjhrCWJ+5iPwZ1nQZXO/3o0YWA=;
 b=VdGYqbFDGiRW419pjaO6XLIjhVb+MsmdOGKMIaPUSAzqAEkf4tBYWOLlQJ6bA001tl
 uc6uEikY+SXmHY76JZGrB7fdWoU3TkO8q5ItBpH5xE9LSKSoBa6e9f0rzQA0TLtUwZEU
 czsazs45apxMzeNctqg6kRQhGKham+10ZmWT0ghWhZDCI/vAk/I4Sg0A2x/o6CUQrY94
 mzbdAUShiYrzswtRtl05g1bGIQ5hxj3zUdLT7zPs8iKoG2sbuB8hg5IVYUoFXfXNC4ql
 Eby+yG5jCIvUYjJZaQXQK7cPFVL79/KKupbATgzVZ5Qj7OHSzA9KbgL7lIn6uEH3ERrx
 E+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772722044; x=1773326844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/3h0WPRfGP1wmv/zzjhrCWJ+5iPwZ1nQZXO/3o0YWA=;
 b=jTvv1fKmk7NRuDumjkD/rcsVoYhnAV4+fitZ9PC2aoxR4+8CB5VR+LoqsTLTHBLSHP
 qbKjzUuXyQSiwWL6R/OjY8lIDyTaZvPA8xj7nVi5rIyDrJlpoG33hdXQH/owba9C4/dH
 ftlcIPseMPl6/gztHsbEahITafxy3fVopK4o+e+4sLPxnz+yKe07oyx6SPL5N3A68IWd
 9o46PPk/utNxtN4qN3zLtpM0sawZjZuFP7JWq0Z9icPGHXHqhax03YfnCrlwz8MqY8qo
 X4zGq4SteImXipQt6lgXU0XcETqMVI6NcjYKkXqgn1p58pWYziNXXhjULWwiCWYRqJxj
 rZVQ==
X-Gm-Message-State: AOJu0Yzw6qbnWBerpJUw7XB0ar7xersQf5pWWfMVnCU9Smdyl1NxD93g
 Z1fJaArZi1G7XnKTwICYWb+xV5giWJftMl0f//7iQClxKrVoVgxAGYeRMw4aJXFSrCrv+SuOn/o
 WwbD8wJAeSVYnKW33KfSbNj+h6QqOGVTjNBRZYWGtUg==
X-Gm-Gg: ATEYQzwMx+DM+oByhaxn1S+GH/BRuIbcbSxXSE0XUPz782wgmnA3Agyi4bPsD2MmnEC
 nQL0ZHNVbGq3vcUNxqKrS2mOaTgm8cA9dHrJFWd+N96rQ/u9ZiwiQ3lSTXtsgCmF8POJcIq5Pce
 Z505khdSlxdDsDKp749jM1Vaqy2wyX33jE7jF3KvvogNBxaMrDWvKhRYc6sne9r7T5b42rwQhOo
 E1oUYwGGuSg7KraRleU+zddPjJytpJ6j+myR3AtjBOB/dEutrnAYD30oiQTEXQ87ZSKQcrboWhM
 iKa6oLZig1wlbnonbc341S3yTkVyvKWFQO+1yJCDUWhMDzRCrIyjOoVKptvkPp4lz+8=
X-Received: by 2002:a05:690e:168a:b0:649:e440:26a8 with SMTP id
 956f58d0204a3-64d07047691mr1848979d50.0.1772722043810; Thu, 05 Mar 2026
 06:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20260303150604.2402872-1-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 14:47:12 +0000
X-Gm-Features: AaiRm52SIzjZAST0OV68ICCRJjKmUiUKnEsVWduK46y60oLPRSv8yfX2MGf7luo
Message-ID: <CAFEAcA8HxfTmY8sSi1hhUE+Hown4RH1guaV5J_QcRsGPWGn2jg@mail.gmail.com>
Subject: Re: [PULL 00/27] Misc patches queue
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 3 Mar 2026 at 15:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046=
e9:
>
>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu in=
to staging (2026-03-02 14:01:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/next-pr-pull-request
>
> for you to fetch changes up to 192f59773a6a8fd1e0d3c1d9c9c3f5f59a62c087:
>
>   util/oslib-posix: increase memprealloc thread count to 32 (2026-03-03 1=
5:01:21 +0000)
>
> ----------------------------------------------------------------
> * Increase pre-alloc max thread count to 32
> * Fix checkpatch warning for new/removed files with --terse
> * Detect more GPL boilerplate in checkpatch
> * Fix lean of data in TLS/websock GSource cancellation
> * Tweak CPU docs for DiamondRapids
> * Unconditionally enable thread naming
> * Fix race setting thread naming on Win32
> * Add API docs for logging APIs
> * Fix interleaved error/trace output
> * Fix missing error prefixes with warn_report
> * Add detailed error reporting for VNC passworrd changes
> * Refactoring of error_vprintf & related funcs
>
> ----------------------------------------------------------------

Something in this consistently causes the s390x runner
to fail the test-migration test:

https://gitlab.com/qemu-project/qemu/-/jobs/13367184083
https://gitlab.com/qemu-project/qemu/-/jobs/13366572115
https://gitlab.com/qemu-project/qemu/-/jobs/13339069533
https://gitlab.com/qemu-project/qemu/-/jobs/13336989367

This was a CI run together with the loongarch pullreq, but
that has just passed this job when run in CI on its own:
 https://gitlab.com/qemu-project/qemu/-/jobs/13367800326
so it seems like this pullreq is the one causing the s390x
failures.

thanks
-- PMM


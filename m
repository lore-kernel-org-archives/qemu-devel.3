Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFBEEFCD96
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzY6Z-0001cA-QT; Mon, 09 Mar 2026 06:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzY6U-0001bk-DL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:44:50 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzY6Q-00089z-It
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:44:49 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c9a6d7f81so10184488d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773053085; cv=none;
 d=google.com; s=arc-20240605;
 b=Wm0IRnc1vsFWGx7YiozL5fOGl1+TCFeFkq7lVxu4TWMdumHS7vpvhJMoPOL7JZ8bS9
 52lQ2dOuLnKsgGP9+YjcRm71DXruuj7OmBGGxAxMBaTlWKaXcczdZ1rMpeh+aILIIwQR
 yCakuJOLuwmFJW68a5NX6SNDSCuxIXi+Y8Lz8dU2iqBqzRognaLJLE6BPlsjjQ1baGMR
 sKEVjZ39vl7h9J78Un0TdPDwBl3mKiGqmQEf41m9ha2gKSE5RumJD3sgdNL+9pxgIXQG
 U7DGo7PNUXKt+GIdJu53Ecgy6OcRmG2AXTrmGh+6NvXMyvaBaub7XiRYyJjxH3q74lXC
 h+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=63a2FB9nouJz23261WpQcFeI33EfyTIDsR3sdSlS/kQ=;
 fh=HC6p+gLFbncmhmb/38kvDWivkmrVx81zN4GNmOWXBzg=;
 b=b0s6jq22yd5o0A/UsjCGYYcbBWEcdlXnaAM9sVR6fxNBf4QF4xdM0nHifh6spzyk9a
 p5Fm46ELjQudUQWR4JhwLxL0uQ53kYWXutNomCChhzxdS2KmH7iWvlrAkU1BxpWDV1nQ
 JsRVvi7aTaj6WueUG+vP0qLOu1H+y4kve1tKa+3EYAEqvQcKIWmH/Ukc5E2TA8okAydd
 mxr1vsGTMJawoHr8NaavNRKdHkivcAf9IhbWhXM8dIX1YDUVNCmmDMiKxJTCj7JZCL2N
 /XGXTh7gCz5QwdRT6yN4z48dtPh3JsmmyPbZHYtMmrYMJvNAYQxoZ/D76p4sab9jRTzM
 17IQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773053085; x=1773657885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=63a2FB9nouJz23261WpQcFeI33EfyTIDsR3sdSlS/kQ=;
 b=je3kRd1AZYHB+MgqpEoiRmrRM5Mw61YfYy1l/SApclnQcVMiseBlc0jRFwdGZwOepq
 PZ6O1yY3AfOja5sV/W3gxHsc3iaQAJ8KbAwWI5/TcJTfUFvRJxdcbW+YXjHrqd3eJ9Ta
 tcVnKlFrT166pcHXCGqC9ezXL9DePleqLyxmKwLGQR70FUt4s/BZTrSUVbCxHKxv9o0c
 t1s806sSfYMZGsaECYhJ8LuU3WSzWH3sNsm/7Agq3OI7afq/vUl0lJoI2zhB2xo0TMfq
 vV/indrve3LzW72hm5CORUDVRf89cLgwdz/mVvfkKvtmtSTGR/ncMkDhLa4sr9tznTp8
 vcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053085; x=1773657885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63a2FB9nouJz23261WpQcFeI33EfyTIDsR3sdSlS/kQ=;
 b=PYC69CYGg34u3djCp+DAnJj8waAjGHYREQo7DNxQW+Gu4dbD41wDn2QssxJ/S3JuXb
 w1VrlpbB3h2J3HEJ3tGC/afyZOQruzX6JD+sLt68rXuOOokGY4c+MQGeXtYRLy/jL2kA
 qgO1cWhBYiS7A1Bs7DuDDA5CYWGYcxvUL0KC4DlDo4c+yW3JaiCeQKk0eCiT6N0W9JOf
 HS6kRnteMB85pNtEmPh1uG8PzUArPIxqLowGZFB+cVgnRWB+pyYYwtZ4NgS9aJDtDrGw
 RwzfDXRYwI0vqNXnYXccjxgNdmdtfoJlBaMByRUX2AU7IH4WjtvO587obX3dZZl0YtC+
 GX2A==
X-Gm-Message-State: AOJu0YzAA+OXyChVAz47cmMQedjAJXwtLRLussFcjASVHp1SrbLsJ2wH
 074xsgxVnTw45WqCq/JZQ3+M94ZCB9fdoZtpaDf5tvkYDrM+oW+pTnkuat4IjH4UR9E3EsD/U1U
 fiJwwb7KpBj9af5AS7xdTOERbVFX2t4DnSTvnqb9+Gg==
X-Gm-Gg: ATEYQzyUA2+9qtEPR9Y+vlln4GdHiqhA/9lQkjiKnX6UuxoFj+qhcmfYJHpNokCtiEu
 pGm8ug/eHznG3desYjtio7bYV6yGEYof+Novx5AX9NWfjUaBHS369ESGGzSvUU9T112wAUpx5X2
 +UYJ0RX8qtexL5NrT59amd60wqcB7GTnQzWl7YReFMI6QJ/pVfLbTVQsykhZieuWpKEsqdkXnKw
 /C1Vugko2a50qKMI1GCitpmEoO4f+nUjTkfKyrd67uQmFiydWfL1DF8/sVTRztsTFsvp7hQVumu
 cg8jVfNylo05rPJSsUSSz0OwraWnQtw/CzxDaQJenkV0Zo3ls6A0x3hIgO6yMPtfLzQ=
X-Received: by 2002:a05:690e:6c4:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-64d1429cbc8mr7717788d50.55.1773053085061; Mon, 09 Mar 2026
 03:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8yiCxkyoGdCE-CZiDFK8gqim48_9XteOcBmbgSG2MnGA@mail.gmail.com>
 <30d92179-80ea-4285-a6a0-90e2544fea3f@linaro.org>
In-Reply-To: <30d92179-80ea-4285-a6a0-90e2544fea3f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 10:44:33 +0000
X-Gm-Features: AaiRm52ddO-BG7UuixmW8CQLSNMTnNbWjzsymxB6QmTjP6Z8-dUDy0GZJ0qsI5o
Message-ID: <CAFEAcA-VGiHKxJ4T2ssPnc+H2x4S+hPXGg0Cjq5tRZ2w0nMkWg@mail.gmail.com>
Subject: Re: skipping the x86_64/test_memlock.py functional test when QEMU
 built with asan
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Sun, 8 Mar 2026 at 23:39, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/8/26 1:01 PM, Peter Maydell wrote:
> > The clang/gcc address sanitizers intercept calls to mlock() and
> > make them do nothing, because mlock doesn't play nicely with the
> > huge allocations the sanitizers do. This means that the functional
> > test x86_64/test_memlock.py fails, because it looks in /proc/ to
> > see if the binary actually locked anything, and fails because it
> > sees 0 pages locked.
> >
> > What would be a good way to skip this test in this situation?
> >
> > (1) Should we make QEMU's mem-lock related command line options
> > actively fail for an asan build (since they won't actually do
> > anything, and if a user runs one they probably would want to
> > know this)?  Then we could detect that particular error in the test.
> >
> > (2) We could run the QEMU binary with
> >   ASAN_OPTIONS='bang' qemu-system-x86_64 -help >/dev/null 2>&1
> > which will exit success on a non-asan build and fail on an asan
> > build (with an error to stderr about the invalid ASAN_OPTIONS
> > syntax, which we send to /dev/null). Then we could use that to
> > decide whether to skip the test.

> Wouldn't that be possible to simply deactivate this test in meson.build
> in case of sanitized builds?
>
> if get_option('asan')
> ...

Good idea -- that's simple and it works, so let's do that.
I'll send a patch.

-- PMM


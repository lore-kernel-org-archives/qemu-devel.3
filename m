Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CEECAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 09:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hwD-0005jo-HP; Mon, 06 Oct 2025 05:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5hwB-0005jZ-TK
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:55:23 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5hw9-0003gj-W6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:55:23 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6353f2937f3so5391213d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759744520; x=1760349320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uZJKABXAOJGjocSq1hAkW829DzTq88oe11mK2eUVQ8g=;
 b=YKSESoSDd+8caMnp8aXUKp5YLtTZq2xQtXEjfmGzgvI78FQL1eIWRw+N0FXfSVQsNX
 0H1+MoAG6mlGQNMtqzsxPoXTKe8L8KDynlDsy3s9M1/4zbITdEYpVEb2IwiNicqp65BS
 JzywJtr3n4q4nCeMH3lqaqsRrSBWNqnMVRnjpYihzGJTUCnF5hwqs4UViLt3o8X6byOU
 KaPMwwpb1RxzFygzBYcwDDSlUaHu6f/zSjVveQWEDIQoTUkgVSbHo7UpOrBAlslT49n9
 6irmpkRi2O/dgzD2ZdDqHJj19Xew9uu2OJokUFT8J0Md2ASxFU9fNWHFEkqpRTI6XmfY
 hZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759744520; x=1760349320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZJKABXAOJGjocSq1hAkW829DzTq88oe11mK2eUVQ8g=;
 b=Zo9//ICqdWhAdOvKgKRHVTKWGUJYViHW0lBUGoeyHrayyl51gf+vNoL6xT8iZossC5
 GRiHK2VKAPayJidN1RGSxwxBAjqCUfF2OBRfAE7bzpKPxqQQSDW/bbmZM2WIPZvpqACw
 FlNvJQnewpwaK8yGjm7slOLxqbGuDEfmin4da4rThVRsG3dG30rxxvv1EUK7INnJHcCq
 0ny+sC/jKmj2xDbyV/B6eYt8n+Vv1ppPZ+S5SpbCvUW0CAphTnHtQaJttO4gJ3QvlHpv
 V+LD3ACyJbBAnziOgrpgsJBKZbi6tFZG5YG+uM60hOOuuFaWF+RYVOcWivp/nfDWAS+i
 TuQg==
X-Gm-Message-State: AOJu0YzlbrsBCetNjJVyaNtVvp8txe/16qXp3NvTApZY/TM+ivUGdVWL
 v+dStwNDpLKEz0FiDghN7U/oEf5yoUC4AKR14FP+eO04DYQkhETeI3tduHdTmgptUwW3Nwf8e2b
 awCAwzvPw/KR6WCEelJiNZD2PZ4/9QIBco9lnHjqN5PmZJY9yO2JK
X-Gm-Gg: ASbGncvxzK7hj3aM6ND0OXGk5Op/3Vjt8WKpKtQrQWBApEBENjUvEbGsIZNsXFlW4Xx
 7Ln1Tdn5ekNp6g/nh4VDHQXWND+AVTKOd19mWDGMeLv9MVWS4hNiRJANwufwgRMNXes11OXcH+R
 RyUYw4bRNYuBUQ2nCLuNzVYaYSfhYBPgCZ/yxZ6/tiZergJq93ncc7Gp9YOKv4jjpenCzpySkXY
 3g0OfSfsfEov1mtOs82sSPuG+m5V2pU9KZDgJOvu31Ou2X+tXPQliUWJQ==
X-Google-Smtp-Source: AGHT+IGaKapOGzBys0cXN/D+t+J/FZ1yeqNpec+iiXxAilKwoYA/CWQmg7NluVpLnXQWLEv46JcwCiKOsZAwAxozlWY=
X-Received: by 2002:a53:be48:0:b0:635:4ece:240b with SMTP id
 956f58d0204a3-63b9a0f2568mr8542492d50.43.1759744520241; Mon, 06 Oct 2025
 02:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
In-Reply-To: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Oct 2025 10:55:07 +0100
X-Gm-Features: AS18NWA4CSxPIs6UeldjuC_xVr82jJR-GzeMFBKAm8GlZtUt0CzUMTdu_yBjMVQ
Message-ID: <CAFEAcA_h3-iWubDg++jcO6_S_o_Z1-Xm4RMHqLYq8T=1naADug@mail.gmail.com>
Subject: Re: qemu-system-aarch64 hangs in a cortex-a72 test
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Sun, 5 Oct 2025 at 17:55, Liviu Ionescu <ilg@livius.net> wrote:
>
> Hi!
>
> I have a small semihosted test that I use to test the xPack QEMU releases.
>
> The test worked just fine up to 8.2.9, but hangs with 9.0.0 or later, including 10.0.0.

> Any ideas what changed from 8.x to 9.0 to cause this?

Notably 9.0 is the first release which included
commit 59754f85ed, which enforces the architectural
requirement that when the MMU is disabled unaligned
loads and stores must fault. We didn't use to check
that, so bare metal code that was compiled with a
compiler that assumes unaligned accesses are permitted
(or which simply has a bug where it does an unaligned
access not permitted by the C spec) will now take an
exception where it didn't before. (You should be able
to see that in the -d debug logs if it's happening,
or via gdbstub if you put a breakpoint on the exception
entry point.)

If it doesn't look like that's what it's falling over on,
you could try a git bisect of QEMU to pinpoint the
commit where it stopped working.

thanks
-- PMM


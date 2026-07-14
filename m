Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD4DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZpu-000363-PX; Tue, 14 Jul 2026 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjZpt-00035G-PZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:53:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjZpr-0003ST-W8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:53:57 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso3916050f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784022834; x=1784627634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+5yYGWVdqrydc9wfy5m5D5+55qHS94fiYtvk7UyqDYw=;
 b=Mao4sycupmMLl1+6w2PxoiqxI6iWTg0j4fYF3crzNSmq0dOVgnRjC7uz7iHCCGeuri
 BzMkegF3O6AeOIaFL9JPFJ3l0RkC7xqPB5oEAKqRBXZRinv8YphOR9HS0Z1PUtQ37lKO
 W94vD9/5QrGPDtzhjBPBM4NjkGEB5h1sudNUDTfT9wd3OgjtyOjp5QWOIYWtX4S0PqG7
 cf4bvcpIKb9+Fnyoc5BIZ4IAe7xZZWczaz3w27voaayG+oACn1dFPPtG8HUInxJk+Pc8
 8jvYFn57PuySWxqQJ1BIYgZ2jiBDlcRZdTnxFj7+7drCuXCx3ViuKBxExe+GKEMYYIKg
 RhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022834; x=1784627634;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+5yYGWVdqrydc9wfy5m5D5+55qHS94fiYtvk7UyqDYw=;
 b=SO74XwGU+sswevTy4AEiTLTEbi4gPPLAf0Jd0e8CU4rXC8whqBNjZ+KnprN+6kZ6t3
 pJkWKnMDiflIFIUOmM2xre6O1GrAV/VjRyZGX/b/iLfBPWv+quIeNxLXRUQNwBBWZ3bU
 uFgAHMJPVQEZwWuVBSUBgSi3GbZPhz0JOJVOwcsTHt/NhKG/ixZh77xqG04kCbBKqSlE
 jpEa+WjeDG3ucxpjbYtuE+lK9DbCCQ38hf2N03yi0m3wzOLrAp6SNGxZ2+c8/0rYLyPN
 TxPhYdv/eudBiaxNz4xwwLcCVY+D50fNTYxYhsekUxSiYKsVLobG82CBTOYe856zZlmS
 5yaA==
X-Gm-Message-State: AOJu0YyeZPpZ6TNYdtpjiY8x/QDR+XJgssySgxD8Zrl9pPN1stJGkIfZ
 6K6qFc+zEspzuvxS7RKwK3TDt2WhZndmA8AlChm+nQNQw4S2VFqhw37rjC5k/S9nQp4=
X-Gm-Gg: AfdE7ckxmUyrI5mexDNAxjKW2wBleBTvWg05W2EVAF2d287MSswxF0V2/mjNbd/WSDE
 6mNWWuIwkcAGWRHt/Xhp1SDaIFu+l4yDu1DdwwyZvVGaH2qrW1O5dSJswUTEZb/Disuj7QB5s5m
 Kog8C0OyMqPxPo52EMP96GGgLm+IJ0unJGqj8Dt8yh2BdJXelCzRX4H3/LuBBVM69CVWwSUyzfR
 dt0kyM/kKiPteQDRAB6nCbTl48zzcayUinMAFS07lC6UpzfBbB/QMw0JWshMs06FcA6MR/kPZ37
 fRYKAR4i1Nyw4ala209xo5AT3LkGnJPQrJ/H+xQ+yL4SXWj877MjwFB3ZqB/GZhMlodkDIg1ji9
 BFon9ggThoJTNJ+R50+u3RFz5BejEY2mqzfRkwSGyUTSA5UlLJusE5TEP8sT5FJluApUdDV9uSV
 KM6IZMwgSlB7ncWdlXCcXySu4=
X-Received: by 2002:a05:6000:25c3:b0:472:c330:e3a5 with SMTP id
 ffacd0b85a97d-47f2dce7c96mr14076194f8f.29.1784022834383; 
 Tue, 14 Jul 2026 02:53:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm6464858f8f.19.2026.07.14.02.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:53:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D5565F835;
 Tue, 14 Jul 2026 10:53:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Fri, 10 Jul 2026 14:42:04 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Tue, 14 Jul 2026 10:53:52 +0100
Message-ID: <87cxwpj3rj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by inte=
grating
> them with meson directly.
>
> It covers all existing tests for all architectures, including
> user/system/multiarch-user/multiarch-system. It implements all requiremen=
ts
> listed on original thread [1].
>
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>
> We also have for free:
> - correct and complete dependencies for any test, including:
>   scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
>
> Series first introduce the meson machinery needed in tests/tcg/meson.buil=
d, step
> by step. Then it adds support for all existing archs. Finally, we remove
> Makefiles and configure bits, and add documentation.
>
> Usage:
>
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> make tcg-tests
>
> ninja tcg-tests

This does work but I couldn't see tcg-tests (or individual tests) when
running:

  ninja -C . -t query all

(which is what my Emacs's helper uses to query potential targets from
ninja).

The plugins, unit and qtest tests all appear in the list.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


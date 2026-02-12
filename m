Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B997FEB48FC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 11:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqUQT-0002bo-1u; Thu, 12 Feb 2026 06:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqUQM-0002bL-Dq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:59:54 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqUQJ-0004Br-9n
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:59:52 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7950881727cso20512017b3.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 02:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770893990; cv=none;
 d=google.com; s=arc-20240605;
 b=lenWVdl/4w8Qo37+Ps3GnGPy2YUIjtqsjjkcIG69RgWVrYkEPmQwj2ZKFNcXOBGyX+
 N7d20dh3R/+G3wPrx40BxJFk7XW4cDCQ9v7F6PbQE7hp4/2W4++ABnw2QdTgCTfmsba9
 DaAQQUkggkvShHYj3p79sNGqCMmjNAe7IuY1HwI5eM/Ln+dHv7DGw60rdwjh8I6peZVV
 2VjtF5SUnrdIauPg6DE3K4jRiQIcRMX+JOTlsGD/4hdk1uJy6+KLChEZClW3zEZ+JOib
 g9scgUJ8KBb0xToEU1jItnjWrHpmfdKEcnz8+s0bYczZIc71EkRfPkjjlXIzCca2TNZ0
 Kwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZVrbCSZbccxq6FEVA4SqZs6DjR06QQJ13wdUUSd0D90=;
 fh=2WCIYsl40A352Dxo4B6IOy0bgaLCiK89nOgLYW+Qbs4=;
 b=Wbnr+RyxgN9WZtqvxzD7n4KkR2jhGDOh2fDYp9A8GRGr2D/9ffUiU0BBcKV+h+kSKs
 pJEzrmEFmZf5WdzGf4PxErdid/Q57QmCtlWLzYZ5HJf4r3IyR7aPuBOGa3xKcUH38/nr
 d1jIkb0pSttgVrceXSB4X9nsGx/w/KLmoSlufcbhDGRPw66bGHmTTF6pMjrRbbit2pL5
 uY1IepPMbS0/vZWn8FeL7TFty3tDyNZUKHA9GV2EAIckvQzdfXXEglAqYowOs5n+aVDJ
 lFOXWqGBT3/drkH3Pt8cfIxD2FsX6pnk+GLfgd5bNvg1aLyOiFPLVmzJLHCjaQSWjj/w
 Z4CA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770893990; x=1771498790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVrbCSZbccxq6FEVA4SqZs6DjR06QQJ13wdUUSd0D90=;
 b=U9nShItEPuvJ5ujso/ap7O7b0klXtsdNGwaOzLdNh4A3oQ5Bq7WwguDXxGOOpGrWoi
 8aHixP74F3TkB3QY/ibdbMl1MeWR8biqfqDAUdToXUsc8U8yo15bekV3K0MGWGmPYTBJ
 Atft9O6rHXwzMzDVBA/11qUBOwBVzGHWaMdMtE+Aw63LxKwp/SCVpi08RGW0UO3u98K9
 ldbNLnnqZkfmWunfxI73n0KTsGFBevTZiHsztlk2Cpn221vDBZ/BPqjdxsQGVToP2Z+j
 4GNCkncQksQFek6Kj1+fK2wh7C1VDJOrR1oeZAgQs7xJ7GgXA9CTkBakhnxWhktrzppo
 0YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770893990; x=1771498790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVrbCSZbccxq6FEVA4SqZs6DjR06QQJ13wdUUSd0D90=;
 b=H+sLF3W9rTYkztu+wrj/9s/mxXrmz3chH+CEol98NSxr54k6ZggRsagYrdf57Ll6ez
 vg7SahT3mRuSr4cMHjO51O5ZQdvvBDGyIfv9jZzQ/seUh085ct7S/NjTbO0d2VFTpGbY
 2KLLe0mtugg7V1qoRQsH36jHsw9uZw7ZJslYIsDDwrhs1FCb0+vMWXLZYC+bJLACJQka
 ho1OVdxRsTmuMZB+pyMk0ozRpLwRa37jZQW7PEPlRWVSxb7mz0faMT4GUZG2JS6mzRiY
 3OnTp/Swt6Wpf31WbSd+eymsicZiCmExlSyovWOT2VEaNip0soZzgvToL2jGcYjYzMcW
 LdRw==
X-Gm-Message-State: AOJu0YxhjlTYOv4aWXxbMollh8eeBTrsx0lE8EXTYQnROVIfNUYWR4L/
 gjjABcd7ue9FJOrzk3gaThz9QljeBKfbd/rQBXbOKgD2KRrxpTVnz84g+Pl4JOdS2NVvTVVpKdN
 ecgo1haMCwRudGZRg85808xTHXfQ9rqREzCkW+ALeAA==
X-Gm-Gg: AZuq6aIuaefqynGelxEJh+vXf1+Uvud7qwWg15RFo/iZfgjm9Y101lrjnfVrSPAY7wX
 8QEG9379ozs9zf/ncUlGw6GhEaGpoOSnnih+gUa+HinTQcZBkr8oRt06Ay40B9hZvr++LrSA+nn
 /Vr334U4DDrnY8B9CRN+Pnn6BjCMhHMZ9BgvsO07EyKbR6kcPUUyToXOAykgTeZAHNhWTNhI8f2
 AkEbA+o1uHycsB4yhKZouOvSMVCIEaspSCQnei4VteYxL44Tt9fIipILIBsx19wgXC+KbQF2Txg
 dG1qCczW3f5oprV6USEsxdRlTNB/ZMcuTENUsoMuWcSqgLUjxMRSl1YcfkOR1P7Qz3s=
X-Received: by 2002:a05:690c:4882:b0:795:1e5b:f72 with SMTP id
 00721157ae682-797931fa40fmr27576287b3.63.1770893989787; Thu, 12 Feb 2026
 02:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
 <93f8f250-7899-4528-b277-1ddd469c192c@linaro.org>
In-Reply-To: <93f8f250-7899-4528-b277-1ddd469c192c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 10:59:38 +0000
X-Gm-Features: AZwV_QhUuW1l9Jivyr7kErjs0tzcoD9IRR_bK5Rkbo6Gtl-aCqdZBlAQHB1UJww
Message-ID: <CAFEAcA9YUOxko51ziY3yAOaDfTCEAwqmXnifF=q_mkyotFHTcg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] target/arm: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 10 Feb 2026 at 20:19, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 2/10/26 12:15 PM, Pierrick Bouvier wrote:
> > This series continues cleaning target/arm, especially tcg folder.
> >
> > For now, it contains some cleanups in headers, and it splits helpers per
> > category, thus removing several usage of TARGET_AARCH64.
> > First version was simply splitting 32 vs 64-bit helpers, and Richard asked
> > to split per sub category.
> >
> > v3
> > --
> >
> > - translate.h: missing vaddr replacement
> > - move tcg_use_softmmu to tcg/tcg-internal.h to avoid duplicating compilation
> >    units between system and user builds.
> > - eradicate TARGET_INSN_START_EXTRA_WORDS by calling tcg_gen_insn_start with
> >    additional 0 parameters if needed.
> >
> > v2
> > --
> >
> > - add missing kvm_enabled() in arm-qmp-cmds.c
> > - didn't extract arm_wfi for tcg/psci.c. If that's a hard requirement, I can do
> >    it in next version.
> > - restricted scope of series to helper headers, so we can validate things one
> >    step at a time. Series will keep on growing once all patches are reviewed.
> > - translate.h: use vaddr where appropriate, as asked by Richard.

> Patches 1-11 are reviewed and ready to be pulled.

Looks like patch 12 has also now been reviewed, so I've applied
the whole series to target-arm.next.

thanks
-- PMM


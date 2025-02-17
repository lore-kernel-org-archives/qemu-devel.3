Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49332C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1QF-0005YU-7o; Mon, 17 Feb 2025 08:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Q7-0005X3-RD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:44:24 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Q5-0003Mp-5j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:44:23 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dc39ede40so2127747276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739799860; x=1740404660; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WS8aRhGy5QA2hi62bCSGIx+KXYqVLDd1iSXzxjgysrc=;
 b=LKe+vXdOicQdqV+JKQLQCAOukvuxL4tQ1tCc8nCtiLbaEdGYdhnrAgQjy0m98Q82D6
 EXMYszwZAN3YHE+iKx6ao/4qCVdyggF8xIV9Ib6s8yuOgH0IKItdRJzVi4SQ2bmeyrx/
 BBZgNeVUuICFbiDGlBev4W+q3H828nxe2STtjn/e/dzqvHfz9Dna2d/lymTPhQ73YjMN
 s4F/e6mkzASclURG9Lv+i1gVONLwVb3AA84zntR2VkJzNaj2r5IJKQH7TAw5okalcEE3
 VeoJB/zL6MYX/eQkjGVwzViXfY4AHT4QtFA6A72CT5pLq0ctCCAdAELEhwNszitbw3C9
 OyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739799860; x=1740404660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WS8aRhGy5QA2hi62bCSGIx+KXYqVLDd1iSXzxjgysrc=;
 b=kXeRGMQnr8E+GpNEl8EbZxS4thJt0Zfi65D0UNMLPoVJZ3VKuhRykrAfurPdFmJnNA
 Abgsj3yFBTreg5McjGVQQ/f2RrihgyclAGuprqgHsmu6JDu+dToP8ZpDAGb9VOEwaC0X
 RfCbwlQ4lP2nPhqPIN/BvCdNcfeVE7hHVFzAdboUxsN92iN65LHlCxGXKOcnBDuDzmkA
 mPo+qOERviBymiROcSU1gRhnRpicoIzQwsGQ+ZscQgR/s/qRYeUk0+UKzc5gLPtod4xi
 FRS3PuDViRE/+rRciIcZnjxTNCUj7gqDvz2fpxzvjLlK1nNnvs4i4xOvEnFt2xri4A45
 1zqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX60vKxdd+ltX17KlQ2E9RcD2NxE++9DGqlfBXuYU/jW+SnOlh5aetkVO0/uPHDCliCZLOcbp4RfBpT@nongnu.org
X-Gm-Message-State: AOJu0YyT95hq6PJoPvDb85kf+ILBbwEfJefLH4aM+r2964NkF79Uf+Em
 RmA7cypGrECfA3efZlAL4ihfa8BwcQyErgKY8w4o1TX1JvpHc3FGX53jsbhukLRmK2g0ijgoMVX
 DJqL+ySBeBtAFt4HdxR2rsfYjNxY48IJrcfng1A==
X-Gm-Gg: ASbGncvy1JIXPPxEWzCcMCd0U6m6CejpVzipsf2yPP/7fO+953KN8vy9fBJ6ClU988f
 Ra8yGCNn0waF4aLXnjz5cQ6tg2DEahAiKxIBlJN5WN2CtzZ4Mgcr9bmJKpRaZojHe+OYOvfzvNA
 ==
X-Google-Smtp-Source: AGHT+IFpYxvxRWTmilKCGEFWXVfGl9czKYOHpzj5mEBYVYTF8jfsPbQ6LWVpCy8lfYub6kzMEYSb8R8vL+esUJgqn+Y=
X-Received: by 2002:a05:6902:18c2:b0:e57:fd58:ad51 with SMTP id
 3f1490d57ef6-e5dc9034483mr6835945276.1.1739799860058; Mon, 17 Feb 2025
 05:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:44:08 +0000
X-Gm-Features: AWEUYZkIurlXyk2t7ZCXtPjqmpDt3saChc5MUpnmDuZY1poxEqfhiNYUXlKBaIs
Message-ID: <CAFEAcA-LVKy3pEhGsJO8+hASjoafnAbTSRoNZ9vBjKJL0BYrKQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] hw/arm: Add NPCM8XX Support
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 6 Feb 2025 at 22:12, Hao Wu <wuhaotsh@google.com> wrote:
>
> Changes since v3:
>
> 1. Removed REGS_END constants according to code review.
> 2. Added a few asserts according to code review.
> 3. A few minor style changes.
>
> Changes since v2:
>
> 1. Update doc to include npcm845-evb description
> 2. Add g_assert for register size in CLK and GCR enter_reset function
> 3. Fix various 8xx SoC and board file issues.
>
> Changes since v1:
>
> 1. Updated vbootrom and pc-bios
> 2. Split out CLK/GCR patches into refactoring and adding new features
> 3. Fixed a few misc items from the patches.

I had a minor comment on patch 15, and as Philippe notes
you need to bump the vmstate version number where you
change the size of something that's a vmstate array field,
but I think this is very close to being ready to go in.

thanks
-- PMM


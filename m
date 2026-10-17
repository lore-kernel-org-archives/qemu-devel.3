Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB2CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3X3-0005Mn-RY; Sat, 17 Oct 2026 08:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3X1-0005M1-Aa
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:28:59 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3X0-00032M-08
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:28:59 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b0d5ddafbcso5875137b3.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240136; cv=none;
 d=google.com; s=arc-20260327;
 b=fIU1bHdYf7595uhNlt2y1QvRui46ZVvpVUJejaTWPI6e/Xdgb5L+6EM0KZ5n18izBg
 u8qCB6FGQyLoYhHnHSQowYjepBpNnPuk1Q7HvYq40otS1srYqo37oO9x7Dj9enW7vovn
 Gz4Uq3m5AqHhM5ZEa32YvgTmUdcGhysb23AWDE0jOahMh6t1RPzhuBrMWZGv+/cjb5LK
 TUn/hmi8WxJj1kcxJHGT9520hTcAVy2L79Pn9VeFg/tnWUi0ieDcdJE0YlaVJ9vqdcWn
 Db6cchnmFIWHdLJth5586WQfZOYBhP2rYPS76iC6hH5P7bEsw3bF8eIYgJaRrITJcj7O
 pntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/sNTgQFv/eKcm5zHjeu8YQV6xL+v8MGYv1wNELBXuA0=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=nt1yVQ7CB42vEUmNLUrCisKXALB0r0ZUl3T31Ht4+dt1QLcnyQ4a4oyvusDlhillyK
 zZDS5x4c5AtrzYa5IqTZ3p4jyhUv4Rs2LwV51NS5RAgjMeFik5kZC0+aqV5ROUFoAeaN
 7hhDJ6G0nrKRlStjErSvrOnkiD1ZFBOf+pjuF0R41Svc2HinfmKjxFznUG2brpGjNZzY
 c52GuCQN5hSKMKh1DnLbpcSgbLgChXCBQWuy+n8ui5HnncjrjBuV2YUWcsyAo/yOHMYc
 ZRY4HbKgqebdMPbL0fSaeK0NhXKgCJC98Q1ECaqTLmVXfGoVrRWOT1kSqOVhMvhEEXuN
 nAew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240136; x=1792844936; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/sNTgQFv/eKcm5zHjeu8YQV6xL+v8MGYv1wNELBXuA0=;
 b=yOJcKpa1B0tb+la+qENdrKVasm9mgB8U3t8r00j+PkrxdvN5X7RqtgWYwtWUhmXMcY
 d3gD0RpxLryQVoBTBAhogoXda5gkAuILh85piyK30jsjJys9jeTSJRBXzNJKFbgMOduw
 J+iPL/8cRfAlNOq6kf4px7Os4twqCn7LNwhKW0NxLM4IYeVhGRhKdRTve980VSdLcWHC
 ydWF9mZynsa7lDX1MWEuSKIqb7Q3iCllmgAzQklCdyQ+bMp9ZQZdM6ne5BCxWWT5bp+E
 wtqrhRM/5Rn3dlde/7gd2daNux0msSk1LIeqaqlfnOp7S3XVwaO6HSjjMzSwWOTDw3Mg
 inKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240136; x=1792844936;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/sNTgQFv/eKcm5zHjeu8YQV6xL+v8MGYv1wNELBXuA0=;
 b=FCY7F5l/FQ7IUGDtVoDptIcM/cgfQq5zrKk+f1UQ2qE7vRcIlp0zlGVFnaTXKTLYRp
 JRPUakBGvJ2XYAnszBmQ1tSSfHk8imF/kKEi0lnccsDgFC++s+zIWX3A63HL8r1Yc961
 GH8OsbGqJsniSP3BsWZztVu7aCt69vc8orSrhTngQYKY6CB9tANG4DhuEcunqluPA5QB
 XqxDykERPWMBdnixP3ANEmbAq0Tnod0P51OHUcjtBhnqiZV6iLAbZbdUKu2Gd6mHFAKd
 QZvD2ZrMh4vrYEPopym2LpWWCARdctT+SJ3ZUn2c8q+uLNr+f4+8ld4z5OyyPv8qUVNs
 kyVg==
X-Gm-Message-State: AFq9FYLTb92MrU+aVCc0IKOb2LZz9UQR4Aa2IwiVaQcSjuiK6b+NrIAb
 tmRyKklWyJkn34ValUDWvLbPQMuqVoGj3An+5J93zkEnZu1EBZsV1mIjS4/HZqKbsvW9G9W1kM3
 LjBZACGlRck/AuZ7HN7tAVJ4iCXPO+JIc6A4biuxnaw==
X-Gm-Gg: AYBFou2l5B6BQGPcRJLpd73OxLPLWEYfqPemZeQAQpJiodxG41ER3YC3f6tMiyp4iR6
 s7QAt40E8d9lglbZ7Qp4w+Kp56fOdTpCdUAgpHbPpVBkpCM6LSqkvixmodIrJ6gkDl9HgNybc8W
 UzuwW+Hjyjq7CCdiOuI5TMX/VDy5jRRhu0vrlaJO7YpVz1ijEIGUguSdsdDcQCjkGZOB78yOLxu
 agVPbk0j+6R/RT6E4ztSxQBAez5T/4JZ2r2hwrd7hxbJUeJMF1nn/hHs4YBEam/0mVE2UM425cm
 25KaEwCDkf6fhw4VAxCEGypjb46Bq6cqNXGEIlkjHuXZd+oy6awys2IIDr8rzwlq9qpa24EKMHn
 I4l+b0BABwz7Ohbozb/G7gsFxv8f5sp6vDFx8Qsg=
X-Received: by 2002:a05:690c:e3e4:b0:8b0:cfe6:29b2 with SMTP id
 00721157ae682-8b0f21f18e5mr10117717b3.41.1792240135798; Sat, 17 Oct 2026
 05:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181111.60491-1-marcelomanzo@gmail.com>
In-Reply-To: <20261015181111.60491-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:28:44 +0100
X-Gm-Features: AclHuK9WBB_vtuGtSl_k2-oNO_-dZMEfrgROiKsejIYp08Qd3q_CGI7Wc-ADTTc
Message-ID: <CAFEAcA9A-hU8bVJdN3c_k4D_dPds2VOgMV1qnHq8LUBJQkfW2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] hw/arm/raspi4b: RNG200 and thermal sensor
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> This series adds the BCM2711 RNG200 hardware random number generator
> and the dummy thermal sensor to raspi4b, carrying forward two more
> patches from Sergey Kambalin's stalled Raspberry Pi 4B series
> (patchwork series 829638). Patches 1 and 3 are Kambalin's code with
> his authorship and Signed-off-by kept, adapted only for API drift
> since 2024; patches 2 and 4 wire the devices into the SoC, and patch
> 5 extends the existing functional test.
>
> v2: thanks to Peter for the review. Now based directly on current
> master -- v1 was written on top of the "working PCIe and GENET" series
> and so did not apply to master; it no longer depends on that series.



Applied to target-arm.next, thanks.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E993E7E0C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 11:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpP23-0000Bi-Hc; Mon, 09 Feb 2026 06:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpP1s-0000B9-IR
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 06:02:09 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpP1q-0006hr-P4
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 06:02:08 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7946a1f2430so24396987b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 03:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770634925; cv=none;
 d=google.com; s=arc-20240605;
 b=btsx1jpjQ/PQ7A8PsLR7yLQY0F1Uh97yMb9g8CwnY/zuSky43OTqULcIuGYIgpLUth
 uWQxXhJ8zF5JtSiYOqx9Zqo6kP8JAvl5e1abxT20e0k5NKQ7YXkHHkPqld8A/7pWGORx
 yCXC2u+9tLhrDPM6m2kHd5Ep0LoVefxPqJiwFvgFs96CG7G9sTY4IZBU8TyDELYNQV7Y
 ZtQYZoOORcJ6nll3CmYwD8oJcxquSftQOXlZyYjfYCRy6erWN41HjNTgFXDPWmT2mTzc
 zPMQJfCdOcQWnugTgCCbyh6mMbkyx0tlZ4wAJCrJERqZPU/AyOxvfKiehMLo79CZWCbi
 W2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YTDWMlMwFhEL5SNPw1PsI/Tc3IjrV4EG8h9hhEEnsw0=;
 fh=55BsMaC87J0YKrkigeP3NDJMrNxySbXKw/063/jMj5U=;
 b=NesPk2+7v8cU7+hY5r/XbS9eLVDotmZwAX7VajW3lxjqz1cFtJlTjJmaQ7b+mhvZ43
 AS4kr+32yhKCQDbO1CXKB5QTA42QBwwkmudhhltPepHhJyBwKoi66LR0D2MJoJeke/0e
 Jd8M7+7gdbo8Wa56BPeK95irj+W3gCR7xejtGpSqMNggaiCIpStYAQzrHCFwDtKhzTHC
 xY7bMxTZm4NpOmAQs5lE4830eg54j1pOu6tLTILzfVrSMcxTlsaxRzvzyge7fTJ5oayI
 n5cko1kA3NEui8KHNKfnnuTSfBzZ2A0eBOHI7aNdZaI0+cE01sb4jK0Cgyo/DSdERwBV
 CkWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770634925; x=1771239725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YTDWMlMwFhEL5SNPw1PsI/Tc3IjrV4EG8h9hhEEnsw0=;
 b=IREk3rEyupjUkAbqmBXUs8VijN8J+bAEwwGXUA3jVCd5mVYxfmKl0rlcXt6sxx1lEI
 PRtHeu39ZNGrD8osCWTlbPWBbuG9to0MZxj19wwsdV+Hsaiqx8k4/5S9OoIU+MZJn9/d
 8DOT3PHa2iUOTDvktbHfSp59W2ffqDEtIG4ShVQeE4kGOrSi01p3Ymvnsqinh/bKm1Pi
 1wV1kb3gIwxT8Ago5/3auUCPU781mPoy03K1WTUrVPZ9/30GDtDCc0LmTj5uM/pKT0F8
 iugwvLpS4pCKxf/tafrMsPh5XBrFqUDbvKGvCd1WLtWJlTnP7H26o4nQnluJBpmMu7f/
 qqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770634925; x=1771239725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTDWMlMwFhEL5SNPw1PsI/Tc3IjrV4EG8h9hhEEnsw0=;
 b=XT+gVgmbs2K6tucHmvNRxL91BhsM2+sGphJ3FNidqPSCkZGSC++Agy7NjW5ixZbM1e
 QHuawvtCXjGSoHcEIZXjUTPtzsUhxDhAGChnvicM2YFvEE1HqO6L96EHgpf7ELxVs8k5
 WOVUbDwEy41s/NkbpPFR1tvdZbJkur75RnoMlIIYnapBEwbYeSbzjbgXxXJ6mTgXc+/r
 UjB1x59nb9HLEh4cFVoNGfTxAHy7xmhy4/pr/f7doe2NGrNn0r4AHUNn7b2+Hpz4W+dF
 7orRaVG1RBBVLv9yWn+UqjgwmPvTaBCLz/GT4JL/DJcHPQcHWDujirqmYi2OgE7YC4cx
 TKmg==
X-Gm-Message-State: AOJu0YzBGwYl0onE4E7b2b7d4YfXAk3AfsVHyj7tqwCmMeylyAjSboas
 GOfqAU2GrvYGg1KD6HuR4Ua5ainxl+Q7KLrhw4JiZM9eVN6Ay+RKabDto2wXPO3ZhYw8wrio2Ka
 bNSpF7Uwf0a0VyKfqAsfawaC49zIJqvI6lhBELjdcGA==
X-Gm-Gg: AZuq6aLLbkLyoXnYDS4CI9BCzKKMP6jaA1kQJYeXh0qngGyQKw617osv3Td4CA0Dflh
 ZjS45b6siHgTVHmW3C7667Dbr5uHyaI0GGUr+a1/xO5oZmH6srT93rqeUj1YR1ZrS1C8xiVN2kT
 huYxKWS50Yq6z+geSwAHp7iB22vaujoH5wEONQa7d6quxNYSMZS8GG4km3ILQcHcwgN23Tam+dS
 gipIHzF/N+SCu9QcPFjKu7pgTuPTeyP4sVsHPP4d/EWOvSQkZRmkV2jW/ANai1oRnBQLseHcHRv
 Ud81BDm23LY7JGovd8kUwUHwzd/elyTZJWbwhl6uZ20ySEWdujaACKVzVBtPVvwm4g==
X-Received: by 2002:a05:690c:388:b0:794:fcd9:4aa1 with SMTP id
 00721157ae682-7952ab88287mr99072977b3.69.1770634924919; Mon, 09 Feb 2026
 03:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20260207225600.1004788-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20260207225600.1004788-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Feb 2026 11:01:53 +0000
X-Gm-Features: AZwV_QiUj2c7iUy5BeH2IbHQW6ZPTm3m_NGjiK7gsYszSEwfq610ET-X-Hd0UHc
Message-ID: <CAFEAcA_mLq0wVix__zGivZN=POuAkfUOESag-BxcTne_XqrOSQ@mail.gmail.com>
Subject: Re: [PULL 0/1] baum: Add copy/paste bindings
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sat, 7 Feb 2026 at 22:56, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit e8cffa556dd85be1ff7fbe9d19b19f33a0fb18d9:
>
>   baum: Add copy/paste bindings (2026-02-07 23:53:41 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to e8cffa556dd85be1ff7fbe9d19b19f33a0fb18d9:
>
>   baum: Add copy/paste bindings (2026-02-07 23:53:41 +0100)
>
> ----------------------------------------------------------------
> baum: Add copy/paste bindings
>
> ----------------------------------------------------------------


Hi -- did you mean to post this as a pullreq rather than a patch
series ? It doesn't seem to have been on the list previously.

(The patch is also missing a Signed-off-by: line and a commit
message body.)

thanks
-- PMM


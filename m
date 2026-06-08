Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9262CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXY5-00071r-50; Mon, 08 Jun 2026 06:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWXY3-00071e-Hm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:49:39 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWXY1-0001Qi-CQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:49:39 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660323f7b27so4286452d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 03:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780915776; cv=none;
 d=google.com; s=arc-20240605;
 b=d5J028r1B7N2Y04xuicjtF8/dV8ivHUUvRioM+YrC4cCnR7FekbmbW4GnLSarnqfHg
 uoS0FIvAY0pR3OLm6YJbbIirYHQa+edM3ryIH1FiOncG9esYzlV2lfxWoS/lI0P7rTrk
 5X0yA70fYN3zmDYlZI9Y/OuEs8Gh5gESyTcryQPcyfJaCLLnDj2LlBVlfbUdPws3L3yQ
 bCn1kFyYtkWwYYLwqL8GDjrMWr145wDj8lAQaw/LBIZFx1zS1ZTA2ZvSfgWuiAsOqeH0
 2Rancj7w6YLZYL2xYSHWIYVWuc4UTYRNEb8fckSnzc4uzLfVymy2ukYn+dyZj//hey9q
 ue+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eCPllJT2xO635yf42qMV1ZL2QitlN4gYtPEJ7c+Tw+Q=;
 fh=2Ql2JQXYYxz1RYoZmvk1GClubAUYYhKeJe346T0P6v0=;
 b=U7G+m8iOYX2ulMIKXGnYDM7lIfui6cvvAWdCYrL5N2zbJfxKz3tiOfVoDfbq/5ayp+
 OXq4jaXyOk+UV8OFLNXMhbi5kVPwpLAtrnpkP4h6ZWNRQLxSH2WMQOjR9pjpxLLSz3Ws
 jx9/j1aWNITIAw96xNHnvkJWnfpmlPYMmZd5uJtsmU/KLUKi5dF/319fLoeMMY07KqSM
 DMmVA4vAFshlMeMmUaZA5MfRe6Ru3qQcYt1E85S2uMocsNTyiVGpwk0GZ61rTeheUeTY
 X15E8toDr45q5o5OVh9bSDBA8rIk5UCv9fW86O7KoDFhwMrietCtFSbY80FD4z6/g8UV
 dSVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780915776; x=1781520576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eCPllJT2xO635yf42qMV1ZL2QitlN4gYtPEJ7c+Tw+Q=;
 b=ZMIIzteglJiTqA4ecLpLVcspSu/sfigjAcW84PC9XEDyZxRaBgPpcfRvSXYE+SGwAt
 05+Qah/cC4x7ZLnqWz7aBHJoaQKtmPUVjLeWAR061Zj7XNleVlx01XYfZ/mRDQzOhX1v
 2h15RbrgTfegdAQb2haW6Cmj7K4r3muF3yfH1EyQZvh0KLqlLQzoM3VtLveADs3opdI3
 G74tNlOi0Jk7M61KaW3p2jE9X5JIujoMjW94sdKn3zBsbOB5MWGScxisWIOFOKpDRCpd
 ECigoINtQVI8xMUFB5lh4qLHkjF6QnfWPEUvaNrNTHjE82uAUGoNfF7TTILhxXZuZlDz
 /+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780915776; x=1781520576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCPllJT2xO635yf42qMV1ZL2QitlN4gYtPEJ7c+Tw+Q=;
 b=VexWhbFh2nMMMS/E2+HX+ogZn5X7CnN28HJLeI28YD9bogmizkBYUXkh5dB5zWF3+s
 6BPnX2n+6vcEj8N37U0auzYtyCdVkKkMozqusQjj1yMJ3HvxI2PoWYs0B4+gzP4+xhE0
 bl60yNO0OFiva931Tm2gu/c6L1Awe3nR1lYw9wbWnbueP9gRF9pm/QmRHVTVg/b2SMfw
 OhLPciEEj3EozD8NjZS+03g/ZKCAi2SGswK5n+i7lmOwJNxKNJlMru8lIXqY4GJyBPGQ
 3ggM/tG2Ag61EUYoGtNGyZuzkPY2I65Rsm5qUC8rV9iGZs9mPVN61sSrG5Xm0A9r2DyR
 rKuw==
X-Gm-Message-State: AOJu0YxpboyZhUNSm7JX2cEopY9oWIvRw9MySHLFegaFv5ZsmD5cQz3g
 wiuG17zpm4ao1RiaEfilHgyyfhC4DwOk+utW5HcVpZWeUqlsjsFHdC27YgSpbCwCGthCY/rpVRk
 vyLK9FvSV6mSJ0UBcZMwowc+kHJI1m6snvvWZMwenrg==
X-Gm-Gg: Acq92OGgxuvx7ul/TzdP/TcgYAMcRuiId98yU/PCyMmhyTeIgm9UH1MtEsvGk0s7qLw
 E7+dLqDuEQm+j+z5Ol8VQJtJKR6AYB8wnBGJwLOIVvzzPM5jPIZjLTNejNVCGWt4t2HaJ/m1xCr
 sMbDxwB7gZeQt8doOvhKoQaL4gjesRYZS03Zi1iTicWYUE9/gcWx42q5mG1D0L3Uw7PxXShIUQ3
 ylQAhR2M2Mm0frjeEs5hiwMJj3S1pS0DAdBJ8HFA0AnQDXxu57hDj1cbHuaOaR//INBFjDNx3gT
 bSfIg0FEjLpTWDnnwslzFGoA7Ay0STuiW7Twca1w9fnVJooqjjwl+8Rj750zjO8wbPMB9ifR7Cl
 Zgg==
X-Received: by 2002:a05:690e:4804:b0:65d:81d3:c1c8 with SMTP id
 956f58d0204a3-66106f4e0ebmr7869614d50.45.1780915776033; Mon, 08 Jun 2026
 03:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260531153354.88909-2-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20260531153354.88909-2-hemanshu.khilari.foss@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 11:49:24 +0100
X-Gm-Features: AVVi8Cecz8WqKkuppWp6jlld-oDo0FMthiKdB87xZmUrgYGoV9JTXX4KOOk5Bqs
Message-ID: <CAFEAcA9ABygEkZPs+bQQCESiPCR7D78uKpFv=AuoxH=hjsS_OQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/core/qdev-clock: Fix potential null pointer
 dereference
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, luc@lmichel.fr, hemanshu_dev@proton.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Sun, 31 May 2026 at 16:34, hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> qdev_get_clocklist() function returns a pointer to the NamedClockList
> struct. This function is called in qdev_alias_clock() and the returned
> pointer is immediately dereferenced without a null check.
>
> Passing clock name that doesn't exist to qdev_get_clocklist() is a
> programming error, and so this change is not fixing a bug, only making
> the reporting of that programming error a bit more helpful and bringing
> it in to line with qdev_get_clock_in() and qdev_get_clock_out().
>
> Cc: luc@lmichel.fr
> Cc: peter.maydell@linaro.org
> Cc: hemanshu_dev@proton.me
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
> ---

Thanks for this patch -- I've applied it to my target-arm.next
tree, so it will get upstream in a week or two.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207A1F8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDnKT-0003Zd-Sj; Fri, 17 Apr 2026 13:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDnKQ-0003W9-F9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:50:08 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDnKN-0005N7-Ri
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:50:05 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-651bc8f864fso663403d50.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776448197; cv=none;
 d=google.com; s=arc-20240605;
 b=iG5vLqZBUu4muSmU0T0F6uKwLb5fZEkTo6i3NFjiDfd4cqtOQy3JUEWaQGjhCWRtxh
 68iKljb90I9GQydDsPiHosTmb4X7YSqhsHEgLpRQtlIpNqaxHv4vIIUp65WK0+Xzpe2B
 rrJ1XWoQXiB5BGVOJEUAEcG5NLC/vE5ED/7u+/J7YmsejH0CeagwbOq4rHOTxRRB0NDd
 GOnYRXvnzKcqlaMRaJbe9QrTeQIthvlg+j/y+2b5ooA0X4mMM/MaulnFlEEXBTjJ7L/X
 OY0d6AgRCaKEM555sne7PaqNYhEqXuAB/lmb1C4TGuchKPH6NO2Udl10KJCb/4Vwyfvj
 C4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rVU0YHiHqJ0pbq4wpCrmcbdTCk1MIpflQ9kNGlpo+E8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=JW14gA12F/USeKR2fbl3cn+mF3bTT+mAwBw97r2EgpeoSklX4fJCilQj9c5xMXmAZ0
 EaKd2lD00qVJO0X743MfVdIlFVQ2nVtmqh+yYLWpAbTOdHtr8SKVRPaP3jykrHZGerEj
 +29Y2L7gpj6WLdSvxIgeBGwLijSxpW1QW+3835XNcmaSLkr5zGPoDOQSyVCS9WJyh82T
 GkSc+zg87IkwrDzT55piiEEl4GTGQbsawfTYFCmAVWPrCl81z2glRn0/iZJ7dnlp0RYL
 B5QuRkmFx9QUrtI6Zc42NPRChfMu+VP060xHbq1ST8biEtueUu+P/ZyCrEva3zkicH30
 zdLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776448196; x=1777052996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVU0YHiHqJ0pbq4wpCrmcbdTCk1MIpflQ9kNGlpo+E8=;
 b=Abg0drImxZBwdnby20xC18FPcPARXq4+PZeu5Me6g0AMVIro+dSoxTakFeHWFIzVwb
 dFkIDInMB5tAmYohHHUD2AFveRwao6KiTq7oieYsACfEjAl2hujKT1t7FlLBnCNTS9af
 rIgAL+r0pi60xqwtdYDzBgCIgnaJ6QaMdg1Uc8wqfQ1PDp1mBGUgCb0WWsaoGhc1k7t1
 HfHO3Ai9cZTMo7ZWoHiX7MzQaRh84oy3o1q9Ok8orryTWCc+eIYRA9TzC3PcjHQTv4AZ
 I5POPbwFvdmleTqu+I80j78SKtB1iGx7HEsgX2u6Sl0/3Ml2KXhFp+1+8nE+RE7SDShH
 kTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448197; x=1777052997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVU0YHiHqJ0pbq4wpCrmcbdTCk1MIpflQ9kNGlpo+E8=;
 b=Hy3We43QyTJrhTvnJmfpF+tlUB4p+neY/Lp4S21OxaBPadSYpBH6kwyZnnUSjvAs1Q
 ZovSbksPeT0g7ypOnN6LhhJog2TFeUQJ2L6BprbdxHP0BhpfVt78U94A8hZtM0YZ4fVg
 gjgrxBzIggySjy8meJ4dhcKgugRC3sFwy2pqL3wU6NZyHXBRzcPqn76ycfGVP8k7WhB8
 vv44ASKQwYy9pBS4uFbv6dHwtk4g2DBhvJsuP+HNxM+1K6lqVAWJNJ6dI/nr90keiX6e
 RtARKbDYGrZlmqXdnbj1yUiHbitnV+NRiR6iib37ok3zyO3Pb1PQqGgk7gpUPs720s1W
 outQ==
X-Gm-Message-State: AOJu0YxgFQ8MneHBSRAzZ07Dj7mVF7Wi+QmKxf9my3kWRTJmB5+lqu7c
 Ry6DNOeUQVtH8WjkOsRlXtmvVSLhkwgj6C1HYwh5eP7ks5ySk/PMC01CZQJLQ+CipTryEkl52Ya
 l4OpjvPsrnRawHtH4bxylZMEnPlkmgCemJ/XcpwuCx5k8zyeQLpgm4dUg0w==
X-Gm-Gg: AeBDieva75OuRt7exfnZzZ0F6vkHqjDa66Wsi1XOi6WvFmqkKKLje7A5/agHO1zr0Ne
 FXNUcX231WxFwA3WcZT93TVHYvwcx1vhzeSQErotmjnmsY4BAnDFbCaxgJXJjmThIhhTn9Zpl+Y
 SbCArk8nr4Z15V5jdb86lcYptnO2BZzCkMg1hVHHydot6w/q5Mp61knBdpxyuqj32/348jBSImE
 Em0A40KUjnjWd57UTAEJPO/dLG3AhVDus4zT+OBHktcFfikKpz5kaRLCXCoAV8GjrtuHkk2JtJ3
 j4EipyyP8052a/TWTzdeFv0Ed2lPTxYp2Oma9opABgs6/LJ/IZfZxLOwkwObLNCf0O2ZCaChu1K
 M9w==
X-Received: by 2002:a05:690e:585:b0:651:bcb6:888f with SMTP id
 956f58d0204a3-653108399a9mr2692291d50.15.1776448196507; Fri, 17 Apr 2026
 10:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260414132100.53861-1-philmd@linaro.org>
 <20260414132100.53861-3-philmd@linaro.org>
In-Reply-To: <20260414132100.53861-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2026 18:49:45 +0100
X-Gm-Features: AQROBzDO481f66WmNUB7K8xzl23S8kkG0EHWVo1Cz2qOwU947KgpthQG2OCAmw0
Message-ID: <CAFEAcA9zveinqwzN5EEahO64RLjOO6ZmVY-tdGRAzjhFzrsb_g@mail.gmail.com>
Subject: Re: [PULL 2/3] hw: q35: fix VGA text console with SMM disabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 14 Apr 2026 at 14:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Work around black screen in VGA mode with SMM disabled.
>
> Required by NVMM, HVF and WHPX backends.
>
> https://gnats.NetBSD.org/59721
> https://gitlab.com/qemu-project/qemu/-/issues/2608
> https://gitlab.com/qemu-project/qemu/-/work_items/3085
>
> Patch written by Taylor R Campbell <riastradh@NetBSD.org>
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20260413170407.57574-1-mohamed@unpredictable.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I was just looking at this change, and I noticed that it still
has the same structural problem that MJT noted in his original
version of this patch:

https://lore.kernel.org/qemu-devel/3458e5b7-b53e-4057-baea-03a729452255@tls=
.msk.ru/

# Overall, adding an early return this way is a recipe for disaster
# to happen - if not now then later.  Here, and in mch_write_config().

If parts of mch_realize() and other functions are smm-specific
then it would be less bug-prone to factor them out to functions
with "smm" in the name, so that realize can do
   if (mch->has_smm_ranges()) {
       mch_smm_range_setup(...);
   }

or similar.

As it is, it would be very easy for somebody to add new code at
the bottom of the mch_realize function without noticing that it
would not get run in the "no SMM" case...

thanks
-- PMM


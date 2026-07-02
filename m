Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9DDC44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIg2-0001Ba-T4; Thu, 02 Jul 2026 10:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfIg1-0001B2-26
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:46:05 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfIfz-0008U7-PA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:46:04 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664cdeab266so2650375d50.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783003562; cv=none;
 d=google.com; s=arc-20260327;
 b=Z7TzVo5oReWeSdXTOYbJ6iywNt4MBA3fs2bl8kLoCLohBWyExBsdCLu6v81fevS/0w
 5/pFMrxuFGQb2XrtitmDy45vK7gZ3uhbD2cWr2ORlvCxhfzFFGF7r0OZGgEjPY7mR05W
 BFGs1iuHyyztMsPWXI8o8O6wTJlHjgT68QBT9tYvcXZapL7/uHmOvheRSkDxjXF4zFLS
 5w8jxKcqvVSc82tWPOJ3kOJUmVsO17xLnwys7O+tY82DHMaA4q2uQyMfL0iP1rkd8qOu
 KJ5PKPLNnsS6W3vyjm6CIdeqOLGpizDF8L2kVX2aAEs6klDL9K1Tq5IhfOMNvZPAMI1a
 np7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V/XuN+kAuWIj2q7usufUAWom2uprrhjVLsVtB5cdVaw=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=I0YPUdH1MWUkDBzO19TaVZjVwSkya6COIT3y8MLtkcNn/9ZLF1nRWMd5plGQHQONr3
 ctAB5f0ti+kDXFi79kaNm5CtcvF9q0TpOImMWrgh0fTYss8zrlrkCE1GWinyxQh8xE0/
 FfbOHEbsVq79sULv2jQMRym4z/tx0JbfL50rU4PPQYPMsn7w7JRUMhHopFToqT394Fif
 ewzs9O3+J9wnYU9nwt5wyPUwR6hVNE/5cwPedFbhZtu5itXMX5zANGeXa7vujzQnSJA9
 ilnQiZXXZ1jJ9P1gXCCjBUAqINmvx36SZnvj3KqJeQj2TGQCbNMRq1tTRKXu8JnxpZBe
 7qdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783003562; x=1783608362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V/XuN+kAuWIj2q7usufUAWom2uprrhjVLsVtB5cdVaw=;
 b=kD8CuzUDUBdRPh4k1ldJ4UvxQNnZGXEB5f1kKyOCj4XSQuUXIr8aHbl/5FNR5IoYFp
 vH5XEQHi/xTBaPr8ztdjU9DRZCLONZpyTxlsYeTunFH2w3GaZ0WeK+j23Cxd7kXws0jg
 5WSah/iwprUdU5c7mmm6vxElzbqpMHSxwoDAb7QtdYnh+x4adLbzdwx5z3M+Pu2bLsXG
 ZU5Tv4glhmSUreDOn7mI6Na+ioTblYOZe5y12baqh7lGESmBUN5M2oHCUTWCoSFp3j6H
 nRH9qUbh4URl7qb8wIl1WH2xrS4nDt5CJzvwfX76h2bY7AzEbsOjHDzFnbejtE/S5nIL
 6Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003562; x=1783608362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/XuN+kAuWIj2q7usufUAWom2uprrhjVLsVtB5cdVaw=;
 b=T/3Rtpfo3yQg4eti/wTM3Qphxw6PSciUk8hztCEl14w2yKlGZFTQgs4L2ZTvqnNzhk
 bjf2CwiN6aApNi4Mw1/PtAi5x8Svis9yHTxQ1VT4dgmgE9jqZboD7Zk5UnTh5fvVMeNf
 Hk74ZCEfzcsSKD4LpOZMhUfdaxNcbxqA/ElvnHbdYgwC9GaP1BNRPbWObtiNA7dhBtdP
 T92V0wmay0Ij0qY/6gXgZWOTU/ibB8P9tf8xoIkezJP0YA8MMvHVyRqo1oFGYesmIpxA
 rd83xmluAPOUJgf0bX3fHrN7vqOPDH2JqK+CfYZTembDOPvdt7JWsXb1njx+TYwvpaWd
 3bww==
X-Gm-Message-State: AOJu0YwjrfSCm9ATX9lHH0/yYqHnX7XN8ks1oTCm55fBkNaB/LVBHY+C
 QoZ2SAx3+U/1yl3+ahetDXcTY0FuGoOGiEA91db3LKQJGwbkfTZEztBwlYIXaILhzRsWtDElPqN
 sbb1PgkKtEMqEnA7bb+itUoj14AXsuVjGRQ/WvHsyJQ==
X-Gm-Gg: AfdE7cmOO0Gti1GyB8js7m5/kvRAg720vxc+ap1wP7yUSjDNx/T1a3K62NNhPTWode2
 LPpU1dCKN+u4+f7MGs5pWAgv6gHzFfDefsfNjixb/fEGEd7hU2hr0s8lZBYDXBJlnp0rLMr0a1v
 wVQMcH5X4n8zCiy+oPXbbQWCJzXhA77H9eTL4IV4vY+v+SptvYNNy1heHCcFjcx1thg2fNB66BB
 zovlLqNNasmiXqrhKMs+pJK6wnEBKax3VxGYyzo09n4HN2Thc2MoVwAx4esT/M4PbvMFvL0RF1q
 3DF5Y+yvmKMkQ7fVjkLPsunLKQo4KQt3sYLcPJv26+52tQnMQC2ht5nv
X-Received: by 2002:a05:690e:12c4:b0:665:2100:990 with SMTP id
 956f58d0204a3-66521a1eed0mr7183330d50.28.1783003561829; Thu, 02 Jul 2026
 07:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
 <CAFEAcA8R1RXrGo2xov-4gKLQXX=FTVKoK1rGuxuYmBo9e8SN_g@mail.gmail.com>
 <CA+1f7BD2pVP2ByBRbwbHBRWNNuZHKdM_7xSVSmPztEWw1BbVbw@mail.gmail.com>
In-Reply-To: <CA+1f7BD2pVP2ByBRbwbHBRWNNuZHKdM_7xSVSmPztEWw1BbVbw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2026 15:45:49 +0100
X-Gm-Features: AVVi8Ceh5Mi6Q21hlZwgPuzVtjkrapNMI0dwIIC9hQk1MNU62sEJ_UrwgxYaUk8
Message-ID: <CAFEAcA_jkzy4evQOefKz3B+=wzcVULWr+swVP4=zKkcbcE44pA@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] target/arm: add support for MTE4
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 1 Jul 2026 at 06:38, Gabriel Brookman <brookmangabriel@gmail.com> wrote:
>
> Sorry, repeating as I forgot to include the mailing list:
>
> Hello,
>
> According to ARM developer, FEAT_MTE4 only implies the existence of
> its 4 subfeatures, plus FEAT_MTE2, and MTE_PERM, all of which are now
> implemented. There are no features that MTE4 guarantees that aren't
> either already present or introduced by my series. This means that we
> can now claim to implement FEAT_MTE4, and close the issue.
>
> We can also add it to emulation.rst. My apologies -- I can't do that
> right now because of my current role, but it should be a trivial
> one-liner for whoever picks it up.

Great, thanks. I'll send out a patch which updates the docs,
and close the issue.

-- PMM


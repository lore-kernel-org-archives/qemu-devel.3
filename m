Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A9FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENL4-0003D5-Pl; Wed, 07 Oct 2026 04:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEKA4-0004R9-E5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:26:04 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEKA3-0006v7-0K
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:25:52 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4f58dce2ad9so1022267b6e.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791350748; cv=none;
 d=google.com; s=arc-20260327;
 b=LqYccmYw/FgAypBtUsoXnSg0wAmWHZe20irmH1FlLTEh/3JZGnkIKAakkgPPbuVHYa
 GilGfMUx8hoo4HUeSrYKZ+vVZyzJO7fEKC1jvzfcl8v91YKE9y7L2MWFRwJcxNWagEaN
 uhHuK+vS0OK5YNLBGqUpUbEgPcWI34m2L/0Yjx1q13ZLCgNM2H6GfHrW5a/qDADnKBCt
 spTlJa8axqCfhzd/KjA99JOaw/vhbKXAUOcBhJ+P2jfLb2+VfL7SfRkIzRBG/XrdSPNO
 TQuvCpfZD4tugnyv9wyBFSxT+sHrY/fT5DpANd5MP2n3P8VL4A8v0u3jtUzsDj9+Dqta
 s2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HkwWpUWf1Y20pZlisA4CbYTVY7eX0xphQ5BeJwKWgLk=;
 fh=QZd6b7RPJse95XtoxjmJpP3S8cFDya7WPyrswNQjLr8=;
 b=qdrZKwIbIvH/bAlrPOGkFE5Dvjr9T4wAYDxpOpzU0l1Kk1wIPKDbMGr4Sc3g66wJcL
 efTa1GEMT6IrNLAG508uMOek7xLHtSHvJ/b0h2bhksd8tEE9rge+NFNi013nAl3WLmWM
 xBHVWT/yvSN91smuR/zumNdrNwJrZeURXNtfFVx/TgaLySnXAH0/vDKnjba9TPa4NdhF
 N638a+FFZoJMiKwGjIJ3wdkWudKPzcJ8E6kmLUKEtdvINnYNkUgn2+hUSTtv0XGWgxIu
 IUdb0o2E3PcD7Iio2MfzMTGZSk1zONv/dVaI1gZeW/1B+/YcsSM3rYUNJ33rzfOT7gMs
 M1ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791350748; x=1791955548; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HkwWpUWf1Y20pZlisA4CbYTVY7eX0xphQ5BeJwKWgLk=;
 b=X7gBRniHP0NdgOy65hvtJKSMigkxUvVqbWNgqwo/FyxTmP8k/Fr8AHGNfv++yPQGsC
 qd8kIEEVf5Ew5NQwDicW7te/icI5r5ysl4b2y6XyUTEn5rc0hXqJkzKziJ7ge3pSATSy
 h2cYerd11kvV/oBJpAWSN6XrohrRDCpyWZ1447ErIzLjrdsCxB1R5zNQy31PAUPtcIsv
 ZpjRB+7qBVcbB3Wa64SJ2NO4ZXWmUcoZ+lHJvcX10AP0dWnBy8xVS8u/872A+vsUBGJm
 YAStOHG1ApukzqwlQXN0MgBnls5Op438HO5dHxv7I7Dgddlfq7uzhAnkbDr0u3BuqmPD
 P5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350748; x=1791955548;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HkwWpUWf1Y20pZlisA4CbYTVY7eX0xphQ5BeJwKWgLk=;
 b=OK4HXHgeBDYAVXtzDkkYZnsuQgk1qFTT51IC7oexgBMLdugf82TL/i0FysiC+KAoCJ
 jjY7ekbZEQoV+LlxSvEnN99Wrk1NJdW2j0y3WFyb9qZMZC2xr4E2tVEOvKq9SOUMMM5c
 zm6quAV/zSmAmExyDXq+6IC+lXsQPFjsQ/oIPSHY1qG5wgC+A6QWEO9x2ysIntpVOu9i
 /qL2VTZIvavU3XcbKSOHaekESTvfbx9nJRma0lsdbaeGD7hWdCjGtvHm9xjmRlrvXl1d
 ciuHrercEPVxpQszM0wMW11oI4kk/lglJ2TS2bPfVs9LPJB40pFkIb2i7kPnz+bjc2oj
 +VgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0gv80Uc4x2aL1i1LXzXwYprvWktrgZ3ck73rfr7Wmkl5giENX1yeh9aELr20vF18DOaBZ/qnzSfSt@nongnu.org
X-Gm-Message-State: AFuF++kVfAptkuHs8eZLcl8T+J3YXgCYBhY3PZnwtqATJ3YOB08Tbphb
 NP0haWWO35s9ne/YJvTGitvkD57lWYW7LtRAgn3Lh013XBuHCSH/oA93ugouflqu6MzacCUUBhr
 +qSvaTxD9EwIDQfk4un0PZEqfQ84DZuwl29EPxHMgeW2JzTUWH3EdoLg=
X-Gm-Gg: AYBFou0arFRO9qFVEXFXLYrSaK98uQUkPE9U1z8IcX/muIkvY9gCmgpj772v4NHrxyl
 vXwMLZ+sC3nGPs2s5LtLAXg2wGsQIoGep0lTgnr0JMBNx2JhmyAdOyZPEiQ1/1Z1AJfA4rWD5ZD
 AtgxtX031gmIFmg360quLI96O5g7CaxlMzMQwug39xP5tB0/3/Ar4X3ucAe1GKIBdsS9CDued+j
 gTykJdNFmwPehsdJGK13wQNPkUN/ccYg27+5Myb8soq3dXcJzw/UDxjOVOm49szg8gWH9jKrxUt
 YlrFVf085UENSAQ1SeGui6oN7p+wOMhHFKn8E6heXCgL9CTGMwrbG/cz/020jAWO9i4SLCJZYkK
 hH4iF2hn8eNJuQJgRomn5AU66YSRJbNcEVefaA3I=
X-Received: by 2002:a05:690c:39a:b0:882:31:3af9 with SMTP id
 00721157ae682-8b04f12a3f9mr2223927b3.9.1791277438337; Tue, 06 Oct 2026
 02:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev>
 <20261002070925.2627344-1-fuad.tabba@linux.dev>
 <l5hcpwnktn2hvbt55ux42xzb2euc5zqohnxtaiftr7lxynfx2g@myyytd4e4owp>
 <20261005214451.1036668-1-fuad.tabba@linux.dev>
In-Reply-To: <20261005214451.1036668-1-fuad.tabba@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 10:03:45 +0100
X-Gm-Features: AclHuK9ZcFrcVklEzJUIN7JogE4OZ7PYlAzE5S0LpUa8UAR5XOcsOZ2nhDstIMk
Message-ID: <CAFEAcA81JuAjk-aOnBWcT1ZXWy0U9tVrWRoa5yYQ4WtvhZJKjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Clear TTBR[5:0] from a 52-bit table base
 address
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Gustavo Romero <gromero@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 5 Oct 2026 at 22:44, Fuad Tabba <fuad.tabba@linux.dev> wrote:
> On Mon, 05 Oct 2026 21:06:44 +0100, Gustavo Romero <gromero@redhat.com> wrote:
> > I'm wondering if the fixes should be separated from the tests as we usually do,
> > but feel free to wait for collecting more input from the other reviewers about
> > it.
>
> Thanks! I kept each test case with the fix it covers, so each patch
> carries a test case that fails without its fix. Both forms have gone
> into target/arm, including my last contribution. Happy to split if you
> prefer. I'll wait for more comments before doing that.

Personally I prefer "fix commit first, test commit second", especially
for cases like this where the fix is a one-liner and the test case is
150 lines; but I don't object to single-commit strongly enough to
require splitting it if it wouldn't otherwise require a respin.

thanks
-- PMM


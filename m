Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450EFF4BB62
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwE5-0001cp-Gn; Tue, 24 Feb 2026 12:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwE2-0001cH-TL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:34 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwDz-00027E-77
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:33 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ae222d978so5513734d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954169; cv=none;
 d=google.com; s=arc-20240605;
 b=I8nCOz1pF5wa9NRKZn4oO2naVa2DGksnjRj5EDpqS+k5Bswr20KMpLeHOl5O06Jm84
 l0QHox4iuk3cOM6WMYnx3D9UTPv1ASIoXO8QZaM9W1JBhOVqpBhYn5f8oP+afWDxo3vC
 u+5JhbwqWD+GtWrcdR0K6N/LVgi8ybv5H8McTyh2uCGbmjIQOobsVCL2SPfs4ixBAye2
 UoGLpYH7J9IBjwmZCTsZHzj5xYxF9SDisiZ59en9zcPz302plBwZ71ZUGL3xnA83GnlX
 VkgPfyyIB9B9frP/CnIF2KKXGlpQVHJQm8e0UmTxuCJ8LFlgs3O1x1sK4zqOrn7rC9XE
 bZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ejiXFy9YoJnWq2/0W8dVVZceAhBkskx0yZnYLil7Y1I=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=kL8Oalz++gUORRlbohCj/X8V6CmR6Q/EtxJoJhSrAPfJzd4eo0Mp0zdXxA5sFQkptF
 Hqb7EyMMn1SF2KBNqedg1awEada4UQRucpEi0un31n30h7l0yDUffOdVbJjNOzuywIXi
 9I4N67X7crnaUhL/vUt3NDka2ribwIc1opTEU0NO/P3BlvpSY9GAk2Wp8U+c9X94bQ6W
 KbaI1pUuG4gu/2k1G1J7622n9w+j3iwoUdnAoqszIgtdek74H0c+9v84kqaqCuT/SCTB
 aQ5mK/K9G+nKAEuFs+44ja8+vLGg1irZRdYFM+gmO6CBcxQe9TaJUlBR8C28vRGmbuGj
 GleA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771954169; x=1772558969; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ejiXFy9YoJnWq2/0W8dVVZceAhBkskx0yZnYLil7Y1I=;
 b=yyz4zVr+h8vGHdIPyY9tRiAuu0jj87V0An0x5I6VudSHzy/zBwq7FnXaTu+2ZAaXf0
 S1Wgsu1qrLrdBeZCkUZPXMdAkE0q9ijbuWU4Ja6e6W0mVMOCWTk1gMkmFufV0MzGx7w2
 NoenLYLtT3b8/Jq5bIdNEm6gxCpKet0f90lnfCSlTCG0p8EavrazplKPJA0LMlYkATzL
 wShTB2RMamB395TOmz1n5ZwIgV+Coiks796cn9FkgzTJU1XPgBSGdh3Xpypaa0P2Yit2
 SIK74DStGJT4OfKl/qaCOTCSd+p988DmoRkP7x400EhYY9NkkODnZegvWgjQ1N6Xt/o3
 9/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954169; x=1772558969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejiXFy9YoJnWq2/0W8dVVZceAhBkskx0yZnYLil7Y1I=;
 b=MCy18HDYHCs5VDo9pDGZu1fQtZ3wcVXZj5+VYdczEXxm4q3ZXfBVGBr99FoO+25av6
 5dB3pA//sF4eImTgRfstMf927wuhuAqnJ9IYTwg0P/3bqPtfaryl8S30ccwbeppBPcS0
 q6SGPE6o/VojOY0s7qhNmk1gx0uJFpl2hphj+MbSrsarzzyA94Eoensab6ypOybBPWge
 TjXcklSE2Duclvez+6q5s/YcyU6i9/Lm1Dq2DtAYZ6osygX2eDXNE611wLl80TWhB5ww
 8SgOjpNKo9OLXsU4Ox5YkCJzrYn/Z4zCk7dPhgMUs8hylWSNMLa0AbM9WD+URLxKucF1
 oong==
X-Gm-Message-State: AOJu0YyNU4HSATh4jf1KFY+frI2ySBSTDSmRNEk15bg1duwp95mit0Yf
 UrcvorxEUDoWbnakGJVRWAqbc3F9bC+NOYor5Ezl+fNxMHio20fXoSiwlOvMCT+otRssY0x+/W7
 j3Y4/MkM/TpPX4Ld/6ReMiAItE3sQtT3Ip4toFLzxAA==
X-Gm-Gg: ATEYQzyV5LI1FJJqgA5tC76353aphzVkNXLwa/fMyUQmqwhRIxNWgTYWLbwk3loRZFR
 W+djX1Af3gnkT41h0vF/lpTt3AUtj4KdkORS+pKucp015JAfavE4p6wO6CG1lsPMWj/+hjN7mgN
 iMIbqIF9mrx9+DqhNd+sa1ao4ZKKYxqdMOyGX2fROrze2lbCIJv0/PBr1AwxZN4bLR8Y7nJgDMH
 685LbsMISsriBxhBSy0cSYpa8dGzmlNk0Dk+Hcc9ZQVrAcxVIGy2tHOyxZbcDZJsummrO4zLehY
 YKgVwTcYuS1Q5B+T5++xgFNsJI+cE0FtH1huF66zqYmZMZwKTxOJ6AJFXffQwRPIWPEe2yebjIF
 sXQ==
X-Received: by 2002:a05:690e:2511:20b0:644:2e5b:410a with SMTP id
 956f58d0204a3-64c78f67477mr7690815d50.71.1771954168817; Tue, 24 Feb 2026
 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-13-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:29:16 +0000
X-Gm-Features: AaiRm51toGyaV8QpiF9drkrrXmwvZGBDoL_0xdpP2yAJwRpAY2ySIiGDkNtbGDY
Message-ID: <CAFEAcA9wgaQ=RHmWL-BaDo7ZKt93Wp5J7YvkOsJzd59HU7z=QQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] target/arm: Add SME state to kvm_arch_{get,
 put}_registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Feb 2026 at 03:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 2 deletions(-)

The (currently proposed) KVM ABI imposes some not-necessarily-obvious
restrictions on what order it is OK to write various things in (e.g.
SMCR.SM and other things affecting vector length need to be
put before the vectors themselves). We should have a comment
explaining this so we don't accidentally refactor and
break the ordering requirements later.

thanks
-- PMM


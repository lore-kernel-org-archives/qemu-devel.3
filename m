Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB5FCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZf3-00052J-5o; Fri, 19 Jun 2026 09:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZf1-00050j-5p
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:53:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZey-0004l0-SV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:53:30 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so2268246d50.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781877204; cv=none;
 d=google.com; s=arc-20240605;
 b=ANefK6GQax+TfCB9BIcSwVgnQGIQPSjCSjnjDjpsUJdyV2ZKnQhRti17AvPE9Hsw3i
 yzjSstLyPr6Y9tWJYGnkHkZorF4YrE3+BClk6jy3Ocx+5Ryk6ZTl78ZdQfRCObdbVRfq
 7h7Qr3kypolvPH6spHYe4oWe68SioNCOGyC1g3Xo0ubOttMroCClIOVjbxX9iz4+I0+C
 tzOb94yarRt2yg3eBKccu4H0xCssJvX5SxB6mepyUdZyFbEPtSyxjeUOqD4ThgFQDT4L
 ZSwaC2xYiUjk8i1tnarghJMEV+KJ7zWitDCFYoVhKFczp7zdykB9lp+U+cFD59o1aH0y
 IiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9lcw5Y+4hzPxq+A6X2LntP1wMGafpivrk1HVEb4wOug=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZZo9IRt0W8tm0oVu2sMHCjcyR9LPVCyOlNVvfpWxAT0dh4cd9Ep7K4ue+wU7Y1+Usv
 LFwt3NTEfGYVf9jiQ30oqWcGH3RtioQSFgNaqzb98vLimfI9lhCFZ3Oq3wguaRtFZBFI
 +BwWu5kAJnN1xBAAbV/157VTGhsoSrNOLG1ocf+9TTka4FQTIdnQQqrc6Nualmx5QMjT
 FMj2b+lq+GMPH1KtzDfFIRWW62mAr5fAYSXp4sqA/s4lgEl+H1vqzWcjFADvEMwGMvKh
 rrGJaUjmbs5GZNHWTy+m3PCsYHkx9hbA8+e+XkSJZn6ODCFX1JTbFn1ZkZnzQUzQPEeo
 xLuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781877204; x=1782482004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9lcw5Y+4hzPxq+A6X2LntP1wMGafpivrk1HVEb4wOug=;
 b=kbx20Qro8EPhxQUJzbwys1sfB4QPeC/upKZ5n9RP5IddBBJRPM5BqdttiageM55J/k
 UOo92sb1kFqXrWfyw990b91sauwQ6Sza6o3rRC9sEVVqI0De4kLRvewWWFgGDp7W4N/D
 4W8/gmBWW8BZ/Y2K/vdPX10AEYg3YG6gE9Hy3XWSUBlxyR4J7CHsMJbqzdFAE6j1p2IK
 YRZIJa/Z0slxIsgxjfqI7L+oYua4PPM6zmLpMohpYMJK+PqJJbAUT2+gfyRKAAnMrQ/m
 3SrY1hOYKT3GkVecG7sxD9IO2fWkSIssJq90HgpVpNhfGMawiIhhgvGSQH6HvQQV8ZoS
 y6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781877204; x=1782482004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lcw5Y+4hzPxq+A6X2LntP1wMGafpivrk1HVEb4wOug=;
 b=o/tXW9q+39IIpHHpp9Ua2Mo4L4+6YpnJUyw/2venfc8CRZMGEvbzzRN/krYz/tMjSx
 jWdPB490KI7oozGoz8/9fggxZXtzSjFJXl8cbuFn7TP7dvKDkzn0ZktH21tHcifBu1Aw
 mFU/Y3xAJgkd56XOPqRxeR0A05phV4DRnPKnhh2g/jyUfQ1Uo2B4n2ukK2AFmh8X3MXF
 oFrIRAX+fvqPqUR0Mcv8lNQ82JiR/lMwe66ej6A6L0jWWIM9ruh071b3s4RaKjvhSZ+R
 JbXZk/VrMOxAZsxWxVPDN53Uzw+UFirrjFS9DArzKcKHrNLCv+Mi4n+W7pFCEmBcapW/
 NZNg==
X-Gm-Message-State: AOJu0YxoBFD/8LB603tDi6ddK3kycX2czBg83N1M80JKKUcbe5Lt81OV
 k8xKP+jzYRVQQJEqI3dW6gP48KuOKfCyDghx6hxdU0YSNWswIgIg3Xh53gFkQ0YQLKhv1CCJ1bb
 EEKe77335WssGtwjfPk0hsJ1//HQKv2uMroJd2JKmZg==
X-Gm-Gg: AfdE7ck3l/ffTLha3ctPNIDUKwaS3EcE/WuqBEvsu9uyXLQaf9N3D8l04L9a0/F5K3Z
 nhGSyT59slMYgrAGdpa7a4xOXZjgtzthSj2haddXMx/YLyVMX4909vpzuINWY0skhP+2EZHwNiU
 wpyHbJNbHb7vcd+CCLxmmd2rGst5/pgFjKjnO4O3as4yrQyj0w3ZbP3uSV2JyxqnHGtiUbiQ0hL
 GEYrreq3FnXXyCaSeb55iyfLdzvrW99hHj7xvA3xuqRBqi2dHjzATLvCkApuvp5BcncHe/z4piE
 znMaduXmsf1xVtMWOQ9Ou4ubcod/aq+y9OErVvbgIPmev6Ooo30lJw97
X-Received: by 2002:a05:690e:2250:b0:660:e9ea:17dd with SMTP id
 956f58d0204a3-662fc9053b9mr3238302d50.28.1781877204062; Fri, 19 Jun 2026
 06:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-10-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:53:11 +0100
X-Gm-Features: AVVi8Cc7pPiuBU7eFiiUkdiKNH7SmloGhD-eVKlKvu_F0d4XkhjyiZcVl67zXJI
Message-ID: <CAFEAcA9F1fVWv_iV-Kb7w3tKFnMP8nD5fO3yyHsuSV9o41CzAw@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/arm: Implement FVDOTB, FVDOTT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   | 10 ++++++++++
>  target/arm/tcg/sme.decode        |  7 +++++++
>  4 files changed, 42 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


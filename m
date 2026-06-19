Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78190CDB46B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZl3-0007jn-Nk; Fri, 19 Jun 2026 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZl1-0007j3-Rd
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:59:43 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZkz-0007iF-DR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:59:43 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6611669cd16so2860740d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781877580; cv=none;
 d=google.com; s=arc-20240605;
 b=WXGXFZYRjf6rF+Ty7VO26c3dng4CHHy7zkCRTk3O/HcbmuxxCg0eBl4J5fUS+qxEDT
 Z/6FpPkwTJHRAKG9eBuLOS2OUebGtzHQN/xeYz2t7nY4mxT6ihaxCnmsY6VsBWnKcssB
 Vh5I6M4k/H0GmvqOQv3V1J79ZzwrZG/c6RUwMctKENoY2NDh7fmTWZBxe/K9JXuNaX8m
 F8V8lmzt+N6LnHLqoCtHF1GHd5w6inovh4l1P2LyqvEzkXJLydNDgg7c7VcqEamyov6M
 iHKOHTUhu99NpDwFXpR2qL2eAK2ewuTKJNnwraIxD0MHOA6G+GJhUbp+lngEdbefdohj
 6xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ShBdqytcLSe2HRNr4jnUDwhsOQrfs6ccbcrDZnIBUP8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=J52bEHpy/E0/piORcwo7awiTWdQak5rccrQd3ISfUOjewNb8nSbTiEewbTlDdrMcfk
 dUV8RU2mZbReIMowsiydtT/o+3JrILp3AfNtQFDZ16riqqdk1WQV977ecri0n2kN5hin
 A2gIkVznSC1LLGReEQPn0xKihsBRhYYMxjvCQntKsRSSPx/f3dVU9KuOyYc2URjhUrw4
 KzD6/I/bFiiXejVsdmsjpm/QTEpbASLl8VZqPmsFwHgyHkAw6NhFrk2gww4brLPvjVTV
 7UEKVmB3RuzFcxyhvSbOTPTLZHxTkgCMAiaDwH7J+j+JBqvxCPo8Sq3f/4RC8CYhU5og
 wFLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781877580; x=1782482380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ShBdqytcLSe2HRNr4jnUDwhsOQrfs6ccbcrDZnIBUP8=;
 b=d2b1mp+qqF30GOksiBiSWgJqs2eGWkV6VJHiTyniQWTU1DhPvu6nNkmJUVVdHwrreT
 +0Ku8k0Ni5PFdmzMMzqnAWmcH0RElVIPcpLG5415h4zDj+afFHKRDdXislHEd130uXRp
 ghNklnYd+eOBZ3D2KnzF46pqgP5DPFAeL153seb8/wT4KLYsqe05yFwo+OXhuQXLAIuv
 aaMp+mQRv7rQ9i06VbUfPpH7jy8nVmaxn8b0lQLdVbI2Asqf7ecRsP7j0hB7oRzilVYH
 Y/FKBNq+fDrEKXN3I01qyVLQ1dhnCLXYn5h7qd566E1KAAtJaWlU+k3ms6kpG8VfLgLc
 2dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781877580; x=1782482380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShBdqytcLSe2HRNr4jnUDwhsOQrfs6ccbcrDZnIBUP8=;
 b=bAx1JbJnyABd8k3B0QkEo6bijIrrYxfvoPk1DEC3P8wqRAy4GvLUdTAO7LDPwEMzJ0
 vAAzjvj8cFYTj2Wzr6GECSG0TPlwLjUGiI1feP1izHQvMqllincSwYuRRSGCJnk9Yk+j
 DRgrSNnOZdWrtXRTQa1Kr1gAwBRPyTjtHDJesjZShqXLr3DwO2INa5h+zNg1WcD0dTOb
 bI83QlUk65980Or16QY0YEZO45nteWUWhv0kVaIsyLNgWvFpxQIq1NsfKeQeUQWbVdeC
 6d6zW7FLdDzDTuQT2ItVWwWMWxI+XiO444oAa0fXSsJDmjJF0Ohz1trt1R8ndVeQ6Z6F
 XYGg==
X-Gm-Message-State: AOJu0YzreXmhFE6ThkrvjLLk/r+z4V51VoPcWT9j5FpGNbk+BqYpW0zK
 bSeRBahed5SLCcrN5EOWGZO5onLNSTU9frJOkeD/S73b2Lc2026uzwQLc2HEzKxc7HeQ3Ps049C
 O/kF++XG6CAznfgnmakACAc++l0AaRTmfkCNb3eAo6Q==
X-Gm-Gg: AfdE7clkUz8UbxGanxJLIuXgaqRxzJYwL+XGxZySS3ilkqhe0nHbcUbkp0E3i6TP8Sf
 4oqREPi1qAKZ8CNxfmi+s4dJyEvVoL679mPxZJI3BOYYCzBXycS+IkpYon0sCeSIF04xxSpPWR7
 hJat8rxmdqVUiCnv3YgiAdcliZRZehUDo23TfjbbGykODQgka9uVfbceD7kfNPfJpMUyB+stKcA
 SRyJ9+n4TtYWIwbyLZwjIfKH1+O7XJ9jH5NWaW1BMmJRoH3ULXeMiZkvhNKgBSgL2jSH15oU1V7
 K2DF8xl8ea24oqqN9fHVFa8Zj2zQU0wPI9OhE3HKNOsHB5FLrEC5vLCU
X-Received: by 2002:a05:690e:d0e:b0:65c:c744:36d4 with SMTP id
 956f58d0204a3-662fffc2126mr2957866d50.59.1781877579619; Fri, 19 Jun 2026
 06:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260618040718.572950-1-richard.henderson@linaro.org>
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:59:28 +0100
X-Gm-Features: AVVi8CfpkOUxP_ydqGvm5VJr8kr87gqEy9M30_cQ0lVRo8UW2ovAgpS7yB34Vow
Message-ID: <CAFEAcA8puxCrNjZgUC0qM=McpOPYvk1AaX4ckO+ir6RK32C7+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] target/arm: Implement FEAT_SVE2p2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Thu, 18 Jun 2026 at 05:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v2:
>   - 18 patches merged
>   - Enablement of the feature for -cpu max is deferred until
>     FEAT_SME2p2 is complete as well.
>   - Dropped sve2p2 helper prefixes.
>   - Renamed sve2_aes to sve_aes; there are more isar functions
>     that want renaming, but this one touches the same lines as
>     FEAT_SSVE_AES.
>   - Other minor tweaks to helpers per review.
>   - Unrelated bug fix for FEAT_FPMR.



Applied to target-arm.next, thanks.

-- PMM


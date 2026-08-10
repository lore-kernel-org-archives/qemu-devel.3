Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70794C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRAh-0007yL-GD; Mon, 10 Aug 2026 10:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtRA8-0007mB-PD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:39:38 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtRA7-0005JO-CT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:39:36 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81e69a2db34so32223927b3.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372774; cv=none;
 d=google.com; s=arc-20260327;
 b=LsC2mTU0Rdv9VI+z8COBjzdrWEt7Ud6zWpYUGTKmbjoCzKNUtdmhdS5HNRr0NP09Ri
 uPYe1f/hRImyriViyS5XxMJoDkba+IJzkHG8vpBd4YvA7Jaaggg8Sm90nxgtWeRE24jB
 PAOa6HYZT1De4Zr7u4+M+jK2EJbcWg+IBSYTRDzalsVNd3KPuy+CuT3vHwsORwelC2uF
 WokNoWyXSQDQ3gNCOEESkHzzqKC1cU07ZzXMFWCvBkPCoa76BhyvlzqBbBOupgnImpmW
 fX7zy1OlK9zK7oJlC7m56RGfWlyqdDYRG/mOUREkpYzx8QBGm63PD2iVSKvv54n0klbn
 g+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KYPrTKBg0uDTSzlel1LnvppHKk6QfkRtH2dKTdsM+5E=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=j12yGjUOvbl9VwPJzilgoKvUdopicGnY64Q3y/7P02xi2aLUQp9KasunFBPbyBEaHV
 K0sxVxLKktddEUy+/AvMgKB2Efsa2rdFph4IFS7+QF9R7syf4o2kNR7iuWHlDvJn1hHw
 p+tfiBMSrFyyb/F8qSmAfWkijgIAybD/hrns7lX3vhQg3SqQjPd01hziBHcFfkgGQ+T8
 Eqld+YlP8txri2U4as1iihXqILp2U6BS5dNea8RrEzxQEVRZCf5T0UEHEtp2CBHGOxvV
 MjW2bzQWmbZyK2Mf4304ME4cj2KPE7/vFNL0vsSbHkwXPVXJhEV39+C1MO7ImC4okEqV
 rijg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786372774; x=1786977574; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KYPrTKBg0uDTSzlel1LnvppHKk6QfkRtH2dKTdsM+5E=;
 b=bfz2Fq9u+gbOB/EUOPvu8SR7aMC3waDnG0vQlLGitG7r87td6IFAHr1XgBvj/3UYF5
 BqLCXJJeyXR0FkGkg8CPS2d1z4DS0Ht8l2Q1iNxi6eWCxdg+X5fHKObUy+oynwKe5Aqf
 4pUriOtXnIUdYFoyf2vuOUsSfWWmOFOBlwuaa31xV3qwjZNS7nXHNWT0PLaToHN3EueT
 gBdraB4eL8tHYEdm8knNHuq9y1qcqfT5KqbQ6eo7YQohAUnjpUzrxOp8ti29Ih5Bnm2n
 ZJEJ5UmDxzalQ9OxeAQyv2Q+x29KuF4TpKcw7vAgff7EMjroFLqKIl1lIFVYEFi7oIGN
 KCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786372774; x=1786977574;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KYPrTKBg0uDTSzlel1LnvppHKk6QfkRtH2dKTdsM+5E=;
 b=BHCN5XTg0nyoLXS3iCJ8k4ixsfAVZTwDMNo4wZPdXAqduVi25imTPuuEWeJe7I7m+j
 sM6BMS7StoppvynHARSUoxRqde2VQjIalyy8TbW5bbYuHoRSBgXDKbNNYlZ6xqOLIJuB
 tqJ8DLbSXvd4KNNhYECA/tHOzRnO7PsYA6PYZA2+7zRuDhrHbC1r8fjYlOYWCJLnbbpC
 pJFHqfLpXw4Ota13LGXFWm5iBqJaBGag+V24Ub3IuZZMoz7IspuqIdgiSvOaUoKYnpRY
 hT3wBxd/9uqRPw+OYWoP4THQAZxpsU0TPd4/kYHvTVjhRwwdmUvXSr5InRJ75tn5bHHH
 SYTQ==
X-Gm-Message-State: AOJu0Yx2ONYmYmNwddfN09mECZrP+djLdNoe7gWceAheqXUuRpZwEPoK
 9hECOZzzZaoUPvCWvLvQIaswedW633cN2TOz9iFJ91yJxVkhIWAgJD2vaVWPVYrSi6SfD08eJoi
 i8RfkfGN62gS9h+nrM6gyxAlHwXYgLai0SXBpzlWlzA==
X-Gm-Gg: AR+sD12O0XdsRqDboAfTm1eFJEA79DMjt97suOtWGhoWxO3Gy8bV/aDc0Vk2jnlgvwY
 p+4B8ERL9exB2YV5riqSbHiNAuxhN/kWOhz2/tqlpCCe8BNoAS413865PUEOS7Y9dTXU9Aw3mkp
 zqr98pXx0uH3IBSQpV8EyrtxRjFEibBfN4k/2Ts0S/ivUhPY+FPXDl5r4wfoiokJvHWTjtvULLy
 kToK3BB0wSxs53URuqMu18kLx8mS8g5YAQLS2ReDGt3nhJhKeKXNALMeTUAPBi5eXnUjd9zx8I/
 1nK3lJwOTvurzsxNAN8kBTYD0IDMDteh3a5u5HJAOqaab3D0lCeY4nflCO4OVgrYg/9gxaB1Zvy
 w00VD2seB5y4yJyz7iihiojX7jobC
X-Received: by 2002:a05:690c:690c:b0:80f:9998:e614 with SMTP id
 00721157ae682-825778aa66amr122891567b3.28.1786372773762; Mon, 10 Aug 2026
 07:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 15:39:22 +0100
X-Gm-Features: AUfX_myKvanqCw3V3p6G1c3PaNj9pSGi9n3Vi6VObv5sv2o9b-Ybzy_rL-I0ckA
Message-ID: <CAFEAcA-puCcXP67TEbW6-TySiFax6-N-N8dXcn97GMJFcAZfhg@mail.gmail.com>
Subject: Re: [PATCH for-11.2 00/10] target/arm: Implement FEAT_SME_TMOP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 14 Jul 2026 at 00:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Another SME2.1 extension that becomes mandatory with SME2.2.
>
> I reused the little helpers that I created for FEAT_SME_MOP4
> without renaming them to something more generic.  I hope that
> isn't too confusing.
>


Applied to target-arm.next for 11.2, thanks.

-- PMM


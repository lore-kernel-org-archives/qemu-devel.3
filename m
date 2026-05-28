Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7937CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSW4S-0001Yk-6J; Thu, 28 May 2026 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSW4Q-0001Ya-E6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:26:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSW4O-0007hD-78
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:26:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-49041e84237so51109865e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779956782; x=1780561582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xYPA/y/VIr45+cBe97oUft98aqvRRT+1NJNx3ORNGQU=;
 b=LloiiqbYLq18LNvDvCrWcrcqv2I80VP+xK2Y3/ntAX18cSmM9Pw5W8OX2aRvhxpiM+
 38L/tq1YYRfW3rzJ7/q6AMdexZaSiB7041EQ2ido6GaaAPLlvbep0NmYLUYPEtXZNHkI
 MumeiuTjgnKSV0FiZnshCqFd7X6oYipjRAZp1MY39r2lMmZvcSjnglcb3kXZSk4wWoWl
 qQxGlocVUQZxb5t3OeYAFAO9xWTe1mVIPCLKHgidTIdPZivp4LCx6uPhkzYToCBFQTk8
 VMT1iHYWdQw+QSa2eqdr8Cbx06lS5jGYBeVrxRPPCIu00mCEt5ez9E5Exg658ND+M2bj
 MN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779956782; x=1780561582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYPA/y/VIr45+cBe97oUft98aqvRRT+1NJNx3ORNGQU=;
 b=gZBFkZsC9RQpbt1k3jDGqw9tGqlYqsPVrxcuUHLIrMEkX78Ov2KcaKJdxfWOZWiyR6
 LTMRWAtai67tzInncenKiQvwweR0H2JBx1/yevjBq59FEBTbv8nZugUrE+4FSKdppCyZ
 F+ub2JdwMNzzyKO4pjbj8yL+spBz2gabvakZb+FtjRfT1KHJFtf4J3bG9z/dv6nwYhCI
 ICy/pEh3KPFXE2THRaf+36CORVAjRGX61v+lcD5TjAXUURBnOKqC/rAWaNeOwt1kDbea
 qCwNAIHpzTuR9k9VtjD09u5CnCeieXcPmYCZgBYVkq7mJRKYk57MrugcYyfjF+nZENY6
 mbXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jn9vEQRWB0Dc7pSKTy5LJxS3zTl0as6PSdAXtaADJ/78GSRRFpgOdX4AxjeckDdf+b5VKmlDllNL2@nongnu.org
X-Gm-Message-State: AOJu0Yxu6vfvkm78ZqJ7UmN09GQWy929sN4IiRVhgxErSEDrrbrlf2uw
 fcIj93KeP17peqZUuIKRz9ZFY82Vk3VT/asNqad2LUQ976u5tlTmpaRNsRZvIVc+tPeeXh9yjJC
 Bgt6FQ7qdfnXO
X-Gm-Gg: Acq92OHdlhuUayH1ba9ZicUevJMS0uFngmnpD9YArIYluQoNp6aOFjJMCmmMUi+QcbZ
 RykrX9JXKnmmR7VwxJ7nrzsqYk00jpphjKlJridFH8RiA03zfubZFAk0tcPOKeouPnj0W4l4wfJ
 pf1Pkb1JZk6UIqHRfLxiwCVc5SiSTnFqm8e5UkoIAuQjKRtai0ALuUhNH0hCCYOxNdyMv46Rz97
 Sl+Xc1+xzl98NbZGCswP2kv+fJ8nI9xZCgNu/PA3PgyfKWi2G8Jgm+Dxukw3UoOSzzF1wqA1nL5
 JdEO2RTUOT5cn7x9IWFkXYtF+Ew2g8+zLp5NE4XpsGftiM+NFLpdjRhesCtbndkNs+yGn4RIk7N
 Qq63iczpt3ApNe16DjnjQXCmbV09sc0ZCAZBicWE03Ee4vR5lSR4BTGcFZPpt6WiP0TKueo+kk+
 NjWag+i1M+JE0q/f4YjXAJiy0JlVJbQmiHY05d+a2M3/MjLiwxNbMVOKUuFoiHXiE8Uf2SXqNY8
 2t9VaKIl3+g3jY=
X-Received: by 2002:a05:600c:8b37:b0:490:f7c:b19 with SMTP id
 5b1f17b1804b1-4909454798bmr11057865e9.0.1779956781961; 
 Thu, 28 May 2026 01:26:21 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909264fbf2sm27576505e9.5.2026.05.28.01.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 01:26:21 -0700 (PDT)
Message-ID: <8f1cbb9d-289d-4573-9da3-250c93e54a1d@linaro.org>
Date: Thu, 28 May 2026 10:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <bonzini@gnu.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 28/5/26 09:34, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
> 
> The concern that motivated the policy is unchanged, and it is worth
> stating precisely: the DCO is about whether the submitter has the legal
> right to contribute the code, not about "creative expression".  The
> copyright and license status of LLM output remains unsettled, so that
> question is still open.  What has shifted is the balance of risk:
> 
> - projects accepting AI-assisted content have not run into serious
>    legal trouble so far, which suggests the probability of the risk
>    materializing is not high;
> 
> - other organizations, such as Red Hat[1], have assessed the risk as
>    acceptable -- though a community of individual developers does not
>    have the legal backing of a company, and even an unfounded dispute
>    would be a long-lasting distraction from work on QEMU.
> 
> Revise the policy to permit AI assistance where the ramifications of
> copyright violations are at least easy to revert and unlikely to spread:
> tests, documentation, mechanical changes, and small bug fixes.  Core code
> that other things depend on, and that cannot simply be thrown away once
> a problem is noticed long after the fact, stays off-limits without prior
> agreement from a maintainer.
> 
> Related to this, and already visible in the incredible uptick in
> security requirements, is the question of maintainer burnout and the
> shift in effort from the author to the reviewer of the code.  AI lowers
> the cost of producing a patch but does nothing to lower the cost of
> understanding and reviewing one; if anything it raises it, since a
> reviewer can no longer assume that the submitter has reasoned through
> every line.  The limits above work just as much to keep the volume of
> review work sustainable.
> 
> Furthermore, introduce "AI-used-for:" as a trailer to record where AI
> was used, and include other suggestions that help reviewers judge
> the result.  The standard is slightly different from the more usual
> "Assisted-by", which doubles as a check that the author has read the
> policy.
> 
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
> 
> [Commit message largely based on
>   https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>   Kevin Wolf. - Paolo]
> 
> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>   docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
>   1 file changed, 75 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And with 
https://lore.kernel.org/qemu-devel/20260528082022.32359-1-philmd@linaro.org/:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


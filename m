Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB59CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgH8-0004cX-JR; Thu, 28 Aug 2025 13:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureQ7-00012c-Tg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:20:13 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureQ0-00071H-2x
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:20:11 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e96f14a6e97so826485276.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394401; x=1756999201; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mWynGiuWXHzVD5czWWsLHHyWvIAmAYjnnVimzEcwFtI=;
 b=puq7nW7e2hEdfYQP/qi/k3WFMIC5N4ZNwLtmUPcLw06UUuOg0locHlKDxP/ohCKN50
 BbtUfTQGaIpBPmlCRVkROySeDy9rx+udiu5ZeYViOXjhjEbcnWqqLRYyKZ8a/NkZ34aT
 MITCHFDo8pTfCtCuZZUj0wtX4uvUgQ2LPI+LdBVyr2U6gR4FfluG0RK6tQMfeSkYYZuR
 QARkJ7qyTwIM7PFkgw0JQJ2I/FgZRu5avdn20QgdMMscKD9QnDmzlnTEfD/Rn7hLMzDd
 U/cnILK5TxW2nzsi2x+Q9pM2gYMTsAI2cAdkQVqaEp6jJOYSBFRu4/+UGUygRNN+28eg
 fbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394401; x=1756999201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWynGiuWXHzVD5czWWsLHHyWvIAmAYjnnVimzEcwFtI=;
 b=OUocJPQQ3HQFYYY0vOH79BQ5U0VGOVAwtMwtI6WI7XWX870gVZ5B2xc+RQk8Mv/ySz
 XF70y4UOcBc0kV9PSvF+vpN9/gj+Sj5rDXHjYLZ92x1GKlyqOG4EWDizxC2eOiVD38qO
 n47fsGl6rI1uVvJSR17fjdrWPrw45JMN//ttFdhbMvCaDeC/0GAu9ceptrAd1toYkp9I
 0QwU1zMNiV88arIBZy185v4OkKSryNNWr/JeeFELYk21IIAwu3R6yZzQWMgae9PCqlEt
 PlsZOfCiLt22ATEmqQzs9lmRozog99wFLKTYemEzofXzvwckh6SfeMUMeEYvbj8DeMO1
 +ryQ==
X-Gm-Message-State: AOJu0YyVyMrCEB6HlGFOhG6uSngT6/0KlqVB4BkWTt3LOpHw9NCWExhM
 zxiqgDGy7ATKPwvB/65hlUZy9IHS1zwPAb09E1QRF9Tb4sbqlYptoVZUjmm6pVQ+/oktLM7Bvwd
 xAxnADlunlJ21eL+ssndCM8rqYZFs/Y+60xa4yi66AkWz/aLkVcAu
X-Gm-Gg: ASbGncv3GpI00OmA05JRfj5VMI3L1/2mfIqpOI608hfFEikt68Wn6tZEvVYu6bnrI8M
 DO2BYS+UKnUcY+FuaojNxWEfFdZV4LW3OYd51yieYCi3VnoIf/hOJaneR1FOe4FikQc+28Q6fLk
 hL4kWdyxt5qFCu6tPyYE6Ne0wH1M+9YLHgwmZJ9AmnBDrtH142Xhdva4KtxmUlgNJcbiPErP0pg
 SfPklz3
X-Google-Smtp-Source: AGHT+IFmNXFy9w5Ps87wu8kd4JncLKeZOxrODFJMurBwYOea8rmbO6pq7yaO9W6ePp6Tg2JCs90p3VCNA11QM+aeCbg=
X-Received: by 2002:a05:690c:298:b0:71f:9a36:d5c0 with SMTP id
 00721157ae682-71fdc54bdaamr242476007b3.46.1756394401535; Thu, 28 Aug 2025
 08:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-87-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-87-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:19:50 +0100
X-Gm-Features: Ac12FXyQ-u89hySJYdFWnzQ8eDNAplmkCSxBpMvETooLIgqBo5Azd7s4tWzz6xQ
Message-ID: <CAFEAcA-B7pujthNbAg=K1fuF_5kup0yWcQG5T_HYSr=F_Gw9DA@mail.gmail.com>
Subject: Re: [PATCH v3 86/87] linux-user/sparc: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 28 Aug 2025 at 13:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move target_pt_regs to target_ptrace.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


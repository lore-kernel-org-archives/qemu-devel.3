Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B34CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WXF-0008Q4-49; Tue, 30 Sep 2025 05:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3WX6-0008J9-Qk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:20:33 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3WWq-0004Cy-R9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:20:24 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-76c144b06fdso57302407b3.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759224006; x=1759828806; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQ+dGVKPJ5GztWEiMuI+xbKW9Ztw7N2eaXVor084qoM=;
 b=zx6Rt6854di1OsctI9rqfV4tdxJv78axHLeL/zHtOJu/RZji+2W6dOt1M2+nL6aVuN
 Vjah23U5g25+6SvIHxCfgpWK1EJRxV/er0jKldsLpQldqDJxuNOY/apauEYO1GpDUghT
 DUReW2rCKXNAZpXExn9Jwev1+4NGe4r5dEbROUs04iAFx4ljc20wYzuogh6Lp7SEDWBV
 uSEKfWNbWJYTBe4GhRW9J3CBqdy8XWpfbxRnyd9IEPP9ay/AUBr/a1Rhhxh6KbH2ooGg
 fnRQlE4oPi0a1zpo9ONbEgDzWM+ifF+FscrBL1D76w9AQwlM5R5TQaZePnQfy0HrJYr7
 myIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759224006; x=1759828806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQ+dGVKPJ5GztWEiMuI+xbKW9Ztw7N2eaXVor084qoM=;
 b=i8OkXPh7CnuuJwX6aFk3d9nE+2x7hpGB/e/kFPrdNHzAdNj0M5PEylKCDJIbipVd7G
 qKfHgvkf1C1z/uz/n3SLoc4Hc0H+rFPkwc98gqgk2S/Og4DD2aQA7G/WVRfVFd4R4/RI
 BEzFKRGiLVHaYRo7gBygJZ3q4MGQYLJ4vnlR7qnm667dbxxwlBQKtXtUZLnVQi5o7E2J
 pPUWzDHFrDZSyJCP2hqwpoFJeINR5l0wBfHnIQr0op3Lqm5Uk90K25ZdJ8ZnqDRAlXJs
 WrhK3IUR2/RgnS2XQSg3Xg98t7iQiCApOeYZs2noULLFAgkt9wO8VrKGY8zmOvzR4aar
 Ss2Q==
X-Gm-Message-State: AOJu0YwL47fnmpG4VE7tkvHMLkPAzLVZF+wWZB4woVAFjr+4yUqws5aD
 eRq7spwOgpCehQUb9O23GkgxcvPEDASgdtqkrZ7pLmzPYgVxyeBWTMz5t4+tpfujv4ssdNbyaaE
 w/owsjfHU84Pt11yigUDkVvLDuaFPOsFC51P7G9rhYw==
X-Gm-Gg: ASbGncvwDfHXIV4LZCwmkBcVBeawv8iUthHssyWKJ1cS3IOqFcvBHbM/y07645Pwa8F
 juk99VFRZzyq2Ag4rbAAThPXlHWa9HUNLXo4zYeSmQLkwTtKxyTxwiIPjLvwjDeo3LF4dXIRaP+
 4x03WaI9fnZarSrkqoEHnD0phtP2yYIahJP2meB92H3HKa6967BOK8qttYLdk6QZ6iXKExgNTuo
 wE1wf8w19fcgyVNPB9XzYDyxxRBpZyRmUD4FbEJzaY=
X-Google-Smtp-Source: AGHT+IFI05uFGaOrDcE7bW8zic9uBE2zkPtVM+gvIcdHtT25a15zg2rpajmUcAIRiJNIOwnz6iOPVItIfz0TuYcOQ/s=
X-Received: by 2002:a05:690e:1642:b0:604:3849:9424 with SMTP id
 956f58d0204a3-6361a70efaamr15761482d50.8.1759224006219; Tue, 30 Sep 2025
 02:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250929190801.931989-1-peterx@redhat.com>
 <20250929190801.931989-4-peterx@redhat.com>
In-Reply-To: <20250929190801.931989-4-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Sep 2025 10:19:54 +0100
X-Gm-Features: AS18NWBAzzbiTglUuVMnOHwliB2sKtJKPjVR1ItgKYYgZf7UMckQLNYD6SEtxxA
Message-ID: <CAFEAcA-7OC3AfDyowK9pCW6yxo_LoTVv=B+AvT=1g+6W46DmrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rcu: Avoid double rcu frees
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 "Emilio G . Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Sept 2025 at 20:08, Peter Xu <peterx@redhat.com> wrote:
>
> Trap call_rcu1() to make sure it won't be invoked twice for one rcu head.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  util/rcu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/util/rcu.c b/util/rcu.c
> index b703c86f15..9272fe5796 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -307,6 +307,8 @@ static void *call_rcu_thread(void *opaque)
>
>  void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
>  {
> +    /* Avoid double rcu frees */

I would maybe have this say "Catch accidental attempts to
use the same rcu node for two things at once", which
isn't the same as a "double free" in the usual sense.

> +    assert(node->func == NULL);
>      node->func = func;
>      enqueue(node);
>      qatomic_inc(&rcu_call_count);

thanks
-- PMM


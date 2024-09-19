Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A57CE8D62
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 09:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srD9W-0001eJ-UA; Thu, 19 Sep 2024 05:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srD9V-0001d2-9X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:08:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srD9T-0003o6-Cb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:08:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92f699so622006a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726736917; x=1727341717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S+Vm0aIJf76hdDpFepnx6YQE+r17lmweI6qL4DRvvHg=;
 b=r+a7qjRF+cp77nF/0HGMHqjsBYbwrnYxYucl/bcWT12yCmtcQAG3pGlTy5OpgZGDLH
 0cTFnGs+1UK6Evht9YXdYv6Gevi9hFXcNM05BAT/a4GKCQuyLHZ3KuqI/omjkSsjzi/U
 zF6Nnrmt1aDXdbT+0/virsorFR/zQYtGUccCC874gqmtaG0PFXcKv5r2Co4qJ8q1+yiC
 2xchW1v8qHbpak2Ql4vlRW/eOwZNXqswQkcOeHPBHHOkvm4qFMmd9QrG/q/ckq33vGXf
 JWXhPK/jz3ac6rD+DSzICpn9ZgLlI/0HZA0kDK9xevdYDbLCcOt5P7+divYZ6BQPBHox
 wxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726736917; x=1727341717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+Vm0aIJf76hdDpFepnx6YQE+r17lmweI6qL4DRvvHg=;
 b=q0RlT3kWEPSd6FEqeaq/9/qohVurw/p/y7s4ks3CsW+++3D+H4fIG+Zy4FZIb+sfzv
 Pc968xtDLHwnI68aRwaOCFF7S+pybu7XmJQ6qKRHRDtnMSrGyWy/NPsPVvbgwRkXmkyg
 ccwvnM0aTIhdPDXyhV6s8UaHSe9VdTGVaxHipYHQKlHe8kwB0RvWK88E4qbuugR7d4jW
 hKCd1V/Gyo42ufOQl8jaf4W3Rmdg0fY3tHyKG0BIsDj9GeQVrfqApElPDm2y8K9ibM8C
 Bt0oUXhLPrVaXjefLVS5XH7KuN8wclE/JgRtz4WCweAmT9e0V42ruAa9Lmna+boisf28
 fTsA==
X-Gm-Message-State: AOJu0Yz75MYUjVH+QJvGTTs/SmHFpck5NXGjUry1ewpduXIt4qtnF9YP
 UQs169n+UzzwvaHGM699g1z5mPyqyoHehPaBJTZK7h8FXnM1y8kwUofy0gYMwzAQOI89AbNlTSZ
 Bp6uSWvKr+BSB9iKrtgvF1iDKuM3UhqwXXu5alwG/tZLqoHBr
X-Google-Smtp-Source: AGHT+IHmRzbtqinSE/3AKLxkiiWZA0+rgOJimgFKmY5DYAIg0tzT0W+Aaatgb/nUb23x/pyIeV3uZecwjidE9QkiY/k=
X-Received: by 2002:a05:6402:d0a:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c413e1ee7bmr22939915a12.18.1726736917230; Thu, 19 Sep 2024
 02:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240918183151.6413-1-peterx@redhat.com>
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 10:08:25 +0100
Message-ID: <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 18 Sept 2024 at 19:31, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240917-pull-request
>
> for you to fetch changes up to 4ce56229087860805877075ddb29dd44578365a9:
>
>   migration/multifd: Fix rb->receivedmap cleanup race (2024-09-18 14:27:39 -0400)
>
> ----------------------------------------------------------------
> Migration pull request for 9.2
>
> - Fabiano's patch to move two tests to slow tests.
> - Peter's patch to fix qatzip builds
> - Stefan's multifd-zstd fix on unsigned diff comparisons
> - Fea's bug fix to consistently use memattrs when map() address space
> - Fabiano's bug fix on multifd race condition against receivedmap
>
> ----------------------------------------------------------------


Applied, thanks.

Thanks for looking at the issues with the migration tests.
This run went through first time without my needing to retry any
jobs, so fingers crossed that we have at least improved the reliability.
(I have a feeling there's still something funny with the k8s runners,
but that's not migration-test specific, it's just that test tends
to be the longest running and so most likely to be affected.)

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


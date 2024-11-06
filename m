Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD24D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jpH-0006Mq-6m; Wed, 06 Nov 2024 12:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jpF-0006MU-Ri
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jpE-0003XP-BZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:13 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso5962328a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914091; x=1731518891; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=54JHIp/nLJuaBtpk02BA99/ggzMhcnTyw0vsZRabSrQ=;
 b=yV1Wi/GsPxqFbyHRu7DA4EQ21gW6FEC55rM676B/LUwZaVIrfkaSbFg/v+dkymWHWe
 5rC7VHLXa/sEieeyBmM+UQKuYWci630jerkUh+GLcU42n1NnAXnnCCCqAyAwsEDAOw3G
 hDMX+cPWNOTQ/XF2X1Sh9c3ZB3S1mBCpxS5L7YZDvJgdayhdW24fY2JSkOSTaTMZftNd
 fM29gxXo/syBNCJvGxxE7TXpLlKsKPRJFy+0EnMH0swjejeZ17DZulLAOSJk8KWDZgpu
 YCPRtcdbYJqJyPng48dcGLiWZm9uiu2PNt4W8eEOfEjFnAqcQKAK8cYzClCHMYW4IqTu
 K41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914091; x=1731518891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54JHIp/nLJuaBtpk02BA99/ggzMhcnTyw0vsZRabSrQ=;
 b=RxFPJsG0usoeIhy0lZzTH5SH6KufNtI42HGZgNVv62/2nDfnIHwAO8wCSbi2rFTI2e
 8XejKPkbgezuT2nW5M7qlILqPLaT88+78I6R2J8z3/FHxwimpY+PXdKQEcB5Ew96LWBd
 J44nwcfr3T2RtKZly+xDEiMlL4f6iFvjblTC5U3VHKIkHl6srSUuqWBZ+5nXr54ejWUQ
 ZcAm5An/GRjlq1YOOYCuu0Bf+4k4gxW7xQI2cutlZxpJgXWMA+MCmABmPkiN1yt+Oy7o
 R2/IjoN7RgdMhs/KVdW4FweYHwK0dr8LkQbgAIIbl2ugEseE0Ek4RVBX4q7+sZ9O+mYB
 V4vw==
X-Gm-Message-State: AOJu0YyNnKfzYj84CWBRPqRh3Ji/S8J6UXoLAUbDcVbJ8W2ylQJ++Hmr
 JvjaykCtx4nzZuWKKgIlk00/UNeiTwCIzM5rhk5cLtujxYm8J0dt3ELoWB2JjvWOzabKE23UhDq
 aOqBQepzFXwKZ3lKTbM8cwsojz4h08/dFQeUoIL0MfQ1fomhM
X-Google-Smtp-Source: AGHT+IFWSkMINHRrr0owC4GL5LZKV0qjs51lpDAJG0TvqHW+OmmHnVqoIABsfCREQpoTHj2rkE9APWcNyIezzHNCQys=
X-Received: by 2002:a05:6402:5cb:b0:5c9:3ff:2734 with SMTP id
 4fb4d7f45d1cf-5cd54a84c79mr22336736a12.12.1730914090864; Wed, 06 Nov 2024
 09:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20241105150348.446982-1-richard.henderson@linaro.org>
In-Reply-To: <20241105150348.446982-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 17:27:59 +0000
Message-ID: <CAFEAcA8ZMPxfJmn7puVDJbxUxZiTj0xXReXtbP=JgsgF=oQdNA@mail.gmail.com>
Subject: Re: [PULL 0/4] linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 5 Nov 2024 at 15:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:
>
>   Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-lu-20241105
>
> for you to fetch changes up to 6f58b090328f5b47ee688c77542bf20d521239a2:
>
>   tests/tcg: Add SIGRTMIN/SIGRTMAX test (2024-11-05 10:36:08 +0000)
>
> ----------------------------------------------------------------
> tests/tcg: Replace -mpower8-vector with -mcpu=power8
> linux-user: Fix GDB complaining about system-supplied DSO string table index
> linux-user: Allow custom rt signal mappings
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


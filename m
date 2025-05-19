Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzGv-0001Cq-Nt; Mon, 19 May 2025 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzGm-0001CS-Sh
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:07:02 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzGi-0003U3-88
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:07:00 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70cb6744e1eso20201017b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747656411; x=1748261211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJQfQnJi9SNNUKNZMnL/0czXpf8dq6h3SsezMcM0DkE=;
 b=wxdlfRpOOPJ+XYhtefgoZ0LhyEg2KFmGy0fmCsKX6rp2t46kieZexPPnf0x25RK564
 K9R43TP24jf+obXwUumn8eqUFBnXs9wb+ZXNTmwgfrSeVzvXWuJ1iBgFxnV4121Z5409
 dkN/3woLXFCfd5B+s7OwlTUWwUHf3yLEZgKHqKgGswryKD/BzMPfy6eFavPamG5/7b7k
 LWPxLLDFe6mLH4BekMgVCvnZ8iibA1OuVY7Ru8DYTyztJAAWNB025Crt2FrqVtgnNBmt
 A+60qFPhJ7rnJfeSQ92pCiC0dvJUlIq+4jBEMx7PF+pnnTUeVbi7HvQSZlCey7RWr7Ri
 9MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747656411; x=1748261211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJQfQnJi9SNNUKNZMnL/0czXpf8dq6h3SsezMcM0DkE=;
 b=UQPU+9Falt3rBf3yJZCSvj0uAxXTt6xYnvXTWR8Sf40oZMyWBxmsEeW8vyXP+e2uM9
 zhP98WDUxjaIrweTyYtKA4KWjPb1DDbOqAmVFi986ArjTP/qQbQ3Fdh0fUptPnXfITaP
 ZwBGxNX7TXEoQdTyPUcBY0W77YxHRu4rlBgHVKJBp+p5ML6y0QD/CK8pCtcJiu5+mb85
 DBkQQhi9oDEKKXCYK9iDdSMgahYvnAAOpRF3MDlE/dpUfvJ3MOuzVQnlkIPoRC+FI0Co
 f7+JfCmPMsYeiN/z6DHVU8t/v37PSeHYPYFtYnCEydGh1W5ZQNWfBSBKGCg5YDa1YlBv
 bNqg==
X-Gm-Message-State: AOJu0YzKuFyUXwKy4gdhax1EMabbMpsWNmmt/J5w48YZkB0i9eLdASVc
 gF/+q0KvOeANMCq4mtdZu8sARMkIXyWnQXGxAljD1dGNOgUsMZNNAvIbZvPbVT6Mu0J54q4U9VB
 9+S7ToOvSB2hXCz9aw+sO7yIZKrzhb1SEPLpJNeBPfw==
X-Gm-Gg: ASbGncvaJvM+HQ946ZV5K5fmlyCx/c8pMkjw2wN8LEx5RXkfcLeRl/m6O6awrMIKyuE
 XYsITNmtTktzcBYFdk81Rn7E2VGx17tS2/cHQsSRJK57ycKumvcnU+P2QZ3RfOHQhQQN4XkAaoo
 gUKlUDXQ3gT7yNb7knv2ADoNxMYVd/A3IPbMuo8ApHIoKx
X-Google-Smtp-Source: AGHT+IEyiPq/6beY2uMCo5U+Rg3iGNrA/peFt3hmqDZ8YorxziqFmYSZBS+9pE+E3QqBNxHCD/UFI24aUlAY60G0ji4=
X-Received: by 2002:a05:690c:4b8f:b0:709:171e:1321 with SMTP id
 00721157ae682-70ca7b8e205mr163442807b3.25.1747656411566; Mon, 19 May 2025
 05:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-2-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:06:40 +0100
X-Gm-Features: AX0GCFu1UYRBSL0yQrkJhetKqc9WVSLENwqcPwkXbdMH_O79TcOJg8rbnK-pyjA
Message-ID: <CAFEAcA9SNu2C5a0uYtem5RFY0T47BgCrOxG0UXWnfhbdD-CYzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] Revert "scripts: mandate that new files have
 SPDX-License-Identifier"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 15 May 2025 at 14:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> This reverts commit fa4d79c64dae03ffa269e42e21822453856618b7.
>
> The logic in this commit was flawed in two critical ways
>
>  * It always failed to report SPDX validation on the last newly
>    added file. IOW, it only worked if at least 2 new files were
>    added in a commit
>
>  * If an existing file change, followed a new file change, in
>    the commit and the existing file context/changed lines
>    included SPDX-License-Identifier, it would incorrectly
>    associate this with the previous newly added file.
>
> Simply reverting this commit will make it significantly easier to
> understand the improved logic in the following commit.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


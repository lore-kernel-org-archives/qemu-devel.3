Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE15CF8842
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swjmc-00068N-WD; Fri, 04 Oct 2024 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swjmX-000685-8a
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:59:49 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swjmV-00009T-Ou
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:59:49 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so4619218a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728053986; x=1728658786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQmtXYfuRety+5EaVJVCPl2n2fx6AN7rll/4Hv1oYtg=;
 b=umiCyhIDg5HycxgFNW+qA922hxlszzrcHJ2MUl3P4Ta7Hq082b40L/OY4wkrUGR8f/
 KD4sTlPa2AvG60nDbw4N8eIpe9onneLK7357P437+dXbrDbWlA4D9iqoKuQqtGAdHDAe
 byV6jj1ywMyeTEUitXMPvj2mbFH4Fi//ueY8FL8lbYcIriv47o4TK6xjrqNXIDOzNzbV
 OUMPnnKU/9hiMNkMKjfmiZR92f0J9HRfv16gfPusQvarCNdKyg20ua/JVKr+lqHxqD/8
 JcMZoC/zQZOjvAUyoeAoztVh7gKW7g4GArEDaVIt5p8UQZloKzLNdy3eNZKrLdp8nwGd
 N5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728053986; x=1728658786;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sQmtXYfuRety+5EaVJVCPl2n2fx6AN7rll/4Hv1oYtg=;
 b=GcY+dTJWA36YzExI2YUYjpibWcC5naUHEz9Go420l++0pdAkDdnLrplgSu0P0VJCiB
 t5bnWpgqfXKrLE9sOjYLda0ns1kdmkRU4my2HL2L9nzUy8+dXb3NclSrJw/FA9oJRUQW
 MO2644wX6o77CQRms4BbZ2qpGvHSVjtm6QWafdxcnI3cu9CbfglamlR97xT2cii79Rzb
 Ss2diwPq2/NrQ+o3GdlK7nnQAWOBQGRcU5tWAH8YWXR7gsuPNl+k9O42BAWtaCr3hWEP
 IcK/fKxYCgcaQBcWwGLCZUwGHiXneCV9F1mxBlUu9/uQwcgjV01pSXfq++jLrIZiVkoP
 ILlg==
X-Gm-Message-State: AOJu0YwuAfoQgp/Cj8oZD7wxbfqQpnLdfW9JIj1hq2lhWMNe/8q1dQ3X
 VANpZHTK9io1xRX0qYJ/V4R0JkIDcOr3mQuVmfsUBpUOwB+x846V8lynaTn//to=
X-Google-Smtp-Source: AGHT+IGdXSFVDUvR6LUp8RS3sTSRngp++bUgR6RhKWkUI7uIi0dwAbKgIxhJa39xcS0u5tLaVjLDZw==
X-Received: by 2002:a05:6402:348e:b0:5c5:cb7f:e56a with SMTP id
 4fb4d7f45d1cf-5c8c09f4689mr8151620a12.1.1728053985919; 
 Fri, 04 Oct 2024 07:59:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8ca3dd51dsm1946873a12.25.2024.10.04.07.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 07:59:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 33DC75F7A2;
 Fri,  4 Oct 2024 15:59:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  Alexander Bulekov
 <alxndr@bu.edu>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH trivial] gitlab-ci/build-oss-fuzz: print FAILED marker
 in case the test failed and run all tests
In-Reply-To: <20241003121656.1173612-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Thu, 3 Oct 2024 15:16:56 +0300")
References: <20241003121656.1173612-1-mjt@tls.msk.ru>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 04 Oct 2024 15:59:44 +0100
Message-ID: <87ploflxr3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> currently, if an oss-fuzz fails, the script does just `exit 1`
> without any additional output, and looking at the build log in
> the gitlab ci it is not clear what actually failed, without
> looking at build-oss-fuzz script and seeing this `exit 1`.
>
> Print easily recognizable error message about test failure, so
> it becomes obvious what exactly has failed.
>
> While at it, continue running other tests even in case of
> failure, and exit non-zero if at least one test failed.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


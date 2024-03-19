Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2DDC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmey8-0006cm-Dm; Tue, 19 Mar 2024 15:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmey5-0006cW-4L
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:17:49 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmexz-0004Ti-Pe
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:17:48 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513ccc70a6dso10219781e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710875862; x=1711480662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDjDpwZx4G+C1l8kk7k4I1S9kgexRc6lFLciCFujiKQ=;
 b=FfbO5MesEueWhZQ/TlDLKhO29FtJzV4Vm5wIRT2zHpH6kmbVm9RLaI1E0qYRj6tQ07
 rdHTqz80JpGbxrezvY7b1Ts7YF6WGy1KTFU1QHvVf2V1cGbylOrlqDBm8A9l729oVYx8
 iqimFhB8W3OmHN3BerKxrd4YtHMlksCVff5fghLqkdEdu5F/PRYJeFWbm33jXVSqsYVC
 XsQAX1zosod9zhX/idrjwoqoa1BYVhNCJnJuJutdkhzcnaCXf95o4l7m+WRqzprgu1/4
 oRW78JAFHTPMVahU+pYe8QclqUlcX94CVhM+MssW9cKd0H/KVw2ytsVpsrYk6+v2871F
 FA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875862; x=1711480662;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YDjDpwZx4G+C1l8kk7k4I1S9kgexRc6lFLciCFujiKQ=;
 b=rP8b9smCK+O8ZUM1EEFY7tkH4gu9pYqnuI2aqJxvx2lxBMSROa+D2Qyf/KxWYP2n+z
 EPasLD0bXiRq0FW874m0q4TB4UgmWRnbMQ1FzPml99SzcBr3s+bMklPuJxkQMwmUxK2D
 Z9hOaNbAcAI1sGkhuK+/MdFSR74CHxylDeVCj9qzP9nmo6alZAkjEkVK155WvsZNOxjt
 4l47JdazyQ0NH1oFf4sql3tXpho+d3VpWGU61KQV25163WIMm+5rEjiDcl6NwLgHqQiZ
 CYWER6y4ru8L08BMYpgywBbgVVs9JW/aOmR9A6xX7s9FwHFpyNzje+dGgor79lpxDKtH
 Vh7w==
X-Gm-Message-State: AOJu0YwZd14ZCfvyvjXOykAWqFGgKirc0T2T5FakA9sFNfMjscaKpjmY
 knOgTmXd+iH7KhTi6/llC2sYubxAGcMk5QSWMFqtHBQ1AfEzp8hNjXrY9WFAUZo=
X-Google-Smtp-Source: AGHT+IE3PNkk+mieXCssifJ6EVETOC76rfKP1VQ8w2nxq6044+LdaPGSPu2D2mGqys21xHnUzFYZUA==
X-Received: by 2002:a05:6512:32a9:b0:513:d976:496a with SMTP id
 q9-20020a05651232a900b00513d976496amr8742832lfe.50.1710875861632; 
 Tue, 19 Mar 2024 12:17:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f23-20020a170906049700b00a464efbb01fsm6395488eja.107.2024.03.19.12.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:17:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6F895F7AE;
 Tue, 19 Mar 2024 19:17:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 07/24] chardev: set record/replay on the base device
 of a muxed device
In-Reply-To: <20240318154621.2361161-8-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:04 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-8-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 19:17:40 +0000
Message-ID: <87zfuu2fqj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> chardev events to a muxed device don't get recorded because e.g.,
> qemu_chr_be_write() checks whether the base device has the record flag
> set.
>
> This can be seen when replaying a trace that has characters typed into
> the console, an examination of the log shows they are not recorded.
>
> Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


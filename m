Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83825CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jDN-0005wF-Uz; Mon, 22 Sep 2025 12:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0jDG-0005vt-5S
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:16:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0jDA-0007v0-QN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:16:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso32575465e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758557776; x=1759162576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7VVMkMl5Rl/lSrVBPmaRTNHV2FIwHD0UnJn0nmEA70=;
 b=A3hrYVa95hFbxW5ELptG3lOA0CLryq5R48V30klbE/1Ga4YLr1J+ns8BV8r5dU/Kct
 R4oiReVcpFjHxudXrH7is43t6AhjWSwHkkT52YvdMXrxNXwqlvMvY//yO8JNVp50eo+3
 UvBwo1YGW7fAyRmwoxirexar09p9wLauZoK4pk/2OHBeYucTzVD2biyvyBrwlyDdXi7X
 XoxXmtFvi9sqH1SLCFwPTL8YkqCzFyuB0xV+kkxJG9zYX2rj8m67GWX58ceawziIzzEe
 dJub86RXVgzjPXP4OUqdld9lflXIiYCwKhbtqQFvR3ahaA3dfvYgQUdkYOrDmtK+aT2a
 vG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758557776; x=1759162576;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t7VVMkMl5Rl/lSrVBPmaRTNHV2FIwHD0UnJn0nmEA70=;
 b=n+7GYk04mh4UBKrKL0dwZUiYGdKjN7IF6H58H/rAXgzSXGTJxS8uK/AAx1Chz82Kb7
 a1xGiTdKtBU0BOtzPJwyKiN1nM3end5UnkNXYQ9njXzI3vZh+p2MY1ds2FhUAjwDZkjB
 jB90os5OLpBtBeFc4cfWLdV5V8xjLsmUEe7gWszoU97C7SXUlN02W6iv1Fm4Pj+NQETc
 JJjqNezJIRz1TvryMDMcjXOy7E0NO6r2WV1fATiZzZR55qhFB/EvS8fz2B7B7wIB3zGG
 r2obuPzHGAZh5qDw7VqDA51f5lsAPb5ugIUK4lUcYF5ueP7I3KNT3TA4cfIYBJBJdJRe
 K1XA==
X-Gm-Message-State: AOJu0YxOUkPrt6L0hZBDXCOkrmwJTMzbMHjiBydI/841Tmvj+f8G82dD
 3cq052XU8U0dTs6WEa0Lawm2oscSXbrlusb5w9Zs1/GXIONVcgMqneqBK7rMlMPocYqXmh1EtHY
 exX3oDGM=
X-Gm-Gg: ASbGnct+H9E5ax0FTMWcAlYWT9LEfvCpHFd+KfaIyu5HcP23xISeMp0uMzmSxXwtiqT
 Q3+ARpyg5v6Pvr30CZpVoxfjToBVhzlKtvFy/5Mgh4SOoj3nnJtMM8fnaA24cJs2mXEr9wkxbEm
 FDeH0EF6/X5riNdP3jZ3im8K70ugV77OSOLPl5x8CV0mq+Lv3jwQIacIH/HbpbeOaQnMk38kjwS
 mJZcIj02N32ZE323sJmms5QCl45TYM0L8vL5kEuQcdQZbKOkvfhuPW7eUfRA/fUCVGNGEHBgTGq
 XUGGcZFFUxsTf3yHTTbyUHOI36iN+5CbGP3jEqcD0+A+i2r9qNm0YQc0EGkRRvyQKP5h22VOgGq
 5beneVaBOo7BPAGvVzylkHrc=
X-Google-Smtp-Source: AGHT+IGx7h92nvwouFyctz8EJoMvWfOxWuYvlA0USf1yewmK2Us6RGKahLEkD+cEpFO6sdDEuLG8yA==
X-Received: by 2002:a05:600c:4b27:b0:468:496f:bbb2 with SMTP id
 5b1f17b1804b1-468496fbcabmr75597815e9.7.1758557775958; 
 Mon, 22 Sep 2025 09:16:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ef166e62e5sm15602873f8f.40.2025.09.22.09.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 09:16:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DA085F7C4;
 Mon, 22 Sep 2025 17:16:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paul Buxton <paul.buxton@codasip.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL,2/2] .gitmodules: move u-boot mirrors to
 qemu-project-mirrors
In-Reply-To: <PR3P192MB079624FFEFC75CDBFB26B653EA12A@PR3P192MB0796.EURP192.PROD.OUTLOOK.COM>
 (Paul Buxton's message of "Mon, 22 Sep 2025 15:37:04 +0000")
References: <PR3P192MB079624FFEFC75CDBFB26B653EA12A@PR3P192MB0796.EURP192.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 17:16:14 +0100
Message-ID: <87ms6mmpip.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Paul Buxton <paul.buxton@codasip.com> writes:

> Hi,
>
> It looks like the=20
> https://gitlab.com/qemu-project/u-boot.git  repositories have now been re=
moved. This breaks any older builds expecting those repositories to still e=
xist.
>
> Is the expectation for users on older versions to update their
> submodule paths? Or is this accidental?

Yes. The patch should be trivially applicable to the stable branches.

  https://patchew.org/QEMU/20250908141911.2546063-1-alex.bennee@linaro.org/

>
> Thanks,
> Paul

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E7DC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 23:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTUgn-0003N5-La; Mon, 15 Jul 2024 19:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTUgm-0003MW-Ry
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:01:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTUgl-0006Kf-8H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:01:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70af2b1a35aso3259871b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721084457; x=1721689257; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqMzgmiYvU7mAURfc96q7iOhB3+VYvgcJRAsUs7h4OQ=;
 b=OPxMIXxemgLkZR5JTBkWFFTUk++jt3ltluzQon/gU3/BNO+ylU4T2tpAVdcPf5oANT
 R7jCXv5ROL/1D4e8X35V3kSvwj/juSkowbMCdZYOKO4CElvev8dPYsErASELNjSLCo9o
 siYaiBS0gel+dQsTl3GSwWhFQvxfK9OPMnIIw3wCtaIIn9vXXVjApU1L9YqKgsY3M94t
 x0RjJKJ49gQ6v0cq7a1bAu4bJADf46gzU/SbcJZ5dEMOXMM1bG9bAZ/lpOiwNyaCNxsP
 50j3moH807h4NzBZTLXeH95FvEwPpm8VlNG8BEXFFVXECPosS7o87OxvRJui7HiVM8Gv
 mE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721084457; x=1721689257;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GqMzgmiYvU7mAURfc96q7iOhB3+VYvgcJRAsUs7h4OQ=;
 b=Kk6vskRm3lcbkyi8TT3gE1YX+n+0HA/A4XXk00vIrSdQjZFA8ppJKyF0Ms9OE4pI4T
 ic0T7DUNukeWBSqjKzIS4MBdBP9zgpoPINCsOBL70Dd+ydj16MDHhybAno0aEAEVrm4t
 BSOaDtI4kiOGT0ed9kJj+xn9GAIDwUapdX1B/a5QKaW1Iv0jWYDxSxxZs2VF8eVFpmDV
 OhPEwXn80f41kxxLuJRdqa5gcYKAyeuET2erFFvuZUGv5SfnIpY+Ddd4rR27thHXR2lY
 ARSMk0E/E4P7Jreid1xZP70k4zAK9lK/dwy1VhgKPRj7cP2kx58Ac562le8VD6Pd7X5v
 90pg==
X-Gm-Message-State: AOJu0YxF5GNpEi2smV4Es3hfMWw0f+yBom6l/fjbXhnbX5KHnCUtTK1o
 l9PVJIwZxlknTe1vBylem09TDT5ArcKRYX5YbXEQZtKfKZD7LzMUAKn5SXUDk2RkC1w1KAzdw1R
 1T1Jvag==
X-Google-Smtp-Source: AGHT+IE6iOlE6xWfKCdEVTVlYbZxfViAQ0px8JZNbd+qyKspQVEVXKz613y3iKY3XRiVtHfiSesIzA==
X-Received: by 2002:a05:6a21:7899:b0:1c2:a696:6a48 with SMTP id
 adf61e73a8af0-1c3f129aa16mr426518637.48.1721084457110; 
 Mon, 15 Jul 2024 16:00:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0b9a0f78sm47557155ad.0.2024.07.15.16.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 16:00:56 -0700 (PDT)
Message-ID: <63699dab-42d9-45ca-932f-acd6df688b6e@linaro.org>
Date: Tue, 16 Jul 2024 09:00:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: FreeBSD update required for CI?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi guys,

CI currently failing FreeBSD:

https://gitlab.com/qemu-project/qemu/-/jobs/7347517439

> pkg: No packages available to install matching 'py39-pillow' have been found in the repositories
> pkg: No packages available to install matching 'py39-pip' have been found in the repositories
> pkg: No packages available to install matching 'py39-sphinx' have been found in the repositories
> pkg: No packages available to install matching 'py39-sphinx_rtd_theme' have been found in the repositories
> pkg: No packages available to install matching 'py39-yaml' have been found in the repositories

Has FreeBSD ports updated to something beyond python 3.9, and we need an update to match?


r~


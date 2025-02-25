Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400DEC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn07t-0000S1-8n; Tue, 25 Feb 2025 13:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tn07r-0000Re-RN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:57:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tn07q-0002NL-0c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:57:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f325dd9e6so3144825f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509867; x=1741114667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKeJckXh02muOHav+sX40o1d9PTRHiNcm43oyBpHGLs=;
 b=fpVssMK3AQ3UkT/GrTVpof1wPvR19gubR7UZ8JUHiRwaE+Ke0SKSp8KzYKlJH8iaxE
 349OLSLljZp5vGpbTpQw13f47DsNgxFr9Wgk4BepmrswOqNDwi8KtoziGUD3hEuWrmma
 1JePQYPERYsirCPAlA8rSR0tSpLI2Ki1tJmkHaCuLy16fUM96PYt0ENJr8YESaa1dERo
 HWZNyNN2jkQ1FSnTiW3iw/Y+mDF+yOdFAw6ou+AVnz82C4a/D2s0KflsETWw8Bd5G0gk
 4bykWcdH60/JkybQfDnVg6xJDhs9vqPn0tXm/ka+CC29w5qrURkhxgqkAMH+MAmr2ayj
 deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509867; x=1741114667;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKeJckXh02muOHav+sX40o1d9PTRHiNcm43oyBpHGLs=;
 b=UiaOZl71m2f21YKbt5IVimJrAHF9i7pymtgght36b4Ex29/pSmQpvC9fPB0/gTzsZQ
 dUqikgNZxYuAVZ7rhM20TrOqhpr5sLAEh4onW/QbOkeoMnXfcjOjBS0uQ62cxM3Qd/QW
 C/IU44VzIVvJiqDgbcBExCL4BdCNau80rKVmGJqPikBIMY+9ZW4QOvjevnq/kghB059a
 8O495EOlj/NIHI6YlmnAMDLhdpUS+A1d+PygFocD1pJ/DwvVmr0bel3Zy0uxrxAp3Q9E
 Wvs1dnmHbErOsmCaAO8XOGY6c+L71uiZBrTbq1fXaT0f/gATBBg5R75vkRVMPyr9bZHT
 Ryow==
X-Gm-Message-State: AOJu0YzuEw8+u49R27Cifc7ol77zJYQMo17Z01A1uvwPbGHS04w0jVJ+
 Cs/XqoV65sx/LIQ6aELjlvBaE26EgGYf+Rm5/U2TReVEPm407n2Dtkl20zmFKZapafKuPNHy6dj
 znhw=
X-Gm-Gg: ASbGncu+dybsjCH8Yl8HTnNmnvnxA5IrlqhoDoR95clZ9SZTnZGiGI7U8Y67yL+zqy8
 7IVqfC5gcvt3jWTe2rMPHmaC5yQbfgHNLIJ7oZYMYLqvl+uT3HOmZUVBxlb/T2lgWscqL42v+uB
 hOR0b7TEv5iz1Xjo9ddDmceIKHodjDYSP7tO2voqFyTQudrSz6+huCZ45CKyQbnTyX9o302nrdS
 CPEPyARG2JjhOszi6if30rXP/7UsL6kuV/FzeYZvzfITx6CZp9MPbxSZqgp2Iz/n6YJ9Gb2IVkd
 hRO8KTO5tIClp39cTBiGuytObqR4
X-Google-Smtp-Source: AGHT+IE2ZskyQA2ozaSgjgmY1frTSmiQBVWdNZ+RF4TT9qjqnPXrNXes6Gy4HEZDJhpK4KzHlwhR1w==
X-Received: by 2002:a05:6000:1561:b0:38d:d387:166 with SMTP id
 ffacd0b85a97d-390d4f84aadmr279799f8f.34.1740509867436; 
 Tue, 25 Feb 2025 10:57:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86caa8sm3192571f8f.25.2025.02.25.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:57:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0712B5F7DC;
 Tue, 25 Feb 2025 18:57:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/10] plugins/api: split out binary
 path/start/end/entry code
In-Reply-To: <5c79e077-138c-4013-bdd6-0719dfe1e26f@linaro.org> (Richard
 Henderson's message of "Tue, 25 Feb 2025 10:32:19 -0800")
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-8-alex.bennee@linaro.org>
 <5c79e077-138c-4013-bdd6-0719dfe1e26f@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 18:57:45 +0000
Message-ID: <875xkx6edy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/25/25 03:08, Alex Benn=C3=A9e wrote:
>> To move the main api.c to a single build compilation object we need to
>> start splitting out user and system specific code. As we need to grob
>> around host headers we move these particular helpers into the *-user
>> mode directories.
>> The binary/start/end/entry helpers are all NOPs for system mode.
>> Signed-off-by: Alex Benn=C3=A9e<alex.bennee@linaro.org>
>> ---
>>   linux-user/plugin-api.c | 43 +++++++++++++++++++++++++++++++++++++++++
>>   plugins/api-system.c    | 39 +++++++++++++++++++++++++++++++++++++
>>   plugins/api.c           | 43 -----------------------------------------
>>   linux-user/meson.build  |  1 +
>>   plugins/meson.build     |  2 +-
>>   5 files changed, 84 insertions(+), 44 deletions(-)
>>   create mode 100644 linux-user/plugin-api.c
>>   create mode 100644 plugins/api-system.c
>
> Surely this breaks bsd-user.

It didn't seem to - but my local building isn't working so maybe CI
disables plugins.

>
> Ideally this would go in common-user, but I think you'd need to move
> structures out of {bsd,linux}-user/qemu.h into include/user/.
>
> In the very short term you could put plugin-api.c.inc in common-user, and
>
>
> #include "qemu.h"
> #include "common-user/plugin-api.c.inc"
>
>
> in both linux-user and bsd-user.
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


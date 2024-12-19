Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACCDE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIm-00028B-U5; Thu, 19 Dec 2024 11:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIjB-00069g-1T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:17 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tOIj9-0005ja-FS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:16 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so160125966b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734623174; x=1735227974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf24Vjtzavfp3NiDUW6ymoY9HR1UpY01Xz0vftfudo4=;
 b=fcctyQTRCEKHKDaUO3Q4rV6SpnOxgMREFmT1mEMLWJd79FPrdmclp7Wt97eHFOzacK
 8pU6oatOtPrfYx9ZcM45K5Tex7isoxhJT8y4DtnduATy/eHjdfaW4RyD7jJDV+zfs3l+
 dVEfSTpdqwRTgUsX/5ece3mfONPdOxpCHf8miSqrn0iSdTfAKwEeEItcabDhsneei28/
 UFrI5kvf15AipcI3hSE6vlXMcWsjYez2hZKxIEx21rUX475+58AZsaX5mp0PLZgo9D7v
 5fpPYRKbsJVUR9jAQCtTlmaZNCmT2Uq70YH+tiziU51AO1VYKHupM1bI3dNdJQs0O1uZ
 trSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623174; x=1735227974;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zf24Vjtzavfp3NiDUW6ymoY9HR1UpY01Xz0vftfudo4=;
 b=VgucyWTX4vVQurKt9cIxK2aHfHxtLojJ6JqT/6qM1xBAt3i5UYi62hrYD7iMeWs3tk
 Bad3xTFiZmELtzYx7W950w04ezUSdc07asikkNtw1M8wiuZC6l23ns1lZIoIi3m1K48K
 y2qMir6jyA8rKzU092VLb1yNabMxydzS1q8U0gHb+krdkUCo4xowkLLBldBpFMUojhqz
 gSOL/nkMc2c8piZi6LO7S5zSU00ytO88X+PUqRWYWGUp9Q+6cxnLTMHgGRLnNfsusnoF
 hrSgeD3SV0zlfdjS18ZAbVhoujPjKAYe1jPgY5LE4Tp1l300Ta+CdIbExXngzUb4ftdJ
 vgnA==
X-Gm-Message-State: AOJu0Yyz7kH0Z0+cVrntvurSD0Tb9935+2kDCPvyUan0BRMIJ/wMo7aj
 j7Wupx1dY9M/lQjHzAmN2EiUMKYjIcwfAGdKO31/gkjxgm76pPzvlLz7l8a9xFM=
X-Gm-Gg: ASbGncs2Yx51AUGj2jeFXvmEBOPCEfED90Sprh1mJWwYN80PpBZNBQJQvCm766RIbHQ
 uONazbvwPBBTh7pid6i5cC0G1yZD9Wqumn556ccayozN0vvod9l77rSq7GFCX3u3TP3plyKAU2S
 BNBeeD3LHTWoUG6KjG9YSHUd5/zKxgfmjaSPVPisW0T/BxeN7Uzj8vSjG03csLLx+LOoinNt1pL
 zqp0BSqFiZVDG9KMpy5USYZ3pc+pQRW6HpLzBTApgUqKCfBYuN0K6I=
X-Google-Smtp-Source: AGHT+IEzh+m7Vj0uxSk7uiGtg6T6XaLX4H4/WNZuACsZopxToAdLjkoIO9FauMj2DHATb0FQBZgvBw==
X-Received: by 2002:a17:907:d87:b0:aa6:86d1:c3f8 with SMTP id
 a640c23a62f3a-aabf48c67dfmr715644066b.39.1734623173834; 
 Thu, 19 Dec 2024 07:46:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82eb8fsm78357866b.35.2024.12.19.07.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:46:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2C0B5F867;
 Thu, 19 Dec 2024 15:46:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,  devel@lists.libvirt.org,  Laurent
 Vivier <laurent@vivier.eu>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/3] docs: Correct '-runas' and '-fsdev/-virtfs proxy'
 indentation
In-Reply-To: <20241219150203.55212-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 19 Dec 2024 16:02:01
 +0100")
References: <20241219150203.55212-1-philmd@linaro.org>
 <20241219150203.55212-2-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 19 Dec 2024 15:46:12 +0000
Message-ID: <87jzbv3ccb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Use the same style for deprecated / removed commands.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


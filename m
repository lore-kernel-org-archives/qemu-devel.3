Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1204BE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9aX-0004cc-Gb; Fri, 27 Dec 2024 07:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tR9aV-0004cG-VU
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:37:07 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tR9aU-0000LS-Cm
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:37:07 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aab925654d9so1295414366b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735303024; x=1735907824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRVFlQ1w5qVUT0xn2kB86mnfBEFJGN8Uy78qpttATGQ=;
 b=Ryqb+Rt3NDA7ASMZ7zgxuYIY72APld2B7ybX/9IYAAjaZBi+5CftlJyO+u09usJ+1m
 5byvV3x2F6BUh0C9mWJ71q8t5wcekocBgDzwlTyi4M6g+pkvULevPcEi4lPr4JdPpynJ
 ZcHtyWCoWg2h95ZlAET4CQWHabLUVkFvdGbqHdHdfZv+JTK6CRdJljyMd6W7ETbhQsWf
 bgp3EFdE938XXSMrmlGM02gTXIWERxVqEksLJ1cKJOMB/vrmxDC1UoismZIFULHTOXyz
 rjkFkbKvb535gSDq8SAlX4VfrXcqG9Lg9AQj578IIs09r60Y/WPKvr2qAP594cwA8zUJ
 ZgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735303024; x=1735907824;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRVFlQ1w5qVUT0xn2kB86mnfBEFJGN8Uy78qpttATGQ=;
 b=PNbuZXJjWelnGjqHB5arl7M1CnRWZgM0tmU5upwbU8dRMo96sWNsaV/P42O+g/IhRk
 EBo/3xEqEJfnRnsAUKoWHogLxuCX3HJSmdoQZDgNn8paSvxVH3JugAeZEFuYZC2tPnYa
 rVgL/Npeep6ofuGpNnesEAEh3b6bHGCvge2f0pF7x1+CYCyUEUs/IVngEBNOySuq3vD+
 1RV444DhFaaXJ3OUe18Om20bdGa8s4Dfi8H6di/gjLCNTRfUe3i9/9gqR7BIfx21AtG4
 l+OjrGBo3mjL9K4mBksbvTrlfyeg9pMeWpS0sxNGZBCqhPpCcgfgYClvw68XwDSJbSAM
 Rm0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo3/x6ocRwIiyOHARs96NSPHQvbm0E470C8mNNLwmnbUoUsDWXfhRtSRgGsaDm5JU1eflfJbNSXxCC@nongnu.org
X-Gm-Message-State: AOJu0YyVTA8/Vlq5ALW1ge6dovF+m2BNkEafznszLnt5s7vA62A2grxe
 5Aj2P08x6bpLB1gzIvByEB06Kq3EF64z48QngOioop8JN1tHvtgp0aNK7a5NVzc=
X-Gm-Gg: ASbGncv5khbdz45rZ69RT5YpALTuq+VkdHjPED7KBLempUaxq5KSnHUXZ6rwIZCiB9N
 3r9RyVpAMikYCC4sbb6TZk53Wmi69Qn+udcvoW9VX1ognPtjWhKZef7rYslY47dDbgGHu/lSGcm
 YFEhj1YEOTvZd3hFNNnmGRlOMDb952dOedDdszOTevAvNjMMoM9/vaSuTUwpqupOjTzP6P4xSZi
 OYpsojTJ0FSj4SE3NoG4DOC3Hncn5G6Q6K/lh63wBlGUx1QC6pbIAQ=
X-Google-Smtp-Source: AGHT+IEtGkWC37MFwqtcldO29YrmviLyixGWxz5JjAFLILfZxpBByljO7gKfc5uPlRye6CQxqy/gCQ==
X-Received: by 2002:a17:906:dc89:b0:aa6:af4b:7c89 with SMTP id
 a640c23a62f3a-aac3446dd7cmr2200247166b.61.1735303024274; 
 Fri, 27 Dec 2024 04:37:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89514esm1110967666b.74.2024.12.27.04.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 04:37:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC22C5F8BF;
 Fri, 27 Dec 2024 12:37:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tigran Sogomonian <tsogomonian@astralinux.ru>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v2] hw/misc: use extract64 instead of 1 << i
In-Reply-To: <20241227104618.2526-1-tsogomonian@astralinux.ru> (Tigran
 Sogomonian's message of "Fri, 27 Dec 2024 13:46:18 +0300")
References: <20241227104618.2526-1-tsogomonian@astralinux.ru>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 27 Dec 2024 12:37:02 +0000
Message-ID: <87h66pl2tt.fsf@draig.linaro.org>
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

Tigran Sogomonian <tsogomonian@astralinux.ru> writes:

> 1 << i is casted to uint64_t while bitwise and with val.
> So this value may become 0xffffffff80000000 but only
> 31th "start" bit is required.
> Use the bitfield extract() API instead.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


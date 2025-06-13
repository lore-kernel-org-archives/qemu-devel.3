Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4CFC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 22:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQCrk-0004B6-3r; Fri, 13 Jun 2025 18:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uQCrg-0004AT-7z
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 18:27:12 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uQCre-0000sk-Hj
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 18:27:11 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso973008fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749853627; x=1750458427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53LCWwtjBsJih5SgMyaJboAcq2zuL0xQA5d2JRjx47M=;
 b=SPq/vz1jw2O29FjZXX8za2RrbgXDR/lr7Nc9ofDiI4vO8AdDuGEvb3UVrJvmo65MTE
 mgy+LDTYupXayYM1gs1dYZlqD9puwN8un434lasl5FhjbVLp8ucuzmeFWHikC4ES+m5D
 s0flCfJWSe+rZ3yYncMcfyTdcp1vbqPoAH6YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749853627; x=1750458427;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53LCWwtjBsJih5SgMyaJboAcq2zuL0xQA5d2JRjx47M=;
 b=Z5Pg/KUXZs3B0OKxlWDeRMZJ4WEom68679gt2kuay8dvlXmI5WnQ5tBguS3z+8Wbmj
 zysiGp4vz8094BqRPawAvazGsuIg3V7WsaZTpo1wNkI/zvXSwgMq1/ZLAAw0ru/aO22C
 Zi5qEHUlkzKGHptOOGCp7013q6czuoIFQ+rbuRt/nxyTCHHbBDYhpg79+L6YxOw2fMxe
 Nj48qsHykCqpwAeJmJRjO4Y5Evcfdd2nFYD4X4Tmnmu0HgmDvSZwHd2GLcB9QpujSjcV
 IvvU9aMOoCi9EJNc4Q23dVQwCS4AcgL1q0soTjeXnIKZfuxPjCh5AfdWkZ36i79Nc+HE
 A0eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcQgtpgoULZuIHPtPg+kum4QlKZrPQIpuhYjjVbP9xE0nksFf5OIETVwy0OhbZPayFu/UpZr8pVook@nongnu.org
X-Gm-Message-State: AOJu0YyLwyd6FprdHmHEJTcw8dt3Lifr23KuO5zVKIguj9CnczhZeChi
 tVzcyVESUONZFN0hJHDbLIH+MY8yWiTMsWi0DaMT+zFlvs9wUzrBU6g7q3w5GfHoOXNezhrOwsw
 DWYn2aTs=
X-Gm-Gg: ASbGnctC//kxUuShDNi6AFWB23an40F5UjXahLPz80wepI+cX+KIwb/LmxCUX16YoeW
 YoWLTl96T5H/7xpM69D2V/xF0smUBrbcD/H6adqgjvKuifJQeB17c10N4M1gyb9kC7lnpv7pMk6
 Tiuq7B3TvIPev7Eq7FghyEUcsQxeOIn99JetLWPjgacdNCBsFSCzgp+HHAyyY8tjj5YvqX9Iu9d
 0ekYaf9NB21VJ2OT5N3daEqVugTgtkBgwioUXgWrbRoTYw0Hrh8eDcFA61Klx+H3QQczwOegrCv
 u65juuMp294tWzaYHKJF60gH6sFcX5mnqMPtK/2fuEU/toPqccAGbNMpCdpeUQEMDZc4rWtAuA4
 NkuVisHDRL4EWu1vN0wRrqzp7IrqcdP3R
X-Google-Smtp-Source: AGHT+IGQyeJdGTk+cQHSXuElQOzxDQBhOErOvVmfeHFfTnl10vp1osa6jYCZ8GdFy3zMo4IBMG6fQQ==
X-Received: by 2002:a05:6870:1cc:b0:2e9:512:ee1a with SMTP id
 586e51a60fabf-2eaf0835465mr889020fac.4.1749853627250; 
 Fri, 13 Jun 2025 15:27:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8e6bec6sm885548fac.35.2025.06.13.15.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 15:27:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Phelps <andrew.phelps@canonical.com>, 
 Alexander Graf <agraf@csgraf.de>, Boyan Karatotev <boyan.karatotev@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Fabio Estevam <festevam@gmail.com>, Harrison Mutai <harrison.mutai@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Liya Huang <1425075683@qq.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v5 00/25] passage: Define a standard for
 firmware data flow
Message-Id: <174985362441.860502.7163329201162812483.b4-ty@konsulko.com>
Date: Fri, 13 Jun 2025 16:27:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=trini@konsulko.com; helo=mail-oa1-x29.google.com
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

On Wed, 28 May 2025 06:32:02 -0600, Simon Glass wrote:

> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
> 
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
> 
> [...]

Applied to u-boot/next, thanks!

[06/25] spl: Rename jump_to_image_no_args()
        commit: f73450918d66565c5efacf2bb57227ba94bdaa40
-- 
Tom




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5707CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VD-0003yR-V3; Mon, 17 Nov 2025 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1V6-0003sr-UL
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:44 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1V2-0008Ha-Rk
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:44 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso2456132f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394627; x=1763999427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jc/nu/J0AL+pY15UNyyOgb11bFycenf4RnmDHJT64M=;
 b=PzHeOvHTX9NdvRoEc+znlWEz9BtqwVISliBoLZeRFQ8eFc8SqlBuRkRLB0maT34swW
 3bZrUuckTvgEwIpCXQSYCfec7IhGp5yqnjx5xZZFTyt0KeRyzcxiBVMwEkQ/jRx8oGJo
 Uv36f3R/ZyEY9UxV/vPFbV+b4tiFeBVEy0BbeJbOhNwWGC2Y81oSNi9g/85z1XGzoyae
 V54Ao8T5nmxx6epbWlWTdBmhVDZrZtJQuvBhkO1S+jf4bTnAB7dK1M6DzVWIVVuOQZcO
 5G3sXKuL7fOwBS4qe+arBMmP7JEFXE2/80o76Dal8EdClcReefB6jrABeRk2EsMbk0m6
 ZwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394627; x=1763999427;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7jc/nu/J0AL+pY15UNyyOgb11bFycenf4RnmDHJT64M=;
 b=InM6b8esNzofCdpP/R9LYazzU7NMFNhTFXjwKus8OcQ4rbaM/z8o+KYjRPHOyCGAIi
 typwjjFKa+Es/YnnetEHp52MNgDIEnvYVPqKyp2s+d3yKQ811AlcTY07EZ8ZruBohFNl
 KuxF/IqWGpe2X6JYJfq6/0Z+X56AuSfECAuMNbRMY6dx2uNrCoEOSncRDv1Op6UKjcWF
 dTu4ISL26jQtMpuW/s3jchBz1G2DtwOGj5YRZU63nZoCA4/VPkXEc8fJ8rq0Ja+eAZRn
 8D5zHUNqMaW6qW2T+I2ejE+OFs4IX5z/wfc4IsPGcEq5kRYnndQPBG2Np/Q/9V4Jk8Yp
 MRCw==
X-Gm-Message-State: AOJu0YzhTBIke66SyuIzXyqW3SA9lDL+vlwRMi5Zjm6KtdOgGh84used
 rwEXjaZDLjs5o6Kdi2COHgZv351imDdFBHvo5cuURuyPIIufMMtbqVIlFra2oaO4ZYM=
X-Gm-Gg: ASbGncvV44GfAFvJzerNNMxvG/bLU6TA6LVu2LYDnU2fKekFrM7fy6jXp4+W62fWTLx
 pGtEs92yO/4Vwadx7kWKzhMAMS64E2K4KpBOKBvtFPx15aekdUM0Fvy0kW87HQ9+BN0ZXbvTe+U
 coO97DYpL4AZzmW5Z+Gmx6ACJurlhefmp6K5/5H/DBPBehWO6QrvE0M7u0ea24JboZcjGxs7CxQ
 x1Ei+Vh5neFM7wuKiI3GVgbJXzkiYig1y/watjRea2PZBAYnGxb+C1K++mw8fwbhf2D4dw9govu
 QslKe7wx6qSeR9uCwCP+4Ye6f8Zi185lIMIsIiqFWLIFy551B7vWv5KpZfKO6PlEhX0ii1xIVVI
 wvb+O5Irb9JWfwoWDQLIy9H0TM31xPDxJsRxuonawa1oSan5Hamik8SUhaWuT4JNDR2r74ZKMSx
 0uX8i6al4iLM4=
X-Google-Smtp-Source: AGHT+IEPyg7Q7nST33WVAn4TLz8sqsSDTTZWkdxTE3F0TV1WIg2f/oxGFvVjB/aCngo9njTelxtQ9A==
X-Received: by 2002:a05:6000:1a8b:b0:42b:2f90:bd05 with SMTP id
 ffacd0b85a97d-42b59374c07mr12492448f8f.45.1763394627051; 
 Mon, 17 Nov 2025 07:50:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c961f6e64sm13559448f8f.27.2025.11.17.07.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:50:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8AEBF5F860;
 Mon, 17 Nov 2025 15:50:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Ed Maste <emaste@freebsd.org>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Thomas Huth <thuth@redhat.com>,  BALATON
 Zoltan <balaton@eik.bme.hu>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,  Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Li-Wen Hsu <lwhsu@freebsd.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  qemu-arm@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>,  qemu-s390x@nongnu.org,  Daniel P. =?utf-8?Q?Berra?=
 =?utf-8?Q?ng=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 03/18] tests/lcitool: update ENV stazas outputted by
 refresh
In-Reply-To: <0d18d036-f93a-4874-9306-ec769cb375d2@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 17 Nov 2025 15:00:52
 +0100")
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
 <20251117115523.3993105-4-alex.bennee@linaro.org>
 <0d18d036-f93a-4874-9306-ec769cb375d2@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 15:50:25 +0000
Message-ID: <87seeclku6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Typo "stanzas" in subject?

dammit - just as I sent it...

spin v2


>
> On 17/11/25 12:55, Alex Benn=C3=A9e wrote:
>> Now lcitool has been updated to use the non-legacy ENVs we should do
>> the same for what refresh adds.
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-ID: <20251113102525.1255370-4-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++--
>>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++--
>>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++--
>>   tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++--
>>   tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++--
>>   tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++--
>>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++--
>>   tests/docker/dockerfiles/debian-riscv64-cross.docker  | 4 ++--
>>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++--
>>   tests/docker/dockerfiles/debian.docker                | 2 +-
>>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 4 ++--
>>   tests/lcitool/refresh                                 | 6 +++---
>>   12 files changed, 24 insertions(+), 24 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


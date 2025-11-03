Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1468CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqLt-0003Mb-Qi; Mon, 03 Nov 2025 03:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFqLr-0003ML-OB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:55:47 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFqLn-0003jQ-8V
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:55:47 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so1791488a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 00:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762160133; x=1762764933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUGYcNfJbTsdbnPIinLqkzdtSXtCUhPLlDDjPVm7xa4=;
 b=cA0rlOSmLuw+nBEgSFVoKOiRq//NbpIPSWFXfKT2f1ndtwluB7rbNoJzeSo2DQl5J3
 vGc7STF6Xx1I4NtBsXxdMu7LaPPCTDB2X/eYua2y4Rf15/0HU/yfq+TFcRG5zUZFhbPB
 msVrxOTS+wajnRYP9Pi0TcMQIhwp1sgL4rrY3RNR1lxfe6Bc8sV3KRfuR1oMmVNi558i
 KJwAMxWY5Pyzi6ytXRDxNC4jXCQjVlbTomxTxI7GK61+4Y0bQjvncgaUR59zHW9JfL23
 lZymGabT9mDAsyTt5uaRSKuvFe+v5byb/LmXh62a48l9PWkF8XnxxJp9tYbVPFruGFnF
 6i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762160133; x=1762764933;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUGYcNfJbTsdbnPIinLqkzdtSXtCUhPLlDDjPVm7xa4=;
 b=ugPb25D3UduvztQ2CDj4xSk+DDQzfQbWiktbqwzinsAi/bARjr3jbDhOmn62b/YuZu
 0oR+0F4ewlvSFng/qA140AyRAsBJ8nGYAcbgL8HqanpzEI/S/t2WO1jLMR5mkxXzXzjI
 cKng7MJvKCaLfi9TJYu7RUMXem1fYib+c7ahfENNWrORtLDv6BaNwTRhkbSQPtfLqK1J
 iATJQzC3x/adwU9BqYGnc2VQAppCobBaih4o5StZN9nzDssR2qqr4kxqCcsKxYxYV27/
 wVOmkjG7HfhYrmtwCSSmAPt6vO7bVSKffAMu9YN1YlD3VSB4OKIViy3LdvJyylB6xaAB
 wu5A==
X-Gm-Message-State: AOJu0YznIeRMOxjXtYThVnqthg0pxoCrgZ9NpzqFFGGb0cRLzcI722pM
 hxO9Xnh5LLEpHnHHEYzcLLHY6tzvJ6tDtyrpcQg2RADln4pBPNQdaO4zY/MKxg==
X-Gm-Gg: ASbGncvSLCEvCi6X8m1mPg1marVU4ztjCVYVzBunJideTBGxf7TLq3VKDzyYN0WeDwa
 fy7m8m++c1K39X94kEz8c4BV+4bZs2LWq4cLvitiGn0AV2F66bX4Hqlv8DgGhojtbd0Lh7QhSPS
 i1WOnGex8ylg2s8wnrnJtEusrYrD9YpTPsaq6Q/Xar/evla8b7zGLZGTk7N1hxvFXKyFc+DZCzy
 jwZMWtPR6rbler30XRm49ekk1ll+6PUe6d3vyjbswD8jVk76J1b2+eZfKsBtGvzCnElripJCREJ
 X2UUzf5SByfxUPwY7IKAYeZoAIhWByLmMSHmde8Uc4yKQtEnT4qcoTsD+g3Ra9xvkEC1qs1Wqsq
 TZPekk10Ghow8RotwMp8y2u/raMgH/r+2F57y6WkeWL/UL4ahikDPsbCyWpsSQ4uyH6TX8Wv2K8
 1VRHswM44sIsCf+O3261YQjUhDC4li8JsWfWOUUIMzXr8oo/kKKDOrLSbnv0iLyd0=
X-Google-Smtp-Source: AGHT+IFJG76yP+7CzRpLRK9tOKTbByXd3Qk/1eKlI6wH2b/vegPqAczSH4PC0MHTRmEqcvAFHTsKiA==
X-Received: by 2002:a05:6402:90d:b0:640:9b43:dcb1 with SMTP id
 4fb4d7f45d1cf-6409b43dcdfmr5444177a12.35.1762160133066; 
 Mon, 03 Nov 2025 00:55:33 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-077-183-079-203.77.183.pool.telefonica.de. [77.183.79.203])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b438b05sm8977171a12.27.2025.11.03.00.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 00:55:32 -0800 (PST)
Date: Mon, 03 Nov 2025 08:55:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/2] KVM Support for imx8mp-evk Machine
In-Reply-To: <20251101120130.236721-1-shentey@gmail.com>
References: <20251101120130.236721-1-shentey@gmail.com>
Message-ID: <4D17B8A6-28E9-4E65-B0DD-15BE2AD4AB04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 1=2E November 2025 12:01:28 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series adds KVM support to the imx8mp-evk machine, allowing it to ru=
n
>
>guests with KVM acceleration=2E Inspiration was taken from the virt machi=
ne=2E This
>
>required a device tree quirk for the guest clock to be kept in sync with =
the
>
>host=2E Without this quirk the guest's clock would advance with factor <h=
ost
>
>system counter> / 8Mhz=2E
>
>
>
>Testing done:
>
>* Run `make check`
>
>* Run Buildroot image with TCG
>
>* Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
>
>  `qemu-system-aarch64 -M virt,secure=3Don,virtualization=3Don,gic-versio=
n=3D4 \
>
>  -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8mp-e=
vk \
>
>  -accel tcg -smp 4"=2E Observe that the `date` command reflects the host=
's date=2E
>
>
>
>v3:
>
>* Fix crash in qtest (Peter) by using cortex-a53 CPU when ms->cpu_type =
=3D=3D NULL
>
>* Apply Peter's style fixes in board documentation
>
>* Apply Phil's R-b -- thanks!
>
>* Rebase onto master
>

Is there still a chance to get this series into 10=2E2? Soft feature freez=
e is tomorrow=2E

Best regards,
Bernhard

>
>
>v2:
>
>* Rebase onto master
>
>* Mention various tradeoffs in the board documentation (Peter)
>
>* Accommodate for single-binary (Peter, Pierrick) by having CPU defaults
=
>
>* Add quirk to fix guest clock
>
>
>
>Bernhard Beschow (2):
>
>  hw/arm/imx8mp-evk: Add KVM support
>
>  hw/arm/imx8mp-evk: Fix guest time in KVM mode
>
>
>
> docs/system/arm/imx8mp-evk=2Erst | 19 +++++++++++++++++++
>
> hw/arm/fsl-imx8mp=2Ec            | 34 +++++++++++++++++++++++++++++-----=

>
> hw/arm/imx8mp-evk=2Ec            | 20 ++++++++++++++++++++
>
> hw/arm/Kconfig                 |  3 ++-
>
> 4 files changed, 70 insertions(+), 6 deletions(-)
>
>
>
>-- >
>2=2E51=2E2
>
>
>


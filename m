Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0mc-0003rq-Cn; Mon, 19 May 2025 09:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH0mZ-0003rT-OK
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:43:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH0mX-0008Eu-LT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:43:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so48162215e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747662232; x=1748267032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUsMvD80xK+nS9HXFI6AMDnlF2I0EExExItaMAeW2J0=;
 b=nKxvhZCyXg0TduGSWMLVUQIPlJ8nLzARTH/YDcZv+lia50f9Xp5qYiIVZjNbWALwb6
 +YaxrZ7d3+cHtwswJFpEq4Bi0Z/lzHn6h2PK+pSStpXSSL+MVPD51/KH+BTSC6r3rUgw
 B7IC+ULuhv8GQ8hFzJjMd1f5pn7XuTaxpmPIGCRO88RchPu5bVRqamlTWPKazCBtuoYJ
 W81KY/bA6dgn6NQqZXTO6Ao2+/1G/T5mIkOZdj08Yg7G/7w7OTp54Nx3dZ3mhfYyVna9
 lUbga91dMWd61Xnw+T3998PslaqZlWGYBffnDc0qXq1s7dzwRczIM0r424YXqnFTJZl2
 5dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747662232; x=1748267032;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FUsMvD80xK+nS9HXFI6AMDnlF2I0EExExItaMAeW2J0=;
 b=BANjT30UcJOH9XP3JpV2Na+2D1Sg+Z6uf6ja69/nI8wn0x7hyOwPAGwltXcO3xSS8X
 zoBKP+6lQ2HrRTp44XLbQo6Jhama0YETo6l97fLil8K47we1hTT1ZzPAYMybhd661uVd
 6EEEMvTAF+R63w9FLrVI0heGhgTS/J8OIgYhL8TTus2CRP8kUv8JxjSfyiUBcHRH0OZA
 zJsGEic1IjWbSO0M3CgVNVJw6Z6CzXG4DwvPoNs/IKcKMGZAGRXQyNq8Kh8bAMzwPm0Q
 6+GPDt7u17VNRzpBSqjgHFZnl7T4JrEE7EeFDBREkcS6MNUwtdCjJdn9YDBgELG1krZy
 pbDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXMzB9v5vBr3PR2SljwjY86Y2HTz9+YDpIHwRL9U2Lfr2Wmm0SUQFTv1pC51X5HIYoRRtRBnIwAYkK@nongnu.org
X-Gm-Message-State: AOJu0YyUq+unby6jQQ0g12uuWxMqmF6TTKfnBkirBTjnHztasIOCjftF
 4PQtpTTI2qiPuCkNsbwnRTJKV6j80FgiOZFyXdBMUCGLbF4Vgm2MFAsK+y1PiagEugg=
X-Gm-Gg: ASbGncvqWuzCSqdainqvfKPofnohD9twoHU0VXPlQjL+7mIuB+FGwGsbt3oi1l1jFGz
 hgGTtNc4FBea4TmDdb6OxCRL2nnIIjvPZODQyWFp7eTePUfzTiUEz114sLPOBSUZdTf8j4U4/hB
 2s633rTjNEoY9FZXJF0u5VMl5CPmEnfQXz08CxDJPDIDE9yai1XzX9pTG7GU3mW+Df77TNMjy/+
 vMYJuRs8ONACxoX17H3WPfwwSjKNJdZDOm8OqnOCf3K5br3gElwtkFEnWwj2QOqLed2gZbrQLpm
 IOYc1DJnCG1gkj7B9dhWmqsGF3VFT0LnLNl/IXA3Q4YwGORKUCqPhRD93aoHHVc=
X-Google-Smtp-Source: AGHT+IG9a5xIbrF/8C3XPiSGaVUrIEXxWv/9n7owfrLWTF7xS3ymA3qKRcET3TUf0m5Hxzb/hSRtBQ==
X-Received: by 2002:a05:600c:3c9b:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-442fd5a1e4cmr122511665e9.0.1747662231907; 
 Mon, 19 May 2025 06:43:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd594707sm143333805e9.33.2025.05.19.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 06:43:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A51D75F87C;
 Mon, 19 May 2025 14:43:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 thuth@redhat.com,  berrange@redhat.com,  eric.auger@redhat.com,
 peter.maydell@linaro.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
In-Reply-To: <85f13ff0-80c5-4a62-8b33-ff35911866a5@linaro.org> (Gustavo
 Romero's message of "Sun, 18 May 2025 10:26:21 +0100")
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
 <002caade-699e-4128-ac08-7797b83b3cc8@linaro.org>
 <85f13ff0-80c5-4a62-8b33-ff35911866a5@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 14:43:49 +0100
Message-ID: <878qmssokq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Phil,
>
> On 5/16/25 15:47, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/5/25 16:45, Gustavo Romero wrote:
>>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>>> hot-unplug on arm64.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 ++
>>> =C2=A0 tests/functional/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++=
++++++
>>> =C2=A0 3 files changed, 80 insertions(+)
>>> =C2=A0 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 23174b4ca7..9ebb768214 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2065,6 +2065,11 @@ S: Supported
>>> =C2=A0 F: include/hw/pci/pcie_doe.h
>>> =C2=A0 F: hw/pci/pcie_doe.c
>>> +ARM PCI Hotplug
>>> +M: Gustavo Romero <gustavo.romero@linaro.org>
>> As mentioned in v2, since this might interest ARM contributors:
>>  =C2=A0=C2=A0 L: qemu-arm@nongnu.org
>
> I thought you're saying "include qemu-arm@nongnu.org" when sending the
> patch, not "add the email into a L: section in the MAINTAINERS".
>
> The test is now queued in Alex's branch. What's best: send a patch
> now; or wait for it to land in the master branch and then send the
> patch?

I've fixed it up.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


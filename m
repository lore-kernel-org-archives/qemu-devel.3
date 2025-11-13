Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09C4CD8C94
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZsD-00082G-KF; Thu, 13 Nov 2025 11:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJZru-0007tX-Br
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:08:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJZrq-00088k-F7
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:08:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso580395f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763050093; x=1763654893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mO+M97hSoYZyVYMCcNQI5e3oXBRyjPrVdrszpUUt7rA=;
 b=rSBgjfu4rveWwQ6fXTJx4NKTS3bDdcZrQjLX86Y+OBP07y+5ZHUnlhP2HefyYEtQLZ
 LPZw/ZeQaKoFoQt1C9iahVs8jXp1RmYF3eB1RR+Rz69KH9GH61ehnrPrXp6DC/XSgFyl
 aCmpN7/K/TatnGCWHFgap6OINOGoAVKNkRluu/Jamh0hAwKLjhxWwyRx6orqlBS+o52O
 dbf4L241BgDas3ONZWMde6YzDOeiAZ/KYhhLHOB6KMg4r1B4dl0kCOqWL33TFWCLljpP
 ecHsQtf172+Vsi9Iu+EDXpgyxv+a0hLMnT/ljyqHRNiWHDIpC/cl1/0F4VCybYYWUDxL
 9wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763050093; x=1763654893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mO+M97hSoYZyVYMCcNQI5e3oXBRyjPrVdrszpUUt7rA=;
 b=IDC/Ihlao5GmLC9MPAUzPZ7WkuUYhmZIGmgOi2h/R5Cxdll+N4WM7treAzNB3xEC1c
 Af2SLm2o9dwfq5CHTRgWMzehVqKvijdZVJaY9vNTPMOpHIHuHaulZQIfFd1z4vsTf7Bj
 gImf7Zj47GUwti3p1Red6A0S9HqdHH3tUUe7WDdQiGxE4/Y5Zw0iBmRv5CGGqjWQmp21
 KHRAiLcN1aOyN9eJ1s8Lqhhdh7uAxo+6hIvl+YDWifMngyVKeY7aS5ymHxweMvuu9iVF
 WMcsLDfYQ6/+iAH+IIboWx2Pe5Edcw8HHzBLKM2AK4BugKQdVr82QBnBbLrZGUtRHlgK
 ehMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvqsirl2QuEVxhIC7gq6xvZMRTbP/U44t7j3XDgXwpFfvLlcz3wiFMtsdKYrz3PpyYgK/VM0imNUqN@nongnu.org
X-Gm-Message-State: AOJu0Yx2K6TANP3aB7cheIbGWFu/qJAiI7c1Qm5riFwTKSfbSU0qEAlD
 nJC3KmWWNZ74SAXEeVEIntzSr5DfW+B75zS82H6bT0fMtj41z89FcuA+mufafFnSldg=
X-Gm-Gg: ASbGncuTtWtxWaftnPAtnu2sdX5q1pUtOqkbyGZRYqG5mKpYrHwRZ6JiGN4EbsLFaYT
 w/pSIrBC1nELoi5z17pmpem6/TagsItfkOnOB7jmXE73eHSWtMY3b2i5bNq97/2HlgSnpaIHKEx
 C3tXU7R6s1YQif5a0pogoe9+L3n5rCRNc96VAU2eSvloyPauJQg2RFom1t/dt9eIalH6Tqd3DM2
 1hg6dvCn8zgkhoUB+FhtClbhyDK2pORBb4bNXU19QNRbnZV0FC5MMGM/YrQUKScTBCeYOTtlpFu
 zB6degO+sLGRzv8f3m31URtNfhHkDA9Hp0WBhWJMsmqm8yLVGvbbGrasxB+MYYDuweqrtot31Sf
 YSmKJwAkFIOz/8l02ClfTZnveHbrA8LjuZjFEkLwO5gtPhxQwCc3h8GPiZRBtsv6rj7XYrliGmI
 7D
X-Google-Smtp-Source: AGHT+IEUybZy1W8pIa/tKaSGMaOkewR6jcFywRQ4lzzAi6+Ap9tTy1FzjY6FHfWV7HEX4IDihSrSbg==
X-Received: by 2002:a05:6000:420b:b0:426:eef2:fa86 with SMTP id
 ffacd0b85a97d-42b4bb8b9fcmr7007239f8f.11.1763050092587; 
 Thu, 13 Nov 2025 08:08:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm4502919f8f.9.2025.11.13.08.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:08:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DE8F5F7DF;
 Thu, 13 Nov 2025 16:08:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] tests/functional/x86_64/test_virtio_gpu: Fix various
 issues reported by pylint
In-Reply-To: <20251113114015.490303-1-thuth@redhat.com> (Thomas Huth's message
 of "Thu, 13 Nov 2025 12:40:15 +0100")
References: <20251113114015.490303-1-thuth@redhat.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Thu, 13 Nov 2025 16:08:11 +0000
Message-ID: <871pm1rk44.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Use the recommended order for import statements, specify the kind of
> exceptions that we try to catch, use f-strings where it makes sense,
> rewrite the vug_log_file part with a proper "with" statement and
> fix some FIXMEs by checking for the availability of the devices, etc.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


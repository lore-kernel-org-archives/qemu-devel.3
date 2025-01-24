Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7C9C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMVq-0001GF-T2; Fri, 24 Jan 2025 11:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMVm-0001FE-6i
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:26:29 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMVe-0005AJ-LV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:26:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso15708535e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735968; x=1738340768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=boLBZdMmo/mRffIYZqYGSU0+gX1aBa77MrGhqTQD5RU=;
 b=NNPjCYwRPPDZjZjIYHSyeFPsNuC912oVFGOSx7kQku7gbmo5grrk28a0Uz9NrMAVrt
 9L8nXipOS7bQK7Gxcz6wdrDXYVUctOsn46xGmCHhWVd7MMDDd1yZqH4gFWSj1erHm4qw
 YjNGPqJ9uwhxGszpVWJxRgww2VsO9l2+xH63zUw7HVXde/1YAbxA8x/mMUU8NR2topip
 NpdTgPDYO/+I26Q+mErGD6y3x9pHNpowmvF3v5o6T+h7pl9B8rfLPYv60qq5h3IcwySl
 nRghcoEY3C+3mTTjq+tdZYotHs9/qmftDdHk5An1hpRHfWJAM4jlAh68ig7qcwyq6HJp
 whsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735968; x=1738340768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=boLBZdMmo/mRffIYZqYGSU0+gX1aBa77MrGhqTQD5RU=;
 b=K1UIUd6gVuvJo1np/ioIaYZ9EMBq3IQK059NSoLzcdGe82ykt7JwpVMwKFmyEajNTl
 a7NZ3qRAxkoNm0VP3El9MSIUWCTueu/DFHWuBfqXxi5W9fNTXFk+8c5/pLUC5HihKkk8
 iEiwkhJjnFGPLxUTq8XVOLbx8tr6o+KvP+PPa4FO3i11EfBPbrNMOtUirhFiRgaEfYV2
 naWIgQyRgubT+KG8vXzcSngaNLcfbAD33CckSltflNupLv/tSZl3HQzokyaXt4n5+q+6
 Dtq3HViFmfH+Z/oFsV1BkDQcDgIRm+5pX8PdWNwDXGlVRiBxejtW6PKwudL/+X5fb6iA
 KWaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6w3SyrQ36v46iMlBYlJriRnaA6M4gnxKB5GaFOusMQEa/OCNHTtNs9Zud0xxwTl203YoSPRbTBe3R@nongnu.org
X-Gm-Message-State: AOJu0Yz5u3EASg/tVBfopiKhDqjKTe4opbniw/CXTkWXazTntJoG1Mvt
 Fb/rVDMDuiLqbamaCWiIeXTSTw7CY1d2Ngykm4XzfbE97QYhqMchvqZQias1gfg=
X-Gm-Gg: ASbGncu4Ekm4UL9LnRpZCQP71bTb9jXzzaVUqCbJ0GCw2A9aqk9kXuTz2EosA+TC1v0
 rFstiocW8J5beuWKeqQfZ2Yovkj3yGWjAALANwIAo3JUdcHkW6qn60JzQYXUfLg+Cx1uF5pL0LS
 Wecfd4bX/P4FuDtopQZoc9dQtFujSxm8NQKo+cBxjn5Tsh8U1E5vl3MMU5TCvAsxFNhkCf3LqIr
 ZYdmQd5z5vcIjg1LoAYSEDV3g5PR3/ZXhsn3/OwrPwn5ApxQavqIDaCdAJYM/X+6vNn/jgmPTFs
 nnDkl/5NCN+VMIzgH5z1g/I0aF6O9omMJ3YjlEuPKAEla1j6
X-Google-Smtp-Source: AGHT+IEpzLP7jJrBsFygMqXwTbSv9sr+n0ss0vb5s9ybvm5THMEUgs6xrlOjtNWM64gNGQH+6DLVaw==
X-Received: by 2002:a05:600c:1389:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-43891460bbemr319559925e9.31.1737735967670; 
 Fri, 24 Jan 2025 08:26:07 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0d1sm32094185e9.26.2025.01.24.08.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:26:07 -0800 (PST)
Message-ID: <7cf3d2e9-bb1f-4b78-886d-27a38bddae57@linaro.org>
Date: Fri, 24 Jan 2025 17:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/functional: Add a decorator for skipping long
 running tests
To: Thomas Huth <thuth@redhat.com>, Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
 <20250124141529.1626877-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124141529.1626877-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/25 15:15, Thomas Huth wrote:
> Some tests have a very long runtime and might run into timeout
> issues e.g. when QEMU has been compiled with --enable-debug.
> Add a decorator for marking them more easily and document the
> corresponding environment variable that is used to enable the
> tests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/devel/testing/functional.rst        |  8 ++++++++
>   tests/functional/qemu_test/__init__.py   |  2 +-
>   tests/functional/qemu_test/decorators.py | 14 ++++++++++++++
>   tests/functional/test_arm_quanta_gsj.py  |  5 +++--
>   4 files changed, 26 insertions(+), 3 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



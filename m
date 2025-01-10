Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148D7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHVI-0002Yu-S0; Fri, 10 Jan 2025 11:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHVE-0002TO-Qy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:04:52 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHVD-0004bb-Ac
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:04:52 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1554939f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736525089; x=1737129889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXI/XYLW2H4aB40RcCSFKK3Ej+zc4PI7vc2Qy+wjzYs=;
 b=SvFQjj0cVPnmzp5UKKZKc93IB21912Rnp+FVpBjn/QQMz4WFqhG0GXfVYtOSl5eqrL
 mnSaX5p2VANCoRFwtiico9Y9F6BUMYRoFDGFh9LaDD7rvWNaf4J6IvpxtNlJLZxDhfsi
 ATGD//Y1Ib/dFocuRF6i29K2nF1JgXQGh3tkZyLRK314Upk22mDXml/SFd7CPT638Sn3
 pAPZDmDem4tbno/BHRr+nF8cIlj5I1Qt8zKkIgwbHDioPvtGDtfPbZRkk2w3YVIo1AkJ
 TbqrjFojd6ceDesEZKmTGne/CepD1mOPMN/fMnrK0KhTmrnx+xSZB2VRALicBq/k7zjD
 Ks1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525089; x=1737129889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXI/XYLW2H4aB40RcCSFKK3Ej+zc4PI7vc2Qy+wjzYs=;
 b=pAfWp+3fEBVF//nfB4dSY7wyyfd23aYJEapmh2JIpHvttUTI+23k3cODy8wtlRX2hN
 H0U4wA9TopYuug3l8kku1tj6IVUbKab7EVlwTwbg4N8jvErwfn71JMIQlRpYJhXchElM
 4TELnos7Ax4MvBouWsWtZRLt0TAB+RiOk7DCzL79WvpRRT81GF8/aWGbbceNNgCT6RfR
 KbXJTnx/vt6Nf5y0WxpDCg1QcT0atVCwWb80o7eb6+npLztdFoAqeXhluNR2iyS0K/Ut
 Ip1FpZXQC7Wol8lTc6JmHMxxMWU8282fyyOXVxN1sAgVvZxqMKC80f1MdyI2jaFHe1E3
 wexg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX479uob8tw7x6Ms3PMNVbA9ErjQ2o0Eb9y48A5mx1xEfiE41j9VtU439EbJqDCw/gyxG3IJCOfue2W@nongnu.org
X-Gm-Message-State: AOJu0YwaYLIhh7dpCQMqgzRZeyXeZvB/qtkT/mL4CRIiMfV7Ir2jxO5M
 sRF2L0A8wgCghxwPEnvmbK0oMn4XD01Z9cNhokqlYe03cnwtKLIzlia9bkBynhs=
X-Gm-Gg: ASbGncvurWMaZDltCJHk9w7cE3aLEf0ABgbo4XdU/YAAEciFvqjiHso37NDRj+DiHHb
 o8W8oFYCh1CrJ5/vgn9WdswAqf1mrkGvv2WT97XKNrlZ6vNKvaGNoJb+F5AQyS0mwYYYPGFiCvS
 AjAXEWKXAn3jZLXKk8V4n2I/taPAFd2zRylbZIPu4m0hw0Q170HfER/LFVWulGzQ5pFo+cyO6vq
 S2qaKA9rDB0gk9mD4JR31O+uKl2Y9Vjy091TU9rWTtnVPB/XDDO4blTBFFJXxdseGDbO5/U8r0X
 Ssyu4MD6DCECdGKqUiYQakQr
X-Google-Smtp-Source: AGHT+IH8RajXnigs8mjUL6yQuwUxyMbnYsailZ6AqC2EFe6Y5BRN3Q903AbsxGJwDbu6+M5dEuiHOg==
X-Received: by 2002:a05:6000:1564:b0:38a:8c9f:dd61 with SMTP id
 ffacd0b85a97d-38a8c9fdeeamr7431552f8f.46.1736525089366; 
 Fri, 10 Jan 2025 08:04:49 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm4966176f8f.39.2025.01.10.08.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:04:48 -0800 (PST)
Message-ID: <3523c701-d234-4f41-834a-ae762ac7cd30@linaro.org>
Date: Fri, 10 Jan 2025 17:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ppc/ppc405: Remove tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-2-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110141800.1587589-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 10/1/25 15:17, Cédric Le Goater wrote:
> Since we are about to remove all support for PPC 405, start by
> removing the tests referring to the ref405ep machine.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/qtest/m48t59-test.c        |  5 -----
>   tests/functional/meson.build     |  1 -
>   tests/functional/test_ppc_405.py | 37 --------------------------------
>   tests/qtest/meson.build          |  1 -
>   4 files changed, 44 deletions(-)
>   delete mode 100755 tests/functional/test_ppc_405.py

Missing removal of MAINTAINERS' entry for the test.



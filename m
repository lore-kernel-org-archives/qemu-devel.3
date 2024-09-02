Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063A1CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl2gm-0001hG-Qk; Mon, 02 Sep 2024 04:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl2gl-0001gZ-KQ
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:45:31 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl2gj-0004pO-S6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:45:31 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-533de5a88f8so4070734e87.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725266728; x=1725871528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqpT8gL6X/950XjPLLr+cL1OFo6rUHeouHx58Wooo0E=;
 b=T81CjT1J2LFX8tOssT1JHBfTsxceFlwfk3sPIwJ7sCGX5U/aNy80mVdkP9c5VHiSVf
 4ZuUDAqv3QA9Bfw74JEN6TOiGzv2LlUEDHI9P9kGAHyPybZRB9pDPviheGdQWdX6eaM0
 6JwZAjldtCb73BurR54gv3+/C0GKePeTl2ZPBIp1FP4TJj0nCQ3ljepahAs+dLoDekeb
 z+uDVl77ZNSQQ+UBzasJ3KT6X/LZ4IzXONUEj+TZdJEz6UUWpL/FfnXyYYddl7NFpjDI
 5bQXSSFAI8iXKTCgmbGH5t04QrsNvnU9d4huwUNiqd2Q+2I/g8R6amsOL3e7Gw4jOruU
 7Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725266728; x=1725871528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqpT8gL6X/950XjPLLr+cL1OFo6rUHeouHx58Wooo0E=;
 b=NDEGCM6U9JE11/sDkNFuI2xyiSDX8CZv+AcRCnltXR3IydztklWEpSK8OJXNBpK8Ob
 HLyH6ceVYOXcMq8L6uI3UAA5Xva1XtFiaDXpBzzaX2dhfsUkpXLbZ4JiA0IFTeJvorlg
 +UWm+VRhZjvgoy5+oWKhb/hIxUe88+fxS8aj2zgyVFoFYpb/OxVDMgnssRmiUz9W92YB
 tnghlAC2PWYa4YyJ7NmZ3UCVwOir2us/7YZKHuYqCrtBpg5BmGk9JY83ExVh6b3xlgTR
 +OaXQVbphC2cDUq7c+9XLOy3WuLACZ1JAxNEFGuPhp6HLWPP4If0hgNPnvzXfbO15oG6
 fAwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+D2OJCE8XOUdBZTaC/8+82wGwQFVTYoa1eAxiYeaKS3C4qyDaSoOxku15vmLJmA+OoYsz2dU0+1ep@nongnu.org
X-Gm-Message-State: AOJu0YyGpmxgtADLkx5hn4NopjBgTRDvNAS5jUsEaTICOcl8wD026EqH
 JzjlsNpbMP6AOIBpaLUPP4nClgyVEYAF8VWfokLt0lkoTjMFYHBYB5eyT7YIa30=
X-Google-Smtp-Source: AGHT+IHc3DIG+4xkEfqw15E0O9i8oA0uTTqEzoSONrjPPB3CU1mnb9XEDCR6uSyVApGlduQ4ZthrUA==
X-Received: by 2002:a05:6512:12cb:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-53546afaadamr6035273e87.3.1725266727687; 
 Mon, 02 Sep 2024 01:45:27 -0700 (PDT)
Received: from [192.168.45.175] (255.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.255]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm130345235e9.0.2024.09.02.01.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 01:45:27 -0700 (PDT)
Message-ID: <6aadb751-ee15-49ae-9dfc-f86853f7b228@linaro.org>
Date: Mon, 2 Sep 2024 10:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/44] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-24-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830133841.142644-24-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 30/8/24 15:38, Thomas Huth wrote:
> The avocado test defined test functions for both, riscv32 and riscv64.
> Since we can run the whole file with multiple targets in the new
> framework, we can now consolidate the functions so we have to only
> define one function per machine now.
> 
> However, we have to mark the "spike" test as flaky now since it sometimes
> fails when running the tests in parallel (the failure happens also with the
> Avocado test when the host is under load, so the problem is not related
> to this conversion to the functional framework).
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                            |  1 +
>   tests/avocado/riscv_opensbi.py         | 63 --------------------------
>   tests/functional/meson.build           |  8 ++++
>   tests/functional/test_riscv_opensbi.py | 40 ++++++++++++++++
>   4 files changed, 49 insertions(+), 63 deletions(-)
>   delete mode 100644 tests/avocado/riscv_opensbi.py
>   create mode 100755 tests/functional/test_riscv_opensbi.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



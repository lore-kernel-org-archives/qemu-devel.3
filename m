Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DCC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 21:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txBRI-000523-MF; Tue, 25 Mar 2025 17:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txBRC-00051l-Ld
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 17:03:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txBR9-0003gc-JZ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 17:03:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso56414135e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742936629; x=1743541429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sq4B4EpxBjwT8fAFSoe5xZO4IKFj4tNkwWbItZBUwsA=;
 b=HISvkr3B8F9CbFAC3ueJ8n8euBicjtqcia/ETC1wRGP8jV025v/Co1MTPdVYJiOPv6
 uWTVlVsM9V2lcAXfrFdy6MWYUNdmxSG+aZ3GH6oysTsf4arQ3nDJgnnhPAX9ruIbwhfD
 ccUuENzBhy9hFN7pDEHzi90Q8B31pCZ00729hrsJEo7cR1DvU6Y5oQYQRmr2QEfL/raS
 Gw9AJAiSDKh5NSYPNHNN2yonct35HCtgtpEXkmmanAc/yelJyVNkGsNMuchsqBBXXkuR
 dwi/XDkEP7O43EcbHIZagYyqJzGTumvHaoohbG8yimm8pd/gc+L62tBH76pI9BoHtUMl
 MudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742936629; x=1743541429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sq4B4EpxBjwT8fAFSoe5xZO4IKFj4tNkwWbItZBUwsA=;
 b=mZUU6iQ+sgOwZL0XJCgOogxHA4iYINeLSziisw2cSU2i7ktIZKvXeamArCZmpq2EYV
 YRZUn/cIMWeQeCVuHutAhtRoFOcd6XAeCIkrZb5ufD1dtIFUEtO2spNvgaT8KFNm2pgS
 rGvozWQXHDEpd4WcSI1+BtzMBvf0xAVWtl5QOGBsQEdptLNv1l2dfUYLgJRB330jhu70
 bxOApzpaFPkmb+3Yv1XjS13qqpBy8ZJaYTyVye0SaBp4BCPJurahkxzRWFiMuvR5Kei5
 b1LZi3Iq6WGWN9YnfHOAlvlmpSSp+hR2WbdPg8A7blohy/DDYXzgm5i1Ti2D81khGXMr
 NjmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIGfrf5uT6fRTaglVhFWOhbQUpc8OJbLIDYNXvdgi7xJXjRqLmOY5rHvnka0U53p5IvX2vzPzZxjW1@nongnu.org
X-Gm-Message-State: AOJu0YzMKjRZcv4W9ApTcr3rxFyfWyClDVUZatNUXiOoIUI5YEXEC0vd
 SPOE0e6b629yHh0CJMtQRzSrbjXq4N2biHBX5voMEfgp1xmPTmUQDyRRck66wZc=
X-Gm-Gg: ASbGnctWDogVUiKKxqdpT/RTiHfa0dmHuQ/1cP1PULQ/jKY8ZJQpPVN1at/bH5ym8AP
 NPsbu6xApyeN6ghHyrtT/EJUXcuNPOwTzQbd6NvPzlX0NB86ogf4g9w+9Vnq6ENnZ2jYYrO4MoA
 eIXhp073NJzqRSCkRHV/bUVG6T5qvP7qF0KPLBtzdrRx//Xgb5OO1KIqklb3yqhqj6YV56mY8JM
 RJ/6xRVuOsMw8CX/spJCUU05cSpZl6i2OI99MqIuxKXRueix6YrU//00ERghJQhHFyCs9oBn8iC
 l5YmKk51FHn3xC0sUTLysMel6BKZqZm3pTAqkP7JhG5Y1JD1bb9aAUDDxW3k/lKs2DPaESbu369
 r0l64x9KRE9dQ
X-Google-Smtp-Source: AGHT+IE2TKqlmE49WRbz/HSITD/wKW2He5sSyGEUSUPpuzgGnDUqAdQ3tV7g8Yf/9f7+tyV2TFHlGA==
X-Received: by 2002:a05:600c:1ca0:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-43d58c9a7b1mr152067755e9.11.1742936628798; 
 Tue, 25 Mar 2025 14:03:48 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef098sm14438317f8f.84.2025.03.25.14.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 14:03:48 -0700 (PDT)
Message-ID: <1b6532cc-f933-4cc5-8c96-c10d2ec3ea98@linaro.org>
Date: Tue, 25 Mar 2025 22:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] Remove the remainders of the Avocado tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325200026.344006-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/3/25 21:00, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that all Avocado tests have been converted to or been replaced by
> other functional tests, we can delete the remainders of the Avocado
> tests from the QEMU source tree.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                             |   8 +-
>   docs/about/build-platforms.rst          |  10 +-
>   docs/devel/build-system.rst             |  11 +-
>   docs/devel/codebase.rst                 |   5 -
>   docs/devel/testing/avocado.rst          | 581 ------------------------
>   docs/devel/testing/functional.rst       |   3 -
>   docs/devel/testing/index.rst            |   1 -
>   docs/devel/testing/main.rst             |  15 -
>   tests/avocado/README.rst                |  10 -
>   configure                               |   2 +-
>   pythondeps.toml                         |   8 +-
>   tests/Makefile.include                  |  60 +--
>   tests/avocado/avocado_qemu/__init__.py  | 424 -----------------
>   tests/avocado/avocado_qemu/linuxtest.py | 253 -----------
>   14 files changed, 16 insertions(+), 1375 deletions(-)
>   delete mode 100644 docs/devel/testing/avocado.rst
>   delete mode 100644 tests/avocado/README.rst
>   delete mode 100644 tests/avocado/avocado_qemu/__init__.py
>   delete mode 100644 tests/avocado/avocado_qemu/linuxtest.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks a lot Thomas for this huge effort of converting from Avocado
to the simpler functional framework... Sincerely appreciated!


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF78C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqcL-0002FI-3e; Mon, 04 Aug 2025 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqc4-0001wR-BE
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:32:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqc0-0008RV-He
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:32:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b78d729bb8so2586195f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296323; x=1754901123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6fOW1YOdW5GB/B2iPbQk4dguMQ+qSgTxpJk6DwemRY=;
 b=rKVZ78s6UGLVQIXy2kvtmWJn8aIEUBQ8jcp1r4nT99ta9+XloDXj6i55bkm1/1G+En
 toz0PhaiU/j00PsW/g4LbvafmYnPbvH3QH5xafvJAWglG1im/2CPWYpbfyuKFxLJdJCy
 Uw46PrH+nEmGHxx28VH8uj+knHlN4dSbJTBKpy0E3WhhWdWJCH1yQqLqqmDPAFcQqFqM
 z5k9CDK/PhSUFVxlWpQzYTZynyETaw1GZpT3x1Hi3+Eeyania5HGwpmcGqRe0l/lunlO
 QSjWgGOHFxkxA4mesjCioRdsDGQIZ65iYBLOfmiaf4yC2f1ka4MyJZhi49LVLrl2/jgy
 NJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296323; x=1754901123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6fOW1YOdW5GB/B2iPbQk4dguMQ+qSgTxpJk6DwemRY=;
 b=QmFmElFapfXOmc5ImGn9TepyHN5C2J+kwQoYot+6UOzzuVyScrcyfyuiRxM4Mjo1Yr
 uhYzixej+0VmJ/StghEv5mZtLjJ6An+Dpsmkl022BqhmXnz4Jk31l4xzl8sY0e0n0r59
 BmY4k7g9RIV+MZlvgVevu/8F7yyZiCbu9S7Cynez3n0Oes8V3t8yfnV2H400Sy3REJWM
 6alDtNUABiPzTMO2Xawny/vTK+RhviNH7BP3YKgceyExnoCunLR8RjA0YtocnMlAtUav
 B1GDqMexCM/jW48+uDpLBdfaaXjX5QGUHXlj61S1x5kyICQLpne9Q60I19c4s69gOUu9
 MqpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4yWHrTUIld/SLkpsj5Z8/ykL4Kbf36ocKHM/i7LeESDqrZ7AjyarnMkv0lJ63GkkK3WCCDkYhKB4q@nongnu.org
X-Gm-Message-State: AOJu0YwABkq/VP0yup1hiME0fuZL9r43jHzKFVz3CjDUmGw6Hq6Tm50B
 ManLvjFSnRxgW32wy3FacItML8EDQwubJllkq+y5S8zaRPrvaK752NK0xOv4JOnB2mk=
X-Gm-Gg: ASbGnctKexcaIur7Mgn+QG0QTv0GB+8Ulp1foMU/zYtYI0Bfab61FyZxIzCgN2gPJCB
 vaiPqud1ZI0qk0/jZS5BC096ZYpwKzb+CSCPYY+nFtEmrj6Sc9UHLv9YUHxnXBUbIVsGiNtnzm4
 gR6UWI12D2SHgdkt2/KOWHUVCveM8psRnhu1+hWZNVAKLMN51LKXKOnSx+BGAkqIeL7R6QvEh1j
 1HeoNq2ACtpIh5VTDaB+U2dCfj87wkmEB8O7EvT7buvxLXMiWMJsaUB+VMgNu44F7xbgVydMgzU
 M6xb75M8EwhnVvdNKC2XTiPDgiGqNBRKhHF4+U+ibFvWPtEc7YTuX8eZMSTQUcRs843sr7hNxp9
 7ktzDfsngNlWUkIAyGmFn09qws3OR3vOK3gmvJDLtJg6SjEbzNq/pUajVIWRTXdGONqwnjuo=
X-Google-Smtp-Source: AGHT+IEh8vdc5khcN47qASY9Drk5HpACXkQsIOEG1LJ9/NCLSwCwlDa/a2pzhH7TO6NREZkMmJTfvg==
X-Received: by 2002:a05:6000:2482:b0:3a5:783f:528a with SMTP id
 ffacd0b85a97d-3b8d94d0232mr5822733f8f.59.1754296322632; 
 Mon, 04 Aug 2025 01:32:02 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48105csm14739083f8f.64.2025.08.04.01.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:32:02 -0700 (PDT)
Message-ID: <5834c686-c8a9-46b2-a784-60f6192c856e@linaro.org>
Date: Mon, 4 Aug 2025 10:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] tests/functional: Move rx test into target-specific
 folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-19-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-19-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Move the architecture specific test into an architecture specific
> subdirectory.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                               | 2 +-
>   tests/functional/meson.build                              | 5 +----
>   tests/functional/rx/meson.build                           | 5 +++++
>   tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} | 0
>   4 files changed, 7 insertions(+), 5 deletions(-)
>   create mode 100644 tests/functional/rx/meson.build
>   rename tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



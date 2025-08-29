Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74590CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiB-0002Zl-LV; Sat, 30 Aug 2025 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6SP-0007S1-HK
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:16:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6SL-0002Il-Sv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:16:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso2244449b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756502175; x=1757106975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eAvDm46K6JOJ9DU6J17+dzG84o1PbcdA7P0Pammr8EU=;
 b=CX9RXVgioaI5ECqGfcGK5UPhEjpkob5adYjofahR6vmo0MxNInC2M/Jj4bKPG7bwBI
 guhjCauVONmLMkUlA8a3dvH0MIgXFO1qkmAVoCrksvMAFC7yRl1s6IhBZL/504m6R3zP
 ucK4syGilAQFjEDMj7heaTYw18K3O/N4GnbGkeZU+AKGQjDC81MV6fYB/0zDmNPvhuzV
 hwrcMgztfvMqPRSn2cgm9Xuahxj2A0aMBbtu3mCm+SE8itJZPJo9zCqqZ4vktnVEm2sQ
 wdlUXX2x5tJ5riZM0dYjPR+fDc9NEfEESunwc7MzU4BIr1KhSAqDj8YcHG6D0egLDaZG
 UM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756502175; x=1757106975;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAvDm46K6JOJ9DU6J17+dzG84o1PbcdA7P0Pammr8EU=;
 b=RkDLhdydpjg1cMhaj/dW/kg+nIciahMvljgnAiv7r1VU4ExlJDkg1S7339IpcTlK9N
 DkOeHXLXqqpIxN5rDesMa7aODP26ECal42zetOmqK7zLm6y6IBwwGePQmUA2Mnt99GvH
 xeKwcc8uqDfuvIUdfNNTsIQDHR6YaTdDy5skkTBuTogy0e3xpdf5gOwPMhbRV+wyNS2r
 jNfwMrMTKxJATLaASMU8SVVgAeHLMJy+WecybrKP667wwfpTMZ54528xnAEoogRtuxtb
 MlmIKjpMPy+84h2B6LHC5Mkz/u159nz7cauF0D1LshTaDo2GTuf9JmPk97BqbG7UHEq2
 Hjyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcVyYkFtuPXWTVNwmBLBv4fyctJ7heDn/5iASYk9DwaP3r7ONx7xAd/Fb3c/vOL4/sn2+0HKTD4DjQ@nongnu.org
X-Gm-Message-State: AOJu0YyH0YVcNFUZjfKV3CMnYIbEjAjQw6Dc6+kFdLkl+E3rM38ffSJ+
 nXUvf4QaTTEmW7s4hmbxrrmOppey+IAy6XayaaNyCNLUFUQoV4vZYEyOxrArcPj9wfU=
X-Gm-Gg: ASbGnctUkU8WqiU8zlXwCNJTa3BmvY6W6/xbHlRqZhgc6J26fmHZLqBFsvl+tQC4yoP
 wkVLsU/JSnRHZMcrjVnoDvnniE8pmkMCyPvR+c9zHfnErFMYoswLj+ZqDY3Ay/G0PyaHXnjya86
 usko55Id9viE4PhCDEfiypVv3cptvduMrWOYZB0SeVb97beo6FwFTeM7bh5Ii3UiDAVoDPZlqxw
 dPv3xt5WhiJXqBPTFJJ+oDyXC4JKjjaCxMqia3D7APYn5NS0Ysi7VMZeCEQpj++XnNXARb5QDLT
 LjDupIwOGYFPVHtPZ/aLFl3Kky7omf6vhE9ebY9ByUP0zqTyPSzY8adfeE7G95wGkqEa8tzITU1
 G7LWcLSmADh5MBfW8ow1EB0GaO6OFG4AKw1ihIjHMkWoGGKUmEF2gELoYxdMVzBTN9XedMHdQrJ
 0K3kXIdeo=
X-Google-Smtp-Source: AGHT+IENWvvrJ8qhjZPe9SRq/DLqHWwXhMf4aNzk6ZCHVBXzpDJTxxWB46Eq7zhKZTYWm2ISkfvEdQ==
X-Received: by 2002:a05:6a00:3d14:b0:76e:7ae9:e86b with SMTP id
 d2e1a72fcca58-7723e3f372bmr46500b3a.27.1756502174598; 
 Fri, 29 Aug 2025 14:16:14 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26a4e5sm3342246b3a.19.2025.08.29.14.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:16:14 -0700 (PDT)
Message-ID: <b44f165c-6189-4402-bfe9-4cef04287929@linaro.org>
Date: Sat, 30 Aug 2025 07:16:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tests/functional: enable force refresh of cached
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250829142616.2633254-1-berrange@redhat.com>
 <20250829142616.2633254-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829142616.2633254-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/30/25 00:26, Daniel P. Berrangé wrote:
> If the 'QEMU_TEST_REFRESH_CACHE' environment variable is set, then
> ignore any existing cached asset and download a fresh copy.
> 
> This can be used to selectively refresh assets if set before running
> a single test script.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   docs/devel/testing/functional.rst   | 3 +++
>   tests/functional/qemu_test/asset.py | 4 ++++
>   2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


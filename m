Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F885D1D47C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vds3b-0001ri-2P; Thu, 08 Jan 2026 10:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vds3P-0001jr-IN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:36:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vds3N-0001BI-3C
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:36:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so26630175e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767886559; x=1768491359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zSoCNwBpRlL92nFJXOyPw4jCaks9/29Zvzq+h2UIRrM=;
 b=hZdWCdd9GzvLlGUw8Y7D7Xe6N0btzRensshcNZQRdmE4dVb4x88/rLGFWSWsEt2cjQ
 e/AIJ1tZXwSGcClj1KbzQU1EyrISQN1k3KWcOgR2OnX8pcAFwcKhgEYvGTVPuiEQ20wS
 Gxi/66v/4QCIwsSq9DOeQJqZiNG4VNV7LFin6fXyf8kqmUMvCv4XlkFDl9GEVckKIzc8
 hM+mNTpfZTzLHgT/mYWC6ikNPPnhKzi7LaqVG7xgIyoycTWUff3L1L7FQNu6hSwvUKsi
 QNjfEZ2ondnUpOWjSn4JdR/dGL2gKTMLfNymrTnNCXwuJ7JXAdI0Vq+m51NBLsSMsLrl
 3CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767886559; x=1768491359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSoCNwBpRlL92nFJXOyPw4jCaks9/29Zvzq+h2UIRrM=;
 b=B8pwMMZV8nKAyeRA0loABl+wrWN7cir0w/IeQ7Ykae7sDwSTx49ojTUYuH2H5eR67N
 l34sauNKLG+c4P2Te5kiZe+8Q28jfRK4rw2nwS1KBsV9/fVzfHf4m4G+Pj3ellnLTbSJ
 cD602ZQ3kEP4Yj2qxJJVHqR7l+uQPQ143olpMefWZAfzszHvRvsgEgJRUV6NfixLscfJ
 HtGQgsT9g1SsYZwh7UWxqHpsoYB6KmC5Qd3oZdGbHSilalByg+mLfX0F5NSS2B0Blc1w
 3MNg6I/eVTuIWy09vsnjYODB7hXWyf5k9YtBRDxQny2GFf5HfhNN0UKn+D0dc4Mfdoli
 jzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGnVv4iMf+5LKrGlPryKzdous4zgbOsudp/n8RWEwszU7aCWQzpCUrfab8gNB0gu58aRmRxFDH/LmU@nongnu.org
X-Gm-Message-State: AOJu0Yw0G7gB9pZAvjczh0OhlOlQGQI0tRlEeoS3ygFddkkBBaS+fbUR
 arbVhfSClJY56TTshddWCQC9B7CeyzT54ybw1Zk7awAOC5NmDruBLDhK5a9HbiqPFXo=
X-Gm-Gg: AY/fxX7B/zTLoZIMTHq0POBM+c6Ezk8LKvUvbLPpAtVh47uqX/f/ul6LpS5gK4jPJrq
 CWXYSPeCZFTjsfm09tRIrInYIXk8toFTViG57AG7vdCpw+mk1BkygWIO15UzgTpxI6KHMGD38t6
 1dCYKzXgnbgRfBJZvit2IhaNfnqOqi0j4A1bmMh356fBKryAG3fH0UbbBNIedCkVWimYGoS4Tyl
 IWT/bmct+Be5MgDF1WC2FR8ahLTOycC59xRM5gIdOtg0Jadk6KeIjWU/Vz8ZiLNEUh5XTgj5opB
 I2/DlyOfSZUZfn12qYRhrNN8VSqWGlLVueV9Y7Bj/JTNGQns5PH9C75bq5vWBPtRfnT58G0AuNj
 l2z+U9LaMYEz0CJuyZfRVFNVi+CY79EX4fxLWrp7z4Lgs8qQ2RUiUyp4ZXqi5DQZI02Dq0vgFAg
 yEtRYWt4spy9qRCWf9jFUx5g1P+J80TLTRqtJs1hrGW9dlOG2p/srAFA==
X-Google-Smtp-Source: AGHT+IEjBKuzgIKF0EtLjzJYOi1kUF6JYm1RVNOxAJ80hha2Fzla8pKv0ahB2igKlvY0G24ZdmYfEA==
X-Received: by 2002:a05:600c:4fc3:b0:479:3a2a:94e7 with SMTP id
 5b1f17b1804b1-47d84b2cd24mr90226275e9.10.1767886558773; 
 Thu, 08 Jan 2026 07:35:58 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm154130115e9.8.2026.01.08.07.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:35:58 -0800 (PST)
Message-ID: <79bd03ad-3fc5-4d83-ab4f-55f8f840cc6c@linaro.org>
Date: Thu, 8 Jan 2026 16:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] cpu_reset clean-ups for arm, sh4, mips, m68k
 and tricore
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/1/26 15:34, Alex Bennée wrote:
> We tend to apply cpu_reset inconsistently throughout our various
> models which leads to unintended ordering dependencies. This got in
> the way in my last plugins series:
> 
>    https://patchew.org/QEMU/20251219190849.238323-1-alex.bennee@linaro.org/
> 
> where I needed to shuffle things around to ensure that gdb register
> creation was done after dependant peripherals had created their cpu
> interfaces.
> 
> Regardless of that we do have a proper reset interface now and most
> architectures have moved to it. This series attempts to clean-up the
> remaining cases with proper qemu_register_reset() calls so reset is
> called when we intend to.

Last time I was blocked at this comment:
https://lore.kernel.org/qemu-devel/20231128170008.57ddb03e@imammedo.users.ipa.redhat.com/

> Alex Bennée (12):
>    target/sh4: drop cpu_reset from realizefn
>    target/m68k: introduce env->reset_pc
>    hw/m68k: register a nextcube_cpu_reset handler
>    hw/m68k: register a mcf5208evb_cpu_reset handler
>    hw/m68k: register a an5206_cpu_reset handler
>    hw/m68k: just use reset_pc for virt platform
>    target/m68k: drop cpu_reset on realizefn
>    hw/mips: defer finalising gcr_base until reset time
>    hw/mips: drop cpu_reset in mips_cpu_realizefn
>    target/tricore: move cpu_reset from tricore_cpu_realizefn
>    target/arm: remove extraneous cpu_reset from realizefn
>    include/hw: expand cpu_reset function docs



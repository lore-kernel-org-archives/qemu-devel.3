Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158CCE69E93
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDXs-0001f7-Cm; Mon, 02 Dec 2024 16:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDXo-0001dB-Ua
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:01:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDXm-00032e-Lw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:01:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a14d6bf4so42954825e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733173280; x=1733778080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s/e5a3SWJapAI2nb5nWexyvSrN0D7OtWC6R4lsg9+bI=;
 b=b4Kj5n6PnNAJiIxludvab1eQ4+77RQYCkNeAXc7rtTIV0PBo6XCxaJBt5hh3E7IiZC
 pW22IU6hbNoHmUQ5tUuFvMZI07rBtsB4Zo4K+sCKumlg1PJ+P2yjGyC9NQv1w9I27BBw
 wsDZ8nBQ1qxh7p5Z55T/kGykijSCLUeiqUtd6aEj9BgVbliGM+sh7bfYNqY6tLTEmMEX
 tysM7O0I3mXOoV5npBd9sRol4GLBPn1TrhKiRDyTMGjqiIuxAGNYqqhuXbgUc8tv1wEZ
 /qXwwTn1+HXwFZblgI+vA6VqCRtLIEaRLSmYBOmZV+wR+vvcBA3AeayLIFV85pOxkQ+6
 esIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733173280; x=1733778080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/e5a3SWJapAI2nb5nWexyvSrN0D7OtWC6R4lsg9+bI=;
 b=pNp+yqfF6l9+OkeqOOE6c5a9gtYzrmn+hk0/yIsUY1OytT1OtmaOU8MvHEULvUT1K/
 uq+p2TCxx01f7ctj1wH3Unx0irUbfuy5sVMlaQgsi67KBG2LAtonCioCGhLS2+g6VOif
 IhZCVYJhHbVW+K4Wtf3oZ/HJ+QYHeFj4i+jew5rxTZ0uSdAScKcYG9DYD2nBl9zzOK2f
 8nlFzePIHfTdzJ7/aTt1wM8eodOP542twhUu1A1bBLi3EJYvBk75tyzrXcChb6O9hfA5
 e5l98yUdipBdHYXcHnsNLPpvYxgCJvsKsi6wYoegoeFE/4AQuo6solwT02lmcJgefIrC
 OQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlRJfsqCtPtuQY9Gjl4xNF9M1nobBir9O0JSHcEITNBHiYuLQ/hKrquLAa7thPMU0LwUSysM472oFg@nongnu.org
X-Gm-Message-State: AOJu0Ywil3wrng6j2/p02uEHcO0i6QJTaw6ZKqIfLOH2y4DD4lffuHAD
 S8wqM77KehZnwcr+Av5IkO5M1eNsu+B9Bn9bDvapk+UXJLMUidfpIBRupLuFErc=
X-Gm-Gg: ASbGnctajrNxajQyaT3fsyCS+oDZ3PJW5KogoJy0zIrXnSPDGViPKSM5iywSwo9ayJC
 T2OJlaZD0QHgsx8Au6EhFCh+JXADdfvAxQ0icqJNMXV90dDPOse89esaLHFVPuWad67oKPO6rLn
 sHKENmVg+OAkUZ2F2pQQgK/SfDbtTluOAs9tTEu5wxdSE8I6tx3guIZXZ0cqjUZj1eoT03g9vhS
 3V0PvVuYG2xVczKamWtcouDtUJ8c1FtpNgFwVQBpwcAxdM0dQkHQD/kCB/nKMiDeQ==
X-Google-Smtp-Source: AGHT+IELLlARmWm3gSX2lmczk2flS4uN7+9DxyH30VVuXD4JrcoBLsaji9XaRa5bSYbZTTIy6PfwUQ==
X-Received: by 2002:a05:6000:799:b0:385:f996:1bb9 with SMTP id
 ffacd0b85a97d-385f9961f13mr2548980f8f.23.1733173280162; 
 Mon, 02 Dec 2024 13:01:20 -0800 (PST)
Received: from [192.168.69.223] ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd368easm13485572f8f.25.2024.12.02.13.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 13:01:19 -0800 (PST)
Message-ID: <50f8076d-aa90-4b47-884c-ac3937ceec89@linaro.org>
Date: Mon, 2 Dec 2024 22:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2? 0/2] tests/functional: Fix tests failing when TCG
 is not available on macOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241202204020.55665-1-philmd@linaro.org>
 <9c4408cd-5fee-4242-ba6b-ebf2bb680d83@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9c4408cd-5fee-4242-ba6b-ebf2bb680d83@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/12/24 21:56, Thomas Huth wrote:
> On 02/12/2024 21.40, Philippe Mathieu-Daudé wrote:
>> Explicit the QTest accelerator to have these 2 tests
>> pass on macOS when only HVF is built in.
> 
> Could we maybe rather add something like this at the top of tests/ 
> functional/meson.build :
> 
> if 'CONFIG_TCG' not in config_all and 'CONFIG_KVM' not in config_all
>    subdir_done()
> endif

I'd rather not:
- these tests don't need anything of TCG/KVM/HVF
- we can run functional tests using QTest [*]

[*] I'm actually using that to test my qemu-system-any
     binary which has HW models but no vCPU nor accelerator
     right now (except QTest).


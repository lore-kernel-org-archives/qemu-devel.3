Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3B0CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjwV-0002ib-O9; Wed, 03 Sep 2025 05:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utjwL-0002hg-KK
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:38:07 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utjwJ-00076J-Jv
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:38:05 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so995892666b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756892281; x=1757497081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PVx28uNA0xbJOXxJcyu5rU5kNhMQ4PELIVd9+Dh5EcA=;
 b=x47TITs7x7pUcjd6D0ETKv+KMiKXk9IACd+HwoBTfJy2wVUj/Ygp90pmDdyw8hWKBY
 t5PNgCwW6lwC/rP/bi1qL8ctR6jxIazF8TPI8QQ5cSd0VMSEIs8FdQKMtOSWDOHDciEM
 tTOULvV6wtB9cf1ekcz6KKYhud2NNVei1HxVrKSSvUX+KSaTisbYuIbCE5keH1IuoyB7
 81S1Agpc+Yx4y/oEP1prn4vaLGN1CnnHiOmQs6NHl+GntGQzjodrpYXoZmctYwKR46//
 y0AA3LYY1K8b94UNL/poU5NjYwftAxc/bHZVXv8++ZInGKJGi76aNfzkKOAOpTgKQAp/
 4C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756892281; x=1757497081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVx28uNA0xbJOXxJcyu5rU5kNhMQ4PELIVd9+Dh5EcA=;
 b=hjGzQYeg2mIN2oLBMiOVpRjRPQe+yn2A2vxc4Om/HUkmZOfejRH5rbQGGXjEkWx5E+
 9fy/h+Fu8lt6ImzWUTv+47OM94ZcTnOc3RDxLo+zpnaNFhKAEZ3aR5kWEb9pwurCFqKw
 yNh8p5unMhXMVwUZ9mwm8A+jEZZlG9RKycpj/TWB53ew2YvdLjGGy+bicCOncLH30Awo
 rEqXU98bIcTDI2ycw9ZsTedveOX7e0sjKvWL7agW3H/QsDU19j6fKLMez+YcZ5NBJrjE
 MF4OW6LUcqE2ldN5yQ3+EEwHz5A9h/rL/t61uoINdl/kzD+sw9kqQ22NVRFxK/lxGcu0
 DBqw==
X-Gm-Message-State: AOJu0YyqyXrn0nV32tHfSPMWB0/cSh6itSCmj2cS87U2r5GGDZIhdrSW
 3fHGDdYNojJLg5bkZJitf2CMB7ZwuPEZb7+/Xxi6cTz8VrZ//7v2/3T80f8N4B34/reXOW3XvpS
 AjqXJ7NU=
X-Gm-Gg: ASbGncubM2PJ1943/0aXSZkG+q1+KlYVzmViV6MDXXswqlPuHjAAccme/7B7D3Dn/zC
 POuW+uHulFy+OyGDB539U3mDf1eoGhnHgAAZaen03Wkk7BXU4Ww3xGwMS3p2v+q2stDgPT2MUZx
 nNBO1wotP7ZWpgGnlelSnmX4BwRAGnpkRb0bapMdRSaPYEY+qArw6J+jsgWCaJCh9LEzP21iZzR
 aDvJs56Y4C9O9uBfDxJCMmx7GSCJVIW+BGhubDqZvq21fMPWL4H9CI0n2hVfW9wWAjYuxTjD8TK
 pyQ/y0jFXTbY7JxgEZE6gdDVSgyNak1pweBOjQIP4qALpsRJKUzT5qvrmRcAFDFaZ4ijIDPXlYt
 hMOhuubCV+woKAm0S6fVMXdbKswl3fGL6cNOOICVJzE6iOHGJ4TTSnm8hZ9uf29uAynDszIo=
X-Google-Smtp-Source: AGHT+IEsdz61X3OgnyrkLhV6hKMH1SeWVcAu9TcuXyy4UXduUPFIPSi4O/91duyYLxfVgn6FJAUsBA==
X-Received: by 2002:a17:907:7ba0:b0:af9:76cd:d836 with SMTP id
 a640c23a62f3a-b01d8a32278mr1581644866b.13.1756892280625; 
 Wed, 03 Sep 2025 02:38:00 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0445cb9296sm483831266b.61.2025.09.03.02.37.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 02:38:00 -0700 (PDT)
Message-ID: <5b5055b2-fa80-4ca9-a5ea-3e65e617be92@linaro.org>
Date: Wed, 3 Sep 2025 11:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/38] Misc HW patches for 2025-09-02
To: qemu-devel@nongnu.org
References: <20250902160004.3816-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250902160004.3816-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 9/2/25 18:00, Philippe Mathieu-Daudé wrote:
> The following changes since commit 8415b0619f65bff12f10c774659df92d3f61daca:
> 
>    Merge tag 'qga-pull-2025-08-29-v2' ofhttps://github.com/kostyanf14/qemu into staging (2025-09-02 12:07:05 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20250902
> 
> for you to fetch changes up to e502e614f4c3e5ee7b12cf1c926d9581262fd626:
> 
>    hw/i386/pc_piix.c: remove unnecessary if() from pc_init1() (2025-09-02 17:58:05 +0200)
> 
> v2: Dropped "hw/sd/sdcard: Fix size check for backing block image"
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Compile various system files once
> - Remove SDCard spec v1.10
> - Remove mipssim machine and mipsnet device model
> - Prevent crash in e1000e when legacy interrupt fires after enabling MSI-X
> - Introduce qemu_init_irq_child()
> - Remove various memory leaks reported by ASan
> - Few Coverity fixes
> - Use 74Kf CPU to run MIPS16e binaries and M14Kc for microMIPS ones
> 
> (a pair if spurious checkpatch.pl warnings ignored).


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


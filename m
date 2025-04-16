Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B03EC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56KR-0006P7-1J; Wed, 16 Apr 2025 13:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u56K6-0006Lv-0z
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:13:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u56K0-0005sD-KG
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:13:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so5900754b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744823590; x=1745428390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wa4KAGukhNqJEA5YzTqcGsVsMUfMRq1+94sJWEHIve8=;
 b=QtUq+cpylTj27mn8hYhcfrOoqsAL98OtrCPoE7h/cwOStqcsQBj0tFDwyzYCJ58MTI
 uEdcBQFzQivGbuZqzc521DljZ3IiwYkzu1Ubn3eNjx75GeDfZK8fY/4+1qZUquBdR22e
 Zooe8098DsZzreuOxANQ1kXqCFw+3L8O0E1uDVWfZeQApNsF52kLXZfNbEXSe3c1v1Rz
 zHhpn3wy4Yg1FbbJdYk1gCWcSTZ8AcV58lnR+AeAesKRFySqM1gs2yxeHJkzWs7qAgcG
 cmsq1fIh0RMHW3u/RUSZ7MR9QYIPEyJvT2oPRzVrir7hdTiqF3pvVhWxX+dBPx1F49id
 bQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744823590; x=1745428390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wa4KAGukhNqJEA5YzTqcGsVsMUfMRq1+94sJWEHIve8=;
 b=c8wd7RsBQR66rMcZ8aUmKJ2pWsv+H4iGIjCCv0nGWL3RGlkAp8YQGHsvLGWyYi4sDn
 0Wz66tO6hWo2zXDeYlhNPjTKJZoGAwo2QEEzhD17dM5WmGb6diZmvbVlvctA9iM+j1xn
 FifmI9VUAx6UCUFXHssVYs5f6K7i8xrENOU+RMPsDPOx4nsor8rygTau3B61vKrFIeIs
 HqiK2khmZG6P+6mrk1zua5Q1IBn2VgbOkxVsMmFfgMHM/i2szJHZPewG1xplApD44MpC
 CbfA6McM+WkdCClb71RFEmNC38gNvthhbniNItpIWwk0UTm18HunQSiWW7xqR0xumJKg
 U37g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZMhqwilsTnBfzwFYM7nNTTxJM9queUsOdl+PotaKVNmsvILdcIRApVL2gm9dRWNuZLp6/le8XBwXs@nongnu.org
X-Gm-Message-State: AOJu0YxVQY8uA6ikANUTRTNMPISyXjQONGwvdfnC67U5Mpqm3wZU8qjP
 V/wSo2ukAamziycDvl99thPfcNTWaCxXZ9en++v7NgWfkE4JEDEAFzA8kvg+KnYo8dorCfycaR/
 7
X-Gm-Gg: ASbGncvZmq/0lxZXY/QA7NB0lWnY1UfWm5qr5kPqCxMfSaEk7Zyy5pl75h4r3+VivhV
 kQn3JsC9kfzu7IGL1wB688UoVH3UI1svuwqP7iKB38s1Yn7Zw+5pckQjUfLut6pdBOmZvWpH4wn
 6bIkVyEIJEwO6Rggfn39A5wEwiXLQCdhOYf/CBLb2pvL0qkDi8y+YA9IbXWsRzMrSbWCy/bdXk0
 47Z2qsJC/6wtxXFm6tLPKjJ6bdxKFiXRqagQ8SiYRFQqe736PIyEkWn85cEryjA84ljPIBinDgn
 DwOmJZsCEZx3nFO0UgW0Jd19nCdCMW5GyHlD2BErmIuxOsh8A8S4ig==
X-Google-Smtp-Source: AGHT+IHi9Lcmgihqeh0KZ51GtbjseW4WMygGBgvtMgwVLyE6Jcf0nqt/82eTwjrfzDZcy46R1oYHdQ==
X-Received: by 2002:a05:6a00:1145:b0:736:4a5b:7f08 with SMTP id
 d2e1a72fcca58-73c267fe1dbmr3998712b3a.22.1744823590191; 
 Wed, 16 Apr 2025 10:13:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198926sm10666499b3a.20.2025.04.16.10.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:13:09 -0700 (PDT)
Message-ID: <e30bcd1e-6df2-469d-af6d-67b2a263690d@linaro.org>
Date: Wed, 16 Apr 2025 10:13:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-3-philmd@linaro.org>
 <655c920b-8204-456f-91a3-85129c5e3b06@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <655c920b-8204-456f-91a3-85129c5e3b06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

T24gNC8xNi8yNSAxMDowNSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMTUv
MjUgMTA6MjIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gQ1BVQVJNU3Rh
dGU6OnBjIGlzIG9mIHR5cGUgdWludDY0X3QuDQo+IA0KPiBUaGF0J3Mgbm90IGEgZ29vZCBh
cmd1bWVudC4gIEl0J3MgYSBndWVzdCB2aXJ0dWFsIGFkZHJlc3MsIGFuZCB1c2luZyB2YWRk
ciB3b3VsZA0KPiBzZWxmLWRvY3VtZW50IHRoYXQgZmFjdC4NCj4NCg0KSWRlYWxseSwgc2hv
dWxkIHdlIHVwZGF0ZSBDUFVBUk1TdGF0ZTo6cGMgYWxzbz8NCg0KPiANCj4gcn4NCg0K


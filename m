Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9E6C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd7Z-0005ss-B8; Tue, 01 Apr 2025 11:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd7V-0005qO-Qt
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:01:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd7T-0002fG-SA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:01:41 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227b650504fso113430635ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519698; x=1744124498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=osmL5wMTTWDcqwzddhIm/8/omA3sFi+E3B0Vpb5cAE4=;
 b=fEkl1OXKUVnfSTIOy2LSnXW2TkVXubHtRAa+xJm/4XtIby/jLjhYsrLoiobW9S869y
 /9qjhYNCBW8+k7aM+Uto7O4+0+RQeiWy1T3jzvAZEoAdvtoYJTy0qm9FJ7NnhOcX7a8m
 hBvXnepGHZDLES8WGaTZ8JyNJllT2aMqC623wT27PFvh7eLoGIzlvGbwT0CgbUMpNOA7
 ccUtR1VSraeQqRwp7f+Rc6DJgbkwr1ztU9l+QVOIZ6xhLZP+GA70HQ5flfA5mBu7SdvM
 okBMQglODS8LT0lStGZf7ouBPCr5q7+5fhcvSEtRb9G8oTa0QnESsOSsiy+oGe8uo6gg
 5gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519698; x=1744124498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osmL5wMTTWDcqwzddhIm/8/omA3sFi+E3B0Vpb5cAE4=;
 b=SS6ZjbSx8b9B88WbDdZ7UdixNrQXnwLKEoGazq/fr2B6U078CsrB3EOApoexf33R61
 3YOM2QVd0EfVioGvky39IlhHImH0cd+03bpuG4be55pCoA8dZa/X7Is5hCHjoqNggcTC
 ROv8Zp6Twn0f3ElhF1RbIeDAntwQKL4W0xMh7NH0SPtE1r7t9g3AyFp9v/P/NmZ1MXPH
 sPXW5w0vZfpkTWkzjAjRe8HJOwT7Utsz24bybthGJpNzb35gEpxjlxAiDhoSdPbxI7Za
 dakQuT9aRFFTSLS+/OROUMFSxEY66B138qqDUp2weODbIl/A6cRL4t3XoiAiq6L0aqPm
 qDeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVinE/w9MHebsM2df9b5puH4XbUjT4yhO6SYCzVf1lBk5O+g6ISJvPfmjE5eHNvpCxpOC6x96VC8NhF@nongnu.org
X-Gm-Message-State: AOJu0Yyxar+f2N1X9StJSYfVHI5bl9MVJY9V397eCWfHeUBjBO89gQER
 RaxI34ZyKKVqdj2LAcPtZaRTTtANdSLRjVlyGIVam+Iu2bN1DR9NGk30V8RJFSc=
X-Gm-Gg: ASbGncvsrQ55ZM3Co1Zkp7XakvTijDRMMXfxubdHw/xx2ZN6NuC6/iGj5AePOT4LGVT
 PNUp556Z/l9PghCa9nKz9EMxZmXnAk8Aan+eAQ2grQ7GzY+ADecjNgu+i424ZiO/JDRHEhdP2LE
 TIJ7ONNNXxFmRIVtqGt58Ai2oUG+3ZXKr+k0ctb1IjaPjp7myqhJDS/UzF6G8UaHHd+M9mc+GSP
 od5WtAFM+5dIDeTUg3SRo/p/oL0u7MqP+v1k7xxTb4/L6J2kHEtDYslaVaG+5qtFXBjJ2y4h8jy
 RgquzAPiBxOETw+1inhfeeAxKPTosMMniJJe9tJgbZbWCkKr+DmMoM9pkQ==
X-Google-Smtp-Source: AGHT+IE2ZLbtNkE1NDVU0GwwYFuKudPWkXTYw/C/1qYaoii7UDyO52MNAL5Bc/crvH/twpB7BENCfg==
X-Received: by 2002:a17:902:d2d1:b0:223:f9a4:3fa8 with SMTP id
 d9443c01a7336-2292f95d8bdmr212634265ad.19.1743519697941; 
 Tue, 01 Apr 2025 08:01:37 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee0d37sm89769595ad.91.2025.04.01.08.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 08:01:37 -0700 (PDT)
Message-ID: <93474fce-4774-4835-969b-2a791b2293ed@linaro.org>
Date: Tue, 1 Apr 2025 08:01:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/3] exec: Restrict 'cpu_ldst.h' to accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
 <20250401083232.33773-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250401083232.33773-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gNC8xLzI1IDAxOjMyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gTWVj
aGFuaWNhbCBjaGFuZ2UgdXNpbmc6DQo+IA0KPiAgICAkIHNlZCAtaSAtZSAncyxleGVjL2Nw
dV9sZHN0LGFjY2VsL3RjZy9jcHUtbGRzdCwnIFwNCj4gICAgICAgICAgJChnaXQgZ3JlcCAt
bCBleGVjL2NwdV9sZHN0LmgpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==


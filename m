Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4F5C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZA-0002JZ-93; Fri, 04 Apr 2025 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ6-0002Ip-OK
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:48 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ3-0005lJ-EC
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227aaa82fafso21878665ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786643; x=1744391443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4jR5B90j5Pcw9oDwiqIrU3CsJajqf86sCOZvtLGfWcI=;
 b=TkSu09Xy7ZREoSrEdTlu91PpLX2ioR2yDxE6TqLIaN9knYxH4g/kNIN4xA0H/PEbsU
 X1wAlrFS26HX88LseQW2JGcEz1tbB9GzXYxbwBTrBtdMSVrq7ATPv3Z6vtJOtYEVgRLw
 772f9k0ckZVNsTfb2QBzQDJpgv2jM4rS46T03cN3dA/0hSYYHgmDQVhvE0wxfWa0mOrw
 Q+1Jy0/KhIZoQEI6pU1ZNKRvQQI44fPObrA1JBHLWdPmUONtCZ52ULkZ9NnEz2JFjpla
 ibE7GX6VXocC4Tbg8PXuo+tuSsb+/MpUYf8hOndbMykirgt4+sWXWR98QaWwnOE7u0bB
 gIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786643; x=1744391443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4jR5B90j5Pcw9oDwiqIrU3CsJajqf86sCOZvtLGfWcI=;
 b=t9qOn+Pi2D+3k23+dSPaMsd+oLdtTEK+hrZpMtAFjyNdSr2k7U9IqHEngkqBKQQ3jA
 R+2f9rjwKaECBMrRUwuc+HTE5QBma3E0fKGML2K5zJu3D27fkoSdA9zXuxlQ2C2JAfIQ
 2Gu/Fyyin1IxF2ld324A6OanbBXGgznzDVngl8MV6tGAqv8Ssr+/Jvlz7hUVC5YkwbkX
 bJMYZGNsaakRaty2HHD1H//WueSUiYB9oi6VhPMLiRelKL7jufrq5axun4CdySEGbzS/
 Jbym0nyDp8EEZkFOlJw/aEu0QqeLgrFphWx6FTK0JX+F4PZ+kSlggmaWRx99F3T/iX6O
 FAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWruH45s59Kh6bnPRxzA6U9q5ZXEbGYstsvXFSznhCjd309GLOfsy5s2b5IotWzI6sQjVAEesziChRD@nongnu.org
X-Gm-Message-State: AOJu0Yzv3nVwKQx2Ug/IXrb4gEOR6vQ2L2Qvs+E7HYwX7ug+wRymFX3U
 cd61OOvVXF72uCz+fv6UaVCaA7bj/L0+Hswhrqo29XTk7rblyYJ7VSp2iCfJrX0=
X-Gm-Gg: ASbGncsKh18juNNp4qD7lRdQIGAZ0kLK9p+x+WcLEG3YIrOIvQHdulldjzgkUkEmBeT
 GRxhc51lJpLevLyV7yNhCEBh8Etz4SsTNYdjzzUiH/+tVddcb3yyNgas97p0Awf0YVTpC7LjGE7
 La+ZLLnzUxJD4HBCRtF9UPD4YinF/QXzfYOn1ZSft0LeEBEAZzoDujARkEjP6dSDv3wSMKbOkpp
 6Kc4Z59N6YCvYNOfhimmBN6B2yVhVss+BeoNDn2Avz8FGcqoAGGnIj1BSPE7rN3c8sVDZqAVP4P
 qJQ0iCja9ykIsKFml542wMXg84Ala1CqBvDBEDaO4kai/QpxxVTkG2svGw==
X-Google-Smtp-Source: AGHT+IH6B5z5rum6ayUSoPQBVScSv+0Bx1V2t9N/EpqUb+SlDiiKqyC+P3dRcDjJlHO061ly3+Vbxw==
X-Received: by 2002:a17:902:f685:b0:223:60ce:2451 with SMTP id
 d9443c01a7336-22a8a05a726mr48935125ad.15.1743786643505; 
 Fri, 04 Apr 2025 10:10:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:43 -0700 (PDT)
Message-ID: <53e4f7c3-47e6-4709-ba62-d98d6c2660b4@linaro.org>
Date: Fri, 4 Apr 2025 09:42:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 02/19] qemu: Convert target_name() to
 TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gNC8zLzI1IDE2OjQ4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL2h3L2NvcmUvY3B1LmggICAgICAgICAgIHwgMiAtLQ0K
PiAgIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmggfCAzICsrKw0KPiAgIGluY2x1
ZGUvcWVtdS90YXJnZXRfaW5mby5oICAgICAgfCAyICsrDQo+ICAgY3B1LXRhcmdldC5jICAg
ICAgICAgICAgICAgICAgICB8IDUgLS0tLS0NCj4gICBody9jb3JlL21hY2hpbmUtcW1wLWNt
ZHMuYyAgICAgIHwgMSArDQo+ICAgcGx1Z2lucy9sb2FkZXIuYyAgICAgICAgICAgICAgICB8
IDIgKy0NCj4gICBzeXN0ZW0vdmwuYyAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAg
IHRhcmdldF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAxICsNCj4gICB0YXJnZXRfaW5m
by5jICAgICAgICAgICAgICAgICAgIHwgNSArKysrKw0KPiAgIDkgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQoNClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==


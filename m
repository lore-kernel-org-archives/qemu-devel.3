Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D64C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 00:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wXz-00057G-Pe; Fri, 18 Apr 2025 20:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wXw-00056J-CL
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:59:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wXu-0001PQ-Q2
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:59:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso3018611b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024341; x=1745629141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fceqb2ccsfp/fYDCbRimTSES9ukvw5sl7BOlNqjQHHw=;
 b=fn36XMYOrOvCFetrlLELrs4nfjlqRqIss1YIrrXP9HFEED3pW1Jr9FtHe5OmtpiUhw
 /xxVrkSPlHBvHOMQHDg1mN7Zz3m4Ga5yJ80C3hkWE9zknr/o2+IYpSTr7NxRhz45Hk+j
 7dzkk1MyyDi2/hlBn1MmnA5NSQxjB+da9Vlrabktsw7TGfCSnQzHouwh3QsTmOOlDd0F
 ufbZmoA0hKEZuMCJX/fjDu2U44VSDLIiadvuC+GJmZC7jQDGXt4HMtLbIFS/jrXwe9qa
 yCPA5m/cJF/j92i86OO+QW2hHsHB841RLe5TrkeUhsLXgjvVnuR8ZtduP4tc4OS9cKyQ
 XfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024341; x=1745629141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fceqb2ccsfp/fYDCbRimTSES9ukvw5sl7BOlNqjQHHw=;
 b=v6TnboxUwDhbXVH3NJSE/C5ZMX7u5X3Oczpys1qFEBq7ENjprt/K1tCBbH5bBd70Dz
 Miou72Q7S4EVWW6gKLCAlxMg+6mZKr0ALjzGUwf99Ua2UtIXmzufsnO5GqXG/rud2Hwn
 QqzW4BPqxwfbRb5/lW+JlRD256S6263AG4CqzQJ+GUUmDi/Aqeld1qjSMzM2Y9grtAn6
 Tdf9+cuxubwiJSZQq02gysG2AB+FcZO1T2SSvX1DTbnU3TukUUWcLSh3e4TsEpXhtJwl
 wnWCzhobglxR/lDMpryt8sPgj9s6aXKQ5ziw66PaeJqH2wYcpc0YapY/mxqhHEjsABJE
 86TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX//XZb0vqPJDb0wE+FfebpQg589hF1wom4NsLpmWT+kHMNwAAeB8N8gk4fHWWpoV5uF0gHzBWT+2Ls@nongnu.org
X-Gm-Message-State: AOJu0Yy2F5FUBEGUSWwsdulvRozHrwKc7ZOhYV4dUMaVsbCafvinoiwb
 Tpmc0XqJQOaGl/hz6XE1ub28NdK28TlP7UvG/+JgY0tc+ovSVz1ms4H+tJ1Jrs8=
X-Gm-Gg: ASbGnctKhtDDrT3/UwrBtgLIVgrRwsFIaqvbWDIF3Z4dLs9fZhFNtkNzjPgU6KIPav1
 cARJSi3wxuLDcS2GCOSWOd65e3GD7mbTe7ecvJg3sFodCKAh2Zxt+DxivAPW9VPqNjHzwJs3pUI
 golxTKL71d3Y/oWCA0YyytxsQmxWP7bVOZE+2wtM/ISMJcnMhdwipHt2DOa0jt9ZYVGN6gSflmf
 pSanwQNNI6VtyxV3Sch75/JIFAuv8uWyamnE0tRkShasn8VWZFbrTTVtG7nCJL8NEPnlkJnDli5
 U5KXfuSa45i1I1F7ybPbsN/hgh/xXaY1cpsK+QZkIkH5qCuTxRbdOA==
X-Google-Smtp-Source: AGHT+IG7hswyWG1XWowcNtlQt35U79esWdf0CnyvPwK2PoMl5rVDYqCpwXCspFl/UhPFxBVaOSsVDQ==
X-Received: by 2002:a05:6a00:aa8d:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-73dc15e7f32mr6379279b3a.20.1745024341351; 
 Fri, 18 Apr 2025 17:59:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa5828esm2228104b3a.112.2025.04.18.17.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 17:59:00 -0700 (PDT)
Message-ID: <f8674785-b377-4b4a-bd2b-0bf7882248be@linaro.org>
Date: Fri, 18 Apr 2025 17:59:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/14] hw/core: Allow ARM/Aarch64 binaries to use
 the 'none' machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gNC8xOC8yNSAxMDoyOCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdo
ZW4gd2UnbGwgc3RhcnQgdG8gdXNlIHRhcmdldF9tYWNoaW5lX3R5cGVuYW1lKCkgdG8gZmls
dGVyDQo+IG1hY2hpbmVzIGZvciB0aGUgQVJNL0FhcmNoNjQgYmluYXJpZXMsIHRoZSAnbm9u
ZScgbWFjaGluZQ0KPiB3aWxsIGJlIGZpbHRlcmVkIG91dC4gUmVnaXN0ZXIgdGhlIHByb3Bl
ciBpbnRlcmZhY2VzIHRvIGtlZXANCj4gaXQgYXZhaWxhYmxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAt
LS0NCj4gICBody9jb3JlL251bGwtbWFjaGluZS5jIHwgNiArKysrKysNCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9u
dWxsLW1hY2hpbmUuYyBiL2h3L2NvcmUvbnVsbC1tYWNoaW5lLmMNCj4gaW5kZXggMWNjYWY2
NTJlYjQuLmRkNTZkN2NiN2U1IDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL251bGwtbWFjaGlu
ZS5jDQo+ICsrKyBiL2h3L2NvcmUvbnVsbC1tYWNoaW5lLmMNCj4gQEAgLTE2LDYgKzE2LDcg
QEANCj4gICAjaW5jbHVkZSAiaHcvYm9hcmRzLmgiDQo+ICAgI2luY2x1ZGUgInN5c3RlbS9h
ZGRyZXNzLXNwYWNlcy5oIg0KPiAgICNpbmNsdWRlICJody9jb3JlL2NwdS5oIg0KPiArI2lu
Y2x1ZGUgImh3L2FybS9tYWNoaW5lcy1xb20uaCINCj4gICANCj4gICBzdGF0aWMgdm9pZCBt
YWNoaW5lX25vbmVfaW5pdChNYWNoaW5lU3RhdGUgKm1jaCkNCj4gICB7DQo+IEBAIC02Miw2
ICs2MywxMSBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gbnVsbF9tYWNoaW5lX3R5cGVzW10g
PSB7DQo+ICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgi
bm9uZSIpLA0KPiAgICAgICAgICAgLnBhcmVudCAgICAgICAgID0gVFlQRV9NQUNISU5FLA0K
PiAgICAgICAgICAgLmNsYXNzX2luaXQgICAgID0gbnVsbF9tYWNoaW5lX2NsYXNzX2luaXQs
DQo+ICsgICAgICAgIC5pbnRlcmZhY2VzICAgICA9IChJbnRlcmZhY2VJbmZvW10pIHsNCj4g
KyAgICAgICAgICAgIHsgVFlQRV9UQVJHRVRfQVJNX01BQ0hJTkUgfSwNCj4gKyAgICAgICAg
ICAgIHsgVFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FIH0sDQo+ICsgICAgICAgICAgICB7
IH0sDQo+ICsgICAgICAgIH0sDQo+ICAgICAgIH0sDQo+ICAgfTsNCj4gICANCg0KUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4N
Cg0K


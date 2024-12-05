Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99409E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFJa-0004U2-8c; Thu, 05 Dec 2024 12:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFJX-0004TJ-G1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:06:55 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFJV-0007AP-DG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:06:55 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-724e5fb3f9dso1079644b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418412; x=1734023212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lGYMY6WRm/CgvOKPzzv7GX+9rGXPyRw+TojADqecgy8=;
 b=mBlsfuh+TCo226C6mp4bAmVZyQNWNhbRuzTwJRO19y/HO19Oemcxc572XK42BLNEJe
 wo4hdL12IQKCheg5wr4usapOdKGeGMxFuviEQg2dQJOMTiMj+7Hprsizhq7ATd/XUhUB
 ZIllMkIwJs8eDdSwAv2q6WYEm95LTFSanBe8xJe4b5otuWoXzJcKa5sY+4yfZ0ZTihx+
 7NrBbFR+c9/Y3+UASpgv1XHC5fuQ/pGOtiO2c/z/aGCT5mNvJufbdckf/S4ylJtlVWTs
 K8UAzGiAhITiQrZ58a2WTM90IEMj9w2upqyq9iwizo2dUPi0HDEh9AHBEcs4r1/s73t2
 J3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418412; x=1734023212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lGYMY6WRm/CgvOKPzzv7GX+9rGXPyRw+TojADqecgy8=;
 b=Qyl5XaEwDJEAmML9+2L70FhxUEmdddEFs12WGdepkgLCF5tmtBrqgXppr+S94u8fsC
 M2S4HkjjS9UzKG9DaBzZKuxQ7YrUeQTUhs9dssggteY8UabZRW2iWdWoofBzii29GcMR
 AcZD0/ojtSqcEuSTjbR5QGPUxuwnCAtToBHqMdBeGcvvPUwnO+ozcFAOl3PYm1c9rv7A
 3yOJIuBgH0vpv7hM/ZfXD5pDzBo9EATUVdD5X7Edvd9qx9OpgHd2Fp5VaksB4LfD3kWR
 Y80B2jDK9J3CGLWvrRNTfrdM+0LOlWHWOGsyqpVrIqSt5HxVS7A9xnAQ8I7jJg8tnVkW
 uF+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVdZ5RqfeSPeG152AInAhZPYfo+j7QxtSCqlvR4ATr3nojNaF4fEKR+uW+tBJyno1WaAjRpOBNNAEG@nongnu.org
X-Gm-Message-State: AOJu0YwccrsNyOROA6JV4WFrbVGSJnzZiwEky2dtWnF1aCc2pgjGjXrf
 8pC43A+l7Sjp1ttiSNV1ZR/YYaPF1pbN/E3qnsBt6ijIQSRF4pn47gfxlDzLhgQ=
X-Gm-Gg: ASbGnct5TXUK4tjbpavottfjF+nxs+H44fl+kU4iKgrefd0CZdFgx1S4csuwORvG7md
 b3M2G1C8TJ8itET3LfVCmlcW5ErbwLb3UFI0pOpa75lNuKWs6mwOa2Pvwvpvv4I5j9tKWh/jEr3
 /9Ub1OoDnh6kD2Qxu92zIE1MbKAcPJo0OzocYO1URLlY+AmTA7THJLKK61UZ4C/h0eaASAl6K59
 BVpjMb5/TgORYpEKHtPMP0tPY+4lv/sqgIcwHdn+ZNjf2wij1rQ4TPwyKsP6NAqCotLMAS8rXx+
 BLpIhbGTvcWFwsQu3idltA==
X-Google-Smtp-Source: AGHT+IFp4yg6KGElUVOp5ATJGDG25H8hEXBoGjCT7NXdnuYwYJh48jND6l21XzghxXEQ4laPZPBaUA==
X-Received: by 2002:a05:6a00:3d03:b0:720:36c5:b548 with SMTP id
 d2e1a72fcca58-7257fcb8d37mr13764873b3a.16.1733418411387; 
 Thu, 05 Dec 2024 09:06:51 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2cc5e70sm1468645b3a.174.2024.12.05.09.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:06:50 -0800 (PST)
Message-ID: <7765df38-eb5a-462f-8145-72891b309c5a@linaro.org>
Date: Thu, 5 Dec 2024 09:06:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] docs/system/arm/fby35: document execute-in-place
 property
Content-Language: en-US
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, alex.bennee@linaro.org,
 Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
 <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
 <0121beea0cbf51268ce6c9e20e7c16660ec6b9fb.camel@codeconstruct.com.au>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0121beea0cbf51268ce6c9e20e7c16660ec6b9fb.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

T24gMTIvNC8yNCAxOTozNywgQW5kcmV3IEplZmZlcnkgd3JvdGU6DQo+IE9uIFdlZCwgMjAy
NC0xMi0wNCBhdCAxMjozOSAtMDgwMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IFNp
Z25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4+IC0tLQ0KPj4gIMKgZG9jcy9zeXN0ZW0vYXJtL2ZieTM1LnJzdCB8IDMgKysr
DQo+PiAgwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RvY3Mvc3lzdGVtL2FybS9mYnkzNS5yc3QgYi9kb2NzL3N5c3RlbS9hcm0vZmJ5
MzUucnN0DQo+PiBpbmRleCBiZjZkYTZiYWEyYS4uZWQ5ZmFlZjM2M2MgMTAwNjQ0DQo+PiAt
LS0gYS9kb2NzL3N5c3RlbS9hcm0vZmJ5MzUucnN0DQo+PiArKysgYi9kb2NzL3N5c3RlbS9h
cm0vZmJ5MzUucnN0DQo+PiBAQCAtNDUsMyArNDUsNiBAQCBwcm9jZXNzIHN0YXJ0cy4NCj4+
ICDCoMKgwqDCoCAkIHNjcmVlbiAvZGV2L3R0eTAgIyBJbiBhIHNlcGFyYXRlIFRNVVggcGFu
ZSwgdGVybWluYWwgd2luZG93LA0KPj4gZXRjLg0KPj4gIMKgwqDCoMKgICQgc2NyZWVuIC9k
ZXYvdHR5MQ0KPj4gIMKgwqDCoMKgICQgKHFlbXUpIGPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICMgU3RhcnQgdGhlIGJvb3QgcHJvY2VzcyBvbmNlIHNjcmVlbiBpcw0KPj4gc2V0dXAuDQo+
PiArDQo+PiArVGhpcyBtYWNoaW5lIG1vZGVsIHN1cHBvcnRzIGVtdWxhdGlvbiBvZiB0aGUg
Ym9vdCBmcm9tIHRoZSBDRU8gZmxhc2gNCj4gDQo+IEJpdCBvZiBhIG5pdCwgYnV0OiBzL0NF
Ty9DRTAvIDopDQo+DQoNCk15IG1pbmQgd2FzIHByb2JhYmx5IGNvbmRpdGlvbmVkIFsxXSBh
ZnRlciByZWFkaW5nIEZhY2Vib29rIDopLg0KDQpbMV0gaHR0cHM6Ly90ZWNoY3J1bmNoLmNv
bS8yMDExLzA2LzI1L2ltLWNlby1iaXRjaC8NCg0KTW9yZSBzZXJpb3VzbHksIEknbGwgZml4
IHRoYXQsIHRoYW5rcyENCg0KPiBBbmRyZXcNCg0K


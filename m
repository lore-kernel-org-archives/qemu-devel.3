Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BF1E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 20:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNI65-00062T-C0; Mon, 16 Dec 2024 15:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNI63-00062C-5i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 15:53:43 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNI61-0006zf-D0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 15:53:42 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fd45005a09so2752798a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734382419; x=1734987219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FKz8PC6zkJnpt+XOAmgSSdp3G1S28O6SHz8XbvJzh4=;
 b=AW1BjBoIsMUhx6AbkstzvbNcL1znGc3OVVn1Cd3fceCBjECWIWueSjgJzAHvFesPZW
 ea8CinV96qJEJ05t3wAJOOxPZfOHk9DeTQU7Tcng/1Bgy9xbjP9/pwlQ2AojcnrmcHpN
 DruX5BP7n3Y6B5c8jab4DuLRrsbB0Lj8m5UEwkAP42FkWq8omeRZKfK8AxbHYCPS4Bci
 rs85EnCHEi60MhirfUzBDLNr9gk18ATBQX9rvH0gTzHhUtDjFvMA0XEBwjUnggDOEtvz
 6douy7i60LaVxz32D7qmEfmMkJYy+i0LfSUM188q+mwMCzfJtfnBI4kp1bdzZX8TGldg
 mIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734382419; x=1734987219;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3FKz8PC6zkJnpt+XOAmgSSdp3G1S28O6SHz8XbvJzh4=;
 b=Vm6+lodgOCeu2rNmnCMzqQ0LKEsjOIBZuwhxWfHLib8q6w+D7jFMWZ9XJ/qF74E9WU
 YmBSu0+hQqkdZ5+i2M/KmnHElwusKgdoSWPfr0FgoOeOOxS7cC5e5a+42tWsMdWv8X9J
 klVGz/XsKoa4CP/gfPfz7ShJZoETMe2Nt4DN2+n7pbFuhYH5WLOrRa+lWbKWqTLBV+FK
 zTCmOuDYpg/WkiEHCNXCgQKbe2MJPaE0NQeI32sh1hShN4f9xJzwSUcXtcstvJzmxjph
 AuNOrgnrKwKM0LUfHwA1iL426PI8PkYTtcs8vSJLqoHckm9+BvsCcPJbMcDv+z8/uo2C
 f6bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9iad+Nw3B86LAA2TVNEkZWw/QTh5Y//SB7A3PsboKYnuarJsbk74PZ6F5Hi4ghPx+1LQ8IiCjP/Tt@nongnu.org
X-Gm-Message-State: AOJu0YyY1RJLxPjauxXolXfPvX4jeicHPccoNoSKp7Rb0kM+mSRNoueo
 rMMuJpabdsEdpee7BqgABw2FTJtljsGi4RgDEqWpOHLXmPKsyWPdVqvSUhYYAOE=
X-Gm-Gg: ASbGncuuKU35wilYVU9ROI+V/5f6H7c+yzHA8cpmRhv456aY8BCb3Z47OqIolupfpQW
 WE4USZ23SkdHmb3oGWLDI5Nqk2e7wurrm0qFbVlGW6Fjtyya9zqJDJjqtnDM3kDsisJL6tYaPwp
 p8u6tSOnPusTWJgD5K8BaTMLznPWQTy7RGawwfFErqkX12ooJ5bVsK5mw1Aux5oQ39iclgTxN1h
 7uVlnHpZf8Lfhnbt3uP0WWFGEoh4s/+Lvk910R4/BOfAhbT5cjNjJxl8aLLh0ZCCn0+OdGBiWP7
 emiD06Bmqj3cxa3UV7w4s/N9Ljm/
X-Google-Smtp-Source: AGHT+IGhLT+OdKA6Mcp427h/eTK3vtIDEepPp2DcDlsY1V4VYS2iQ9FHwC00qx/jQceZc00C6VQdBA==
X-Received: by 2002:a17:90b:4cd1:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2f28fb63e72mr18864507a91.11.1734382419300; 
 Mon, 16 Dec 2024 12:53:39 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142fa218bsm8493663a91.35.2024.12.16.12.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 12:53:38 -0800 (PST)
Message-ID: <ab7297b6-95f8-428b-b82a-329380a2dcb1@linaro.org>
Date: Mon, 16 Dec 2024 12:53:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
 <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
 <ae5c9de4-67e5-4a37-a184-eb4017723725@linaro.org>
 <bf824af9-3351-40b6-8d94-e51187295d49@linaro.org>
In-Reply-To: <bf824af9-3351-40b6-8d94-e51187295d49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

T24gMTIvMTYvMjQgMTA6NDUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+IE9uIDEyLzE0
LzI0IDA0OjM1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IE9uIDE0LzEy
LzI0IDA2OjI5LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAxMi8xMy8yNCAy
MTo0NCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4gSGkgUmljaGFyZCwNCj4+Pj4N
Cj4+Pj4gT24gMTIvMTMvMjQgMTM6NDcsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+
Pj4gSGksDQo+Pj4+Pg0KPj4+Pj4gU2V2ZXJhbCBvZiB0aGUgcmVjZW50IGNvbnRyaWIvcGx1
Z2lucy8gcGF0Y2hlcyBkbyBub3QgYnVpbGQgb24gZS5nLg0KPj4+Pj4gYXJtMzIuDQo+Pj4+
PiBBbGwgb2YgdGhlIGlzc3VlcyBhcmUgcmVsYXRlZCB0byBjYXN0aW5nIGJldHdlZW4gcG9p
bnRlcnMgYW5kDQo+Pj4+PiB1aW50NjRfdDsgdGhlcmUgaXMgYSBXZXJyb3INCj4+Pj4+IGdl
bmVyYXRlZCBmb3IgY2FzdGluZyBiZXR3ZWVuIHBvaW50ZXJzIGFuZCBpbnRlZ2VycyBvZiBk
aWZmZXJlbnQgc2l6ZXMuDQo+Pj4+Pg0KPj4+Pj4gSSBzdXNwZWN0IGFsbCBvZiB0aGUgaW5z
dGFuY2VzIHdpbGwgbmVlZCB0byB1c2Ugc2VwYXJhdGUgc3RydWN0dXJlcw0KPj4+Pj4gdG8g
c3RvcmUgdWludDY0X3QNCj4+Pj4+IHdpdGhpbiB0aGUgaGFzaCB0YWJsZXMuwqAgVGhlIGhh
c2ggdmFsdWVzIHRoZW1zZWx2ZXMgY2FuIHVzZQ0KPj4+Pj4gdWludHB0cl90LCBhcyAiaGFz
aCIgYnkNCj4+Pj4+IGRlZmluaXRpb24gbG9zZXMgZGF0YS4NCj4+Pj4+DQo+Pj4+PiBUaGUg
Zm9sbG93aW5nIGlzICpub3QqIGEgc3VnZ2VzdGVkIHBhdGNoLCBqdXN0IHRvdWNoZXMgZXZl
cnkgcGxhY2UNCj4+Pj4+IHdpdGggYW4gZXJyb3IgdG8NCj4+Pj4+IGhpZ2hsaWdodCBhbGwg
b2YgdGhlIHBsYWNlcy4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFRoaXMgaXMgc29tZXRoaW5nIEkg
YWxyZWFkeSB0cmllZCB0byBmaXggdGhpcyB3YXksIGJ1dCBhbGFzLCBjYXN0aW5nDQo+Pj4+
IHZhbHVlcyBpcyBub3QgZW5vdWdoLCB3ZSBtaWdodCBsb3NlIGluZm9ybWF0aW9uIChpbiB0
aGUgY2FzZSB3aGVyZQ0KPj4+PiBndWVzdCBpcyA2NCBiaXRzKS4gU29tZSBwbHVnaW5zIG5l
ZWQgYSByZWZhY3RvcmluZyB0byBhbGxvY2F0ZSBkYXRhDQo+Pj4+IGR5bmFtaWNhbGx5LCBp
bnN0ZWFkIG9mIGhpZGluZyBpdCB1bmRlciBhIHBvaW50ZXIuDQo+Pj4+DQo+Pj4+IFNlZSB0
aGlzIHByZXZpb3VzIHNlcmllczoNCj4+Pj4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIw
MjQwODE0MjMzNjQ1Ljk0NDMyNy0xLQ0KPj4+PiBwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmcvDQo+Pj4+DQo+Pj4+IEZpbmFsbHksIHdlIGRpc2N1c3NlZCBpdCB3YXMgbm90IHdvcnRo
IHRoZSBlZmZvcnQsIGFuZCBBbGV4IHNpbXBseQ0KPj4+PiBkZWFjdGl2YXRlZCBwbHVnaW5z
IGJ5IGRlZmF1bHQgZm9yIDMyIGJpdHMgcGxhdGZvcm0sIHNvIGl0IHNob3VsZCBub3QNCj4+
Pj4gYmUgYnVpbHQgZm9yIGFybSAzMiBiaXRzLiBJZiB3ZSByZWFsbHkgaGF2ZSBzb21lb25l
IHRoYXQgbmVlZHMgdGhpcw0KPj4+PiB1c2VjYXNlLCB3ZSBtaWdodCBtYWtlIHRoZSBlZmZv
cnQsIGJ1dCBmb3Igbm93LCBpdCBkb2VzIG5vdCBzZWVtIHdvcnRoDQo+Pj4+IHRoZSBoYXNz
bGUuDQo+Pg0KPj4gVGhpcyBpczoNCj4+DQo+PiBjb21taXQgY2YyYTc4Y2JiYjQ2M2Q1NzE2
ZGE5ODA1YzhmYzU3NTg5Mzc5MjRkOA0KPj4gQXV0aG9yOiBBbGV4IEJlbm7DqWUgPGFsZXgu
YmVubmVlQGxpbmFyby5vcmc+DQo+PiBEYXRlOiAgIE1vbiBTZXAgMTYgMDk6NTM6NDMgMjAy
NCArMDEwMA0KPj4NCj4+ICAgICAgICBkZXByZWNhdGlvbjogZG9uJ3QgZW5hYmxlIFRDRyBw
bHVnaW5zIGJ5IGRlZmF1bHQgb24gMzIgYml0IGhvc3RzDQo+Pg0KPj4gICAgICAgIFRoZSBl
eGlzdGluZyBwbHVnaW5zIGFscmVhZHkgbGliZXJhbGx5IHVzZSBob3N0IHBvaW50ZXIgc3R1
ZmZpbmcgZm9yDQo+PiAgICAgICAgcGFzc2luZyB1c2VyIGRhdGEgd2hpY2ggd2lsbCBmYWls
IHdoZW4gZG9pbmcgNjQgYml0IGd1ZXN0cyBvbiAzMiBiaXQNCj4+ICAgICAgICBob3N0cy4g
V2Ugc2hvdWxkIGRpc2NvdXJhZ2UgdGhpcyBieSBvZmZpY2lhbGx5IGRlcHJlY2F0aW5nIHN1
cHBvcnQgYW5kDQo+PiAgICAgICAgYWRkaW5nIGFub3RoZXIgbmFpbCB0byB0aGUgMzIgYml0
IGhvc3QgY29mZmluLg0KPj4NCj4+IC4uLg0KPj4NCj4+ICtUQ0cgUGx1Z2luIHN1cHBvcnQg
bm90IGVuYWJsZWQgYnkgZGVmYXVsdCBvbiAzMi1iaXQgaG9zdHMgKHNpbmNlIDkuMikNCj4+
ICsnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJycnJycnJycNCj4+DQo+PiAuLi4NCj4+DQo+PiAtaWYgdGVzdCAiJHBsdWdp
bnMiICE9ICJubyI7IHRoZW4NCj4+ICtpZiB0ZXN0ICIkcGx1Z2lucyIgIT0gIm5vIiAmJiB0
ZXN0ICRob3N0X2JpdHMgLWVxIDY0OyB0aGVuDQo+PiAgICAgICBwbHVnaW5zPXllcw0KPj4N
Cj4+PiBIbW0uwqAgSSBkaWRuJ3QgZGVsZXRlIG15IDMyLWJpdCBidWlsZCB0cmVlLCBidXQg
aXQgY2VydGFpbmx5IHJlLQ0KPj4+IGNvbmZpZ3VyZWQuwqAgSWYgcGx1Z2lucyBhcmUgc3Vw
cG9zZWQgdG8gYmUgZGlzYWJsZWQsIHNvbWV0aGluZyBtYXkgYmUNCj4+PiB3cm9uZyB0aGVy
ZS4uLg0KPj4+DQo+IA0KPiBUbyBhZGQgbW9yZSBkZXRhaWxzLCBtb3N0IG9mIHRoZSBwcm9i
bGVtcyB3aXRoIHBsdWdpbnMgY29tZXMgZnJvbQ0KPiBjb252ZXJ0aW5nIHVpbnQ2NCB0byBw
b2ludGVycywgZm9yIHVzZSBpbiBoYXNoIHRhYmxlcy4NCj4gDQo+IFRoZSBtYWNyb3MgR0lO
VF9UT19QT0lOVEVSIGFuZCBHVUlOVF9UT19QT0lOVEVSIGFyZSBjYXN0aW5nIHRvIGxvbmcN
Cj4gYmVmb3JlIGNhc3RpbmcgdG8gcG9pbnRlciwgc28gdGhleSBpbmhpYml0IHRoZSBjb252
ZXJzaW9uIHdhcm5pbmcgd2UNCj4gc2hvdWxkIG5vcm1hbGx5IGhhdmUuIElNSE8sIGl0J3Mg
YSBiYWQgdGhpbmcgYW5kIHZlcnkgZXJyb3IgcHJvbmUgZXZlbg0KPiB0aG91Z2ggdGhlIEds
aWIgZG9jdW1lbnRhdGlvbiBtZW50aW9ucyB0aGlzLg0KPiANCj4gSW4gc2hvcnQsIHRoZSBi
ZXN0IHdheSB0byBkZWFsIHdpdGggdGhpcyB3b3VsZCBiZSBnZXQgcmlkIG9mDQo+IEdVSU5U
X1RPX1BPSU5URVIgYW5kIEdJTlRfVE9fUE9JTlRFUiBpbiBwbHVnaW5zIGNvZGUsIGFuZCBm
aXggYWxsIHRoZQ0KPiB3YXJuaW5ncyByZWxhdGVkLg0KPiANCg0KSSB3aWxsIHB1c2ggYSBz
ZXJpZXMgdG8gZml4IDMyIGJpdHMgYnVpbGRzIGZvciBwbHVnaW5zIChhbGwgZG9uZSwgSSdt
IA0Kbm93IHRlc3RpbmcgaXQgdG8gZW5zdXJlIGl0IGRvZXMgbm90IGJyZWFrIG1vZGlmaWVk
IHBsdWdpbnMpLg0KDQpJIHdhcyBhIGJpdCBoZXNpdGFudCB0byBkbyBpdCBiZWZvcmUsIGJ1
dCBub3cgdGhhdCB3ZSBidWlsZCBjb250cmliIA0KcGx1Z2lucyB3aXRoIG1lc29uLCBpdCBt
YWtlcyBzZW5zZSB0byBzdXBwb3J0IGl0LiBJbiBtb3JlLCB0aGUgY2hhbmdlIGlzIA0KcHJl
dHR5IHN0cmFpZ2h0Zm9yd2FyZC4NCg0KSSdsbCByZXZlcnQgdGhlIGNvbmZpZ3VyZSBjaGFu
Z2UgdG8gcmVlbmFibGUgcGx1Z2lucyBieSBkZWZhdWx0IGFzIHdlbGwuDQoNCj4+Pg0KPj4+
IHJ+DQo+Pj4NCj4+DQo+IA0KDQo=


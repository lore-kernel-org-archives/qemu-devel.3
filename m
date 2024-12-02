Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A6E69E81
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 18:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIBHQ-0003il-8J; Mon, 02 Dec 2024 13:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIBHN-0003hy-7A
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:36:17 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIBHI-0003KB-LU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:36:16 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fc2b80c845so2346700a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733164569; x=1733769369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oivYi+ksQkL9zqgH9QocSn+LXHGuCHFx2hL505Chc9I=;
 b=Xcm13J2DnhJ2a8TZ8d8RMtEs+qXkXoAi6az84FhSugU4HNxQVqjgBY02qelNV5GfyW
 qkfV0BK5rQo3IsM2odJDpbSOe8eukwR4wNuAQq/1/BZRraDU1pzCW96tUzPTBCTxRMMt
 hHVvtSIAFTaFshB6GwBWPbyv4ev2VKlwz+3NnxYG10RhUBFX3qdvwpLf/0H4k1qiE7Yx
 vtrmx+OcSWXrIxL/Z49eb7BZRz5ksLF83vN+8Z5Tu64+bf1mBaFmv/DqDEp/zHU8W7Ka
 9G68TjH1fYqU31SYjz+Reh5jqGRQO/qGzQjnXTq+x1JO7HfDRf8W72DHOvJ2ZGdOnf/Q
 cAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733164569; x=1733769369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oivYi+ksQkL9zqgH9QocSn+LXHGuCHFx2hL505Chc9I=;
 b=FV3c8g38KEzxsslLsU2L5jMr+WxSKquf4fU3yJFxU4VyVtpj/un5x9eMB1T5YNdKiI
 8AFZ0ZImaUUExmzO2svA98AJgWyArn/MrdFtpUQwU3Pz7lLqG58mOztgSaUlg8lx357T
 YKdcwz/MrkEaWtmZULN8GtgsgAmMtjU00AlmQTLn1bceqDpzG/y0k/hJz3jC5ekfufTy
 W0OS07Nv/UvkRVGs//m03oM6eutPd7dVx103O7ThT5kUtjU9JDxdUJD5FY0Xsj5pWQA3
 e7um9seb3hctgcba1PZZHTksH1HS1aA82SZ50m/IzCIDDIz3hgyJd9ICNRAz0eOjT0XQ
 IAPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRtWp9vMU7eVjGW73OScdGP62MyIBnW/uQ24RShuO7AIwEJNCboqmrwzXuNX7lA2n0M0Sqa6P3p7Gi@nongnu.org
X-Gm-Message-State: AOJu0YxjsI2dB3/WIiNibx9CFzbaiAq46G6vUcEROvuLVbJMeVRhiZTr
 rarGTluzILVeNhq0Cgn79+BjL3pjDMsorQ5l2LiH5wuns4K+HmrcTzhlQtEzMjY=
X-Gm-Gg: ASbGncueEr3cTV3lS444cw2SS9GB40E3QEDrljuVuPV7rcn9fojNtSLUGnNwLvCwYVG
 jzKJpaLuR8rOL94AYiU4n6U625U64qdEITynzXVTY8gcYujU7En/ppVqixt8qVPKWKnWryEJoUm
 b4mX8ANoPpCV5I9ZZuPNWTuwb7WzAZKCgkmP9g+f73bDQLFV1ZXQz0+liXpL8KprDSQRbquncFu
 R1BVj9Z9NWa4Zi8qmH7oHc5mOyT7JVy0G5chKu+64aO2Z/HG4tpVO8eG36G1PpZiMVnK3Cs7GZ5
 vNIuak/sde3sR/A+7DFqlA==
X-Google-Smtp-Source: AGHT+IFEI0IPcpn3W47lqoMIQGPFLqP1rC8pv6/veul69ZM4PKM0kHe9IgYQfWMXFy7R93sbjm+bjA==
X-Received: by 2002:a05:6a20:2583:b0:1e0:d380:fe71 with SMTP id
 adf61e73a8af0-1e0e09e2467mr34719207637.0.1733164568560; 
 Mon, 02 Dec 2024 10:36:08 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417fba22sm8827623b3a.113.2024.12.02.10.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 10:36:08 -0800 (PST)
Message-ID: <a26e2a3d-d915-4e84-9b8e-dd5935049f31@linaro.org>
Date: Mon, 2 Dec 2024 10:36:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ser6c5be.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

T24gMTIvMi8yNCAxMDoyMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAx
Mi8yLzI0IDAyOjU3LCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPj4+IE9uIFN1biwgMSBEZWMg
MjAyNCBhdCAxODowOSwgUGllcnJpY2sgQm91dmllcg0KPj4+IDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+Pg0KPj4+PiBIaSBNYXJjaW4sDQo+Pj4+DQo+Pj4+
IE9uIDEyLzEvMjQgMDU6MzQsIE1hcmNpbiBKdXN6a2lld2ljeiB3cm90ZToNCj4+Pj4+IFcg
ZG5pdSAyOC4xMS4yMDI0IG8gMjI6MzcsIFBpZXJyaWNrIEJvdXZpZXIgcGlzemU6DQo+Pj4+
Pj4gVGhpcyBib290IGFuIE9QLVRFRSBlbnZpcm9ubWVudCwgYW5kIGxhdW5jaCBhIG5lc3Rl
ZCBndWVzdCBWTSBpbnNpZGUgaXQNCj4+Pj4+PiB1c2luZyB0aGUgUmVhbG1zIGZlYXR1cmUu
IFdlIGRvIGl0IGZvciB2aXJ0IGFuZCBzYnNhLXJlZiBwbGF0Zm9ybXMuDQo+Pj4+Pj4NCj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQo+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlv
bmFsL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZA0KPj4+Pj4+
IGluZGV4IDVjMDQ4Y2ZhYzZkLi5iOTc1YTE1NjBkZiAxMDA2NDQNCj4+Pj4+PiAtLS0gYS90
ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+Pj4+Pj4gKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9tZXNvbi5idWlsZA0KPj4+Pj4+IEBAIC0xMyw2ICsxMyw4IEBAIGVuZGlmDQo+Pj4+
Pj4gICAgICB0ZXN0X3RpbWVvdXRzID0gew0KPj4+Pj4+ICAgICAgICAnYWFyY2g2NF9hc3Bl
ZWQnIDogNjAwLA0KPj4+Pj4+ICAgICAgICAnYWFyY2g2NF9yYXNwaTQnIDogNDgwLA0KPj4+
Pj4NCj4+Pj4+PiArICAnYWFyY2g2NF9ybWVfdmlydCcgOiA3MjAsDQo+Pj4+Pg0KPj4+Pj4g
VG9vayAyOTc0Ljk1cyBvbiBNMSBQcm8gbWFjYm9vay4NCj4+Pj4+DQo+Pj4+Pj4gKyAgJ2Fh
cmNoNjRfcm1lX3Nic2FyZWYnIDogNzIwLA0KPj4+Pj4NCj4+Pj4+IFRoaXMgb25lIG5lZWRl
ZCAyMjg4LjI5cy4NCj4+Pj4+DQo+Pj4+Pj4gICAgICAgICdhYXJjaDY0X3Nic2FyZWZfYWxw
aW5lJyA6IDcyMCwNCj4+Pj4+DQo+Pj4+PiBIYXZlIHRvIGNoZWNrIGNhdXNlIHRpbWVkIG91
dC4NCj4+Pj4+DQo+Pj4+Pj4gICAgICAgICdhYXJjaDY0X3Nic2FyZWZfZnJlZWJzZCcgOiA3
MjAsDQo+Pj4+Pg0KPj4+Pj4gMzMxLjY1cw0KPj4+Pj4NCj4+Pj4+IFNvIFJNRSB0ZXN0cyBw
cm9iYWJseSBuZWVkIGxvbmdlciB0aW1lb3V0cyBvciB3b3VsZCBub3QgcnVuIGF0IGFsbC4N
Cj4+Pj4+DQo+Pj4+DQo+Pj4+IEJ5IGFueSBjaGFuY2UsIGFyZSB5b3UgcnVubmluZyB0aG9z
ZSB0ZXN0cyBpbiBkZWJ1ZyBtb2RlPw0KPj4+PiBJdCBzZWVtcyB0byBtZSB0aGF0IENJIGlz
IHJ1bm5pbmcgZnVuY3Rpb25hbCB0ZXN0cyB3aXRoIG9wdGltaXplZA0KPj4+PiBidWlsZHMs
IHNvIEknbSBub3Qgc3VyZSB3ZSB3YW50IHRvIHN1cHBvcnQgZGVidWcgInRpbWVzIiBoZXJl
Lg0KPj4+IFdlIGRvIG5lZWQgdG8gc3VwcG9ydCBkZWJ1ZyB0aW1lcywgYmVjYXVzZSBhIGNv
bW1vbiBkZXZlbG9wZXINCj4+PiB1c2UgY2FzZSBpcyAiZG9pbmcgYSBkZWJ1ZyBidWlsZCwg
cnVuICdtYWtlIGNoZWNrLWZ1bmN0aW9uYWwnDQo+Pj4gdG8gY2hlY2sgd2hldGhlciBhbnl0
aGluZyBpcyBicm9rZW4uIFRoZSBkZWJ1ZyB0aW1lcyBhbHNvDQo+Pj4gYXJlIHVzZWZ1bCBi
ZWNhdXNlIHRoZSBDSSBydW5uZXJzIGNhbiBoYXZlIGhpZ2hseSB2YXJpYWJsZQ0KPj4+IHBl
cmZvcm1hbmNlIC0tIGlmIGEgdGVzdCBpcyBzbG93IGVub3VnaCB0byBoaXQgdGhlIHRpbWVv
dXQNCj4+PiBmb3IgYSBkZWJ1ZyBidWlsZCBsb2NhbGx5LCBpdCdzIHByb2JhYmx5IGdvaW5n
IHRvIGFsc28gaGl0DQo+Pj4gdGhlIHRpbWVvdXQgYXQgbGVhc3Qgc29tZXRpbWVzIGluIENJ
Lg0KPj4+DQo+Pg0KPj4gSSB1bmRlcnN0YW5kIHRoZSBzY2VuYXJpbywgYnV0IGdpdmVuIGhv
dyBzbG93IGRlYnVnIGJ1aWxkcyBhcmUsIGl0DQo+PiB3b3VsZCBwcm9iYWJseSBiZSBmYXN0
ZXIgdG8gYWR2aXNlIGRldmVsb3BlciB0byByZWNvbXBpbGUgaW4gcmVsZWFzZQ0KPj4gbW9k
ZS4NCj4+IFRoZSBvdmVyYWxsIHRpbWUgb2YgY29tcGlsZSArIHRlc3QgaXMgc2xvd2VyIHRo
YW4gd2FpdGluZyBmb3IgZGVidWcuDQo+Pg0KPj4gQmV5b25kIHVzaW5nIGEgZGVidWdnZXIs
IHdoYXQgaXMgdGhlIGFkdmFudGFnZSB0byBjb21waWxlIHdpdGggLU8wPw0KPiANCj4gLS1l
bmFibGUtZGVidWcNCj4gDQo+ICAgIC0gZW5hYmxlcyAtMDAgd2l0aCAtZzMgZm9yIHN5bWJv
bHMNCj4gICAgLSBhbmQgZW5hYmxlcyBhZGRpdGlvbmFsIGNoZWNrcyB0byB2YWxpZGF0ZSBU
Q0cNCj4gDQoNCkknbSBhd2FyZSB0aGlzIGlzIHRoZSBjb21iaW5hdGlvbiBvZiBib3RoLCBh
bmQgaW5kZWVkLCBydW50aW1lIGNoZWNrcyANCmNhbiBiZSBkb25lIG9uIG9wdGltaXplZCBi
dWlsZHMgYXMgd2VsbCAoaXQncyB0aGUgY29tYmluYXRpb24gSSB1c2UgDQpwZXJzb25hbGx5
KS4NCg0KTWF5YmUgb3VyIGVuYWJsZS1kZWJ1ZyBzaG91bGQgcHJvZHVjZWQgb3B0aW1pemVk
IGJ1aWxkcyBieSBkZWZhdWx0LCBhbmQgDQp3ZSBjb3VsZCBoYXZlIGEgbmV3IC0tZW5hYmxl
LWRlYnVnLXVub3B0IGZvciB0aGUgIkkgbmVlZCB0byB1c2UgYSANCmRlYnVnZ2VyIiB1c2Ug
Y2FzZS4gV291bGQgc2F2ZSBhIGxvdCBvZiB0aW1lIGZvciBkZXZzLCBhbmQgaW4gQ0kgd2hl
cmUgDQptaW51dGVzIGFyZSBwcmVjaW91cy4NCg0KPiBZb3UgY2FuIHVzZSAtLWVuYWJsZS1k
ZWJ1Zy1pbmZvIGZvciBqdXN0IGRlYnVnIGluZm8gd2l0aG91dCB0aGUgb3ZlcmhlYWQuDQo+
IA0KPj4NCj4+PiB0aGFua3MNCj4+PiAtLSBQTU0NCj4gDQoNCg==


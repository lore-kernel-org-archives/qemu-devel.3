Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34D3E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW0zy-0005uX-FY; Thu, 09 Jan 2025 17:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW0zx-0005uJ-1S
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:27:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW0zr-0003rI-F5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:27:28 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166360285dso24143335ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736461641; x=1737066441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGOGiEHeUkmuyK4cQCDqwz8fW7U8JS1EjZkn0rCPU1o=;
 b=C7n1pXPoKhZE3AVyQ9T4xixxsRvVgrXxrpYJ3wfAY0ANdt9Ndrm3B9PSyIM6tiAgfX
 rbGyCyinacLSwBIXcMrJqeoKPJPPToPrlp/QuQLM2yLjtRDZ/+wP0h6pS+IUMyuZQJBN
 P+qvyYqqdc7lxGWVr2xHjYYTkp6t3TC3hOabvm14QVsj9qjX73fNECEuKqb7/vpg3I89
 4l2Hgnrql7Raj4wwjynUPdz2WtgCzQgsw1D4qAzAVQ8jgGcq2u8pDRT8wmCRrev6ZVjt
 PuwYdMXzmUnEIR0G1sWP0HCWMW25/xch99H+DyPH6HIuqWrcminyPMDuz75no6+Gcvlk
 VvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736461641; x=1737066441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGOGiEHeUkmuyK4cQCDqwz8fW7U8JS1EjZkn0rCPU1o=;
 b=cG/pw256iZB2UEP0s9yE3kVu5MlXYLovzN3nByfYkim7Uv86uhHvW7sU3gqqoD7ZdM
 4h1S5u/dT0VcupyB/bpPID4qwk1ph8xY9ld/I/2Irrujsa7UAEtDfq25ABQeHnWeQE9Y
 F0/cdunmfxldr1S6CCxIt6K6zUBcqXGq4tEixCc1XCJLxq8+KhWgzjoQXkMWwKXjKzl0
 OIV3cPEj73J7xtmU92wz1oS6UsNN0vGtPFMA9nu1nQjqecSeCdukMwWp1pT6ETINDqqy
 NNxJl6oUiBXT1QXW293Ulc8ekkTk3yMW1jISfDfMpawQdumesC2Gnol42jQZj0DFP+VW
 orDQ==
X-Gm-Message-State: AOJu0YzR9GoG8ySgf7TmLhs/hyR4LAHYXDSJG0MVy0aGSfRf2sR4WePn
 p+L4dPsOodHKuI62dnilyWXSnXec1i0QvSv6prXXNeAWA4glzHuuVqGQYwsZv+M=
X-Gm-Gg: ASbGncsPq1EdOAa0bpKEGKlWcNFY2nHM4M91drQ6tCWAKXcngkuC8DKosdp8fnVHvBA
 xu8P3dlLIChnPG892sufk7iGwNMw55Md/nmvCOoMzowAZGtCWKEEpvQd75z3io0TZ8D+tUbmBcs
 c2K1btxFqMpAICUPK5U0cNtCTL8XB1BfSqarsUeaKIEzYH3VG44dh9GpJbhRJJMBb48vcsoLhdL
 8RLvEWvF4WxbTcXVyhuFQxGDZvBrqoK6adfrqkQFwm9nZ1s6kFoRsmO3TV2vGHSurs7pA==
X-Google-Smtp-Source: AGHT+IHW2lMcoTLiXU25+4IDNv2RqVdJAaYB1jDWuLG+/Xj7vDHCbkUYJfYBxoaS3dioErx6tdlySg==
X-Received: by 2002:a17:902:ccca:b0:215:a434:b6ad with SMTP id
 d9443c01a7336-21a83f5f2e6mr126939545ad.33.1736461641432; 
 Thu, 09 Jan 2025 14:27:21 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f2538e8sm2592215ad.218.2025.01.09.14.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:27:20 -0800 (PST)
Message-ID: <86f60229-e76b-40d1-b8e2-2ad6c29c1194@linaro.org>
Date: Thu, 9 Jan 2025 14:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
 <87a5c06j7b.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87a5c06j7b.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gMS85LzI1IDA4OjMzLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+ICJKdWxpYW4gR2FueiIg
PG5laXRoZXJAbnV0LmVtYWlsPiB3cml0ZXM6DQo+IA0KPiAoQWRkIFJpY2hhcmQgdG8gQ0Mp
DQo+IA0KPj4gSGkgUGllcnJpY2ssDQo+Pg0KPj4gRGVjZW1iZXIgNSwgMjAyNCBhdCAxMjoz
MyBBTSwgIlBpZXJyaWNrIEJvdXZpZXIiIHdyb3RlOg0KPj4+IE9uIDEyLzIvMjQgMTE6NDEs
IEp1bGlhbiBHYW56IHdyb3RlOg0KPj4+PiAgICtzdGF0aWMgdm9pZCBpbnNuX2V4ZWModW5z
aWduZWQgaW50IHZjcHVfaW5kZXgsIHZvaWQgKnVzZXJkYXRhKQ0KPj4+PiAgICt7DQo+Pj4+
ICAgKyBzdHJ1Y3QgY3B1X3N0YXRlICpzdGF0ZSA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRf
ZmluZChzdGF0ZXMsIHZjcHVfaW5kZXgpOw0KPj4+PiAgICsgdWludDY0X3QgcGMgPSAodWlu
dDY0X3QpIHVzZXJkYXRhOw0KPj4+PiAgICsgR1N0cmluZyogcmVwb3J0Ow0KPj4+PiAgICsN
Cj4+Pj4gICArIGlmIChzdGF0ZS0+aGFzX25leHQpIHsNCj4+Pj4gICArIGlmIChzdGF0ZS0+
bmV4dF9wYyAhPSBwYykgew0KPj4+PiAgICsgcmVwb3J0ID0gZ19zdHJpbmdfbmV3KCJUcmFw
IHRhcmdldCBQQyBtaXNtYXRjaFxuIik7DQo+Pj4+ICAgKyBnX3N0cmluZ19hcHBlbmRfcHJp
bnRmKHJlcG9ydCwNCj4+Pj4gICArICJFeHBlY3RlZDogJSJQUkl4NjQiXG5FbmNvdW50ZXJl
ZDogJSINCj4+Pj4gICArIFBSSXg2NCJcbiIsDQo+Pj4+ICAgKyBzdGF0ZS0+bmV4dF9wYywg
cGMpOw0KPj4+PiAgICsgcWVtdV9wbHVnaW5fb3V0cyhyZXBvcnQtPnN0cik7DQo+Pj4+ICAg
KyBpZiAoYWJvcnRfb25fbWlzbWF0Y2gpIHsNCj4+Pj4gICArIGdfYWJvcnQoKTsNCj4+Pj4g
ICArIH0NCj4+Pj4gICArIGdfc3RyaW5nX2ZyZWUocmVwb3J0LCB0cnVlKTsNCj4+Pj4gICAr
IH0NCj4+Pj4gICArIHN0YXRlLT5oYXNfbmV4dCA9IGZhbHNlOw0KPj4+PiAgICsgfQ0KPj4+
PiAgICt9DQo+Pj4+DQo+Pj4gV2hlbiBib290aW5nIGFuIGFybTY0IHZtLCBJIGdldCB0aGlz
IG1lc3NhZ2U6DQo+Pj4gVHJhcCB0YXJnZXQgUEMgbWlzbWF0Y2gNCj4+PiBFeHBlY3RlZDog
MjNmYWYzYTgwDQo+Pj4gRW5jb3VudGVyZWQ6IDIzZmFmM2E4NA0KPj4NCj4+IEEgY29sbGVh
Z3VlIG9mIG1pbmUgd2VudCB0byBncmVhdCBsZW5ndGhzIHRyeWluZyB0byB0cmFjayBhbmQg
cmVsaWFibHkNCj4+IHJlcHJvZHVjZSB0aGlzLiBXZSB0aGluayB0aGF0IGl0J3Mgc29tZXRo
aW5nIGFtaXNzIHdpdGggdGhlIGV4aXN0aW5nDQo+PiBpbnN0cnVjdGlvbiBleGVjIGNhbGxi
YWNrIGluZnJhc3RydWN0dXJlLiBTby4uLiBpdCdzIG5vdCBzb21ldGhpbmcgSSdsbA0KPj4g
YmUgYWRkcmVzc2luZyB3aXRoIHRoZSBuZXh0IGl0ZXJhdGlvbiBhcyBpdCdzIG91dCBvZiBz
Y29wZS4gV2UnbGwNCj4+IHByb2JhYmx5IGNvbnRpbnVlIGxvb2tpbmcgaW50byBpdCwgdGhv
dWdoLg0KPj4NCj4+IFRoZSBtaXNtYXRjaCBpcyByZXBvcnRlZCBwZXJmZWN0bHkgbm9ybWFs
IGFuZCBib3JpbmcgZXhjZXB0aW9ucyBhbmQNCj4+IGludGVycnVwdHMgd2l0aCBubyBpbmRp
Y2F0aW9uIG9mIGFueSBkaWZmZXJlbmNlcyB0byBvdGhlciAobm90IHJlcG9ydGVkKQ0KPj4g
ZXZlbnRzIHRoYXQgZmlyZSBvbiBhIHJlZ3VsYXIgYmFzaXMuIEFwcGFyZW50bHksIG9uY2Ug
aW4gYSBibHVlIG1vb24NCj4+IChyZWxhdGl2ZWx5IHNwZWFraW5nKSwgZm9yIHRoZSBmaXJz
dCBpbnN0cnVjdGlvbiBvZiBhIGhhbmRsZXIgKGV2ZW4NCj4+IHRob3VnaCBpdCBpcyBkZWZp
bml0ZWx5IGV4ZWN1dGVkIGFuZCBxZW11IGRvZXMgcHJpbnQgYSB0cmFjZS1saW5lIGZvcg0K
Pj4gdGhhdCBpbnN0cnVjdGlvbik6DQo+Pg0KPj4gfCBUcmFjZSAwOiAweDdmZmZhMGIwMzkw
MCBbMDAxMDQwMDQvMDAwMDAwMDIzZmRlNzNiNC8wMDAwMDAyMS9mZjAyMDIwMF0NCj4+IHwg
VHJhY2UgMDogMHg3ZmZmYTAyZDk1ODAgWzAwMTA0MDA0LzAwMDAwMDAyM2ZkZTcyYjgvMDAw
MDAwMjEvZmYwMjAyMDBdDQo+PiB8IFRyYWNlIDA6IDB4N2ZmZmEwMmRmYzQwIFswMDEwNDAw
NC8wMDAwMDAwMjNmZGU3MzM4LzAwMDAwMDIxL2ZmMDIwMjAwXQ0KPj4gfCBUcmFjZSAwOiAw
eDdmZmZhMGIwM2QwMCBbMDAxMDQwMDQvMDAwMDAwMDIzZmRlNzNkNC8wMDAwMDAyMS9mZjAy
MDIwMF0NCj4+IHwgVHJhY2UgMDogMHg3ZmZmYTBiMDNlODAgWzAwMTA0MDA0LzAwMDAwMDAy
M2ZkZTczZDgvMDAwMDAwMjEvZmYwMjAyMDBdDQo+PiB8IFRyYWNlIDA6IDB4N2ZmZmEwYjA0
MTQwIFswMDEwNDAwNC8wMDAwMDAwMjNmZGU3NDA4LzAwMDAwMDIxL2ZmMDIwMjAwXQ0KPj4g
fCBUcmFjZSAwOiAweDdmZmZhMDJkZDZjMCBbMDAxMDQwMDQvMDAwMDAwMDIzZmRlNzBiOC8w
MDAwMDAyMS9mZjAyMDIwMF0NCj4+IHwgVHJhY2UgMDogMHg3ZmZmYTAyZGQ4MDAgWzAwMTA0
MDA0LzAwMDAwMDAyM2ZkZTdiOTAvMDAwMDAwMjEvZmYwMjAyMDBdDQo+PiB8IGNwdV9pb19y
ZWNvbXBpbGU6IHJld291bmQgZXhlY3V0aW9uIG9mIFRCIHRvIDAwMDAwMDAyM2ZkZTdiOTAN
Cj4gDQo+IFNvIHRoaXMgaGFwcGVucyB3aGVuIGFuIGluc3RydWN0aW9uIHRoYXQgaXMgbm90
IHRoZSBsYXN0IGluc3RydWN0aW9uIG9mDQo+IHRoZSBibG9jayBkb2VzIHNvbWUgSU8uIEFz
IElPIGFjY2Vzc2VzIGNhbiBwb3RlbnRpYWxseSBjaGFuZ2Ugc3lzdGVtDQo+IHN0YXRlIHdl
IGNhbid0IGFsbG93IG1vcmUgaW5zdHJ1Y3Rpb25zIHRvIHJ1biBpbiB0aGUgYmxvY2sgdGhh
dCBtaWdodA0KPiBub3QgaGF2ZSB0aGF0IGNoYW5nZSBvZiBzdGF0ZSBjYXB0dXJlZA0KPiAN
Cj4gY3B1X2lvX3JlY29tcGlsZSBleGl0cyB0aGUgbG9vcCBhbmQgZm9yY2VzIHRoZSBuZXh0
IFRyYW5zbGF0aW9uQmxvY2sgdG8NCj4gYmUgb25seSBvbmUgKG9yIG1heWJlIHR3byBpbnN0
cnVjdGlvbnMpLiBXZSBoYXZlIHRvIHBsYXkgZ2FtZXMgd2l0aA0KPiBpbnN0cnVtZW50YXRp
b24gdG8gYXZvaWQgZG91YmxlIGNvdW50aW5nIGV4ZWN1dGlvbjoNCj4gDQo+ICAgICAgLyoN
Cj4gICAgICAgKiBFeGl0IHRoZSBsb29wIGFuZCBwb3RlbnRpYWxseSBnZW5lcmF0ZSBhIG5l
dyBUQiBleGVjdXRpbmcgdGhlDQo+ICAgICAgICoganVzdCB0aGUgSS9PIGluc25zLiBXZSBh
bHNvIGxpbWl0IGluc3RydW1lbnRhdGlvbiB0byBtZW1vcnkNCj4gICAgICAgKiBvcGVyYXRp
b25zIG9ubHkgKHdoaWNoIGV4ZWN1dGUgYWZ0ZXIgY29tcGxldGlvbikgc28gd2UgZG9uJ3QN
Cj4gICAgICAgKiBkb3VibGUgaW5zdHJ1bWVudCB0aGUgaW5zdHJ1Y3Rpb24uDQo+ICAgICAg
ICovDQo+ICAgICAgY3B1LT5jZmxhZ3NfbmV4dF90YiA9IGN1cnJfY2ZsYWdzKGNwdSkgfCBD
Rl9NRU1JX09OTFkgfCBuOw0KPiANCj4gVGhlIGluc3RydWN0aW9uIGlzIGluIGEgd2VpcmQg
c3RhdGUgaGF2aW5nIGJvdGggZXhlY3V0ZWQgKGZyb20gdGhlDQo+IHBsdWdpbiBwb2ludCBv
ZiB2aWV3KSBidXQgbm90IGNoYW5nZWQgYW55IHN0YXRlIChzdG9wcGVkIGZyb20gZG9pbmcg
TU1JTw0KPiB1bnRpbCB0aGUgbmV4dCBpbnN0cnVjdGlvbikuDQo+IA0KPj4gfCBUYWtpbmcg
ZXhjZXB0aW9uIDUgW0lSUV0gb24gQ1BVIDANCj4+IHwgLi4uZnJvbSBFTDEgdG8gRUwxDQo+
PiB8IC4uLndpdGggRVNSIDB4MC8weDM4MDAwMDANCj4+IHwgLi4ud2l0aCBTUFNSIDB4MjAw
MDAzMDUNCj4+IHwgLi4ud2l0aCBFTFIgMHgyM2ZkZTdiOTANCj4+IHwgLi4udG8gRUwxIFBD
IDB4MjNmZDc3YTgwIFBTVEFURSAweDIzYzUNCj4gDQo+IEkgZ3Vlc3MgYmVmb3JlIHdlIHJl
LWV4ZWN1dGVkIHRoZSBuZXcgYmxvY2sgYW4gYXN5bmNocm9ub3VzIGludGVycnVwdA0KPiBj
YW1lIGluPw0KPiANCj4gRG9lcyBjaGFuZ2luZyB0aGUgYWJvdmUgdG86DQo+IA0KPiAgICBj
cHUtPmNmbGFnc19uZXh0X3RiID0gY3Vycl9jZmxhZ3MoY3B1KSB8IENGX01FTUlfT05MWSB8
IENGX05PSVJRIHwgbjsNCj4gDQo+IG1ha2UgdGhlIHByb2JsZW0gZ28gYXdheT8gSXQgc2hv
dWxkIGVuc3VyZSB0aGUgbmV4dCAxLzIgaW5zdHJ1Y3Rpb24NCj4gYmxvY2sgZXhlY3V0ZSB3
aXRob3V0IGNoZWNraW5nIGZvciBhc3luYyBldmVudHMuIFNlZSBnZW5fdGJfc3RhcnQoKSBm
b3INCj4gdGhlIGdvcnkgZGV0YWlscy4NCj4gDQoNClRoYW5rcywgaXQgc29sdmVzIHRoZSBw
cm9ibGVtIGluZGVlZC4NCkkgd2FzIG5vdCBzdXJlIHdoeSB0aGlzIHNwZWNpZmljIGJsb2Nr
IHdhcyByZWV4ZWN1dGVkIGluIHRoZSBjYXNlIG9mIGFuIElSUS4NCg0KPj4gfCBUcmFjZSAw
OiAweDdmZmZhMTNhODM0MCBbMDAxMDQwMDQvMDAwMDAwMDIzZmQ3N2E4MC8wMDAwMDAyMS9m
ZjAyMTIwMV0NCj4+IHwgVHJhY2UgMDogMHg3ZmZmYTEzYTg0ODAgWzAwMTA0MDA0LzAwMDAw
MDAyM2ZkNzdhODQvMDAwMDAwMjEvZmYwMjAyMDBdDQo+PiB8IFRyYXAgdGFyZ2V0IFBDIG1p
c21hdGNoIENQVSAwDQo+PiB8IEV4cGVjdGVkOiAgICAyM2ZkNzdhODANCj4+IHwgRW5jb3Vu
dGVyZWQ6IDIzZmQ3N2E4NA0KPj4gfCB3YXJuaW5nOiA0NAkuL25wdGwvcHRocmVhZF9raWxs
LmM6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4+IHwgQ291bGRuJ3QgZ2V0IHJlZ2lz
dGVyczogTm8gc3VjaCBwcm9jZXNzLg0KPj4NCj4+IEl0IGRvZXMgc2hvdyB1cCB3aXRoIGJv
dGggc2luZ2xlLWNvcmUgYW5kIG11bHRpLWNvcmUgVk1zLCBzbyB0aGF0IGF0DQo+PiBsZWFz
dCBlbGltaW5hdGVzIHNvbWUgcG9zc2liaWxpdGllcy4gTWF5YmUgOi8NCj4+DQo+PiBUaGUg
aXNzdWUgaXMgbmFzdHkgdG8gcmVwcm9kdWNlIGluIGEgd2F5IHRoYXQgYWxsb3dzIGFueSBt
ZWFuaW5nZnVsDQo+PiBpbnZlc3RpZ2F0aW9uLiBJdCB1c3VhbGx5IGludm9sdmVzIHNpZnRp
bmcgdGhyb3VnaCBtYW55IEdCcyBvZiBRZW11IGxvZ3MNCj4+IGZvciBtYXliZSBvbmUgb2Nj
dXJhbmNlLiBXZSBjb3VsZCBhZGQgYW5vdGhlciB0ZXN0aW5nL2R1bW15IHBsdWdpbiB0aGF0
DQo+PiBqdXN0IHByaW50cyB0aGUgUEMgZm9yIF9hbnlfIGluc3RydWN0aW9uIGV4ZWN1dGVk
IGFuZCBoYXZlIGEgc2tyaXB0DQo+PiBjaGVjayBmb3Igbm9uLWFsdGVybmF0aW5nIFRyYWNl
LWxpbmVzIGZyb20gUWVtdSBhbmQgdGhhdCBQbHVnaW4uIEJ1dA0KPj4gdGhlbiB3ZSdyZSB0
YWxraW5nIG5lYXJseSBkb3VibGUgdGhlIGFtb3VudCBvZiBMaW5lcyB0byBsb29rIHRocm91
Z2gNCj4+IHdpdGggcHJvYmFibHkgbGl0dGxlIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+
Pg0KPj4gUmVnYXJkcywNCj4+IEp1bGlhbg0KPiANCg0K


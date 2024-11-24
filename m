Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE5E6780A
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 20:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFJA2-0003fB-Ee; Sun, 24 Nov 2024 15:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFJA0-0003cK-4x
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 15:24:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFJ9x-0000kA-FB
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 15:24:46 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso2838771f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732479883; x=1733084683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ySifidxIfGNwfPX42w3vvTQ59tD9aEwxVzH1Ky4J9UE=;
 b=prC3ex9RewXm2sdJq8r2e0ja5xHBUx+bBvxEHRBQqut16lPxXjyPupWy/LZw4Ly/SZ
 hnKZ8/cJ97jj3GV8Qxi/7P2xNEbr/N+nKwIg4AJQzo2TuQ9VVh4+/ellUxNyXhpnFudL
 MOmpgQcgYABKkhEbjL9YAiZTx80ripaUXg+tLMcDKFPqNVWaxE+Kf3a51ye9OT1H63Aa
 ueRkZpb1Nya9850jpolxERbSG2IiR09ZQtBu6hRV+LP1aXw96GTBP8h+y7wAKEpnmWvZ
 DxzmcN4i+4iT8c5bH/ZXrN4SCg8MhyLnu+yq4nUf/mY2n0aDBLprUE5+o38BbnpCRBnp
 qdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732479883; x=1733084683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySifidxIfGNwfPX42w3vvTQ59tD9aEwxVzH1Ky4J9UE=;
 b=o7FCjIxGtSrYaOkeuuA+Opg8gIWUPukTOgee5qykCNjJNXx/HQRXfMu+ewHmHfDguG
 j/3txOtPLR/Fg7nEaq1K/PhbcNgOlnqdWiAyuSBBBO5Ztsn/ncV0IRPjCopW3cOhCOKk
 8ueS+aKknGrW4i90iK+fHi5EBH8EOfWmwPAC50K9vf0wNOIsmIFKxr9JVG4rtQHg2Ur5
 zlhMsrxIM/msnxNy43LU9C8WXkeKqGncGIGhyxX4uIwTojPF7N4C+Z/uhgRqHwlkRDI5
 TKtp4KMHHX5NM6h7PFGYC77BjQHhLtW8GMPscO6lWBYBIwNAl12GzYfrpFOaqAv38+Lm
 yFMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQwXJenaySCyIamiN9RIj8VjOLwCtjsC4LTos5/pakSBSjXjWaEDqO8MVS8rlRdnZ5xZIMLTVnxVZ8@nongnu.org
X-Gm-Message-State: AOJu0Yz5EYmcmAMU2FG+GcNJ956NkrK6PnsXmqbJ2aJj131MXiSmGaAi
 ZXuGLMbOXIAXlLYHapuU2gf5T0VB2q55IRVLqNSGTyepeXfEpToEqUwOUH55ZfY=
X-Gm-Gg: ASbGnctZp+/FE9sdAkC8trSKT7m+G8qB9b7YYXrpCvz8P9udGx+mQph7jmQ5SJSPHj/
 9s4Zc1MOMSl8GZEJEJmU4SHJ36M4ukIJW+svvm/86wis93hsLMKpMNqMTUe5nRnmHRZEmuwBTQL
 ipVLZjOHlXGkTQY6KLcWXCBS/8rVcjEPhfGKc4wflSF94VKiA0u5thldIuBJXdVWh7HUlNbyKgJ
 axpOKZ+At0UlQHnWWAqRQ4qWRlBhc6LKdNW5xLEagDwxdUXfz8lgd68cb4zMmWzmQ==
X-Google-Smtp-Source: AGHT+IFnCxD/k+sdqAZXeD1m95nULUHcmPW9t/HNDT1D7fM9W3/o8wynejQCKMcv0TxDdjNyygLkQw==
X-Received: by 2002:a5d:6c69:0:b0:382:31ca:4dca with SMTP id
 ffacd0b85a97d-38260b4d679mr8167011f8f.7.1732479882594; 
 Sun, 24 Nov 2024 12:24:42 -0800 (PST)
Received: from [10.150.212.240] ([95.173.222.38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432f64e7e12sm124577565e9.2.2024.11.24.12.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 12:24:42 -0800 (PST)
Message-ID: <4220b050-e29a-461d-85b7-93a335a96e4d@linaro.org>
Date: Sun, 24 Nov 2024 12:24:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <ae79e5a8-d875-41c5-ace0-911be633d8c5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ae79e5a8-d875-41c5-ace0-911be633d8c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42b.google.com
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

T24gMTEvMjQvMjQgMDQ6MjgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAyNC8xMS8yNCAwMToyMSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IEhpIGFsbCwN
Cj4gDQo+IA0KPj4gQWZ0ZXIgdGhpbmtpbmcgYWJvdXQgaXQsIGEgc2ltcGxlLCBleGhhdXN0
aXZlIGFuZCByZWxpYWJsZSB3YXkgdG8gZmluZA0KPj4gdGhpcyB0eXBlIGluZm9ybWF0aW9u
IGlzIHRoZSBkZWJ1ZyAoZHdhcmYpIGluZm8uDQo+PiBCeSBjb21waWxpbmcgcWVtdSBiaW5h
cmllcyB3aXRoIC0tZW5hYmxlLWRlYnVnLCBhbmQgZXh0cmFjdGluZyBpbmZvDQo+PiB1c2lu
ZyBsbHZtLWR3YXJmZHVtcCBwbHVzIGEgY3VzdG9tIGZpbHRlciBbNF0sIHdlIGNhbiBvYnRh
aW4gYSB0ZXh0DQo+PiByZXByZXNlbnRhdGlvbiBvZiBhbGwgc3RydWN0dXJlcyBRRU1VIHVz
ZXMuDQo+Pg0KPj4gQXMgZXhwZWN0ZWQsIHR1cm5pbmcgdGhlIG9wdGlvbiBnbG9iYWxseSBo
YXMgYW4gZWZmZWN0LiBUaGUgZXhhY3QgbGlzdA0KPj4gb2Ygc3RydWN0dXJlcyBpbXBhY3Rl
ZCAodGhvc2UgaGF2aW5nIGJpdGZpZWxkcywgYW5kIG5vdCBiZWluZyBwYWNrZWQpDQo+PiBj
YW4gYmUgc2VlbiBmb3IgZWFjaCBiaW5hcnkgaGVyZTogWzVdLg0KPj4gQXMgdGhlcmUgaXMg
YSBsb3Qgb2YgcmVwZXRpdGlvbiBiZXR3ZWVuIGFsbCBxZW11IGJpbmFyaWVzLCB0aGUgcmVk
dWNlZA0KPj4gbGlzdCBvZiBzdHJ1Y3RzIGNvbmNlcm5lZCBpcyBbNl06DQo+PiArbmFtZTpB
cmR1aW5vTWFjaGluZUNsYXNzIHNpemU6MHgwMTk4DQo+PiArbmFtZTpBUk1DYWNoZUF0dHJz
IHNpemU6MHgwNA0KPj4gK25hbWU6QVJNVkFQYXJhbWV0ZXJzIHNpemU6MHgwNA0KPj4gK25h
bWU6QXNwZWVkTWFjaGluZUNsYXNzIHNpemU6MHgwMWQwDQo+PiArbmFtZTpfR0lPQ2hhbm5l
bCBzaXplOjB4NzANCj4+ICtuYW1lOk1hY2hpbmVDbGFzcyBzaXplOjB4MDE4OA0KPj4gK25h
bWU6TWljcm92bU1hY2hpbmVDbGFzcyBzaXplOjB4MDFhMA0KPj4gK25hbWU6TVBTMk1hY2hp
bmVDbGFzcyBzaXplOjB4MDFhOA0KPj4gK25hbWU6TVBTMlRaTWFjaGluZUNsYXNzIHNpemU6
MHgwMWU4DQo+PiArbmFtZTpNUFMzUk1hY2hpbmVDbGFzcyBzaXplOjB4MDFhMA0KPj4gK25h
bWU6TXVzY2FNYWNoaW5lQ2xhc3Mgc2l6ZToweDAxYTgNCj4+ICtuYW1lOk5QQ003eHhNYWNo
aW5lQ2xhc3Mgc2l6ZToweDAxOTANCj4+ICtuYW1lOlBDTWFjaGluZUNsYXNzIHNpemU6MHgw
MWMwDQo+PiArbmFtZTpQbnZNYWNoaW5lQ2xhc3Mgc2l6ZToweDAxYjANCj4+ICtuYW1lOlBQ
Q0U1MDBNYWNoaW5lQ2xhc3Mgc2l6ZToweDAxZTANCj4+ICtuYW1lOlJhc3BpQmFzZU1hY2hp
bmVDbGFzcyBzaXplOjB4MDE5MA0KPj4gK25hbWU6UnhHZGJTaW1NYWNoaW5lQ2xhc3Mgc2l6
ZToweDAxOTgNCj4+ICtuYW1lOlMzOTBDY3dNYWNoaW5lQ2xhc3Mgc2l6ZToweDAxOTANCj4+
ICtuYW1lOlNwYXByTWFjaGluZUNsYXNzIHNpemU6MHgwMWQwDQo+PiArbmFtZTpTdW40bU1h
Y2hpbmVDbGFzcyBzaXplOjB4MDE5MA0KPj4gK25hbWU6VHJpQm9hcmRNYWNoaW5lQ2xhc3Mg
c2l6ZToweDAxYTANCj4+ICtuYW1lOlZleHByZXNzTWFjaGluZUNsYXNzIHNpemU6MHgwMTkw
DQo+PiArbmFtZTpWaXJ0TWFjaGluZUNsYXNzIHNpemU6MHgwMWEwDQo+PiArbmFtZTpYODZN
YWNoaW5lQ2xhc3Mgc2l6ZToweDAxOTANCj4gDQo+IFRoZSAqTWFjaGluZUNsYXNzIG9uZXMg
Y29tZSBmcm9tIFsqXToNCj4gDQo+ICAgICBzdHJ1Y3QgTWFjaGluZUNsYXNzIHsNCj4gICAg
ICAgICAuLi4NCj4gICAgICAgICB1bnNpZ25lZCBpbnQgbm9fc2VyaWFsOjEsDQo+ICAgICAg
ICAgICAgIG5vX3BhcmFsbGVsOjEsDQo+ICAgICAgICAgICAgIG5vX2Zsb3BweToxLA0KPiAg
ICAgICAgICAgICBub19jZHJvbToxLA0KPiAgICAgICAgICAgICBub19zZGNhcmQ6MSwNCj4g
ICAgICAgICAgICAgcGNpX2FsbG93XzBfYWRkcmVzczoxLA0KPiAgICAgICAgICAgICBsZWdh
Y3lfZndfY2ZnX29yZGVyOjE7DQo+IA0KPiBJTUhPIFVzaW5nIGJpdGZpZWxkIHRvIG1hbnVh
bGx5IG1pY3JvLW9wdGltaXplIG1lbW9yeSBzaXplIHNlZW1zDQo+IGEgYml0IGEgd2FzdGUg
b2YgZGV2ZWxvcGVyIHRpbWUvZm9jdXMsIEknZCByYXRoZXIgc2VlIGNvbXBpbGVycw0KPiBk
b2luZyB0aGF0IGZvciB1cy4NCj4gDQoNClllcywgaXQncyAoYW5vdGhlcikgbGVzc29uIHRo
YXQgQyBiaXRmaWVsZHMgYXJlIGEgZ29vZCBzeW5vbnltIG9mIG5vbiANCnBvcnRhYmxlIGNv
ZGUgaW4gZ2VuZXJhbC4NCg0KPiBSZWdhcmRzLA0KPiANCj4gUGhpbC4NCj4gDQo+IFsqXSBJ
bnRlcmVzdGluZ2x5IFRob21hcyBpcyBhbHNvIGxvb2tpbmcgYXQgdGhvc2UgZmllbGRzOg0K
PiAgIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMTIyMDg0
OTIzLjE1NDI3NDMtMS10aHV0aEByZWRoYXQuY29tLw0KDQo=


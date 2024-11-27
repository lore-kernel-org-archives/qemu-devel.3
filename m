Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41207D6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGN27-0003oR-SC; Wed, 27 Nov 2024 13:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGN24-0003ni-ND
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:45:00 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGN20-0000Fn-K5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:45:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2120f9ec28eso729365ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 10:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732733095; x=1733337895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zCL2V3DDMeW4inpoAOXJZoMOvH8FuT8TY1UyyUP0go=;
 b=O+IBk7HDAaUC2g/orTKsWvoROsfYBFM+t9IVf8v2/EgeCE9n1IZ9aeIoniEcYmFuIF
 n/D8u5GtHdZlzdKKotfbFsqn6XLKcZTFA7qiXUU5G4dC/f9tBJBYqDEWviB279JAPjBq
 c++BOC0c7srcScySKK9zSfrWF/I0Ry0MbgFtYqwvrgHZfjxDa29+HT4yYeaz/65vwyYL
 wZp79fOu4m5PYiYqjP9Gm5WtloSLiRMtuDthmXalAwSJMxqdR3cnExBrsF437Y5Ur8lU
 R6LtwRuRMKvg4Gd+B5zirBLi4+ceW5WktEEb0r5G6K0J2T7csBy5EOU+t4DtBzKzLpmJ
 zcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732733095; x=1733337895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zCL2V3DDMeW4inpoAOXJZoMOvH8FuT8TY1UyyUP0go=;
 b=Q+5dBXV5SQgOZMYj68mon0ybGuFOrMUgMelFgcEh4LRpzHItQ6njVhd1mORcpL8PC/
 /JIQu3nxwUSIhvT5b9kKPAwOPVuWe29InHyLu4u1UCsjY3o/8z9hK6qnyPd2keaHcEDQ
 QVleGqYpAGqF53q7iT0p9dWIpFKaZFTjOEPiIPS0TjO/+AHIv4+Hnu+V5/OYZlx5OqzC
 L2MCqcqhZA8XShLSkKyeNgnJDLRMw29jkHg3cvqPGP/aFpydl7EJMZmCWTrSRcur24o1
 FVL2TNiwjcQbKpQG2p+Jerq74dZhbV5NbSJOZRgTsLHavpOyWpGoR/LQvF01kJ19Vs71
 R4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ButIRff1n1V5wXkIdhQ8MpYjpETRrz359U06iQvBodxIWADpnKyhFhmYzUZB1U8stPYtl4owHgl8@nongnu.org
X-Gm-Message-State: AOJu0Yze5H5zg+o5C800hvSxU2JnV6nV50/B7IsE05ki/dwExG67dF1k
 RMi8AkP2Kcc+6YktTaYG6k3WkNfiafn9HZ6H9Jc+LE+VrMyuy+uro7vKYuUmpIQ=
X-Gm-Gg: ASbGnct7FSTDkLxZbSv84uRKkec6USzW/I0CvVGd00Po6U2hzZaaPA+bycFgwe+CH7f
 pAqtEWssAowX0Gr4mg2EnLuHiXEqIbre/EFPzr0jEPAX7AQFNsExkIlQZbOyQPqpxBLj3WaUMKT
 A96bmiRkRaliHVcNdIC9S69w7DcvTb7+qoy2I9q9Tl30sOGVSRgUgFyShRs5yPx6srqaWPi3X/S
 1BI1lCKRLYYYuiCb/CRZD4N1hzG76ZfEr3H54gz82LB5TxuRLXrj0rjUIHjSLHlv380DgWW4MLk
 lSbmdhHCFiU/vN8j/sC+aQ==
X-Google-Smtp-Source: AGHT+IEbqmfV0IkdbuQTYLZEjnxb5P3TpDf6RZ7gJfUFoJ2C/+OZZ1aPQviqHWCcYtkw4Rgi95zBSg==
X-Received: by 2002:a17:902:f541:b0:212:9ac9:e3e2 with SMTP id
 d9443c01a7336-2151d32fa20mr6228045ad.14.1732733094672; 
 Wed, 27 Nov 2024 10:44:54 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129db8793asm105959665ad.26.2024.11.27.10.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 10:44:54 -0800 (PST)
Message-ID: <49cc1e5e-dd62-475e-b483-c2897c829529@linaro.org>
Date: Wed, 27 Nov 2024 10:44:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Content-Language: en-US
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241113094342.282676-2-frolov@swemel.ru>
 <Z0YUMoPr0oyQhqqK@redhat.com>
 <04edda40-32d2-43e0-8ade-a4b2a3e06eab@swemel.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <04edda40-32d2-43e0-8ade-a4b2a3e06eab@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMTEvMjYvMjQgMjM6NDAsINCU0LzQuNGC0YDQuNC5INCk0YDQvtC70L7QsiB3cm90ZToN
Cj4gSGVsbG8sIERhbmllbA0KPiANCj4gT24gMjYuMTEuMjAyNCAyMTozMiwgRGFuaWVsIFAu
IEJlcnJhbmfDqSB3cm90ZToNCj4+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0IDEyOjQzOjQw
UE0gKzAzMDAsIERtaXRyeSBGcm9sb3Ygd3JvdGU6DQo+Pj4gU29tZSB0ZXN0cyBuZWVkIG1v
cmUgdGltZSB3aGVuIHFlbXUgaXMgYnVpbHQgd2l0aA0KPj4+ICItLWVuYWJsZS1hc2FuIC0t
ZW5hYmxlLXVic2FuIg0KPj4+DQo+Pj4gQXMgd2FzIGRpc2N1c3NlZCBoZXJlOg0KPj4+IGh0
dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI0MTExMjEyMDEwMC4xNzY0OTItMi1mcm9sb3ZA
c3dlbWVsLnIvdQ0KPj4+DQo+Pj4gVElNRU9VVF9NVUxUSVBMSUVSIGVudmlyb21lbnQgdmFy
aWFibGUgd2lsbCBiZQ0KPj4+IGEgdXNlZnVsIG9wdGlvbiwgYWxsb3dpbmcgbm9uLWludmFz
aXZlIHRpbWVvdXRzDQo+Pj4gaW5jcmVhc2luZyBmb3IgYSBzcGVjaWZpYyBidWlsZC4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBGcm9sb3YgPGZyb2xvdkBzd2VtZWwucnU+
DQo+Pj4gLS0tDQo+Pj4gICAgc2NyaXB0cy9tdGVzdDJtYWtlLnB5IHwgMiArKw0KPj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9zY3JpcHRzL210ZXN0Mm1ha2UucHkgYi9zY3JpcHRzL210ZXN0Mm1ha2UucHkNCj4+PiBp
bmRleCBlYjAxYTA1ZGRiLi5mZjYwYjYyNzI0IDEwMDY0NA0KPj4+IC0tLSBhL3NjcmlwdHMv
bXRlc3QybWFrZS5weQ0KPj4+ICsrKyBiL3NjcmlwdHMvbXRlc3QybWFrZS5weQ0KPj4+IEBA
IC0yNyw3ICsyNyw5IEBAIGRlZiBuYW1lcyhzZWxmLCBiYXNlKToNCj4+PiAgICAuc3BlZWQu
c2xvdyA9ICQoZm9yZWFjaCBzLCQoc29ydCAkKGZpbHRlci1vdXQgJS10aG9yb3VnaCwgJDEp
KSwgLS1zdWl0ZSAkcykNCj4+PiAgICAuc3BlZWQudGhvcm91Z2ggPSAkKGZvcmVhY2ggcywk
KHNvcnQgJDEpLCAtLXN1aXRlICRzKQ0KPj4+ICAgIA0KPj4+ICtpZm5kZWYgVElNRU9VVF9N
VUxUSVBMSUVSDQo+Pj4gICAgVElNRU9VVF9NVUxUSVBMSUVSID0gMQ0KPj4+ICtlbmRpZg0K
Pj4gQ2FuIHlvdSBleHBsYWluIHdoYXQgc2NlbmFyaW8gdGhpcyBpcyBuZWVkZWQgZm9yLCBh
cyB1bmxlc3MgSSdtDQo+PiBtaXNzaW5nIHNvbWV0aGluZyB0aGlzIGNoYW5nZSBoYXMgbm8g
cHVycG9zZS4gVGhpcyBhc3NpZ25tZW50IGlzDQo+PiBtZXJlbHkgZGVmaW5pbmcgdGhlIGRl
ZmFsdCB2YWx1ZSwgd2hpY2ggY2FuIGFscmVhZHkgYmUgb3ZlcnJpZGRlbg0KPj4gYXQgcnVu
dGltZSB3aXRob3V0IHRoaXMgJ2lmbmRlZicNCj4+DQo+PiBlZw0KPj4NCj4+ICQgbWFrZSBj
aGVjay11bml0IFRJTUVPVVRfTVVMVElQTElFUj03DQo+Pg0KPj4gSW4gYW5vdGhlciBzaGVs
bDoNCj4+DQo+PiAkIHBzIC1heHV3d2YgfCBncmVwICdtZXNvbiB0ZXN0Jw0KPj4gYmVycmFu
Z2UgMTkzMTY1NyAgMy45ICAwLjEgMzMwOTA0IDk5MzQ0IHB0cy8xICAgIFMrICAgMTg6Mjkg
ICAwOjAwICAgICAgICAgICAgICAgICAgXF8gL3Zhci9ob21lL2JlcnJhbmdlL3NyYy92aXJ0
L3FlbXUvYnVpbGQvcHl2ZW52L2Jpbi9weXRob24zIC92YXIvaG9tZS9iZXJyYW5nZS9zcmMv
dmlydC9xZW11L2J1aWxkL3B5dmVudi9iaW4vbWVzb24gdGVzdCAtLW5vLXJlYnVpbGQgLXQg
NyAtLW51bS1wcm9jZXNzZXMgMSAtLXByaW50LWVycm9ybG9ncyAtLXN1aXRlIHVuaXQNCj4+
DQo+PiBzaG93cyBUSU1FT1VUX01VTFRJUExJRVIgYmVpbmcgaG9ub3VyZWQNCj4gWWVhaC4u
LiBZb3UgYXJlIHJpZ2h0IQ0KPiBJdCBpcyBwb3NzaWJsZSB0byBzZXQgVElNRU9VVF9NVUxU
SVBMSUVSIG9ubHkgdG8gcnVuIHRlc3RzLg0KPiBJdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHNl
dCBpdCBmb3IgdGhlIHdob2xlIGJ1aWxkLg0KPiANCj4gU29ycnksIGFuZCB0aGFua3MgYSBs
b3QhDQo+Pg0KPj4NCj4+IFdpdGggcmVnYXJkcywNCj4+IERhbmllbA0KPiByZWdhcmRzLA0K
PiBEbWl0cnkNCj4gDQoNClRoaXMgcGF0Y2ggaXMgc3RpbGwgdXNlZnVsIGlmIHdlIHdhbnQg
dG8gc2V0IFRJTUVPVVRfTVVMVElQTElFUiBhcyANCmdsb2JhbCBlbnYgdmFyaWFibGUsIGFu
ZCBub3QgZXhwbGljaXRlbHkgb24gZWFjaCBtYWtlIGludm9jYXRpb24uDQo=


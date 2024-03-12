Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E713C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 06:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvEy-0002cG-Ef; Tue, 12 Mar 2024 02:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjvEu-0002bb-SH
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:03:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjvEr-00025w-T7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:03:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e7ae72312so3234029f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 23:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710223426; x=1710828226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEOtTxTKxg85esuTz7jcj45Ytw6I/5CMlOpI5vm2kUk=;
 b=vGpBAx0C25jwFdAjr7GOzUGmj359aCYpYOh82aDAQmt+xrVt4tQGCYd/GCFhKDWxD8
 fFmAzIhvWQZ5f3kvgHwp4g9dqyVyjTs6/2kj7mImb14KTkCG0po4feXa3KwkLQiY8tXQ
 lpB7VpPPDSvdFvKX8e/QkY3bEafH8XNt5l33fNeySo7atRKRRtqw5yv80sVoa+5FkGVl
 r4XcMz3WzyrGryBwtdwYeXF+zZy2IKs3W5rRbzXgNDxVEiyOi5Zr4/t6hpQoaUamIPDF
 oSsI/LtK2llIySgYiXtflbM9y5T0+IH9B9DIQbCfoHYVZlePvUdVgYPIm1PPzHK9XJ0R
 HPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710223426; x=1710828226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEOtTxTKxg85esuTz7jcj45Ytw6I/5CMlOpI5vm2kUk=;
 b=qn05PXB8pYy1GzUdHtLe0CLu/Ye61/iti3/3LAkGZlRafae5fhZIUS8TkxpGVhAg0O
 ew+fWqBVfEYSbBY1nFWFnTUeeRBRDOufY7uU3L2aau9PJNRf7RTIrqZ+VIvmQMiVPyPf
 VavZxzJWfqJHSsmmEwCICHKAr71xPLoXu8/PXTkdRqyYzRIDdzPDlhmonfXWohvaEz2w
 l3CDBXqAdKH8nB3eR429L8tRo0K12oVs5hQ2fC2jldd9vd1cRB92ny+3PdSM0PRocE9R
 6Dwl3wqX9f2pP0Z6DlRS70BZ+eu5Lu83ZNCBnw30zXy7ig3Eksl4kk45d9lHcc9bwe1f
 lwlA==
X-Gm-Message-State: AOJu0YyubvGdAbAEJiuvg9vXtn2xYIRXmCTh2R32xHosgMYzQZsWD8C9
 HeMVM/RzLn9G4VrXBjynPLnW18vMOZj2zxFF42Met3mpZijkvVTZL8t//QmY0Ck=
X-Google-Smtp-Source: AGHT+IGOG0kikLqWZoNP3uiwtwr4PjRh5Wf8Rd6/NGdPMEaNgtDRHxDKDOACmj1A+Co7SXQg1xoP8w==
X-Received: by 2002:adf:eac2:0:b0:33e:7896:a9d7 with SMTP id
 o2-20020adfeac2000000b0033e7896a9d7mr7207778wrn.67.1710223425597; 
 Mon, 11 Mar 2024 23:03:45 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c11-20020adfe70b000000b0033e41e1ad93sm8112889wrm.57.2024.03.11.23.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 23:03:45 -0700 (PDT)
Message-ID: <595d141e-67d7-46c0-8471-fc52f2d4af0f@linaro.org>
Date: Tue, 12 Mar 2024 10:03:43 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
 <87zfv4pydu.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87zfv4pydu.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMy8xMS8yNCAxOTo0MywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBFeHRl
bmQgcGx1Z2lucyBBUEkgdG8gc3VwcG9ydCBjYWxsYmFjayBjYWxsZWQgd2l0aCBhIGdpdmVu
IGNyaXRlcmlhDQo+PiAoZXZhbHVhdGVkIGlubGluZSkuDQo+Pg0KPj4gQWRkZWQgZnVuY3Rp
b25zOg0KPj4gLSBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNfY29uZF9jYg0K
Pj4gLSBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X2luc25fZXhlY19jb25kX2NiDQo+Pg0K
Pj4gVGhleSBleHBlY3QgYXMgcGFyYW1ldGVyIGEgY29uZGl0aW9uLCBhIHFlbXVfcGx1Z2lu
X3U2NF90IChvcDEpIGFuZCBhbg0KPj4gaW1tZWRpYXRlIChvcDIpLiBDYWxsYmFjayBpcyBj
YWxsZWQgaWYgb3AxIHxjb25kfCBvcDIgaXMgdHJ1ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IDxz
bmlwPg0KPj4gICANCj4+ICtzdGF0aWMgVENHQ29uZCBwbHVnaW5fY29uZF90b190Y2djb25k
KGVudW0gcWVtdV9wbHVnaW5fY29uZCBjb25kKQ0KPj4gK3sNCj4+ICsgICAgc3dpdGNoIChj
b25kKSB7DQo+PiArICAgIGNhc2UgUUVNVV9QTFVHSU5fQ09ORF9FUToNCj4+ICsgICAgICAg
IHJldHVybiBUQ0dfQ09ORF9FUTsNCj4+ICsgICAgY2FzZSBRRU1VX1BMVUdJTl9DT05EX05F
Og0KPj4gKyAgICAgICAgcmV0dXJuIFRDR19DT05EX05FOw0KPj4gKyAgICBjYXNlIFFFTVVf
UExVR0lOX0NPTkRfTFQ6DQo+PiArICAgICAgICByZXR1cm4gVENHX0NPTkRfTFRVOw0KPj4g
KyAgICBjYXNlIFFFTVVfUExVR0lOX0NPTkRfTEU6DQo+PiArICAgICAgICByZXR1cm4gVENH
X0NPTkRfTEVVOw0KPj4gKyAgICBjYXNlIFFFTVVfUExVR0lOX0NPTkRfR1Q6DQo+PiArICAg
ICAgICByZXR1cm4gVENHX0NPTkRfR1RVOw0KPj4gKyAgICBjYXNlIFFFTVVfUExVR0lOX0NP
TkRfR0U6DQo+PiArICAgICAgICByZXR1cm4gVENHX0NPTkRfR0VVOw0KPj4gKyAgICBkZWZh
dWx0Og0KPj4gKyAgICAgICAgLyogQUxXQVlTIGFuZCBORVZFUiBjb25kaXRpb25zIHNob3Vs
ZCBuZXZlciByZWFjaCAqLw0KPj4gKyAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsN
Cj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgVENHT3AgKmFwcGVuZF9jb25k
X3VkYXRhX2NiKGNvbnN0IHN0cnVjdCBxZW11X3BsdWdpbl9keW5fY2IgKmNiLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVENHT3AgKmJlZ2luX29wLCBUQ0dP
cCAqb3AsIGludCAqY2JfaWR4KQ0KPj4gK3sNCj4+ICsgICAgY2hhciAqcHRyID0gY2ItPmNv
bmRfY2IuZW50cnkuc2NvcmUtPmRhdGEtPmRhdGE7DQo+PiArICAgIHNpemVfdCBlbGVtX3Np
emUgPSBnX2FycmF5X2dldF9lbGVtZW50X3NpemUoDQo+PiArICAgICAgICBjYi0+Y29uZF9j
Yi5lbnRyeS5zY29yZS0+ZGF0YSk7DQo+PiArICAgIHNpemVfdCBvZmZzZXQgPSBjYi0+Y29u
ZF9jYi5lbnRyeS5vZmZzZXQ7DQo+PiArICAgIC8qIENvbmRpdGlvbiBzaG91bGQgYmUgbmVn
YXRlZCwgYXMgY2FsbGluZyB0aGUgY2IgaXMgdGhlICJlbHNlIiBwYXRoICovDQo+PiArICAg
IFRDR0NvbmQgY29uZCA9IHRjZ19pbnZlcnRfY29uZChwbHVnaW5fY29uZF90b190Y2djb25k
KGNiLT5jb25kX2NiLmNvbmQpKTsNCj4+ICsNCj4+ICsgICAgb3AgPSBjb3B5X2NvbnN0X3B0
cigmYmVnaW5fb3AsIG9wLCBwdHIpOw0KPj4gKyAgICBvcCA9IGNvcHlfbGRfaTMyKCZiZWdp
bl9vcCwgb3ApOw0KPj4gKyAgICBvcCA9IGNvcHlfbXVsX2kzMigmYmVnaW5fb3AsIG9wLCBl
bGVtX3NpemUpOw0KPj4gKyAgICBvcCA9IGNvcHlfZXh0X2kzMl9wdHIoJmJlZ2luX29wLCBv
cCk7DQo+PiArICAgIG9wID0gY29weV9jb25zdF9wdHIoJmJlZ2luX29wLCBvcCwgcHRyICsg
b2Zmc2V0KTsNCj4+ICsgICAgb3AgPSBjb3B5X2FkZF9wdHIoJmJlZ2luX29wLCBvcCk7DQo+
PiArICAgIG9wID0gY29weV9sZF9pNjQoJmJlZ2luX29wLCBvcCk7DQo+PiArICAgIG9wID0g
Y29weV9icmNvbmRpX2k2NCgmYmVnaW5fb3AsIG9wLCBjb25kLCBjYi0+Y29uZF9jYi5pbW0p
Ow0KPj4gKyAgICBvcCA9IGNvcHlfY2FsbCgmYmVnaW5fb3AsIG9wLCBjYi0+Zi52Y3B1X3Vk
YXRhLCBjYl9pZHgpOw0KPj4gKyAgICBvcCA9IGNvcHlfc2V0X2xhYmVsKCZiZWdpbl9vcCwg
b3ApOw0KPj4gKyAgICByZXR1cm4gb3A7DQo+IA0KPiBJIHRoaW5rIHdlIGFyZSBtaXNzaW5n
IHNvbWV0aGluZyBoZXJlIHRvIGVuc3VyZSB0aGF0IHVkYXRhIGlzIHNldA0KPiBjb3JyZWN0
bHkgZm9yIHRoZSBjYWxsYmFjaywgc2VlIG15IFJGQzoNCj4gDQo+ICAgIFN1YmplY3Q6IFtS
RkMgUEFUQ0hdIGNvbnRyaWIvcGx1Z2luczogY29udHJvbCBmbG93IHBsdWdpbiAoV0lQISkN
Cj4gICAgRGF0ZTogTW9uLCAxMSBNYXIgMjAyNCAxNTozNDozMiArMDAwMA0KPiAgICBNZXNz
YWdlLUlkOiA8MjAyNDAzMTExNTM0MzIuMTM5NTE5MC0xLWFsZXguYmVubmVlQGxpbmFyby5v
cmc+DQo+IA0KPiB3aGljaCBpcyBzZWVpbmcgdGhlIHNhbWUgdmFsdWUgZXZlcnkgdGltZSBp
biB0aGUgY2FsbGJhY2suDQo+IA0KDQpJJ20gdHJ5aW5nIHRvIHJlcHJvZHVjZSBhbmQgd2ls
bCBhbnN3ZXIgb24gdGhpcyB0aHJlYWQuDQo=


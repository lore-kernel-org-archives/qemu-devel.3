Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D426C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQMa-0003my-RJ; Tue, 18 Feb 2025 11:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkQMY-0003mT-1m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:22:22 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkQMV-00005n-Ns
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:22:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2210d92292eso83862755ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739895736; x=1740500536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Xp4Z9/HmR+OSwLghu/zsJpTEJ/uMatbp0fonrfAci4=;
 b=e+k94yFwUk/ta1wJyl3Wp3dP+Zevc0UT7GlPGxO77DnaCLjOxxfLmOVeSY/0jEkH1d
 Y6PhaaQ8keBGbFKLgRF8DbWO1laHlnr/WUtuuxWHART+92oi59EClGFbv/sYDtJBFEnT
 0fuybV5Wc9l7BI+sWpsgkM7H7nlPYYGMcfaLCy7llEGKt4+mvidtcvZlfEWd9oCyCfi0
 stifiAn4OMhConu++5PsTD90jxcy8+iaAZHr3mig3fKbno5Nqzc+C4Tf+cD7XlCgRbpH
 GENPi6bXsLSIaC7jh9pFt688Hu+FWmTDad4XiMS61MCIth+ow7Bj4vjzCL3Ehptfh1Qk
 ZKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895736; x=1740500536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Xp4Z9/HmR+OSwLghu/zsJpTEJ/uMatbp0fonrfAci4=;
 b=sI8bdViXekKG8fbVHZ6eil5LjxzzgJr18kp11TejjRA62AUInMV3uhlZLeX/lxdgjn
 gMh9HTzthCOwKrG7t7Y449pJtXR2oAiWRCe1iSGPkug3BBy5opin5I0AIbUqtCVDsrzb
 SkhQ9pF54pIKaMeIbub4f1WQpRvchkazmTP1Isk0zlN6fQsEbNYgruSLnnoCddov+4xq
 KwxixlFFI+50xaRqRfCYcc/mbwrrE4Ov+0iCCHCXs4nYidyMv+JyMWm9/JrWWtVC3/aC
 e84IkkUhjOCeecu1VJW2evEhNG2o8VIRUaf08zKorH3W2RdOnnV0vthQhML6+sBI48Ma
 kDCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvyIqwNtIPW4yd8GDQzRGvAOFCQ9JvEPG+VVU/PMvNSCXcu6YbtmZ0nzK149boLdlkbnkCOO0az+4i@nongnu.org
X-Gm-Message-State: AOJu0YzxKFL6NBrRErA0DjvjY+8hy/p8eIFCnvATPO6BwcUJwcW3GChx
 LryJXnydu6RBm4S4/2Sz9s96g8hOBTwLIHZmkR3to5BednDzqmfIfYY/nVYGMlQ=
X-Gm-Gg: ASbGnctNfy8ID/QEqwLQeiJSVZ3udQBFWUr1SOugcmDPWUQscdxmQdR/HFZuz/oBE7W
 aTlhcYXq4M9O8RhZmvJnqASLZz0InneGwSR1NT8axRecaPG5YGIgbIpw/lBVb5ZkKzKpP3YrkgY
 91olxnVUCcW7jFItVBhB5LuG01b+OMtteKzPOUDp93YcjNdMP3p55fe1uU1tb26X1oQQlxc7G6K
 h9lW0f7fVR0L7vkT/QojKIHWS68nf3YduvzhShK7mDJncaACpRxIOazSrHNRVQj8RUTH87kOyqU
 Gyg5I7tmoGv+2Ow7kEw33WyYVXtU
X-Google-Smtp-Source: AGHT+IF5lt6Q9knZAhxS1GZtZOUoHgbgEbMDaeDVKXLy4rEqRIXV8XRlLHSGKb/OKUrAGZIrtvzJWA==
X-Received: by 2002:a05:6a21:102:b0:1ee:85b2:ef7c with SMTP id
 adf61e73a8af0-1ee8cbbcc1cmr22838441637.27.1739895736026; 
 Tue, 18 Feb 2025 08:22:16 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ab127esm10065582a91.1.2025.02.18.08.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 08:22:15 -0800 (PST)
Message-ID: <71254e1d-3e17-4082-968f-db7fe6cea590@linaro.org>
Date: Tue, 18 Feb 2025 08:22:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Weil <stefan.weil@weilnetz.de>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
 <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

SGkgQnJpYW4sDQoNCk9uIDIvMTcvMjUgMjA6MTEsIEJyaWFuIENhaW4gd3JvdGU6DQo+IA0K
PiBPbiAxLzExLzIwMjUgNDowOCBQTSwgU3RlZmFuIFdlaWwgdmlhIHdyb3RlOg0KPj4gQW0g
MTAuMDEuMjUgdW0gMjE6MzMgc2NocmllYiBQaWVycmljayBCb3V2aWVyOg0KPj4+IEZvciBu
b3csIGl0IHdhcyBvbmx5IHBvc3NpYmxlIHRvIGJ1aWxkIHBsdWdpbnMgdXNpbmcgR0NDIG9u
IFdpbmRvd3MuDQo+Pj4gSG93ZXZlciwNCj4+PiB3aW5kb3dzLWFhcmNoNjQgb25seSBzdXBw
b3J0cyBDbGFuZy4NCj4+PiBUaGlzIGJpZ2dlc3Qgcm9hZGJsb2NrIHdhcyB0byBnZXQgcmlk
IG9mIGdjY19zdHJ1Y3QgYXR0cmlidXRlLCB3aGljaA0KPj4+IGlzIG5vdA0KPj4+IHN1cHBv
cnRlZCBieSBDbGFuZy4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgd2UgcHJvdmVkIGl0IHdhcyBz
YWZlIHRvDQo+Pj4gZHJvcCBpdC4NCj4+Pg0KPj4+IEJ1aWx0IGFuZCB0ZXN0ZWQgb24gV2lu
ZG93cyAoYWxsIG1zeXMgZW52KS9MaW51eC9NYWNPUyBmb3IgeDg2XzY0IGFuZA0KPj4+IGFh
cmNoNjQNCj4+PiBob3N0cy4NCj4+Pg0KPj4+IHYxIGNvbnRhaW5lZCB3YXJuaW5nIGZpeGVz
IGFuZCB2YXJpb3VzIGJpdHMgdGhhdCBoYXZlIGJlZW4gdXBzdHJlYW1lZA0KPj4+IGFscmVh
ZHkuDQo+Pj4gVGhlIG9ubHkgYml0cyBsZWZ0IGluIHRoaXMgc2VyaWVzIGFyZSB0aGUgZ2Nj
X3N0cnVjdCByZW1vdmFsLCBhbmQNCj4+PiBmaXhpbmcgdGhlDQo+Pj4gcGx1Z2lucyBidWls
ZCB3aXRoIGNsYW5nLg0KPj4+DQo+Pj4gVGhpcyBzZXJpZXMgaXMgZm9yIDEwLjAsIGFzIHdl
IGRlY2lkZWQgdG8gbm90IGluY2x1ZGUgdGhlIGdjY19zdHJ1Y3QNCj4+PiByZW1vdmFsIGlz
DQo+Pj4gOS4yIHJlbGVhc2UuDQo+Pj4NCj4+PiBBbGwgcGF0Y2hlcyBhcmUgbm93IHJldmll
d2VkLCBzbyB0aGlzIHNlcmllcyBjYW4gYmUgcHVsbGVkLiBJJ2xsDQo+Pj4gcmVwb3J0IHRo
YXQgdG8NCj4+PiBNU1lTMiB0b28sIHNvIHdlIGNhbiBlbmFibGUgY2xhbmcgZW52aXJvbm1l
bnRzIGZvciBRRU1VLg0KPj4+DQo+Pj4gdjE6DQo+Pj4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9R
RU1VLzIwMjQxMDMxMDQwNDI2Ljc3MjYwNC0xLXBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zy8NCj4+Pg0KPj4+IHYyOg0KPj4+IC0gZHJvcCBhdHRyaWJ1dGUgZ2NjX3N0cnVjdCBpbnN0
ZWFkIG9mIHVzaW5nIC1tbm8tbXMtYml0ZmllbGRzIG9wdGlvbg0KPj4+IC0gYWRkIGEgc2Vj
dGlvbiBhYm91dCBiaXRmaWVsZHMgaW4gZG9jdW1lbnRhdGlvbg0KPj4+DQo+Pj4gdjM6DQo+
Pj4gLSBleHBsYWluIHdoeSBnY2Nfc3RydWN0IGF0dHJpYnV0ZSBtYXR0ZXJzIGluIHBhY2tl
ZCBzdHJ1Y3RzIGluDQo+Pj4gY29tbWl0IG1lc3NhZ2UNCj4+PiAtIHJld29yZCB0aGUgYml0
ZmllbGRzIGRvY3VtZW50YXRpb24gd2l0aCBzdWdnZXN0aW9ucyBnaXZlbg0KPj4+DQo+Pj4g
djQ6DQo+Pj4gLSBlZGl0IGZvciBiaXRmaWVsZHMgZG9jIHJlcXVlc3RlZCBieSBQaGlsaXBw
ZQ0KPj4+DQo+Pj4gUGllcnJpY2sgQm91dmllciAoMyk6DQo+Pj4gIMKgwqAgd2luMzI6IHJl
bW92ZSB1c2FnZSBvZiBhdHRyaWJ1dGUgZ2NjX3N0cnVjdA0KPj4+ICDCoMKgIGRvY3MvZGV2
ZWwvc3R5bGU6IGFkZCBhIHNlY3Rpb24gYWJvdXQgYml0ZmllbGQsIGFuZCBkaXNhbGxvdyB0
aGVtIGZvcg0KPj4+ICDCoMKgwqDCoCBwYWNrZWQgc3RydWN0dXJlcw0KPj4+ICDCoMKgIHBs
dWdpbnM6IGVuYWJsZSBsaW5raW5nIHdpdGggY2xhbmcvbGxkDQo+Pj4NCj4+PiAgwqAgZG9j
cy9kZXZlbC9zdHlsZS5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMCArKysrKysrKysrKysrKysrKysrDQo+Pj4gIMKgIG1lc29uLmJ1aWxkwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA2ICsrKy0tLQ0KPj4+ICDCoCBpbmNsdWRlL3FlbXUvY29tcGlsZXIuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArLS0tLS0tDQo+Pj4gIMKg
IHNjcmlwdHMvY29jY2ktbWFjcm8tZmlsZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA2ICstLS0tLQ0KPj4+ICDCoCBzdWJwcm9qZWN0cy9saWJ2aG9zdC11c2VyL2xp
YnZob3N0LXVzZXIuaCB8wqAgNiArLS0tLS0NCj4+PiAgwqAgY29udHJpYi9wbHVnaW5zL21l
c29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPj4+ICDC
oCBwbHVnaW5zL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCAyNCArKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+ICDCoCB0ZXN0
cy90Y2cvcGx1Z2lucy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MyArLS0NCj4+PiAgwqAgOCBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAyNiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBUaGlzIG5pY2Ugc2VyaWVzIGFsbG93cyBidWlsZGluZyBR
RU1VIGZvciBXaW5kb3dzIHdpdGggdGhlIExMVk0gY3Jvc3MNCj4+IGNvbXBpbGVyIG9uIG15
IEFSTTY0IG1hY2hpbmUsIHNvIHlvdSBjYW4gYWRkDQo+IA0KPiBJcyB0aGlzIHRvb2xjaGFp
biBhdmFpbGFibGUgcHVibGljbHkgb3IgZGlkIHlvdSBidWlsZCBpdCB5b3Vyc2VsZj/CoCBJ
dA0KPiB3b3VsZCBiZSBoYW5keSBpZiB0aGVyZSB3ZXJlIGEgbGludXggeDg2XzY0IGhvc3Rl
ZCBjcm9zcy10b29sY2hhaW4gdGhhdA0KPiBjYW4gdGFyZ2V0IFdpbmRvd3MtYWFyY2g2NC7C
oCBPciBsaW51eCBhYXJjaDY0IGhvc3RlZCB3b3VsZCBiZSBwcmV0dHkNCj4gZ29vZCwgdG9v
Lg0KPiANCg0KQXQgdGhlIG1vbWVudCwgdGhlIG9ubHkgb3BlbiBzb3VyY2UgdG9vbGNoYWlu
IHN1cHBvcnRpbmcgd2luZG93cy1hcm02NCANCmlzIGxsdm0tbWluZ3cgKGh0dHBzOi8vZ2l0
aHViLmNvbS9tc3RvcnNqby9sbHZtLW1pbmd3KS4NClRoZXJlIGlzIHNvbWUgcHJvZ3Jlc3Mg
b24gZ2NjLCBidXQgaXQgaXMgbm90IHlldCBmdWxseSB1cHN0cmVhbS4NCk1TWVMyIHVzZXMg
bGx2bS1taW5ndyBmb3Igd2luZG93cy1hcm02NCBlbnZpcm9ubWVudC4NCg0KT24gbXkgc2lk
ZSwgSSB1c2VkIGEgd2luZG93cy1hcm02NCBtYWNoaW5lIHdpdGggTVNZUzIgbmF0aXZlIGVu
dmlyb25tZW50Lg0KDQpJdCB3b3VsZCBiZSBoYW5keSB0byBjcm9zcyBjb21waWxlLCBhbmQg
dGhlIHByb2JsZW0gaXMgbm90IHJlYWxseSBRRU1VIA0KaXRzZWxmLCBidXQgdG8gY3Jvc3Mg
Y29tcGlsZSBhbGwgdGhlIGRlcGVuZGVuY2llcy4NCkZvciB4ODZfNjQsIHdlIHVzZSBmZWRv
cmEsIHdoaWNoIHByb3ZpZGVzIGNvbnZlbmllbnQgcHJlY29tcGlsZWQgbWluZ3cgDQpwYWNr
YWdlcyBmb3IgZGVwZW5kZW5jaWVzLg0KSXQncyBkZWZpbml0ZWx5IG5vdCBpbXBvc3NpYmxl
IHRvIGRvIHRoZSBzYW1lIGZvciB3aW5kb3dzLWFybTY0LCBidXQgaXQgDQpqdXN0IHRha2Vz
IG11Y2ggbW9yZSBlZmZvcnQuDQoNCj4gSXMgdGhlcmUgYW4gTVNZUzIgb3Igb3RoZXIgZGlz
dHJpYnV0b3IgdGhhdCBwcm92aWRlcyB3aW5kb3dzLWFhcmNoNjQNCj4gYnVpbGRzIG9mIHRo
ZSBnbGliIGFuZCBvdGhlciBsaWJyYXJ5IGRlcGVuZGVuY2llcz8NCj4gDQoNCk1TWVMyIGRv
ZXMsIGJ1dCBpdCdzIGNvbXBsaWNhdGVkIHRvIGRvd25sb2FkIHBhY2thZ2VzIGJ5IGhhbmQg
aWYgaXQncyANCnlvdXIgaWRlYS4gQmV0dGVyIHRvIGNyb3NzIGNvbXBpbGUgaXQuDQoNClJl
Z2FyZHMsDQpQaWVycmljaw0KDQo+Pg0KPj4gVGVzdGVkLWJ5OiBTdGVmYW4gV2VpbCA8c3dA
d2VpbG5ldHouZGU+DQo+Pg0KPj4gSSBvbmx5IG5lZWRlZCBhIHRyaXZpYWwgYWRkaXRpb25h
bCBmaXggaW4gc2NyaXB0cy9uc2lzLnB5IGZvciBgbWFrZQ0KPj4gaW5zdGFsbGVyYCBiZWNh
dXNlIHRoZSB1c3VhbCBHTlUgb2JqZHVtcCBhbmQgdGhlIExMVk0gb2JqZHVtcCAob3IgdGhl
DQo+PiBjcm9zcyB4ODZfNjQtdzY0LW1pbmd3MzItb2JqZHVtcCBpbiBteSB0ZXN0KSBwcm9k
dWNlIHNsaWdodGx5DQo+PiBkaWZmZXJlbnQgb3V0cHV0IChpbmRlbnRhdGlvbiB3aXRoIFx0
LCBpbmRlbnRhdGlvbiB3aXRoIGZvdXIgc3BhY2VzKS4NCj4+IEknbGwgcHJlcGFyZSBhIHBh
dGNoIHdoaWNoIGVsaW1pbmF0ZXMgdGhlIG5lZWQgZm9yIG9iamR1bXAsIHNvIG5vDQo+PiBp
bnRlcm1lZGlhdGUgZml4IGlzIG5lZWRlZCBmb3IgdGhpcy4NCj4+DQo+PiBTdGVmYW4gVy4N
Cj4+DQoNCg==


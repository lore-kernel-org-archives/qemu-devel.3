Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A8D1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84WD-0006pj-IE; Mon, 04 Nov 2024 16:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t84WA-0006pS-Vl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:21:47 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t84W8-0006ou-UI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:21:46 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so3359977b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730755303; x=1731360103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dAKTOomuqmU/tJZhuIphGwO0UtMP04Z8OPHC8PRpPmE=;
 b=RBOKdP4VkQ4PjBCF28knxQNLNnAYHI/HGaW2SYx4zMNyJ3SUhCLartN36K3WzHNoYB
 djk0M64jh5NIouk35LrS27eL0k+Gt3g7k4seG7pMkzvA/45YGoFwjSRwbEykZhSsSOex
 Xd6+ZwBn/VXSgEHwZflT4lEk2mJUWbjcVG0q25af/VatUuAktUSEsZxgyCRmX0qvsClW
 MBMcOVvP/MavbjhH9iueXCLrqAvGs4d/52tyr7wrhMu/braUBEQqDh+RrefxO8QfAptG
 NMwYKvgdOTy+mGiV/KYqoY00+ZqPLb/QBFytXNdpqoudbLhSzDnxL6Bqzjn5xo/9QB1H
 LVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755303; x=1731360103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dAKTOomuqmU/tJZhuIphGwO0UtMP04Z8OPHC8PRpPmE=;
 b=RFsjQAd7gHWogPLBACqF0MJ7lrE6Gj8GEsz/AF6KKwyTLuuL0GLLVba46TU6wqjHva
 MqS2OyQGiBWVBbaebGwriC7yfVOolTGQO+q8AQQGWG49dga8NnAog1jyqHDqXWjGnQ3p
 +8U0CUHiOQHG9ipOo88se37VOiIfPQ+U3lfo5htcACl0offen45Kf/EVnVYUYJoD+S5R
 Z9SCWNgy7xvKrBZUEwNP0DXCauQ4r3MIji86wrVD3punfYcyEI6r1nmrt9qWb+MvMQ9s
 ksmx0/821DdN5G4mw/oKDtxLmdTh5XfeC9SATpCbDsYwcKHIPl7FVJpdSOra9XaGjtEU
 2RPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lWJC5AbHSBHXajg9hAeZDklSbq6gAQLnmixrqwlUf169VZTGb1KPHCaHEzP0oHFcY5Cb4PulKnit@nongnu.org
X-Gm-Message-State: AOJu0YxtwIhJEJzwPrVGlujfXjFK0QG4bWRBt8RjDBsdwFHKkGpX4sNs
 08iLvp2jy+y+Dlpo8c4Obbd7HpMRdLZ+f/xiKyUxWbJ04mZtlHaBfNrvbV+OyE0=
X-Google-Smtp-Source: AGHT+IF3+2ISQE30SV3mCd1zFTWTMPUWP8rtYnj2xmOrEjlbpU+UINVw+wambo9GjT0S+fOs9AkP+g==
X-Received: by 2002:a05:6a00:4615:b0:71e:5573:8dcd with SMTP id
 d2e1a72fcca58-720bcaf1e8emr23154281b3a.2.1730755302685; 
 Mon, 04 Nov 2024 13:21:42 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2c58f7sm8280981b3a.140.2024.11.04.13.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 13:21:42 -0800 (PST)
Message-ID: <ec546d66-0ecb-4294-b8c6-a7f2c2a6e534@linaro.org>
Date: Mon, 4 Nov 2024 13:21:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to get args passed to binary
Content-Language: en-US
To: Demin Han <demin.han@starfivetech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
References: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gMTEvMS8yNCAyMjoxMCwgRGVtaW4gSGFuIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE1hbnkg
YmVuY2htYXJrcyBoYXZlIHRoZWlyIG93biBidWlsZCBhbmQgcnVuIHN5c3RlbSwgc3VjaCBh
cyBzcGVjaW50LCB3ZSANCj4gZG9u4oCZdCB3YW50IHRvIGNoYW5nZSB0aGVpciBjb2RlLg0K
Pg0KDQpJIGRvbid0IHRoaW5rIHRob3NlIGJlbmNobWFya3MgKHN1Y2ggYXMgc3BlY2ludCkg
aW50ZWdyYXRlIGNhbGxpbmcgcWVtdSANCndpdGggYSBzcGVjaWZpYyBwbHVnaW4gb24gY29t
bWFuZCBsaW5lLCBzbyBJIGd1ZXNzIHlvdSBoYXZlIGEgd3JhcHBlciBvciANCnNvbWV0aGlu
ZyB3aGVyZSB5b3UgY291bGQgcGFzcyBuZWNlc3NhcnkgaW5mb3JtYXRpb24sIG9yIHR3ZWFr
IG91dHB1dCANCmZpbGUsIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGJlbmNobWFyayBpdHNlbGYu
IEluIGNhc2UgSSdtIHdyb25nLCBmZWVsIA0KZnJlZSB0byBjb3JyZWN0IG1lLg0KDQo+IEFj
dHVhbGx5IHRoZSBsb2cgbWF5YmUgc3RydWN0dXJhbCBkYXRhIHN1Y2ggYXMgaW4ganNvbiBm
b3JtYXQgYW5kIG1heSBiZSANCj4gb3V0cHV0IG11bHRpcGxlIGxvZyBmaWxlcyB3aXRoIGRp
ZmZlcmVudCBzdGF0aXN0aWNzIGRpbWVudGlvbiBmb3Igb25lIHJ1bi4NCj4gDQo+IC1EIGNh
buKAmXQgc2F0aXNmeSB0aGlzLg0KDQpJbmRlZWQsIGl0IGNhbiBvdXRwdXQgb25seSBhIHNp
bmdsZSBmaWxlLiBJZiB5b3VyIHBsdWdpbiBuZWVkcyBzb21ldGhpbmcgDQptb3JlIGFkdmFu
Y2VkLCB5b3UgY2FuIHRyeSB0byBvdXRwdXQgc29tZXRoaW5nIHlvdXJzZWxmLiBIb3dldmVy
LCBhIA0KYmV0dGVyIGFuZCBzaW1wbGVyIHdheSB3b3VsZCBiZSB0byBwcmVmaXggbGluZXMg
b3V0cHV0IHdpdGggYSBzcGVjaWZpYyANCm1hcmtlciwgYW5kIHBvc3QgcHJvY2VzcyB5b3Vy
IHBsdWdpbiB0cmFjZSB3aXRoIGEgY3VzdG9tIHNjcmlwdC4NCg0KQWRkaW5nIGNvbW1hbmQg
bGluZSBhY2Nlc3MgdG8gcGx1Z2lucyBkb2VzIG5vdCBzb2x2ZSBhbnkgb2YgdGhvc2UgcHJv
YmxlbXMuDQoNCkkgc2VlIHZhbHVlIGluIHdoYXQgdGhpcyBzZXJpZXMgb2ZmZXIsIGJ1dCBJ
IGRvbid0IHNlZSBob3cgaXQncyByZWxhdGVkIA0KdG8gdGhlIGN1cnJlbnQgbmVlZCB5b3Ug
ZXhwcmVzcy4NCg0KUmVnYXJkcywNClBpZXJyaWNrDQoNCj4gDQo+IFJlZ2FyZCwNCj4gRGVu
aW4NCj4gDQo+IOiOt+WPliBPdXRsb29rIGZvciBpT1MgPGh0dHBzOi8vYWthLm1zL28wdWtl
Zj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICrlj5Hku7bkuro6KiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+ICrlj5HpgIHml7bpl7Q6KiBT
YXR1cmRheSwgTm92ZW1iZXIgMiwgMjAyNCAyOjE4OjIwIEFNDQo+ICrmlLbku7bkuro6KiBE
ZW1pbiBIYW4gPGRlbWluLmhhbkBzdGFyZml2ZXRlY2guY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnIA0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiAq5oqE6YCBOiogYWxleC5i
ZW5uZWVAbGluYXJvLm9yZyA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47IA0KPiBlcmRuYXhl
QGNyYW5zLm9yZyA8ZXJkbmF4ZUBjcmFucy5vcmc+OyBtYS5tYW5kb3VyckBnbWFpbC5jb20g
DQo+IDxtYS5tYW5kb3VyckBnbWFpbC5jb20+DQo+ICrkuLvpopg6KiBSZTogW1BBVENIXSBw
bHVnaW5zOiBhZGQgcGx1Z2luIEFQSSB0byBnZXQgYXJncyBwYXNzZWQgdG8gYmluYXJ5DQo+
IEhpIERlbWluLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIGNvbnRyaWJ1dGlvbi4NCj4gDQo+
IE9uIDExLzEvMjQgMDI6MDAsIGRlbWluLmhhbiB3cm90ZToNCj4+IFdoeSB3ZSBuZWVkIGFy
Z3M/DQo+PiBXaGVuIHBsdWdpbiBvdXRwdXRzIGxvZyBmaWxlcywgb25seSBiaW5hcnkgcGF0
aCBjYW4ndCBkaXN0aW5ndWlzaCBtdWx0aXBsZQ0KPj4gcnVucyBpZiB0aGUgYmluYXJ5IHBh
c3NlZCB3aXRoIGRpZmZlcmVudCBhcmdzLg0KPj4gVGhpcyBpcyBiYWQgZm9yIENJIHVzaW5n
IHBsdWdpbi4NCj4+DQo+IA0KPiBDYW4gaXQgYmUgc29sdmVkIHNpbXBseSBieSBlbmNvZGlu
ZyB0aGlzIGluIG5hbWUgb2YgbG9nIGZpbGUgZnJvbSB0aGUgQ0kNCj4gcnVuIHNjcmlwdD8N
Cj4gJCBjbWQ9Ii91c3IvYmluL2VjaG8gSGVsbG8gd29ybGQiDQo+ICQgb3V0X2ZpbGU9IiQo
ZWNobyAiJGNtZCIgfCBzZWQgLWUgJ3MvXHMvXy8nKS5sb2ciDQo+ICQgcWVtdSAtcGx1Z2lu
Li4uIC1kIHBsdWdpbiAtRCAiJG91dF9maWxlIiAkY21kDQo+IA0KPiBJIGNhbiBzZWUgc29t
ZSBnb29kIHBvaW50cyB0byBhZGQgdGhpcyBuZXcgQVBJLCBidXQgZm9yIHRoZSB1c2UgY2Fz
ZQ0KPiBwcmVzZW50ZWQgaW4gY29tbWl0IG1lc3NhZ2UsIEknbSBub3Qgc3VyZSB0byBzZWUg
d2hhdCBpdCBzb2x2ZXMuDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogZGVtaW4uaGFuIDxkZW1p
bi5oYW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4+IC0tLQ0KPj7CoMKgIGluY2x1ZGUvcWVtdS9x
ZW11LXBsdWdpbi5owqDCoCB8IDExICsrKysrKysrKysrDQo+PsKgwqAgcGx1Z2lucy9hcGku
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE2ICsrKysrKysrKysrKysrKysN
Cj4+wqDCoCBwbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzIHzCoCAxICsNCj4+wqDCoCAz
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2lu
LmgNCj4+IGluZGV4IDYyMmM5YTAyMzIuLmRhZjc1YzlmNWEgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaA0KPj4gKysrIGIvaW5jbHVkZS9xZW11L3FlbXUt
cGx1Z2luLmgNCj4+IEBAIC04MzcsNiArODM3LDE3IEBAIGJvb2wgcWVtdV9wbHVnaW5fYm9v
bF9wYXJzZShjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICp2YWwsIGJvb2wgKnJldCk7
DQo+PsKgwqAgUUVNVV9QTFVHSU5fQVBJDQo+PsKgwqAgY29uc3QgY2hhciAqcWVtdV9wbHVn
aW5fcGF0aF90b19iaW5hcnkodm9pZCk7DQo+PiAgIA0KPj4gKy8qKg0KPj4gKyAqIHFlbXVf
cGx1Z2luX2FyZ3ZfdG9fYmluYXJ5KCkgLSBhcmd2IHRvIGJpbmFyeSBmaWxlIGJlaW5nIGV4
ZWN1dGVkDQo+PiArICoNCj4+ICsgKiBSZXR1cm4gYSBzdHJpbmcgYXJyYXkgcmVwcmVzZW50
aW5nIHRoZSBhcmd2IHRvIHRoZSBiaW5hcnkuIEZvciB1c2VyLW1vZGUNCj4+ICsgKiB0aGlz
IGlzIHRoZSBtYWluIGV4ZWN1dGFibGUncyBhcmd2LiBGb3Igc3lzdGVtIGVtdWxhdGlvbiB3
ZSBjdXJyZW50bHkNCj4+ICsgKiByZXR1cm4gTlVMTC4gVGhlIHVzZXIgc2hvdWxkIGdfZnJl
ZSgpIHRoZSBzdHJpbmcgYXJyYXkgb25jZSBubyBsb25nZXINCj4+ICsgKiBuZWVkZWQuDQo+
PiArICovDQo+PiArUUVNVV9QTFVHSU5fQVBJDQo+PiArY29uc3QgY2hhciAqKnFlbXVfcGx1
Z2luX2FyZ3ZfdG9fYmluYXJ5KHZvaWQpOw0KPj4gKw0KPj7CoMKgIC8qKg0KPj7CoMKgwqAg
KiBxZW11X3BsdWdpbl9zdGFydF9jb2RlKCkgLSByZXR1cm5zIHN0YXJ0IG9mIHRleHQgc2Vn
bWVudA0KPj7CoMKgwqAgKg0KPj4gZGlmZiAtLWdpdCBhL3BsdWdpbnMvYXBpLmMgYi9wbHVn
aW5zL2FwaS5jDQo+PiBpbmRleCAyNGVhNjRlMmRlLi5mYTI3MzVkYjAzIDEwMDY0NA0KPj4g
LS0tIGEvcGx1Z2lucy9hcGkuYw0KPj4gKysrIGIvcGx1Z2lucy9hcGkuYw0KPj4gQEAgLTQ4
NSw2ICs0ODUsMjIgQEAgY29uc3QgY2hhciAqcWVtdV9wbHVnaW5fcGF0aF90b19iaW5hcnko
dm9pZCkNCj4+wqDCoMKgwqDCoMKgIHJldHVybiBwYXRoOw0KPj7CoMKgIH0NCj4+ICAgDQo+
PiArY29uc3QgY2hhciAqKnFlbXVfcGx1Z2luX2FyZ3ZfdG9fYmluYXJ5KHZvaWQpDQo+PiAr
ew0KPj4gK8KgwqDCoCBjb25zdCBjaGFyICoqYXJndiA9IE5VTEw7DQo+PiArI2lmZGVmIENP
TkZJR19VU0VSX09OTFkNCj4+ICvCoMKgwqAgaW50IGksIGFyZ2M7DQo+PiArwqDCoMKgIFRh
c2tTdGF0ZSAqdHMgPSBnZXRfdGFza19zdGF0ZShjdXJyZW50X2NwdSk7DQo+PiArwqDCoMKg
IGFyZ2MgPSB0cy0+YnBybS0+YXJnYzsNCj4+ICvCoMKgwqAgYXJndiA9IGdfbWFsbG9jKHNp
emVvZihjaGFyICopICogKGFyZ2MgKyAxKSk7DQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBhcmdjOyArK2kpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBhcmd2W2ldID0gZ19zdHJkdXAo
dHMtPmJwcm0tPmFyZ3ZbaV0pOw0KPj4gK8KgwqDCoCB9DQo+PiArwqDCoMKgIGFyZ3ZbYXJn
Y10gPSBOVUxMOw0KPj4gKyNlbmRpZg0KPj4gK8KgwqDCoCByZXR1cm4gYXJndjsNCj4+ICt9
DQo+PiArDQo+PsKgwqAgdWludDY0X3QgcWVtdV9wbHVnaW5fc3RhcnRfY29kZSh2b2lkKQ0K
Pj7CoMKgIHsNCj4+wqDCoMKgwqDCoMKgIHVpbnQ2NF90IHN0YXJ0ID0gMDsNCj4+IGRpZmYg
LS1naXQgYS9wbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzIGIvcGx1Z2lucy9xZW11LXBs
dWdpbnMuc3ltYm9scw0KPj4gaW5kZXggMDMyNjYxZjllYS4uNTMyNTgyZWZmZSAxMDA2NDQN
Cj4+IC0tLSBhL3BsdWdpbnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMNCj4+ICsrKyBiL3BsdWdp
bnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMNCj4+IEBAIC0xLDQgKzEsNSBAQA0KPj7CoMKgIHsN
Cj4+ICvCoCBxZW11X3BsdWdpbl9hcmd2X3RvX2JpbmFyeTsNCj4+wqDCoMKgwqAgcWVtdV9w
bHVnaW5fYm9vbF9wYXJzZTsNCj4+wqDCoMKgwqAgcWVtdV9wbHVnaW5fZW5kX2NvZGU7DQo+
PsKgwqDCoMKgIHFlbXVfcGx1Z2luX2VudHJ5X2NvZGU7DQo+IA0KPiBSZWdhcmRzLA0KPiBQ
aWVycmljaw0K


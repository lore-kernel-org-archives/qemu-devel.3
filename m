Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C728AC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lVz-00065H-0q; Fri, 04 Apr 2025 14:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lVs-00063X-Ef
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:11:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lVq-0006d3-8o
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:11:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22928d629faso24921335ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743790286; x=1744395086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i4LwuXVYbq7hv+up6Kpubk7319Yq0niQC9NeXY4/ylY=;
 b=LDm4yaotTjp2xMm5yt22qzP94br/MaiUtrIvmIInI//L/1ur6F/I9691Q2GD9qqxxh
 svo389XIakm8HSHlCK6rXV51z+1VdPfWzY7AUg33NyFtzneeh3HNrLb+bpBa7q3n0DQd
 hewKSp+FZpuhd/ivYJH+wbhcykCuwjpLh0dKlmiAP4C2YQnoBCbWxUonw0l5GyVEzRN+
 /yaTj+fQ9KSVlw8pZROwGwGWBz5V7+AxI8cSArZOPqq5e1PA5DO5uMJ9+gqmIGck6+qS
 ivIpBzCF+gGYmMJU8yfV8CY+XNtkGQuZHePa8rwHQ6UGUF5lbRCisDC4W9TiP/nTKf1E
 uJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790286; x=1744395086;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4LwuXVYbq7hv+up6Kpubk7319Yq0niQC9NeXY4/ylY=;
 b=lLC4DB8PZ5B9mkOzTeOhqvZZWyJPj9YC9ZPNfZ2tkWUW6WXTlNFvgzj1Djf/7TXV1G
 tSAML3zM1Ypyx4WVkvtzvU97LOVvvBzjO1g6bWCdXriQxRqOiQ5k8GXE9gCosiuox1fh
 sJfJtR4YjC2m5TdP1QAR2J4ZLtl+leyKBCnCuTHbUkMJySIx0bYWXQvUtHCBwfx4zLEX
 wcyAi+i814BXnftfPo3yZSjP0+7kbNEv2yL2J1FPJyrVMuASriOHxm2vst7ISI0hNh1T
 XAuDcu1bk759nOGGVA0RRGOOemtCBmocEM1Dl8W36/ALUymN6FwJ2EDIhR6oZti7JL0m
 V1TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtPPtYra9mYsvXC3FypoCyTCu2upb1cMb/kQtkg0LX1wAjqy/ba7biuIVOzhd4u1bDBPgs5kObg7TE@nongnu.org
X-Gm-Message-State: AOJu0Yw/sM4EVK5OYRAqVje7er/46ivGQ9jrIe+JGyhixaZvt4+T+umK
 d5/4qxFpboxDGQI/MSr2x9yBYxo2Uo4CAg4KHBz+24a7wr5iZXzUeG0qkiXUMt8=
X-Gm-Gg: ASbGnctI4ZGjBN5RG1xfoLQkGivzVbjtG4vLP+PZzDBQwXB3fyUto+J/bHomSXeVyVb
 OIc/OTozml20uZXpbWi/SWNa8XX9lI5FFhGQFHq1TDmXUCNT0zxLew5ecUjRccFE6PEsvENY9Zo
 eL0BnCwSEgeveQPW46oQFgx5uiWma6w5Z7IzamtL3EblPzZ7GIbgGDtFtYE/PuzmP0IRZGJMnu4
 ywGL/8e8mbHDqMn9wJkpl1JiDmXHLBSFudthLld5pdlOraum9S2QNGtr0W5zyoh/vCFX5uuHJm9
 +FRraxEiu3hgtNrMCVq/VS9eCAmmTVYrNk9W2zbOqUvEucHeIXq5IvJp4Q==
X-Google-Smtp-Source: AGHT+IGd1OdHvSIG3sn3OaC56Vw81/8ybsWfpw3FRX4l5z48GM9c89oLI1AdSQdbKqqLq6mAI5Mdjw==
X-Received: by 2002:a17:903:283:b0:220:c4e8:3b9d with SMTP id
 d9443c01a7336-22a8a8cefb0mr46732965ad.37.1743790286058; 
 Fri, 04 Apr 2025 11:11:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297877659asm35546015ad.250.2025.04.04.11.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:11:25 -0700 (PDT)
Message-ID: <7bc70b5a-3ff5-4d99-9f28-275c9e1005eb@linaro.org>
Date: Fri, 4 Apr 2025 11:11:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 19/19] system/vl: Filter machine list for
 binary using machine_binary_filter()
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-20-philmd@linaro.org>
 <5fa51205-4172-41d4-8bd9-5a95e8da24c2@linaro.org>
 <e334621a-db20-45f1-853f-0f341af2ad8f@linaro.org>
 <b0f9c6b0-0728-48e6-a347-af8b6245a83e@linaro.org>
In-Reply-To: <b0f9c6b0-0728-48e6-a347-af8b6245a83e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gNC80LzI1IDExOjA4LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPiBPbiA0LzQvMjUg
MTE6MDEsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gSGkgUGllcnJpY2ss
DQo+Pg0KPj4gT24gNC80LzI1IDE5OjEwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+
IE9uIDQvMy8yNSAxNjo0OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4+Pj4gLS0tDQo+Pj4+ICAgwqAgc3lzdGVtL3ZsLmMgfCAyNCArKysrKysrKysr
KysrKysrKysrKysrKysNCj4+Pj4gICDCoCAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9u
cygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3ZsLmMgYi9zeXN0ZW0vdmwu
Yw0KPj4+PiBpbmRleCBkOGEwZmU3MTNjOS4uNTU0ZjVmMmE0NjcgMTAwNjQ0DQo+Pj4+IC0t
LSBhL3N5c3RlbS92bC5jDQo+Pj4+ICsrKyBiL3N5c3RlbS92bC5jDQo+Pj4+IEBAIC0yNyw2
ICsyNyw4IEBADQo+Pj4+ICAgwqAgI2luY2x1ZGUgInFlbXUvZGF0YWRpci5oIg0KPj4+PiAg
IMKgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+Pj4+ICAgwqAgI2luY2x1ZGUgInFlbXUv
bW9kdWxlLmgiDQo+Pj4+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby5oIg0KPj4+PiAr
I2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+Pj4+ICAgwqAgI2luY2x1ZGUg
ImV4ZWMvY3B1LWNvbW1vbi5oIg0KPj4+PiAgIMKgICNpbmNsdWRlICJleGVjL3BhZ2UtdmFy
eS5oIg0KPj4+PiAgIMKgICNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCINCj4+Pj4g
QEAgLTgzMywxNCArODM1LDI5IEBAIHN0YXRpYyBib29sIHVzYl9wYXJzZShjb25zdCBjaGFy
ICpjbWRsaW5lLCBFcnJvcg0KPj4+PiAqKmVycnApDQo+Pj4+ICAgwqAgLyoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KPj4+
PiAgIMKgIC8qIG1hY2hpbmUgcmVnaXN0cmF0aW9uICovDQo+Pj4+ICtzdGF0aWMgY2hhciAq
bWFjaGluZV9iaW5hcnlfZmlsdGVyKHZvaWQpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgaWYg
KHRhcmdldF9pbmZvX2lzX3N0dWIoKSkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IE5VTEw7DQo+Pj4+ICvCoMKgwqAgfQ0KPj4+PiArwqDCoMKgIHJldHVybiBnX3N0cmNvbmNh
dChUWVBFX0xFR0FDWV9CSU5BUllfUFJFRklYLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInFlbXUtc3lzdGVtLSIsIHRhcmdldF9uYW1l
KCksIE5VTEwpOw0KPj4+DQo+Pj4gTm8sIHdlIHNob3VsZCBub3QgaGF2ZSBzdWNoIHRoaW5n
cy4NCj4+PiBXZSBjYW4gbWFrZSBpdCB3b3JrIHdpdGggcHJvcGVyIFFPTSB0eXBlcywgZGVm
aW5lZCBieSB0YXJnZXQsIGluc3RlYWQgb2YNCj4+PiByZWx5aW5nIG9uIHN0cmluZyBjb25z
dHJ1Y3Rpb24vY29tcGFyZSBsaWtlIHRoaXMuDQo+Pg0KPj4gSSBhbSBub3QgdW5kZXJzdGFu
ZGluZyB5b3UsIGRvIHlvdSBtaW5kIHNoYXJpbmcgY29kZSBzbmlwcGV0cyBvZiB3aGF0DQo+
PiB5b3UgaGF2ZSBpbiBtaW5kPw0KPj4NCj4gDQo+IEluc3RlYWQgb2YgdGhlIGN1cnJlbnQg
YW5kIHByZXZpb3VzIHBhdGNoLA0KPiANCj4gd2UgZGVmaW5lIFRZUEVfVEFSR0VUX01BQ0hJ
TkVfUFJFRklYLg0KPiANCj4gRm9yIGVhY2ggdGFyZ2V0LCB3ZSBkZWZpbmUgYSBzcGVjaWZp
YyBUWVBFX1RBUkdFVF9NQUNISU5FIHZhcmlhbnQsIGxpa2U6DQo+IC0gVFlQRV9UQVJHRVRf
TUFDSElORV9BUk0NCj4gLSBUWVBFX1RBUkdFVF9NQUNISU5FX0FBUkNINjQNCj4gLi4uDQo+
IA0KPiBJbiBUYXJnZXRJbmZvLCB3ZSBhZGQgYSBuZXcgZnVuY3Rpb24gdGFyZ2V0X21hY2hp
bmVfdHlwZSgpLCB0aGF0IHJldHVybnMNCj4gdGhpcyB0eXBlLCBzcGVjaWFsaXplZCBmb3Ig
ZWFjaCBhcmNoaXRlY3R1cmUuDQo+IEFzIGEgZmlyc3Qgc3RlcCwgdGhlIHN0dWIgaW1wbGVt
ZW50YXRpb24gY2FuIHJldHVybiBUWVBFX01BQ0hJTkUsIGFuZCB3ZQ0KPiBjYW4gZW5hYmxl
IHRoaXMgYXJjaGl0ZWN0dXJlIHBlciBhcmNoaXRlY3R1cmUgbGF0ZXIuDQo+IA0KPiBGb3Ig
dGhlIGZpcnN0IGFyY2hpdGVjdHVyZSBpbXBsZW1lbnRhdGlvbiwgYXJtLCB3ZSB3aWxsIGRl
ZmluZQ0KPiBUWVBFX1RBUkdFVF9NQUNISU5FX0FSTSwgYW5kIFRZUEVfVEFSR0VUX01BQ0hJ
TkVfQUFSQ0g2NCwgd2hpY2ggd2lsbA0KPiBhbGxvdyBjb25jZXJuZWQgZmlsZXMgdG8gYmUg
Y29tbW9uLCB3aGlsZSBzdGlsbCBtYWludGFpbmluZyBhIHNwZWNpZmljDQo+IHNldCBvZiBt
YWNoaW5lcyBwZXIgdGFyZ2V0Lg0KPiANCg0KTm90ZTogVGhvc2UgVFlQRV9UQVJHRVRfTUFD
SElORV8qIHR5cGVzIGFyZSBRT00gaW50ZXJmYWNlcywgdGhhdCBldmVyeSANCmNvbmNlcm5l
ZCBtYWNoaW5lIGltcGxlbWVudHMuDQoNCk9uY2UgdGhpbmdzIGFyZSBkb25lIHRoaXMgd2F5
LCB0aGUgb25seSByZXF1aXJlZCBjaGFuZ2UgaXM6DQotIG1hY2hpbmVzID0gb2JqZWN0X2Ns
YXNzX2dldF9saXN0KFRZUEVfTUFDSElORSwgZmFsc2UpOw0KKyBtYWNoaW5lcyA9IG9iamVj
dF9jbGFzc19nZXRfbGlzdCh0YXJnZXRfbWFjaGluZV90eXBlKCksIGZhbHNlKTsNCg0KQXMg
YSBmdXJ0aGVyIHN0ZXAsIGl0IHdpbGwgYmUgdmVyeSBlYXN5IHRvIHN1cHBvcnQgaGF2aW5n
IG11bHRpcGxlIA0KdGFyZ2V0cyBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUgKGJ1aWxkIGEg
bGlzdCBvZiBtYWNoaW5lIHR5cGVzIGluc3RlYWQgDQpvZiBhIHNpbmdsZSBvbmUpLCBidXQg
d2UgY2FuIGRvIHRoaXMgKmxhdGVyKiB3aGVuIHRhY2tsaW5nIGhldGVyb2dlbmVvdXMgDQpl
bXVsYXRpb24uDQoNCj4gSXMgdGhhdCBtb3JlIGNsZWFyPw0KPiANCj4+Pg0KPj4+PiArfQ0K
Pj4+PiArDQo+Pj4+ICAgwqAgc3RhdGljIE1hY2hpbmVDbGFzcyAqZmluZF9tYWNoaW5lKGNv
bnN0IGNoYXIgKm5hbWUsIEdTTGlzdCAqbWFjaGluZXMpDQo+Pj4+ICAgwqAgew0KPj4+PiAg
IMKgwqDCoMKgwqAgR1NMaXN0ICplbDsNCj4+Pj4gK8KgwqDCoCBnX2F1dG9mcmVlIGNoYXIg
KmJpbmFyeV9maWx0ZXIgPSBtYWNoaW5lX2JpbmFyeV9maWx0ZXIoKTsNCj4+Pj4gICDCoMKg
wqDCoMKgIGZvciAoZWwgPSBtYWNoaW5lczsgZWw7IGVsID0gZWwtPm5leHQpIHsNCj4+Pj4g
ICDCoMKgwqDCoMKgwqDCoMKgwqAgTWFjaGluZUNsYXNzICptYyA9IGVsLT5kYXRhOw0KPj4+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXN0cmNtcChtYy0+bmFtZSwgbmFtZSkgfHwg
IWdfc3RyY21wMChtYy0+YWxpYXMsIG5hbWUpKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChiaW5hcnlfZmlsdGVyICYmICFvYmplY3RfY2xhc3NfZHluYW1pY19jYXN0
KGVsLT5kYXRhLA0KPj4+PiArDQo+Pj4+IGJpbmFyeV9maWx0ZXIpKSB7DQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTWFjaGluZSBpcyBub3QgZm9yIHRoaXMg
YmluYXJ5OiBmYWlsICovDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIE5VTEw7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbWM7DQo+Pj4+ICAgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCj4+Pj4gICDCoMKgwqDCoMKgIH0NCj4+Pj4gQEAgLTE1NjMsNiArMTU4
MCw3IEBAIHN0YXRpYyB2b2lkIG1hY2hpbmVfaGVscF9mdW5jKGNvbnN0IFFEaWN0ICpxZGlj
dCkNCj4+Pj4gICDCoMKgwqDCoMKgIGdfYXV0b3B0cihHU0xpc3QpIG1hY2hpbmVzID0gTlVM
TDsNCj4+Pj4gICDCoMKgwqDCoMKgIEdTTGlzdCAqZWw7DQo+Pj4+ICAgwqDCoMKgwqDCoCBj
b25zdCBjaGFyICp0eXBlID0gcWRpY3RfZ2V0X3RyeV9zdHIocWRpY3QsICJ0eXBlIik7DQo+
Pj4+ICvCoMKgwqAgZ19hdXRvZnJlZSBjaGFyICpiaW5hcnlfZmlsdGVyID0gbWFjaGluZV9i
aW5hcnlfZmlsdGVyKCk7DQo+Pj4+ICAgwqDCoMKgwqDCoCBtYWNoaW5lcyA9IG9iamVjdF9j
bGFzc19nZXRfbGlzdChUWVBFX01BQ0hJTkUsIGZhbHNlKTsNCj4+Pg0KPj4+IElmIHdlIGRl
ZmluZSBhIHByb3BlciBUWVBFX1RBUkdFVF9NQUNISU5FIHBlciB0YXJnZXQsIGFuZCB3ZSBh
ZGQgdGhpcyB0bw0KPj4+IFRhcmdldEluZm8sIHRoaXMgY2FuIGJlY29tZToNCj4+Pg0KPj4+
IG1hY2hpbmVzID0gb2JqZWN0X2NsYXNzX2dldF9saXN0KHRhcmdldF9tYWNoaW5lX3R5cGUo
KSwgZmFsc2UpOw0KPj4+DQo+Pj4gQW5kIHdlIGRvbid0IG5lZWQgYW55IG90aGVyIHN0cmlu
ZyBoYWNrIHRvIGRldGVjdCB3aGF0IGlzIHRoZSBjb3JyZWN0IHR5cGUuDQo+Pj4NCj4+Pj4g
ICDCoMKgwqDCoMKgIGlmICh0eXBlKSB7DQo+Pj4+IEBAIC0xNTc3LDYgKzE1OTUsMTIgQEAg
c3RhdGljIHZvaWQgbWFjaGluZV9oZWxwX2Z1bmMoY29uc3QgUURpY3QgKnFkaWN0KQ0KPj4+
PiAgIMKgwqDCoMKgwqAgbWFjaGluZXMgPSBnX3NsaXN0X3NvcnQobWFjaGluZXMsIG1hY2hp
bmVfY2xhc3NfY21wKTsNCj4+Pj4gICDCoMKgwqDCoMKgIGZvciAoZWwgPSBtYWNoaW5lczsg
ZWw7IGVsID0gZWwtPm5leHQpIHsNCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgTWFjaGlu
ZUNsYXNzICptYyA9IGVsLT5kYXRhOw0KPj4+PiArDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoYmluYXJ5X2ZpbHRlciAmJiAhb2JqZWN0X2NsYXNzX2R5bmFtaWNfY2FzdChlbC0+ZGF0
YSwNCj4+Pj4gKw0KPj4+PiBiaW5hcnlfZmlsdGVyKSkgew0KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBNYWNoaW5lIGlzIG5vdCBmb3IgdGhpcyBiaW5hcnk6IHNraXAgKi8N
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCB9DQo+Pj4NCj4+PiBXaXRoIHRoZSBhcHByb2FjaCBhYm92ZSwgdGhpcyBpcyBu
b3QgbmVlZGVkIGFueW1vcmUuDQo+Pj4NCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KG1jLT5hbGlhcykgew0KPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW50
ZigiJS0yMHMgJXMgKGFsaWFzIG9mICVzKVxuIiwgbWMtPmFsaWFzLCBtYy0+ZGVzYywNCj4+
Pj4gbWMtPm5hbWUpOw0KPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4NCj4+PiBJ
IHRoaW5rIHdlIGFyZSBtaXNzaW5nIGEgY29tbWl0IGhlcmUsIGRlZmluaW5nIGEgcHJvcGVy
DQo+Pj4gVFlQRV9UQVJHRVRfTUFDSElORV9QUkVGSVgsIHRoYXQgaXMgdGFyZ2V0IGRlcGVu
ZGVudCwgaW5zdGVhZCBvZiB0aGUNCj4+PiBUWVBFX0xFR0FDWV9CSU5BUllfUFJFRklYLg0K
Pj4+DQo+Pj4gQW5kIHdlIHNob3VsZCBpbmNsdWRlIGluIHRoaXMgdHlwZSBpbiBUYXJnZXRJ
bmZvLCB0aGUgc2FtZSB3YXkgaXQgd2FzDQo+Pj4gZG9uZSBmb3IgY3B1cy4NCj4+DQo+IA0K
DQo=


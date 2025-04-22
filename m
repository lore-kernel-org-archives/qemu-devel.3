Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98263C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IOb-0006ec-Qg; Tue, 22 Apr 2025 14:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IOY-0006dJ-Ah
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:30:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IOW-0003Zz-22
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:30:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22435603572so59208305ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346654; x=1745951454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wEdZngJNuO8pTfEDS0r9ssBkV1XYme8fAqv1zQJbsIE=;
 b=FMUI3ZIlioEqx5qhIckdINTo40w8R384ycE5niEt74Ppdr7aJ5whU1WGFOj9BVaYmr
 sAZf12L+a4qRhulbc4oozfKdjFtwRkLbxByktX71YjgRlQJm3bYuq9zCmISa99aF8Yqz
 IAbwIDyLJwsTTWhC2GQ0DQODQJN72LR1878idV6pCBtuJXIzGycNboG17GRUGq6Lk+4E
 AnSi37dm/KAOSkphcdlgclxPLWJwT7cRFhGsmd7+L13BSq/i/cA1vc8afPvWR5/tyU84
 2BxieqO1+3Z71ex8Th89d9FMv7Xmnw8CRvNMdnnaS0Vn1zSYlk8GBI4O/0osQ2FhFHE9
 FCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346654; x=1745951454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wEdZngJNuO8pTfEDS0r9ssBkV1XYme8fAqv1zQJbsIE=;
 b=i8N/RrJQ9cAIhCbQ0jKONNNd96GK0LDP3LwAnxoJ7hJHF6dSLwmA4jHlTe1rAEIJoL
 Wp/c/FQtc8xHIwaqBdSeMVQozv3LhsYFrh4OtzxRIl8Jjk0TLkqH9TmLYUb4d1UW4BbY
 koQ0MwnUFjAUEaJaaC6JHD/N5HG5QxdvFLvaPretItAytvUbi27yzIs46REOw4QySawL
 N5Cn+9jWfg1+kz6aycQgENymvSZaOVFOrcdYmfS6Ufu0B5fBc6Ra+3UEaiTrUS1HoJYN
 Dtjh2mK5UQmqd1uvD/kaStEVnzNPteoAhg2i6AcVEQiLFpn5mlyWXvzBKdJvDEN2hOvU
 zCLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx9WHsA/SQZf6HCBPSx3H32GZ5kkJn7se2q8nvfKgLR5Two0r41X77usz75HBy0iiBaP/QAoSDHetK@nongnu.org
X-Gm-Message-State: AOJu0YwCuP6hmPOkP4H3/3J8/fK4334bKcE9Qp1eRZYEUYrs3o4rmxvE
 WCEAWFKgKND9O1Qu+fmZPCieUcnVWBvovS0qFaLlivFP4d8TzUNdIbnptZvJr2Y=
X-Gm-Gg: ASbGncvxZGuf6cJOs4AHzihAW/ocKUoHjH3KBgv1zmjM484VnN1WlkX/m3MpM7iqmMG
 AEyMz2GDB55/NvLwrKFr+tQxQyQu3aEmm8PqjQ3/G/DADFQVsj58zVu/mao6YvoDZ3VE/WUI4Wz
 LSBQBxfeNnWuyfE0Fv3+nqnimCqXJzZV491HxMQ7wNQ/nAo20VylHu3U65MI+sJOCveDBzNr/Af
 ZTwQHvfqjRb/oVEL38hAKoClAOQxA1xuBrEDk8x4Uv6qlmF4TS4LdB+5jsi5ghTMLmVBIO493LS
 i+RCoWrWXKlZKZo0BL/a21TsAu4mptpzC/RxIYG/lxYzGlxQ7hNZCg==
X-Google-Smtp-Source: AGHT+IFWocRSN8iogFPOuUrCZ9bbPXa9XBSDpQMCu+JL3X9fHQGr9TZ/+PPjJKfjD01Gfgb2FM6J3Q==
X-Received: by 2002:a17:903:1cf:b0:224:1eab:97b5 with SMTP id
 d9443c01a7336-22c5337c9ffmr235376175ad.1.1745346653813; 
 Tue, 22 Apr 2025 11:30:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb5349sm88988665ad.157.2025.04.22.11.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:30:53 -0700 (PDT)
Message-ID: <5c3cebf7-665d-4c07-97d8-cf913e78c3f0@linaro.org>
Date: Tue, 22 Apr 2025 11:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
 <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gNC8yMi8yNSAxMToyNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIyLzQvMjUgMjA6MjAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzIyLzI1
IDA3OjU0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4g
LS0tDQo+Pj4gIMKgIGluY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbXBsLmjCoMKgIHwgNCAr
KysrDQo+Pj4gIMKgIGNvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNvZnRtbXUuYyB8IDEgKw0K
Pj4+ICDCoCBjb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuY8KgwqDCoMKgIHwgMSArDQo+
Pj4gIMKgIHRhcmdldC1pbmZvLXN0dWIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDEgKw0KPj4+ICDCoCA0IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1pbXBsLmggYi9p
bmNsdWRlL3FlbXUvdGFyZ2V0LQ0KPj4+IGluZm8taW1wbC5oDQo+Pj4gaW5kZXggNGVmNTRj
NTEzNmEuLmU1Y2QxNjliNDlhIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJn
ZXQtaW5mby1pbXBsLmgNCj4+PiArKysgYi9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8taW1w
bC5oDQo+Pj4gQEAgLTEwLDEyICsxMCwxNiBAQA0KPj4+ICDCoCAjZGVmaW5lIFFFTVVfVEFS
R0VUX0lORk9fSU1QTF9IDQo+Pj4gIMKgICNpbmNsdWRlICJxZW11L3RhcmdldC1pbmZvLmgi
DQo+Pj4gKyNpbmNsdWRlICJxYXBpL3FhcGktdHlwZXMtbWFjaGluZS5oIg0KPj4+ICDCoCB0
eXBlZGVmIHN0cnVjdCBUYXJnZXRJbmZvIHsNCj4+PiAgwqDCoMKgwqDCoCAvKiBydW50aW1l
IGVxdWl2YWxlbnQgb2YgVEFSR0VUX05BTUUgZGVmaW5pdGlvbiAqLw0KPj4+ICDCoMKgwqDC
oMKgIGNvbnN0IGNoYXIgKmNvbnN0IHRhcmdldF9uYW1lOw0KPj4+ICvCoMKgwqAgLyogcmVs
YXRlZCB0byBUQVJHRVRfQVJDSCBkZWZpbml0aW9uICovDQo+Pj4gK8KgwqDCoCBTeXNFbXVU
YXJnZXQgdGFyZ2V0X2FyY2g7DQo+Pj4gKw0KPj4+ICDCoMKgwqDCoMKgIC8qIFFPTSB0eXBl
bmFtZSBtYWNoaW5lcyBmb3IgdGhpcyBiaW5hcnkgbXVzdCBpbXBsZW1lbnQgKi8NCj4+PiAg
wqDCoMKgwqDCoCBjb25zdCBjaGFyICpjb25zdCBtYWNoaW5lX3R5cGVuYW1lOw0KPj4+IGRp
ZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvYWFyY2g2NC1zb2Z0bW11LmMgYi9jb25maWdz
L3RhcmdldHMvDQo+Pj4gYWFyY2g2NC1zb2Z0bW11LmMNCj4+PiBpbmRleCAzNzVlNmZhMGI3
Yi4uZmY4OTQwMWVhMzQgMTAwNjQ0DQo+Pj4gLS0tIGEvY29uZmlncy90YXJnZXRzL2FhcmNo
NjQtc29mdG1tdS5jDQo+Pj4gKysrIGIvY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1t
dS5jDQo+Pj4gQEAgLTEzLDYgKzEzLDcgQEANCj4+PiAgwqAgc3RhdGljIGNvbnN0IFRhcmdl
dEluZm8gdGFyZ2V0X2luZm9fYWFyY2g2NF9zeXN0ZW0gPSB7DQo+Pj4gIMKgwqDCoMKgwqAg
LnRhcmdldF9uYW1lID0gImFhcmNoNjQiLA0KPj4+ICvCoMKgwqAgLnRhcmdldF9hcmNoID0g
U1lTX0VNVV9UQVJHRVRfQUFSQ0g2NCwNCj4+PiAgwqDCoMKgwqDCoCAubWFjaGluZV90eXBl
bmFtZSA9IFRZUEVfVEFSR0VUX0FBUkNINjRfTUFDSElORSwNCj4+PiAgwqAgfTsNCj4+PiBk
aWZmIC0tZ2l0IGEvY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMgYi9jb25maWdzL3Rh
cmdldHMvYXJtLQ0KPj4+IHNvZnRtbXUuYw0KPj4+IGluZGV4IGQ0YWNkYWU2NGYzLi4yMmVj
OWU0ZmFhMyAxMDA2NDQNCj4+PiAtLS0gYS9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUu
Yw0KPj4+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jDQo+Pj4gQEAgLTEz
LDYgKzEzLDcgQEANCj4+PiAgwqAgc3RhdGljIGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2lu
Zm9fYXJtX3N5c3RlbSA9IHsNCj4+PiAgwqDCoMKgwqDCoCAudGFyZ2V0X25hbWUgPSAiYXJt
IiwNCj4+PiArwqDCoMKgIC50YXJnZXRfYXJjaCA9IFNZU19FTVVfVEFSR0VUX0FSTSwNCj4+
PiAgwqDCoMKgwqDCoCAubWFjaGluZV90eXBlbmFtZSA9IFRZUEVfVEFSR0VUX0FSTV9NQUNI
SU5FLA0KPj4+ICDCoCB9Ow0KPj4+IGRpZmYgLS1naXQgYS90YXJnZXQtaW5mby1zdHViLmMg
Yi90YXJnZXQtaW5mby1zdHViLmMNCj4+PiBpbmRleCAyMThlNTg5OGU3Zi4uZTU3M2Y1YzE5
NzUgMTAwNjQ0DQo+Pj4gLS0tIGEvdGFyZ2V0LWluZm8tc3R1Yi5jDQo+Pj4gKysrIGIvdGFy
Z2V0LWluZm8tc3R1Yi5jDQo+Pj4gQEAgLTEyLDYgKzEyLDcgQEANCj4+PiAgwqAgc3RhdGlj
IGNvbnN0IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fc3R1YiA9IHsNCj4+PiAgwqDCoMKgwqDC
oCAudGFyZ2V0X25hbWUgPSBUQVJHRVRfTkFNRSwNCj4+PiArwqDCoMKgIC50YXJnZXRfYXJj
aCA9IC0xLA0KPj4NCj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGhhdmUgYSBmdWxsIGlmZGVmIGxh
ZGRlciBoZXJlLCB0byBoYW5kbGUgYWxsDQo+PiBhcmNoaXRlY3R1cmVzLiBTZXR0aW5nIC0x
IGlzIG5vdCBhIHNhZmUgZGVmYXVsdC4NCj4gDQo+IFRhcmdldEluZm8gZGVmaW5pdGlvbiBp
cyBpbnRlcm5hbCB0byAicWVtdS90YXJnZXQtaW5mby1pbXBsLmgiLA0KPiBvdGhlcndpc2Ug
aXRzIHR5cGUgaXMgZm9yd2FyZC1kZWNsYXJlZCBhcyBvcGFxdWUuDQo+IA0KDQpGaW5lLCBi
dXQgd2UgbmVlZCB0byBiZSBhYmxlIHRvIGFjY2VzcyB0byB0YXJnZXRfYXJjaCgpLCB3aGlj
aCByZXR1cm5zIA0KdGhlIGVudW0gdmFsdWUsIHdpdGhvdXQgaGF2aW5nIHRvIGRlYWwgd2l0
aCAtMSBzaXR1YXRpb24sIHdoaWNoIGlzIG5vdCBhIA0KcHJvcGVyIGVudW0gdmFsdWUuDQoN
CnN3aXRjaCAodGFyZ2V0X2FyY2goKSkgew0KY2FzZSBTWVNfRU1VX1RBUkdFVF9BUk06DQpj
YXNlIFNZU19FTVVfVEFSR0VUX0FBUkNINjQ6DQouLi4NCmRlZmF1bHQ6DQoJYnJlYWs7DQp9
DQoNCj4+DQo+Pj4gIMKgwqDCoMKgwqAgLm1hY2hpbmVfdHlwZW5hbWUgPSBUWVBFX01BQ0hJ
TkUsDQo+Pj4gIMKgIH07DQo+Pg0KPiANCg0K


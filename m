Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E084C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wqS-0006Kf-Ix; Fri, 18 Apr 2025 21:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wqD-0006Jb-Q7
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:17:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wqB-0003eQ-ED
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:17:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2240b4de12bso34262935ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745025474; x=1745630274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p3rTb9ee+T1wuDQXHMJpK03F5aTS3NScrIJTYk05J08=;
 b=l5mh1rWyi6wq/jyZbPCvbsoaqAwCcb7/qZjOSor6bZr1rfC70N2qBd/TN2M/+E9QI6
 +ECA8j4q5vA0UtNKfk4TXfo95+iAuwIqV6tM3GS/PbTBnE3Qx0YH8lRNCkFkSqB3K2Ky
 8oJUw7rXtuc9gbrat0988vSN8YP4O7V9U/zawJD/BYTGqQfPCRR2e0LTomRF/qrP2yH5
 YCJYkuW+Fn4/+DLHeeW7skc29VQIYjrq2lQYniYjbr7tSM3TYuK1uqIVmO7WTSL5+vic
 MCQEEjBuxolzpPM+y11Me3kRtbWuqdXwb12JIH4Ww0HA6y40b1yiu6XfBmvul6eb6Kdj
 JYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745025474; x=1745630274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p3rTb9ee+T1wuDQXHMJpK03F5aTS3NScrIJTYk05J08=;
 b=juP8XkKYIC+eS9twybOl3ynOau32ps15F0Ko0E1mJrR9I2haH5szF6w60d+3uJ76Hh
 v0O1bpFIapIYh2L4H9VVNhof0wuSSMmkD28taJObZwkgkVfcYwF9N4m2xKiS6kBCYRhX
 ZOU5NWKiX9JVf4tg5S7gA38dZ/rtiUatAA1w0YMDxhHAHJ5mCHzZVPO7UkNG+S6Tl2cW
 oqAfpkcKroitxiUKceG1OTQ3ZCBOC7ENO1Nv+XIjcg1IlxrVzt6fnDxPPPIK2YvOY3jL
 wcNBfH5Le1GA6u8yQS/fkA3uw4Y7eQ0zZMiT89r9En/YJ2kSvveXCjFVu9V9kSddg/6H
 pS6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt+mBguk4RMDXfAlUbIFSyOMzeFr2NrCJOd6ihqJT5gVkOp1UKCX9nryAxVIPG85hwpC2/xsadnFC3@nongnu.org
X-Gm-Message-State: AOJu0YwRCRCiiF5ohrHpM709nMGGJY3YfRvawR4jjLUC6nZRNJOOsEAG
 3+v0e533ugDGKX6LzBZMdToD9xdHInIXOZKEI+5Jy4V/AUGkR1LnZFqY6Vg64OQ=
X-Gm-Gg: ASbGnctle8LrjNp62epakD/9EnKWATYmgLxrc75lHuiR55IsrDaclv0NS5chhuGsiDH
 TR5khm+i6+XKmKO34rkBlfn5BySJRF0jqFNidJs1FrhSTtf7lX9k6nqDM85Fp3S60RTRmNP2KdE
 0OXFvVITDeuwdN2cCIdFDWl8jFxeiL+Nv/rNjvA04pWW91ocTCkIq4d0eqp15YQicZcPeBFCl2g
 UWzfpcLN7KMuqHqCn81bDv3DatfTTYK+Gdlqp50P+S9okeATu3odN0LRWwdXLutpryUVbEBd/3M
 uwYbjTwtN6MESRMwbR0rnlA4Z8JDmlPxaNhnJNQpCX02qAZAP0wxng==
X-Google-Smtp-Source: AGHT+IH2PuhNsQ6HzRHsY5EGumsklfQUFE/QLXNqhE2uAkhnpF/0LF0OLrC7mViuDIx8QV0uhHk0mA==
X-Received: by 2002:a17:902:d58b:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22c5360454cmr72513375ad.36.1745025473657; 
 Fri, 18 Apr 2025 18:17:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eceb74sm23048245ad.166.2025.04.18.18.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 18:17:53 -0700 (PDT)
Message-ID: <cfba13d1-b7b2-495c-a7fd-144909ddc62e@linaro.org>
Date: Fri, 18 Apr 2025 18:17:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU
 QOM interfaces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-5-philmd@linaro.org>
 <ac98a60e-fa76-4460-a9fa-6f95dd35814d@linaro.org>
 <dcf13faa-31e8-4ae1-9d89-1990310d207d@linaro.org>
 <dc052898-e075-4e1e-ae45-e3e47f41caae@linaro.org>
 <11f622cc-e57f-423c-91ae-6301bb3f055a@linaro.org>
 <be5d6d8f-b0df-4295-a2d3-16b5caef1eb0@linaro.org>
 <d9a95e4f-2baa-4cf4-837b-a8fc9a41bfaf@linaro.org>
 <046e2106-de39-47f1-9454-b43547716c2e@linaro.org>
 <9f182524-7e3f-4cc1-91df-8e96f2aa8a6e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9f182524-7e3f-4cc1-91df-8e96f2aa8a6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gNC8xOC8yNSAxMDozMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMTk6MjMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE4LzI1
IDEwOjEwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAxOC80LzI1
IDE5OjA3LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzE4LzI1IDEwOjA0
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+IE9uIDE4LzQvMjUgMTg6
MzAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4gT24gNC8xOC8yNSAwNzowNywg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+Pj4+IE9uIDE4LzQvMjUgMDU6
MDcsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4+PiBPbiA0LzE3LzI1IDE3OjUw
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4+Pj4+PiBEZWZpbmUgdGhl
IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FIGFuZCBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJ
TkUNCj4+Pj4+Pj4+PiBRT00gaW50ZXJmYWNlIG5hbWVzIHRvIGFsbG93IG1hY2hpbmVzIHRv
IGltcGxlbWVudCB0aGVtLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCBtZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4+Pj4+PiAgwqDCoMKgwqAgaW5j
bHVkZS9ody9ib2FyZHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+Pj4+
Pj4+ICDCoMKgwqDCoCBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8tcW9tLmggfCAxOCArKysr
KysrKysrKysrKysrKysNCj4+Pj4+Pj4+PiAgwqDCoMKgwqAgdGFyZ2V0X2luZm8tcW9tLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCA0IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMo
KykNCj4+Pj4+Pj4+PiAgwqDCoMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvcWVt
dS90YXJnZXRfaW5mby1xb20uaA0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0X2luZm8tcW9tLmMNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IGRpZmYgLS1n
aXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkDQo+Pj4+Pj4+Pj4gaW5kZXggNDlhMDUw
YTI4YTMuLjE2OGIwN2I1ODg3IDEwMDY0NA0KPj4+Pj4+Pj4+IC0tLSBhL21lc29uLmJ1aWxk
DQo+Pj4+Pj4+Pj4gKysrIGIvbWVzb24uYnVpbGQNCj4+Pj4+Pj4+PiBAQCAtMzgwOCw2ICsz
ODA4LDcgQEAgY29tbW9uX3NzLmFkZChwYWdldmFyeSkNCj4+Pj4+Pj4+PiAgwqDCoMKgwqAg
c3BlY2lmaWNfc3MuYWRkKGZpbGVzKCdwYWdlLXRhcmdldC5jJywgJ3BhZ2UtdmFyeS10YXJn
ZXQuYycpKQ0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCBjb21tb25fc3MuYWRkKGZpbGVzKCd0YXJn
ZXRfaW5mby5jJykpDQo+Pj4+Pj4+Pj4gK3N5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9p
bmZvLXFvbS5jJykpDQo+Pj4+Pj4+Pj4gIMKgwqDCoMKgIHNwZWNpZmljX3NzLmFkZChmaWxl
cygndGFyZ2V0X2luZm8tc3R1Yi5jJykpDQo+Pj4+Pj4+Pj4gIMKgwqDCoMKgIHN1YmRpcign
YmFja2VuZHMnKQ0KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2JvYXJkcy5o
IGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPj4+Pj4+Pj4+IGluZGV4IDAyZjQzYWM1ZDRkLi5i
MWJiZjNjMzRkNCAxMDA2NDQNCj4+Pj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L2JvYXJkcy5o
DQo+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPj4+Pj4+Pj4+IEBAIC03
LDYgKzcsNyBAQA0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCAjaW5jbHVkZSAic3lzdGVtL2hvc3Rt
ZW0uaCINCj4+Pj4+Pj4+PiAgwqDCoMKgwqAgI2luY2x1ZGUgInN5c3RlbS9ibG9ja2Rldi5o
Ig0KPj4+Pj4+Pj4+ICDCoMKgwqDCoCAjaW5jbHVkZSAicWFwaS9xYXBpLXR5cGVzLW1hY2hp
bmUuaCINCj4+Pj4+Pj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+
Pj4+Pj4+Pj4gIMKgwqDCoMKgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPj4+Pj4+Pj4+
ICDCoMKgwqDCoCAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPj4+Pj4+Pj4+ICDCoMKgwqDC
oCAjaW5jbHVkZSAiaHcvY29yZS9jcHUuaCINCj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9xZW11L3RhcmdldF9pbmZvLXFvbS5oIGIvaW5jbHVkZS9xZW11Lw0KPj4+Pj4+Pj4+
IHRhcmdldF9pbmZvLXFvbS5oDQo+Pj4+Pj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
Pj4+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMC4uN2ViOWI2YmQyNTQNCj4+Pj4+Pj4+PiAtLS0g
L2Rldi9udWxsDQo+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLXFv
bS5oDQo+Pj4+Pj4+Pj4gQEAgLTAsMCArMSwxOCBAQA0KPj4+Pj4+Pj4+ICsvKg0KPj4+Pj4+
Pj4+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQgQVBJIChRT00gdHlwZXMpDQo+Pj4+Pj4+Pj4g
KyAqDQo+Pj4+Pj4+Pj4gKyAqwqAgQ29weXJpZ2h0IChjKSBMaW5hcm8NCj4+Pj4+Pj4+PiAr
ICoNCj4+Pj4+Pj4+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4+Pj4+Pj4+PiArICovDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICsjaWZuZGVm
IFFFTVVfVEFSR0VUX0lORk9fUU9NX0gNCj4+Pj4+Pj4+PiArI2RlZmluZSBRRU1VX1RBUkdF
VF9JTkZPX1FPTV9IDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICsjZGVmaW5lIFRZUEVfVEFS
R0VUX0FSTV9NQUNISU5FIFwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgInRhcmdldC1p
bmZvLWFybS1tYWNoaW5lIg0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArI2RlZmluZSBUWVBF
X1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUgXA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAi
dGFyZ2V0LWluZm8tYWFyY2g2NC1tYWNoaW5lIg0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiAr
I2VuZGlmDQo+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZvLXFvbS5jIGIvdGFy
Z2V0X2luZm8tcW9tLmMNCj4+Pj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4+
Pj4+IGluZGV4IDAwMDAwMDAwMDAwLi5kM2ZlZTU3MzYxYg0KPj4+Pj4+Pj4+IC0tLSAvZGV2
L251bGwNCj4+Pj4+Pj4+PiArKysgYi90YXJnZXRfaW5mby1xb20uYw0KPj4+Pj4+Pj4+IEBA
IC0wLDAgKzEsMjQgQEANCj4+Pj4+Pj4+PiArLyoNCj4+Pj4+Pj4+PiArICogUUVNVSBiaW5h
cnkvdGFyZ2V0IEFQSSAoUU9NIHR5cGVzKQ0KPj4+Pj4+Pj4+ICsgKg0KPj4+Pj4+Pj4+ICsg
KsKgIENvcHlyaWdodCAoYykgTGluYXJvDQo+Pj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+Pj4gKyAq
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+Pj4+Pj4+Pj4g
KyAqLw0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIN
Cj4+Pj4+Pj4+PiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8tcW9tLmgiDQo+Pj4+Pj4+
Pj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICtz
dGF0aWMgY29uc3QgVHlwZUluZm8gdGFyZ2V0X2luZm9fdHlwZXNbXSA9IHsNCj4+Pj4+Pj4+
PiArwqDCoMKgIHsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgwqDCoMKg
wqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VUX0FSTV9NQUNISU5FLA0KPj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAucGFyZW50wqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfSU5URVJGQUNFLA0K
Pj4+Pj4+Pj4+ICvCoMKgwqAgfSwNCj4+Pj4+Pj4+PiArwqDCoMKgIHsNCj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfVEFSR0VU
X0FBUkNINjRfTUFDSElORSwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLnBhcmVudMKg
wqDCoMKgwqDCoMKgwqAgPSBUWVBFX0lOVEVSRkFDRSwNCj4+Pj4+Pj4+PiArwqDCoMKgIH0s
DQo+Pj4+Pj4+Pj4gK307DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICtERUZJTkVfVFlQRVMo
dGFyZ2V0X2luZm9fdHlwZXMpDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSWRlYWxseSwgdGhpcyBz
aG91bGQgYmUgaW4gdGFyZ2V0L2FybSwgYXMgdGhpcyB0eXBlIHdpbGwgb25seSBiZQ0KPj4+
Pj4+Pj4gdXNlZCBieQ0KPj4+Pj4+Pj4gYm9hcmRzIGluIGh3L2FybSwgYW5kIGJ5IHRoZSB0
YXJnZXRfaW5mbyBzcGVjaWFsaXphdGlvbi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gTm90IHRoZSB3
YXkgUU9NIHdvcmtzLCBpbnRlcmZhY2VzIG11c3QgYmUgcmVnaXN0ZXJlZCwgd2hpY2ggaXMN
Cj4+Pj4+Pj4gd2h5IEkgdXNlIHRoaXMgY2VudHJhbGl6ZWQgZmlsZS4gT3RoZXJ3aXNlIHdl
IGdldDoNCj4+Pj4+Pj4NCj4+Pj4+Pj4gJCBxZW11LXN5c3RlbS1zaDQgLU0gaGVscA0KPj4+
Pj4+PiBxZW11LXN5c3RlbS1zaDQ6IC1NIGhlbHA6IG1pc3NpbmcgaW50ZXJmYWNlICd0YXJn
ZXQtaW5mby1hcm0tbWFjaGluZScNCj4+Pj4+Pj4gZm9yIG9iamVjdCAnbWFjaGluZScNCj4+
Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IElmIEknbSBjb3JyZWN0LCB0eXBlcyBjYW4gYmUgcmVn
aXN0ZXJlZCBhbnl3aGVyZSwgc2luY2UgdGhleSByZWx5IG9uDQo+Pj4+Pj4gc3RhdGljIGlu
aXRpYWxpemVyLCBidXQgaW4gcWVtdS1zeXN0ZW0tc2g0LCBody9hcm0gb3IgdGFyZ2V0L2Fy
bSBpcw0KPj4+Pj4+IG5vdA0KPj4+Pj4+IGxpbmtlZCwgc28gaXQgZmFpbHMuDQo+Pj4+Pj4g
SSBndWVzcyB0aGlzIGlzIHRoZSBudWxsIGJvYXJkIHRoYXQgaXMgY3JlYXRpbmcgdGhpcyBz
aXR1YXRpb24sIHNpbmNlDQo+Pj4+Pj4gaXQncyBpbmNsdWRlZCBieSBhbGwgYmluYXJpZXMu
DQo+Pj4+Pg0KPj4+Pj4gQ29ycmVjdC4NCj4+Pj4+DQo+Pj4+Pj4gSSBzZWUgdHdvIHNvbHV0
aW9ucyB3aGlsZSBzdGlsbCBtb3ZpbmcgdGhvc2UgdHlwZXMgaW4gdGFyZ2V0L2FybToNCj4+
Pj4+PiAtIGluY2x1ZGUgdGhpcyB0eXBlIGZpbGUgaW4gbGliY29tbW9uLCBzbyBpdCdzIGFs
d2F5cyBsaW5rZWQuDQo+Pj4+Pj4gLSBpbnRyb2R1Y2UgYSBuZXcgVFlQRV9UQVJHRVRfQUxM
X01BQ0hJTkUsIGFuZCBhbHdheXMgaW5jbHVkZSBpdCBpbg0KPj4+Pj4+IGxpc3QNCj4+Pj4+
PiBvZiBtYWNoaW5lcy4gQnV0IEkgdGhpbmsgaXQncyBub3Qgc28gZ29vZCBhcyBpdCB3b3Vs
ZCByZXF1aXJlIHRvIGRlYWwNCj4+Pj4+PiB3aXRoIGEgbGlzdCBvZiB0eXBlcyB3aGVuIHdl
IHdhbnQgdG8gYWNjZXNzIGEgbWFjaGluZS4NCj4+Pj4+Pg0KPj4+Pj4+IFNvIEkgd291bGQg
anVzdCBtb3ZlIHRoZSBmaWxlIGFuZCBsaW5rIGl0IGluY29uZGl0b25uYWxseSBpbiBhbGwN
Cj4+Pj4+PiBiaW5hcmllcy4NCj4+Pj4+DQo+Pj4+PiBXaGljaCBmaWxlPyB0YXJnZXRfaW5m
by1xb20uYyBpcyBhbHJlYWR5IGluIHN5c3RlbV9zc1tdLg0KPj4+Pg0KPj4+PiBNb3ZlIGV4
aXN0aW5nIHRhcmdldF9pbmZvLXFvbSBpbiBpbiB0YXJnZXQvYXJtL3RhcmdldF9pbmZvX3R5
cGVzLmMsIGFuZA0KPj4+PiBhZGQgaXQgdG8gc3lzdGVtX3NzLCBpbnN0ZWFkIG9mIGFybV9z
cyBvciBhcm1fY29tbW9uX3NzLCBzbyBpdCdzIGFsd2F5cw0KPj4+PiBsaW5rZWQuDQo+Pj4N
Cj4+PiBUaGF0IHNob3VsZCB3b3JrLCBidXQgd2hhdCBpcyB0aGUgYmVuZWZpdCBvdmVyIGhh
dmluZyBhIHNpbmdsZSBmaWxlDQo+Pj4gd2hlcmUgYWxsIGRlZmluaXRpb25zIGFyZSBjb25j
ZW50cmF0ZWQ/DQo+Pj4NCj4+DQo+PiBMaW1pdCB3aGljaCB0eXBlcyBhcmUgdmlzaWJsZSBm
cm9tIGV2ZXJ5IGh3L1gsIHNvIGl0J3MgZXhwbGljaXQgd2hpY2gNCj4+IGFyY2hpdGVjdHVy
ZSBldmVyeSBib2FyZC9jcHUvZGV2aWNlIHdpbGwgaW1wbGVtZW50IGluIHRoZSBlbmQuDQo+
PiBJIGRvbid0IG1pbmQgaWYgeW91IHdhbnQgdG8ga2VlcCBpdCB0aGVyZSBmb3Igbm93LCBp
dCBkb2Vzbid0IHJlYWxseQ0KPj4gbWF0dGVyLg0KPiANCj4gT2gsIHRoZW4gSSB0aGluayBJ
IHVuZGVyc3Rvb2QgeW91IGFuZCB3ZSBhcmUgZ29vZDoNCj4gDQo+IEluc3RlYWQgb2YgaGF2
aW5nIGEgc2luZ2xlIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1xb20uaCB3aXRoDQo+IGFs
bCB0YXJnZXQgZGVmaW5pdGlvbnMsIEkgYWRkZWQgdGhlIEFSTSogb25lcyB0bw0KPiBpbmNs
dWRlL2h3L2FybS9tYWNoaW5lcy1xb20uaC4gQnV0IEkga2VwdCB0YXJnZXRfaW5mb190eXBl
c1tdDQo+IGluIGEgc2luZ2xlIGNvbW1vbiBzb3VyY2UgZmlsZS4NCg0KQWxsIGdvb2QuDQo=



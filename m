Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE62C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 04:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cwG-0000PT-5h; Fri, 18 Apr 2025 00:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cwB-0000N8-Uv
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:02:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cwA-0008K4-78
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:02:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso1751311b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744948965; x=1745553765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyWislkAjng3ymzM/sB2IEsExo0LuqpBqywxmPWYBpw=;
 b=Zhn6WWqdb5U6bFubAlrBAyhdLD+eo5ZneJ2837FZg+yr5yLBnHevbbJVgvNgZgvbkg
 l5R09LKyGEwohMS/iugOE1kHs2X9etwRyhb25Lx5myaAV++7PjxPiPH8AOkPY6TqDY+J
 Bms20XHKWXIQ3+sNMrT4uTZjVNW8jIGwD5IujIb4yJ92HfR4eA0SuJ1seCo/q7Ag7Sn6
 OEKI8Bk4sAOsmFzqEY9dIlUlJGkJQuHxyvQNjfO6YOf3SpqThGMA1ImLOhw6gmWHAIRk
 OX261YiiuXXhRTDIyQ+vgrSivdLLqs46Ry/eti4zndA1qt/LDvmsQQGfvHDsmvH7HQlG
 x/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744948965; x=1745553765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyWislkAjng3ymzM/sB2IEsExo0LuqpBqywxmPWYBpw=;
 b=Te2IfIl3SQqZaJRBJEmEkZyULtF0kqUNka04Zuc04fM0axBcquYaRmuqdkUg5detXw
 1rT/opgUegdqFFK1gmqApTIzI5iu+jh4VR4mmVHEPz1MSbJirXLzNMAbfcANfGE7NqwQ
 U+mmow1sus71iewsE7WwZG9Nmo/KWsJ8ap2d17nOU2M9B0xfCVUkNztliUHKEArMDhmu
 oEFjHgI2mTIoBYhQcfefBqzdVssaO1BVj8FgNSABd51DxEPkBO69D6mvkuHfCdbL5qND
 zrsXer/sRjXhuO//Bh/bXLrGNpVp/uQMla7xvR6bIhGBUWVoVuwepso0ilQV/Cllw6nC
 kV8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQvMzuVGZeOAVAELlmkhInY4yGNj1jBEHQz7fp1rNcH5HaYCzci2mY6q2Fw8BNQ3Jgr1OeuOqW8oiW@nongnu.org
X-Gm-Message-State: AOJu0YxB99KA+lq1n98cMw3x5saNHJ+Ub4t6zgjOPzzD+mWDQJFjGfEI
 4O5RQGj+8bGBE7rUGIonLeGBViyHyZN1MFLnK5ZAzsVW3O/+PWc5UC4EuSEL8Go=
X-Gm-Gg: ASbGnctDGlhMbblfjipvOxTmuofWb6bZFSipfyZWqpbu/XN1paF9of17oVZAQKdgyqV
 yvyLPouIpLaKygvH9Ry0548bpYF4aiRd+0Yhq7zKdml2mtxUckvkeuq6ikxQDomO0N+brGuQaS3
 AIiQS3lgr2+dtkf2PxtthMuRBZmBgfNggZ5gwOhzG3TtEa+T2vAjOEgNE3mDpn0N8BZ9wQaB2Bn
 Axwg/fYpMk4Ly6WeDfQypsZg5mVr5GcnbEqsbReTjbNFLTUAevn0eAeGQ/YrdWNYnOd7peYKmjv
 NvQV5uSLe1BRkVXBWbcT4G9kVWPUzzcUUAQF+du4Hxjte+EU9VZKmw==
X-Google-Smtp-Source: AGHT+IHMfQwiinhl3pCh8V/AbAkcsi50yGgBUKQI75evrMKfJxaJhoQwiXDYrYtuOmViFuZF4BiSHw==
X-Received: by 2002:a05:6a00:2448:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-73dc15ebb5fmr1908830b3a.21.1744948964802; 
 Thu, 17 Apr 2025 21:02:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e0bbesm723355b3a.37.2025.04.17.21.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 21:02:44 -0700 (PDT)
Message-ID: <51f533bc-ccdf-47b2-a119-c8aa96b7c659@linaro.org>
Date: Thu, 17 Apr 2025 21:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/11] hw/arm/aspeed: Build objects once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE5v
dyB0aGFuIEFzcGVlZCBtYWNoaW5lcyBjYW4gYmUgZmlsdGVyZWQgd2hlbiBydW5uaW5nIGEN
Cj4gcWVtdS1zeXN0ZW0tYXJtIG9yIHFlbXUtc3lzdGVtLWFhcmNoNjQgYmluYXJ5LCB3ZSBj
YW4NCj4gcmVtb3ZlIHRoZSBUQVJHRVRfQUFSQ0g2NCAjaWZkZWYncnkgYW5kIGNvbXBpbGUg
dGhlDQo+IGFzcGVlZC5jIGZpbGUgb25jZSwgbW92aW5nIGl0IGZyb20gYXJtX3NzW10gc291
cmNlIHNldA0KPiB0byBhcm1fY29tbW9uX3NzW10uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAg
IGh3L2FybS9hc3BlZWQuYyAgICB8IDYgLS0tLS0tDQo+ICAgaHcvYXJtL21lc29uLmJ1aWxk
IHwgNCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJt
L2FzcGVlZC5jDQo+IGluZGV4IGQ1NGVlMmQ0YjUzLi4zNjNiZTJkYWY2MCAxMDA2NDQNCj4g
LS0tIGEvaHcvYXJtL2FzcGVlZC5jDQo+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiBAQCAt
MTc5LDEzICsxNzksMTEgQEAgc3RydWN0IEFzcGVlZE1hY2hpbmVTdGF0ZSB7DQo+ICAgI2Rl
ZmluZSBBU1QyNjAwX0VWQl9IV19TVFJBUDEgMHgwMDAwMDBDMA0KPiAgICNkZWZpbmUgQVNU
MjYwMF9FVkJfSFdfU1RSQVAyIDB4MDAwMDAwMDMNCj4gICANCj4gLSNpZmRlZiBUQVJHRVRf
QUFSQ0g2NA0KPiAgIC8qIEFTVDI3MDAgZXZiIGhhcmR3YXJlIHZhbHVlICovDQo+ICAgLyog
U0NVIEhXIFN0cmFwMSAqLw0KPiAgICNkZWZpbmUgQVNUMjcwMF9FVkJfSFdfU1RSQVAxIDB4
MDAwMDA4MDANCj4gICAvKiBTQ1VJTyBIVyBTdHJhcDEgKi8NCj4gICAjZGVmaW5lIEFTVDI3
MDBfRVZCX0hXX1NUUkFQMiAweDAwMDAwNzAwDQo+IC0jZW5kaWYNCj4gICANCj4gICAvKiBS
YWluaWVyIGhhcmR3YXJlIHZhbHVlOiAoUUVNVSBwcm90b3R5cGUpICovDQo+ICAgI2RlZmlu
ZSBSQUlOSUVSX0JNQ19IV19TVFJBUDEgKDB4MDA0MjIwMTYgfCBTQ1VfQVNUMjYwMF9IV19T
VFJBUF9CT09UX1NSQ19FTU1DKQ0KPiBAQCAtMTY2Myw3ICsxNjYxLDYgQEAgc3RhdGljIHZv
aWQgYXNwZWVkX21pbmlibWNfbWFjaGluZV9hc3QxMDMwX2V2Yl9jbGFzc19pbml0KE9iamVj
dENsYXNzICpvYywNCj4gICAgICAgYXNwZWVkX21hY2hpbmVfY2xhc3NfaW5pdF9jcHVzX2Rl
ZmF1bHRzKG1jKTsNCj4gICB9DQo+ICAgDQo+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4g
ICBzdGF0aWMgdm9pZCBhc3QyNzAwX2V2Yl9pMmNfaW5pdChBc3BlZWRNYWNoaW5lU3RhdGUg
KmJtYykNCj4gICB7DQo+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzb2MgPSBibWMtPnNvYzsN
Cj4gQEAgLTE3MTMsNyArMTcxMCw2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5lX2Fz
dDI3MDBhMV9ldmJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+
ICAgICAgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0gMSAqIEdpQjsNCj4gICAgICAgYXNwZWVk
X21hY2hpbmVfY2xhc3NfaW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gICB9DQo+IC0jZW5k
aWYNCj4gICANCj4gICBzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9xY29tX2RjX3NjbV92
MV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEpDQo+IEBAIC0x
OTM2LDcgKzE5MzIsNiBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX21hY2hpbmVf
dHlwZXNbXSA9IHsNCj4gICAgICAgICAgICAgICB7IFRZUEVfVEFSR0VUX0FBUkNINjRfTUFD
SElORSB9LA0KPiAgICAgICAgICAgICAgIHsgfSwNCj4gICAgICAgICAgIH0sDQo+IC0jaWZk
ZWYgVEFSR0VUX0FBUkNINjQNCj4gICAgICAgfSwgew0KPiAgICAgICAgICAgLm5hbWUgICAg
ICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgiYXN0MjcwMGEwLWV2YiIpLA0KPiAgICAgICAg
ICAgLnBhcmVudCAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0KPiBAQCAtMTk1Myw3
ICsxOTQ4LDYgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9tYWNoaW5lX3R5cGVz
W10gPSB7DQo+ICAgICAgICAgICAgICAgeyBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUg
fSwNCj4gICAgICAgICAgICAgICB7IH0sDQo+ICAgICAgICAgICB9LA0KPiAtI2VuZGlmDQo+
ICAgICAgIH0sIHsNCj4gICAgICAgICAgIC5uYW1lICAgICAgICAgID0gVFlQRV9BU1BFRURf
TUFDSElORSwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9NQUNISU5FLA0K
PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL21lc29uLmJ1aWxkIGIvaHcvYXJtL21lc29uLmJ1aWxk
DQo+IGluZGV4IDA5YjFjZmU1YjU3Li5mNzZlN2ZiMjI5ZiAxMDA2NDQNCj4gLS0tIGEvaHcv
YXJtL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L2FybS9tZXNvbi5idWlsZA0KPiBAQCAtMzks
MTUgKzM5LDE1IEBAIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfWExOWF9WRVJT
QUwnLCBpZl90cnVlOiBmaWxlcygneGxueC12ZXJzYWwuYycsICd4DQo+ICAgYXJtX2NvbW1v
bl9zcy5hZGQod2hlbjogJ0NPTkZJR19GU0xfSU1YMjUnLCBpZl90cnVlOiBmaWxlcygnZnNs
LWlteDI1LmMnLCAnaW14MjVfcGRrLmMnKSkNCj4gICBhcm1fY29tbW9uX3NzLmFkZCh3aGVu
OiAnQ09ORklHX0ZTTF9JTVgzMScsIGlmX3RydWU6IGZpbGVzKCdmc2wtaW14MzEuYycsICdr
em0uYycpKQ0KPiAgIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfRlNMX0lNWDYn
LCBpZl90cnVlOiBmaWxlcygnZnNsLWlteDYuYycpKQ0KPiAtYXJtX3NzLmFkZCh3aGVuOiAn
Q09ORklHX0FTUEVFRF9TT0MnLCBpZl90cnVlOiBmaWxlcygNCj4gK2FybV9jb21tb25fc3Mu
YWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NPQycsIGlmX3RydWU6IGZpbGVzKA0KPiAgICAg
J2FzcGVlZC5jJywNCj4gICAgICdhc3BlZWRfc29jX2NvbW1vbi5jJywNCj4gICAgICdhc3Bl
ZWRfYXN0MjQwMC5jJywNCj4gICAgICdhc3BlZWRfYXN0MjYwMC5jJywNCj4gICAgICdhc3Bl
ZWRfYXN0MTB4MC5jJywNCj4gKyAgJ2FzcGVlZF9hc3QyN3gwLmMnLA0KPiAgICAgJ2FzcGVl
ZF9lZXByb20uYycsDQo+ICAgICAnZmJ5MzUuYycpKQ0KPiAtYXJtX2NvbW1vbl9zcy5hZGQo
d2hlbjogWydDT05GSUdfQVNQRUVEX1NPQycsICdUQVJHRVRfQUFSQ0g2NCddLCBpZl90cnVl
OiBmaWxlcygnYXNwZWVkX2FzdDI3eDAuYycpKQ0KPiAgIGFybV9jb21tb25fc3MuYWRkKHdo
ZW46ICdDT05GSUdfTVBTMicsIGlmX3RydWU6IGZpbGVzKCdtcHMyLmMnKSkNCj4gICBhcm1f
Y29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX01QUzInLCBpZl90cnVlOiBmaWxlcygnbXBz
Mi10ei5jJykpDQo+ICAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19NU0YyJywg
aWZfdHJ1ZTogZmlsZXMoJ21zZjItc29jLmMnKSkNCg0KSHVycmFoIQ0KUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K


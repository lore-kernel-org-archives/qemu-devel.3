Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFDE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlaP-00039m-7h; Tue, 14 Jan 2025 13:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXla6-0002t1-Qe
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXla4-0004Pk-Dm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:24:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21636268e43so136874395ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736879038; x=1737483838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfNyLOYfaNLG/Mlb9S+1ElY8Ozvd55xra4FcxZ3bhSs=;
 b=CW3UOc6pahkZP5rlk9TeRT9SHELqC2sWoKhUu9iTicS/iH1bpxw8jUDBYh7p443fej
 MfxI4FFzZKiMIV1bDNpYLLNljRZzwMIjabbDoCGDW7EoUNQ/315Q5CdVaNR+SaZvmwm8
 ZAqWHoMCT6aS3UjcwYX0uyJZtyIrf9biQAktPxIcqYoiH20Db71BA0uNrKcr4sNEF1Em
 VbHfbIUlZVC257vv423gzqJyC/0ZHanzudOvXHkhZFbn/Z6xzL/ElU+lEmvCUXqr3uCX
 vsXop6cu4ppkkXrZZXuyOORnxD9PJKXsGl01mevOSsAoWb+4F3GF9BdAE6fOxd0AfTRW
 JuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736879038; x=1737483838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FfNyLOYfaNLG/Mlb9S+1ElY8Ozvd55xra4FcxZ3bhSs=;
 b=C5fDMB1WqO676HUCh+RsTT9fcKytv84a1ePtC95IHoB6t5d6/6xtV8j1K0oJ7dtM42
 Du/tROuQ2FhdMuuzcN3Cvc5nOcLOWKy3fmIaSld/Qck+EWi8vC9/yIhICUH0MtiOsgku
 mojA1dwEFU/vD5F9sLjIje4kA8qP/s6NfAQvpHYqGJTCbsmcypu7ckLsZwJpOnP2Z9Un
 GRFct6+4UPjO3DrtrNcluygVBjBp/FMqtwxQE53thKHKGRxGZ8wzUW85+9iI9TQ8X/mp
 nRQDdfstt+CHeL3pT4vJIg/U/yc/zfZnWZZGC9/78RhmAa8+Ez5DpzWS/YxebSVkhdMO
 vHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIeSFPyE1wDUQmpSnJUqVEWa+OpwaywEK30hVzE7DT0DCQBC5K4c/ZvFPEDB7W7aZ4475A7syh/Xj1@nongnu.org
X-Gm-Message-State: AOJu0YwSgNsvBRVygjQe6KmZGQFRa7YBvOb1ABsdpcUTXlarXJh65+Ks
 weGxZAE+z76nMMB3Tp7EmpFEcen7hD+yUnd0xog6Qwf2ZT02iCMpdIF34zDVWr4=
X-Gm-Gg: ASbGnctAK01CApeg5jHdhDX/uCnK7WAD3AGp3THUKsk6LE08/pfnjCv30Q3ck9qX5Xs
 PZmZM2O6D+bjpD+TdPXKcSNH5WoGkeoDF8za8jJMx6/yLOuVZowxdQMvAFZTvj8Tff2Z5vdmpfP
 /74g+ynUdRuO4c7pccNnW1HeV8QE6NFx4oiGF1f5MJTLoujgGl/M/oXJlLVQbk0t0dZ+scnSZnE
 uvxIGA92cxCCO5Kgppbb6pzGT2wMaFmWLJjuHfHnkvL/FksWCVvly/qxEDegxyIqEMYDQ==
X-Google-Smtp-Source: AGHT+IEqwQ2peXOwzVNKx7OtI4jhue3Hk1jyStYdw96NroCZ8+rRU5rEUlXgLNWE1MjoN34JchZKhQ==
X-Received: by 2002:a17:902:d48a:b0:216:4064:53ad with SMTP id
 d9443c01a7336-21a840109d2mr399728825ad.48.1736879036387; 
 Tue, 14 Jan 2025 10:23:56 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f12fcfbsm70053675ad.82.2025.01.14.10.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 10:23:55 -0800 (PST)
Message-ID: <ebc94a24-2a60-45c0-b60d-33750d4b68ab@linaro.org>
Date: Tue, 14 Jan 2025 10:23:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/37] tests/qtest: fix some copy and paste errors in
 kdoc
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-29-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114113821.768750-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMS8xNC8yNSAwMzozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBBIG51bWJlciBvZiBj
b3B5IGFuZCBwYXN0ZSBrZG9jIGNvbW1lbnRzIGFyZSByZWZlcnJpbmcgdG8gdGhlIHdyb25n
DQo+IGRlZmluaXRpb24uIEZpeCB0aG9zZSBjYXNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGVz
dHMvcXRlc3QvbGlicW9zL3FncmFwaC5oIHwgMiArLQ0KPiAgIHRlc3RzL3F0ZXN0L2xpYnF0
ZXN0LmggICAgICB8IDYgKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3Qv
bGlicW9zL3FncmFwaC5oIGIvdGVzdHMvcXRlc3QvbGlicW9zL3FncmFwaC5oDQo+IGluZGV4
IDFiNWRlMDJlN2IuLjgxZmJmZGQwZTIgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3F0ZXN0L2xp
YnFvcy9xZ3JhcGguaA0KPiArKysgYi90ZXN0cy9xdGVzdC9saWJxb3MvcWdyYXBoLmgNCj4g
QEAgLTM1NSw3ICszNTUsNyBAQCB2b2lkIHFvc19vYmplY3Rfc3RhcnRfaHcoUU9TR3JhcGhP
YmplY3QgKm9iaik7DQo+ICAgUU9TR3JhcGhPYmplY3QgKnFvc19tYWNoaW5lX25ldyhRT1NH
cmFwaE5vZGUgKm5vZGUsIFFUZXN0U3RhdGUgKnF0cyk7DQo+ICAgDQo+ICAgLyoqDQo+IC0g
KiBxb3NfbWFjaGluZV9uZXcoKTogaW5zdGFudGlhdGUgYSBuZXcgZHJpdmVyIG5vZGUNCj4g
KyAqIHFvc19kcml2ZXJfbmV3KCk6IGluc3RhbnRpYXRlIGEgbmV3IGRyaXZlciBub2RlDQo+
ICAgICogQG5vZGU6IEEgZHJpdmVyIG5vZGUgdG8gYmUgaW5zdGFudGlhdGVkDQo+ICAgICog
QHBhcmVudDogQSAjUU9TR3JhcGhPYmplY3QgdG8gYmUgY29uc3VtZWQgYnkgdGhlIG5ldyBk
cml2ZXIgbm9kZQ0KPiAgICAqIEBhbGxvYzogQW4gYWxsb2NhdG9yIHRvIGJlIHVzZWQgYnkg
dGhlIG5ldyBkcml2ZXIgbm9kZS4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2xpYnF0
ZXN0LmggYi90ZXN0cy9xdGVzdC9saWJxdGVzdC5oDQo+IGluZGV4IGYyM2Q4MGU5ZTUuLmZh
MDhjN2VjYTUgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmgNCj4gKysr
IGIvdGVzdHMvcXRlc3QvbGlicXRlc3QuaA0KPiBAQCAtMzY1LDcgKzM2NSw3IEBAIFFEaWN0
ICpxdGVzdF9xbXBfZXZlbnRfcmVmKFFUZXN0U3RhdGUgKnMsIGNvbnN0IGNoYXIgKmV2ZW50
KTsNCj4gICBjaGFyICpxdGVzdF9obXAoUVRlc3RTdGF0ZSAqcywgY29uc3QgY2hhciAqZm10
LCAuLi4pIEdfR05VQ19QUklOVEYoMiwgMyk7DQo+ICAgDQo+ICAgLyoqDQo+IC0gKiBxdGVz
dF9obXB2Og0KPiArICogcXRlc3RfdmhtcDoNCj4gICAgKiBAczogI1FUZXN0U3RhdGUgaW5z
dGFuY2UgdG8gb3BlcmF0ZSBvbi4NCj4gICAgKiBAZm10OiBITVAgY29tbWFuZCB0byBzZW5k
IHRvIFFFTVUsIGZvcm1hdHMgYXJndW1lbnRzIGxpa2UgdnNwcmludGYoKS4NCj4gICAgKiBA
YXA6IEhNUCBjb21tYW5kIGFyZ3VtZW50cw0KPiBAQCAtOTA0LDcgKzkwNCw3IEBAIHZvaWQg
cXRlc3RfcW1wX2Fzc2VydF9zdWNjZXNzKFFUZXN0U3RhdGUgKnF0cywgY29uc3QgY2hhciAq
Zm10LCAuLi4pDQo+ICAgDQo+ICAgI2lmbmRlZiBfV0lOMzINCj4gICAvKioNCj4gLSAqIHF0
ZXN0X3FtcF9mZF9hc3NlcnRfc3VjY2Vzc19yZWY6DQo+ICsgKiBxdGVzdF9xbXBfZmRzX2Fz
c2VydF9zdWNjZXNzX3JlZjoNCj4gICAgKiBAcXRzOiBRVGVzdFN0YXRlIGluc3RhbmNlIHRv
IG9wZXJhdGUgb24NCj4gICAgKiBAZmRzOiB0aGUgZmlsZSBkZXNjcmlwdG9ycyB0byBzZW5k
DQo+ICAgICogQG5mZHM6IG51bWJlciBvZiBAZmRzIHRvIHNlbmQNCj4gQEAgLTkyMSw3ICs5
MjEsNyBAQCBRRGljdCAqcXRlc3RfcW1wX2Zkc19hc3NlcnRfc3VjY2Vzc19yZWYoUVRlc3RT
dGF0ZSAqcXRzLCBpbnQgKmZkcywgc2l6ZV90IG5mZHMsDQo+ICAgICAgIEdfR05VQ19QUklO
VEYoNCwgNSk7DQo+ICAgDQo+ICAgLyoqDQo+IC0gKiBxdGVzdF9xbXBfZmRfYXNzZXJ0X3N1
Y2Nlc3M6DQo+ICsgKiBxdGVzdF9xbXBfZmRzX2Fzc2VydF9zdWNjZXNzOg0KPiAgICAqIEBx
dHM6IFFUZXN0U3RhdGUgaW5zdGFuY2UgdG8gb3BlcmF0ZSBvbg0KPiAgICAqIEBmZHM6IHRo
ZSBmaWxlIGRlc2NyaXB0b3JzIHRvIHNlbmQNCj4gICAgKiBAbmZkczogbnVtYmVyIG9mIEBm
ZHMgdG8gc2VuZA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQo=


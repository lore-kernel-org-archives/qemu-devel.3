Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623E7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 01:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW405-0002BP-7Z; Thu, 09 Jan 2025 20:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW401-0002Ag-Mv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 20:39:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW3zv-0002Pk-6V
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 20:39:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b1f05caso26158705ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 17:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736473177; x=1737077977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IWoYa8Tq2Iqy0RVtRWeqNc8gWw69km03OztpeuuT6JA=;
 b=O7dSB7MlK/urEbfBBNs+2FFsA/YPqMSQX4HQHSBHpD3SExNn+Sw4b3J3MyXdvuLmVS
 vxMH+UEw3YkAxAUUA9zrxiUB9zCUpU8HBqJq2Um/66o/n0b4CEyB/F2AFbL1pYQRpkR0
 T372U8NWmzChmN6NwMBubEMKls1yAJ2A5yzwfIdEoSdLvoREB8s2M3xXntFqetpb2feB
 b3SINJ0xGN1PMc8X8HKJWLus0PG9u3DYruai5jnucBVNDC1SGsin8OfFpPc9FhI9E/1o
 TfEWyWl+/3JPc5hIjcREm6KWMLzTHMuELiyIfwGI4j/7UBSBpAgdASYQx0NtBhuc83Rr
 Y/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736473177; x=1737077977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IWoYa8Tq2Iqy0RVtRWeqNc8gWw69km03OztpeuuT6JA=;
 b=HIhxQdBXSCjxyMSbkqTNO2ccL8U/OAnFjh/MFNLqsjcxh+PumWTv2/z3UuL10jl3Ut
 sRW1z1roSIO37i4LN9ZHnIcY3Cdgp4CPFCX6DP7xwQQCkxAMNCeGNjyLvrtA/1SaNYlG
 K5XUjkFpZrBLmIqG6iwMBi6qvm/UcRzOlQTP6kOX72rtcAeSq1xyN1FNrR07MU+XIqK4
 w8Fcu6Xc/QF22CRwiSw32oH3Tr04XWDmnhYCF0kxvsFQ9aoLbXwilzQ2tkCe4Aqfa521
 BdKVojm1spZcmY4o09iIw9oWYUBVqN/4+VbcuWnVNHGn3SBcuLvKsnxTVzzguc5UOmhC
 dfLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKzV3pUkudssX0n912REq9uukx3/8JyMF+ZYeYIsJ/z61Fudf5VmdVUIFDxfAVVAQ0XWQbbu9pa9uH@nongnu.org
X-Gm-Message-State: AOJu0Yxi5iXvSVwtni8cKuu5wwcd8EH5wndAzldbFwZKG+0V9+PpYMb8
 jPLYZA1daJFfhjENttSxaHdFwVhpKGV+LLqCtk+YHJQJyOz6P4gwBToSlqSVxF8=
X-Gm-Gg: ASbGncsajLN2S3DP2+ckmgxghhtBgVLdcpSv3kkfHVCAYFKQJk1v9bYuz6FRIAuf4S7
 Yezg1cm/a3RSp/uijjHSBuNJGonI7NAWhc8/RTi0k0AmEMdU5qUeTHMFJ634+ihVViSlmVKd1Hm
 CFu6CMky3+n7c1kB9kyxWOx+44uZqpcxVArsCKsIfWCL5KG6nPKYyE+wfDYb6Iig9hZS+wPuNps
 gwIHT5VED14EMnu5kVJK9JSA/jjtckZ41RDuPdvySXtIx7HNxyxKfo2mcwCJlUrarUBYQ==
X-Google-Smtp-Source: AGHT+IFlVo/Qf/ZKLTa197NJxWVe1d7YV6rFQKAZ9mcAkA47rlvUgpM0hEN3qz912nbkRI4XBPBlzg==
X-Received: by 2002:a17:902:ce06:b0:216:5561:70d7 with SMTP id
 d9443c01a7336-21a83fe48c0mr142323375ad.52.1736473177378; 
 Thu, 09 Jan 2025 17:39:37 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f12f925sm4216135ad.61.2025.01.09.17.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 17:39:36 -0800 (PST)
Message-ID: <a24bd0e8-d6f7-4297-90b8-b69f6b3080fc@linaro.org>
Date: Thu, 9 Jan 2025 17:39:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vvfat: fix out of bounds array write
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20250105135929.6286-1-vr_qemu@t-online.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250105135929.6286-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SGkgVm9sa2VyLA0KDQpPbiAxLzUvMjUgMDU6NTksIFZvbGtlciBSw7xtZWxpbiB3cm90ZToN
Cj4gSW4gZnVuY3Rpb24gY3JlYXRlX2xvbmdfZmlsbmFtZSgpLCB0aGUgYXJyYXkgbmFtZVs4
ICsgM10gaW4NCj4gc3RydWN0IGRpcmVudHJ5X3QgaXMgdXNlZCBhcyBpZiBpdCB3ZXJlIGRl
ZmluZWQgYXMgbmFtZVszMl0uDQo+IFRoaXMgaXMgaW50ZW50aW9uYWwgYW5kIHdvcmtzLiBJ
dCdzIG5ldmVydGhlbGVzcyBhbiBvdXQgb2YNCj4gYm91bmRzIGFycmF5IGFjY2Vzcy4gVG8g
YXZvaWQgdGhpcyBwcm9ibGVtLCB0aGlzIHBhdGNoIGFkZHMgYQ0KPiBzdHJ1Y3QgbGZuX2Rp
cmVudHJ5X3Qgd2l0aCBtdWx0aXBsZSBuYW1lIGFycmF5cy4gQSBkaXJlY3RvcnkNCj4gZW50
cnkgZm9yIGEgbG9uZyBGQVQgZmlsZSBuYW1lIGlzIHNpZ25pZmljYW50bHkgZGlmZmVyZW50
IGZyb20NCj4gYSBkaXJlY3RvcnkgZW50cnkgZm9yIGEgcmVndWxhciBGQVQgZmlsZSBuYW1l
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVm9sa2VyIFLDvG1lbGluIDx2cl9xZW11QHQtb25s
aW5lLmRlPg0KPiAtLS0NCj4gICBibG9jay92dmZhdC5jIHwgNTUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDQxIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL3Z2ZmF0LmMgYi9ibG9jay92dmZhdC5jDQo+IGluZGV4IDhmZmU4YjNiOWIu
LjYyNmM0ZjAxNjMgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Z2ZmF0LmMNCj4gKysrIGIvYmxv
Y2svdnZmYXQuYw0KPiBAQCAtMjU1LDYgKzI1NSwxNyBAQCB0eXBlZGVmIHN0cnVjdCBkaXJl
bnRyeV90IHsNCj4gICAgICAgdWludDMyX3Qgc2l6ZTsNCj4gICB9IFFFTVVfUEFDS0VEIGRp
cmVudHJ5X3Q7DQo+ICAgDQo+ICt0eXBlZGVmIHN0cnVjdCBsZm5fZGlyZW50cnlfdCB7DQo+
ICsgICAgdWludDhfdCBzZXF1ZW5jZTsNCj4gKyAgICB1aW50OF90IG5hbWUwMVsxMF07DQo+
ICsgICAgdWludDhfdCBhdHRyaWJ1dGVzOw0KPiArICAgIHVpbnQ4X3QgZGlyZW50cnlfdHlw
ZTsNCj4gKyAgICB1aW50OF90IHNmbl9jaGVja3N1bTsNCj4gKyAgICB1aW50OF90IG5hbWUw
ZVsxMl07DQo+ICsgICAgdWludDE2X3QgYmVnaW47DQo+ICsgICAgdWludDhfdCBuYW1lMWNb
NF07DQo+ICt9IFFFTVVfUEFDS0VEIGxmbl9kaXJlbnRyeV90Ow0KPiArDQo+ICAgLyogdGhp
cyBzdHJ1Y3R1cmUgYXJlIHVzZWQgdG8gdHJhbnNwYXJlbnRseSBhY2Nlc3MgdGhlIGZpbGVz
ICovDQo+ICAgDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgbWFwcGluZ190IHsNCj4gQEAgLTM5OSwx
MSArNDEwLDI4IEBAIHN0YXRpYyB2b2lkIGluaXRfbWJyKEJEUlZWVkZBVFN0YXRlICpzLCBp
bnQgY3lscywgaW50IGhlYWRzLCBpbnQgc2VjcykNCj4gICANCj4gICAvKiBkaXJlbnRyeSBm
dW5jdGlvbnMgKi8NCj4gICANCj4gK3N0YXRpYyB2b2lkIHdyaXRlX2xvbmdfZmlsZW5hbWUo
bGZuX2RpcmVudHJ5X3QgKmVudHJ5LCBpbnQgaW5kZXgsIHVpbnQ4X3QgYykNCj4gK3sNCj4g
KyAgICBpZiAoaW5kZXggPCBBUlJBWV9TSVpFKGVudHJ5LT5uYW1lMDEpKSB7DQo+ICsgICAg
ICAgIGVudHJ5LT5uYW1lMDFbaW5kZXhdID0gYzsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiAr
ICAgIH0NCj4gKyAgICBpbmRleCAtPSBBUlJBWV9TSVpFKGVudHJ5LT5uYW1lMDEpOw0KPiAr
ICAgIGlmIChpbmRleCA8IEFSUkFZX1NJWkUoZW50cnktPm5hbWUwZSkpIHsNCj4gKyAgICAg
ICAgZW50cnktPm5hbWUwZVtpbmRleF0gPSBjOw0KPiArICAgICAgICByZXR1cm47DQo+ICsg
ICAgfQ0KPiArICAgIGluZGV4IC09IEFSUkFZX1NJWkUoZW50cnktPm5hbWUwZSk7DQo+ICsg
ICAgaWYgKGluZGV4IDwgQVJSQVlfU0laRShlbnRyeS0+bmFtZTFjKSkgew0KPiArICAgICAg
ICBlbnRyeS0+bmFtZTFjW2luZGV4XSA9IGM7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICAg
c3RhdGljIGRpcmVudHJ5X3QgKmNyZWF0ZV9sb25nX2ZpbGVuYW1lKEJEUlZWVkZBVFN0YXRl
ICpzLCBjb25zdCBjaGFyICpmaWxlbmFtZSkNCj4gICB7DQo+ICAgICAgIGludCBudW1iZXJf
b2ZfZW50cmllcywgaTsNCj4gICAgICAgZ2xvbmcgbGVuZ3RoOw0KPiAtICAgIGRpcmVudHJ5
X3QgKmVudHJ5Ow0KPiArICAgIGxmbl9kaXJlbnRyeV90ICplbnRyeTsNCj4gICANCj4gICAg
ICAgZ3VuaWNoYXIyICpsb25nbmFtZSA9IGdfdXRmOF90b191dGYxNihmaWxlbmFtZSwgLTEs
IE5VTEwsICZsZW5ndGgsIE5VTEwpOw0KPiAgICAgICBpZiAoIWxvbmduYW1lKSB7DQo+IEBA
IC00MTUsMjQgKzQ0MywyMyBAQCBzdGF0aWMgZGlyZW50cnlfdCAqY3JlYXRlX2xvbmdfZmls
ZW5hbWUoQkRSVlZWRkFUU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmZpbGVuYW1lKQ0KPiAgIA0K
PiAgICAgICBmb3IoaT0wO2k8bnVtYmVyX29mX2VudHJpZXM7aSsrKSB7DQo+ICAgICAgICAg
ICBlbnRyeT1hcnJheV9nZXRfbmV4dCgmKHMtPmRpcmVjdG9yeSkpOw0KPiArICAgICAgICBl
bnRyeS0+c2VxdWVuY2UgPSAobnVtYmVyX29mX2VudHJpZXMgLSBpKSB8IChpID09IDAgPyAw
eDQwIDogMCk7DQo+ICAgICAgICAgICBlbnRyeS0+YXR0cmlidXRlcz0weGY7DQo+IC0gICAg
ICAgIGVudHJ5LT5yZXNlcnZlZFswXT0wOw0KPiArICAgICAgICBlbnRyeS0+ZGlyZW50cnlf
dHlwZSA9IDA7DQo+ICAgICAgICAgICBlbnRyeS0+YmVnaW49MDsNCj4gLSAgICAgICAgZW50
cnktPm5hbWVbMF09KG51bWJlcl9vZl9lbnRyaWVzLWkpfChpPT0wPzB4NDA6MCk7DQo+IC0g
ICAgfQ0KPiAtICAgIGZvcihpPTA7aTwyNipudW1iZXJfb2ZfZW50cmllcztpKyspIHsNCj4g
LSAgICAgICAgaW50IG9mZnNldD0oaSUyNik7DQo+IC0gICAgICAgIGlmKG9mZnNldDwxMCkg
b2Zmc2V0PTErb2Zmc2V0Ow0KPiAtICAgICAgICBlbHNlIGlmKG9mZnNldDwyMikgb2Zmc2V0
PTE0K29mZnNldC0xMDsNCj4gLSAgICAgICAgZWxzZSBvZmZzZXQ9Mjgrb2Zmc2V0LTIyOw0K
PiAtICAgICAgICBlbnRyeT1hcnJheV9nZXQoJihzLT5kaXJlY3RvcnkpLHMtPmRpcmVjdG9y
eS5uZXh0LTEtKGkvMjYpKTsNCj4gKyAgICB9DQo+ICsgICAgZm9yIChpID0gMDsgaSA8IDI2
ICogbnVtYmVyX29mX2VudHJpZXM7IGkrKykgew0KPiArICAgICAgICB1aW50OF90IGM7DQo+
ICsNCj4gKyAgICAgICAgZW50cnkgPSBhcnJheV9nZXQoJnMtPmRpcmVjdG9yeSwgcy0+ZGly
ZWN0b3J5Lm5leHQgLSBpIC8gMjYgLSAxKTsNCj4gICAgICAgICAgIGlmIChpID49IDIgKiBs
ZW5ndGggKyAyKSB7DQo+IC0gICAgICAgICAgICBlbnRyeS0+bmFtZVtvZmZzZXRdID0gMHhm
ZjsNCj4gKyAgICAgICAgICAgIGMgPSAweGZmOw0KPiAgICAgICAgICAgfSBlbHNlIGlmIChp
ICUgMiA9PSAwKSB7DQo+IC0gICAgICAgICAgICBlbnRyeS0+bmFtZVtvZmZzZXRdID0gbG9u
Z25hbWVbaSAvIDJdICYgMHhmZjsNCj4gKyAgICAgICAgICAgIGMgPSBsb25nbmFtZVtpIC8g
Ml0gJiAweGZmOw0KPiAgICAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgIGVudHJ5
LT5uYW1lW29mZnNldF0gPSBsb25nbmFtZVtpIC8gMl0gPj4gODsNCj4gKyAgICAgICAgICAg
IGMgPSBsb25nbmFtZVtpIC8gMl0gPj4gODsNCj4gICAgICAgICAgIH0NCj4gKyAgICAgICAg
d3JpdGVfbG9uZ19maWxlbmFtZShlbnRyeSwgaSAlIDI2LCBjKTsNCj4gICAgICAgfQ0KPiAg
ICAgICBnX2ZyZWUobG9uZ25hbWUpOw0KPiAgICAgICByZXR1cm4gYXJyYXlfZ2V0KCYocy0+
ZGlyZWN0b3J5KSxzLT5kaXJlY3RvcnkubmV4dC1udW1iZXJfb2ZfZW50cmllcyk7DQo+IEBA
IC03MzEsNyArNzU4LDcgQEAgc3RhdGljIGlubGluZSBkaXJlbnRyeV90KiBjcmVhdGVfc2hv
cnRfYW5kX2xvbmdfbmFtZShCRFJWVlZGQVRTdGF0ZSogcywNCj4gICAgICAgICAgIC8qIGNh
bGN1bGF0ZSBhbmV3LCBiZWNhdXNlIHJlYWxsb2MgY291bGQgaGF2ZSB0YWtlbiBwbGFjZSAq
Lw0KPiAgICAgICAgICAgZW50cnlfbG9uZz1hcnJheV9nZXQoJihzLT5kaXJlY3RvcnkpLGxv
bmdfaW5kZXgpOw0KPiAgICAgICAgICAgd2hpbGUoZW50cnlfbG9uZzxlbnRyeSAmJiBpc19s
b25nX25hbWUoZW50cnlfbG9uZykpIHsNCj4gLSAgICAgICAgICAgIGVudHJ5X2xvbmctPnJl
c2VydmVkWzFdPWNoa3N1bTsNCj4gKyAgICAgICAgICAgICgobGZuX2RpcmVudHJ5X3QgKill
bnRyeV9sb25nKS0+c2ZuX2NoZWNrc3VtID0gY2hrc3VtOw0KPiAgICAgICAgICAgICAgIGVu
dHJ5X2xvbmcrKzsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KDQpJIHRlc3RlZCB0aGlz
IHBhdGNoIGFuZCBpdCBjb3JyZWN0bHkgZml4ZXMgdGhlIGlzc3VlIHJlcG9ydGVkIGJ5IHVi
c2FuLCANCndoaWxlIGtlZXBpbmcgdGhlIGZlYXR1cmUgd29ya2luZyBhcyBleHBlY3RlZC4N
Cg0KVGVzdGVkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPg0KDQpUaHVzLCBpdCBjYW4gYmUgbWVyZ2VkIChjYyB0byBxZW11LXRy
aXZpYWwgZm9yIHF1aWNrIGludGVncmF0aW9uKS4NCg0KVGhhbmsgeW91IFZvbGtlciwNClBp
ZXJyaWNrDQoNCg==


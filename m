Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E05E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNMWZ-0004VI-R4; Mon, 16 Dec 2024 20:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNMWX-0004UY-UW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:37:21 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNMWV-00017f-Vr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:37:21 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso5084598b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734399438; x=1735004238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58S9uhqOfe6b2kK2jKkLS81vpX910XTN9+ZeO7HTvTo=;
 b=uBnxxGM6c/gfwLd8p9kavUoqeji7TKdUmUxhZeERhWSWCOZcHcDpGDfqh3vr9KjDdK
 jeUoMfZhFyxrR5VNuRrZe1UaGWlOP294i5bFwdbTUSUcsk/7ykTahISG0fahUFDEGANA
 cGYNWL5EOn5utagv3S+LNNEDtLHai+sXNWVf1iLx8pljp/tcKq3icrg6ZHfPeECWqdXY
 fOpApMmKQTxe32QOHrTxngmMIZYZmi6riRheR8yNjR+VQVf85EwmogJJjSM2ff3T+JWM
 vwoFvdJ7iHJoTAhm0De4dWokLTgHDJitI8wSEpH96H61MxdhOGoA+fvkgV2rJZeQwEwy
 ngIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734399438; x=1735004238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58S9uhqOfe6b2kK2jKkLS81vpX910XTN9+ZeO7HTvTo=;
 b=bixz8sDCKDEKp/07eJ8udBIvp9Bb7scTecPL1HEh3HwkBLM9Dz5fQtDstMtixJozYJ
 LWtg3PXXGiDLshKqbIZml7RVaHC8GixQh6CWqwmmN0QOKSQuEhlf68/BUq1vOFDTfjbz
 6Hqunl2O88ZsEMvRnXFqnqpG9EIIvfJPugnjuJs14gF7JA18gMAby+H2aTjomHfgwphj
 IkTAxog3aYG5KH3YhLLGF9lA8aNLQAybjBjd7Ylp5x8IaFOvYi9hA66y+vvGHwIJttZg
 FkgIhU7WVpl7rAfKnJ4hW5nCzuT7gIrwfIStzqF0km3U6YwJdCaXCyiEXt04TOMbunWl
 c5Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgiFU+h0ARgdIaEja9RqkHlUv9Ie/j0cczucYkm+1GrjW2ieCkw8uW80vNIaGX+iDY47V1eqHTqsh/@nongnu.org
X-Gm-Message-State: AOJu0YzZfOtCYrLihhRZ4A7iiVjBk+DtK2pMUM/O9KRKUYrjWKekCVPI
 PjOEmejVl+J7Gbp/atnxSgy1rZaJwRRYQr8Ga2vwColvEAErrNPkwHtcmTRVWMM=
X-Gm-Gg: ASbGncvBOqrKYtTLmXFraeyf4VT4Rxm3SnUliFUdDA0IosttlkglYFNSSdegE8ZVG9A
 ewIFJ+8aj5g0hQ6CM0IFPTqv34/R6788bq6bQrxIfgi7SwWOZG/uewxqQmoy/ykCzOOnZt+AaIi
 OZTSBJBdVlTHifmqq63hU1sYUoWKE15dEuBrYE1Qdkt94h/0FphjWVhZ2iVarOvTfbCZB30Gyur
 jtFt9mOkKcuLuTLajBQs6dQ+9C9T98qdTNVkWBawkWz7FByB9LDE95m7XtOZpBtbkaD4/xfMFo9
 Cwbq8zjLy/pPurMfwLFMRnitX7gP
X-Google-Smtp-Source: AGHT+IEBgl1hnPj4HXBP9uZZaA3d+A2ih14wjGSoHZ+0RaZbtAoP3bUfaoqg/F/qFJuOQZQwO+Ufkw==
X-Received: by 2002:a05:6a00:32ca:b0:729:49a:2da6 with SMTP id
 d2e1a72fcca58-7290c10d751mr22431588b3a.3.1734399438223; 
 Mon, 16 Dec 2024 17:37:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c3662csm4718560a12.71.2024.12.16.17.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 17:37:17 -0800 (PST)
Message-ID: <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
Date: Mon, 16 Dec 2024 17:37:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gMTIvMTYvMjQgMTE6NTAsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMi8x
Ni8yNCAxMzoyNiwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDEyLzE2LzI0IDEx
OjEwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAxMi80LzI0IDE1OjEyLCBQ
aWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBxZW11LXN5c3RlbS1hYXJjaDY0IGRlZmF1
bHQgcG9pbnRlciBhdXRoZW50aWNhdGlvbiAoUUFSTUE1KSBpcyBleHBlbnNpdmUsIHdlDQo+
Pj4+IHNwZW50IHVwIHRvIDUwJSBvZiB0aGUgZW11bGF0aW9uIHRpbWUgcnVubmluZyBpdCAo
d2hlbiB1c2luZyBUQ0cpLg0KPj4+Pg0KPj4+PiBTd2l0Y2hpbmcgdG8gcGF1dGgtaW1wZGVm
PW9uIGlzIG9mdGVuIGdpdmVuIGFzIGEgc29sdXRpb24gdG8gc3BlZWQgdXAgZXhlY3V0aW9u
Lg0KPj4+PiBUaHVzIHdlIHRhbGtlZCBhYm91dCBtYWtpbmcgaXQgdGhlIG5ldyBkZWZhdWx0
Lg0KPj4+Pg0KPj4+PiBUaGUgZmlyc3QgcGF0Y2ggaW50cm9kdWNlIGEgbmV3IHByb3BlcnR5
IChwYXV0aC1xYXJtYTUpIHRvIGFsbG93IHRvIHNlbGVjdA0KPj4+PiBjdXJyZW50IGRlZmF1
bHQgYWxnb3JpdGhtLg0KPj4+PiBUaGUgc2Vjb25kIG9uZSBjaGFuZ2UgdGhlIGRlZmF1bHQu
DQo+Pj4+DQo+Pj4+IFBpZXJyaWNrIEJvdXZpZXIgKDIpOg0KPj4+PiAgwqDCoMKgIHRhcmdl
dC9hcm06IGFkZCBuZXcgcHJvcGVydHkgdG8gc2VsZWN0IHBhdXRoLXFhcm1hNQ0KPj4+PiAg
wqDCoMKgIHRhcmdldC9hcm06IGNoYW5nZSBkZWZhdWx0IHBhdXRoIGFsZ29yaXRobSB0byBp
bXBkZWYNCj4+Pj4NCj4+Pj4gIMKgwqAgZG9jcy9zeXN0ZW0vYXJtL2NwdS1mZWF0dXJlcy5y
c3QgfMKgIDcgKysrKystLQ0KPj4+PiAgwqDCoCBkb2NzL3N5c3RlbS9pbnRyb2R1Y3Rpb24u
cnN0wqDCoMKgwqAgfMKgIDIgKy0NCj4+Pj4gIMKgwqAgdGFyZ2V0L2FybS9jcHUuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4gIMKgwqAgdGFyZ2V0
L2FybS9hcm0tcW1wLWNtZHMuY8KgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+Pj4+ICDCoMKg
IHRhcmdldC9hcm0vY3B1NjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzMCAr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+Pj4gIMKgwqAgdGVzdHMvcXRlc3Qv
YXJtLWNwdS1mZWF0dXJlcy5jwqDCoCB8IDE1ICsrKysrKysrKysrLS0tLQ0KPj4+PiAgwqDC
oCA2IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0K
Pj4+Pg0KPj4+DQo+Pj4gSSB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uLCBidXQgYXMtaXMg
dGhpcyB3aWxsIGJyZWFrIG1pZ3JhdGlvbi4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyB3aWxs
IG5lZWQgdG8gYmUgdmVyc2lvbmVkIHNvbWVob3csIGJ1dCB0aGUgb25seSB0aGluZyB0aGF0
IHJlYWxseSBnZXRzDQo+Pj4gdmVyc2lvbmVkIGFyZSB0aGUgYm9hcmRzLCBhbmQgSSdtIG5v
dCBzdXJlIGhvdyB0byBsaW5rIHRoYXQgdG8gdGhlIGluc3RhbnRpYXRlZCBjcHUuDQo+Pj4N
Cj4+DQo+PiAgIEZyb20gd2hhdCBJIHVuZGVyc3Rvb2QsIGFuZCBJIG1heSBiZSB3cm9uZywg
dGhlIHVzZSBjYXNlIHRvIG1pZ3JhdGUgKHRjZykgdm0gd2l0aCBjcHUgbWF4DQo+PiBiZXR3
ZWVuIFFFTVUgdmVyc2lvbnMgaXMgKm5vdCogc3VwcG9ydGVkLCBhcyB3ZSBjYW4ndCBndWFy
YW50ZWUgd2hpY2ggZmVhdHVyZXMgYXJlIHByZXNlbnQNCj4+IG9yIG5vdC4NCj4gVGhpcyBk
b2Vzbid0IGFmZmVjdCBvbmx5IC1jcHUgbWF4LCBidXQgYW55dGhpbmcgdXNpbmcgYWFyY2g2
NF9hZGRfcGF1dGhfcHJvcGVydGllcygpOg0KPiBuZW92ZXJzZS1uMSwgbmVvdmVyc2UtbjIs
IGNvcnRleC1hNzEwLg0KPiANCg0KSSB0aGluayB0aGlzIGlzIHN0aWxsIGEgY2hhbmdlIHdv
cnRoIHRvIGRvLCBiZWNhdXNlIHBlb3BsZSBjYW4gZ2V0IGEgDQoxMDAlIHNwZWVkdXAgd2l0
aCB0aGlzIHNpbXBsZSBjaGFuZ2UsIGFuZCBpdCdzIGEgYmV0dGVyIGRlZmF1bHQgdGhhbiB0
aGUgDQpwcmV2aW91cyB2YWx1ZS4NCkluIG1vcmUsIGluIGNhc2Ugb2YgdGhpcyBtaWdyYXRp
b24gc2NlbmFyaW8sIFFFTVUgd2lsbCBpbW1lZGlhdGVseSBhYm9ydCANCnVwb24gYWNjZXNz
aW5nIG1lbW9yeSB0aHJvdWdoIGEgcG9pbnRlci4NCg0KSSdtIG5vdCBzdXJlIGFib3V0IHdo
YXQgd291bGQgYmUgdGhlIGJlc3Qgd2F5IHRvIG1ha2UgdGhpcyBjaGFuZ2UgYXMgDQpzbW9v
dGggYXMgcG9zc2libGUgZm9yIFFFTVUgdXNlcnMuDQoNClBldGVyLCBBbGV4LCBkbyB5b3Ug
aGF2ZSBhbnkgc3VnZ2VzdGlvbiBvbiB0aGlzIHRvcGljPw0KDQpUaGFua3MsDQpQaWVycmlj
aw0KDQo+IA0KPiByfg0KDQo=


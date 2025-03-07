Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6D1C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdGQ-0000m6-5L; Fri, 07 Mar 2025 14:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdD9-0002iS-Kw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:18:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdD8-0004mU-1J
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:18:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fb0f619dso47365255ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375096; x=1741979896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3p9RAOkMR4+J/NKAAm7eKy2q67QMezwc8dkXu0QQvck=;
 b=eaVMsKGiBVW32FN1v4W9/4YSo0RakrXM2Wg7gV0YyHMkMeTIZhbu/Cy6a7WT81fdRP
 uWrUEvwzoUZVrQCxL30PONBRZCJKdvwkdVtA/4CjpBPOqxp96bv/PuX1biTkefNCt+qt
 SlTIRDe00mpNcca/z2N3HpWFgdY5UgJZt5w5oPxRmHZep4CQUYGNcK4j8a2ICvajwRFU
 OOCORbM3vtRCI4naFQezhkP0gK0BF3MyGfllMZtujZoozXvq8AyOEKBx3+gM6ZClAd7G
 Qvi4/4Kz1xepyETNUP0tUe2zqXEvUB9kQdXBieuv1dbB2pF7OVCmCp2fAa44hfZ91Abq
 CB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375096; x=1741979896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3p9RAOkMR4+J/NKAAm7eKy2q67QMezwc8dkXu0QQvck=;
 b=l00VJ4mVRCOb6AiPo01jlT3aIIfcYbyjmxLv84TYveh7sh04Z0/dWf6hJnYlYKRdld
 MwgiLIDtbLoApu5Nqc8VVkdPYmGDaPFKk/umj74vgSwgxxexA1e9wYJqi2gGsSx9UR95
 l7a57blubuTcLvEKohP6iZwRS7vqzVeHaNNUqvbiKMTm8Mqt7yYBdtGC1xIjbu4W4fjh
 a3Mh0G1C3rkCfsUIZAPN+lPF5J5Jb+tEBe6YMz3Xl3+yMGO+PoSL7tIaXJEOr/y7XBwy
 Nc5ouT9tE3i5UBoe73i8RvBawaJq0G+LlODaVQnnw2AENiICKOeUSMjkiAHtDQLBii+9
 sXAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxXAvTwkEE8uQstNQ5kZU0UjMzfB+BIMfx/mIihsO/umGs4uCj1mlrAqAmQFlBSEF9uz2P30Vm54tN@nongnu.org
X-Gm-Message-State: AOJu0Yz8UX7NJ1xxxycApebfYHMmb1Ywvrdvj1k3VMvZMqBAKnxd5j/Q
 hDHd6Cx8bZjECMDsPCJSYX8WZ5XJWtNFypKqRW2EfMIlSx6QKkBXIzM6Z9Tzh9U=
X-Gm-Gg: ASbGnctTb/r4AvpGvRt4dIFRYpVWUhdtPIvj/aDOd77rnvF0urSr10L4yKZXPsGcH5R
 Pl7ozCe8duDrEFdjkaeTApzBQcAA88PumE67qUXU20xdzk6+dGtsLNs95wJsu1eXWbqa+VocFMV
 BC/Vo5Jh9iAnqKobR0f/Ds2DJQ1mgRcFAxUIEyAZaIm+ok/W7NEJ6fj3jKGKjxiHzpBnnm+Yn3h
 3oWyUegC17j2CHtw8eDCiqs6TjL5kn40dNUtEN7wQ04EmWgaDPS33+pO9jm/iZrp63Gy2YtLIxt
 DzRgjMKkvrkrD7SHmNXevtHGftuLZhEq4xMCBlearTrihg9A5qI6v3COiQ==
X-Google-Smtp-Source: AGHT+IFLxvQXq8Q81yznZtKMHT/lFMvLwKw11hMDx5fuvUZsIiMteJnVYk8BhWt8Dqfosdfwi+nC+Q==
X-Received: by 2002:a05:6a20:430a:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-1f544c5fb2bmr8851480637.31.1741375094961; 
 Fri, 07 Mar 2025 11:18:14 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f718bsm3635175b3a.85.2025.03.07.11.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:18:14 -0800 (PST)
Message-ID: <a90fa8c1-c804-4359-b1d9-da8aece5a404@linaro.org>
Date: Fri, 7 Mar 2025 11:18:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/vfio/pci: Convert CONFIG_KVM check to runtime one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVXNl
IHRoZSBydW50aW1lIGt2bV9lbmFibGVkKCkgaGVscGVyIHRvIGNoZWNrIHdoZXRoZXINCj4g
S1ZNIGlzIGF2YWlsYWJsZSBvciBub3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L3Zm
aW8vcGNpLmMgfCAxOSArKysrKysrKystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMNCj4gaW5kZXggZmRiYzE1ODg1ZDQuLjk4
NzI4ODRmZjhhIDEwMDY0NA0KPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ICsrKyBiL2h3L3Zm
aW8vcGNpLmMNCj4gQEAgLTExOCw4ICsxMTgsMTMgQEAgc3RhdGljIHZvaWQgdmZpb19pbnR4
X2VvaShWRklPRGV2aWNlICp2YmFzZWRldikNCj4gICANCj4gICBzdGF0aWMgYm9vbCB2Zmlv
X2ludHhfZW5hYmxlX2t2bShWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApDQo+
ICAgew0KPiAtI2lmZGVmIENPTkZJR19LVk0NCj4gLSAgICBpbnQgaXJxX2ZkID0gZXZlbnRf
bm90aWZpZXJfZ2V0X2ZkKCZ2ZGV2LT5pbnR4LmludGVycnVwdCk7DQo+ICsgICAgaW50IGly
cV9mZDsNCj4gKw0KPiArICAgIGlmICgha3ZtX2VuYWJsZWQoKSkgew0KPiArICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBpcnFfZmQgPSBldmVudF9ub3Rp
Zmllcl9nZXRfZmQoJnZkZXYtPmludHguaW50ZXJydXB0KTsNCj4gICANCj4gICAgICAgaWYg
KHZkZXYtPm5vX2t2bV9pbnR4IHx8ICFrdm1faXJxZmRzX2VuYWJsZWQoKSB8fA0KPiAgICAg
ICAgICAgdmRldi0+aW50eC5yb3V0ZS5tb2RlICE9IFBDSV9JTlRYX0VOQUJMRUQgfHwNCj4g
QEAgLTE3MSwxNiArMTc2LDEzIEBAIGZhaWxfaXJxZmQ6DQo+ICAgZmFpbDoNCj4gICAgICAg
cWVtdV9zZXRfZmRfaGFuZGxlcihpcnFfZmQsIHZmaW9faW50eF9pbnRlcnJ1cHQsIE5VTEws
IHZkZXYpOw0KPiAgICAgICB2ZmlvX3VubWFza19zaW5nbGVfaXJxaW5kZXgoJnZkZXYtPnZi
YXNlZGV2LCBWRklPX1BDSV9JTlRYX0lSUV9JTkRFWCk7DQo+ICsNCj4gICAgICAgcmV0dXJu
IGZhbHNlOw0KPiAtI2Vsc2UNCj4gLSAgICByZXR1cm4gdHJ1ZTsNCj4gLSNlbmRpZg0KPiAg
IH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCB2ZmlvX2ludHhfZGlzYWJsZV9rdm0oVkZJT1BD
SURldmljZSAqdmRldikNCj4gICB7DQo+IC0jaWZkZWYgQ09ORklHX0tWTQ0KPiAtICAgIGlm
ICghdmRldi0+aW50eC5rdm1fYWNjZWwpIHsNCj4gKyAgICBpZiAoIWt2bV9lbmFibGVkKCkg
fHwgIXZkZXYtPmludHgua3ZtX2FjY2VsKSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+ICAg
ICAgIH0NCj4gICANCj4gQEAgLTIxMSw3ICsyMTMsNiBAQCBzdGF0aWMgdm9pZCB2ZmlvX2lu
dHhfZGlzYWJsZV9rdm0oVkZJT1BDSURldmljZSAqdmRldikNCj4gICAgICAgdmZpb191bm1h
c2tfc2luZ2xlX2lycWluZGV4KCZ2ZGV2LT52YmFzZWRldiwgVkZJT19QQ0lfSU5UWF9JUlFf
SU5ERVgpOw0KPiAgIA0KPiAgICAgICB0cmFjZV92ZmlvX2ludHhfZGlzYWJsZV9rdm0odmRl
di0+dmJhc2VkZXYubmFtZSk7DQo+IC0jZW5kaWYNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGlj
IHZvaWQgdmZpb19pbnR4X3VwZGF0ZShWRklPUENJRGV2aWNlICp2ZGV2LCBQQ0lJTlR4Um91
dGUgKnJvdXRlKQ0KPiBAQCAtMjc4LDcgKzI3OSw2IEBAIHN0YXRpYyBib29sIHZmaW9faW50
eF9lbmFibGUoVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICB2
ZGV2LT5pbnR4LnBpbiA9IHBpbiAtIDE7IC8qIFBpbiBBICgxKSAtPiBpcnFbMF0gKi8NCj4g
ICAgICAgcGNpX2NvbmZpZ19zZXRfaW50ZXJydXB0X3Bpbih2ZGV2LT5wZGV2LmNvbmZpZywg
cGluKTsNCj4gICANCj4gLSNpZmRlZiBDT05GSUdfS1ZNDQo+ICAgICAgIC8qDQo+ICAgICAg
ICAqIE9ubHkgY29uZGl0aW9uYWwgdG8gYXZvaWQgZ2VuZXJhdGluZyBlcnJvciBtZXNzYWdl
cyBvbiBwbGF0Zm9ybXMNCj4gICAgICAgICogd2hlcmUgd2Ugd29uJ3QgYWN0dWFsbHkgdXNl
IHRoZSByZXN1bHQgYW55d2F5Lg0KPiBAQCAtMjg3LDcgKzI4Nyw2IEBAIHN0YXRpYyBib29s
IHZmaW9faW50eF9lbmFibGUoVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKQ0K
PiAgICAgICAgICAgdmRldi0+aW50eC5yb3V0ZSA9IHBjaV9kZXZpY2Vfcm91dGVfaW50eF90
b19pcnEoJnZkZXYtPnBkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2ZGV2LT5pbnR4LnBpbik7DQo+ICAgICAgIH0N
Cj4gLSNlbmRpZg0KPiAgIA0KPiAgICAgICByZXQgPSBldmVudF9ub3RpZmllcl9pbml0KCZ2
ZGV2LT5pbnR4LmludGVycnVwdCwgMCk7DQo+ICAgICAgIGlmIChyZXQpIHsNCg0KUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4N
Cg0K


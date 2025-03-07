Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4EFC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdEG-0005s8-9O; Fri, 07 Mar 2025 14:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdCS-0001A2-2z
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:17:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdCP-0004hE-36
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:17:35 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22349bb8605so43700625ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375051; x=1741979851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPLqVn8VYFNzc949TxsQE1MT5WiJdnycfU2e++TtZnQ=;
 b=X19baYRS0GNnaCEAAT+jrG3Mo3shqY/hELObPJPCklqu7ZWCdXROhZ6+J1jaFXlkgQ
 OSV4spel2rCPfFDvVOHzsC5Y8qRShn7ybO2PJLWQskj3gOaO3/Cl0KtgXCEtukPezS/B
 WEdUf4y13s0uuSc+llw1o0IwA69N655D16v0+hmlOBQz0vz+DGE9KAThrVJoHAqm8dFw
 9EneRcEX8vzD3WlqVKK+C166jNqsZyywBjYp4ZWKR814+ncIskf+8PfFHCSS6QaFzkYn
 NAVnEenkJHJgxdjNGnKUu5fBoFtczTJDkgKqxo3VJkupVGBbXqj3ZLah8FdsRZP2K16h
 wP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375051; x=1741979851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPLqVn8VYFNzc949TxsQE1MT5WiJdnycfU2e++TtZnQ=;
 b=aq39GjXqUU2vZXEu1lcek8Lx6gJ/FryZiF3o2NoUeN+32hD7ovJdJONoEK5T0Dn1BD
 lIh/Cq1GDF2/29WHYAV3Ca56WdcHCh2Q78oCQv8kityUVGj4DF7pQEyxEBSFkDEg6A04
 MyNt0pvX++8kMMfQZluWo0W5v2egxx1Of4vyQkWYccv/gwWGAvQan57H7469SOmElgmy
 42aeSfujKMU64Fxz5qW4xMYZUW2ZRjUl7KliORttnrnKIpUZ3xtpQ2yBy/BhYsAZJhfp
 xASvEQd7rmcGlzCFJASIyROADgGk/MuR0+UTBxX0m/4TcO24UXbes/eJQ/NG6H6iaaG1
 XQnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVehBg2/bGlXeSnSg7qdWNyFQ6CF1z8OR6H6vjJxF8o9ATD1R1VyiIQ+ieZulxYf7KvzCxoRaR6LEKe@nongnu.org
X-Gm-Message-State: AOJu0YwlxHdhx2UPULtTVchdHxVNfsuZX9wRJ7N77g3VMnrFpX2vOQRT
 C1bwO2cOGGSpWQz5WHEC0/liGMv7t7WD52oNDGGRgbo/g+AyagC08KbrMjkmW1g=
X-Gm-Gg: ASbGncvQdom81Py9RvODth6suz0Ljcln7aZPzYx9S63bMJeUctHCOTn8mPewbdzQsSK
 TMnMrwyuuM+UeNhzIqixf7KOm0hpYxAGtBuKwm5mUCrcsZbcZYExXqX9vKhxZcxuFZshSgr6AqZ
 rwL06Afiy40DFXjgrHgr2OerbaHAwFNgYXhhiOZK8RTzSKUBEbTamO3g6DLmh/JHx7gxzq9OOaf
 PXo4e3OO345UxioHvIl2ciOi90odFnlSeTX4wVObGjgiHt0bKhjinTzxJGJyumkrEhqyAq3AIRk
 VNRRzfI32WogNG3MUiktH9bNTEt+mUciaPcKHfqonWdcRIz1ak0XiWAJ4A==
X-Google-Smtp-Source: AGHT+IHCOdU1jo4N2/3Xn+NIQXXngzOozOrAD+PVnvNMr/RyYgIxJOFYyvx7SDeOlHhlVEJLZ9Fmug==
X-Received: by 2002:a17:902:ceca:b0:224:2175:b0cd with SMTP id
 d9443c01a7336-22428aa1c02mr61046555ad.26.1741375051398; 
 Fri, 07 Mar 2025 11:17:31 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aaba8csm33790645ad.245.2025.03.07.11.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:17:30 -0800 (PST)
Message-ID: <595c60d9-c77c-40bc-ad00-5964dbe3df64@linaro.org>
Date: Fri, 7 Mar 2025 11:17:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] system/kvm: Expose
 kvm_irqchip_[add,remove]_change_notifier()
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
 <20250307180337.14811-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ3Vy
cmVudGx5IGt2bV9pcnFjaGlwX2FkZF9pcnFmZF9ub3RpZmllcigpIGFuZA0KPiBrdm1faXJx
Y2hpcF9yZW1vdmVfaXJxZmRfbm90aWZpZXIoKSBhcmUgb25seSBkZWNsYXJlZCBvbg0KPiB0
YXJnZXQgc3BlY2lmaWMgY29kZS4gVGhlcmUgaXMgbm90IHBhcnRpY3VsYXIgcmVhc29uIHRv
LA0KPiBhcyB0aGVpciBwcm90b3R5cGVzIGRvbid0IHVzZSBhbnl0aGluZyB0YXJnZXQgcmVs
YXRlZC4NCj4gDQo+IE1vdmUgdGhlaXIgZGVjbGFyYXRpb24gd2l0aCBjb21tb24gcHJvdG90
eXBlcywgYW5kDQo+IGltcGxlbWVudCB0aGVpciBzdHViLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gICBpbmNsdWRlL3N5c3RlbS9rdm0uaCAgIHwgIDggKysrKy0tLS0NCj4gICBhY2NlbC9z
dHVicy9rdm0tc3R1Yi5jIHwgMTIgKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvc3lzdGVtL2t2bS5oIGIvaW5jbHVkZS9zeXN0ZW0va3ZtLmgNCj4gaW5kZXgg
YWIxN2MwOWE1NTEuLjc1NjczZmI3OTRlIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3N5c3Rl
bS9rdm0uaA0KPiArKysgYi9pbmNsdWRlL3N5c3RlbS9rdm0uaA0KPiBAQCAtNDEyLDEwICs0
MTIsNiBAQCBpbnQga3ZtX2lycWNoaXBfc2VuZF9tc2koS1ZNU3RhdGUgKnMsIE1TSU1lc3Nh
Z2UgbXNnKTsNCj4gICANCj4gICB2b2lkIGt2bV9pcnFjaGlwX2FkZF9pcnFfcm91dGUoS1ZN
U3RhdGUgKnMsIGludCBnc2ksIGludCBpcnFjaGlwLCBpbnQgcGluKTsNCj4gICANCj4gLXZv
aWQga3ZtX2lycWNoaXBfYWRkX2NoYW5nZV9ub3RpZmllcihOb3RpZmllciAqbik7DQo+IC12
b2lkIGt2bV9pcnFjaGlwX3JlbW92ZV9jaGFuZ2Vfbm90aWZpZXIoTm90aWZpZXIgKm4pOw0K
PiAtdm9pZCBrdm1faXJxY2hpcF9jaGFuZ2Vfbm90aWZ5KHZvaWQpOw0KPiAtDQo+ICAgc3Ry
dWN0IGt2bV9ndWVzdF9kZWJ1ZzsNCj4gICBzdHJ1Y3Qga3ZtX2RlYnVnX2V4aXRfYXJjaDsN
Cj4gICANCj4gQEAgLTUxNyw2ICs1MTMsMTAgQEAgdm9pZCBrdm1faXJxY2hpcF9yZWxlYXNl
X3ZpcnEoS1ZNU3RhdGUgKnMsIGludCB2aXJxKTsNCj4gICB2b2lkIGt2bV9hZGRfcm91dGlu
Z19lbnRyeShLVk1TdGF0ZSAqcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3Qga3ZtX2lycV9yb3V0aW5nX2VudHJ5ICplbnRyeSk7DQo+ICAgDQo+ICt2b2lkIGt2
bV9pcnFjaGlwX2FkZF9jaGFuZ2Vfbm90aWZpZXIoTm90aWZpZXIgKm4pOw0KPiArdm9pZCBr
dm1faXJxY2hpcF9yZW1vdmVfY2hhbmdlX25vdGlmaWVyKE5vdGlmaWVyICpuKTsNCj4gK3Zv
aWQga3ZtX2lycWNoaXBfY2hhbmdlX25vdGlmeSh2b2lkKTsNCj4gKw0KPiAgIGludCBrdm1f
aXJxY2hpcF9hZGRfaXJxZmRfbm90aWZpZXJfZ3NpKEtWTVN0YXRlICpzLCBFdmVudE5vdGlm
aWVyICpuLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEV2
ZW50Tm90aWZpZXIgKnJuLCBpbnQgdmlycSk7DQo+ICAgaW50IGt2bV9pcnFjaGlwX3JlbW92
ZV9pcnFmZF9ub3RpZmllcl9nc2koS1ZNU3RhdGUgKnMsIEV2ZW50Tm90aWZpZXIgKm4sDQo+
IGRpZmYgLS1naXQgYS9hY2NlbC9zdHVicy9rdm0tc3R1Yi5jIGIvYWNjZWwvc3R1YnMva3Zt
LXN0dWIuYw0KPiBpbmRleCBlY2ZkNzYzNmY1Zi4uYTMwNWIzM2Q4NGQgMTAwNjQ0DQo+IC0t
LSBhL2FjY2VsL3N0dWJzL2t2bS1zdHViLmMNCj4gKysrIGIvYWNjZWwvc3R1YnMva3ZtLXN0
dWIuYw0KPiBAQCAtODMsNiArODMsMTggQEAgdm9pZCBrdm1faXJxY2hpcF9jaGFuZ2Vfbm90
aWZ5KHZvaWQpDQo+ICAgew0KPiAgIH0NCj4gICANCj4gK2ludCBrdm1faXJxY2hpcF9hZGRf
aXJxZmRfbm90aWZpZXIoS1ZNU3RhdGUgKnMsIEV2ZW50Tm90aWZpZXIgKm4sDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEV2ZW50Tm90aWZpZXIgKnJuLCBxZW11
X2lycSBpcnEpDQo+ICt7DQo+ICsgICAgcmV0dXJuIC1FTk9TWVM7DQo+ICt9DQo+ICsNCj4g
K2ludCBrdm1faXJxY2hpcF9yZW1vdmVfaXJxZmRfbm90aWZpZXIoS1ZNU3RhdGUgKnMsIEV2
ZW50Tm90aWZpZXIgKm4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHFlbXVfaXJxIGlycSkNCj4gK3sNCj4gKyAgICByZXR1cm4gLUVOT1NZUzsNCj4gK30N
Cj4gKw0KPiAgIGludCBrdm1faXJxY2hpcF9hZGRfaXJxZmRfbm90aWZpZXJfZ3NpKEtWTVN0
YXRlICpzLCBFdmVudE5vdGlmaWVyICpuLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEV2ZW50Tm90aWZpZXIgKnJuLCBpbnQgdmlycSkNCj4gICB7DQoN
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQoNCg==


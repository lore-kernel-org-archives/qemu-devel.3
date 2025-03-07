Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA7C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdH4-0002Es-Af; Fri, 07 Mar 2025 14:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdBY-00008O-H6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:16:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdBW-0004ay-Ov
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:16:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349bb8605so43688135ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374997; x=1741979797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FcIgjAldmNTlJDpfNudD2honsQ62don2ZnA8aDXXrh8=;
 b=t0hsCXNj+AVXxXeVSurXE4fBlt9/ywuqYXJ4+ZHXSgomPeV9HawMjuJdcn7XpV769v
 V9FCkFopBDUjplhRFMxGgxnmQDK/8w9JDzCa/8DQUIqU58XZ0lRaLKMHvhgQSRKUBWnP
 UuUHHT8uUxL7r2Th/LvvyirPyKKZh49ylzBUIO6dHWDIrm5Ow4e5rsCG7Mjby3+eJKt/
 +DNQvOrQ11hbVRkrWOi3pJVIekdPQoXDXTdYxVsLWKMaH0sDlOeHina6r9BEAalcJota
 /I7nNn0MgPURuMyyqbnZ12c/sEVrZrttCFUzpbP4AOSPMH73kBTYZ6H6dn6TLkjQrHfX
 CLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374997; x=1741979797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcIgjAldmNTlJDpfNudD2honsQ62don2ZnA8aDXXrh8=;
 b=XL9PwZBbsXD1S+Lbrpr8FgUicExb3QBvQF4HY3quM0a8L7mxdhCzGltfIEP6MQ2SE4
 FXc+IaZCxaKZNQgYl9nlUpzuOZvhdNA8pZKagP2lzawpqc9iHbCcVTIFTlchYdFKI5oa
 pXgXOVVdPqrBfEPTefemYMc4A487xcKzsTuUbVqe1pGTdl7fB2tIIS40NuCRKsoqliJ/
 /RLkH8sK+DVQFHN/iZhvasTNe1ZHsOV0noYYiqM1DWhgomamCCKKJlM8nSVAq3FnRaV+
 niX182d2190dMUSLPsjRQBq1NzRpVwVxinhRPj9YZTlFVef7hxNnVFJ9Xo+m9vac3NTf
 +Itg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqkx44FCU9h4+fY2VytMTtF2jvyjY06mo2cwMCC+qK+jr99aiZMxgg3WSysClmlYCxr1fXFlr1fp3u@nongnu.org
X-Gm-Message-State: AOJu0YzhMU/IVUcm+V2pMHmkz+Pv2kfii9lqQCL+LQ1AVDlo2L4vxvp/
 NgoeAuY9j7v9TWgoyc0WJp6z8VHHgyPJ27EIAusM8ICHUSp9HHQpQ3VWI353PC5YFM+f3gUtT0C
 H
X-Gm-Gg: ASbGncuN2XWYbgrJVqix/1HSzjqbHUK/0uAxPATo547hPlq198uHkPDUJ9q2W0kieEj
 QV+YBHWkJYrb7/b0oNW4CufEcYLOxMNvGwR4zSrfzDeFKnCxSfm8e017PhyynEqSAcmo3eOwaAt
 r1Wmfa3OZWTIJiHmcZU9fSVIi3L+B0qQTttHwpTROv9v8K+q/XWaS0KWeak5sFsjr8uhgY7K68w
 R26Mxg3gMWWlByGUEk3Sikf6WQSwrcptHJbSUoVmyckgwI9DuEC7pnoCioieNU4KZR8pwfn/512
 hS2Sujqea3Xa+em4gIQI7y2YWJY5KSLh6/B9/1UMK1pz5ZJJxEAIlKaRwQ==
X-Google-Smtp-Source: AGHT+IFFcAeOjTAjMG3Bag0rUEEDFXr56Mdr47n7HVur2E3bT9phCmlclPDwElxI5OB8yT4Xtbu8iQ==
X-Received: by 2002:a17:903:234f:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22428881fcfmr61990885ad.6.1741374997529; 
 Fri, 07 Mar 2025 11:16:37 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410abb088sm33771545ad.256.2025.03.07.11.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:16:37 -0800 (PST)
Message-ID: <a817e24e-c7b2-45e9-9cd1-81f24465015b@linaro.org>
Date: Fri, 7 Mar 2025 11:16:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
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
 <20250307180337.14811-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQm90
aCBxZW11X21pbnJhbXBhZ2VzaXplKCkgYW5kIHFlbXVfbWF4cmFtcGFnZXNpemUoKSBhcmUN
Cj4gcmVsYXRlZCB0byBob3N0IG1lbW9yeSBiYWNrZW5kcy4gTW92ZSB0aGVpciBwcm90b3R5
cGUNCj4gZGVjbGFyYXRpb24gdG8gInN5c3RlbS9ob3N0bWVtLmgiLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0K
PiAtLS0NCj4gICBpbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaCAgICB8IDMgLS0tDQo+ICAgaW5j
bHVkZS9zeXN0ZW0vaG9zdG1lbS5oICAgfCAzICsrKw0KPiAgIGh3L3BwYy9zcGFwcl9jYXBz
LmMgICAgICAgIHwgMSArDQo+ICAgaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3LmMgfCAxICsN
Cj4gICBody92ZmlvL3NwYXByLmMgICAgICAgICAgICB8IDEgKw0KPiAgIDUgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvZXhlYy9yYW1fYWRkci5oIGIvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgN
Cj4gaW5kZXggOTRiYjNjY2JlNDIuLmNjYzhkZjU2MWFmIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2V4ZWMvcmFtX2FkZHIuaA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0K
PiBAQCAtMTAxLDkgKzEwMSw2IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBpbnQg
cmFtYmxvY2tfcmVjdl9iaXRtYXBfb2Zmc2V0KHZvaWQgKmhvc3RfYWRkciwNCj4gICANCj4g
ICBib29sIHJhbWJsb2NrX2lzX3BtZW0oUkFNQmxvY2sgKnJiKTsNCj4gICANCj4gLWxvbmcg
cWVtdV9taW5yYW1wYWdlc2l6ZSh2b2lkKTsNCj4gLWxvbmcgcWVtdV9tYXhyYW1wYWdlc2l6
ZSh2b2lkKTsNCj4gLQ0KPiAgIC8qKg0KPiAgICAqIHFlbXVfcmFtX2FsbG9jX2Zyb21fZmls
ZSwNCj4gICAgKiBxZW11X3JhbV9hbGxvY19mcm9tX2ZkOiAgQWxsb2NhdGUgYSByYW0gYmxv
Y2sgZnJvbSB0aGUgc3BlY2lmaWVkIGJhY2tpbmcNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
c3lzdGVtL2hvc3RtZW0uaCBiL2luY2x1ZGUvc3lzdGVtL2hvc3RtZW0uaA0KPiBpbmRleCA1
YzIxY2E1NWMwMS4uNjI2NDJlNjAyY2EgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvc3lzdGVt
L2hvc3RtZW0uaA0KPiArKysgYi9pbmNsdWRlL3N5c3RlbS9ob3N0bWVtLmgNCj4gQEAgLTkz
LDQgKzkzLDcgQEAgYm9vbCBob3N0X21lbW9yeV9iYWNrZW5kX2lzX21hcHBlZChIb3N0TWVt
b3J5QmFja2VuZCAqYmFja2VuZCk7DQo+ICAgc2l6ZV90IGhvc3RfbWVtb3J5X2JhY2tlbmRf
cGFnZXNpemUoSG9zdE1lbW9yeUJhY2tlbmQgKm1lbWRldik7DQo+ICAgY2hhciAqaG9zdF9t
ZW1vcnlfYmFja2VuZF9nZXRfbmFtZShIb3N0TWVtb3J5QmFja2VuZCAqYmFja2VuZCk7DQo+
ICAgDQo+ICtsb25nIHFlbXVfbWlucmFtcGFnZXNpemUodm9pZCk7DQo+ICtsb25nIHFlbXVf
bWF4cmFtcGFnZXNpemUodm9pZCk7DQo+ICsNCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBh
L2h3L3BwYy9zcGFwcl9jYXBzLmMgYi9ody9wcGMvc3BhcHJfY2Fwcy5jDQo+IGluZGV4IDkw
NGJmZjg3Y2UxLi45ZTUzZDBjMWZkMSAxMDA2NDQNCj4gLS0tIGEvaHcvcHBjL3NwYXByX2Nh
cHMuYw0KPiArKysgYi9ody9wcGMvc3BhcHJfY2Fwcy5jDQo+IEBAIC0zNCw2ICszNCw3IEBA
DQo+ICAgI2luY2x1ZGUgImt2bV9wcGMuaCINCj4gICAjaW5jbHVkZSAibWlncmF0aW9uL3Zt
c3RhdGUuaCINCj4gICAjaW5jbHVkZSAic3lzdGVtL3RjZy5oIg0KPiArI2luY2x1ZGUgInN5
c3RlbS9ob3N0bWVtLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgImh3L3BwYy9zcGFwci5oIg0K
PiAgIA0KPiBkaWZmIC0tZ2l0IGEvaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3LmMgYi9ody9z
MzkweC9zMzkwLXZpcnRpby1jY3cuYw0KPiBpbmRleCA1MWFlMGMxMzNkOC4uMTI2MWQ5M2I3
Y2UgMTAwNjQ0DQo+IC0tLSBhL2h3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jDQo+ICsrKyBi
L2h3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jDQo+IEBAIC00MSw2ICs0MSw3IEBADQo+ICAg
I2luY2x1ZGUgImh3L3MzOTB4L3RvZC5oIg0KPiAgICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVt
LmgiDQo+ICAgI2luY2x1ZGUgInN5c3RlbS9jcHVzLmgiDQo+ICsjaW5jbHVkZSAic3lzdGVt
L2hvc3RtZW0uaCINCj4gICAjaW5jbHVkZSAidGFyZ2V0L3MzOTB4L2t2bS9wdi5oIg0KPiAg
ICNpbmNsdWRlICJtaWdyYXRpb24vYmxvY2tlci5oIg0KPiAgICNpbmNsdWRlICJxYXBpL3Zp
c2l0b3IuaCINCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vc3BhcHIuYyBiL2h3L3ZmaW8vc3Bh
cHIuYw0KPiBpbmRleCA5YjVhZDA1YmIxYy4uMWE1ZDE2MTFmMmMgMTAwNjQ0DQo+IC0tLSBh
L2h3L3ZmaW8vc3BhcHIuYw0KPiArKysgYi9ody92ZmlvL3NwYXByLmMNCj4gQEAgLTEyLDYg
KzEyLDcgQEANCj4gICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ICAgI2luY2x1ZGUgPGxp
bnV4L3ZmaW8uaD4NCj4gICAjaW5jbHVkZSAic3lzdGVtL2t2bS5oIg0KPiArI2luY2x1ZGUg
InN5c3RlbS9ob3N0bWVtLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvYWRkcmVzcy1zcGFjZXMu
aCINCj4gICANCj4gICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbW1vbi5oIg0KDQpSZXZp
ZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0KDQo=


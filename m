Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A12C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdGU-0000xC-7w; Fri, 07 Mar 2025 14:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdAN-0005sZ-HD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:30 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdAL-0000TQ-9a
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:26 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2239f8646f6so43554455ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374924; x=1741979724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwYc9p1kXttTG6382TJaxB99a5wuQBiYD3sq+AX1GGM=;
 b=NKVXi1Jteo4T1D2/VGVbFaA2KwsnChA0J91aRPU/Qi9iQDZdyDi0XUk4wTtlc1s/3g
 OfT17V0Ev522PON/TYGNeEQd9ChEv+1sPOipzJ3D7TzwVqHzVrbGDH3PwzftoyRgY49x
 wGcJpoI7gah9OPRIufywfLMnc58VVk7WAvxRA2q0QnUzvcMw+EpDwDd2ltglyAHUtK7w
 vpbxnJ5aGpu246d2bDJO30yVV201Q0fQQh9C+OFLX6l2PCRmgZcxDh+B3Q7JRJekswQc
 30uh+qefyfskQs8zozA3M/xCJ/FESUdYpgxXFl1KSnReWig0WhNqMK4h5avKFEDnhoIf
 NVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374924; x=1741979724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwYc9p1kXttTG6382TJaxB99a5wuQBiYD3sq+AX1GGM=;
 b=J4EQb6X4KTzWU4zTD+pXkIdfnF1QCgFYDZ5ChtQC9HYdQqiBRpQmJ3Y1AuqotlpWHt
 Rqu/gca2OU51QjnlR4xVUdfTjCyFm12yUbAEL8NRfSmmJb0X/brtc2bDhe0xMs/csDPz
 yRK+zK1PGBWKT5yvRSTKfoEgojhaMkHgqySb+cRve33ghCBj9u4ucuVspdj2Gp+BWT7p
 vXZXW+WvjpuYcSjFyrDL3bjdgKJdJ7BHli6ptFUV4wawM1edyrOf9TaVJNdZNxkeDcTq
 LY/mSjFGwC1Wef3161cNrbH716OfgweUt86QsR0+1VAguYwpn/sZoxUaxVYySFhV++fo
 EPmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTef/tt3aEVlb2xNQijSiVlLH9wZ8RVstiDtxDc5Alc+AbKZLfb++dJsDniTe6GBn2YE00mkScwyeR@nongnu.org
X-Gm-Message-State: AOJu0Yz8VshkVrGa+iqxXyYC9TVUbOsAJDimHFPXnflKMy/jNXTz2J0c
 De09VpI8Prtfr+iI1XJ93jgznrVirsm9QVk+8f3k/XHvTEQMc3Pv3sqDnYgFozY=
X-Gm-Gg: ASbGncv9z3/e2V9iAS3E0burQBengIVF8YNlGJeyGasXHdLT+bHDDZN4dvG0xw//k0F
 6e3TvMoUjowQaI8SVjgqkAf1DtsSiu6Kw6wdbJvMk2Cvxdb8G5QbySJrGZ/9C6EiYk8PZbKQmfe
 3YOpLqrLk+nbRPKQP58uv+rEsaexMN+iRngd9hP0B8uPL04vroxnUZbitxermdflrvBoqtEFOVd
 PbZXA18ytiCz/bH7NMzdzyoC9Y6uzfrpp8QaNjZ1Y2WElqmNiPP10RXbYte2Um9H4gQduBp29hK
 80naRwh6FPq+DvlZSK+jNxXYsPXLN6+/U1qgynGkyR9DDIUCDwq3SdhiwA==
X-Google-Smtp-Source: AGHT+IGo9prg4b/2FXdagrrmhBEJEH0dcZUgAuL/WOiVD4MA96tJGEQan07XoYtTGmcH/icqlRVVlA==
X-Received: by 2002:a05:6a00:21ce:b0:736:53c5:33ba with SMTP id
 d2e1a72fcca58-736aaabeccemr5719882b3a.16.1741374923813; 
 Fri, 07 Mar 2025 11:15:23 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698243fd6sm3754249b3a.66.2025.03.07.11.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:15:23 -0800 (PST)
Message-ID: <ec744091-da4e-496d-bbb3-90d35fd66161@linaro.org>
Date: Fri, 7 Mar 2025 11:15:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/vfio: Compile some common objects once
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
 <20250307180337.14811-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-4-philmd@linaro.org>
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU29t
ZSBmaWxlcyBkb24ndCByZWx5IG9uIGFueSB0YXJnZXQtc3BlY2lmaWMga25vd2xlZGdlDQo+
IGFuZCBjYW4gYmUgY29tcGlsZWQgb25jZToNCj4gDQo+ICAgLSBoZWxwZXJzLmMNCj4gICAt
IGNvbnRhaW5lci1iYXNlLmMNCj4gICAtIG1pZ3JhdGlvbi5jIChyZW1vdmluZyB1bm5lY2Vz
c2FyeSAiZXhlYy9yYW1fYWRkci5oIikNCj4gICAtIG1pZ3JhdGlvbi1tdWx0aWZkLmMNCj4g
ICAtIGNwci5jDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L3ZmaW8vbWlncmF0aW9uLmMg
fCAgMSAtDQo+ICAgaHcvdmZpby9tZXNvbi5idWlsZCB8IDEzICsrKysrKysrLS0tLS0NCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ody92ZmlvL21pZ3JhdGlvbi5jIGIvaHcvdmZpby9taWdyYXRp
b24uYw0KPiBpbmRleCA0MTY2NDNkZGQ2OS4uZmJmZjQ2Y2ZjMzUgMTAwNjQ0DQo+IC0tLSBh
L2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4gKysrIGIvaHcvdmZpby9taWdyYXRpb24uYw0KPiBA
QCAtMjcsNyArMjcsNiBAQA0KPiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ICAgI2lu
Y2x1ZGUgInFhcGkvcWFwaS1ldmVudHMtdmZpby5oIg0KPiAgICNpbmNsdWRlICJleGVjL3Jh
bWxpc3QuaCINCj4gLSNpbmNsdWRlICJleGVjL3JhbV9hZGRyLmgiDQo+ICAgI2luY2x1ZGUg
InBjaS5oIg0KPiAgICNpbmNsdWRlICJ0cmFjZS5oIg0KPiAgICNpbmNsdWRlICJody9ody5o
Ig0KPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9tZXNvbi5idWlsZCBiL2h3L3ZmaW8vbWVzb24u
YnVpbGQNCj4gaW5kZXggMjYwZDY1ZmViZDYuLjhlMzc2Y2ZjYmY4IDEwMDY0NA0KPiAtLS0g
YS9ody92ZmlvL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L3ZmaW8vbWVzb24uYnVpbGQNCj4g
QEAgLTEsMTIgKzEsNyBAQA0KPiAgIHZmaW9fc3MgPSBzcy5zb3VyY2Vfc2V0KCkNCj4gICB2
ZmlvX3NzLmFkZChmaWxlcygNCj4gLSAgJ2hlbHBlcnMuYycsDQo+ICAgICAnY29tbW9uLmMn
LA0KPiAtICAnY29udGFpbmVyLWJhc2UuYycsDQo+ICAgICAnY29udGFpbmVyLmMnLA0KPiAt
ICAnbWlncmF0aW9uLmMnLA0KPiAtICAnbWlncmF0aW9uLW11bHRpZmQuYycsDQo+IC0gICdj
cHIuYycsDQo+ICAgKSkNCj4gICB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BTRVJJRVMn
LCBpZl90cnVlOiBmaWxlcygnc3BhcHIuYycpKQ0KPiAgIHZmaW9fc3MuYWRkKHdoZW46ICdD
T05GSUdfSU9NTVVGRCcsIGlmX3RydWU6IGZpbGVzKA0KPiBAQCAtMjUsMyArMjAsMTEgQEAg
dmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19WRklPX0FQJywgaWZfdHJ1ZTogZmlsZXMoJ2Fw
LmMnKSkNCj4gICB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZGSU9fSUdEJywgaWZfdHJ1
ZTogZmlsZXMoJ2lnZC5jJykpDQo+ICAgDQo+ICAgc3BlY2lmaWNfc3MuYWRkX2FsbCh3aGVu
OiAnQ09ORklHX1ZGSU8nLCBpZl90cnVlOiB2ZmlvX3NzKQ0KPiArDQo+ICtzeXN0ZW1fc3Mu
YWRkKHdoZW46ICdDT05GSUdfVkZJTycsIGlmX3RydWU6IGZpbGVzKA0KPiArICAnaGVscGVy
cy5jJywNCj4gKyAgJ2NvbnRhaW5lci1iYXNlLmMnLA0KPiArICAnbWlncmF0aW9uLmMnLA0K
PiArICAnbWlncmF0aW9uLW11bHRpZmQuYycsDQo+ICsgICdjcHIuYycsDQo+ICspKQ0KDQpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPg0KDQo=


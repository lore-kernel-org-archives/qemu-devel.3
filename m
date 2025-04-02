Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60979C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 15:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0029-0004oM-G7; Wed, 02 Apr 2025 11:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0027-0004ml-QI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:29:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0025-00054I-W8
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:29:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22423adf751so125758305ad.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743607776; x=1744212576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VsdG4r4USTN1qiJtiYzGcxzjQRU59GC5RfjoU7e7sa0=;
 b=JmLi+/Dex4imDCFv2GxupmR08kAX5CLyqOQyEr9r+CTFh1BxJYfUDUQw/wW716wCLj
 d5L2ng/lJQ++ZMU/zqHUFUcOj1JPI0bHVb/EP7JgeFkFcW1NOo8clNAXwCfSYKi28OQ7
 NtCEU0Rd2MjiCmah+vycIXoqFS6oHaloxUvk8T8QoSRXni8wJF3lacSV5mUDnSQZh5Kv
 G2LpkZqKlX8HTrxY5KLPDZ3sXyj8Zx2Y5LSgxFtMcdAAIgtLxoAkQ818P7X9/pyUh7l+
 AB+Iq1CTifEfrwfBjPgqD+6LggdWbIGZzr03e+GLj0syrNCCpGZArXOYU0rHNEq9WsiI
 s7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607776; x=1744212576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VsdG4r4USTN1qiJtiYzGcxzjQRU59GC5RfjoU7e7sa0=;
 b=nppbDijn5z6g81F6fMLSZy1N0w12RrqLCITIhHijlF9F8bktXTbe1gK9bDp3SrDbK1
 mn3utw39WbsahDre6BcXgxljlgxIUly6rJCsK/jIU4tkICBZuBpre3sYtDk7o1FF7p4N
 IfIWtz/hnkOThl1laqDVSdyuCeKs/qfWh64b8iVWWl6sfYfgREOK2X2IVYRSJA+7U2SE
 Ps9Gex5+RhAc7x9U/leeKvtIS8pN0YgBeIpsSwvA5CjumFpUFUWihznX61TA4/AMKbwh
 wzzkfx3Y7Et3cxVXcln8sFNl0GMLcz80nU7yE/BdWoYu9B3ycekSKuGweN9UizERZ5cQ
 eP0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdE0r/Qzr0fMk2RkXevXKcMEwWDstYU+Zkk4sp6IOLl+Xo2FG2Bqx4+9+960IJR0y7Vj8kQXFfm+J@nongnu.org
X-Gm-Message-State: AOJu0YzJK43jsMnK+wHB0bTwEE+xdw270gYweXXkja7jcc/9h6a+3KPJ
 nV92xBJ0f25YYhZnsVVno4ygPZB4zPB8SeJ6Zswr+sXdYewf37pZhiBW/c0K8Nc=
X-Gm-Gg: ASbGncsEt6qnmInZSqsYGk1bjGKEszChISzCmkLpT/D2Y2K3rrM9qID6FMCa7ydR9wi
 3xcOKnTjTHsT/SfxfDla30te6f3/M2ByEcePnAgZ81x1prwtKVgz0a2ioIQswyRO9iIyddMewpB
 3Od0EHM7O+tntTAoIV5+Qz8LmmLzl6SFzQQW/pHOdmuxxfZnFiy7+tfwJVbhCG/U0VKS0aCZKmV
 Z+d/1dFvFa+aa3MFMxhu5gciikSVcB4tCbLmeW/n8cARAPB0SGDox12crHJMaE6LQbT1+BeOITV
 L82dIBApZ4Wke/rl1To/XdIpxtC0HkAQKun70GQ08drT7zg1pj0HfDVi2Q==
X-Google-Smtp-Source: AGHT+IGOsVL2SQoJqcx3R6L4Tof7xXmuuleQdfjWtLgOktk/bvreIcOK/lnol5PAfIu3jdLDCrJD+g==
X-Received: by 2002:a17:902:ce12:b0:226:3781:379d with SMTP id
 d9443c01a7336-2295c0ed130mr100544425ad.33.1743607775785; 
 Wed, 02 Apr 2025 08:29:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f7cc2sm109045095ad.258.2025.04.02.08.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 08:29:35 -0700 (PDT)
Message-ID: <cc8ed8b6-da31-4b21-9971-6550ab091c3d@linaro.org>
Date: Wed, 2 Apr 2025 08:29:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/arm: Move CPU QOM type definitions to
 "hw/arm/cpu.h"
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20230110164406.94366-1-philmd@linaro.org>
 <20230110164406.94366-6-philmd@linaro.org>
 <325310d0-aad6-fc39-748a-80762d644dd8@linaro.org>
 <b91019e8-1a75-d968-c842-1d040b32a431@linaro.org>
 <6ea2ab5a-47fd-45d3-85c9-36a8ac3c8b18@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6ea2ab5a-47fd-45d3-85c9-36a8ac3c8b18@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gNC8xLzI1IDIxOjA2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ2Mn
aW5nIFBpZXJyaWNrDQo+IA0KPiBPbiAxMi8xLzIzIDA4OjE3LCBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSB3cm90ZToNCj4+IE9uIDExLzEvMjMgMjE6MDIsIFJpY2hhcmQgSGVuZGVyc29u
IHdyb3RlOg0KPj4+IE9uIDEvMTAvMjMgMDg6NDMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IHdyb3RlOg0KPj4+PiArKysgYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4+IEBAIC0yNiw2ICsy
Niw3IEBADQo+Pj4+ICDCoCAjaW5jbHVkZSAiY3B1LXFvbS5oIg0KPj4+PiAgwqAgI2luY2x1
ZGUgImV4ZWMvY3B1LWRlZnMuaCINCj4+Pj4gIMKgICNpbmNsdWRlICJxYXBpL3FhcGktdHlw
ZXMtY29tbW9uLmgiDQo+Pj4+ICsjaW5jbHVkZSAiaHcvYXJtL2NwdS5oIg0KPj4+DQo+Pj4g
SSdtIG5vdCBhIGZhbiBvZiB0aGlzLg0KPj4+DQo+Pj4gSWYgeW91IHdhbnQgYSBzbWFsbGVy
IHZlcnNpb24gb2YgY3B1LXFvbS5oIGhlcmUgaW4gdGFyZ2V0L2FybS8sIGZvcg0KPj4+IHVz
ZSBieSBody8sIHRoYXQncyBvbmUgdGhpbmcuwqAgQnV0IHRhcmdldC8gc2hvdWxkIG5vdCBi
ZSByZWFjaGluZyBiYWNrDQo+Pj4gaW50byBody8sIElNTy4NCj4+DQo+PiBJIGNvbmN1ciwg
YnV0IGN1cnJlbnRseSB3ZSBoYXZlOg0KPj4NCj4+ICQgZ2l0IGdyZXAgJyNpbmNsdWRlICJo
dycgdGFyZ2V0IHwgd2MgLWwNCj4+ICAgwqDCoMKgwqAgMjIwDQo+Pg0KPj4gJCBnaXQgZ3Jl
cCAtaCAnI2luY2x1ZGUgImh3JyB0YXJnZXQgfCBzb3J0IHwgdW5pcSAtYw0KPj4gICDCoMKg
IDEgI2luY2x1ZGUgImh3L2FjcGkvYWNwaS5oIg0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3
L2FjcGkvZ2hlcy5oIg0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3L2FybS9ib290LmgiDQo+
PiAgIMKgwqAgMSAjaW5jbHVkZSAiaHcvYXJtL3ZpcnQuaCINCj4+ICAgwqAgMTkgI2luY2x1
ZGUgImh3L2JvYXJkcy5oIg0KPj4gICDCoMKgIDIgI2luY2x1ZGUgImh3L2Nsb2NrLmgiDQo+
PiAgIMKgwqAgMyAjaW5jbHVkZSAiaHcvY29yZS9hY2NlbC1jcHUuaCINCj4+ICAgwqAgMjQg
I2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+PiAgIMKgIDIwICNpbmNsdWRlICJody9jb3Jl
L3N5c2VtdS1jcHUtb3BzLmgiDQo+PiAgIMKgIDI0ICNpbmNsdWRlICJody9jb3JlL3RjZy1j
cHUtb3BzLmgiDQo+PiAgIMKgwqAgMSAjaW5jbHVkZSAiaHcvaHBwYS9ocHBhX2hhcmR3YXJl
LmgiDQo+PiAgIMKgwqAgMyAjaW5jbHVkZSAiaHcvaHcuaCINCj4+ICAgwqDCoCAxICNpbmNs
dWRlICJody9oeXBlcnYvaHlwZXJ2LXByb3RvLmgiDQo+PiAgIMKgwqAgMiAjaW5jbHVkZSAi
aHcvaHlwZXJ2L2h5cGVydi5oIg0KPj4gICDCoMKgIDIgI2luY2x1ZGUgImh3L2kzODYvYXBp
Yy1tc2lkZWYuaCINCj4+ICAgwqDCoCAyICNpbmNsdWRlICJody9pMzg2L2FwaWMuaCINCj4+
ICAgwqDCoCA4ICNpbmNsdWRlICJody9pMzg2L2FwaWNfaW50ZXJuYWwuaCINCj4+ICAgwqDC
oCAxICNpbmNsdWRlICJody9pMzg2L2U4MjBfbWVtb3J5X2xheW91dC5oIg0KPj4gICDCoMKg
IDEgI2luY2x1ZGUgImh3L2kzODYvaW50ZWxfaW9tbXUuaCINCj4+ICAgwqDCoCAxICNpbmNs
dWRlICJody9pMzg2L2lvYXBpYy5oIg0KPj4gICDCoMKgIDIgI2luY2x1ZGUgImh3L2kzODYv
cGMuaCINCj4+ICAgwqDCoCAxICNpbmNsdWRlICJody9pMzg2L3NneC1lcGMuaCINCj4+ICAg
wqDCoCAxICNpbmNsdWRlICJody9pMzg2L3RvcG9sb2d5LmgiDQo+PiAgIMKgwqAgMSAjaW5j
bHVkZSAiaHcvaTM4Ni94ODYtaW9tbXUuaCINCj4+ICAgwqDCoCAyICNpbmNsdWRlICJody9p
Mzg2L3g4Ni5oIg0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3L2ludGMvcmlzY3ZfYWNsaW50
LmgiDQo+PiAgIMKgwqAgOCAjaW5jbHVkZSAiaHcvaXJxLmgiDQo+PiAgIMKgwqAgMSAjaW5j
bHVkZSAiaHcvaXNhL2lzYS5oIg0KPj4gICDCoMKgIDUgI2luY2x1ZGUgImh3L2xvYWRlci5o
Ig0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3L2xvb25nYXJjaC92aXJ0LmgiDQo+PiAgIMKg
wqAgMiAjaW5jbHVkZSAiaHcvbWlwcy9jcHVkZXZzLmgiDQo+PiAgIMKgwqAgMiAjaW5jbHVk
ZSAiaHcvcGNpL21zaS5oIg0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3L3BjaS9tc2l4Lmgi
DQo+PiAgIMKgwqAgMyAjaW5jbHVkZSAiaHcvcGNpL3BjaS5oIg0KPj4gICDCoMKgIDEgI2lu
Y2x1ZGUgImh3L3BwYy9vcGVucGljX2t2bS5oIg0KPj4gICDCoMKgIDUgI2luY2x1ZGUgImh3
L3BwYy9wcGMuaCINCj4+ICAgwqDCoCAyICNpbmNsdWRlICJody9wcGMvc3BhcHIuaCINCj4+
ICAgwqDCoCAxICNpbmNsdWRlICJody9wcGMvc3BhcHJfY3B1X2NvcmUuaCINCj4+ICAgwqDC
oCAyICNpbmNsdWRlICJody9xZGV2LWNsb2NrLmgiDQo+PiAgIMKgIDEyICNpbmNsdWRlICJo
dy9xZGV2LXByb3BlcnRpZXMuaCINCj4+ICAgwqAgMTEgI2luY2x1ZGUgImh3L3JlZ2lzdGVy
ZmllbGRzLmgiDQo+PiAgIMKgwqAgMiAjaW5jbHVkZSAiaHcvczM5MHgvZWJjZGljLmgiDQo+
PiAgIMKgwqAgNSAjaW5jbHVkZSAiaHcvczM5MHgvaW9pbnN0LmgiDQo+PiAgIMKgwqAgMiAj
aW5jbHVkZSAiaHcvczM5MHgvaXBsLmgiDQo+PiAgIMKgwqAgOCAjaW5jbHVkZSAiaHcvczM5
MHgvcHYuaCINCj4+ICAgwqDCoCAyICNpbmNsdWRlICJody9zMzkweC9zMzkwLXBjaS1idXMu
aCINCj4+ICAgwqDCoCAyICNpbmNsdWRlICJody9zMzkweC9zMzkwLXBjaS1pbnN0LmgiDQo+
PiAgIMKgwqAgMiAjaW5jbHVkZSAiaHcvczM5MHgvczM5MC12aXJ0aW8tY2N3LmgiDQo+PiAg
IMKgwqAgMiAjaW5jbHVkZSAiaHcvczM5MHgvczM5MC12aXJ0aW8taGNhbGwuaCINCj4+ICAg
wqDCoCAzICNpbmNsdWRlICJody9zMzkweC9zMzkwX2ZsaWMuaCINCj4+ICAgwqDCoCAxICNp
bmNsdWRlICJody9zMzkweC9zY2xwLmgiDQo+PiAgIMKgwqAgMiAjaW5jbHVkZSAiaHcvczM5
MHgvc3RvcmFnZS1rZXlzLmgiDQo+PiAgIMKgwqAgMSAjaW5jbHVkZSAiaHcvczM5MHgvdG9k
LmgiDQo+PiAgIMKgwqAgMSAjaW5jbHVkZSAiaHcvc2g0L3NoX2ludGMuaCINCj4+ICAgwqDC
oCAyICNpbmNsdWRlICJody9zeXNidXMuaCINCj4+ICAgwqDCoCAxICNpbmNsdWRlICJody93
YXRjaGRvZy93ZHRfZGlhZzI4OC5oIg0KPj4gICDCoMKgIDEgI2luY2x1ZGUgImh3L3h0ZW5z
YS94dGVuc2EtaXNhLmgiDQo+Pg0KPj4gQXNzdW1pbmcgd2Ugd2FudCB0byBoYXZlIGEgc2Vs
Zi1jb250YWluZWQgbGlidGFyZ2V0JGFyY2gsIGhvdyBjYW4gd2UNCj4+IGRlYWwgd2l0aCBI
VyB0aWVkIHRvIHRoZSBhcmNoIHN1Y2ggQ1BVIHRpbWVycyBvciBOVklDPw0KDQpJdCdzIG5v
dCB3aGF0IHdlJ2xsIGFjaGlldmUuDQpSaWdodCBub3csIHdoYXQgd2UgY2FsbCBsaWJYIGlu
IG1lc29uLmJ1aWxkIGlzIHNpbXBseSBhIHNlbGVjdGlvbiBvZiANCm9iamVjdCBmaWxlcywg
d2l0aG91dCBhbnkgZ3VhcmFudGVlIHRoYXQgdGhleSBkb24ndCBoYXZlIGV4dGVybmFsIA0K
ZGVwZW5kZW5jeSBvbiBzeW1ib2xzIGZyb20gb3RoZXIgbGlicmFyaWVzLiBXZSB1c2UgdGhh
dCB0byBhcHBseSANCnNwZWNpZmljIGNvbXBpbGF0aW9uIGZsYWdzIHRvIGEgc2V0IG9mIGZp
bGVzLCBhbmQgdGhpcyBpcyB3aGF0IHdlIHJlYWxseSANCmFjaGlldmUgaGVyZS4NCg0KWWVz
LCBpZGVhbGx5LCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgaHcgd2FzIGEgbGVhZiBsaWJyYXJ5
IGluIG91ciANCmRlcGVuZGVuY3kgZ3JhcGguDQpIb3dldmVyLCBpdCdzIG5vdCBuZWVkZWQg
dG8gc29sdmUgdGhpcyBub3csIGFuZCBpdCdzIG5vdCB1bmJsb2NraW5nIA0KYW55dGhpbmcg
dG8gYmUgYWJsZSB0byBidWlsZCBhIHNpbmdsZSBiaW5hcnksIHNvIEkgZG9uJ3Qgc2VlIGl0
IGFzIGEgDQpwcmlvcml0eS4NCg0KPiANCg0K


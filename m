Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA12C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubbU-0005QJ-MR; Tue, 18 Mar 2025 14:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tubbO-0005PA-F5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:23:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tubbM-0003gt-2A
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:23:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so12494045ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742322222; x=1742927022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zhdlHNWmjY0/U0RTVbqd1beK1I5dVapYlQeofi/XGMw=;
 b=cTisoaLGcU95jFZQzOUAz2P5y+ni+DO7pNmFnsW50TWWXhbVq5xr+n1gjhsretFYSk
 cN8/uXsjKAvFrMdBAn89Sn0N0umaR2cGA5K0cIa156/rWLtG/VNr1UG8Vk4Qg+T0A4DG
 A7LhlgxtCOnxYhbWJtHLATAogu6Erca3MtCWyi3bdd85cwUfDZdlIt+jbAqQFDUBPUB6
 0YWXV6+wPWIi1q2Lmc/jsUFv1g83Gc0YK2Mplg7d/+W5VRjoM3naC8EoxdnoV2CDaDTi
 fHlnlYKCDMUD07kOcmVwJojRSSMRYHh5ZErRyqPOvVEM4UiB2r9pDhP06ERcS897+Wss
 2Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742322222; x=1742927022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhdlHNWmjY0/U0RTVbqd1beK1I5dVapYlQeofi/XGMw=;
 b=r20oU11lNpmsVUu9vd72a/3fsjSgxaCtlC8trMrwLe8H0YW1EuyIH2m54V7ZZSqcrs
 jZDuWRgjpS7o791OjD2Y6zFYeDcuI3E77iazR1snjEJYbn/4u3GFHbq1SMutoh3yDtFN
 kyjCtmrd1noO2kHeRyeIMhmNS109gZ530pyDnayWcMNj+/WQ7i8QYUfuTY8MCdvnhgtV
 TB9s1TpyV3XuIXqf0RMgMWIbwKvjhJOodKPIavrSdvGMrh9m9ZQoD6hKq6x0IqFNVOLI
 pVEwM8lk+SgKXgGO/M3iQmIiw3+2b4UUwc7oMIzGXxQlnYFNYuuRCV0vGz7XvAUQKi98
 cU4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs+bLE3ei6X7JAkQ2PjNEZ41DqB+yRbm5nwJ3qjZGAjDmFnU2eT9M6r3Do7pogc77Q0UTQ+FfrpbOP@nongnu.org
X-Gm-Message-State: AOJu0YzmmhH8RDvnu77ErVgeXgusMlrvLk2URqPxW/s4p0o2DJtZcz8Y
 f5rsQ13Br9sDhEDalYIZGApWsH+x5gNGZH/zxMjqYLDe4pEASpk2g3diIUnxoN0=
X-Gm-Gg: ASbGncvm7phhzS+j1cOwll2nPzMJsQoIatqmuzgyecFkPWsr8Pb3cQ28KOsiWeK6gZZ
 WcP+X7N52sphkJCAJWu7x13KDG3cuvgQajzLkMM+poG2pvkUFVxCt36Rz0BjE7gT+YgJfGqFG50
 jTYSCtC9ZPFW+6u8AJfvvGtjJvDTUptd46S+hbUBnK9APWca2Cac0HTGIsEyfT2bg/iHEGgWP7g
 quUnDjf8gFbySa6+VYn0SS+o9eRR01lsqKBTy+5EcZu2giq7oxx7g7qBEGWwWCJOgytuuImzYGv
 oCIB1Mtit9lBN+zSeLP6+vfDT+XbYl+lwlcTqXyEzyRJL8PfE4QeUNJ+sA==
X-Google-Smtp-Source: AGHT+IF2LvaZ3PEnsxaSBKWmFbnLT1gdeU7gnXTv95cW5ygVp8xR52qeX2fRpo9WNGk6os/wtQpMKA==
X-Received: by 2002:aa7:888a:0:b0:736:baa0:2acd with SMTP id
 d2e1a72fcca58-73722460be6mr24957668b3a.20.1742322222270; 
 Tue, 18 Mar 2025 11:23:42 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371157369bsm9893539b3a.75.2025.03.18.11.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:23:41 -0700 (PDT)
Message-ID: <ab9b15c1-4f59-4fce-88fd-028fd21875c3@linaro.org>
Date: Tue, 18 Mar 2025 11:23:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/arm/cpu: always define kvm related registers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-8-pierrick.bouvier@linaro.org>
 <fa3c4676-f78c-42af-b572-559640c0e4f7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fa3c4676-f78c-42af-b572-559640c0e4f7@linaro.org>
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

T24gMy8xOC8yNSAxMToxNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzMvMjUgMDU6NTEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBUaGlzIGRvZXMg
bm90IGh1cnQsIGV2ZW4gaWYgdGhleSBhcmUgbm90IHVzZWQuDQo+IA0KPiBJJ20gbm90IGNv
bnZpbmNlZCBieSB0aGUgcmF0aW9uYWxlLg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0N
Cj4+ICAgIHRhcmdldC9hcm0vY3B1LmggfCAyIC0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuaCBi
L3RhcmdldC9hcm0vY3B1LmgNCj4+IGluZGV4IDIzYzIyOTNmN2QxLi45NmY3ODAxYTIzOSAx
MDA2NDQNCj4+IC0tLSBhL3RhcmdldC9hcm0vY3B1LmgNCj4+ICsrKyBiL3RhcmdldC9hcm0v
Y3B1LmgNCj4+IEBAIC05NzEsNyArOTcxLDYgQEAgc3RydWN0IEFyY2hDUFUgew0KPj4gICAg
ICAgICAqLw0KPj4gICAgICAgIHVpbnQzMl90IGt2bV90YXJnZXQ7DQo+PiAgICANCj4+IC0j
aWZkZWYgQ09ORklHX0tWTQ0KPj4gICAgICAgIC8qIEtWTSBpbml0IGZlYXR1cmVzIGZvciB0
aGlzIENQVSAqLw0KPj4gICAgICAgIHVpbnQzMl90IGt2bV9pbml0X2ZlYXR1cmVzWzddOw0K
Pj4gICAgDQo+PiBAQCAtOTg0LDcgKzk4Myw2IEBAIHN0cnVjdCBBcmNoQ1BVIHsNCj4+ICAg
IA0KPj4gICAgICAgIC8qIEtWTSBzdGVhbCB0aW1lICovDQo+PiAgICAgICAgT25PZmZBdXRv
IGt2bV9zdGVhbF90aW1lOw0KPj4gLSNlbmRpZiAvKiBDT05GSUdfS1ZNICovDQo+IA0KPiBN
YXliZSB3ZSBuZWVkIGFuIG9wYXF1ZSBBcmNoQWNjZWxDcHVTdGF0ZSBzdHJ1Y3R1cmUuLi4N
Cj4gDQoNCkl0J3Mgc2ltaWxhciB0byB0aGUgaW50ZXJlc3RpbmcgcXVlc3Rpb24gb2YgaG93
IHRvIGV4cG9zZSBzb21lIHJlZ2lzdGVycyANCmNvbmRpdGlvbm5hbGx5Lg0KDQpXZSBjb3Vs
ZCBwdXQgdGhpcyBpbiBhbm90aGVyIHN0cnVjdCwgYWxsb2NhdGUgaWYgb25seSBpZiBuZWVk
ZWQgDQooa3ZtX2VuYWJsZWQoKSksIG9yIGp1c3QgbGV0IGl0IGJlIHByZXNlbnQgYW55dGlt
ZSBsaWtlIGl0IGlzIGRvbmUgd2l0aCANCnRoaXMgcGF0Y2guDQoNCkkgZG9uJ3QgaGF2ZSBh
IHN0cm9uZyBvcGluaW9uLCBidXQgaGF2aW5nIGNvbmRpdGlvbmFsIHByZXNlbmNlIGhlcmUg
aXMgDQpqdXN0IG1ha2luZyB0aGluZ3MgY29tcGxpY2F0ZWQgd2l0aG91dCBpbnRyb2R1Y2lu
ZyBhbnkgYmVuZWZpdC4gSXQgZG9lcyANCm5vdCBwcmV2ZW50ICJ1bmF1dGhvcml6ZWQiIGFj
Y2VzcyB0byBpdC4NCg0KTm93LCBpZiB3ZSBzdGFydCB0byBoYXZlIHNvbWV0aGluZyBtb3Jl
IGNsZWFuLCBpbXBsZW1lbnRlZCBpbiBhbm90aGVyIA0KY29tcGlsYXRpb24gdW5pdHMsIG9u
bHkgcmVsYXRlZCB0byBrdm0sIHdlbGwsIHRoYXQgY291bGQgYmUgdXNlZnVsLiBCdXQgDQp3
ZSBoYXZlIHRvIGRlZmluZSB0aGUgaW50ZXJmYWNlIGZvciB0aGF0LCBhZGQgaXQgdG8gb3Ro
ZXIgYXJjaGl0ZWN0dXJlcywgDQphbmQgcHJvYmFibHkgc3BlbmQgYSBmZXcgbW9udGhzIGlu
IHRoZSBtaWRkbGUgd2hlcmUgdGhpbmdzIGFyZSBzdHVjayBoZXJlLg0KDQo+PiAgICANCj4+
ICAgICAgICAvKiBVbmlwcm9jZXNzb3Igc3lzdGVtIHdpdGggTVAgZXh0ZW5zaW9ucyAqLw0K
Pj4gICAgICAgIGJvb2wgbXBfaXNfdXA7DQo+IA0KDQo=


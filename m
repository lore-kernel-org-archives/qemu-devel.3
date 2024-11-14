Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F2D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRCd-0003ip-Fp; Wed, 13 Nov 2024 23:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCW-0003XY-3Z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:24 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCT-0003b2-PE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:23 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ee6edc47abso89524a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557480; x=1732162280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jv9JiIWJE1vzQVPFyvVwvDKEKOfDWoMPFigOySU3qgw=;
 b=zNzK514WlKK8evfTj7y47cPUnVjyL28uYkU3sEY1ajILwftsqwsFs7ggTF4kfRvDt2
 RXa/dQiFKpL743sndAGb1TCWPKl7IeWDXIHztwXESwl/lvLrw+Tdrtvj8mHtm6HdZLhk
 YWBtIL2jDzt3TwMQVghvYRCtAwwW1WQJfZ66c7tzYzLj7OZG9BINqEz2hikEaMQJFPzW
 XDkaTxoO0MUPPwyExA5qYLbSXngkXvgYEim60aE3QLVcWWtnE2JolaBpA5q3KL4F4aAa
 Am8Mx/VCjH4Nz0wlq8amRHmYEqt9m6m8ZVfEHFE7T2R2MB6eX2MEqOk2g2nnlZFRyzKh
 hVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557480; x=1732162280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jv9JiIWJE1vzQVPFyvVwvDKEKOfDWoMPFigOySU3qgw=;
 b=Yp26MO9/g1z1rxzPrWm31+jJ5OBkVxkRMX93rSxoibeZZNjZfeDsEAJqPZbU/j08PS
 Z88KF0S9DKnfgTuOae+7pqoAgsTGIlOGSRdNZ7rAjVGZeLYFfxtEc5VwO2WaAQy9Pgt6
 j4+K5K9qE3o43LflK8bcl9yvYxPE7egxgzWRrMqoMSQ3RNFuDM7UOXJ25ZikzUxuLIUT
 h7IH294BDZMbWFKBvLUwMxoRrOyB+s57TZ+p7Q33P32KU3W0yTsFtqOeCdq7p5FCvNeF
 LMuoYD4TfPmTCroAkW6FPdxo9AXlZJUKvCzaDq+1uOPtLT6NCZ3ThjBLPs3jbr1smXX1
 +17A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPjdIPOiXr8Riel36qC4U6hGr1bv8Q2Xs64nPwXPMdbOp8gQCSkKDNsZv7ubTuMTf5WG97fB2M2Rp+@nongnu.org
X-Gm-Message-State: AOJu0YxGCT7p10fIBkFbKgEz0PrcwF6ZtBOdZNln99lBG9dRBGbJ0NQO
 DXDA5NqGjD/4PjCzuFPw7Q9Pj/X2eS+Ipbc9X7fEBfXXDKpBDtUKDWBYXzMS714=
X-Google-Smtp-Source: AGHT+IFoAFkaZFZZOJ7c9cP095EN8WOpPtRWl4mfrdTnHnZbBu2sZ5qMOL69fVHp1jC2U5l3LhQysA==
X-Received: by 2002:a05:6a20:7484:b0:1db:e338:b5bc with SMTP id
 adf61e73a8af0-1dc832a5e81mr1115831637.5.1731557480361; 
 Wed, 13 Nov 2024 20:11:20 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bcfc0sm242604b3a.163.2024.11.13.20.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:19 -0800 (PST)
Message-ID: <5270010b-5deb-488c-83b2-f8cb8b6966ae@linaro.org>
Date: Wed, 13 Nov 2024 20:11:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/i386/helper: Include missing
 'exec/translation-block.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gVEIgY29tcGlsZSBmbGFncyBhcmUgZGVmaW5lZCBpbiAiZXhlYy90cmFuc2xhdGlvbi1i
bG9jay5oIi4NCj4gSW5jbHVkZSBpdCBpbiBvcmRlciB0byBhdm9pZCB3aGVuIHJlZmFjdG9y
aW5nOg0KPiANCj4gICAgdGFyZ2V0L2kzODYvaGVscGVyLmM6NTM2OjI4OiBlcnJvcjogdXNl
IG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnQ0ZfUENSRUwnDQo+ICAgICAgNTM2IHwgICAg
IGlmICh0Y2dfY2ZsYWdzX2hhcyhjcywgQ0ZfUENSRUwpKSB7DQo+ICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0YXJn
ZXQvaTM4Ni9oZWxwZXIuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2hlbHBlci5jIGIvdGFyZ2V0
L2kzODYvaGVscGVyLmMNCj4gaW5kZXggMDFhMjY4YTMwYi4uNzVjNTJlMjE0MyAxMDA2NDQN
Cj4gLS0tIGEvdGFyZ2V0L2kzODYvaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L2kzODYvaGVs
cGVyLmMNCj4gQEAgLTIxLDYgKzIxLDcgQEANCj4gICAjaW5jbHVkZSAicWFwaS9xYXBpLWV2
ZW50cy1ydW4tc3RhdGUuaCINCj4gICAjaW5jbHVkZSAiY3B1LmgiDQo+ICAgI2luY2x1ZGUg
ImV4ZWMvZXhlYy1hbGwuaCINCj4gKyNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2Nr
LmgiDQo+ICAgI2luY2x1ZGUgInN5c2VtdS9ydW5zdGF0ZS5oIg0KPiAgICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQ0KPiAgICNpbmNsdWRlICJzeXNlbXUvaHdfYWNjZWwuaCINCg0KUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCg0K


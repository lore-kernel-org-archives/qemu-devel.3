Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CBBC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD0j-0007nW-7F; Mon, 17 Mar 2025 12:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuD00-0007Yp-EA
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:07:34 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuCzs-0002ho-5O
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:07:26 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so2717211a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742227642; x=1742832442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBROt8Wvg39oI6RJKUKBStbr1ifb9ytbzgO6Y+lRt3Q=;
 b=n2iajuZ9Q9fyjzHSbg58R66YRMzKdQhRw4V5luxxFanQnfVZKIcwbsEEEg2+XwbNPH
 KXIfWxgsrnaomFmHf4MoSQ8sF8yaQ8Gg2HfYsP//DUWzO1eVT/WwdqlWHiqavIDJbxf/
 H8QpSg1JtIy39b+2yL8ZA0NQtEgAlyc3mG+sfu2D8fa/To/zyMtC4aHIWGULsJACAckh
 BrTxVkYu6mrm9lD4iPKYK9rqi9CaXVr6WdVL6XLvFRVlxvvywu0r5GskNZZiOwhGGhKt
 S1OuxLbcbZ5NXdur+prUrUPylKD5lVUVsGxxH1/GRWyYK19lD+O3IiRoFco7AngTRhUS
 ps4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742227642; x=1742832442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBROt8Wvg39oI6RJKUKBStbr1ifb9ytbzgO6Y+lRt3Q=;
 b=haISP34Z9jR9rlImh9d2zabdIpmxF3r1CBtRfWBwOILNSaeqPww1VzTt6d6QcTINif
 FYL9HIxAEhTH9tguwYGBGkuDlzVnJzHc4WMLIqcA+iLOWbSqDxfPVRMExTxHC6Q4bDhs
 JYVmudlkNrXvY1kxtKZ8dCkReynJPpGYglUo81r1byzWwClguQCX0ZybHX/6UZ+zemq/
 3GaVxuLkMBErH2yiej7abPvH57adi13A/AbrqbbJ1Xdp7VjE/g8uU1bxjHkH7RCpvhDY
 lTbov/5O61Tw3kdlXeqvbkVZWGmxXXgRyzyCYp0IF/1pnlvgm+38P9iicRFWT3M015FH
 X0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg4KSvxpK+hpQs574fPE4XgDEgsZ2Hdn9tJYnvAgHm+iw8URdFwj7sUh5LmJkrRrpoAPm+lpEpiASW@nongnu.org
X-Gm-Message-State: AOJu0Yydm7QPJ34aUhx4QsZoRpARKehsCVHQhaYrezhK4YddoeTcw05W
 GgeCEcZQbe/d4gsEav/l6rE5Yh8+wGtek74wE2mILKNhErORKQKYAkf1qLf8OvA=
X-Gm-Gg: ASbGncvKJnSzqHt5RwR9gp47SnMfXvZMKiXUCHw3Oit46HfSwZipnbpcBePMxqe9Lsv
 1yw7jfm2gE4JP6JBoWlHOe7qaKCWQush0hgPELL+H1mfvAmbmqaE9Z0N80GsvRVbsVphtWAdMtJ
 ePKGK00BNvui0rFeigZBjKrlhaGlccGvW212wNNcesB6zAbCu0LixY771nx26sF8aVwg7SmH+aJ
 2yJah5XEeyD7ETeUoFcJdgPkGmoWDjgU8BLYTWRMIh6FifD9T48kbj38dNtVl4ybFSSMXkO2W/o
 3vYp6cwo+23f7UczbTH2aEh0cF971nhAlgJrwOBef4Jx0rwVNmsDq5k6fg==
X-Google-Smtp-Source: AGHT+IGu7JBcnuWnMPBuU7hiTo93qu/WDWnwnWY6VP9EN/eE9EF8eTD0WKyIrv4I/zgNLAfNvjqk7A==
X-Received: by 2002:a17:90a:fc43:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-30151d3e018mr16040542a91.25.1742227641697; 
 Mon, 17 Mar 2025 09:07:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153519fefsm6256238a91.12.2025.03.17.09.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:07:21 -0700 (PDT)
Message-ID: <edc3bc03-b34f-4bed-be0d-b0fb776a115b@linaro.org>
Date: Mon, 17 Mar 2025 09:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] exec/ram_addr: call xen_hvm_modified_memory only
 if xen is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <20250314173139.2122904-12-pierrick.bouvier@linaro.org>
 <ad7cdcaf-46d6-460f-8593-a9b74c600784@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ad7cdcaf-46d6-460f-8593-a9b74c600784@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

T24gMy8xNy8yNSAwODo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE0LzMvMjUgMTg6MzEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBSZXZpZXdlZC1i
eTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxp
bmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGluY2x1ZGUvZXhlYy9yYW1fYWRkci5oIHwgOCAr
KysrKystLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgg
Yi9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0KPj4gaW5kZXggZjVkNTc0MjYxYTMuLjkyZTg3
MDhhZjc2IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4+ICsr
KyBiL2luY2x1ZGUvZXhlYy9yYW1fYWRkci5oDQo+PiBAQCAtMzM5LDcgKzMzOSw5IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBjcHVfcGh5c2ljYWxfbWVtb3J5X3NldF9kaXJ0eV9yYW5nZShy
YW1fYWRkcl90IHN0YXJ0LA0KPj4gICAgICAgICAgICB9DQo+PiAgICAgICAgfQ0KPj4gICAg
DQo+PiAtICAgIHhlbl9odm1fbW9kaWZpZWRfbWVtb3J5KHN0YXJ0LCBsZW5ndGgpOw0KPj4g
KyAgICBpZiAoeGVuX2VuYWJsZWQoKSkgew0KPj4gKyAgICAgICAgeGVuX2h2bV9tb2RpZmll
ZF9tZW1vcnkoc3RhcnQsIGxlbmd0aCk7DQo+IA0KPiBQbGVhc2UgcmVtb3ZlIHRoZSBzdHVi
IGFsdG9nZXRoZXIuDQo+DQoNCldlIGNhbiBldmVudHVhbGx5IGlmZGVmIHRoaXMgY29kZSB1
bmRlciBDT05GSUdfWEVOLCBidXQgaXQgbWF5IHN0aWxsIGJlIA0KYXZhaWxhYmxlIG9yIG5v
dC4gVGhlIG1hdGNoaW5nIHN0dWIgZm9yIHhlbl9odm1fbW9kaWZpZWRfbWVtb3J5KCkgd2ls
bCANCmFzc2VydCBpbiBjYXNlIGl0IGlzIHJlYWNoZWQuDQoNCldoaWNoIGNoYW5nZSB3b3Vs
ZCB5b3UgZXhwZWN0IHByZWNpc2VseT8NCg0KPj4gKyAgICB9DQo+PiAgICB9DQoNCg==


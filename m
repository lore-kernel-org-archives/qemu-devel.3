Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A550EC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDrk-0003cq-1l; Mon, 17 Mar 2025 13:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuDrW-0003Wf-DL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:02:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuDrR-0004vb-Kx
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:02:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22435603572so74538535ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742230962; x=1742835762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0KdeYQZxMITCKW2YracoyMvGqqsB+WIg6tW1xi9WJ6o=;
 b=TwahcsoFhptAd8IEHSN59Pbyj50YcBT/Pj8U7vR7XwRwcAD+6lwOFuTYSaFo+af3rx
 2EHHsYhV1AHFLm+wh+eOx6SqNN6075/j4p1Ejn5a7WbJgVk9ad0F/1QZeql5G6c3qHl8
 kVfbv2/eG989ATSWkop0/TLYcl6sUjMb61mOnSKvXtwypYOqDn9fnwNBtZ1mY1EFAoEG
 wMNk6aAMWEikMtaaKn6EgO6nQqOUi1K2W5FjRFbVDBkvOhOKWTN3nmwEABjmhOZSYMZe
 NeuA61ASeLMGs7yfDqVTVtmg8WCL3DMYwQxZmeE+Xz2ZgcXWyu7piR8fH+nkLoYqpegs
 ttHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742230962; x=1742835762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0KdeYQZxMITCKW2YracoyMvGqqsB+WIg6tW1xi9WJ6o=;
 b=a9QNNuct89XYWSL+pNGzyLEPftAchorAL1AkSVov0aAL44zFv1f6YvtKTkidni+nDi
 XC8BOv7X7bW+DA5kZchsLYJdUsXZzN8D1Neb7iO7NcW3LHr+uqk5bua0KsgfRrYsQoj8
 tEptyrj53bWXO6me3eGTLuZc3MAdUzaxPAQOaBHkyjbKJ8ur6xnclAXlU9osDYzYRu1c
 J0ZyLqxEpew0eGD4lD5rfvEHffuVSFs+tIZiTOM8rvrSYqCUYdpc1DK0g95xyTK2Hn3q
 u3UzGW18OP8tU/shANYexsprT2mqax28FgcI2dxp8tsVA9nYrX7pemNkYo32K341PJ+4
 71Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbx8ibJJD4Dz7iAMC7T3C91TLIKt9dfxYISC2r7uoBjrgoFjgkfUWAklWbm1fS/foVqa6IFx4xFFm3@nongnu.org
X-Gm-Message-State: AOJu0YzTHHO+dqNysW8RkS6rXt74lzu5WXJY7ngsIzjXsAJecKpFeofX
 +wY8NNl1mwtwGoTxJ66IKBPtenDlUWJLZgLLAK5+Cl4LcrxNLntqLZ8JbXDy3pI=
X-Gm-Gg: ASbGncs8Tu1yiVvncrb2HSEgLkKxD+9eEsLZ9ekZ0PVK9/r4XNC0fumxvOEkLiExBV3
 qTXY68cjtUvTkOfM+mPJrDQNYuJeah5dNjVvfJRvvLrCx98Ud17htFWdRI+ErsYoeT6wCJrHgzq
 W46L5EKuGwBOv8regHazUCqULdq0agB/fyhh0Bj0RIvv90UFDcj334nYhOxY1iluflPqFfCOw7e
 A9K77kUzbMrOS3MXElU/mAAt4Y1flzyBjz12odTZzlFLPfZKRC7Jme6rRE8mOlUIRviO8E7050N
 QKv2co96b98fH02+AK+x8CUKRKsddDkdyDTOgEJ8jiUgltNrUeCgbaIRrQ==
X-Google-Smtp-Source: AGHT+IE96+IQ6oKtgk11tBS7t87MDWjDBBfjgGEDyxjnsPlxW2vYa3f+I8+TbfFUdxKcglJZ9KvdSg==
X-Received: by 2002:a17:902:7488:b0:224:826:277f with SMTP id
 d9443c01a7336-225e0af5bc8mr124296695ad.33.1742230962248; 
 Mon, 17 Mar 2025 10:02:42 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe905sm77694415ad.190.2025.03.17.10.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 10:02:41 -0700 (PDT)
Message-ID: <476e8dd7-08fc-49a8-8596-41ae91321738@linaro.org>
Date: Mon, 17 Mar 2025 10:02:40 -0700
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
 <edc3bc03-b34f-4bed-be0d-b0fb776a115b@linaro.org>
 <9c55662e-0c45-4bb6-83bf-54b131e30f48@linaro.org>
 <d93f6514-6d42-467d-826b-c95c6efd66b1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d93f6514-6d42-467d-826b-c95c6efd66b1@linaro.org>
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

T24gMy8xNy8yNSAwOToyMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE3LzMvMjUgMTc6MjIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gT24g
MTcvMy8yNSAxNzowNywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBPbiAzLzE3LzI1
IDA4OjUwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4gT24gMTQvMy8y
NSAxODozMSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4+IFJldmlld2VkLWJ5OiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gIMKgwqAgaW5jbHVkZS9leGVjL3JhbV9hZGRy
LmggfCA4ICsrKysrKy0tDQo+Pj4+PiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2V4ZWMvcmFtX2FkZHIuaCBiL2luY2x1ZGUvZXhlYy9yYW1fYWRkci5oDQo+Pj4+PiBp
bmRleCBmNWQ1NzQyNjFhMy4uOTJlODcwOGFmNzYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9pbmNs
dWRlL2V4ZWMvcmFtX2FkZHIuaA0KPj4+Pj4gKysrIGIvaW5jbHVkZS9leGVjL3JhbV9hZGRy
LmgNCj4+Pj4+IEBAIC0zMzksNyArMzM5LDkgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+Pj4+
PiBjcHVfcGh5c2ljYWxfbWVtb3J5X3NldF9kaXJ0eV9yYW5nZShyYW1fYWRkcl90IHN0YXJ0
LA0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+ICDCoMKgwqDCoMKgwqAg
fQ0KPj4+Pj4gLcKgwqDCoCB4ZW5faHZtX21vZGlmaWVkX21lbW9yeShzdGFydCwgbGVuZ3Ro
KTsNCj4+Pj4+ICvCoMKgwqAgaWYgKHhlbl9lbmFibGVkKCkpIHsNCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCB4ZW5faHZtX21vZGlmaWVkX21lbW9yeShzdGFydCwgbGVuZ3RoKTsNCj4+Pj4N
Cj4+Pj4gUGxlYXNlIHJlbW92ZSB0aGUgc3R1YiBhbHRvZ2V0aGVyLg0KPj4+Pg0KPj4+DQo+
Pj4gV2UgY2FuIGV2ZW50dWFsbHkgaWZkZWYgdGhpcyBjb2RlIHVuZGVyIENPTkZJR19YRU4s
IGJ1dCBpdCBtYXkgc3RpbGwNCj4+PiBiZSBhdmFpbGFibGUgb3Igbm90LiBUaGUgbWF0Y2hp
bmcgc3R1YiBmb3IgeGVuX2h2bV9tb2RpZmllZF9tZW1vcnkoKQ0KPj4+IHdpbGwgYXNzZXJ0
IGluIGNhc2UgaXQgaXMgcmVhY2hlZC4NCj4+Pg0KPj4+IFdoaWNoIGNoYW5nZSB3b3VsZCB5
b3UgZXhwZWN0IHByZWNpc2VseT8NCj4+DQo+PiAtLSA+OCAtLQ0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvc3lzdGVtL3hlbi1tYXBjYWNoZS5oIGIvaW5jbHVkZS9zeXN0ZW0veGVuLW1h
cGNhY2hlLmgNCj4+IGluZGV4IGI2OGYxOTZkZGQ1Li5iYjQ1NGE3Yzk2YyAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvc3lzdGVtL3hlbi1tYXBjYWNoZS5oDQo+PiArKysgYi9pbmNsdWRl
L3N5c3RlbS94ZW4tbWFwY2FjaGUuaA0KPj4gQEAgLTE0LDggKzE0LDYgQEANCj4+DQo+PiAg
IMKgdHlwZWRlZiBod2FkZHIgKCpwaHlzX29mZnNldF90b19nYWRkcl90KShod2FkZHIgcGh5
c19vZmZzZXQsDQo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFtX2FkZHJf
dCBzaXplKTsNCj4+IC0jaWZkZWYgQ09ORklHX1hFTl9JU19QT1NTSUJMRQ0KPj4gLQ0KPj4g
ICDCoHZvaWQgeGVuX21hcF9jYWNoZV9pbml0KHBoeXNfb2Zmc2V0X3RvX2dhZGRyX3QgZiwN
Cj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHZvaWQgKm9wYXF1ZSk7DQo+PiAgIMKgdWludDhfdCAqeGVuX21hcF9jYWNoZShNZW1vcnlS
ZWdpb24gKm1yLCBod2FkZHIgcGh5c19hZGRyLCBod2FkZHIgc2l6ZSwNCj4+IEBAIC0yOCw0
NCArMjYsNSBAQCB2b2lkIHhlbl9pbnZhbGlkYXRlX21hcF9jYWNoZSh2b2lkKTsNCj4+ICAg
wqB1aW50OF90ICp4ZW5fcmVwbGFjZV9jYWNoZV9lbnRyeShod2FkZHIgb2xkX3BoeXNfYWRk
ciwNCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBuZXdfcGh5c19hZGRyLA0KPj4gICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaHdhZGRyIHNpemUpOw0KPj4gLSNlbHNlDQo+PiAtDQo+PiAtc3RhdGljIGlu
bGluZSB2b2lkIHhlbl9tYXBfY2FjaGVfaW5pdChwaHlzX29mZnNldF90b19nYWRkcl90IGYs
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqb3BhcXVlKQ0KPj4gLXsNCj4+IC19
DQo+PiAtDQo+PiAtc3RhdGljIGlubGluZSB1aW50OF90ICp4ZW5fbWFwX2NhY2hlKE1lbW9y
eVJlZ2lvbiAqbXIsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBwaHlzX2FkZHIs
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBzaXplLA0KPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByYW1fYWRkcl90IHJhbV9hZGRyX29mZnNldCwNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDhfdCBsb2NrLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGRtYSwN
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc193cml0ZSkNCj4+IC17DQo+PiAtwqDC
oMKgIGFib3J0KCk7DQo+PiAtfQ0KPj4gLQ0KPj4gLXN0YXRpYyBpbmxpbmUgcmFtX2FkZHJf
dCB4ZW5fcmFtX2FkZHJfZnJvbV9tYXBjYWNoZSh2b2lkICpwdHIpDQo+PiAtew0KPj4gLcKg
wqDCoCBhYm9ydCgpOw0KPj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgeGVu
X2ludmFsaWRhdGVfbWFwX2NhY2hlX2VudHJ5KHVpbnQ4X3QgKmJ1ZmZlcikNCj4+IC17DQo+
PiAtfQ0KPj4gLQ0KPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5faW52YWxpZGF0ZV9tYXBf
Y2FjaGUodm9pZCkNCj4+IC17DQo+PiAtfQ0KPj4gLQ0KPj4gLXN0YXRpYyBpbmxpbmUgdWlu
dDhfdCAqeGVuX3JlcGxhY2VfY2FjaGVfZW50cnkoaHdhZGRyIG9sZF9waHlzX2FkZHIsDQo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdhZGRyIG5ld19w
aHlzX2FkZHIsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aHdhZGRyIHNpemUpDQo+PiAtew0KPj4gLcKgwqDCoCBhYm9ydCgpOw0KPj4gLX0NCj4+IC0N
Cj4+IC0jZW5kaWYNCj4+DQo+PiAgIMKgI2VuZGlmIC8qIFhFTl9NQVBDQUNIRV9IICovDQo+
IA0KPiAoc29ycnksIHRoZSBpbmNsdWRlL3N5c3RlbS94ZW4tbWFwY2FjaGUuaCBjaGFuZ2Ug
aXMgZm9yIHRoZSBuZXh0IHBhdGNoKQ0KPiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5
c3RlbS94ZW4uaCBiL2luY2x1ZGUvc3lzdGVtL3hlbi5oDQo+PiBpbmRleCA5OTBjMTlhOGVm
MC4uMDRmZTMwY2NhNTAgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3N5c3RlbS94ZW4uaA0K
Pj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0veGVuLmgNCj4+IEBAIC0zMCwyNSArMzAsMTYgQEAg
ZXh0ZXJuIGJvb2wgeGVuX2FsbG93ZWQ7DQo+Pg0KPj4gICDCoCNkZWZpbmUgeGVuX2VuYWJs
ZWQoKcKgwqDCoMKgwqDCoMKgwqDCoMKgICh4ZW5fYWxsb3dlZCkNCj4+DQo+PiAtdm9pZCB4
ZW5faHZtX21vZGlmaWVkX21lbW9yeShyYW1fYWRkcl90IHN0YXJ0LCByYW1fYWRkcl90IGxl
bmd0aCk7DQo+PiAtdm9pZCB4ZW5fcmFtX2FsbG9jKHJhbV9hZGRyX3QgcmFtX2FkZHIsIHJh
bV9hZGRyX3Qgc2l6ZSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IE1lbW9yeVJlZ2lvbiAqbXIsIEVycm9yICoqZXJycCk7DQo+PiAtDQo+PiAg
IMKgI2Vsc2UgLyogIUNPTkZJR19YRU5fSVNfUE9TU0lCTEUgKi8NCj4+DQo+PiAgIMKgI2Rl
ZmluZSB4ZW5fZW5hYmxlZCgpIDANCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgeGVuX2h2bV9t
b2RpZmllZF9tZW1vcnkocmFtX2FkZHJfdCBzdGFydCwgcmFtX2FkZHJfdA0KPj4gbGVuZ3Ro
KQ0KPj4gLXsNCj4+IC3CoMKgwqAgLyogbm90aGluZyAqLw0KPj4gLX0NCj4+IC1zdGF0aWMg
aW5saW5lIHZvaWQgeGVuX3JhbV9hbGxvYyhyYW1fYWRkcl90IHJhbV9hZGRyLCByYW1fYWRk
cl90IHNpemUsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNZW1vcnlSZWdpb24gKm1yLCBFcnJvciAqKmVy
cnApDQo+PiAtew0KPj4gLcKgwqDCoCBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPj4gLX0N
Cj4+DQo+PiAgIMKgI2VuZGlmIC8qIENPTkZJR19YRU5fSVNfUE9TU0lCTEUgKi8NCj4+DQo+
PiArdm9pZCB4ZW5faHZtX21vZGlmaWVkX21lbW9yeShyYW1fYWRkcl90IHN0YXJ0LCByYW1f
YWRkcl90IGxlbmd0aCk7DQo+PiArdm9pZCB4ZW5fcmFtX2FsbG9jKHJhbV9hZGRyX3QgcmFt
X2FkZHIsIHJhbV9hZGRyX3Qgc2l6ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTWVtb3J5UmVnaW9uICptciwgRXJyb3IgKiplcnJwKTsNCj4+ICsNCj4+
ICAgwqBib29sIHhlbl9tcl9pc19tZW1vcnkoTWVtb3J5UmVnaW9uICptcik7DQo+PiAgIMKg
Ym9vbCB4ZW5fbXJfaXNfZ3JhbnRzKE1lbW9yeVJlZ2lvbiAqbXIpOw0KPj4gICDCoCNlbmRp
Zg0KPj4gLS0tDQo+IA0KDQpTb3VuZHMgZ29vZCENCkkgd2lsbCBpbmNsdWRlIGl0IGluIG5l
eHQgdmVyc2lvbi4NCg==


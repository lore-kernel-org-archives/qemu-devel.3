Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A3DD41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRHG-000135-OP; Wed, 13 Nov 2024 23:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRHA-0000W7-Kp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:16:12 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRH8-0004hV-Sn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:16:12 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso133604b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557769; x=1732162569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lezMPJwXytMzlLaQtK2wi8F3Fr7eDH5mRsOKafMawOU=;
 b=TMomBFtCsHp5rC+aHA6/04iL+YBfHKdSkwgnAW6HSJk8kk+ecoKH2shimbGVw/yruY
 ULVJguBYFaoPZSkHcAA+MlkGRXh27QlVHW94MRTtRsiLf28RJlbvlBnTgoqMoJ5CtMRv
 kEq5DQ93JThjHfmqd1zArlFYbHSNxk1jtT2jyRjQbMnd3KvSPW1Lpn00N2Y7XFpY/vo2
 ICubf8oS1XAS1/mnhU5DT2yWL1f6xiwxKlGG9McXw8dl83WucNVUBKC+zW6O5uamAz4u
 GGA5XyRXWwOz83/4DYgRYgeikf/NCnZwYu5sp1xFrcvQowczQzio33mTALMEk6d+BJM7
 vPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557769; x=1732162569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lezMPJwXytMzlLaQtK2wi8F3Fr7eDH5mRsOKafMawOU=;
 b=V95AWLx4zFG7W/NbhCaym3vCD248pOHLb56KvOOYqsv2fWQgC7U1HSYU8TUMNaU728
 u0en5juyTImRKLpvV0CV6fY9lmMyuWlk0r05+0bj162IVO48z6+KVLF9gwiLy3+LdBYR
 DHymN1Kz3aydfkhtX6HGz3LdROsZl/ILpjd+oE3RJopPkNECsQEFCltrJt8JgoqlOtQK
 +71S3xkri0GJtjGztmaTKGnadaVD71MPORUjzRC989gwmpZzjgFD6Or/9kpT8/1PJGz5
 nYNFSxBQcnmas4FH/MOJTTj8+Q9VYqrGgTgRZTP+t01HGmv82E1zuvSAbxbppWvpTb7q
 xdxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgrFCtAeYJGkesKtwCRaM+x3zeLuONG5Ud3MHIfVr5Z0SrAKQpS0ERMqrZUMuWLqM1E0c8LFu95Ksz@nongnu.org
X-Gm-Message-State: AOJu0YwHPQgq6IeWjnh80gNp48QNgT7nKMR051FA/euP3BljRGL/m+34
 LUJHkBEBL3X+KBQ1gLazGa7TT2l9jliAFpkf+fIlzS3wo4gOANlOXkQkkSRBOUU=
X-Google-Smtp-Source: AGHT+IFyz5dEST757I7gGbQVm+j0sU0JM/WJadpM0ElN+axYMMau5mm2TAJbUMT9XonwqZ75gKG35A==
X-Received: by 2002:a05:6a00:b85:b0:71e:64fe:965f with SMTP id
 d2e1a72fcca58-72457a2a382mr7723917b3a.20.1731557769306; 
 Wed, 13 Nov 2024 20:16:09 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9a8260sm256068b3a.122.2024.11.13.20.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:16:08 -0800 (PST)
Message-ID: <cb3640c3-97e8-4da7-9d01-0189adfd4e9a@linaro.org>
Date: Wed, 13 Nov 2024 20:16:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] exec/memory: Move qemu_map_ram_ptr() declaration to
 'exec/ram_addr.h'
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
 <20241114011310.3615-24-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

T24gMTEvMTMvMjQgMTc6MTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgIHwgMiArLQ0KPiAgIGlu
Y2x1ZGUvZXhlYy9yYW1fYWRkci5oIHwgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvbWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4gaW5kZXggOTQ1OGUy
ODAxZC4uNThmYWEzZWIwOCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5o
DQo+ICsrKyBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPiBAQCAtMjgsNiArMjgsNyBAQA0K
PiAgICNpbmNsdWRlICJxZW11L25vdGlmeS5oIg0KPiAgICNpbmNsdWRlICJxb20vb2JqZWN0
LmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvcmN1LmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9yYW1f
YWRkci5oIg0KPiAgIA0KPiAgICNkZWZpbmUgUkFNX0FERFJfSU5WQUxJRCAofihyYW1fYWRk
cl90KTApDQo+ICAgDQo+IEBAIC0yOTczLDcgKzI5NzQsNiBAQCBNZW1UeFJlc3VsdCBmbGF0
dmlld19yZWFkX2NvbnRpbnVlKEZsYXRWaWV3ICpmdiwgaHdhZGRyIGFkZHIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1UeEF0dHJzIGF0dHJzLCB2b2lk
ICpidWYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIg
bGVuLCBod2FkZHIgYWRkcjEsIGh3YWRkciBsLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uICptcik7DQo+IC12b2lkICpxZW11X21hcF9y
YW1fcHRyKFJBTUJsb2NrICpyYW1fYmxvY2ssIHJhbV9hZGRyX3QgYWRkcik7DQo+ICAgDQo+
ICAgLyogSW50ZXJuYWwgZnVuY3Rpb25zLCBwYXJ0IG9mIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiBhZGRyZXNzX3NwYWNlX3JlYWRfY2FjaGVkDQo+ICAgICogYW5kIGFkZHJlc3Nfc3BhY2Vf
d3JpdGVfY2FjaGVkLiAgKi8NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9yYW1fYWRk
ci5oIGIvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4gaW5kZXggZTA2MjBkZGIwMy4uYzRm
MjIwYWU5MyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4gKysr
IGIvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4gQEAgLTczLDYgKzczLDcgQEAgdm9pZCBx
ZW11X3JhbV9zZXRfbWlncmF0YWJsZShSQU1CbG9jayAqcmIpOw0KPiAgIHZvaWQgcWVtdV9y
YW1fdW5zZXRfbWlncmF0YWJsZShSQU1CbG9jayAqcmIpOw0KPiAgIGJvb2wgcWVtdV9yYW1f
aXNfbmFtZWRfZmlsZShSQU1CbG9jayAqcmIpOw0KPiAgIGludCBxZW11X3JhbV9nZXRfZmQo
UkFNQmxvY2sgKnJiKTsNCj4gK3ZvaWQgKnFlbXVfbWFwX3JhbV9wdHIoUkFNQmxvY2sgKnJh
bV9ibG9jaywgcmFtX2FkZHJfdCBhZGRyKTsNCj4gICANCj4gICBzaXplX3QgcWVtdV9yYW1f
cGFnZXNpemUoUkFNQmxvY2sgKmJsb2NrKTsNCj4gICBzaXplX3QgcWVtdV9yYW1fcGFnZXNp
emVfbGFyZ2VzdCh2b2lkKTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C322D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRGB-0007Bu-Dw; Wed, 13 Nov 2024 23:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRG2-0006Y1-MS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:15:02 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRG0-000483-PO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:15:02 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c77459558so1243825ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557699; x=1732162499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHyRIdRpQcoUW4bo+q8r1ktrBEIhwAheO5i5u4SrJtQ=;
 b=SK7xG6uu1c0B71LZt3U5Qt3sPY4DBrF0qewiruyTY0HK37PBQOaKfsOB1sJhoV7T5k
 ES0cP+us7SovJIezHqt583HpWasgunKroAAdg1gE3wPHwEGqQOjCmaUBzfAS7KAVMhWb
 dkfo5C3sK8G04SYat2MA44RjSbnlShBw9gi6jKc8PQfcbKpCDr79uxqkCERKmlKf1b30
 Bchq6rriBrkZTvbhwIterjNCgO1Juyc2tX2iYSM1JD0GT+6ypkmbjrfs/S7VV83y5/mK
 0abZQGVd7XaPXyi53XiMRltt575vKp/vz/yRoxDHNrmSJd9Uc/vj5uq2URCUw08TjfjE
 NydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557699; x=1732162499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EHyRIdRpQcoUW4bo+q8r1ktrBEIhwAheO5i5u4SrJtQ=;
 b=fPf9v/TbY+0GPI1BbKhKhVbH6yhJu+UQN/2H4c4OUu+GZacmFlYT4RVHbA6YDBzMSV
 rs5sWzHpM/YZAWqi0Wo4j7gbxyRn11NA6sQ/eZJGlnvuBMhN6nRcDzUpA2jb4r+47zpZ
 piUVAei2UZbNyxyl+prwQH8qhUhiaCJLAfdP0CcHA2tJzDR62IQTRzENs5qrhAoYuQ1o
 pvHT5JUu+Mo1B0sH+uLI1qW5tPPirqOyf7Ij9TjdpH5f37xLYr9k3oGUgUItfKHQk1m4
 TOMWGuYBt88D35MboRKD9L0ljQUv7hZnuSYVi4DFiDjt7blsr1PHrIk3uL+AtRWX6pVB
 tuOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlhvS7bcHiWJejozZ3bq2GUBeYLYKyatQGdXUUVE54nUo1MaJ0YPrzSrV1Is9hpDmTEUNzk8HFG5cu@nongnu.org
X-Gm-Message-State: AOJu0YzcxuXrMsk9gmVe/B4KwJT+z+oUwa6mGRAh3BQ4kVtVM5KlaMhW
 TBaaeOHBRNvBNu4MqF7Mn7L2IxHgGBzxyS27mUvq0seqTXoFqBr3lDxpaFNmLEA=
X-Google-Smtp-Source: AGHT+IFQ0eAxL7EgkFIvZArw6tKeTPj+7WAxJFY4Mmnzq1Kao2wYIEtF/9TLNGmWCCY7wiKeH1+g7A==
X-Received: by 2002:a17:902:fc46:b0:20b:96b6:9fc2 with SMTP id
 d9443c01a7336-211ab90a5b4mr125907655ad.10.1731557699513; 
 Wed, 13 Nov 2024 20:14:59 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c5665bsm1504475ad.100.2024.11.13.20.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:14:59 -0800 (PST)
Message-ID: <fedd9248-5aef-43e7-8655-079033329d0e@linaro.org>
Date: Wed, 13 Nov 2024 20:14:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] exec: Declare tlb_vaddr_to_host() in 'exec/cputlb.h'
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
 <20241114011310.3615-21-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gTW92ZSBDUFUgVExCIHJlbGF0ZWQgbWV0aG9kcyB0byAiZXhlYy9jcHV0bGIuaCIuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9jcHVfbGRzdC5oICAgICB8IDI1
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBpbmNsdWRlL2V4ZWMvY3B1dGxiLmgg
ICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHRhcmdldC9hcm0v
dGNnL2hlbHBlci1hNjQuYyB8ICAxICsNCj4gICB0YXJnZXQvcHBjL21lbV9oZWxwZXIuYyAg
ICAgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvY3B1X2xkc3Qu
aCBiL2luY2x1ZGUvZXhlYy9jcHVfbGRzdC5oDQo+IGluZGV4IDc2OWU5ZmM0NDAuLmVlYzQ3
Y2EwNWUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9jcHVfbGRzdC5oDQo+ICsrKyBi
L2luY2x1ZGUvZXhlYy9jcHVfbGRzdC5oDQo+IEBAIC02OSw3ICs2OSw2IEBADQo+ICAgI2lu
Y2x1ZGUgImV4ZWMvbWVtb3BpZHguaCINCj4gICAjaW5jbHVkZSAiZXhlYy92YWRkci5oIg0K
PiAgICNpbmNsdWRlICJleGVjL2FiaV9wdHIuaCINCj4gLSNpbmNsdWRlICJleGVjL21tdS1h
Y2Nlc3MtdHlwZS5oIg0KPiAgICNpbmNsdWRlICJxZW11L2ludDEyOC5oIg0KPiAgIA0KPiAg
ICNpZiBkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+IEBAIC0zMTEsMzAgKzMxMCw2IEBA
IHVpbnQzMl90IGNwdV9sZHV3X2NvZGUoQ1BVQXJjaFN0YXRlICplbnYsIGFiaV9wdHIgYWRk
cik7DQo+ICAgdWludDMyX3QgY3B1X2xkbF9jb2RlKENQVUFyY2hTdGF0ZSAqZW52LCBhYmlf
cHRyIGFkZHIpOw0KPiAgIHVpbnQ2NF90IGNwdV9sZHFfY29kZShDUFVBcmNoU3RhdGUgKmVu
diwgYWJpX3B0ciBhZGRyKTsNCj4gICANCj4gLS8qKg0KPiAtICogdGxiX3ZhZGRyX3RvX2hv
c3Q6DQo+IC0gKiBAZW52OiBDUFVBcmNoU3RhdGUNCj4gLSAqIEBhZGRyOiBndWVzdCB2aXJ0
dWFsIGFkZHJlc3MgdG8gbG9vayB1cA0KPiAtICogQGFjY2Vzc190eXBlOiAwIGZvciByZWFk
LCAxIGZvciB3cml0ZSwgMiBmb3IgZXhlY3V0ZQ0KPiAtICogQG1tdV9pZHg6IE1NVSBpbmRl
eCB0byB1c2UgZm9yIGxvb2t1cA0KPiAtICoNCj4gLSAqIExvb2sgdXAgdGhlIHNwZWNpZmll
ZCBndWVzdCB2aXJ0dWFsIGluZGV4IGluIHRoZSBUQ0cgc29mdG1tdSBUTEIuDQo+IC0gKiBJ
ZiB3ZSBjYW4gdHJhbnNsYXRlIGEgaG9zdCB2aXJ0dWFsIGFkZHJlc3Mgc3VpdGFibGUgZm9y
IGRpcmVjdCBSQU0NCj4gLSAqIGFjY2Vzcywgd2l0aG91dCBjYXVzaW5nIGEgZ3Vlc3QgZXhj
ZXB0aW9uLCB0aGVuIHJldHVybiBpdC4NCj4gLSAqIE90aGVyd2lzZSAoVExCIGVudHJ5IGlz
IGZvciBhbiBJL08gYWNjZXNzLCBndWVzdCBzb2Z0d2FyZQ0KPiAtICogVExCIGZpbGwgcmVx
dWlyZWQsIGV0YykgcmV0dXJuIE5VTEwuDQo+IC0gKi8NCj4gLSNpZmRlZiBDT05GSUdfVVNF
Ul9PTkxZDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgKnRsYl92YWRkcl90b19ob3N0KENQVUFy
Y2hTdGF0ZSAqZW52LCBhYmlfcHRyIGFkZHIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGludCBtbXVfaWR4
KQ0KPiAtew0KPiAtICAgIHJldHVybiBnMmgoZW52X2NwdShlbnYpLCBhZGRyKTsNCj4gLX0N
Cj4gLSNlbHNlDQo+IC12b2lkICp0bGJfdmFkZHJfdG9faG9zdChDUFVBcmNoU3RhdGUgKmVu
diwgdmFkZHIgYWRkciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5
cGUgYWNjZXNzX3R5cGUsIGludCBtbXVfaWR4KTsNCj4gLSNlbmRpZg0KPiAtDQo+ICAgLyoN
Cj4gICAgKiBGb3IgdXNlci1vbmx5LCBoZWxwZXJzIHRoYXQgdXNlIGd1ZXN0IHRvIGhvc3Qg
YWRkcmVzcyB0cmFuc2xhdGlvbg0KPiAgICAqIG11c3QgcHJvdGVjdCB0aGUgYWN0dWFsIGhv
c3QgbWVtb3J5IGFjY2VzcyBieSByZWNvcmRpbmcgJ3JldGFkZHInDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2V4ZWMvY3B1dGxiLmggYi9pbmNsdWRlL2V4ZWMvY3B1dGxiLmgNCj4gaW5k
ZXggMDdjNGJjNjY5ZS4uNGFjYzJjNjIzNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVj
L2NwdXRsYi5oDQo+ICsrKyBiL2luY2x1ZGUvZXhlYy9jcHV0bGIuaA0KPiBAQCAtMjAsNiAr
MjAsNyBAQA0KPiAgICNpZm5kZWYgQ1BVVExCX0gNCj4gICAjZGVmaW5lIENQVVRMQl9IDQo+
ICAgDQo+ICsjaW5jbHVkZSAiZXhlYy9hYmlfcHRyLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMv
Y3B1LWNvbW1vbi5oIg0KPiAgICNpbmNsdWRlICJleGVjL2h3YWRkci5oIg0KPiAgICNpbmNs
dWRlICJleGVjL21lbWF0dHJzLmgiDQo+IEBAIC0zMDYsNCArMzA3LDI5IEBAIHZvaWQgdGxi
X3NldF9wYWdlKENQVVN0YXRlICpjcHUsIHZhZGRyIGFkZHIsDQo+ICAgICAgICAgICAgICAg
ICAgICAgaHdhZGRyIHBhZGRyLCBpbnQgcHJvdCwNCj4gICAgICAgICAgICAgICAgICAgICBp
bnQgbW11X2lkeCwgdmFkZHIgc2l6ZSk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIHRsYl92YWRk
cl90b19ob3N0Og0KPiArICogQGVudjogQ1BVQXJjaFN0YXRlDQo+ICsgKiBAYWRkcjogZ3Vl
c3QgdmlydHVhbCBhZGRyZXNzIHRvIGxvb2sgdXANCj4gKyAqIEBhY2Nlc3NfdHlwZTogMCBm
b3IgcmVhZCwgMSBmb3Igd3JpdGUsIDIgZm9yIGV4ZWN1dGUNCj4gKyAqIEBtbXVfaWR4OiBN
TVUgaW5kZXggdG8gdXNlIGZvciBsb29rdXANCj4gKyAqDQo+ICsgKiBMb29rIHVwIHRoZSBz
cGVjaWZpZWQgZ3Vlc3QgdmlydHVhbCBpbmRleCBpbiB0aGUgVENHIHNvZnRtbXUgVExCLg0K
PiArICogSWYgd2UgY2FuIHRyYW5zbGF0ZSBhIGhvc3QgdmlydHVhbCBhZGRyZXNzIHN1aXRh
YmxlIGZvciBkaXJlY3QgUkFNDQo+ICsgKiBhY2Nlc3MsIHdpdGhvdXQgY2F1c2luZyBhIGd1
ZXN0IGV4Y2VwdGlvbiwgdGhlbiByZXR1cm4gaXQuDQo+ICsgKiBPdGhlcndpc2UgKFRMQiBl
bnRyeSBpcyBmb3IgYW4gSS9PIGFjY2VzcywgZ3Vlc3Qgc29mdHdhcmUNCj4gKyAqIFRMQiBm
aWxsIHJlcXVpcmVkLCBldGMpIHJldHVybiBOVUxMLg0KPiArICovDQo+ICsjaWZkZWYgQ09O
RklHX1VTRVJfT05MWQ0KPiArI2luY2x1ZGUgInVzZXIvZ3Vlc3QtaG9zdC5oIg0KPiArc3Rh
dGljIGlubGluZSB2b2lkICp0bGJfdmFkZHJfdG9faG9zdChDUFVBcmNoU3RhdGUgKmVudiwg
YWJpX3B0ciBhZGRyLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlLCBpbnQgbW11X2lkeCkNCj4gK3sNCj4gKyAg
ICByZXR1cm4gZzJoKGVudl9jcHUoZW52KSwgYWRkcik7DQo+ICt9DQo+ICsjZWxzZQ0KPiAr
dm9pZCAqdGxiX3ZhZGRyX3RvX2hvc3QoQ1BVQXJjaFN0YXRlICplbnYsIHZhZGRyIGFkZHIs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBl
LCBpbnQgbW11X2lkeCk7DQo+ICsjZW5kaWYNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2FybS90Y2cvaGVscGVyLWE2NC5jIGIvdGFyZ2V0L2FybS90Y2cvaGVs
cGVyLWE2NC5jDQo+IGluZGV4IDhmNDJhMjhkMDcuLjljYjVkOGVlNTMgMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9hcm0vdGNnL2hlbHBlci1hNjQuYw0KPiArKysgYi90YXJnZXQvYXJtL3Rj
Zy9oZWxwZXItYTY0LmMNCj4gQEAgLTMwLDYgKzMwLDcgQEANCj4gICAjaW5jbHVkZSAicWVt
dS9jcmMzMmMuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiAgICNpbmNs
dWRlICJleGVjL2NwdV9sZHN0LmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCINCj4g
ICAjaW5jbHVkZSAicWVtdS9pbnQxMjguaCINCj4gICAjaW5jbHVkZSAicWVtdS9hdG9taWMx
MjguaCINCj4gICAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC5oIg0KPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3BwYy9tZW1faGVscGVyLmMgYi90YXJnZXQvcHBjL21lbV9oZWxwZXIuYw0KPiBp
bmRleCA1MWIxMzdmZWJkLi40NDk3NGIyNWY4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcHBj
L21lbV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcHBjL21lbV9oZWxwZXIuYw0KPiBAQCAt
MjQsNiArMjQsNyBAQA0KPiAgICNpbmNsdWRlICJleGVjL2hlbHBlci1wcm90by5oIg0KPiAg
ICNpbmNsdWRlICJoZWxwZXJfcmVncy5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdV9sZHN0
LmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCINCj4gICAjaW5jbHVkZSAiaW50ZXJu
YWwuaCINCj4gICAjaW5jbHVkZSAicWVtdS9hdG9taWMxMjguaCINCj4gICANCg0KUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4N
Cg0K


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D3C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twok1-00076Z-3u; Mon, 24 Mar 2025 16:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twojg-00074J-LL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:49:39 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twojc-0000C3-Ti
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:49:28 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso8935558a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742849363; x=1743454163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97hOyWapgZBd64gmy0Nc9wp499USihNMJzxpnuLZbN0=;
 b=oGx6rrISJL4/g6qQNgQZ9h4vxyu2/8UU+hn1tXMRwizJP0cLIc9qxKxCDFA1Z0eQne
 V07zBkTQ5PQ1jjtza+9NO7gT57oUeGc1dbyqlYb59MdDpN9aQiGYSED7IysmsIRBgsxZ
 oUCEv16h2P38tirMuvK2emD6fDCQuvxI1beJh1aPcl1Qz6+NhF/LmmnH2SQSkeA5l8Q/
 qU6B4RuR4sbnkl5HfeQdkkS3XNeR6nce9aS9YV9gwZGeK7qumkOLmwB53oCK1YIFJ1Tz
 aJiofqLrcT9xVIgvNsD/UTqb2zuH4TuKC+AtbeM7n/aXUFjQi29Cc2I6z6pAy+n1CYrk
 0QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849363; x=1743454163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97hOyWapgZBd64gmy0Nc9wp499USihNMJzxpnuLZbN0=;
 b=sKbIIwI1AbQETBuc5gODABc2mWMn/wRIjtBDumlo9pin+RID0xIV6Cn9pmDyiOg6V+
 VYVQPvsToAoEgPMRJrsda+anmdsmd+VBTVbrCQ5xTqzNzTVSA9v8/SfrAUxfSMYopv6h
 WdKkIwHwFu27PJrFVgS8/kfGsCdJiOYXXWASFcIqmhH4lcMh89MGD8+rKcxCgd9CdgP4
 ADWqid66anTAjEt9cve9I6wMcq+pwNw8KaQ4xtMRThyOFJMLSlgs23NoGvzJN8pdwQe1
 IqK+vSxGkaJbYJjLsFK0EgDwcESyA6nZXGJ10dfazVC/Tue68P7iLT7JRzwATs2OPG/q
 E9Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp0lFNcO6/HtKKz/UERq+GJruaX5ZHRpNaklX2IY4QRhn+4sncl5GvLx54r1wupZ+RjAodcAx4Ldmt@nongnu.org
X-Gm-Message-State: AOJu0Yxv8f6LZV5we9QM5tEkPMageSLegmmstbp7pRD+u6Pk0Y43vK5U
 F1FDi22goZb0gb3iKm8YyCJfiClDaxarPtpUZmZrmhHHLa5roZno3gB2xRBCLuE=
X-Gm-Gg: ASbGnctqWh6Mn/YOaf1x9SsSALd3vDibFih4QTDsrHAvq9aqouKL6SM797arivZtK1i
 7kgEOslDHsCa1ePbPXsitO2T9QTCK9EIwlYgbBWT7EgI/HKbVOIQfL/J6JPLMZpCbLgKYJdh8Zk
 mL77ovixQGfRLaeSY52LIaF39XtS6MzPO8dso9UwAoAzIoZPFUV6KLkEm5qAuoQ7Bi7pTcYCvbA
 vlCH2xvNMbleFRS3uzWLCl6Pf9mhn2lx98yfBowaOk3OhGIMR+dY1cW7lYABtXdMuBybcFd8RWJ
 BUGBE9/3v3Wb8X7SfBb66gip6JaodwEmDyLg5WExIVEZ/U/vKY8eQCP0+g==
X-Google-Smtp-Source: AGHT+IFXt3ZXtvjhqsKPjwTZjE6W+mT+TwD0xPN6Wv7bPTrX6BddvzyANfTOi8eqwCY9oud7VfiANQ==
X-Received: by 2002:a17:90b:2551:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-3030fe595c0mr25403894a91.7.1742849362863; 
 Mon, 24 Mar 2025 13:49:22 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f395e9sm75791905ad.28.2025.03.24.13.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:49:22 -0700 (PDT)
Message-ID: <4ff5ca15-6784-4660-b6f5-9c219d215378@linaro.org>
Date: Mon, 24 Mar 2025 13:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-10-alex.bennee@linaro.org>
 <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
 <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
 <f2fc4de2-7235-4c86-8574-2b8d630e5cd6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f2fc4de2-7235-4c86-8574-2b8d630e5cd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

T24gMy8yNC8yNSAxMzowNCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjQv
MjUgMTI6MjksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzI0LzI1IDEwOjM5
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzI0LzI1IDAzOjIxLCBBbGV4
IEJlbm7DqWUgd3JvdGU6DQo+Pj4+ICvCoMKgwqAgI2lmZGVmIFRBUkdFVF9CSUdfRU5ESUFO
DQo+Pj4+ICvCoMKgwqAgTWVtT3AgZW5kID0gTU9fQkU7DQo+Pj4+ICvCoMKgwqAgI2Vsc2UN
Cj4+Pj4gK8KgwqDCoCBNZW1PcCBlbmQgPSBNT19MRTsNCj4+Pj4gK8KgwqDCoCAjZW5kaWYN
Cj4+Pj4gKyNlbmRpZg0KPj4+DQo+Pj4gVGhhdCdzIHdoYXQgTU9fVEUgaXMgZm9yLg0KPj4+
DQo+Pj4+ICsvKg0KPj4+PiArICogSGVscGVycyBjb3BpZWQgZnJvbSBoZWxwZXJzLmgganVz
dCBmb3IgaGFuZGxpbmcgdGFyZ2V0X3Vsb25nIHZhbHVlcw0KPj4+PiArICogZnJvbSBnZGJz
dHViJ3MgR0J5dGVBcnJheSBiYXNlZCBvbiB3aGF0IHRoZSBidWlsZCBjb25maWcgaXMuIFRo
aXMNCj4+Pj4gKyAqIHdpbGwgbmVlZCBmaXhpbmcgZm9yIHNpbmdsZS1iaW5hcnkuDQo+Pj4+
ICsgKi8NCj4+Pj4gKw0KPj4+PiArI2lmIFRBUkdFVF9MT05HX0JJVFMgPT0gNjQNCj4+Pj4g
KyNkZWZpbmUgbGR0dWxfcChhZGRyKSBsZHFfcChhZGRyKQ0KPj4+PiArI2RlZmluZSBnZGJf
Z2V0X3JlZ2xfdmFsdWUobSwgYiwgdikgZ2RiX2dldF9yZWc2NF92YWx1ZShtLCBiLCB2KQ0K
Pj4+PiArI2Vsc2UNCj4+Pj4gKyNkZWZpbmUgbGR0dWxfcChhZGRyKSBsZGxfcChhZGRyKQ0K
Pj4+PiArI2RlZmluZSBnZGJfZ2V0X3JlZ2xfdmFsdWUobSwgYiwgdikgZ2RiX2dldF9yZWcz
Ml92YWx1ZShtLCBiLCB2KQ0KPj4+PiArI2VuZGlmDQo+Pj4NCj4+PiBTdXJlbHkgeW91J3Jl
IG5vdCBpbnRlbmRpbmcgdG8gcmVwbGljYXRlIHRoaXMgaW4gYW55IHRhcmdldCB0aGF0IGNh
biBoYXZlIG11bHRpcGxlIHNpemVzPw0KPj4+IFRoaXMgaXMgbm90IGFuIGltcHJvdmVtZW50
Lg0KPj4+DQo+Pg0KPj4gSWYgSSdtIGNvcnJlY3QgKGFuZCBmcm9tIHYxKSwgcHBjIGlzIHRo
ZSBvbmx5IGFyY2hpdGVjdHVyZSBoYXZpbmcgcmVnaXN0ZXJzIGRlZmluZWQgd2l0aA0KPj4g
dGFyZ2V0X2xvbmcgdHlwZXMuDQo+IA0KPiBXaXRoIGEgcXVpY2sgY2hlY2ssIG1pcHMsIHJp
c2N2LCBzcGFyYyBkbyBhcyB3ZWxsLg0KPg0KDQpSaWdodCwgSSBzaG91bGQgaGF2ZSBydW4g
dGhlIHNpbXBsZSBncmVwIDopDQpTbyBpdCdzIGJldHRlciB0byBrZWVwIHRob3NlIG1hY3Jv
cyBkZWZpbmVkIGluIGEgc2VwYXJhdGUgaGVhZGVyIChvdXQgb2YgDQpoZWxwZXJzLmgsIGxp
a2UgaGVscGVycy10YXJnZXQuaCksIHNvIHdlIGNhbiBhbHJlYWR5IHN0YXJ0IHRvIGNsZWFu
dXAgDQpzb21lIHRhcmdldHMsIGFuZCBkbyB0aGUgcmVzdCBvZiB0aGUgd29yayBmb3IgdGhl
IG9uZXMgdXNpbmcgDQp0YXJnZXRfdWxvbmcgdHlwZSBmb3IgbGF0ZXIuDQoNCj4gDQo+IHJ+
DQoNCg==


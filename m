Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD91C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMKN-00082r-48; Thu, 20 Mar 2025 16:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvMK4-000816-Jh
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:17:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvMJw-0006BL-K7
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:16:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22435603572so24016325ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742501810; x=1743106610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ztqrQSVxttMzOhz+XxSD7fJmmQFkQ9AG5S8dAxDfpyU=;
 b=Jc2DlpUTRFA9EZ1IpraMme/w2GplmZ5k9WacRqSimbwkhqQb8DMkBPZHC1QFtW1xaQ
 wkbJpOPKtEWghb2YEF0ove6U3tyG1l/FMUsjPCNLfQdK+g8uY1rCp1JO3fy1ObQ8h7WH
 viQr3r+BJ6GNXCwU/YCNi9+fE/jrlAegb6vexsQzGRgmW4CDm39+u/YWStlTx7TJ3FOY
 tQNBVFEz9ywZLGPE8X6dAYQBUxkT2gfYPapHnTa3teanea8c6fBOifICGoN5r0a2x2BV
 aO8Q1cicItOZiNAhKyWZ+q7IW1envJUeFLLrD/vCPNjRP1g/jOEBNKiMCvgwALtkYMja
 kUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742501810; x=1743106610;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztqrQSVxttMzOhz+XxSD7fJmmQFkQ9AG5S8dAxDfpyU=;
 b=NPWwDaaS0MWto7EIUFvWpc6jkhuLYVqUE0V4DTs/p4R2t0IuHNUtwz6+F/L1IRQZYQ
 VQ+eIhIWpQqwDuKY8QEdHVKXhlX26/HzX7ryCIVqU5RqMCU/yj6zC25WbSu8k5w72sR/
 7TmzpVS1QwALMliU3hDvE5s74v2RLTmYysNbX+S6qP1R+3XAaYOSQXYtQ5znxfkoysrJ
 BV7gnbV6NHw5LU6JkKFzAIOeb5Qn7gQZ0Jk2VwgFbfja7PbOTq5XiPyTmlpdzz1tjcfn
 AFmT+B9sA8CNr/tPImMXA8rDqRYYANFcE4vT/MLXRGnUaWLrhPTD3lherlfKpJfYWlea
 w8Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHLzNw8953zQpiAe7GzXopJZhrj8vHPfuoZ5CXN2cc9rOdphBrZhqTaQUTSoS4V0matwFRFzoiLwss@nongnu.org
X-Gm-Message-State: AOJu0YzHrJ7esoOvb8Hg6Fc8q0cqoUjL71hjM/SDnXqtnuL+oEefwFnP
 i7mYzbR8/GL/oHZDdOsSj+gDlx3jVH96QIA05pMqimRw3sAcz6uinNfOGGtOhyM=
X-Gm-Gg: ASbGnculEBjoWUqmytf7OIsG9urZNPX+s+B5a0wqUIuNNukXMOHGDmhYPV0XwgleSe9
 jkJiROffNw5VUTsVjxZW78yZRPh+wHeqXx8f5bajJu4PX79m6DTTUqRzo5Se86SgZJryL4quq+0
 o/KPJTG/GO+tamR9m8FJiAZv9k0W8M6toW9OZQL/kpzGwq2A38U5nNbvzgkEM7f8huCAPnMdeT7
 PjDqqf0xDl0iIj3qHb3LF53BIiv5xP2QvRGwCkd4lqD+Ror8tWqs5cPjD4pKICgat3vyzOdDYUf
 85nteoXPfGI+L0vDsHXeWoZGxDFgkWP7fH/D84xAQJiF5QRS2NOjZdiQzK683evA5O3Y
X-Google-Smtp-Source: AGHT+IFES38x6iH+cV5rc1c12rPZNCzJ+9KazpLQF+Z75dxcDEQWw0ZF4FsGeJNbr0xzzfX8n+NDow==
X-Received: by 2002:a05:6a00:1812:b0:736:6151:c6ca with SMTP id
 d2e1a72fcca58-7390598df4emr1155932b3a.4.1742501809874; 
 Thu, 20 Mar 2025 13:16:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611cae4sm240043b3a.101.2025.03.20.13.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 13:16:49 -0700 (PDT)
Message-ID: <7444c007-d8f1-4c55-ab4a-15becdf1c932@linaro.org>
Date: Thu, 20 Mar 2025 13:16:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
In-Reply-To: <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
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

T24gMy8yMC8yNSAxMjo1MiwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMy8xOS8y
NSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gVGhlIGFpbSBvZiB0aGlzIHdvcmsg
aXMgdG8gZ2V0IHJpZCBvZiB0aGUgZW5kaWFuIGF3YXJlIGhlbHBlcnMgaW4NCj4+IGdkYnN0
dWIvaGVscGVycy5oIHdoaWNoIGR1ZSB0byB0aGVpciB1c2Ugb2YgdHN3YXAoKSBtZWFuIHRh
cmdldA0KPj4gZ2Ric3R1YnMgbmVlZCB0byBiZSBidWlsdCBtdWx0aXBsZSB0aW1lcy4gV2hp
bGUgdGhpcyBzZXJpZXMgZG9lc24ndA0KPj4gYWN0dWFsbHkgYnVpbGQgZWFjaCBzdHViIG9u
Y2UgaXQgaW50cm9kdWNlcyBhIG5ldyBoZWxwZXIgLQ0KPj4gZ2RiX2dldF9yZWdpc3Rlcl92
YWx1ZSgpIHdoaWNoIHRha2VzIGEgTWVtT3Agd2hpY2ggY2FuIGRlc2NyaWJlIHRoZQ0KPj4g
Y3VycmVudCBlbmRpYW4gc3RhdGUgb2YgdGhlIHN5c3RlbS4gVGhpcyB3aWxsIGJlIGEgbG90
IGVhc2llciB0bw0KPj4gZHluYW1pY2FsbHkgZmVlZCBmcm9tIGEgaGVscGVyIGZ1bmN0aW9u
Lg0KPj4NCj4+IFRoZSBtb3N0IGNvbXBsZXggZXhhbXBsZSBpcyBQUEMgd2hpY2ggaGFzIGEg
aGVscGVyIGNhbGxlZA0KPj4gcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVyKCkgd2hpY2ggd2Fz
IGRvaW5nIHRoaXMuDQo+Pg0KPj4gVGhpcyBpcyBzdGlsbCBhbiBSRkMgc28gSSdtIGludGVy
ZXN0ZWQgaW4gZmVlZGJhY2s6DQo+Pg0KPj4gICAgIC0gaXMgdGhlIEFQSSBzYW5lDQo+PiAg
ICAgLSBjYW4gd2UgYXZvaWQgbG90cyBvZiAodWludDhfdCAqKSBjYXN0aW5nPw0KPiANCj4g
RXZlbiB0aG91Z2ggdGhlIHNlcmllcyBoYXMgYSBnb29kIGludGVudCwgdGhlIGZhY3Qgd2Ug
bWFrZSBldmVyeXRoaW5nDQo+ICJnZW5lcmljIiBtYWtlcyB0aGF0IHdlIGxvc2UgYWxsIGd1
YXJhbnRlZXMgd2UgY291bGQgZ2V0IGJ5IHJlbHlpbmcgb24NCj4gc3RhdGljIHR5cGluZywg
YW5kIHRoYXQgd2UgaGFkIHBvc3NpYmlsaXR5IG9mIG1pc3Rha2VzIHdoZW4gcGFzc2luZyBz
aXplDQo+ICh3aGljaCBoYXBwZW5lZCBpbiBwYXRjaCA0IGlmIEknbSBjb3JyZWN0KS4gQW5k
IGV4cGxpY2l0IGNhc3RpbmcgY29tZXMNCj4gYXMgYSAqc3Ryb25nKiB3YXJuaW5nIGFib3V0
IHRoYXQuDQo+IA0KPiBCeSBwYXRjaCA3LCBJIHdhcyByZWFsbHkgZmVlbGluZyBpdCdzIG5v
dCBhIHdpbiB2cyBleHBsaWNpdCBmdW5jdGlvbnMNCj4gcGVyIHNpemUuDQo+IA0KPiBJZiB0
aGUgZ29hbCBvZiB0aGUgc2VyaWVzIGlzIHRvIGdldCByaWQgb2YgZW5kaWFuIGF3YXJlIGhl
bHBlcnMsIHdlbGwsDQo+IHRoaXMgY2FuIGJlIGZpeGVkIGluIHRoZSBoZWxwZXJzIHRoZW1z
ZWx2ZXMsIHdpdGhvdXQgbmVlZGluZyB0bw0KPiBpbnRyb2R1Y2UgYSAiZ2VuZXJpYyIgc2l6
ZSBoZWxwZXIuIE1heWJlIHdlIGFyZSB0cnlpbmcgdG8gc29sdmUgdHdvDQo+IGRpZmZlcmVu
dCBwcm9ibGVtcyBoZXJlPw0KPiANCj4+ICAgICAtIHNob3VsZCB3ZSBoYXZlIGEgcmV2ZXJz
ZSBoZWxwZXIgZm9yIHNldHRpbmcgcmVnaXN0ZXJzDQo+Pg0KPj4gSWYgdGhpcyBzZWVtcyBs
aWtlIHRoZSByaWdodCBhcHByb2FjaCBJIGNhbiBoYXZlIGEgZ28gYXQgbW9yZSBvZiB0aGUN
Cj4+IGZyb250ZW5kcyBsYXRlci4NCj4+DQoNCkxvb2tpbmcgYXQgaW5jbHVkZS9nZGJzdHVi
L2hlbHBlcnMuaCwgZ2RiX2dldF9yZWcxMjggY2FuIGJlIHNvbHZlZCBieSANCnVzaW5nIHRh
cmdldF93b3Jkc19iaWdlbmRpYW4oKSBpbnN0ZWFkIG9mIFRBUkdFVF9CSUdfRU5ESUFOLCB3
aGljaCBpcyANCmFscmVhZHkgd2hhdCB0c3dhcCBwcmltaXRpdmVzIGFyZSBkb2luZy4NCg0K
Rm9yIGdkYl9nZXRfcmVnbCwgSSB3b3VsZCBnZXQgcmlkIG9mIGl0IGNvbXBsZXRlbHksIGJ5
IGVkaXRpbmcgYWxsIA0KdGFyZ2V0cyBnZGJzdHViLmMsIGFuZCByZXBsYWNpbmcgd2l0aCBn
ZGJfZ2V0X3JlZzMyIG9yIGdkYl9nZXRfcmVnNjQgDQpleHBsaWNpdCBjYWxscy4NCnBwYyBp
cyBhIHZlcnkgbmF1Z2h0eSBib3ksIGJlY2F1c2UgcmVnaXN0ZXJzIGFyZSBkZWZpbmVkIGFz
IA0KdGFyZ2V0X3Vsb25nLCB3aGlsZSBvdGhlciBhcmNoIHVzZSBmaXhlZCB0eXBlcy4gVGhl
IHNvbHV0aW9uIG1pZ2h0IGJlIGFzIA0Kc2ltcGxlIGFzIGNoYW5naW5nIHBwYyByZWdpc3Rl
cnMgZGVmaW5pdGlvbiB0byB1aW50NjRfdC4NCklmIGl0J3MgdG9vIGNvbXBsaWNhdGVkLCB5
b3UgY2FuIHBvc3Rwb25lIHRoZSBwcm9ibGVtIGJ5IGxlYXZpbmcgDQpnZGJfZ2V0X3JlZ2wg
ZGVmaW5lZCBvbmx5IGluIHBwYyBnZGJzdHViLCBhbmQgY2xlYW4gdXAgYWxsIG90aGVyIGFy
Y2guDQpUaGFua3MgdG8gc3RhdGljIHR5cGluZywgaXQgd2lsbCBiZSBlYXN5IHRvIHNwb3Qg
YSB3cm9uZyBnZGJfZ2V0X3JlZ2wgDQpjb252ZXJzaW9uLCBzbyBpdCdzIGEgbm8tcmlzayBv
cGVyYXRvbi4NCg0KRm9yIGxkdHVsX3AsIGxkdHVsX2xlX3AsIGFuZCBsZHR1bF9iZV9wLCBp
dCdzIGEgc2ltaWxhciBnYW1lLiBJdCdzIA0KaGFyZGVyIGJlY2F1c2Ugb25seSByZXR1cm4g
dHlwZSB3aWxsIGRpZmZlciwgYW5kIHlvdSBtaWdodCBtaXNzIG9jY3VyZW5jZXMuDQpBIHNh
ZmUgd2F5IGNvdWxkIGJlIHRvIHJlcGxhY2UgbGR0dWxfcCBieSBjYWxsIHRvIGEgZnVuY3Rp
b24gdGFraW5nIA0KcmV0dXJuIHZhbHVlIHRocm91Z2ggcG9pbnRlciBpbiBwYXJhbWV0ZXIu
IFRoaXMgd2F5LCB5b3UgY2FuIHJlcGxhY2UgDQplYXNpbHkgd2l0aCBsIGFuZCBxIHZhcmlh
bnRzLCB3aXRob3V0IGFueSByaXNrIG9mZiBpbXBsaWNpdCBjb252ZXJzaW9uLg0KQW5kIGZv
ciB0aGUgb25lIGxlZnQgZGVwZW5kaW5nIG9uIHRhcmdldF91bG9uZy90YXJnZXRfbG9uZywg
bGVhdmUgdGhhdCANCmZvciBub3csIGFuZCBtb3ZlIGxkdHVsKl9wIHRvIGEgdGFyZ2V0LWhl
bHBlci5oIGluY2x1ZGVkIG9ubHkgZm9yIGFyY2hzIA0KbmVlZGluZyB0aGlzLg0KDQo+PiBU
aGVyZSBhcmUgYSBmZXcgb3RoZXIgbWlzYyBjbGVhbi11cHMgSSBkaWQgb24gdGhlIHdheSB3
aGljaCBtaWdodCBiZQ0KPj4gd29ydGggY2hlcnJ5IHBpY2tpbmcgZm9yIDEwLjAgYnV0IEkn
bGwgbGVhdmUgdGhhdCB1cCB0byBtYWludGFpbmVycy4NCj4+DQo+PiBBbGV4Lg0KPj4NCj4+
IEFsZXggQmVubsOpZSAoMTApOg0KPj4gICAgIGluY2x1ZGUvZ2Ric3R1YjogZml4IGluY2x1
ZGUgZ3VhcmQgaW4gY29tbWFuZHMuaA0KPj4gICAgIGdkYnN0dWI6IGludHJvZHVjZSB0YXJn
ZXQgaW5kZXBlbmRlbnQgZ2RiIHJlZ2lzdGVyIGhlbHBlcg0KPj4gICAgIHRhcmdldC9hcm06
IGNvbnZlcnQgMzIgYml0IGdkYnN0dWIgdG8gbmV3IGhlbHBlcg0KPj4gICAgIHRhcmdldC9h
cm06IGNvbnZlcnQgNjQgYml0IGdkYnN0dWIgdG8gbmV3IGhlbHBlcg0KPj4gICAgIHRhcmdl
dC9wcGM6IGV4cGFuZCBjb21tZW50IG9uIEZQL1ZNWC9WU1ggYWNjZXNzIGZ1bmN0aW9ucw0K
Pj4gICAgIHRhcmdldC9wcGM6IG1ha2UgcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVyIHN0YXRp
Yw0KPj4gICAgIHRhcmdldC9wcGM6IGNvbnZlcnQgZ2Ric3R1YiB0byBuZXcgaGVscGVyICgh
aGFja3kpDQo+PiAgICAgZ2Ric3R1YjogYXNzZXJ0IGVhcmxpZXIgaW4gaGFuZGxlX3JlYWRf
YWxsX3JlZ3MNCj4+ICAgICBpbmNsdWRlL2V4ZWM6IGZpeCBhc3NlcnQgaW4gc2l6ZV9tZW1v
cA0KPj4gICAgIHRhcmdldC9taWNyb2JsYXplOiBjb252ZXJ0IGdkYnN0dWIgdG8gbmV3IGhl
bHBlcg0KPj4NCj4+ICAgIGluY2x1ZGUvZXhlYy9tZW1vcC5oICAgICAgICB8ICAgNCArLQ0K
Pj4gICAgaW5jbHVkZS9nZGJzdHViL2NvbW1hbmRzLmggIHwgICAyICstDQo+PiAgICBpbmNs
dWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmggfCAgMzAgKysrKysrDQo+PiAgICB0YXJnZXQvcHBj
L2NwdS5oICAgICAgICAgICAgfCAgIDggKy0NCj4+ICAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAg
ICAgICAgICB8ICAyNCArKysrLQ0KPj4gICAgdGFyZ2V0L2FybS9nZGJzdHViLmMgICAgICAg
IHwgIDU3ICsrKysrKystLS0tDQo+PiAgICB0YXJnZXQvYXJtL2dkYnN0dWI2NC5jICAgICAg
fCAgNTMgKysrKysrLS0tLQ0KPj4gICAgdGFyZ2V0L21pY3JvYmxhemUvZ2Ric3R1Yi5jIHwg
IDQ0ICsrKystLS0tDQo+PiAgICB0YXJnZXQvcHBjL2dkYnN0dWIuYyAgICAgICAgfCAxOTQg
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+PiAgICA5IGZpbGVzIGNo
YW5nZWQsIDI1NyBpbnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pDQo+PiAgICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9nZGJzdHViL3JlZ2lzdGVycy5oDQo+Pg0KPiANCg0K



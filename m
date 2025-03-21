Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C9C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgDU-0004aT-NL; Fri, 21 Mar 2025 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgDM-0004Zq-IU
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:31:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgDK-0001M0-A1
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:31:23 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso3309249a91.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742578280; x=1743183080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DrFtCIvaLTzjOWuaWQ6uwsyQfRpw9NZV1uzK6X4bCmM=;
 b=poCPBcm69fsHemhbjq0qV0k0aZyQvjsAX0ElEWJKt2gPDC5CaYNn3M0wtFGZ8aK4Lk
 5OSH3pkQgZpcioyW7r2XdVbDWSBY+tKk2uuSdEm6uCdK7hFa3A7TRcJ0o3JZaiM/CpQD
 CWHoqQLC4sWJ6cM001hcEQFNvWXxs/J6+UYiFiBE+41LRTSUwRJbdNFxV4BLY0jCyohl
 ruQ7gCeGeKJRqcYj1ckbodXfOFuXPoKfbTPuDUKPi6KCOsSR/oAxlwQ/RDoCc/nkm7kR
 nN5RwhkrjP8d4dLrHrpNJ1MSW6R0Z4H37b9Mp8q9Di9kUbtQU4B58AOSfXHDoDd63rNI
 CT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578280; x=1743183080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrFtCIvaLTzjOWuaWQ6uwsyQfRpw9NZV1uzK6X4bCmM=;
 b=wkgbXFEIzMlr+WQhXb1PeNkfZlNRqyg97iZqizRyXOazIalcDoY7ug7UVmbG+6KuAE
 t47+oKFitVZoNFPyAFx8tVwpueb/S/327tGX4CvDwAWuRC0UGgLc1UHALeDeHKc3TBNi
 qgOnvuEu0KpLiOBms/tua8h7C9Duyi1l51IYezJG8QRHuCEtC8H4rviGuPIOQbMVaUBd
 McvO5crcDHNNNlMybnfvVuMYSY2aQI0cz+gMU+yD6n1r/7DTvI7poDn66lytJcY2HtMv
 NAcfw+rtwO4zWHitDB6GFMky946/JYbSF4y9KEpYv9U9ls3gJanOjwdADb45z6MA6vo7
 79Sw==
X-Gm-Message-State: AOJu0Yxn4FwoxbrYZlsCmjj6p0sDd4uunZTY6j4N+WE10r7IINviZ+51
 FtYrMekhLUKL+MSnKwP975j3iNG8jFC+t/xRqcwkJB5e1/yevwotDkNsmtRhV/w=
X-Gm-Gg: ASbGncsk+V7dN/sqDqFhg596X1H0XnZayT01Q6ccGcZiEpZswhmZManTK7wR+gIvwCr
 K7ud6DKJN2V7l46S9uE1qhKkbghQ13+pGRasafSVLk4chSnBFznkiiC3WrapIh1jseftanmpueS
 QoRChZOiotbgJzTUAE2pzZKbweNvO5daSgjbkDB8P6houdlaHDqfQRQePPYm9xYwQ9b+UgqBqNj
 GasnSVJgqeqeL0clUoGYmaBbxf0HaGhk1o0Ybo9/394DiL8CIRGWCAxeB6TP4MXAP5o6Aeo/2JK
 QcFKpy2Qbihs0GUUW1tb560KI8jmLLtjWZG+d7YOhG5fjvbDcn60PsLDgD8=
X-Google-Smtp-Source: AGHT+IGMSU5WqluuG/BPPkgn0Ar0vFGm7RggxiwfwyziOE0QM1xCSHvgb+XffBGa+Xm5vNowiYuvFA==
X-Received: by 2002:a17:90b:2f4d:b0:2ff:6aa6:47a3 with SMTP id
 98e67ed59e1d1-3030fef7703mr6748783a91.25.1742578280440; 
 Fri, 21 Mar 2025 10:31:20 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm6968337a91.13.2025.03.21.10.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:31:19 -0700 (PDT)
Message-ID: <3e1c7b60-18cf-4ca6-b853-02203954fc3a@linaro.org>
Date: Fri, 21 Mar 2025 10:31:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
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
 <87a59eli7m.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87a59eli7m.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

T24gMy8yMS8yNSAwNDo0NiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAz
LzE5LzI1IDExOjIyLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gVGhlIGFpbSBvZiB0aGlz
IHdvcmsgaXMgdG8gZ2V0IHJpZCBvZiB0aGUgZW5kaWFuIGF3YXJlIGhlbHBlcnMgaW4NCj4+
PiBnZGJzdHViL2hlbHBlcnMuaCB3aGljaCBkdWUgdG8gdGhlaXIgdXNlIG9mIHRzd2FwKCkg
bWVhbiB0YXJnZXQNCj4+PiBnZGJzdHVicyBuZWVkIHRvIGJlIGJ1aWx0IG11bHRpcGxlIHRp
bWVzLiBXaGlsZSB0aGlzIHNlcmllcyBkb2Vzbid0DQo+Pj4gYWN0dWFsbHkgYnVpbGQgZWFj
aCBzdHViIG9uY2UgaXQgaW50cm9kdWNlcyBhIG5ldyBoZWxwZXIgLQ0KPj4+IGdkYl9nZXRf
cmVnaXN0ZXJfdmFsdWUoKSB3aGljaCB0YWtlcyBhIE1lbU9wIHdoaWNoIGNhbiBkZXNjcmli
ZSB0aGUNCj4+PiBjdXJyZW50IGVuZGlhbiBzdGF0ZSBvZiB0aGUgc3lzdGVtLiBUaGlzIHdp
bGwgYmUgYSBsb3QgZWFzaWVyIHRvDQo+Pj4gZHluYW1pY2FsbHkgZmVlZCBmcm9tIGEgaGVs
cGVyIGZ1bmN0aW9uLg0KPj4+IFRoZSBtb3N0IGNvbXBsZXggZXhhbXBsZSBpcyBQUEMgd2hp
Y2ggaGFzIGEgaGVscGVyIGNhbGxlZA0KPj4+IHBwY19tYXliZV9ic3dhcF9yZWdpc3Rlcigp
IHdoaWNoIHdhcyBkb2luZyB0aGlzLg0KPj4+IFRoaXMgaXMgc3RpbGwgYW4gUkZDIHNvIEkn
bSBpbnRlcmVzdGVkIGluIGZlZWRiYWNrOg0KPj4+ICAgICAtIGlzIHRoZSBBUEkgc2FuZQ0K
Pj4+ICAgICAtIGNhbiB3ZSBhdm9pZCBsb3RzIG9mICh1aW50OF90ICopIGNhc3Rpbmc/DQo+
Pg0KPj4gRXZlbiB0aG91Z2ggdGhlIHNlcmllcyBoYXMgYSBnb29kIGludGVudCwgdGhlIGZh
Y3Qgd2UgbWFrZSBldmVyeXRoaW5nDQo+PiAiZ2VuZXJpYyIgbWFrZXMgdGhhdCB3ZSBsb3Nl
IGFsbCBndWFyYW50ZWVzIHdlIGNvdWxkIGdldCBieSByZWx5aW5nIG9uDQo+PiBzdGF0aWMg
dHlwaW5nLCBhbmQgdGhhdCB3ZSBoYWQgcG9zc2liaWxpdHkgb2YgbWlzdGFrZXMgd2hlbiBw
YXNzaW5nDQo+PiBzaXplICh3aGljaCBoYXBwZW5lZCBpbiBwYXRjaCA0IGlmIEknbSBjb3Jy
ZWN0KS4gQW5kIGV4cGxpY2l0IGNhc3RpbmcNCj4+IGNvbWVzIGFzIGEgKnN0cm9uZyogd2Fy
bmluZyBhYm91dCB0aGF0Lg0KPj4NCj4+IEJ5IHBhdGNoIDcsIEkgd2FzIHJlYWxseSBmZWVs
aW5nIGl0J3Mgbm90IGEgd2luIHZzIGV4cGxpY2l0IGZ1bmN0aW9ucw0KPj4gcGVyIHNpemUu
DQo+Pg0KPj4gSWYgdGhlIGdvYWwgb2YgdGhlIHNlcmllcyBpcyB0byBnZXQgcmlkIG9mIGVu
ZGlhbiBhd2FyZSBoZWxwZXJzLCB3ZWxsLA0KPj4gdGhpcyBjYW4gYmUgZml4ZWQgaW4gdGhl
IGhlbHBlcnMgdGhlbXNlbHZlcywgd2l0aG91dCBuZWVkaW5nIHRvDQo+PiBpbnRyb2R1Y2Ug
YSAiZ2VuZXJpYyIgc2l6ZSBoZWxwZXIuIE1heWJlIHdlIGFyZSB0cnlpbmcgdG8gc29sdmUg
dHdvDQo+PiBkaWZmZXJlbnQgcHJvYmxlbXMgaGVyZT8NCj4gDQo+IEl0IGRpZCBzZWVtIG5h
dHVyYWwgdGhhdCBpZiB5b3Ugd2VyZSBkZWZpbmluZyBhIE1lbU9wIHlvdSB3b3VsZCB1c2Ug
YWxsDQo+IG9mIGl0IHJhdGhlciB0aGFuIG9ubHkgaXRzIGVuZGlhbiBkZWZpbml0aW9uLiBC
dXQgeW91IGFyZSByaWdodCB3ZSBjb3VsZA0KPiBpbnRyb2R1Y2UgdGhlIHNhbWUgaGVscGVy
cyB3aXRoIGEgYm9vbCBmbGFnIGZvciBlbmRpYW5lc3MuDQo+IA0KDQpEZWZpbmluZyBNZW1P
cCBhbmQgcGFzc2luZyBpcyBvaywgYnV0IGxvb3Npbmcgc3RhdGljIHR5cGluZyBndWFyYW50
ZWVzIA0KaXMgd3JvbmcgaW4gbXkgb3Bpbmlvbi4gQyBpcyBhbHJlYWR5IG9uIHRoZSB3ZWFr
IHNpZGUgcmVnYXJkaW5nIHR5cGluZywgDQp3ZSBkb24ndCBuZWVkIHRvICJ2b2lkKiJpemUg
dGhpbmdzIG1vcmUgaW5zdGVhZCBvZiByZXBsYWNpbmcgdGhlIGNhbGxzIA0Kd2l0aCBjb3Jy
ZWN0IHZhcmlhbnRzLg0KDQo+IE1heWJlIHdlIHNob3VsZCBoYXZlIGZ1bGx5IGZvcm1lZCBt
b3BzIGFuZCBqdXN0IGFzc2VydCBpbiB0aGUgaGVscGVyOg0KPiANCj4gICAgZ2RiX2dldF9y
ZWczMihNZW1PcCBvcCwgR0J5dGVBcnJheSAqYnVmLCB1aW50MzJfdCB2YWwpIHsNCj4gICAg
ICAgIGdfYXNzZXJ0KG9wICYgTU9fU0laRSA9PSBNT18zMik7DQo+ICAgICAgICBnZGJfZ2V0
X3JlZ2lzdGVyX3ZhbHVlKG9wLCBidWYsICZ2YWwpOw0KPiAgICB9DQo+IA0KPiBJIHdhcyBh
bHNvIHRyeWluZyB0byBhdm9pZCBvdmVyIGJvaWxlcnBsYXRpbmcgdGhlIGNvZGUuDQo+DQoN
CkFkZGluZyBwcm9wZXIgZnVuY3Rpb25zIGRlZmluaXRpb24gaW5zdGVhZCBvZiBtYWNyb3Ms
IGFuZCBlbGltaW5hdGluZyANCmlmZGVmcyBpcyBub3QgcmVhbGx5IGJvaWxlcnBsYXRlLg0K
QWRkaW5nIGNhc3RzIHRvIGxvb3NlbiB0eXBlIHN5c3RlbSBpcyBub3QgYSB3aW4gdmVyc3Vz
IHRoYXQuDQoNCj4+DQo+Pj4gICAgIC0gc2hvdWxkIHdlIGhhdmUgYSByZXZlcnNlIGhlbHBl
ciBmb3Igc2V0dGluZyByZWdpc3RlcnMNCj4+PiBJZiB0aGlzIHNlZW1zIGxpa2UgdGhlIHJp
Z2h0IGFwcHJvYWNoIEkgY2FuIGhhdmUgYSBnbyBhdCBtb3JlIG9mIHRoZQ0KPj4+IGZyb250
ZW5kcyBsYXRlci4NCj4+PiBUaGVyZSBhcmUgYSBmZXcgb3RoZXIgbWlzYyBjbGVhbi11cHMg
SSBkaWQgb24gdGhlIHdheSB3aGljaCBtaWdodCBiZQ0KPj4+IHdvcnRoIGNoZXJyeSBwaWNr
aW5nIGZvciAxMC4wIGJ1dCBJJ2xsIGxlYXZlIHRoYXQgdXAgdG8gbWFpbnRhaW5lcnMuDQo+
Pj4gQWxleC4NCj4+PiBBbGV4IEJlbm7DqWUgKDEwKToNCj4+PiAgICAgaW5jbHVkZS9nZGJz
dHViOiBmaXggaW5jbHVkZSBndWFyZCBpbiBjb21tYW5kcy5oDQo+Pj4gICAgIGdkYnN0dWI6
IGludHJvZHVjZSB0YXJnZXQgaW5kZXBlbmRlbnQgZ2RiIHJlZ2lzdGVyIGhlbHBlcg0KPj4+
ICAgICB0YXJnZXQvYXJtOiBjb252ZXJ0IDMyIGJpdCBnZGJzdHViIHRvIG5ldyBoZWxwZXIN
Cj4+PiAgICAgdGFyZ2V0L2FybTogY29udmVydCA2NCBiaXQgZ2Ric3R1YiB0byBuZXcgaGVs
cGVyDQo+Pj4gICAgIHRhcmdldC9wcGM6IGV4cGFuZCBjb21tZW50IG9uIEZQL1ZNWC9WU1gg
YWNjZXNzIGZ1bmN0aW9ucw0KPj4+ICAgICB0YXJnZXQvcHBjOiBtYWtlIHBwY19tYXliZV9i
c3dhcF9yZWdpc3RlciBzdGF0aWMNCj4+PiAgICAgdGFyZ2V0L3BwYzogY29udmVydCBnZGJz
dHViIHRvIG5ldyBoZWxwZXIgKCFoYWNreSkNCj4+PiAgICAgZ2Ric3R1YjogYXNzZXJ0IGVh
cmxpZXIgaW4gaGFuZGxlX3JlYWRfYWxsX3JlZ3MNCj4+PiAgICAgaW5jbHVkZS9leGVjOiBm
aXggYXNzZXJ0IGluIHNpemVfbWVtb3ANCj4+PiAgICAgdGFyZ2V0L21pY3JvYmxhemU6IGNv
bnZlcnQgZ2Ric3R1YiB0byBuZXcgaGVscGVyDQo+Pj4gICAgaW5jbHVkZS9leGVjL21lbW9w
LmggICAgICAgIHwgICA0ICstDQo+Pj4gICAgaW5jbHVkZS9nZGJzdHViL2NvbW1hbmRzLmgg
IHwgICAyICstDQo+Pj4gICAgaW5jbHVkZS9nZGJzdHViL3JlZ2lzdGVycy5oIHwgIDMwICsr
KysrKw0KPj4+ICAgIHRhcmdldC9wcGMvY3B1LmggICAgICAgICAgICB8ICAgOCArLQ0KPj4+
ICAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgICB8ICAyNCArKysrLQ0KPj4+ICAgIHRh
cmdldC9hcm0vZ2Ric3R1Yi5jICAgICAgICB8ICA1NyArKysrKysrLS0tLQ0KPj4+ICAgIHRh
cmdldC9hcm0vZ2Ric3R1YjY0LmMgICAgICB8ICA1MyArKysrKystLS0tDQo+Pj4gICAgdGFy
Z2V0L21pY3JvYmxhemUvZ2Ric3R1Yi5jIHwgIDQ0ICsrKystLS0tDQo+Pj4gICAgdGFyZ2V0
L3BwYy9nZGJzdHViLmMgICAgICAgIHwgMTk0ICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLQ0KPj4+ICAgIDkgZmlsZXMgY2hhbmdlZCwgMjU3IGluc2VydGlvbnMoKyks
IDE1OSBkZWxldGlvbnMoLSkNCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9n
ZGJzdHViL3JlZ2lzdGVycy5oDQo+Pj4NCj4gDQoNCg==


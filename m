Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6250FA1FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZjA-0004X1-Mq; Wed, 22 Apr 2026 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wFZj7-0004Vu-QV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:42:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wFZj4-0001sx-2A
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:42:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so7266514a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1776872572; x=1777477372; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Gq6ugJyH1iB0WsCcNUD/eNxZR0GzGz3K8kVdulfmgUI=;
 b=N1GEKFwOE5BJiPgE/LpLD6xbqHA3h46FOUA6vqdktddQCL4fSkuVw8mMisIr8u1x1U
 dFokTsWjecSdiqy5PfUsh7Pp1rRrIIm+r55di3DdVYggROnioodvdB0DQfRQrawbUs76
 p4JhdK6EbcQ+avm17n2Ciz1B8C7anQEe9f6FaTNIR0QPvEh3CujJ/MHA/n2dvPOmnJd3
 TG62fjGF/SMrcqObcLeI34IfvoaTJcza9ebsh1OauBzQ0D3M+J84q7Um0br4rapkgL0W
 geFef3WTwIxD49LvM/tmsqN9zWjY6nVX1+6j9rOtiGUy8fbadzy0FvaiXrkJl/oBO1FV
 NFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872572; x=1777477372;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gq6ugJyH1iB0WsCcNUD/eNxZR0GzGz3K8kVdulfmgUI=;
 b=J7hC4NXf2AGMcSAq/8ofZoiu9NWF7w0oI/0fQhx+W7rKR0M1wIS0adiq3D7+rPpPcJ
 VAb2/47vNNly9zwWldTsUh7xw42OZdJn0y/cE9OkjryqyaET+peNdjIYU1BlfzP7RGLx
 0d+0JQk0J0jTeovUZ8Mc4yuk+uY18MwbyeUBCrkT3GFegXHrY6eW0MhH2CBe46JHLiuF
 fnhi5S6rpLkrztZyadO27ftUl2D7m5df4dcnld8mWyl9u29bCrAcvygM6T2NC+xchvcs
 OHXtqrQJtg6FBd7dnC16pO3ljNRg0YuNQHWLluMZJU3fVEZgQGT09E5uXasMs4BUpu0w
 SoJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HvZv9dLWEIrVy9A5WWKtr/Ye2lM1ESrZFP4XwYkgZe42EVh2cfeDxLiqgJHm0jvPKKR2cMWRaX6/9@nongnu.org
X-Gm-Message-State: AOJu0Ywi2rlERbKXFTHZ7mytQdlQyahAwNiwNclvwHnLcw3XCuRFp/rl
 4jH9zGIRYVOobFX+lJ9LIfW3Wiys4CSHfMDQSBs+wE7BuOIsc/8/blZmF0WnumWxnRA=
X-Gm-Gg: AeBDievNlDAgxjp1QoxV736X8vtsZ88DncfpZ/9C6PNgC+kcjK7nnVT/jGjfeM5bzF1
 kSrOHWIPjXbUVtNXuH+7cM94ErLBoBIqAoU+q3b4ajaQdAUjVmI1E+KK0Q7fHtXxCvrEzaNCt+/
 /Q+k9lYxGUYCRh3LBwlOPfni9YXhmOC4415Axt05+cJ8NgGimfxw+bu06oT1Sgj2dWDqKIGMoJj
 eNAdXPgkEO5/nxYQ6nSyQYuGylIZPW93qPVQlXZs02EaeyrL18bR9DCyNKYfQdVQIItFCZesCSZ
 hBZnYAD4+jXRGBt4Zgq/qqIh5ATeKxPh5nC9pe4YjvyP900s8B+0061Pyc4PiojqDoz1eGmNLJS
 XV3mVHKlRicVzQ/C1mKxBP/+6Ku0+rFdzWTrTfUUT8oso7FzwR8WJ5IYAIncRYy3RmlDKSbYkR7
 0Sfd6yb7ghUH0p+AIwR0NDA3RCUSiAGf4pN24v5sofs6R1Hb/iExfcXuQ=
X-Received: by 2002:a17:907:968f:b0:ba7:d004:8f98 with SMTP id
 a640c23a62f3a-ba7d00564admr726433366b.46.1776872571713; 
 Wed, 22 Apr 2026 08:42:51 -0700 (PDT)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba4517ee077sm575287866b.18.2026.04.22.08.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 08:42:51 -0700 (PDT)
Message-ID: <3e7f9fb1-e9a7-49b5-91b2-866aae623a15@lowrisc.org>
Date: Wed, 22 Apr 2026 16:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v3 06/10] ot_uart: implement RX fifo and loopback
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-6@git.sr.ht>
 <CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmail.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
In-Reply-To: <CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eNYGwgWYXGfMJeHbo1BrhnhB"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eNYGwgWYXGfMJeHbo1BrhnhB
Content-Type: multipart/mixed; boundary="------------yJgxuBD07Jxf5KZ0EmsoWfZC";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Message-ID: <3e7f9fb1-e9a7-49b5-91b2-866aae623a15@lowrisc.org>
Subject: Re: [PATCH qemu v3 06/10] ot_uart: implement RX fifo and loopback
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-6@git.sr.ht>
 <CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmail.com>

--------------yJgxuBD07Jxf5KZ0EmsoWfZC
Content-Type: multipart/mixed; boundary="------------vsqqwQDvmZMertj3Y9rVksBt"

--------------vsqqwQDvmZMertj3Y9rVksBt
Content-Type: multipart/alternative;
 boundary="------------kA1Cxm9vDhraqvzYbE1if3vD"

--------------kA1Cxm9vDhraqvzYbE1if3vD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxNi8wNC8yMDI2IDAyOjM4LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBPbiBX
ZWQsIEFwciAxNSwgMjAyNiBhdCAzOjIz4oCvQU0gfmxleGJhaWxleWxvd3Jpc2MNCj4gPGxl
eGJhaWxleWxvd3Jpc2NAZ2l0LnNyLmh0PiB3cm90ZToNCj4+IEZyb206IExleCBCYWlsZXk8
bGV4LmJhaWxleUBsb3dyaXNjLm9yZz4NCj4+DQo+PiBUaGUgU1RBVFVTIHJlZ2lzdGVyIHZh
bHVlIGlzIG5vdyBnZW5lcmF0ZWQgb24gZXZlcnkgcmVhZCBpbnN0ZWFkIG9mIGJlaW5nDQo+
PiB0cmFja2VkIGluIG1lbW9yeSBzaW5jZSBpdCBoYXMgc3VjaCBhIGR5bmFtaWMgdmFsdWUu
IHRoZSByZWNlaXZlIGZpZm8gaXMgbm93DQo+PiBpbXBsZW1lbnRlZCwgYW5kIHRoZSBzeXN0
ZW0gbG9vcGJhY2sgbW9kZS4gKGxpbmUgbG9vcGJhY2sgaXMgbm90IHN1cHBvcnRlZCkNCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBMZXggQmFpbGV5PGxleC5iYWlsZXlAbG93cmlzYy5vcmc+
DQo+PiAtLS0NCj4+ICAgaHcvY2hhci9vdF91YXJ0LmMgfCAxNjAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MTEyIGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9jaGFyL290X3VhcnQuYyBiL2h3L2NoYXIvb3RfdWFydC5jDQo+PiBpbmRleCAyMjQ3
ZGI3MTEwLi4zNTExYTQyZmJlIDEwMDY0NA0KPj4gLS0tIGEvaHcvY2hhci9vdF91YXJ0LmMN
Cj4+ICsrKyBiL2h3L2NoYXIvb3RfdWFydC5jDQo+PiBAQCAtMTQwLDYgKzE0MCwyMSBAQCBz
dGF0aWMgdm9pZCBvdF91YXJ0X3VwZGF0ZV9pcnFzKE90VUFSVFN0YXRlICpzKQ0KPj4gICAg
ICAgfQ0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBib29sIG90X3VhcnRfaXNfc3lzX2xvb3Bh
Y2tfZW5hYmxlZChjb25zdCBPdFVBUlRTdGF0ZSAqcykNCj4+ICt7DQo+PiArICAgIHJldHVy
biBGSUVMRF9FWDMyKHMtPnJlZ3NbUl9DVFJMXSwgQ1RSTCwgU0xQQkspOw0KPj4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgYm9vbCBvdF91YXJ0X2lzX3R4X2VuYWJsZWQoY29uc3QgT3RVQVJU
U3RhdGUgKnMpDQo+PiArew0KPj4gKyAgICByZXR1cm4gRklFTERfRVgzMihzLT5yZWdzW1Jf
Q1RSTF0sIENUUkwsIFRYKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGJvb2wgb3RfdWFy
dF9pc19yeF9lbmFibGVkKGNvbnN0IE90VUFSVFN0YXRlICpzKQ0KPj4gK3sNCj4+ICsgICAg
cmV0dXJuIEZJRUxEX0VYMzIocy0+cmVnc1tSX0NUUkxdLCBDVFJMLCBSWCk7DQo+PiArfQ0K
Pj4gKw0KPj4gICBzdGF0aWMgaW50IG90X3VhcnRfY2FuX3JlY2VpdmUodm9pZCAqb3BhcXVl
KQ0KPj4gICB7DQo+PiAgICAgICBPdFVBUlRTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+IEBAIC0x
OTYsNyArMjExLDcgQEAgc3RhdGljIHZvaWQgb3RfdWFydF9yZXNldF9yeF9maWZvKE90VUFS
VFN0YXRlICpzKQ0KPj4gICAgICAgZmlmbzhfcmVzZXQoJnMtPnJ4X2ZpZm8pOw0KPj4gICAg
ICAgcy0+cmVnc1tSX0lOVFJfU1RBVEVdICY9IH5JTlRSX1JYX1dBVEVSTUFSS19NQVNLOw0K
Pj4gICAgICAgcy0+cmVnc1tSX0lOVFJfU1RBVEVdICY9IH5JTlRSX1JYX09WRVJGTE9XX01B
U0s7DQo+PiAtICAgIGlmIChGSUVMRF9FWDMyKHMtPnJlZ3NbUl9DVFJMXSwgQ1RSTCwgUlgp
KSB7DQo+PiArICAgIGlmIChvdF91YXJ0X2lzX3J4X2VuYWJsZWQocykpIHsNCj4+ICAgICAg
ICAgICBxZW11X2Nocl9mZV9hY2NlcHRfaW5wdXQoJnMtPmNocik7DQo+PiAgICAgICB9DQo+
PiAgIH0NCj4+IEBAIC0yMTgsMjEgKzIzMywzNyBAQCBzdGF0aWMgdm9pZCBvdF91YXJ0X3ht
aXQoT3RVQVJUU3RhdGUgKnMpDQo+PiAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgfQ0K
Pj4NCj4+IC0gICAgLyogaW5zdGFudCBkcmFpbiB0aGUgZmlmbyB3aGVuIHRoZXJlJ3Mgbm8g
YmFjay1lbmQgKi8NCj4+IC0gICAgaWYgKCFxZW11X2Nocl9mZV9iYWNrZW5kX2Nvbm5lY3Rl
ZCgmcy0+Y2hyKSkgew0KPj4gLSAgICAgICAgb3RfdWFydF9yZXNldF90eF9maWZvKHMpOw0K
Pj4gLSAgICAgICAgb3RfdWFydF91cGRhdGVfaXJxcyhzKTsNCj4+IC0gICAgICAgIHJldHVy
bjsNCj4+IC0gICAgfQ0KPj4gKyAgICBpZiAob3RfdWFydF9pc19zeXNfbG9vcGFja19lbmFi
bGVkKHMpKSB7DQo+PiArICAgICAgICAvKiBzeXN0ZW0gbG9vcGJhY2sgbW9kZSwganVzdCBm
b3J3YXJkIHRvIFJYIEZJRk8gKi8NCj4+ICsgICAgICAgIHVpbnQzMl90IGNvdW50ID0gZmlm
bzhfbnVtX3VzZWQoJnMtPnR4X2ZpZm8pOw0KPj4gKyAgICAgICAgYnVmID0gZmlmbzhfcG9w
X2J1ZnB0cigmcy0+dHhfZmlmbywgY291bnQsICZzaXplKTsNCj4+ICsgICAgICAgIG90X3Vh
cnRfcmVjZWl2ZShzLCBidWYsIChpbnQpc2l6ZSk7DQo+PiArICAgICAgICBjb3VudCAtPSBz
aXplOw0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIHRoZXJlIG1heSBiZSBtb3Jl
IGRhdGEgdG8gc2VuZCBpZiBkYXRhIHdyYXBzIGFyb3VuZCB0aGUgZW5kIG9mIFRYDQo+PiAr
ICAgICAgICAgKiBGSUZPDQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAgIGlmIChjb3Vu
dCkgew0KPj4gKyAgICAgICAgICAgIGJ1ZiA9IGZpZm84X3BvcF9idWZwdHIoJnMtPnR4X2Zp
Zm8sIGNvdW50LCAmc2l6ZSk7DQo+PiArICAgICAgICAgICAgb3RfdWFydF9yZWNlaXZlKHMs
IGJ1ZiwgKGludClzaXplKTsNCj4+ICsgICAgICAgIH0NCj4gTWF5YmUgYSByZXR1cm4gaGVy
ZSBzbyB0aGUgcmVzdCBvZiB0aGUgZnVuY3Rpb24gZG9lc24ndCBoYXZlIHRvIGJlIGluIGFu
IGVsc2UNCj4NCj4gQWxpc3RhaXINCg0KQWgsIEkgc2VlIGl0J3Mgbm90IHNvIG9idmlvdXMg
ZnJvbSB0aGUgcGF0Y2ggaW4gdGhlIGVtYWlsLCBidXQgdGhlcmUgaXMgDQpzdGlsbCBzb21l
IGxvZ2ljIGFmdGVyIHRoaXMgaWYtZWxzZSwganVzdCBhZnRlciB0aGUgbGluZSAiLyogdXBk
YXRlIA0KSU5UUl9TVEFURSAqLyIuIFRoaXMgbmVlZHMgdG8gcnVuIGluIGJvdGggY2FzZXMs
IHNvIEkgY2FuJ3QgdXNlIGEgcmV0dXJuIA0KaGVyZS4NCg0KTGV4Lg0KDQo+DQo+PiArICAg
IH0gZWxzZSB7DQo+PiArICAgICAgICAvKiBpbnN0YW50IGRyYWluIHRoZSBmaWZvIHdoZW4g
dGhlcmUncyBubyBiYWNrLWVuZCAqLw0KPj4gKyAgICAgICAgaWYgKCFxZW11X2Nocl9mZV9i
YWNrZW5kX2Nvbm5lY3RlZCgmcy0+Y2hyKSkgew0KPj4gKyAgICAgICAgICAgIG90X3VhcnRf
cmVzZXRfdHhfZmlmbyhzKTsNCj4+ICsgICAgICAgICAgICBvdF91YXJ0X3VwZGF0ZV9pcnFz
KHMpOw0KPj4gKyAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgIH0NCj4+DQo+PiAt
ICAgIC8qIGdldCBhIGNvbnRpbnVvdXMgYnVmZmVyIGZyb20gdGhlIEZJRk8gKi8NCj4+IC0g
ICAgYnVmID0NCj4+IC0gICAgICAgIGZpZm84X3BlZWtfYnVmcHRyKCZzLT50eF9maWZvLCBm
aWZvOF9udW1fdXNlZCgmcy0+dHhfZmlmbyksICZzaXplKTsNCj4+IC0gICAgLyogc2VuZCBh
cyBtdWNoIGFzIHBvc3NpYmxlICovDQo+PiAtICAgIHJldCA9IHFlbXVfY2hyX2ZlX3dyaXRl
KCZzLT5jaHIsIGJ1ZiwgKGludClzaXplKTsNCj4+IC0gICAgLyogaWYgc29tZSBjaGFyYWN0
ZXJzIHdoZXJlIHNlbnQsIHJlbW92ZSB0aGVtIGZyb20gdGhlIEZJRk8gKi8NCj4+IC0gICAg
aWYgKHJldCA+PSAwKSB7DQo+PiAtICAgICAgICBmaWZvOF9kcm9wKCZzLT50eF9maWZvLCBy
ZXQpOw0KPj4gKyAgICAgICAgLyogZ2V0IGEgY29udGludW91cyBidWZmZXIgZnJvbSB0aGUg
RklGTyAqLw0KPj4gKyAgICAgICAgYnVmID0NCj4+ICsgICAgICAgICAgICBmaWZvOF9wZWVr
X2J1ZnB0cigmcy0+dHhfZmlmbywgZmlmbzhfbnVtX3VzZWQoJnMtPnR4X2ZpZm8pLCAmc2l6
ZSk7DQo+PiArICAgICAgICAvKiBzZW5kIGFzIG11Y2ggYXMgcG9zc2libGUgKi8NCj4+ICsg
ICAgICAgIHJldCA9IHFlbXVfY2hyX2ZlX3dyaXRlKCZzLT5jaHIsIGJ1ZiwgKGludClzaXpl
KTsNCj4+ICsgICAgICAgIC8qIGlmIHNvbWUgY2hhcmFjdGVycyB3aGVyZSBzZW50LCByZW1v
dmUgdGhlbSBmcm9tIHRoZSBGSUZPICovDQo+PiArICAgICAgICBpZiAocmV0ID49IDApIHsN
Cj4+ICsgICAgICAgICAgICBmaWZvOF9kcm9wKCZzLT50eF9maWZvLCByZXQpOw0KPj4gKyAg
ICAgICAgfQ0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIC8qIHVwZGF0ZSBJTlRSX1NUQVRF
ICovDQo+PiBAQCAtMjY5LDcgKzMwMCw3IEBAIHN0YXRpYyB2b2lkIHVhcnRfd3JpdGVfdHhf
ZmlmbyhPdFVBUlRTdGF0ZSAqcywgdWludDhfdCB2YWwpDQo+PiAgICAgICAgICAgcy0+dHhf
d2F0ZXJtYXJrX2xldmVsID0gMDsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIGlmIChGSUVM
RF9FWDMyKHMtPnJlZ3NbUl9DVFJMXSwgQ1RSTCwgVFgpKSB7DQo+PiArICAgIGlmIChvdF91
YXJ0X2lzX3R4X2VuYWJsZWQocykpIHsNCj4+ICAgICAgICAgICBvdF91YXJ0X3htaXQocyk7
DQo+PiAgICAgICB9DQo+Pg0KPj4gQEAgLTI4OCw4ICszMTksNiBAQCBzdGF0aWMgdm9pZCBv
dF91YXJ0X3Jlc2V0X2VudGVyKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkNCj4+DQo+
PiAgICAgICBtZW1zZXQoJnMtPnJlZ3NbMF0sIDAsIHNpemVvZihzLT5yZWdzKSk7DQo+Pg0K
Pj4gLSAgICBzLT5yZWdzW1JfU1RBVFVTXSA9IDB4MDAwMDAwM2M7DQo+PiAtDQo+PiAgICAg
ICBzLT50eF93YXRlcm1hcmtfbGV2ZWwgPSAwOw0KPj4gICAgICAgZm9yICh1bnNpZ25lZCBp
bmRleCA9IDA7IGluZGV4IDwgQVJSQVlfU0laRShzLT5pcnFzKTsgaW5kZXgrKykgew0KPj4g
ICAgICAgICAgIHFlbXVfc2V0X2lycShzLT5pcnFzW2luZGV4XSwgMCk7DQo+PiBAQCAtMzA1
LDYgKzMzNCwyNyBAQCBzdGF0aWMgdm9pZCBvdF91YXJ0X3Jlc2V0X2VudGVyKE9iamVjdCAq
b2JqLCBSZXNldFR5cGUgdHlwZSkNCj4+ICAgICAgIG90X3VhcnRfdXBkYXRlX2lycXMocyk7
DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIHVpbnQ4X3Qgb3RfdWFydF9yZWFkX3J4X2ZpZm8o
T3RVQVJUU3RhdGUgKnMpDQo+PiArew0KPj4gKyAgICB1aW50OF90IHZhbDsNCj4+ICsNCj4+
ICsgICAgaWYgKCEocy0+cmVnc1tSX0NUUkxdICYgUl9DVFJMX1JYX01BU0spKSB7DQo+PiAr
ICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoZmlmbzhf
aXNfZW1wdHkoJnMtPnJ4X2ZpZm8pKSB7DQo+PiArICAgICAgICByZXR1cm4gMDsNCj4+ICsg
ICAgfQ0KPj4gKw0KPj4gKyAgICB2YWwgPSBmaWZvOF9wb3AoJnMtPnJ4X2ZpZm8pOw0KPj4g
Kw0KPj4gKyAgICBpZiAob3RfdWFydF9pc19yeF9lbmFibGVkKHMpICYmICFvdF91YXJ0X2lz
X3N5c19sb29wYWNrX2VuYWJsZWQocykpIHsNCj4+ICsgICAgICAgIHFlbXVfY2hyX2ZlX2Fj
Y2VwdF9pbnB1dCgmcy0+Y2hyKTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4g
dmFsOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIHVpbnQ2NF90IG90X3VhcnRfZ2V0X2Jh
dWQoT3RVQVJUU3RhdGUgKnMpDQo+PiAgIHsNCj4+ICAgICAgIHVpbnQ2NF90IGJhdWQ7DQo+
PiBAQCAtMzI3LDMyICszNzcsNTAgQEAgc3RhdGljIHVpbnQ2NF90IG90X3VhcnRfcmVhZCh2
b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4+ICAgICAg
IGNhc2UgUl9JTlRSX0VOQUJMRToNCj4+ICAgICAgIGNhc2UgUl9DVFJMOg0KPj4gICAgICAg
Y2FzZSBSX0ZJRk9fQ1RSTDoNCj4+IC0gICAgY2FzZSBSX1NUQVRVUzoNCj4+ICAgICAgICAg
ICByZXR2YWx1ZSA9IHMtPnJlZ3NbcmVnXTsNCj4+ICAgICAgICAgICBicmVhazsNCj4+ICsg
ICAgY2FzZSBSX1NUQVRVUzoNCj4+ICsgICAgICAgIC8qIGFzc3VtZSB0aGF0IFVBUlQgYWx3
YXlzIHJlcG9ydCBSWElETEUgKi8NCj4+ICsgICAgICAgIHJldHZhbHVlID0gUl9TVEFUVVNf
UlhJRExFX01BU0s7DQo+PiArICAgICAgICAvKiByZXBvcnQgUlhFTVBUWSBvciBSWEZVTEwg
Ki8NCj4+ICsgICAgICAgIHN3aXRjaCAoZmlmbzhfbnVtX3VzZWQoJnMtPnJ4X2ZpZm8pKSB7
DQo+PiArICAgICAgICBjYXNlIDA6DQo+PiArICAgICAgICAgICAgcmV0dmFsdWUgfD0gUl9T
VEFUVVNfUlhFTVBUWV9NQVNLOw0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAg
ICAgY2FzZSBPVF9VQVJUX1JYX0ZJRk9fU0laRToNCj4+ICsgICAgICAgICAgICByZXR2YWx1
ZSB8PSBSX1NUQVRVU19SWEZVTExfTUFTSzsNCj4+ICsgICAgICAgICAgICBicmVhazsNCj4+
ICsgICAgICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAg
ICB9DQo+PiArICAgICAgICAvKiByZXBvcnQgVFhFTVBUWStUWElETEUgb3IgVFhGVUxMICov
DQo+PiArICAgICAgICBzd2l0Y2ggKGZpZm84X251bV91c2VkKCZzLT50eF9maWZvKSkgew0K
Pj4gKyAgICAgICAgY2FzZSAwOg0KPj4gKyAgICAgICAgICAgIHJldHZhbHVlIHw9IFJfU1RB
VFVTX1RYRU1QVFlfTUFTSyB8IFJfU1RBVFVTX1RYSURMRV9NQVNLOw0KPj4gKyAgICAgICAg
ICAgIGJyZWFrOw0KPj4gKyAgICAgICAgY2FzZSBPVF9VQVJUX1RYX0ZJRk9fU0laRToNCj4+
ICsgICAgICAgICAgICByZXR2YWx1ZSB8PSBSX1NUQVRVU19UWEZVTExfTUFTSzsNCj4+ICsg
ICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICAg
ICAgYnJlYWs7DQo+PiArICAgICAgICB9DQo+PiArICAgICAgICBpZiAoIW90X3VhcnRfaXNf
dHhfZW5hYmxlZChzKSkgew0KPj4gKyAgICAgICAgICAgIHJldHZhbHVlIHw9IFJfU1RBVFVT
X1RYSURMRV9NQVNLOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAgICAgaWYgKCFvdF91YXJ0
X2lzX3J4X2VuYWJsZWQocykpIHsNCj4+ICsgICAgICAgICAgICByZXR2YWx1ZSB8PSBSX1NU
QVRVU19SWElETEVfTUFTSzsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgICAgIGJyZWFrOw0K
Pj4NCj4+ICAgICAgIGNhc2UgUl9SREFUQToNCj4+IC0gICAgICAgIHJldHZhbHVlID0gcy0+
cmVnc1tSX1JEQVRBXTsNCj4+IC0gICAgICAgIGlmICgocy0+cmVnc1tSX0NUUkxdICYgUl9D
VFJMX1JYX01BU0spICYmIChzLT5yeF9sZXZlbCA+IDApKSB7DQo+PiAtICAgICAgICAgICAg
cWVtdV9jaHJfZmVfYWNjZXB0X2lucHV0KCZzLT5jaHIpOw0KPj4gLQ0KPj4gLSAgICAgICAg
ICAgIHMtPnJ4X2xldmVsIC09IDE7DQo+PiAtICAgICAgICAgICAgcy0+cmVnc1tSX1NUQVRV
U10gJj0gflJfU1RBVFVTX1JYRlVMTF9NQVNLOw0KPj4gLSAgICAgICAgICAgIGlmIChzLT5y
eF9sZXZlbCA9PSAwKSB7DQo+PiAtICAgICAgICAgICAgICAgIHMtPnJlZ3NbUl9TVEFUVVNd
IHw9IFJfU1RBVFVTX1JYSURMRV9NQVNLOw0KPj4gLSAgICAgICAgICAgICAgICBzLT5yZWdz
W1JfU1RBVFVTXSB8PSBSX1NUQVRVU19SWEVNUFRZX01BU0s7DQo+PiAtICAgICAgICAgICAg
fQ0KPj4gLSAgICAgICAgfQ0KPj4gKyAgICAgICAgcmV0dmFsdWUgPSAodWludDMyX3Qpb3Rf
dWFydF9yZWFkX3J4X2ZpZm8ocyk7DQo+PiAgICAgICAgICAgYnJlYWs7DQo+Pg0KPj4gICAg
ICAgY2FzZSBSX0ZJRk9fU1RBVFVTOg0KPj4gLSAgICAgICAgcmV0dmFsdWUgPSBzLT5yZWdz
W1JfRklGT19TVEFUVVNdOw0KPj4gLQ0KPj4gLSAgICAgICAgcmV0dmFsdWUgfD0gKHMtPnJ4
X2xldmVsICYgMHgxRikgPDwgUl9GSUZPX1NUQVRVU19SWExWTF9TSElGVDsNCj4+IC0gICAg
ICAgIHJldHZhbHVlIHw9IChzLT50eF9sZXZlbCAmIDB4MUYpIDw8IFJfRklGT19TVEFUVVNf
VFhMVkxfU0hJRlQ7DQo+PiAtDQo+PiAtICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklN
UCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIiVzOiBSWCBmaWZvcyBhcmUgbm90IHN1
cHBvcnRlZFxuIiwgX19mdW5jX18pOw0KPj4gKyAgICAgICAgcmV0dmFsdWUgPQ0KPj4gKyAg
ICAgICAgICAgIChmaWZvOF9udW1fdXNlZCgmcy0+cnhfZmlmbykgJiAweGZmdSkgPDwgUl9G
SUZPX1NUQVRVU19SWExWTF9TSElGVDsNCj4+ICsgICAgICAgIHJldHZhbHVlIHw9DQo+PiAr
ICAgICAgICAgICAgKGZpZm84X251bV91c2VkKCZzLT50eF9maWZvKSAmIDB4ZmZ1KSA8PCBS
X0ZJRk9fU1RBVFVTX1RYTFZMX1NISUZUOw0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+
ICAgICAgIGNhc2UgUl9WQUw6DQo+PiBAQCAtNDE2LDEwICs0ODQsNiBAQCBzdGF0aWMgdm9p
ZCBvdF91YXJ0X3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHZh
bDY0LA0KPj4gICAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IFVBUlRfQ1RSTF9ORiBpcyBub3Qgc3Vw
cG9ydGVkXG4iLCBfX2Z1bmNfXyk7DQo+PiAgICAgICAgICAgfQ0KPj4gLSAgICAgICAgaWYg
KHZhbHVlICYgUl9DVFJMX1NMUEJLX01BU0spIHsNCj4+IC0gICAgICAgICAgICBxZW11X2xv
Z19tYXNrKExPR19VTklNUCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICIlczog
VUFSVF9DVFJMX1NMUEJLIGlzIG5vdCBzdXBwb3J0ZWRcbiIsIF9fZnVuY19fKTsNCj4+IC0g
ICAgICAgIH0NCj4+ICAgICAgICAgICBpZiAodmFsdWUgJiBSX0NUUkxfTExQQktfTUFTSykg
ew0KPj4gICAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiJXM6IFVBUlRfQ1RSTF9MTFBCSyBpcyBub3Qgc3Vw
cG9ydGVkXG4iLCBfX2Z1bmNfXyk7DQo+PiBAQCAtNDQ1LDE5ICs1MDksMTkgQEAgc3RhdGlj
IHZvaWQgb3RfdWFydF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRf
dCB2YWw2NCwNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICAgICAgYnJlYWs7DQo+PiAgICAg
ICBjYXNlIFJfV0RBVEE6DQo+PiAtICAgICAgICB1YXJ0X3dyaXRlX3R4X2ZpZm8ocywgdmFs
dWUpOw0KPj4gKyAgICAgICAgdWFydF93cml0ZV90eF9maWZvKHMsICh1aW50OF90KSh2YWx1
ZSAmIFJfV0RBVEFfV0RBVEFfTUFTSykpOw0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+
ICAgICAgIGNhc2UgUl9GSUZPX0NUUkw6DQo+PiAtICAgICAgICBzLT5yZWdzW1JfRklGT19D
VFJMXSA9IHZhbHVlOw0KPj4gLQ0KPj4gKyAgICAgICAgcy0+cmVnc1tSX0ZJRk9fQ1RSTF0g
PQ0KPj4gKyAgICAgICAgICAgIHZhbHVlICYgKFJfRklGT19DVFJMX1JYSUxWTF9NQVNLIHwg
Ul9GSUZPX0NUUkxfVFhJTFZMX01BU0spOw0KPj4gICAgICAgICAgIGlmICh2YWx1ZSAmIFJf
RklGT19DVFJMX1JYUlNUX01BU0spIHsNCj4+IC0gICAgICAgICAgICBzLT5yeF9sZXZlbCA9
IDA7DQo+PiAtICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsDQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAiJXM6IFJYIGZpZm9zIGFyZSBub3Qgc3VwcG9ydGVk
XG4iLCBfX2Z1bmNfXyk7DQo+PiArICAgICAgICAgICAgb3RfdWFydF9yZXNldF9yeF9maWZv
KHMpOw0KPj4gKyAgICAgICAgICAgIG90X3VhcnRfdXBkYXRlX2lycXMocyk7DQo+PiAgICAg
ICAgICAgfQ0KPj4gICAgICAgICAgIGlmICh2YWx1ZSAmIFJfRklGT19DVFJMX1RYUlNUX01B
U0spIHsNCj4+IC0gICAgICAgICAgICBzLT50eF9sZXZlbCA9IDA7DQo+PiArICAgICAgICAg
ICAgb3RfdWFydF9yZXNldF90eF9maWZvKHMpOw0KPj4gKyAgICAgICAgICAgIG90X3VhcnRf
dXBkYXRlX2lycXMocyk7DQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgICAgIGJyZWFrOw0K
Pj4gICAgICAgY2FzZSBSX09WUkQ6DQo+PiAtLQ0KPj4gMi40OS4xDQo+Pg0KPj4NCi0tIA0K
TGV4IEJhaWxleSAodGhleS90aGVtKQ0KbG93UklTQyBDLkkuQy4gNyBIaWxscyBSb2FkLCBD
YW1icmlkZ2UsIENCMiAxR0UsIFVLLiBSZWdpc3RlcmVkIGluIA0KRW5nbGFuZCAmIFdhbGVz
IDA5MjcyMjgzIGxleC5iYWlsZXlAbG93cmlzYy5vcmcNCg==
--------------kA1Cxm9vDhraqvzYbE1if3vD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 16/04/2026 02:38, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmai=
l.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Wed, Apr 15, 2026 at 3:23=
=E2=80=AFAM ~lexbaileylowrisc
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lexbaileylowrisc@git.sr=
=2Eht">&lt;lexbaileylowrisc@git.sr.ht&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
From: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lex.ba=
iley@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>

The STATUS register value is now generated on every read instead of being=

tracked in memory since it has such a dynamic value. the receive fifo is =
now
implemented, and the system loopback mode. (line loopback is not supporte=
d)

Signed-off-by: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:lex.bailey@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>
---
 hw/char/ot_uart.c | 160 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 112 insertions(+), 48 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 2247db7110..3511a42fbe 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -140,6 +140,21 @@ static void ot_uart_update_irqs(OtUARTState *s)
     }
 }

+static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, SLPBK);
+}
+
+static bool ot_uart_is_tx_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, TX);
+}
+
+static bool ot_uart_is_rx_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, RX);
+}
+
 static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
@@ -196,7 +211,7 @@ static void ot_uart_reset_rx_fifo(OtUARTState *s)
     fifo8_reset(&amp;s-&gt;rx_fifo);
     s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_WATERMARK_MASK;
     s-&gt;regs[R_INTR_STATE] &amp;=3D ~INTR_RX_OVERFLOW_MASK;
-    if (FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, RX)) {
+    if (ot_uart_is_rx_enabled(s)) {
         qemu_chr_fe_accept_input(&amp;s-&gt;chr);
     }
 }
@@ -218,21 +233,37 @@ static void ot_uart_xmit(OtUARTState *s)
         return;
     }

-    /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_backend_connected(&amp;s-&gt;chr)) {
-        ot_uart_reset_tx_fifo(s);
-        ot_uart_update_irqs(s);
-        return;
-    }
+    if (ot_uart_is_sys_loopack_enabled(s)) {
+        /* system loopback mode, just forward to RX FIFO */
+        uint32_t count =3D fifo8_num_used(&amp;s-&gt;tx_fifo);
+        buf =3D fifo8_pop_bufptr(&amp;s-&gt;tx_fifo, count, &amp;size);
+        ot_uart_receive(s, buf, (int)size);
+        count -=3D size;
+        /*
+         * there may be more data to send if data wraps around the end o=
f TX
+         * FIFO
+         */
+        if (count) {
+            buf =3D fifo8_pop_bufptr(&amp;s-&gt;tx_fifo, count, &amp;siz=
e);
+            ot_uart_receive(s, buf, (int)size);
+        }
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
Maybe a return here so the rest of the function doesn't have to be in an =
else

Alistair</pre>
    </blockquote>
    <p>Ah, I see it's not so obvious from the patch in the email, but
      there is still some logic after this if-else, just after the line
      "<span style=3D"white-space: pre-wrap">/* update INTR_STATE */". Th=
is needs to run in both cases, so I can't use a return here.</span></p>
    <p><span style=3D"white-space: pre-wrap">Lex.</span></p>
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKNYx6qe+4P3wQj6_QCa7K8LUrk6k_6JfdDJh+Y_-CJSFQ@mail.gmai=
l.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">+    } else {
+        /* instant drain the fifo when there's no back-end */
+        if (!qemu_chr_fe_backend_connected(&amp;s-&gt;chr)) {
+            ot_uart_reset_tx_fifo(s);
+            ot_uart_update_irqs(s);
+            return;
+        }

-    /* get a continuous buffer from the FIFO */
-    buf =3D
-        fifo8_peek_bufptr(&amp;s-&gt;tx_fifo, fifo8_num_used(&amp;s-&gt;=
tx_fifo), &amp;size);
-    /* send as much as possible */
-    ret =3D qemu_chr_fe_write(&amp;s-&gt;chr, buf, (int)size);
-    /* if some characters where sent, remove them from the FIFO */
-    if (ret &gt;=3D 0) {
-        fifo8_drop(&amp;s-&gt;tx_fifo, ret);
+        /* get a continuous buffer from the FIFO */
+        buf =3D
+            fifo8_peek_bufptr(&amp;s-&gt;tx_fifo, fifo8_num_used(&amp;s-=
&gt;tx_fifo), &amp;size);
+        /* send as much as possible */
+        ret =3D qemu_chr_fe_write(&amp;s-&gt;chr, buf, (int)size);
+        /* if some characters where sent, remove them from the FIFO */
+        if (ret &gt;=3D 0) {
+            fifo8_drop(&amp;s-&gt;tx_fifo, ret);
+        }
     }

     /* update INTR_STATE */
@@ -269,7 +300,7 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_=
t val)
         s-&gt;tx_watermark_level =3D 0;
     }

-    if (FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, TX)) {
+    if (ot_uart_is_tx_enabled(s)) {
         ot_uart_xmit(s);
     }

@@ -288,8 +319,6 @@ static void ot_uart_reset_enter(Object *obj, ResetTyp=
e type)

     memset(&amp;s-&gt;regs[0], 0, sizeof(s-&gt;regs));

-    s-&gt;regs[R_STATUS] =3D 0x0000003c;
-
     s-&gt;tx_watermark_level =3D 0;
     for (unsigned index =3D 0; index &lt; ARRAY_SIZE(s-&gt;irqs); index+=
+) {
         qemu_set_irq(s-&gt;irqs[index], 0);
@@ -305,6 +334,27 @@ static void ot_uart_reset_enter(Object *obj, ResetTy=
pe type)
     ot_uart_update_irqs(s);
 }

+static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
+{
+    uint8_t val;
+
+    if (!(s-&gt;regs[R_CTRL] &amp; R_CTRL_RX_MASK)) {
+        return 0;
+    }
+
+    if (fifo8_is_empty(&amp;s-&gt;rx_fifo)) {
+        return 0;
+    }
+
+    val =3D fifo8_pop(&amp;s-&gt;rx_fifo);
+
+    if (ot_uart_is_rx_enabled(s) &amp;&amp; !ot_uart_is_sys_loopack_enab=
led(s)) {
+        qemu_chr_fe_accept_input(&amp;s-&gt;chr);
+    }
+
+    return val;
+}
+
 static uint64_t ot_uart_get_baud(OtUARTState *s)
 {
     uint64_t baud;
@@ -327,32 +377,50 @@ static uint64_t ot_uart_read(void *opaque, hwaddr a=
ddr, unsigned int size)
     case R_INTR_ENABLE:
     case R_CTRL:
     case R_FIFO_CTRL:
-    case R_STATUS:
         retvalue =3D s-&gt;regs[reg];
         break;
+    case R_STATUS:
+        /* assume that UART always report RXIDLE */
+        retvalue =3D R_STATUS_RXIDLE_MASK;
+        /* report RXEMPTY or RXFULL */
+        switch (fifo8_num_used(&amp;s-&gt;rx_fifo)) {
+        case 0:
+            retvalue |=3D R_STATUS_RXEMPTY_MASK;
+            break;
+        case OT_UART_RX_FIFO_SIZE:
+            retvalue |=3D R_STATUS_RXFULL_MASK;
+            break;
+        default:
+            break;
+        }
+        /* report TXEMPTY+TXIDLE or TXFULL */
+        switch (fifo8_num_used(&amp;s-&gt;tx_fifo)) {
+        case 0:
+            retvalue |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
+            break;
+        case OT_UART_TX_FIFO_SIZE:
+            retvalue |=3D R_STATUS_TXFULL_MASK;
+            break;
+        default:
+            break;
+        }
+        if (!ot_uart_is_tx_enabled(s)) {
+            retvalue |=3D R_STATUS_TXIDLE_MASK;
+        }
+        if (!ot_uart_is_rx_enabled(s)) {
+            retvalue |=3D R_STATUS_RXIDLE_MASK;
+        }
+        break;

     case R_RDATA:
-        retvalue =3D s-&gt;regs[R_RDATA];
-        if ((s-&gt;regs[R_CTRL] &amp; R_CTRL_RX_MASK) &amp;&amp; (s-&gt;=
rx_level &gt; 0)) {
-            qemu_chr_fe_accept_input(&amp;s-&gt;chr);
-
-            s-&gt;rx_level -=3D 1;
-            s-&gt;regs[R_STATUS] &amp;=3D ~R_STATUS_RXFULL_MASK;
-            if (s-&gt;rx_level =3D=3D 0) {
-                s-&gt;regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
-                s-&gt;regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
-            }
-        }
+        retvalue =3D (uint32_t)ot_uart_read_rx_fifo(s);
         break;

     case R_FIFO_STATUS:
-        retvalue =3D s-&gt;regs[R_FIFO_STATUS];
-
-        retvalue |=3D (s-&gt;rx_level &amp; 0x1F) &lt;&lt; R_FIFO_STATUS=
_RXLVL_SHIFT;
-        retvalue |=3D (s-&gt;tx_level &amp; 0x1F) &lt;&lt; R_FIFO_STATUS=
_TXLVL_SHIFT;
-
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: RX fifos are not supported\n", __func__);
+        retvalue =3D
+            (fifo8_num_used(&amp;s-&gt;rx_fifo) &amp; 0xffu) &lt;&lt; R_=
FIFO_STATUS_RXLVL_SHIFT;
+        retvalue |=3D
+            (fifo8_num_used(&amp;s-&gt;tx_fifo) &amp; 0xffu) &lt;&lt; R_=
FIFO_STATUS_TXLVL_SHIFT;
         break;

     case R_VAL:
@@ -416,10 +484,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_NF is not supported\n", __func_=
_);
         }
-        if (value &amp; R_CTRL_SLPBK_MASK) {
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: UART_CTRL_SLPBK is not supported\n", __fu=
nc__);
-        }
         if (value &amp; R_CTRL_LLPBK_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_LLPBK is not supported\n", __fu=
nc__);
@@ -445,19 +509,19 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
         }
         break;
     case R_WDATA:
-        uart_write_tx_fifo(s, value);
+        uart_write_tx_fifo(s, (uint8_t)(value &amp; R_WDATA_WDATA_MASK))=
;
         break;

     case R_FIFO_CTRL:
-        s-&gt;regs[R_FIFO_CTRL] =3D value;
-
+        s-&gt;regs[R_FIFO_CTRL] =3D
+            value &amp; (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MA=
SK);
         if (value &amp; R_FIFO_CTRL_RXRST_MASK) {
-            s-&gt;rx_level =3D 0;
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: RX fifos are not supported\n", __func__);=

+            ot_uart_reset_rx_fifo(s);
+            ot_uart_update_irqs(s);
         }
         if (value &amp; R_FIFO_CTRL_TXRST_MASK) {
-            s-&gt;tx_level =3D 0;
+            ot_uart_reset_tx_fifo(s);
+            ot_uart_update_irqs(s);
         }
         break;
     case R_OVRD:
--
2.49.1


</pre>
      </blockquote>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      Lex Bailey (they/them)<br>
      <span style=3D"font-size:0.5em;color:#777777;">lowRISC C.I.C. 7
        Hills Road, Cambridge, CB2 1GE, UK. Registered in England &amp;
        Wales 09272283
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lex.bailey@l=
owrisc.org">lex.bailey@lowrisc.org</a></span></div>
  </body>
</html>

--------------kA1Cxm9vDhraqvzYbE1if3vD--

--------------vsqqwQDvmZMertj3Y9rVksBt
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDNBGlk2ScBDAC1hE3kA783wihbPYaF+9u8OHqzVVq75fboAha+9EUZ7cx55XJb
OTkmUR1emuyerVG0RdCXa95J2isEfq4Rl+j7pvAR2MhRp8uDZlOInV0+1uW4xa/I
nfiZ/r5rM4WUtySt1ok/0Ix9BV7rUP1jzLkSe3u1kDlFdZnkt4iIjWpQbzsNy7/K
G604ZXs6BsrOkDU20YB4TCeCg0JOHSQdzg155LH/fJWzyNQHmJnSZk8Slp/7OJLC
FZfDJT5XtxAAhYxwkkNAxDMNM+P2waFujhinWwejkAl8wo6yoGxz4lANM0StvUJ0
8+V/w5YfLjDGBTzclN9UTr+nuOhJ8uMOeM4mQARop+vMdKve90jeqrLr078pwmtr
IquzG9XFbpBrDqa4M+wiZtdwyEWTkcV5Sxef3Crm49V4a2Qn7gaCXCb8XU7g1UOa
eXDvFxA2tB/6Vv3ox0lquWVh3Wg8HWWbuk1u/vaihC+c8eR7Ok4mUQP4dM5G3M4C
J9+aL0nUbgX79NUAEQEAAc0jTGV4IEJhaWxleSA8bGV4LmJhaWxleUBsb3dyaXNj
Lm9yZz7CwQcEEwEIADEWIQSrqBHVGPsUIhGgMJV8uyDUC1VYLAUCaWTZJwIbAwQL
CQgHBRUICQoLBRYCAwEAAAoJEHy7INQLVVgs1RsL+wSZyKki5agYN3lBkozL29EG
AI0NKzkJgA2xn8PnC9XNvy3sNzJ8Z84f7k33cY4maR17oa+SQ9+lkK0+L2BNm2hG
7nqaQJ0EmOePzwldxhUBGYbVQiUnb316RTUM/iCooFTrcNKhBKFSVdgWTkeQAPK/
rg8AZH2PqSEH+8pcRE/0mW0u3TjO2wutp3WLYIJ4JqU529uw4lTCQ4l+hpcXLI2Y
JtDiVCYIwEZ3ExtUJD3RC5yccHAj5s+wY8TtPwVnfvKBzgbmeB5l05zHQQpf17bj
Cus/0zbmeN3EpZMpnETUlbCMLzx8U5ySlAQIQxubQeiRqOvtJLUsuWA3pm0IiVS9
PLZiaVNqhDYuxXM6jwFX1nRGqOktfd8IlPvEBaMfNf/Vi9mqQU26Y7aNXkF49Nxe
j0dhsuQhBCRXBAlSt0/N7xu7CFfFj+R+5izKGYnIsgI1dyubwASgcEVzOUfRbMls
Z+pT8kktdnUaM382sNiM4lNIHBDsjP5hecu961xepM7AzQRpZNkoAQwAv1unf9+A
eYoPGctWdDBhFdEDFNGga4NhrS+a4L86GFj4AyQjfS1CmP0Nvo6iyB+FAXQCpDEZ
L/EM81OtBBXDvhfw1nx+2KkGcRD9+APEOZqvgE44qgITwpA2ZbRhoAq2USmmYhsS
qb1X/rQr8MHtp3FxKJESFIpObo6oFkRttmM/UE07foX6pugT5blkIfDzM3Biiv/5
umBOtFB6xaNxYBI6PQ8gJOs6JBFE8NlUmSQstrVfm+QnUtMjnfQnUVoPqINCDk/H
UR2Y86c050PXDEwNnxEhdhE3i3Np08Her900BhpRPys3b6rnPXw8BsoIiLbTFABO
NC9mpEhOK7ELVYro4qYZYCue+GSbv7gjhchYyJXS9BlEjFYGkLbWCAunRo1ztywq
vNtENDlv8woJHRQd5Pw2FFoBRF8Y48IV7rpSCi7GkQ1NuhvayQ/P42lddqKhPaca
aOsHjBazjFqWeSGwVTDsKMwwVfqNbur0WKUpjtO9HTdBPWF0leP6uMK/ABEBAAHC
wPYEGAEIACAWIQSrqBHVGPsUIhGgMJV8uyDUC1VYLAUCaWTZKAIbDAAKCRB8uyDU
C1VYLJHiC/9VswW/tu9vnMP+3p1w3Kd3nCaSj6/KCfQU+sskLT+kafH/hSISBhvC
hns6jUO6cLGTikqrqdqkvsdDKnUVyym9DtE+uh7gmHgQus+3ePRFyr85Oaurvb3A
+FIsF9tKW8JX/V0pUMDiwVa6mcBf94NvgtU+zi5jgl57qgA5S/bm76ws9PBUpjN7
NWTqAJajMtGHIl049hm31HTacYVaD84mP+LKxiqXGqcIy2qvjFdNOiKwupnluERe
ZfQ+ppWRZ/rW41x5Tg7UF/CkC/F8CB9sFocGWl6qWZjB6SOioFZ5E6vNgfUsMqlq
C5uefUb7+Hsi0/avR7gA47EnJLQw6MRii+0RxyvPa3jstm20967pqFlBAldKPXQB
f4to5KEBRzTiGXLQJRfPTbq4krpqyIyzRAZONxiLQbU7XW5yUdkaDRI52M/txz3O
aykHK+f7rKw0/491S2jNzrLe00hWmNeoFnGq4+QpqNO58uAPyRLOcr+m9f2ktpDv
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------vsqqwQDvmZMertj3Y9rVksBt--

--------------yJgxuBD07Jxf5KZ0EmsoWfZC--

--------------eNYGwgWYXGfMJeHbo1BrhnhB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmno7HoFAwAAAAAACgkQfLsg1AtVWCws
zQwAlusbYCO0mQyUUeuE7Y5g+Kv9dwdgm0Q/U4Mn4jvEaQ+eg7noP1ksiJyQ8Wcv800yiC2sWyf9
qKTjVn5ZqYh99iOjsaRSXKojwLcrII7eh1ulbsyDFFhfPskZ3RHqDCJSqbtKsHv1IMBrEY150GnY
oXHeCawHOlsSEwHvS6yno9WruV1f+B1281+HSOPxsvbfX0ExXIRwB7UicSCL0xErl6xr/X++XPlm
AIL90jfGjk9puds7jrP8ermtniRYHgnwSUTkSTolHPOpb2cFpyC9+8Ag6SHX6Y/UVJZQR4OGHCDh
2jKg1Efr7M4xCsG9iZFcT09ZXVvUrwZEL3Tk4dlCyu8eWbz9UKfprV/IHkggregayoQtPu/OUBnW
6rE1S589FzjXYT2T+8oyLPYlmp8Rcqk7M1R0Kcfr5yt5ZvOdnp13UUjQ8NqSLHJmXqSUA/b+vEI2
DaNmrNGYd9D/bqgguJ4F112s4p7lbjL6RiPt0P0ywqyozLDn8AG/7Oyu6DBr
=P6v0
-----END PGP SIGNATURE-----

--------------eNYGwgWYXGfMJeHbo1BrhnhB--


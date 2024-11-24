Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41770E66893
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 00:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF0eV-0004vy-D5; Sat, 23 Nov 2024 19:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tF0eS-0004va-SC
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 19:39:01 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tF0eQ-00075y-BY
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 19:39:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3823cae4be1so2103025f8f.3
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732408736; x=1733013536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wHrRhFo2GoX28NZrh/RpbpVsuxGFGjmDZ5zhQRUuhI=;
 b=duoBUeeAOAuXaMk0r3RwsRxTwVoxZqQWcLyaWeULnViYjTwIjyLzHKJeKAj+xYneLj
 MQlFmQVs2P/WtWHoqT1Sdq2YWm8+kRVoPm5GJF9Z6hHU5JePcp04+S0i8YsHXFQMMD6F
 paSLUyQWoW8TMXXgsBEOLODKy7rxFuOpHIoGsHqb2WZlVicX7dDMDZ31gKpzLIsow+lj
 VxKKBW8/0LbAjIkP6TbikE8/YiW4lKnFlr4dkAMhfaxtzRaY2dTXgZ2aK8rHQqDFF5wg
 PID6omOlqpjvizpwPoUs3TaXauufXALKQRFXIR5QFbrN0DfzcFisJfQ6Wxi8UbOP+PiL
 A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732408736; x=1733013536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wHrRhFo2GoX28NZrh/RpbpVsuxGFGjmDZ5zhQRUuhI=;
 b=a1D6GdLfULF8L/ThYC0F0XuPlBft0LVtIJWZHpCzjG0LwSqrRa+O3jHFXmG/6OMzMr
 IJV8ogkTPuDvEKGLyWcY0SQC8fm4woePjZKp0qliEOiuUgOICT3Htj1fBFFZW9Y0Nzl9
 r12y1mkVMwGgWlAIkEuqy3BZx6bn+dk0WMah0XjRbQWE66RbLdI1qd0GMBlKkFkbj3Uu
 gJ0iDSxn0OQalku2pC421y6Esx4pAm575ICrJXAakzD3yln5kPPERJOVFmdsafwwERge
 ooM9wRvPMoBtIxC/dmQ21YpCiyUtjfckb+jID6WMcjuNdtSHqAYVB6jqQJyhvX+qDeJK
 1i/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1i7Xo2PZ/fj+cB8Z3I0/8rIwHRU4mYI4UnSXg9+oCx5zoG0gOKNHsjAyarCeHUnMbjCEfi5pJmzC1@nongnu.org
X-Gm-Message-State: AOJu0YwECmCHORgEB33ezRKfzuJXdTu4hnt5DCcxLjjKl5Twk2Qgi4HB
 ub/TgKFC7qyQ0hPgAERQ82IawObFG1prQlOPi6XObAroWNlYhOJdpVy6mE/3MkU=
X-Gm-Gg: ASbGncupmDlCkk/7tFMXJXs6mAVjSVIbKkPuAWLJHRDrwcho8FuLYRyFAejMm9Tm1iu
 oU2hIahgZWdnjflva4Y6lXUTnoiP6rh/D7HuP3nMWsSCgWRnFVee7r4ypzAorgiY4KGFRJQDbeK
 4xGKjOyU1E0uC/bnrqdDEhrwo2r72L2YTt9ndacvvqI9aOcgb5kGhYdfLbZbppN7CB6TdbRrL8C
 ihsStJrijZLZ1WyNANHcyPvXnTr6UoNdc+XBVOEVxpLJKXNrvOywGINN0kHTfPKVg==
X-Google-Smtp-Source: AGHT+IEAz+uNMtjKk8KYD0o7T13suJWDT8gelvfSWUhhu+AhvZCic/1fyW40z/lpO13sR9X8Xma0rw==
X-Received: by 2002:a05:6000:4904:b0:382:4eef:28a with SMTP id
 ffacd0b85a97d-38260bce857mr6876234f8f.43.1732408736385; 
 Sat, 23 Nov 2024 16:38:56 -0800 (PST)
Received: from [10.150.212.240] ([95.173.222.38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb537d4sm6436345f8f.61.2024.11.23.16.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 16:38:55 -0800 (PST)
Message-ID: <77cb7691-b936-46b9-81e4-d3541cb81756@linaro.org>
Date: Sat, 23 Nov 2024 16:38:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU patches for native windows support through clang-cl
Content-Language: en-US
To: Erwin Jansen <jansene@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, sw@weilnetz.de,
 lvivier@redhat.com, Patrick Leis <venture@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Danny Rosen
 <dannyrosen@google.com>, JP Cottin <jpcottin@google.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
 <Zz99VtNtZCx-P5Mx@redhat.com>
 <CABgObfY8fmSjQBU34NVhn-de5iWeWTBJr18u_GgFZpJXjL3NzQ@mail.gmail.com>
 <CAP52u7ZdRxATBfopYB90fgWheuqnxJ1R6p-WK0CX0Nrk7Z4jeQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAP52u7ZdRxATBfopYB90fgWheuqnxJ1R6p-WK0CX0Nrk7Z4jeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x431.google.com
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

SGksDQoNCk9uIDExLzIxLzI0IDEzOjQyLCBFcndpbiBKYW5zZW4gd3JvdGU6DQo+IFdvdWxk
IGEgZ29vZCBuZXh0IHN0ZXAgYmUgdG8gd29yayBvdXQgc29tZSBtb3JlIGRldGFpbHMgaW4g
YSBkb2N1bWVudCANCj4gdGhhdCBvdXRsaW5lcyB3aGF0IHByb2Nlc3Mgd2UgYXJlIHVzaW5n
LCB3aGF0IHdlIGFyZSBwbGFubmluZyB0byBkbyBhbmQgDQo+IGluY2x1ZGUgYSBzZXQgb2Yg
c3VnZ2VzdGlvbnMgYXMgYSBzdGFydGluZyBwb2ludCB0byBzZWUgaWYgd2UgY2FuIA0KPiB1
cHN0cmVhbSBzb21lIG9mIHRoZSBjaGFuZ2VzIHRvIHRoZSBsYXJnZXIgY29tbXVuaXR5Pw0K
PiANCj4gV2UgY3VycmVudGx5IGRvbid0IGhhdmUgYSBwcm9wZXIgc29sdXRpb24gZm9yIHBh
Y2tpbmcuIFdlIGFyZSB0cmFja2luZyANCj4gdGhlIGlzc3VlIGhlcmUgaHR0cHM6Ly9pc3N1
ZXRyYWNrZXIuZ29vZ2xlLmNvbS9pc3N1ZXMvMzgwMjk1ODQ1IA0KPiA8aHR0cHM6Ly9pc3N1
ZXRyYWNrZXIuZ29vZ2xlLmNvbS9pc3N1ZXMvMzgwMjk1ODQ1Pi4gQWxsIG91ciBjb2RlIGlz
IA0KPiBwdWJsaWMgYW5kIGRldmVsb3BtZW50IGlzIGhhcHBlbmluZyBvbiB0aGUgZW11LWRl
diByZXBvc2l0b3J5OiBodHRwczovLyANCj4gYW5kcm9pZC5nb29nbGVzb3VyY2UuY29tL3Bs
YXRmb3JtL2V4dGVybmFsL3FlbXUvKy9lbXUtZGV2IDxodHRwczovLyANCj4gYW5kcm9pZC5n
b29nbGVzb3VyY2UuY29tL3BsYXRmb3JtL2V4dGVybmFsL3FlbXUvKy9lbXUtZGV2Pg0KPiAN
Cg0KUmVnYXJkaW5nIHRoZSBnY2Nfc3RydWN0L2NsYW5nIGlzc3VlLCBJJ3ZlIGJlZW4gY2hl
Y2tpbmcgYXQgdGhlIGZ1bGwgDQppbXBhY3QgdG8gdXNlIC1tbm8tbXMtYml0ZmllbGRzIGFz
IGEgcmVwbGFjZW1lbnQgWzFdLiBBbmQgZnJvbSB0aGUgDQpkaWZmZXJlbmNlIG9ic2VydmVk
LCBpdCBzZWVtcyB0byBiZSBhIGJldHRlciBkZWZhdWx0IGNob2ljZSB0aGFuIHVzaW5nIA0K
c2VsZWN0aXZlbHkgZ2NjX3N0cnVjdCBmb3IgcGFja2VkIHN0cnVjdHMuDQoNCkZlZWRiYWNr
IGlzIHdlbGNvbWUgWzFdLCBhbmQgZW5hYmxpbmcgdGhpcyB3b3VsZCBhbGxvdyB0byBzdXBw
b3J0IA0KY2xhbmcvY2xhbmctY2wsIGFuZCB3aW5kb3dzLWFybTY0ICh3aGVyZSBnY2MgaXMg
bm90IHN1cHBvcnRlZCB5ZXQpIGFzIGEgDQpzaWRlIGVmZmVjdC4NCg0KUmVnYXJkcywNClBp
ZXJyaWNrDQoNClsxXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvNjZj
MzQ2ZGUtN2UyMC00ODMxLWIzZWItMWNkYTgzMjQwYWY5QGxpbmFyby5vcmcvVC8jdQ0KDQo+
IEdyZWV0aW5ncywNCj4gRXJ3aW4uDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gT24gVGh1LCBO
b3YgMjEsIDIwMjQgYXQgMTA6NDfigK9BTSBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tIA0KPiA8bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20+PiB3cm90ZToNCj4gDQo+
ICAgICAgPiBOQiBBcyBhIGdlbmVyYWwgcG9pbnQsIHdlIGFjdGl2ZWx5IGJsb2NrIHVzZSBv
ZiBjbGFuZyB3aXRoIFdpbmRvd3MNCj4gICAgICA+IGJ1aWxkcyAobW9yZSBzdHJpY3RseSBp
biA5LjIgbm93KSwgYmVjYXVzZSBpdCBsYWNrcyBzdXBwb3J0IGZvciB0aGUNCj4gICAgICA+
ICdnY2Nfc3RydWN0JyBhbm5vdGF0aW9uIHRoYXQgd2UgcmVseSBvbiB0byBndWFyYW50ZWUg
Y29ycmVjdCBBQkkgZm9yDQo+ICAgICAgPiBzdHJ1Y3RzIGV4cG9zZWQgdG8gZ3Vlc3RzIGlu
IHBhcnRpY3VsYXIuDQo+IA0KPiAgICAgQWgsIGdvb2QgcG9pbnQuIFRoaXMgaXMNCj4gICAg
IGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9pc3N1ZXMvMjQ3NTcgPGh0
dHBzOi8vDQo+ICAgICBnaXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L2lzc3Vlcy8yNDc1
Nz4gZm9yIHRoZSBnZW5lcmFsDQo+ICAgICB0cmFja2luZyBpc3N1ZSwgYW5kIGh0dHBzOi8v
Z2l0aHViLmNvbS9sbHZtL2xsdm0tcHJvamVjdC9wdWxsLzcxMTQ4DQo+ICAgICA8aHR0cHM6
Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L3B1bGwvNzExNDg+DQo+ICAgICBmb3Ig
YSByZWNlbnQgUFIgdGhhdCBhdHRlbXB0cyB0byBpbXBsZW1lbnQgdGhpcy4NCj4gDQo+ICAg
ICBVc2luZyAtbW5vLW1zLWJpdGZpZWxkcyBnbG9iYWxseSBpcyB1bnNhZmUgYmVjYXVzZSB0
aGVyZSBhcmUgcHJvYmFibHkNCj4gICAgIFdpbmRvd3MgQVBJIHN0cnVjdHMgdGhhdCBpbXBs
ZW1lbnQgaXQuDQo+IA0KPiAgICAgT25lIHNvbHV0aW9uIGlzIHRvIGFkZCBgUUVNVV9CVUlM
RF9CVUdfT04oc2l6ZW9mKC4uLikgPT0gLi4uKWAgdG8gYWxsDQo+ICAgICBzdHJ1Y3RzIGlu
IFFFTVUgdGhhdCB1c2UgYml0ZmllbGRzLiBUaGF0IHdpbGwgcHJvdmUgdmVyeSBxdWlja2x5
IGlmDQo+ICAgICB0aGVyZSBhcmUgaXNzdWVzIG9yIG5vdC4NCj4gDQo+ICAgICBQYW9sbw0K
PiANCj4gICAgICA+IE1hbnkgcGVvcGxlIHRyeSB0byBzaW1wbHkgcmVtb3ZlIHRoYXQgI2lm
ZGVmLCBtaXN0YWtlbmx5IGFzc3VtaW5nDQo+ICAgICB0aGF0DQo+ICAgICAgPiBiZWNhdXNl
IHRoZSBjb2RlIGNvbXBpbGVzIHdpdGhvdXQgd2FybmluZ3MsIGl0IG11c3QgYmUgY29ycmVj
dC4gRGlkDQo+ICAgICAgPiB5b3UgaGF2ZSBzb2x1dGlvbiBmb3IgdGhpcywgYXMgaXQgd291
bGQgYmUgYSBibG9ja2VyIGZvciBlbmFibGluZw0KPiAgICAgID4gY2xhbmcgb24gV2luZG93
cyBjdXJyZW50bHkgPw0KPiAgICAgID4NCj4gICAgICA+IFdpdGggcmVnYXJkcywNCj4gICAg
ICA+IERhbmllbA0KPiAgICAgID4gLS0NCj4gICAgICA+IHw6IGh0dHBzOi8vYmVycmFuZ2Uu
Y29tIDxodHRwczovL2JlcnJhbmdlLmNvbT7CoCDCoCDCoCAtby0gaHR0cHM6Ly8NCj4gICAg
IHd3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgPGh0dHBzOi8vd3d3LmZsaWNrci5j
b20vcGhvdG9zLw0KPiAgICAgZGJlcnJhbmdlPiA6fA0KPiAgICAgID4gfDogaHR0cHM6Ly9s
aWJ2aXJ0Lm9yZyA8aHR0cHM6Ly9saWJ2aXJ0Lm9yZz7CoCDCoCDCoCDCoCDCoC1vLSBodHRw
czovLw0KPiAgICAgZnN0b3AxMzguYmVycmFuZ2UuY29tIDxodHRwczovL2ZzdG9wMTM4LmJl
cnJhbmdlLmNvbT4gOnwNCj4gICAgICA+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3Jn
IDxodHRwczovL2VudGFuZ2xlLXBob3RvLm9yZz7CoCDCoCAtby0NCj4gICAgIGh0dHBzOi8v
d3d3Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDxodHRwczovL3d3dy5pbnN0YWdyYW0uY29t
Lw0KPiAgICAgZGJlcnJhbmdlPiA6fA0KPiAgICAgID4NCj4gDQoNCg==


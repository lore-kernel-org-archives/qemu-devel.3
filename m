Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81373E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzBU-00051b-W1; Wed, 18 Dec 2024 13:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzBT-000514-5A
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:54:11 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzBR-0001Sp-6P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:54:10 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-218c80a97caso307315ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734548047; x=1735152847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixIuQpaXxoXzTAhnAPS9JNQkA15zsXaCoMl3cuCCmmU=;
 b=MYZJTRNnUdRARvyPs/UgsGmq79mLQX+DKUZiH43zWdDWeTdX8bR33ik4FdlT9g4WSf
 KrG/H8dlESTmTdOvTuHanKbKSYc/pddf86dKUTm5y2pwQib8yRMH/cJ3QC6ftI3QgDzS
 ompeB5UhhOMpVAFG+JW4mblY0UjLV2jzC0YdR3TOACUoR3yowIzMdffo8gDBtqNYy5Ar
 e8ytp25sd2249DwLCw49XSDeqccBV9qxKvt4qpEBtMI7Qz/INhynylNYPUqqQawel8WE
 OlbRWrL4mjmn+q3BAXGWjI4P1sUclr4a2/2o/JoIhWqKcArI0dT9cj8P44MCozbxQI1V
 W1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734548047; x=1735152847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixIuQpaXxoXzTAhnAPS9JNQkA15zsXaCoMl3cuCCmmU=;
 b=bWxkAZhDF7iA4LeGEfoLBUP5xy6zi3adSDl34O20zK0fJ/VVWNctItA2pQaypM2p6v
 sU8OUzMybMsCPYzDDzAjZd6+mkI+zqrF4AsoTNflZgX3B0sTMYe1qDn1xmCb5fywsMZP
 gOwUlVLLOMAj/S4WuCwiOtM9pucMq+Aqqax4Q8xJgu/o1WaLKVtg013FBIOQuqQoXIk0
 gjYFYqyA7rZE+pjKmvrSXJRB70l7gPgVgksOJh/G5+/G3xgDQxjbpOyKDpveZeGEQXlZ
 EGvBYX8qdpRjVSGx1vsumEX4Te6KXEbEQiGu+C30CPVHM33PZfijn1+9qHLoHpuX/LJU
 yVtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2dGQaX11/MVlDlnzqgCFh9Xb0SyA67mSqBHawm6VhTRRWzuvqLPA7YybI8NI11+OjehfsUER47zpV@nongnu.org
X-Gm-Message-State: AOJu0YyNm+iyRpNjcvzLH8Z6yKcTsEzGKnyQPDUAXX1T/dLUivxufhGS
 gvHTTCUUg4PA553C6eKUQk7NwenQ8QS5vTNHZuhWi9qjvNStemN2Uj+m6lExhWY=
X-Gm-Gg: ASbGnctQsgUGkKjAuJBSio/nMBIot+aIw3DDzUwVQzvULCxP/WJSS5i57RvgJDH+Vsb
 fBZO6L7mUria4kcAL/t6nLPKYR+fGBarCmZeAgYAOsE7pPJOJiDK5vFJw/Q72xz45Mx/w3Q2Gfm
 DlsJsHY+Ax5NqNky1ho1F2pqN2YkqJEn2/ABxVYwUEefiYPW2/h2iW1PIfvki1PD7xsOBIkODKd
 pCnTbBMs/uVel6vyJmBcZdlCoC+cyUaupRg1cvUTqtBMrj8eA2DmNmoMOqrtU0oxTB7Vg==
X-Google-Smtp-Source: AGHT+IHYbHsjxiObOpOR2o+XcvtGqz3o3ISnCRn16bu1MPnlWfV16yYIQwDNzQzLV7T+C9Ajtq6DXw==
X-Received: by 2002:a17:902:e5d2:b0:215:577b:ab77 with SMTP id
 d9443c01a7336-218d7252841mr56094345ad.39.1734548047416; 
 Wed, 18 Dec 2024 10:54:07 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5404csm79648545ad.150.2024.12.18.10.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 10:54:06 -0800 (PST)
Message-ID: <bd1f77f4-76b6-45f5-a709-1d2fc44932a0@linaro.org>
Date: Wed, 18 Dec 2024 10:54:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
 <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
 <8734il5oiy.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8734il5oiy.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMTIvMTgvMjQgMDE6MjcsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gT24g
MTIvMTcvMjQgMDI6MzgsIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+Pj4gT24gVHVlLCAxNyBE
ZWMgMjAyNCBhdCAwNzo0MCwgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4+Pj4NCj4+Pj4gUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4+DQo+Pj4+PiBPbiAxMi8xNi8yNCAxMTo1MCwg
UmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+Pj4+Pj4gT24gMTIvMTYvMjQgMTM6MjYsIFBp
ZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4+IE9uIDEyLzE2LzI0IDExOjEwLCBSaWNo
YXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+Pj4+Pj4+IE9uIDEyLzQvMjQgMTU6MTIsIFBpZXJy
aWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4+Pj4gcWVtdS1zeXN0ZW0tYWFyY2g2NCBkZWZh
dWx0IHBvaW50ZXIgYXV0aGVudGljYXRpb24gKFFBUk1BNSkgaXMgZXhwZW5zaXZlLCB3ZQ0K
Pj4+Pj4+Pj4+IHNwZW50IHVwIHRvIDUwJSBvZiB0aGUgZW11bGF0aW9uIHRpbWUgcnVubmlu
ZyBpdCAod2hlbiB1c2luZyBUQ0cpLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gU3dpdGNoaW5n
IHRvIHBhdXRoLWltcGRlZj1vbiBpcyBvZnRlbiBnaXZlbiBhcyBhIHNvbHV0aW9uIHRvIHNw
ZWVkIHVwIGV4ZWN1dGlvbi4NCj4+Pj4+Pj4+PiBUaHVzIHdlIHRhbGtlZCBhYm91dCBtYWtp
bmcgaXQgdGhlIG5ldyBkZWZhdWx0Lg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gVGhlIGZpcnN0
IHBhdGNoIGludHJvZHVjZSBhIG5ldyBwcm9wZXJ0eSAocGF1dGgtcWFybWE1KSB0byBhbGxv
dyB0byBzZWxlY3QNCj4+Pj4+Pj4+PiBjdXJyZW50IGRlZmF1bHQgYWxnb3JpdGhtLg0KPj4+
Pj4+Pj4+IFRoZSBzZWNvbmQgb25lIGNoYW5nZSB0aGUgZGVmYXVsdC4NCj4+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4+IFBpZXJyaWNrIEJvdXZpZXIgKDIpOg0KPj4+Pj4+Pj4+ICAgICAgICB0YXJn
ZXQvYXJtOiBhZGQgbmV3IHByb3BlcnR5IHRvIHNlbGVjdCBwYXV0aC1xYXJtYTUNCj4+Pj4+
Pj4+PiAgICAgICAgdGFyZ2V0L2FybTogY2hhbmdlIGRlZmF1bHQgcGF1dGggYWxnb3JpdGht
IHRvIGltcGRlZg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gICAgICAgZG9jcy9zeXN0ZW0vYXJt
L2NwdS1mZWF0dXJlcy5yc3QgfCAgNyArKysrKy0tDQo+Pj4+Pj4+Pj4gICAgICAgZG9jcy9z
eXN0ZW0vaW50cm9kdWN0aW9uLnJzdCAgICAgfCAgMiArLQ0KPj4+Pj4+Pj4+ICAgICAgIHRh
cmdldC9hcm0vY3B1LmggICAgICAgICAgICAgICAgIHwgIDEgKw0KPj4+Pj4+Pj4+ICAgICAg
IHRhcmdldC9hcm0vYXJtLXFtcC1jbWRzLmMgICAgICAgIHwgIDIgKy0NCj4+Pj4+Pj4+PiAg
ICAgICB0YXJnZXQvYXJtL2NwdTY0LmMgICAgICAgICAgICAgICB8IDMwICsrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQ0KPj4+Pj4+Pj4+ICAgICAgIHRlc3RzL3F0ZXN0L2FybS1j
cHUtZmVhdHVyZXMuYyAgIHwgMTUgKysrKysrKysrKystLS0tDQo+Pj4+Pj4+Pj4gICAgICAg
NiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgdW5kZXJzdGFuZCB0aGUgbW90aXZhdGlv
biwgYnV0IGFzLWlzIHRoaXMgd2lsbCBicmVhayBtaWdyYXRpb24uDQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4gSSB0aGluayB0aGlzIHdpbGwgbmVlZCB0byBiZSB2ZXJzaW9uZWQgc29tZWhvdywg
YnV0IHRoZSBvbmx5IHRoaW5nIHRoYXQgcmVhbGx5IGdldHMNCj4+Pj4+Pj4+IHZlcnNpb25l
ZCBhcmUgdGhlIGJvYXJkcywgYW5kIEknbSBub3Qgc3VyZSBob3cgdG8gbGluayB0aGF0IHRv
IHRoZSBpbnN0YW50aWF0ZWQgY3B1Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAg
IEZyb20gd2hhdCBJIHVuZGVyc3Rvb2QsIGFuZCBJIG1heSBiZSB3cm9uZywgdGhlIHVzZSBj
YXNlIHRvIG1pZ3JhdGUgKHRjZykgdm0gd2l0aCBjcHUgbWF4DQo+Pj4+Pj4+IGJldHdlZW4g
UUVNVSB2ZXJzaW9ucyBpcyAqbm90KiBzdXBwb3J0ZWQsIGFzIHdlIGNhbid0IGd1YXJhbnRl
ZSB3aGljaCBmZWF0dXJlcyBhcmUgcHJlc2VudA0KPj4+Pj4+PiBvciBub3QuDQo+Pj4+Pj4g
VGhpcyBkb2Vzbid0IGFmZmVjdCBvbmx5IC1jcHUgbWF4LCBidXQgYW55dGhpbmcgdXNpbmcg
YWFyY2g2NF9hZGRfcGF1dGhfcHJvcGVydGllcygpOg0KPj4+Pj4+IG5lb3ZlcnNlLW4xLCBu
ZW92ZXJzZS1uMiwgY29ydGV4LWE3MTAuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBJIHRoaW5r
IHRoaXMgaXMgc3RpbGwgYSBjaGFuZ2Ugd29ydGggdG8gZG8sIGJlY2F1c2UgcGVvcGxlIGNh
biBnZXQgYQ0KPj4+Pj4gMTAwJSBzcGVlZHVwIHdpdGggdGhpcyBzaW1wbGUgY2hhbmdlLCBh
bmQgaXQncyBhIGJldHRlciBkZWZhdWx0IHRoYW4NCj4+Pj4+IHRoZSBwcmV2aW91cyB2YWx1
ZS4NCj4+Pj4+IEluIG1vcmUsIGluIGNhc2Ugb2YgdGhpcyBtaWdyYXRpb24gc2NlbmFyaW8s
IFFFTVUgd2lsbCBpbW1lZGlhdGVseQ0KPj4+Pj4gYWJvcnQgdXBvbiBhY2Nlc3NpbmcgbWVt
b3J5IHRocm91Z2ggYSBwb2ludGVyLg0KPj4+Pj4NCj4+Pj4+IEknbSBub3Qgc3VyZSBhYm91
dCB3aGF0IHdvdWxkIGJlIHRoZSBiZXN0IHdheSB0byBtYWtlIHRoaXMgY2hhbmdlIGFzDQo+
Pj4+PiBzbW9vdGggYXMgcG9zc2libGUgZm9yIFFFTVUgdXNlcnMuDQo+Pj4+DQo+Pj4+IFN1
cmVseSB3ZSBjYW4gb25seSBob25vdXIgYW5kIGFwcGx5IHRoZSBuZXcgZGVmYXVsdCB0byAt
Y3B1IG1heD8NCj4+Pg0KPj4NCj4+IFdpdGggYWxsIG15IHJlc3BlY3QsIEkgdGhpbmsgdGhl
IGN1cnJlbnQgZGVmYXVsdCBpcyB3cm9uZywgYW5kIGl0DQo+PiB3b3VsZCBiZSBzYWQgdG8g
a2VlcCBpdCB3aGVuIHBlb3BsZSBkb24ndCBwcmVjaXNlIGNwdSBtYXgsIG9yIGZvcg0KPj4g
b3RoZXIgY3B1cyBlbmFibGluZyBwb2ludGVyIGF1dGhlbnRpY2F0aW9uLg0KPiANCj4gVGhl
cmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gbWF4IGFuZCBvdGhlciBDUFVzLiBGb3IgbWF4
IGFzIGhhcyBhbHJlYWR5DQo+IGJlZW4gc3RhdGVkIG1pZ3JhdGlvbiBpcyBsaWtlbHkgdG8g
YnJlYWsgYW55d2F5IGJldHdlZW4gUUVNVSB2ZXJzaW9ucyAtDQo+IHdlIHNob3VsZCBhbHNv
IG1ha2UgdGhhdCBjbGVhciBpbiB0aGUgZG9jcy4gQnV0IGZvciB0aGUgb3RoZXIgQ1BVcyB3
ZQ0KPiBuZWVkIHRvIGhvbm91ciB0aGUgZXhpc3RpbmcgZGVmYXVsdHMuDQo+IA0KDQpJJ2xs
IGFkZCB0aGlzIGluIHRoZSBkb2MgYXMgcGFydCBvZiB0aGlzIHNlcmllcy4NCg0KPj4gSW4g
YWxsIG91ciBjb252ZXJzYXRpb25zLCB0aGVyZSBzZWVtcyB0byBiZSBhIGZvY3VzIG9uIGNo
b29zaW5nIHRoZQ0KPj4gImZhc3Rlc3QiIGVtdWxhdGlvbiBzb2x1dGlvbiB0aGF0IHNhdGlz
ZmllcyB0aGUgZ3Vlc3QgKGJlaGF2aW91cg0KPj4gd2lzZSkuIEFuZCwgZm9yIGEgcmVhc29u
IEkgaWdub3JlLCBwb2ludGVyIGF1dGhlbnRpY2F0aW9uIGVzY2FwZWQgdGhpcw0KPj4gcnVs
ZS4NCj4+DQo+PiBJIHVuZGVyc3RhbmQgdGhlIGNvbmNlcm4gcmVnYXJkaW5nIHJldHJvIGNv
bXBhdGliaWxpdHksIGJ1dCBpdCB3b3VsZA0KPj4gYmUgYmV0dGVyIHRvIGFzayBwb2xpdGVs
eSAod2l0aCBhbiBlcnJvciBtZXNzYWdlKSB0byBwZW9wbGUgdG8gcmVzdGFydA0KPj4gdGhl
aXIgdmlydHVhbCBtYWNoaW5lcyB3aGVuIHRoZXkgdHJ5IHRvIG1pZ3JhdGUsIGluc3RlYWQg
b2YgYmVpbmcNCj4+IHN0dWNrIHdpdGggYSBzbG93IGRlZmF1bHQgZm9yZXZlci4NCj4gDQo+
IFRoaXMgaXMgd2h5IHdlIGhhdmUgY29tcGF0aWJpbGl0eSBsb2dpYyBzbyBpdHMgZWFzeSB0
byBkbyB0aGUgcmlnaHQNCj4gdGhpbmcgYnkgc3BlY2lmeWluZyB0aGUgUUVNVSB2ZXJzaW9u
IGluIHRoZSBtYWNoaW5lIHR5cGUuDQo+IA0KPj4gSW4gbW9yZSwgd2UgYXJlIHRhbGtpbmcg
b2YgYSB0Y2cgc2NlbmFyaW8sIGZvciB3aGljaCBJJ20gbm90IHN1cmUNCj4+IHBlb3BsZSB1
c2UgbWlncmF0aW9uIGZlYXR1cmUgKHNhdmUvcmVzdG9yZSkgaGVhdmlseSwgYnV0IEkgbWF5
IGJlDQo+PiB3cm9uZyBvbiB0aGlzLg0KPiANCj4gV2UgY2FuJ3QgYXNzdW1lIGl0cyBub3Qu
IFdlIGV2ZW4gaGF2ZSBleHBsaWNpdCB0ZXN0cyB0aGF0IGNoZWNrDQo+IG1pZ3JhdGlvbiBk
b2Vzbid0IGJyZWFrIGJldHdlZW4gbWFzdGVyIGFuZCAkUFJFVlNUQUJMRS4NCj4gDQo+PiBC
ZXR3ZWVuIHRoZSByaXNrIG9mIGJyZWFraW5nIG1pZ3JhdGlvbiAod2l0aCBhIHBvbGl0ZSBl
cnJvciBtZXNzYWdlKSwNCj4+IGFuZCBoYXZpbmcgYSBkZWZhdWx0IHRoYXQgaXMgMTAwJSBm
YXN0ZXIsIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyDQo+PiB0byBmYXZvciB0aGUgc2Vj
b25kIG9uZS4gSWYgaXQgd291bGQgYmUgYSA1JSBzcGVlZHVwLCBJIHdvdWxkIG5vdA0KPj4g
YXJndWUsIGJ1dCBzbG93aW5nIGRvd24gZXhlY3V0aW9uIHdpdGggYSBmYWN0b3Igb2YgMiBp
cyByZWFsbHkgYSBsb3QuDQo+Pg0KPj4+IFRoYXQgd2FzIHdoYXQgSSB0aG91Z2h0IHdlIHdl
cmUgYWltaW5nIGZvciwgeWVzLiBXZSAqY291bGQqIGhhdmUNCj4+PiBhIHByb3BlcnR5IG9u
IHRoZSBDUFUgdG8gc2F5ICJ1c2UgdGhlIG9sZCBiYWNrLWNvbXBhdGlibGUgZGVmYXVsdCwN
Cj4+PiBub3QgdGhlIG5ldyBvbmUiLCB3aGljaCB3ZSB0aGVuIGxpc3QgaW4gdGhlIGFwcHJv
cHJpYXRlIGh3X2NvbXBhdA0KPj4+IGFycmF5LiAoR3JlcCBmb3IgdGhlICJiYWNrY29tcGF0
LWNudGZycSIgcHJvcGVydHkgZm9yIGFuIGV4YW1wbGUgb2YNCj4+PiB0aGlzLikgQnV0IEkn
bSBub3Qgc3VyZSBpZiB0aGF0IGlzIHdvcnRoIHRoZSBlZmZvcnQgY29tcGFyZWQgdG8NCj4+
PiBqdXN0IGNoYW5naW5nICdtYXgnLg0KPj4NCj4+IFdoZW4gd2UnbGwgZGVmaW5lIGh3X2Nv
bXBhdF8xMF8wLCBhbmQgaHdfY29tcGF0XzExXzAsIGRvIHdlIGhhdmUgdG8NCj4+IGNhcnJ5
IHRoaXMgb24gZm9yZXZlcj8gKFNhbWUgcXVlc3Rpb24gZm9yICJiYWNrY29tcGF0LWNudGZy
cSIpLg0KPj4NCj4+PiAoSXQncyBub3QgdGhhdCBtdWNoIGV4dHJhIGNvZGUgdG8gYWRkIHRo
ZSBwcm9wZXJ0eSwgc28gSSBjb3VsZA0KPj4+IGVhc2lseSBiZSBwZXJzdWFkZWQgdGhlIG90
aGVyIHdheS4gUG9zc2libGUgYXJndW1lbnRzIGluY2x1ZGUNCj4+PiBwcmVmZXJyaW5nIGNv
bnNpc3RlbmN5IGFjcm9zcyBhbGwgQ1BVcy4gSWYgd2UgYWxyZWFkeSBtYWtlIHRoZQ0KPj4+
IGRlZmF1bHQgYmUgbm90ICJ3aGF0IHRoZSByZWFsIENQVSBvZiB0aGlzIHR5cGUgdXNlcyIg
dGhlbiB0aGF0J3MNCj4+PiBhbHNvIGFuIGFyZ3VtZW50IHRoYXQgd2UgY2FuIHNldCBpdCB0
byB3aGF0ZXZlciBpcyBjb252ZW5pZW50Ow0KPj4+IGlmIHdlIGRvIGhvbm91ciB0aGUgQ1BV
IElEIHJlZ2lzdGVyIHZhbHVlcyBmb3IgdGhlIGltcGxlbWVudGF0aW9uDQo+Pj4gZGVmYXVs
dCB0aGVuIHRoYXQncyBhbiBhcmd1bWVudCB0aGF0IHdlIHNob3VsZCBjb250aW51ZSB0byBk
bw0KPj4+IHNvIGFuZCBub3QgY2hhbmdlIHRoZSBkZWZhdWx0IHRvIG91ciBpbXBkZWYgb25l
LikNCj4+Pg0KPj4NCj4+IEZvciB0aGUgVENHIHVzZSBjYXNlLCBpcyB0aGVyZSBhbnkgdmlz
aWJsZSBzaWRlIGVmZmVjdCBmb3IgdGhlIGd1ZXN0DQo+PiB0byB1c2UgYW55IHNwZWNpZmlj
IHBvaW50ZXIgYXV0aGVudGljYXRpb24gYWxnb3JpdGhtPw0KPj4gSW4gb3RoZXIgd29yZHMs
IGlzIHRoZXJlIGEgc2NlbmFyaW8gd2hlcmUgcG9pbnRlciBhdXRoZW50aWNhdGlvbiB3b3Vs
ZA0KPj4gd29yayB3aXRoIGltcGRlZiwgYnV0IG5vdCB3aXRoIHFhcm1hezMsNX0/DQo+PiBJ
ZiBubywgSSBkb24ndCBzZWUgYW55IHJlYXNvbiBmb3IgYSBjcHUgdG8gZmF2b3IgYW4gZXhw
ZW5zaXZlDQo+PiBlbXVsYXRpb24uDQo+IA0KPiBJZiB0aGUgdXNlciBhc2tzIGZvciBhIHNw
ZWNpZmljIENQVSBtb2RlbCAobm90IGEgc3BlY2lhbCBjYXNlIGxpa2UgbWF4KQ0KPiB3ZSBz
aG91bGQgcHJvdmlkZSB0aGUgbW9zdCBhY2N1cmF0ZSBtb2RlbCB0aGF0IHdlIGNhbiBhcyBl
eHBsaWNpdGx5IHNldA0KPiBieSB0aGUgdXNlci4gV2UgZG9uJ3QgdHJhZGUgYWNjdXJhY3kg
Zm9yIHNwZWVkIChjLmYuIGRpc2N1c3Npb25zIGFib3V0DQo+IGZsb2F0aW5nIHBvaW50IGFu
ZCBJTkVYQUNUIGRldGVjdGlvbikuDQo+IA0KPj4gSW4gdGhlIGFjY2VsZXJhdG9yIGNhc2Us
IHdlIHJlYWQgdGhlIHZhbHVlcyBmcm9tIHRoZSBob3N0IGNwdSwgc28NCj4+IHRoZXJlIGlz
IG5vIHByb2JsZW0uDQo+Pg0KPj4+IC0tIFBNTQ0KPiANCg0K


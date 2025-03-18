Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6282C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tub5t-000815-OY; Tue, 18 Mar 2025 13:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tub5Q-0007rj-5Z
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:50:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tub54-000246-G1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:50:24 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30155bbbeaeso5039751a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742320214; x=1742925014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b1xKnKy4CGJ/XdKVe9sQQOXwvKQLk6WAfJQbJ8AYkec=;
 b=QJTPpDvv8aB5RrpI/x7Bmg94vGXqN5cgbAhf97JDK0AnLAGe/TS8/bBgZqsbM0zZqB
 NKV7Yu2jZHn4yvUyx09WtcPaOoBP6ZUvXdzTcyhFqFX/Kklz/AlLnwxd98s+s+fOIgVf
 sb3QVEFIjF7PIwo8Q9l3DcRiqK4p3TG17LvPpRRlGI9mJmYdDU8/feLNmTz5KveWbXc3
 1/AHtr1jMlOFh3OCN5Vsay15Mfv1RmGd17eQnSQECNKhEJCpLu213D5jMrwGXOw12qhs
 0jdZTmLiX8nyBti1IQbcgDP1nbZXbQI7td5xDvNFOgKIZ468M9RfmPfYTU4rbe2Q6iGL
 5bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742320214; x=1742925014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b1xKnKy4CGJ/XdKVe9sQQOXwvKQLk6WAfJQbJ8AYkec=;
 b=UtP2AhLZQdoArFaxVGgMcYrZEPE1AR5sXyxxq8terNpLNpDo8WUh2fZZLdoiz/09gg
 nG7y+B6yK79im5Fl46Bi29fhwAgT2iiefLhy4Hg1OWQhUoZMTJCH25I9vwwlkukQ1pV/
 aLwUbu1QpaQhXqNBADRkp0vMjTu9Kz3sDatwCM9QGqlsNu3DtPX9BPcM7VRX3k98RVJ6
 BcMZtzrOF7tTIhQyy8RXm1px21EqmbdHr6WlJpV1VBi3zNrODxKBPFq9HBnoARlA8qRB
 6AWif2evYUKpDYuufxzySaphwvq6Di9ocADY/f6Y+6Eno0+y+gTy1gOO9DJL9SaH2HKO
 GpFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnYbAT9KB8Rul+v+DTjRZHc8IS3Nct+QOJJvd2wdc/Kgl6w8KcCiXybc+8Tmld9JcHOyMtXtSc7wD5@nongnu.org
X-Gm-Message-State: AOJu0Yw9sFJbuNFgoVx9kobFd8E7dlF+ITl8keBz7NSEZIYIdjJ3BipZ
 QKyTrZR/3AHrkqFmk/p7c03+kIxH1a/Jh9fkV52+k1fUNd/da38SnppCqZlYmD8=
X-Gm-Gg: ASbGncsNlMi0z81ZgKS77zXDbI2sPSt+R5meWp6o+AKEGFBHBU6dCH/IFayCwrXf//g
 DYFu9w7ucAkUU8Qmd0efwNiV4dPb+W8Qg4TI4ilU3YbBFjQw9eoFLWMkYwHEKUxiICGXWoB8pk9
 yQfs6fck9i4qgcow3Kd7EARX4MOx984y35Xm5Rhs1jfrAZHVLxx01Br4e80vQKHLHQ13xhVYZyq
 Hfk3RmUQbxRIQjUzpQFcdoc8VCw3ZekFUI2csXVWfbX6Hrbfex+G9g/zX8OdBWpzCUAGQu8uVdl
 J+sC3QvzaKGU4KVdttkcZzoRhIIuNXAyQDwKkRMdSQ6XR9TTwpYxdD67Nw==
X-Google-Smtp-Source: AGHT+IH78tif7R6gzXurAW0XZxtmFJkJ2vsvt+xbpOCzQtnizanOa49k0QkDmETa9oq+SboQl1/F7w==
X-Received: by 2002:a17:90b:3142:b0:301:1d03:93b3 with SMTP id
 98e67ed59e1d1-301ba143043mr108818a91.22.1742320214477; 
 Tue, 18 Mar 2025 10:50:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015351961csm8531313a91.14.2025.03.18.10.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 10:50:14 -0700 (PDT)
Message-ID: <dba359a9-0e9a-471c-a34c-d4aefbf21ccb@linaro.org>
Date: Tue, 18 Mar 2025 10:50:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

T24gMy8xOC8yNSAxMDo0MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzMvMjUgMDU6NTEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBEaXJlY3RseSBj
b25kaXRpb24gYXNzb2NpYXRlZCBjYWxscyBpbiB0YXJnZXQvYXJtL2hlbHBlci5jIGZvciBu
b3cuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgICB0YXJnZXQvYXJtL2NwdS5oICAg
IHwgOCAtLS0tLS0tLQ0KPj4gICAgdGFyZ2V0L2FybS9oZWxwZXIuYyB8IDYgKysrKysrDQo+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9jcHUuaCBiL3RhcmdldC9hcm0vY3B1
LmgNCj4+IGluZGV4IDUxYjY0MjhjZmVjLi45MjA1Y2JkZWM0MyAxMDA2NDQNCj4+IC0tLSBh
L3RhcmdldC9hcm0vY3B1LmgNCj4+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmgNCj4+IEBAIC0x
MjIyLDcgKzEyMjIsNiBAQCBpbnQgYXJtX2NwdV93cml0ZV9lbGYzMl9ub3RlKFdyaXRlQ29y
ZUR1bXBGdW5jdGlvbiBmLCBDUFVTdGF0ZSAqY3MsDQo+PiAgICAgKi8NCj4+ICAgIHZvaWQg
YXJtX2VtdWxhdGVfZmlybXdhcmVfcmVzZXQoQ1BVU3RhdGUgKmNwdXN0YXRlLCBpbnQgdGFy
Z2V0X2VsKTsNCj4+ICAgIA0KPj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPj4gICAgaW50
IGFhcmNoNjRfY3B1X2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIEdCeXRlQXJy
YXkgKmJ1ZiwgaW50IHJlZyk7DQo+PiAgICBpbnQgYWFyY2g2NF9jcHVfZ2RiX3dyaXRlX3Jl
Z2lzdGVyKENQVVN0YXRlICpjcHUsIHVpbnQ4X3QgKmJ1ZiwgaW50IHJlZyk7DQo+PiAgICB2
b2lkIGFhcmNoNjRfc3ZlX25hcnJvd192cShDUFVBUk1TdGF0ZSAqZW52LCB1bnNpZ25lZCB2
cSk7DQo+PiBAQCAtMTI1NCwxMyArMTI1Myw2IEBAIHN0YXRpYyBpbmxpbmUgdWludDY0X3Qg
KnN2ZV9ic3dhcDY0KHVpbnQ2NF90ICpkc3QsIHVpbnQ2NF90ICpzcmMsIGludCBucikNCj4+
ICAgICNlbmRpZg0KPj4gICAgfQ0KPj4gICAgDQo+PiAtI2Vsc2UNCj4+IC1zdGF0aWMgaW5s
aW5lIHZvaWQgYWFyY2g2NF9zdmVfbmFycm93X3ZxKENQVUFSTVN0YXRlICplbnYsIHVuc2ln
bmVkIHZxKSB7IH0NCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgYWFyY2g2NF9zdmVfY2hhbmdl
X2VsKENQVUFSTVN0YXRlICplbnYsIGludCBvLA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IG4sIGJvb2wgYSkNCj4+IC17IH0NCj4+IC0jZW5k
aWYNCj4+IC0NCj4+ICAgIHZvaWQgYWFyY2g2NF9zeW5jXzMyX3RvXzY0KENQVUFSTVN0YXRl
ICplbnYpOw0KPj4gICAgdm9pZCBhYXJjaDY0X3N5bmNfNjRfdG9fMzIoQ1BVQVJNU3RhdGUg
KmVudik7DQo+PiAgICANCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5jIGIv
dGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4gaW5kZXggYjQ2YjJiZmZjZjMuLjc3NGUxZWUwMjQ1
IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4gKysrIGIvdGFyZ2V0
L2FybS9oZWxwZXIuYw0KPj4gQEAgLTY1NjIsNyArNjU2Miw5IEBAIHN0YXRpYyB2b2lkIHpj
cl93cml0ZShDUFVBUk1TdGF0ZSAqZW52LCBjb25zdCBBUk1DUFJlZ0luZm8gKnJpLA0KPj4g
ICAgICAgICAqLw0KPj4gICAgICAgIG5ld19sZW4gPSBzdmVfdnFtMV9mb3JfZWwoZW52LCBj
dXJfZWwpOw0KPj4gICAgICAgIGlmIChuZXdfbGVuIDwgb2xkX2xlbikgew0KPj4gKyNpZmRl
ZiBUQVJHRVRfQUFSQ0g2NA0KPiANCj4gV2hhdCBhYm91dCB1c2luZyBydW50aW1lIGNoZWNr
IGluc3RlYWQ/DQo+IA0KPiAgICBpZiAoYXJtX2ZlYXR1cmUoJmNwdS0+ZW52LCBBUk1fRkVB
VFVSRV9BQVJDSDY0KSAmJiBuZXdfbGVuIDwgb2xkX2xlbikgew0KPiANCg0KVGhpcyBpcyB0
aGUgcmlnaHQgd2F5IHRvIGRlYWwgd2l0aCBpdCwgYnV0IEkgd291bGQgcHJlZmVyIHRvIGRv
IGl0IHdoZW4gDQp0aGUgY29uY2VybmVkIGZpbGUgKHRhcmdldC9hcm0vaGVscGVyLmMpIHdp
bGwgYmUgbW9kaWZpZWQsIGluIGEgZnV0dXJlIA0Kc2VyaWVzLg0KDQpUaGUgY3VycmVudCBv
bmUgZm9jdXNlcyBvbiBody9hcm0gYW5kICJwdXNoZXMgYmFjayIgZGVwZW5kZW5jaWVzIGlu
IA0Kb3RoZXIgcGxhY2VzLCB0aGF0IHdlIGNhbiBkZWFsIHdpdGggbGF0ZXIuDQoNCk5vdGhp
bmcgd3Jvbmcgd2l0aCB0aGUgY2hhbmdlIHByb3Bvc2VkLCBqdXN0IHRyeWluZyB0byBmb2N1
cyBvbiB0aGUgDQptaW5pbWFsIHNldCBuZWVkZWQgdG8gcmVhY2ggdGhlIGdvYWwsIHdpdGhv
dXQgYW55IGRldG91ci4NCg0KPj4gICAgICAgICAgICBhYXJjaDY0X3N2ZV9uYXJyb3dfdnEo
ZW52LCBuZXdfbGVuICsgMSk7DQo+PiArI2VuZGlmDQo+PiAgICAgICAgfQ0KPj4gICAgfQ0K
PiANCg0K


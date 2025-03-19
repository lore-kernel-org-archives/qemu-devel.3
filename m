Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3ADC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 23:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv2x3-000222-A6; Wed, 19 Mar 2025 19:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2x1-00021o-HY
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:35:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2wz-0004fw-GK
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:35:55 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224171d6826so2643805ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742427351; x=1743032151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bba+WjZANogVZ1VO1VQrZkZQkuzhk6YNoaDnsc3kitM=;
 b=mQN14fdN8O7aZfvhk0gwrYBauFUF7f/vq5oR88z6tW0hDtkW2Kqk2Ofxyq+p4CkWsN
 nBKes9SXQLs19MOJesNWAuOICm4PtoigjOCtGVHg856hGDXT55SkfdHEJ3JheKZI0zzG
 eo96b430sshy98f2fXjXrzp26SzKPKGferjIbWTOhYDRYUqW82CSDVXRfso3GuaGVaKo
 e3sWx1T4WAJ+d+Efmhm4wheuQ/vQ01BJjgnY8DfLt1dn963i4r9zIUg9lRMQDVSJvwNF
 H9pSlSmKB+n1SoP7wBrxfxO9rrDNECyaiHVA7f0wflTiR6Pk6ZTU51DqU4jhK6+5ejY8
 6CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742427351; x=1743032151;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bba+WjZANogVZ1VO1VQrZkZQkuzhk6YNoaDnsc3kitM=;
 b=BYxT4XEGI8UUPq/C/GdyDdUT3AFZo1fIsvch279VWYPki8IU1msZMIsc0NHepe1aSs
 R1p+4CF9qj1B5I6DbjT2G7XOpGWnYOCbQKv/GHecg4sqFl0ZYcOWd6RrCWFgKNWaDdBS
 EXhB5sqiy33YdkmFyTeZMiqPskYQM0fs+4IorQKZfZU5XYmLd9y6cZsAlXFnNfIu4eHM
 n+lFJJMRTfW9S53UEwAmqn9S6WJYCFv0A1br2qfXA6ZxqpOUnDejCwBMzMLEoYATz9yI
 GbfUVQ8ZdnMbLU0G7qhe4Y7z2lxDTuS6u6FTKx/T1P/KMDrpwqSu7UiH0chtJxz6q1rz
 8ScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUZP+lHZuqFRCBf/yWeaBZ9I2QSrHWeY0vQGR3t/FYt0b7bRZb+7ObZNhkTVlbBsLcVkRdyoEQ1zXU@nongnu.org
X-Gm-Message-State: AOJu0YySUxyJU5lh1W224pOBUVjq+rgSO5tMx21rVkNP51d6879zHTPM
 z45GFWH0hkp6K1Yys3j94F8lURxvwrIj1CZPvrumr53BUCH5XpO2HJhoj6qZSRc=
X-Gm-Gg: ASbGncuVWYARfrXsTN2Q8pK0ezQR15ualnyZR/PV1D8YX4r8HZ5DR/HhCwqlghImVGN
 DTvgj59LxtXA0Il7YC7FQkLtklMuZBkMClHBQeHCXmdb2D5nLRAr/gB7kvENgn+C3wakOd3wHiB
 O5x0SMacbS2n/BAGXD0IjKbA1+jVIWeuVjiJ4753goyo+vZLwvVJK5ILIoUaBQPMKmD7QIR6/xa
 AnpuMosi7A0UveFXx0xnFh5Mjyr7bprUZB10Fhfx4jSi15zqicMxi4xubG337D7E4nFffWKxo5h
 JrvYCG68vUuFeBqthOe938A8AesV2QgHLBTw1QuWaWMVE1agQlbl9QWBq2ilL6yzXbm0
X-Google-Smtp-Source: AGHT+IETmexpnPzy5asUNH7L61TM7FIk56BJdgjCieEAWISIOp2MN6FnQVD6a0eBg54AiItWl2hCbA==
X-Received: by 2002:a17:903:1a08:b0:223:f928:4553 with SMTP id
 d9443c01a7336-22649a7ff9cmr77267365ad.44.1742427351422; 
 Wed, 19 Mar 2025 16:35:51 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68aa815sm121697505ad.102.2025.03.19.16.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 16:35:51 -0700 (PDT)
Message-ID: <6bf1aea4-9709-4216-9cd8-4e413caf6872@linaro.org>
Date: Wed, 19 Mar 2025 16:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
 <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
 <a3b61916-2466-4ec8-a4e1-567581be7a2b@linaro.org>
 <CAFEAcA9jsFqD-BR+zTzWV1V92fJqpghaOrGq1rDcdidm=R94Pw@mail.gmail.com>
 <8291b89a-9e97-47e6-9ee6-fd407066c3bf@linaro.org>
In-Reply-To: <8291b89a-9e97-47e6-9ee6-fd407066c3bf@linaro.org>
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

T24gMy8xOC8yNSAxMToxMywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMy8xOC8y
NSAxMTowNiwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4+IE9uIFR1ZSwgMTggTWFyIDIwMjUg
YXQgMTc6NTIsIFBpZXJyaWNrIEJvdXZpZXINCj4+IDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gMy8xOC8yNSAxMDo1MCwgUGV0ZXIgTWF5ZGVs
bCB3cm90ZToNCj4+Pj4gT24gVHVlLCAxOCBNYXIgMjAyNSBhdCAxNzo0MiwgUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiB3cm90ZToNCj4+Pj4+DQo+Pj4+
PiBPbiAxOC8zLzI1IDA1OjUxLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4+IERp
cmVjdGx5IGNvbmRpdGlvbiBhc3NvY2lhdGVkIGNhbGxzIGluIHRhcmdldC9hcm0vaGVscGVy
LmMgZm9yIG5vdy4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+Pj4+PiAtLS0NCj4+Pj4+
PiAgICAgIHRhcmdldC9hcm0vY3B1LmggICAgfCA4IC0tLS0tLS0tDQo+Pj4+Pj4gICAgICB0
YXJnZXQvYXJtL2hlbHBlci5jIHwgNiArKysrKysNCj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vY3B1LmggYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4+
Pj4gaW5kZXggNTFiNjQyOGNmZWMuLjkyMDVjYmRlYzQzIDEwMDY0NA0KPj4+Pj4+IC0tLSBh
L3RhcmdldC9hcm0vY3B1LmgNCj4+Pj4+PiArKysgYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4+
Pj4gQEAgLTEyMjIsNyArMTIyMiw2IEBAIGludCBhcm1fY3B1X3dyaXRlX2VsZjMyX25vdGUo
V3JpdGVDb3JlRHVtcEZ1bmN0aW9uIGYsIENQVVN0YXRlICpjcywNCj4+Pj4+PiAgICAgICAq
Lw0KPj4+Pj4+ICAgICAgdm9pZCBhcm1fZW11bGF0ZV9maXJtd2FyZV9yZXNldChDUFVTdGF0
ZSAqY3B1c3RhdGUsIGludCB0YXJnZXRfZWwpOw0KPj4+Pj4+DQo+Pj4+Pj4gLSNpZmRlZiBU
QVJHRVRfQUFSQ0g2NA0KPj4+Pj4+ICAgICAgaW50IGFhcmNoNjRfY3B1X2dkYl9yZWFkX3Jl
Z2lzdGVyKENQVVN0YXRlICpjcHUsIEdCeXRlQXJyYXkgKmJ1ZiwgaW50IHJlZyk7DQo+Pj4+
Pj4gICAgICBpbnQgYWFyY2g2NF9jcHVfZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpj
cHUsIHVpbnQ4X3QgKmJ1ZiwgaW50IHJlZyk7DQo+Pj4+Pj4gICAgICB2b2lkIGFhcmNoNjRf
c3ZlX25hcnJvd192cShDUFVBUk1TdGF0ZSAqZW52LCB1bnNpZ25lZCB2cSk7DQo+Pj4+Pj4g
QEAgLTEyNTQsMTMgKzEyNTMsNiBAQCBzdGF0aWMgaW5saW5lIHVpbnQ2NF90ICpzdmVfYnN3
YXA2NCh1aW50NjRfdCAqZHN0LCB1aW50NjRfdCAqc3JjLCBpbnQgbnIpDQo+Pj4+Pj4gICAg
ICAjZW5kaWYNCj4+Pj4+PiAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+IC0jZWxzZQ0KPj4+Pj4+
IC1zdGF0aWMgaW5saW5lIHZvaWQgYWFyY2g2NF9zdmVfbmFycm93X3ZxKENQVUFSTVN0YXRl
ICplbnYsIHVuc2lnbmVkIHZxKSB7IH0NCj4+Pj4+PiAtc3RhdGljIGlubGluZSB2b2lkIGFh
cmNoNjRfc3ZlX2NoYW5nZV9lbChDUFVBUk1TdGF0ZSAqZW52LCBpbnQgbywNCj4+Pj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbiwgYm9vbCBh
KQ0KPj4+Pj4+IC17IH0NCj4+Pj4+PiAtI2VuZGlmDQo+Pj4+Pj4gLQ0KPj4+Pj4+ICAgICAg
dm9pZCBhYXJjaDY0X3N5bmNfMzJfdG9fNjQoQ1BVQVJNU3RhdGUgKmVudik7DQo+Pj4+Pj4g
ICAgICB2b2lkIGFhcmNoNjRfc3luY182NF90b18zMihDUFVBUk1TdGF0ZSAqZW52KTsNCj4+
Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5jIGIvdGFyZ2V0
L2FybS9oZWxwZXIuYw0KPj4+Pj4+IGluZGV4IGI0NmIyYmZmY2YzLi43NzRlMWVlMDI0NSAx
MDA2NDQNCj4+Pj4+PiAtLS0gYS90YXJnZXQvYXJtL2hlbHBlci5jDQo+Pj4+Pj4gKysrIGIv
dGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4+Pj4+IEBAIC02NTYyLDcgKzY1NjIsOSBAQCBzdGF0
aWMgdm9pZCB6Y3Jfd3JpdGUoQ1BVQVJNU3RhdGUgKmVudiwgY29uc3QgQVJNQ1BSZWdJbmZv
ICpyaSwNCj4+Pj4+PiAgICAgICAgICAgKi8NCj4+Pj4+PiAgICAgICAgICBuZXdfbGVuID0g
c3ZlX3ZxbTFfZm9yX2VsKGVudiwgY3VyX2VsKTsNCj4+Pj4+PiAgICAgICAgICBpZiAobmV3
X2xlbiA8IG9sZF9sZW4pIHsNCj4+Pj4+PiArI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+Pj4+
Pg0KPj4+Pj4gV2hhdCBhYm91dCB1c2luZyBydW50aW1lIGNoZWNrIGluc3RlYWQ/DQo+Pj4+
Pg0KPj4+Pj4gICAgICBpZiAoYXJtX2ZlYXR1cmUoJmNwdS0+ZW52LCBBUk1fRkVBVFVSRV9B
QVJDSDY0KSAmJiBuZXdfbGVuIDwgb2xkX2xlbikgew0KPj4+Pj4NCj4+Pj4NCj4+Pj4gVGhh
dCB3b3VsZCBiZSBhIGRlYWQgY2hlY2s6IGl0IGlzIG5vdCBwb3NzaWJsZSB0byBnZXQgaGVy
ZQ0KPj4+PiB1bmxlc3MgQVJNX0ZFQVRVUkVfQUFSQ0g2NCBpcyBzZXQuDQo+Pj4+DQo+Pj4N
Cj4+PiBXZSBjYW4gdGhlbiBhc3NlcnQgaXQsIHRvIG1ha2Ugc3VyZSB0aGVyZSBpcyBubyBy
ZWdyZXNzaW9uIGFyb3VuZCB0aGF0Lg0KPj4NCj4+IFdlIGhhdmUgYSBsb3Qgb2Ygd3JpdGUv
cmVhZC9hY2Nlc3MgZm5zIGZvciBBQXJjaDY0LW9ubHkgc3lzcmVncywgYW5kDQo+PiB3ZSBk
b24ndCBuZWVkIHRvIGFzc2VydCBpbiBhbGwgb2YgdGhlbSB0aGF0IHRoZXkncmUgY2FsbGVk
IG9ubHkgd2hlbg0KPj4gdGhlIENQVSBoYXMgQUFyY2g2NCBlbmFibGVkLg0KPj4NCj4+PiBX
ZSBub3cgaGF2ZSBhbm90aGVyIGNvbnZlcnNhdGlvbiBhbmQgc29tZXRoaW5nIHRvIGRlY2lk
ZSBpbiBhbm90aGVyDQo+Pj4gZmlsZSwgYW5kIHRoYXQncyB3aHkgSSBjaG9zZSB0byBkbyB0
aGUgbWluaW1hbCBjaGFuZ2UgKCJpZmRlZiB0aGUNCj4+PiBpc3N1ZSIpIGluc3RlYWQgb2Yg
dHJ5aW5nIHRvIGRvIGFueSBjaGFuZ2UuDQo+Pg0KPj4gSSB0aGluayB3ZSBjYW4gZmFpcmx5
IGVhc2lseSBhdm9pZCBpZmRlZmZpbmcgdGhlIGNhbGxzaXRlIG9mDQo+PiBhYXJjaDY0X3N2
ZV9uYXJyb3dfdnEoKS4gQ3VycmVudGx5IHdlIGhhdmU6DQo+PiAgICAqIGEgcmVhbCB2ZXJz
aW9uIG9mIHRoZSBmdW5jdGlvbiwgd2hvc2UgZGVmaW5pdGlvbiBpcyBpbnNpZGUNCj4+ICAg
ICAgYW4gaWZkZWYgVEFSR0VUX0FBUkNINjQgaW4gdGFyZ2V0L2FybS9oZWxwZXIuYw0KPj4g
ICAgKiBhIHN0dWIgdmVyc2lvbiwgaW5saW5lIGluIHRoZSBjcHUuaCBoZWFkZXINCj4+DQo+
PiBJZiB3ZSBkb24ndCB3YW50IHRvIGhhdmUgdGhlIHN0dWIgdmVyc2lvbiB3aXRoIGlmZGVm
cywgdGhlbiB3ZSBjYW4NCj4+IG1vdmUgdGhlIHJlYWwgaW1wbGVtZW50YXRpb24gb2YgdGhl
IGZ1bmN0aW9uIHRvIG5vdCBiZSBpbnNpZGUgdGhlDQo+PiBpZmRlZiAobWF0Y2hpbmcgdGhl
IGZhY3QgdGhhdCB0aGUgcHJvdG90eXBlIGlzIG5vIGxvbmdlciBpbnNpZGUNCj4+IGFuIGlm
ZGVmKS4gVGhlIGZ1bmN0aW9uIGRvZXNuJ3QgY2FsbCBhbnkgb3RoZXIgZnVuY3Rpb25zIHRo
YXQgYXJlDQo+PiBUQVJHRVRfQUFSQ0g2NCBvbmx5LCBzbyBpdCBzaG91bGRuJ3QgYmUgYSAi
bm93IHdlIGhhdmUgdG8gbW92ZQ0KPj4gNTAgb3RoZXIgdGhpbmdzIiBwcm9ibGVtLCBJIGhv
cGUuDQo+Pg0KPiANCj4gSSdsbCB0cnkgdG8ganVzdCBsZXQgdGhlIGNhbGwgYmUgZG9uZSwg
YW5kIHNlZSB3aGF0IGhhcHBlbnMuDQo+IEJ1dCBpZiBJIG1lZXQgYSByZWdyZXNzaW9uIHNv
bWV3aGVyZSBpbiB0YXJnZXQvYXJtLyosIEknbGwgc2ltcGx5DQo+IGxldCB0aGUgY3VycmVu
dCBpZmRlZiBmb3Igbm93Lg0KPiANCj4gSSB1bmRlcnN0YW5kIGl0ICJzaG91bGQgYmUgb2si
LCBidXQgSSBqdXN0IHdhbnQgdG8gZm9jdXMgb24gaHcvYXJtLCBhbmQNCj4gbm90IHN0YXJ0
IGZ1cnRoZXIgY2hhbmdlcyBpbiB0YXJnZXQvYXJtL2hlbHBlci5jIGFzIGEgc2lkZSBlZmZl
Y3Qgb2YNCj4gc2ltcGx5IG1vdmluZyBhbiBpZmRlZiBpbiBhIGhlYWRlci4NCj4gDQoNCkkg
dHJpZWQgdG8gc2ltcGx5IGlmZGVmIGZ1bmN0aW9ucyBkZXBlbmRpbmcgb24gdGhvc2Ugc3lt
Ym9scy4gSG93ZXZlciwgDQp0aGlzIGFkZHMgbXVjaCBtb3JlIGlmZGVmcyB0aGFuIHRoaXMg
b3JpZ2luYWwgcGF0Y2guDQpTb29uLCB3ZSdsbCBjb21wbGV0ZWx5IHJlbW92ZSB0aG9zZSBp
ZmRlZnMgZnJvbSB0YXJnZXQvYXJtL2hlbHBlci5jLCBzbyANCkknbGwganVzdCBjYWxsIGl0
IGEgZGF5IGZvciBub3csIHdpdGhvdXQgYWRkaW5nIHN0dWJzIHRoYXQgd2lsbCBiZSANCnJl
bW92ZWQgc29vbiBhcyB3ZWxsLg0KDQo+PiB0aGFua3MNCj4+IC0tIFBNTQ0KPiANCg0K


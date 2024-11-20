Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35026D743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDsil-0001sK-MP; Wed, 20 Nov 2024 16:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDsiP-0001ar-CS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:58:27 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDsiL-00074S-15
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:58:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21116b187c4so1398445ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732139899; x=1732744699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1rKcniXgxdvV6OMEiIKMaL2cduwYnSQRJhKxAOGzjE=;
 b=m72s25gP1rh1AyDR2qMq43I2Ri08rw4Ow5PsX1Sfx6toXADoba+2VvNVTwmW0hFutn
 646DVG8Q14FzWZhQGgdZ9gKNSst+mPyKI78VaYBgCQPlcbl5Jcs32nSKiFU5bjiK+B2D
 AePQplWW5o9K2vgVtj6+MpR9COyWeA8v5Bv+4x4sJv4F1sSCZsEGF83COqqz2bpd8hAL
 gmvRnGoCxAUpZfU/nXrHTKYF6ooltFHstgXi/u+ec1yppQMtlaKMDrGZL3mmnigIxnBn
 xRTVH2PiFy2+03BS5v3/Oplopqpm5Q2iI7TWCzeD69f1vScUritBJDV5gClbRvE4Wu3O
 Xe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139899; x=1732744699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1rKcniXgxdvV6OMEiIKMaL2cduwYnSQRJhKxAOGzjE=;
 b=OkjeWFkBnU2CNT3bF9Ab0a7gptRs0QqdXrMqLdmm2mVVsJ5EKowDqnMCRk+/dm4w+M
 cq19V/AhHESTwiZATvFn37BqV2yyb1ndtAAGZCxsUhKMbJHNNM4ZCJljJ5ICe2mCp+Bs
 HRuizGUbCHtb4Tha+a/XZYwTHqCwpKrS+BM2LJBU/sSR7UUP9cJQ5UN/FI5QDFAM/z4T
 GbiKSCV8t9Vp9wd6f8b4+BWjxYsywtueDjzsCggVvQySnpwH3nqbsRjUw47Qq1nv0yhW
 NPJUVet+/3x0gro6JzdxestaDlkVu8GvTPC8wN158Git7jVnjCg8ND/ei5N0bijnXPzn
 LObQ==
X-Gm-Message-State: AOJu0YzO6Vzuna9r8YdQR6+4hWzZD5JPF9TkpsGYejsxhPOJ8qZu0EUd
 KalPfYppT0i3xFcKFfpXRFTnOlcyCSMdmGARaCvwy5jSXNY3nFom+EpVgMT8vFY=
X-Google-Smtp-Source: AGHT+IGoa9RiX1UR1EflR6+sqDIpQ8UMsBUviGHMxt9hRz1nrj4zmB1CHJCPAIn3a18BkXSQZDrdQQ==
X-Received: by 2002:a17:902:ccc6:b0:20b:3f70:2e05 with SMTP id
 d9443c01a7336-2126a475010mr53620485ad.41.1732139899286; 
 Wed, 20 Nov 2024 13:58:19 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2128788ac4esm367295ad.14.2024.11.20.13.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 13:58:18 -0800 (PST)
Message-ID: <ec89b777-92a9-4956-8a8a-12c6dcbef034@linaro.org>
Date: Wed, 20 Nov 2024 13:58:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] docs/devel: add information on how to setup build
 environments
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-5-pierrick.bouvier@linaro.org>
 <ZzxZRwXAIlMt6SNA@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZzxZRwXAIlMt6SNA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

T24gMTEvMTkvMjQgMDE6MjQsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIE1v
biwgTm92IDE4LCAyMDI0IGF0IDA5OjIzOjU0QU0gLTA4MDAsIFBpZXJyaWNrIEJvdXZpZXIg
d3JvdGU6DQo+PiBNYWNPUyBhbmQgTGludXggYXJlIHN0cmFpZ2h0Zm9yd2FyZCwgYnV0IFdp
bmRvd3MgbmVlZHMgYSBiaXQgbW9yZQ0KPj4gZGV0YWlscy4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+
PiAtLS0NCj4+ICAgZG9jcy9hYm91dC9idWlsZC1wbGF0Zm9ybXMucnN0ICAgfCAgIDQgKy0N
Cj4+ICAgZG9jcy9kZXZlbC9idWlsZC1lbnZpcm9ubWVudC5yc3QgfCAxMTQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBkb2NzL2RldmVsL2luZGV4LWJ1aWxkLnJz
dCAgICAgICB8ICAgMSArDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTE4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3MvZGV2ZWwv
YnVpbGQtZW52aXJvbm1lbnQucnN0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RvY3MvYWJvdXQv
YnVpbGQtcGxhdGZvcm1zLnJzdCBiL2RvY3MvYWJvdXQvYnVpbGQtcGxhdGZvcm1zLnJzdA0K
Pj4gaW5kZXggNjEwMmYwMGFlYzAuLmMxZWE1M2RiODM0IDEwMDY0NA0KPj4gLS0tIGEvZG9j
cy9hYm91dC9idWlsZC1wbGF0Zm9ybXMucnN0DQo+PiArKysgYi9kb2NzL2Fib3V0L2J1aWxk
LXBsYXRmb3Jtcy5yc3QNCj4+IEBAIC0yOSw2ICsyOSw5IEBAIFRoZSBgUmVwb2xvZ3lgXyBz
aXRlIGlzIGEgdXNlZnVsIHJlc291cmNlIHRvIGlkZW50aWZ5DQo+PiAgIGN1cnJlbnRseSBz
aGlwcGVkIHZlcnNpb25zIG9mIHNvZnR3YXJlIGluIHZhcmlvdXMgb3BlcmF0aW5nIHN5c3Rl
bXMsDQo+PiAgIHRob3VnaCBpdCBkb2VzIG5vdCBjb3ZlciBhbGwgZGlzdHJvcyBsaXN0ZWQg
YmVsb3cuDQo+PiAgIA0KPj4gK1lvdSBjYW4gZmluZCBob3cgdG8gaW5zdGFsbCBidWlsZCBk
ZXBlbmRlbmNpZXMgZm9yIGRpZmZlcmVudCBzeXN0ZW1zIG9uIHRoZQ0KPj4gKzpyZWY6YHNl
dHVwLWJ1aWxkLWVudmAgcGFnZS4NCj4+ICsNCj4+ICAgU3VwcG9ydGVkIGhvc3QgYXJjaGl0
ZWN0dXJlcw0KPj4gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIA0KPj4g
QEAgLTEzMCw3ICsxMzMsNiBAQCBPcHRpb25hbCBidWlsZCBkZXBlbmRlbmNpZXMNCj4+ICAg
ICBjcm9zcyBjb21waWxhdGlvbiB1c2luZyBgYGRvY2tlcmBgIG9yIGBgcG9kbWFuYGAsIG9y
IHRvIHVzZSBwcmUtYnVpbHQNCj4+ICAgICBiaW5hcmllcyBkaXN0cmlidXRlZCB3aXRoIFFF
TVUuDQo+PiAgIA0KPj4gLQ0KPj4gICBXaW5kb3dzDQo+PiAgIC0tLS0tLS0NCj4+ICAgDQo+
PiBkaWZmIC0tZ2l0IGEvZG9jcy9kZXZlbC9idWlsZC1lbnZpcm9ubWVudC5yc3QgYi9kb2Nz
L2RldmVsL2J1aWxkLWVudmlyb25tZW50LnJzdA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwLi5kOWE2NmY1ZmNjNg0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvZG9jcy9kZXZlbC9idWlsZC1lbnZpcm9ubWVudC5yc3QNCj4+IEBAIC0wLDAg
KzEsMTE0IEBADQo+PiArDQo+PiArLi4gX3NldHVwLWJ1aWxkLWVudjoNCj4+ICsNCj4+ICtT
ZXR1cCBidWlsZCBlbnZpcm9ubWVudA0KPj4gKz09PT09PT09PT09PT09PT09PT09PT09DQo+
PiArDQo+PiArUUVNVSB1c2VzIGEgbG90IG9mIGRlcGVuZGVuY2llcyBvbiB0aGUgaG9zdCBz
eXN0ZW0uIGdsaWIyIGlzIHVzZWQgZXZlcnl3aGVyZSBpbg0KPj4gK3RoZSBjb2RlIGJhc2Us
IGFuZCBtb3N0IG9mIHRoZSBvdGhlciBkZXBlbmRlbmNpZXMgYXJlIG9wdGlvbmFsLg0KPj4g
Kw0KPj4gK1dlIHByZXNlbnQgaGVyZSBzaW1wbGUgaW5zdHJ1Y3Rpb25zIHRvIGVuYWJsZSBu
YXRpdmUgYnVpbGRzIG9uIG1vc3QgcG9wdWxhcg0KPj4gK3N5c3RlbXMuDQo+PiArDQo+PiAr
WW91IGNhbiBmaW5kIGFkZGl0aW9uYWwgaW5zdHJ1Y3Rpb25zIG9uIGBRRU1VIHdpa2kgPGh0
dHBzOi8vd2lraS5xZW11Lm9yZy8+YF86DQo+PiArDQo+PiArLSBgTGludXggPGh0dHBzOi8v
d2lraS5xZW11Lm9yZy9Ib3N0cy9MaW51eD5gXw0KPj4gKy0gYE1hY09TIDxodHRwczovL3dp
a2kucWVtdS5vcmcvSG9zdHMvTWFjPmBfDQo+PiArLSBgV2luZG93cyA8aHR0cHM6Ly93aWtp
LnFlbXUub3JnL0hvc3RzL1czMj5gXw0KPj4gKy0gYEJTRCA8aHR0cHM6Ly93aWtpLnFlbXUu
b3JnL0hvc3RzL0JTRD5gXw0KPiANCj4gDQo+IFdlIGdlbmVyYWxseSBzdWZmZXIgZnJvbSBo
YXZpbmcgaW5mb3JtYXRpb24gc3ByZWFkIG92ZXIgbXVsdGlwbGUgc291cmNlcywNCj4gZ2l2
aW5nIHVzIHRoZSBidXJkZW4gb2Yga2VlcGluZyB0aGUgZGlmZmVyZW50IHBsYWNlcyBjb25z
aXN0ZW50LCB3aGljaCB3ZQ0KPiBwcmV0dHkgY29uc2lzdGVudGx5IGZhaWwgYXQuDQo+IA0K
DQpBZ3JlZSBvbiB0aGF0Lg0KDQo+IEl0IGlzIGEgZ29vZCB0aGluayB0byBhZGQgYnVpbGQg
ZW52IGRvY3MgdG8gcWVtdS5naXQgd2hlcmUgd2UgYWN0dWFsbHkNCj4gaGF2ZSBvdmVyc2ln
aHQgLyByZXZpZXcgdG8gY2F0Y2ggbWlzdGFrZXMuIElmIHdlIGRvIHRoaXMgdGhvdWdoLCBJ
TUhPLA0KPiB3ZSBzaG91bGQgYmUgZGVsZXRpbmcgdGhlIHdpa2kgcGFnZXMgYW5kIG1ha2lu
ZyB0aGVtIGludG8gMzAyIHJlZGlyZWN0cw0KPiB0byBvdXIgbmV3IGluLXRyZWUgZG9jcy4N
Cj4gDQoNClN1cmUuDQpIb3dldmVyLCB0aGVyZSBpcyBzdGlsbCBzb21lIHVzZWZ1bCBpbmZv
cm1hdGlvbiB0aGVyZSwgdGhhdCBhcmUgbm90IA0KcmVmbGVjdGVkIGluIHRoaXMgcGF0Y2gu
DQoNCldlIGNvdWxkIG1pZ3JhdGUgdGhlIGluZm9ybWF0aW9uIGxhdGVyLCBidXQgZm9yIG5v
dywgSSBjYW4ndCBzcGVuZCBtYW55IA0KY3ljbGVzIHRvIHRyeSB0byBidWlsZCBhbGwgY29u
ZmlndXJhdGlvbnMgZGVzY3JpYmVkIG9uIHRoZSB3aWtpIHRvIG1ha2UgDQpzdXJlIGl0J3Mg
dXAgdG8gZGF0ZS4NClNvIEkganVzdCBpbmNsdWRlZCBpbmZvcm1hdGlvbiBJJ20gc3VyZSBp
dCB3b3JrcywgYW5kIHRoYXQgY292ZXIgdGhlIA0KYmFzaWMgbmVlZHMgdG8gYnVpbGQgb24g
YWxsIG1ham9yIHN5c3RlbXMuDQoNCkhvcGUgdGhpcyBpcyBhIHN0YXJ0aW5nIHBvaW50IHdl
IGNhbiBtYXliZSBhY2NlcHQsIGFuZCB3ZSBjYW4gZW5oYW5jZSANCnRoZSBkb2N1bWVudGF0
aW9uIGxhdGVyLiBCdXQgYXNraW5nIHRvIGRvIGFsbCB0aGlzIGF0IG9uY2UgaXMgYSBiaWcg
DQp0YXNrLCBhbmQgSSBmZWVsIGl0J3MgYSBsb3QgdG8gYXNrIGZvciBpdCBhcyBwYXJ0IG9m
IHRoZSBjdXJyZW50IHNlcmllcy4NCg0KV291bGQgeW91IGFjY2VwdCB0aGF0LCBvciBwcmVm
ZXIgdG8gbm90IGluY2x1ZGUgYW55dGhpbmcgYmVmb3JlIHdlIGhhdmUgDQpwdXJnZWQgdGhl
IHdpa2lzIGNvbXBsZXRlbHk/DQoNCj4+ICsNCj4+ICtMaW51eA0KPj4gKy0tLS0tDQo+PiAr
DQo+PiArRmVkb3JhDQo+PiArKysrKysrDQo+PiArDQo+PiArOjoNCj4+ICsNCj4+ICsgICAg
c3VkbyBkbmYgdXBkYXRlICYmIHN1ZG8gZG5mIGJ1aWxkZGVwIHFlbXUNCj4+ICsNCj4+ICtE
ZWJpYW4vVWJ1bnR1DQo+PiArKysrKysrKysrKysrKw0KPj4gKw0KPj4gK1lvdSBmaXJzdCBu
ZWVkIHRvIGVuYWJsZSBgU291cmNlcyBMaXN0IDxodHRwczovL3dpa2kuZGViaWFuLm9yZy9T
b3VyY2VzTGlzdD5gXy4NCj4+ICtUaGVuLCB1c2UgYXB0IHRvIGluc3RhbGwgZGVwZW5kZW5j
aWVzOg0KPj4gKw0KPj4gKzo6DQo+PiArDQo+PiArICAgIHN1ZG8gYXB0IHVwZGF0ZSAmJiBz
dWRvIGFwdCBidWlsZC1kZXAgcWVtdQ0KPj4gKw0KPj4gK01hY09TDQo+PiArLS0tLS0NCj4+
ICsNCj4+ICtZb3UgZmlyc3QgbmVlZCB0byBpbnN0YWxsIGBIb21lYnJldyA8aHR0cHM6Ly9i
cmV3LnNoLz5gXy4gVGhlbiwgdXNlIGl0IHRvDQo+PiAraW5zdGFsbCBkZXBlbmRlbmNpZXM6
DQo+PiArDQo+PiArOjoNCj4+ICsNCj4+ICsgICAgYnJldyB1cGRhdGUgJiYgYnJldyBpbnN0
YWxsICQoYnJldyBkZXBzIC0taW5jbHVkZS1idWlsZCBxZW11KQ0KPiANCj4gDQo+IFRoZSBk
b3duc2lkZSBpbiByZWNvbW1lbmRpbmcgdGhlICdidWlsZCBkZXAnIGFwcHJvYWNoIGlzIHRo
YXQgaXQgbWlzc2VzDQo+IG91dCBvbiBkZXBzIHRoYXQgaGF2ZSBiZWVuIG5ld2x5IGludHJv
ZHVjZWQgaW4gcWVtdS5naXQsIHNpbmNlIHdoYXRldmVyDQo+IG9sZCB2ZXJzaW9uIG9mIFFF
TVUgdGhlIGRpc3Ryb3MgYXJlIHNoaXBwaW5nLiAgSXQgYWxzbyBtaXNzZXMgZGVwcyBmb3IN
Cj4gYW55IGZlYXR1cmVzIHRoZSBkaXN0cm8gdmVuZG9yIGhhcyBkZWNpZGVkIHRvIGV4Y2x1
ZGUuDQo+IA0KPiBDYW4gd2UgcHV0IGEgY2F2ZWF0IGRlc2NyaWJpbmcgdGhpcyBsaW1pdGF0
aW9uIGF0IHRoZSB0b3AsIHNvIHRoYXQgdXNlcnMNCj4gaGF2ZSBwb2ludGVyIGlmIHRoaW5n
cyBkb24ndCBxdWl0ZSBnbyB0aGUgd2F5IHdlIGV4cGVjdGVkLg0KPg0KDQpJIGNhbiBhZGQg
YSBub3RlIGFib3V0IGl0LiBJdCdzIGVzcGVjaWFsbHkgdHJ1ZSBmb3IgTGludXgsIGFzIG9u
IFdpbmRvd3MgDQooTVNZUzIpIGFuZCBNYWNPUyAoaG9tZWJyZXcpLCB0aGV5IHVzdWFsbHkg
dHJhY2sgbGF0ZXN0IHJlbGVhc2Ugb2YgUUVNVSwgDQpzbyB0aGUgYnVpbGQgbGlzdCBzaG91
bGQgbWF0Y2gsIGdpdmVuIGEgcmVkdWNlZCB0aW1lIGZyYW1lIGFmdGVyIHRoZSANCnJlbGVh
c2UuDQoNCj4+ICsNCj4+ICtXaW5kb3dzDQo+PiArLS0tLS0tLQ0KPj4gKw0KPj4gK1lvdSBm
aXJzdCBuZWVkIHRvIGluc3RhbGwgYE1TWVMyIDxodHRwczovL3d3dy5tc3lzMi5vcmcvPmBf
Lg0KPj4gK01TWVMyIG9mZmVycyBgZGlmZmVyZW50IGVudmlyb25tZW50cyA8aHR0cHM6Ly93
d3cubXN5czIub3JnL2RvY3MvZW52aXJvbm1lbnRzLz5gXy4NCj4+ICt4ODZfNjQgZW52aXJv
bm1lbnRzIGFyZSBiYXNlZCBvbiBHQ0MsIHdoaWxlIGFhcmNoNjQgaXMgYmFzZWQgb24gQ2xh
bmcuDQo+PiArDQo+PiArV2UgcmVjb21tZW5kIHRvIHVzZSBNSU5HVzY0IGZvciB3aW5kb3dz
LXg4Nl82NCBhbmQgQ0xBTkdBUk02NCBmb3Igd2luZG93cy1hYXJjaDY0DQo+PiArKG9ubHkg
YXZhaWxhYmxlIG9uIHdpbmRvd3MtYWFyY2g2NCBob3N0cykuDQo+IA0KPiBEb2VzIENMQU5H
QVJNNjQgcmVhbGx5IHdvcmsgd2l0aCBRRU1VID8gICBXZSBnbyBvdXQgb2Ygb3VyIHdheSB0
byBhY3RpdmVseQ0KPiBibG9jayB0aGUgdXNlIG9mIENMYW5nIGZvciBXaW5kb3dzIGJlY2F1
c2Ugb2YgaXRzIGxhY2sgb2Ygc3VwcG9ydCBmb3INCj4gJ2djY19zdHJ1Y3QnIGF0dHJpYnV0
ZXMsIHNvIEkgd291bGQgaGF2ZSBleHBlY3RlZCBpdCB0byBmYWlsDQo+IA0KDQpJIGNhbiBk
cm9wIHRoZSB3aW5kb3dzLWFybTY0IHBhcnQuDQpGb3IgdGhlIHN1cHBvcnQsIGl0J3MgYSBk
aXNjdXNzaW9uIHdlIGFkZCBwcmV2aW91c2x5IG9uIHRoZSBjb25jZXJuZWQgDQpzZXJpZXMu
IEluIGN1cnJlbnQgbWFzdGVyLCBpdCB3b24ndCBldmVuIGdvIHBhc3QgdGhlIGNvbmZpZ3Vy
ZSBzdGVwIA0KYmVjYXVzZSBvZiBpbnRlbnRpb25hbCByZXN0cmljdGlvbiB3ZSBoYXZlIGlu
IG1lc29uLmJ1aWxkLg0KTXkgaW5pdGlhbCBob3BlIHdhcyB0byByZW1vdmUgaXQsIGJ1dCBJ
IHVuZGVyc3RhbmQgdGhhdCB3ZSBwcmVmZXIgdG8gDQp3YWl0IGZvciBnY2Nfc3RydWN0IHN1
cHBvcnQgaW4gY2xhbmcuIFNvIGJlIGl0LCBJIGNhbiBsaXZlIHdpdGggYSBsb2NhbCANCmZp
eCBmb3IgdGhhdCBtZWFud2hpbGUgOikuDQoNCj4+ICsNCj4+ICtUaGVuLCB5b3UgY2FuIG9w
ZW4gYSB3aW5kb3dzIHNoZWxsLCBhbmQgZW50ZXIgbXN5czIgZW52IHVzaW5nOg0KPj4gKw0K
Pj4gKzo6DQo+PiArDQo+PiArICAgIGM6L21zeXM2NC9tc3lzMl9zaGVsbC5jbWQgLWRlZnRl
cm0gLWhlcmUgLW5vLXN0YXJ0IC1taW5ndzY0DQo+PiArICAgICMgUmVwbGFjZSAtdWNydDY0
IGJ5IC1jbGFuZ2FybTY0IG9yIC11Y3J0NjQgZm9yIG90aGVyIGVudmlyb25tZW50cy4NCj4+
ICsNCj4+ICtNU1lTMiBwYWNrYWdlIG1hbmFnZXIgZG9lcyBub3Qgb2ZmZXIgYSBidWlsdC1p
biB3YXkgdG8gaW5zdGFsbCBidWlsZA0KPj4gK2RlcGVuZGVuY2llcy4gWW91IGNhbiBzdGFy
dCB3aXRoIHRoaXMgbGlzdCBvZiBwYWNrYWdlcyB1c2luZyBwYWNtYW46DQo+PiArDQo+IA0K
PiBXaXRoIHJlZ2FyZHMsDQo+IERhbmllbA0KDQo=


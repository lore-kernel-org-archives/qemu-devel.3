Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBF8D6E2CA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 06:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDeDh-0002fK-6A; Wed, 20 Nov 2024 01:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDeDf-0002el-6s
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:29:43 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDeDc-00005C-53
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:29:42 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f8cc29aaf2so1287456a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 22:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732084178; x=1732688978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1GVP68nyuDefceK1RhYkPlb+WdyURxuIQytWQmEjrCM=;
 b=FwxrNQA35x1BT67T7XGYVsLigFZl1vOKCrIXrGRM4sX7gTuPkg9iVVb22BnAvNfaJ4
 oEAq6x4Gght79o2qeAD5o6pSBPw0jxzi8F+3in518nIzXxo8HflxM72ql+FhMQdUzU5O
 +MpGxdyzBLxW5N+mXGQ9v6K4hMjtPub2JcYLFT7waIH5mzmhgJsR0JhGk/2iy4skgtLF
 eibOkRGxPe+V2bh7NQ2xqVA28w0cdv+gNZMSEgcwgl51SlYm2nZX8K2OYGY7pUKfIl+B
 rdqr4gssAj8FONnBvkYtEbBcup/F4v1yqPklPVRvtomFa6rx4Sn7LfdkJJmSjvUosUjo
 TLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732084178; x=1732688978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1GVP68nyuDefceK1RhYkPlb+WdyURxuIQytWQmEjrCM=;
 b=P4vD6Zo3XolnsMhBsE0N7H20js2S3DkSQof60QQo+Oa0wT9m7ReosfvFdWGKjBwtC0
 xHBn93iMlG/5H+u/MA4N9rNwKs5dVPH0eIdv59JQtciF+/d2oPBRaUEtuNA2Jk4Hz6W1
 1nd/tp1y8lNobAzCDVrpJJfqOYOJlQ7BSbwC5Iai1JQeq38fe/Zml5sj8Qp0F05GyuMC
 oxS2wp8PNmHB5AJ0F7TZxR05SH6e+X2o3zuHExaaMdI+OACHUNZErRl8TsZGKhhgf99g
 KE9cjXgUqwJRZOcKfF8r7a3qQatWa0PvU3M9LAMVORTdXQ6hP9R0ol0CLpEal/IrL56H
 AKGA==
X-Gm-Message-State: AOJu0Yw5Be+u6YsqAiUeMioLic2K/9vV8g+8ofnhT1KK8UslQmX8rk83
 0CmUZVf80wp1em21xdlHKmV36yA8k0O1/nKHpT6s6cJXE0T18dMpDEkO3L+HXXo=
X-Gm-Gg: ASbGnctfmOTbpsJ/Sh19ZhD+GlMpXg6AUFIakA9kPTnFG2cChyz8X9DXHFXpGjMN3ky
 lWdw6C6M8RJj6jfP1EHdwL3WEne/BbKhrCKRepDcxtsd4BkFIN1UZMDIGXH/S5Y5+UFaBH4Q3T6
 R0MvHiF8UrrMLcpAd5pCECGRNVfnOTGgz6HzDoZSaSSXgbWJbF8D9cbm5eoHFC9bq42aHuU9Gro
 LNRl+b+1Fs8h045Jw9ODN5jxc39h+z0bHiZfkv6LtDbq1vq4Jr5q73ZGmv0JaA7/3+dY7ZaTrQN
 t3IJkkaYB7JVwCPHTeZY0g==
X-Google-Smtp-Source: AGHT+IEAMNsZFkOAyKDLzrDIreDMiakfpwTGWdiMlDAQI8UDHnUqB4k1v7z9IktdgmZ+aCAAUPKDEw==
X-Received: by 2002:a05:6a20:3953:b0:1d9:3b81:cdd3 with SMTP id
 adf61e73a8af0-1ddae1fa439mr2641549637.1.1732084178482; 
 Tue, 19 Nov 2024 22:29:38 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724bef8da27sm790332b3a.91.2024.11.19.22.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 22:29:38 -0800 (PST)
Message-ID: <2e1ad112-6bf6-460d-96b0-8f87f1b44fb6@linaro.org>
Date: Tue, 19 Nov 2024 22:29:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
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
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
 <ce090d62-89a8-4f1a-a864-add24704dd11@linaro.org>
 <ZzxWeG-UKT0odfL8@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZzxWeG-UKT0odfL8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

T24gMTEvMTkvMjQgMDE6MTIsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIFR1
ZSwgTm92IDE5LCAyMDI0IGF0IDA5OjQxOjQwQU0gKzAxMDAsIE1hcmNpbiBKdXN6a2lld2lj
eiB3cm90ZToNCj4+IFcgZG5pdSAxOC4xMS4yMDI0IG/CoDE4OjIzLCBQaWVycmljayBCb3V2
aWVyIHBpc3plOg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAgICBkb2NzL2RldmVsL3N1
Ym1pdHRpbmctYS1wYXRjaC5yc3QgfCAxNCArKysrKysrKysrKysrKw0KPj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZG9j
cy9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2gucnN0IGIvZG9jcy9kZXZlbC9zdWJtaXR0aW5n
LWEtcGF0Y2gucnN0DQo+Pj4gaW5kZXggMzQ5YzMyZWUzYTkuLjk1MzY4MmYyMGNiIDEwMDY0
NA0KPj4+IC0tLSBhL2RvY3MvZGV2ZWwvc3VibWl0dGluZy1hLXBhdGNoLnJzdA0KPj4+ICsr
KyBiL2RvY3MvZGV2ZWwvc3VibWl0dGluZy1hLXBhdGNoLnJzdA0KPj4+IEBAIC0yMzcsNiAr
MjM3LDIwIEBAIGF0dGFjaG1lbnRzIGNhbiBiZSB1c2VkIGFzIGEgbGFzdCByZXNvcnQgb24g
YSBmaXJzdC10aW1lIHN1Ym1pc3Npb24uDQo+Pj4gICAgLi4gX2lmX3lvdV9jYW5ub3Rfc2Vu
ZF9wYXRjaF9lbWFpbHM6DQo+Pj4gK1VzZSBnaXQtcHVibGlzaA0KPj4+ICt+fn5+fn5+fn5+
fn5+fn4NCj4+PiArDQo+Pj4gK0lmIHlvdSBhbHJlYWR5IGNvbmZpZ3VyZWQgZ2l0IHNlbmQt
ZW1haWwsIHlvdSBjYW4gc2ltcGx5IHVzZSBgZ2l0LXB1Ymxpc2gNCj4+PiArPGh0dHBzOi8v
Z2l0aHViLmNvbS9zdGVmYW5oYS9naXQtcHVibGlzaD5gX18gdG8gc2VuZCBzZXJpZXMuDQo+
Pj4gKw0KPj4+ICs6Og0KPj4+ICsNCj4+PiArICAgICQgZ2l0IGNoZWNrb3V0IG1hc3RlciAt
YiBteS1mZWF0dXJlDQo+Pj4gKyAgICAkICMgd29yayBvbiBuZXcgY29tbWl0cywgYWRkIHlv
dXIgJ1NpZ25lZC1vZmYtYnknIGxpbmVzIHRvIGVhY2gNCj4+PiArICAgICQgZ2l0IHB1Ymxp
c2gNCj4+PiArICAgICQgLi4uIG1vcmUgd29yaywgcmViYXNlIG9uIG1hc3RlciwgLi4uDQo+
Pj4gKyAgICAkIGdpdCBwdWJsaXNoICMgd2lsbCBzZW5kIGEgdjINCj4+DQo+PiBZb3UgcmVj
b21tZW5kICdiNCBzaGF6YW0nIGluIDMvNyBwYXRjaCBzbyB3aHkgbm90IGhlcmU/IEJvdGgg
J2I0JyBhbmQNCj4+ICdnaXQtcHVibGlzaCcgc2VlbSB0byBkbyBzYW1lIHN0dWZmIC0gaGFu
ZGxlIHBhdGNoIHNlcmllcyBhbmQgc2VuZCB0aGVtDQo+PiB1cHN0cmVhbS4NCj4gDQo+IGdp
dC1wdWJsaXNoIGlzIHdoYXQgd2UgYWxyZWFkeSByZWNvbW1lbmRlZCB0byBwZW9wbGUgYm90
aCBlbHNld2hlcmUgaW4NCj4gdGhpcyBmaWxlLCBhbmQgbW9yZSBwcm9taW5lbnRseSBpbiB0
aGUgUkVBRE1FLnJzdCBmaWxlLCBzbyBtYWludGFpbmluZw0KPiB0aGF0IHByYWN0aWNlIGlz
IGNvcnJlY3QuDQo+IA0KDQpBdCB0aGUgdGltZSBJIHN0YXJ0ZWQgd29ya2luZyBvbiBRRU1V
LCBJIG1pc3NlZCB0aGF0IGluZm9ybWF0aW9uLCANCmJlY2F1c2UgSSBmb2N1c2VkIG9uIHRo
ZSBtYW51YWwgKG1pc3NpbmcgdGhlIGNvbnRlbnQgb2YgdGhlIFJFQURNRSksIHNvIA0KdGhh
dCdzIHdoeSBJIGFkZCBpdCBoZXJlIGFzIHdlbGwuDQoNCj4+IGI0IGFsbG93cyB0byBrZWVw
IFRvL0NjIGVtYWlscyBpbnNpZGUgb2YgY292ZXIgbGV0dGVyIHdoaWNoIG1ha2VzIGl0IGVh
c3kgdG8NCj4+IG5vdCBtaXNzIGFueW9uZSBuZWVkZWQuDQo+IA0KPiBnaXQtcHVibGlzaCBh
dXRvbWF0aWNhbGx5IENDJ3MgcGVvcGxlIGJ5IGNvcnJlbGF0aW5nIHRoZSBmaWxlcyB0b3Vj
aGVkIGluDQo+IHRoZSBjb21taXRzIGFnYWluc3Qgb3VyIE1BSU5UQUlORVJTIGZpbGUsIHNv
IGl0ICJkb2VzIHRoZSByaWdodCB0aGluZyINCj4gaW4gdGhlIG1ham9yaXR5IG9mIGNhc2Vz
LiBXZSByZWNvbW1lbmQgaXQgYmVjYXVzZSBpdCBtYWtlcyBpdCBtdWNoIGhhcmRlcg0KPiBm
b3Igbm92aWNlIHVzZXJzIHRvIG1lc3MgdXAgcGF0Y2ggc2VyaWVzIHN1Ym1pc3Npb24uDQo+
DQoNCkkgYWdyZWUgd2l0aCB0aGF0LiBGcm9tIG15IHBlcnNvbmFsIGV4cGVyaWVuY2UsIHRo
ZSBoYXJkZXN0IHBhcnQgd2hlbiANCm9uYm9hcmRpbmcgd2l0aCBlbWFpbCB3b3JrZmxvdyBp
cyBtb3JlIHRvIHVuZGVyc3RhbmQgaXQgKHdoaWNoIHN0ZXBzIHlvdSANCmdvIHRocm91Z2gg
dW50aWwgdGhlIGNvbnRyaWJ1dGlvbiBpcyBhY2NlcHRlZCksIG1vcmUgdGhhbiBsZWFybmlu
ZyBhIA0Kc3BlY2lmaWMgdG9vbCBpbiBwYXJ0aWN1bGFyLg0KU28gaGF2aW5nIGEgInNpbXBs
ZSIgdG9vbCBsaWtlIGdpdC1wdWJsaXNoIGlzIGdvb2QuDQoNCj4gV2l0aCByZWdhcmRzLA0K
PiBEYW5pZWwNCg0K


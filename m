Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9ADD6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMp4-00039B-K5; Wed, 27 Nov 2024 13:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGMoo-0002kj-TB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:31:20 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGMol-0002uV-Uv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:31:17 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7251331e756so74777b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732732274; x=1733337074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yVRdWpRtnBqzjVZzo1jk7Ut74SB6owCWRTP6clVkI8w=;
 b=TZ3S+mMrCof+Yqo9NcZZr7GJZ4hVd9OZPTaNkY+1eA/in09fJ6vFJGz9AIbjJBKCdk
 dSBzeXfTMFfrTms+UyNXOz2Ns0rAkAMGMlcHRzUkw0NYjmJ68H7nUFetIAbnxp5w71eH
 R/EcyQr5kRFJi12ANVOBHYV0rd0eAYjGCO+rwZGm5LtJfmG0x+A2atXx0hWC4wZtfYLu
 WtWJ1wNRXOrwN+q3eIrJv0AB1plTZlLPFGfnjR336eVZ5CY4Am/4mWovOli89BvV/e8V
 EAeoSYnyugSOo1C3/fQZcKmAjaB96J4j5D5LRWrgN6EDAedxQ+AT0VE0hvnGfGseAdm4
 fdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732732274; x=1733337074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yVRdWpRtnBqzjVZzo1jk7Ut74SB6owCWRTP6clVkI8w=;
 b=cI11LMertH0MljmtqRUmJe9gtk0LIAFJWhkQDw/pEmk1+PgPg5DC9RMrmjhodvVBwc
 UjqexCTXz+V0GX7IVhxfiPntHzAG59xnY/LLbFhPPfjm6BebJfQ5sc5u3yZLACqo8cPe
 QkqkqvbjJQkEQylahfcQKdG166egH9k6HT+1IsR2QbBsZLk/at5D4rj1FAAV5fGi5gEn
 sh2ubVsFmUyv8CSG+WVHo9yZS/4OGfExYzp+8MuH+VBqaTIUfKEA7pYyr8YQ7Y1ehTuT
 6gmHJqt9Y56hPzbhX0QEk7nqYo6iww+dRbe8dR778RxO1BsjfDMHkZx6NHSG1RbztAwC
 qxew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsiORgcWXOl8fB0F745X1Q8kOckR0glERX7AW+srGkCKHMDgi+fic/Novy2DzhGSugmQEsy8CQ7aHI@nongnu.org
X-Gm-Message-State: AOJu0Yw0Ow3kaMK/NWdMYiDCtuifRGn816l6vXXf78Fsilks5qm0gQos
 ZjSrE6WbOr7KSUw7R8kAq2ref4qlJKWxGwSwUORzuGdCy2+LCq341bajWnj45RvMPMBaFdaB/7d
 eL90=
X-Gm-Gg: ASbGncslkvaMI8Iz0DB3Ti9lDu5fYNj/M/3TcG+olYgQu+ImOyH190Lu7BCX9PtkPef
 6iNiOlzarY74QQYWIc9s6MPOk0S8I4XZyJEdMB0L4YY+gIRwzb5Ml8h65cJWwNp8gN3Ndd1N4sh
 fuHpVjtnurmN1AyM+4QcPmGOIyD8nMiv89UQLZ8erwEGSPeTaFEXSx7KMp4hPe9fFxF/BumU+nj
 1P/CfSDiKoSweJM7kW0vyWKM7KuzY/3qIT3zQ124UPSttPaQrtR9+tisUPzV8V+F7b9Zt56Zrkv
 iSxL4q9Op+s2NKZFprmbfg==
X-Google-Smtp-Source: AGHT+IEIF+U1n+DPfWjI2o7N+5LM5Tg6ZQfWszZgzVvf7ZnYQq8ZRcJivHB2Nqqi6qflaWpGbwGbAA==
X-Received: by 2002:a17:90b:3e86:b0:2ea:9309:757e with SMTP id
 98e67ed59e1d1-2ee08e9fa32mr5369193a91.9.1732732274477; 
 Wed, 27 Nov 2024 10:31:14 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de573d37sm10524141b3a.174.2024.11.27.10.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 10:31:13 -0800 (PST)
Message-ID: <07f2dcf3-8796-4e8e-af1e-c3e860dcd095@linaro.org>
Date: Wed, 27 Nov 2024 10:31:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <Z0bhDbpovFOkDomB@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Z0bhDbpovFOkDomB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gMTEvMjcvMjQgMDE6MDYsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIFR1
ZSwgTm92IDI2LCAyMDI0IGF0IDA0OjU0OjE4UE0gLTA2MDAsIFJpY2hhcmQgSGVuZGVyc29u
IHdyb3RlOg0KPj4gT24gMTEvMjYvMjQgMTE6NTIsIFRob21hcyBIdXRoIHdyb3RlOg0KPj4+
IEkgdGhpbmsgd2Ugd2FudCB0byBjb250aW51ZSB0byBtYWVrIGZhaWxpbmcgZG93bmxvYWRz
IGFzIHRlc3QgZmFpbHVyZXMsDQo+Pj4gb3RoZXJ3aXNlIHdlJ2xsIG5ldmVyIG5vdGljZSB3
aGVuIGFuIGFzc2V0IGlzIG5vdCBhdmFpbGFibGUgZnJvbSB0aGUNCj4+PiBpbnRlcm5ldCBh
bnltb3JlIChzaW5jZSBTS0lQcyBqdXN0IGdldCBpZ25vcmVkKS4NCj4+DQo+PiBJIGRpc2Fn
cmVlLiAgRG93bmxvYWQgZmFpbHVyZXMgYXJlIG5vdCByYXJlLg0KPiANCj4gRmFpbHVyZXMg
b2YgdGhlIHRlc3QgdG8gZG93bmxvYWQgYXNzZXRzIHdpbGwgYmUgcmFyZSAqaWYqIHdlIGhh
dmUgdGhlDQo+IENJIHJ1bm5lciBjYWNoZSBmaXhlZC4gV2Ugb25seSBuZWVkIHRvIHN1Y2Nl
c3NmdWxseSBkb3dubG9hZCBlYWNoDQo+IGFzc2V0IG9uY2UsIGFuZCBpdCBzaG91bGQgYmUg
Y2FjaGVkIGZvcmV2ZXIgd2l0aCBubyBleHBpcnkgdGltZW91dC4NCj4gDQo+IFNvIHdlIGhh
dmUgYW4gaW5pdGlhbGx5IGJvb3RzdHJhcHBpbmcgcHJvYmxlbSBvbmNlIGNhY2hpbmcgaXMg
Zml4ZWQsDQo+IHdoZXJlIGRvd25sb2FkIGZhaWx1cmVzIGNvdWxkIGltcGFjdCB1cy4gT25j
ZSB0aGUgY2FjaGUgaXMgcHJpbWVkLA0KPiB3ZSdsbCBvbmx5IGJlIGF0IHJpc2sgb2YgZG93
bmxvYWQgZmFpbHVyZXMgd2hlbiBpbnRyb2R1Y2luZyBuZXcNCj4gYXNzZXQgVVJMcywgc28g
SSB0aGluayBpdCBpcyBmYWlyIHRvIHNheSBmYWlsdXJlcyBzaG91bGQgYmUgcmFyZQ0KPiAq
aWYqIHdlIGdldCB0aGUgY2FjaGluZyBmaXhlZC4NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4g
RGFuaWVsDQoNCkJleW9uZCB0aGUgUUVNVSBDSSwgd2Ugc2hvdWxkIHRoaW5rIGFib3V0IHVz
ZXJzIHRyeWluZyB0byBydW4gdGVzdHMsIGFuZCANCmhhdmluZyB0aGUgc2FtZSBraW5kIG9m
IHByb2JsZW1zLCBidXQgd2l0aG91dCBoYXZpbmcgYWNjZXNzIHRvIHRoZSBtYWdpYyANCmNh
Y2hlLg0KDQpSZWdhcmRpbmcgdGhlIGFzc2V0cyBkb3dubG9hZCwgd2h5IGRvbid0IHdlIG1p
cnJvciB0aGVtIHNvbWV3aGVyZSANCnJlbGlhYmxlIGluc3RlYWQgb2YgcmVseWluZyBvbiB0
aGlyZCBwYXJ0eSBzdG9yYWdlPw0KDQpJdCBjb3VsZCBiZSBhbm90aGVyIGdpdGh1YiByZXBv
IChhbmQgd2UgcHVzaCBmaWxlcyBpbiBhICJyZWxlYXNlIiwgd2hlcmUgDQpzaXplIGlzIHVu
bGltaXRlZCkuIEluIG15IGV4cGVyaWVuY2UsIGl0J3MgdmVyeSByZWxpYWJsZSwgYW5kIHVw
dGltZSBpcyANCjk5Ljk5OSUuDQoNClRoZSBjaGFuZ2UgaXMgbm90IGNvbXBsaWNhdGVkLCBh
bmQgdGhlcmUgaXMgbm8gcmlzayB0byBpbnRyb2R1Y2UgDQpyZWdyZXNzaW9ucywgYXMgdGhl
IGhhc2hlcyB3aWxsIGJlIGV4YWN0bHkgdGhlIHNhbWUuDQpXZSBjYW4gZXZlbiBkbyBpdCBv
biBhIGJlc3QtZWZmb3J0IGJhc2lzLCB3aGVuIG9uZSBkZXAgc3RhcnQgZmFpbGluZy4NCg0K
UGllcnJpY2sNCg==


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A30C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqbV9-0001Ia-QA; Fri, 07 Mar 2025 12:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqbV6-0001DH-MK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:28:44 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqbV4-0000Pl-OD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:28:44 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3903774a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 09:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741368521; x=1741973321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fuCjjgBkNEewYDYmiM8ozxvRqJg4DrU5jlpsU73PMjU=;
 b=ott3vYpf5ARak/WRU/JRuvajE1JOBGz24go66oACLh6Q8mK6GgOhj6qIVYJs/P/ic9
 R474+kXZR1BYOr8DxyI1Fk1Ui2f85E0vB8lSaS3resw2Kqbp9QThPE0mVAsrzAdUpoCO
 ZxWe8R1RYMqqTmPjMZ6NB0DMMAdjBhbr2ODsFDF03l01Gojl42us1kcAt57g8X5qk8Do
 3Qi5xyEq7fQSzdh1PkCEINn9T0WFS62L0X6lfMd0A9kjYyJimf7jVcKaIe52Ys/U0v8u
 OH4Ayty3ur8xuGa4rVayeiHI+w7BQGrMDK4fiVmtxikrY+TUaJhZk7OgG4HW8Vple5JG
 xtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741368521; x=1741973321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuCjjgBkNEewYDYmiM8ozxvRqJg4DrU5jlpsU73PMjU=;
 b=mRgCtV8l4s2qrejaQoPh2YB5+x9KsOb4kBmzbpnw5Fg6RknXQX2lCiodC7T+tzq+Yl
 DnhwRsZzb7RhmmD6VpV/qO9P3aahWe5QM8RpUPes+dMb00iL1PZ5S9/eRMawIj/aR9r2
 aa6U/3Kk0if1zoq/QN2lV1vE0B3WQL41mFeldAni7js1UhkPvaImSiizvt8PPMVrtD/D
 wJThQcEFcSjEVtBH4WCS0F1u2x3NjHX0OJaATikn7fLE+WNc30dx6z9gMUIs9Jw6ufNn
 +Izez9dBjm0XfxfCPIj4lbomI9zlzyjXqcJZ1h63McqoeXKcxHoBxB/99HGrXaIY5CXE
 R/Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXosJfAFTNcBwQKJK3tIl8FgS5117LCCPIlgh+dlB4kela8DJ/jTZQjyAyIJGjWjumGQYy/BMzgOR0s@nongnu.org
X-Gm-Message-State: AOJu0YxEOAiGLpBz/yuRUUgqhgBc1ougfxLrV5u/cEFec22pav7C+9bk
 xYBiLFUsM76DNtBSDMFJfSsoSRCwriHc06NZg0aLUFdvXY1s8d6z9B/aY3H2OAY=
X-Gm-Gg: ASbGncsZZYOJDPYOlvx98+fmAA1fn1BtI2zr6oqOENRiz0kKzi72yiTwfZu/pF7ZLEX
 xE3eHOptyl2Yi/NiV+4OzbO/cO71wMogS2lXDKppDTbuFG0fZEmhAKZyuhiYN9hsqvvRjIhTNYb
 x0iRfvU2kyzQPiHhwZOyzMv9Qv1l1KVINy2v+RDxWsHpFzRudgEu1ncFpEzKb3t5bMrTsxcpRVu
 K70+IPt769pXIXXErU6Zo49H6aZw6V+ex/C18+bg6lrGEFKHLekRu9GlIAKA2NeoevPhPF4lhpY
 aeSehQ/HE09E2ezLJYXuGCZQoKW5731QssEPnlyYlqlGPTWpJ4YH7jeKHA==
X-Google-Smtp-Source: AGHT+IHkmMPBeC7Jjz6QaagGABV93I+Jsq2T/Kqau419WQZhtTKYIasZKgrWrz43zBNXteOS9gtokg==
X-Received: by 2002:a05:6a20:43a0:b0:1f1:253:2e6d with SMTP id
 adf61e73a8af0-1f544c377efmr7566014637.29.1741368521281; 
 Fri, 07 Mar 2025 09:28:41 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2812887b3sm2819173a12.71.2025.03.07.09.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 09:28:40 -0800 (PST)
Message-ID: <ab1a90fb-e068-4ddc-865e-07bdeb2789e3@linaro.org>
Date: Fri, 7 Mar 2025 09:28:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 manos.pitsidianakis@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
 <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
 <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
 <d62743f5-ca79-47c0-a72b-c36308574bdd@linaro.org>
 <6556fdd8-83ea-4cc6-9a3b-3822fdc8cb5d@linaro.org>
 <95a6f718-8fab-434c-9b02-6812f7afbcc3@maciej.szmigiero.name>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <95a6f718-8fab-434c-9b02-6812f7afbcc3@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

T24gMy83LzI1IDAzOjA3LCBNYWNpZWogUy4gU3ptaWdpZXJvIHdyb3RlOg0KPiBPbiA2LjAz
LjIwMjUgMjM6NTYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzYvMjUgMDk6
NTgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+IE9uIDYvMy8yNSAxNzoy
MywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4gT24gMy82LzI1IDA4OjE5LCBSaWNo
YXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+Pj4+IE9uIDMvNS8yNSAyMjo0MSwgUGllcnJpY2sg
Qm91dmllciB3cm90ZToNCj4+Pj4+PiBSZXBsYWNlIFRBUkdFVF9QQUdFLiogYnkgcnVudGlt
ZSBjYWxscw0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICDC
oMKgwqAgaHcvaHlwZXJ2L3N5bmRiZy5jwqDCoMKgIHwgNyArKysrLS0tDQo+Pj4+Pj4gIMKg
wqDCoCBody9oeXBlcnYvbWVzb24uYnVpbGQgfCAyICstDQo+Pj4+Pj4gIMKgwqDCoCAyIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0K
Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody9oeXBlcnYvc3luZGJnLmMgYi9ody9oeXBlcnYvc3lu
ZGJnLmMNCj4+Pj4+PiBpbmRleCBkM2UzOTE3MDc3Mi4uZjkzODIyMDJlZDMgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvaHcvaHlwZXJ2L3N5bmRiZy5jDQo+Pj4+Pj4gKysrIGIvaHcvaHlwZXJ2
L3N5bmRiZy5jDQo+Pj4+Pj4gQEAgLTE0LDcgKzE0LDcgQEANCj4+Pj4+PiAgwqDCoMKgICNp
bmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4+Pj4+ICDCoMKgwqAgI2luY2x1ZGUg
Imh3L3FkZXYtcHJvcGVydGllcy5oIg0KPj4+Pj4+ICDCoMKgwqAgI2luY2x1ZGUgImh3L2xv
YWRlci5oIg0KPj4+Pj4+IC0jaW5jbHVkZSAiY3B1LmgiDQo+Pj4+Pj4gKyNpbmNsdWRlICJl
eGVjL3RhcmdldF9wYWdlLmgiDQo+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSAiaHcvaHlwZXJ2
L2h5cGVydi5oIg0KPj4+Pj4+ICDCoMKgwqAgI2luY2x1ZGUgImh3L2h5cGVydi92bWJ1cy1i
cmlkZ2UuaCINCj4+Pj4+PiAgwqDCoMKgICNpbmNsdWRlICJody9oeXBlcnYvaHlwZXJ2LXBy
b3RvLmgiDQo+Pj4+Pj4gQEAgLTE4OCw3ICsxODgsOCBAQCBzdGF0aWMgdWludDE2X3QgaGFu
ZGxlX3JlY3ZfbXNnKEh2U3luRGJnICpzeW5kYmcsDQo+Pj4+Pj4gdWludDY0X3Qgb3V0Z3Bh
LA0KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IHRpbWVvdXQsIHVpbnQzMl90
DQo+Pj4+Pj4gKnJldHJpZXZlZF9jb3VudCkNCj4+Pj4+PiAgwqDCoMKgIHsNCj4+Pj4+PiAg
wqDCoMKgwqDCoMKgwqAgdWludDE2X3QgcmV0Ow0KPj4+Pj4+IC3CoMKgwqAgdWludDhfdCBk
YXRhX2J1ZltUQVJHRVRfUEFHRV9TSVpFIC0gVURQX1BLVF9IRUFERVJfU0laRV07DQo+Pj4+
Pj4gK8KgwqDCoCBjb25zdCBzaXplX3QgYnVmX3NpemUgPSBxZW11X3RhcmdldF9wYWdlX3Np
emUoKSAtDQo+Pj4+Pj4gVURQX1BLVF9IRUFERVJfU0laRTsNCj4+Pj4+PiArwqDCoMKgIHVp
bnQ4X3QgKmRhdGFfYnVmID0gZ19hbGxvY2EoYnVmX3NpemUpOw0KPj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoCBod2FkZHIgb3V0X2xlbjsNCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgdm9pZCAq
b3V0X2RhdGE7DQo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIHNzaXplX3QgcmVjdl9ieXRlX2Nv
dW50Ow0KPj4+Pj4NCj4+Pj4+IFdlJ3ZlIHB1cmdlZCB0aGUgY29kZSBiYXNlIG9mIFZMQXMs
IGFuZCB0aG9zZSBhcmUgcHJlZmVyYWJsZSB0byBhbGxvY2EuDQo+Pj4+PiBKdXN0IHVzZSBn
X21hbGxvYyBhbmQgZ19hdXRvZnJlZS4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IEkgaGVzaXRhdGVk
LCBkdWUgdG8gcG90ZW50aWFsIHBlcmZvcm1hbmNlIGNvbnNpZGVyYXRpb25zIGZvciBwZW9w
bGUNCj4+Pj4gcmV2aWV3aW5nIHRoZSBwYXRjaC4gSSdsbCBzd2l0Y2ggdG8gaGVhcCBiYXNl
ZCBzdG9yYWdlLg0KPj4+DQo+Pj4gT1RPSCBoeXBlcnYgaXMgeDg2LW9ubHksIHNvIHdlIGNv
dWxkIGRvOg0KPj4+DQo+Pj4gI2RlZmluZSBCVUZTWiAoNCAqIEtpQikNCj4+Pg0KPj4+IGhh
bmRsZV9yZWN2X21zZygpDQo+Pj4gew0KPj4+ICDCoMKgwqAgdWludDhfdCBkYXRhX2J1ZltC
VUZTWiAtIFVEUF9QS1RfSEVBREVSX1NJWkVdOw0KPj4+ICDCoMKgwqAgLi4uDQo+Pj4NCj4+
PiBodl9zeW5kYmdfY2xhc3NfaW5pdCgpDQo+Pj4gew0KPj4+ICDCoMKgwqAgYXNzZXJ0KEJV
RlNaID4gcWVtdV90YXJnZXRfcGFnZV9zaXplKCkpOw0KPj4+ICDCoMKgwqAgLi4uDQo+Pj4N
Cj4+PiBhbmQgY2FsbCBpdCBhIGRheS4NCj4+DQo+PiBDb3VsZCBiZSBwb3NzaWJsZSBmb3Ig
bm93IHllcy4NCj4+DQo+PiBBbnkgb3BpbmlvbiBmcm9tIGNvbmNlcm5lZCBtYWludGFpbmVy
cz8NCj4gDQo+IEkgdGhpbmsgZXNzZW50aWFsbHkgaGFyZGNvZGluZyA0ayBwYWdlcyBpbiBo
eXBlcnYgaXMgb2theQ0KPiAod2l0aCBhbiBhcHByb3ByaWF0ZSBjaGVja2luZy9lbmZvcmNl
bWVudCBhc3NlcnRzKCkgb2YgY291cnNlKSwNCj4gc2luY2UgZXZlbiBpZiB0aGlzIGdldHMg
cG9ydGVkIHRvIEFSTTY0IGF0IHNvbWUgcG9pbnQNCj4gaXQgaXMgZ29pbmcgdG8gbmVlZCAq
YSBsb3QqIG9mIGNoYW5nZXMgYW55d2F5Lg0KPiANCg0KT2ssIEkgd2lsbCBoYXJkY29kZSB0
aGlzIGZvbGxvd2luZyBQaGlsaXBwZSBzdWdnZXN0aW9uIHRoZW4uDQoNCj4gVGhhbmtzLA0K
PiBNYWNpZWoNCj4gDQoNCg==


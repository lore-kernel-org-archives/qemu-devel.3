Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 10:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg0QS-0000wS-QG; Fri, 01 Mar 2024 05:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rg0QM-0000w3-VB
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:47:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rg0QL-0002JD-Av
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:47:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso1055391f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709290047; x=1709894847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQyTCQFFu4Gz99/zakxCtQx+i93eHI0kZ2+9IsC1EQc=;
 b=TFlVY/ckVNgKrhxuxfcX2s9T9vaQVIx8DWB/383PlMf137LpXp5tjkdOOe5EPnKquV
 0Ctk3DHVl47Ozh7milwzqGo2aEUjx9bBCOVLitnCK9fVyhD7xlTV5RmTF8LA2U5xHfeb
 vwG8lXp8YYDTpTLcLEJXr6IUigDSYbG9MZcuvxjR4YLVmlSkW5/kPruuGbnoea3NDh9l
 2Du6TzTWglROf7+I5d6DZlbmb9td2CtCl0McgSN4E5V3voo00I3YIQxkuTbz2wQXnLD8
 wvJ9S4SprzbisOFcCRzFIogggW/6uEt11Bbvd78/Gf3O94T1tuNcFEEMuWovY8+2y6mv
 Q8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709290047; x=1709894847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQyTCQFFu4Gz99/zakxCtQx+i93eHI0kZ2+9IsC1EQc=;
 b=c4q47xLU+OIoob44VMyTMfv0hxuXHaoULevZFDY63Kr8lWcvnNKtbaj1MD2WZMYPqk
 1OqweIRGhc77Sv2XoYF/ykr/U9Mq7cRpvZaTqU1svKw/loAJ9lHp4HKIgdhrL7RYsZ3O
 A2kESZtmjtI2szNxfOQPPYiFnEQeyODSywZIcyTLrGlVtHJty/1khhj10QCYtL7Q9M2u
 DxvrYhWRxOTTJJ17KTnjA6vnnT8u2OknQHBeC6ZRhdBNklwNnMqZN/7IHfCB2es+3haB
 YrHH4t4Zo9FBHotLRbWhJInlHnk68/wLVE65D3f6jptrjyNaXS2/AWizTSgaTZIUwAKH
 jbFA==
X-Gm-Message-State: AOJu0YxD5D08BBKLvaYSpXLbdTj5msZ8nNcHU8mr7UfOl4N81IXJppVK
 eFK/JoIfUh/w1Ebh3SwJdV7Ysfo3A8I8c5Jp53xNFBkP4WDFRMM3tBIcRfRO+UQ=
X-Google-Smtp-Source: AGHT+IHCtebZK7X9krcHumXlOFkLOZ1ih0AE4usmU9AZ7XMRhCXkHDk92MUdrOEjtSXmwUg8lP0/OA==
X-Received: by 2002:adf:ca89:0:b0:33d:754c:8daf with SMTP id
 r9-20020adfca89000000b0033d754c8dafmr1342804wrh.10.1709290047156; 
 Fri, 01 Mar 2024 02:47:27 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 j3-20020adff003000000b0033e01e397d6sm4210280wro.54.2024.03.01.02.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 02:47:26 -0800 (PST)
Message-ID: <4f7c818f-d887-4505-a0ba-9a45b17d2e63@linaro.org>
Date: Fri, 1 Mar 2024 14:47:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] tests/plugin/bb: migrate to new per_vcpu API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-9-pierrick.bouvier@linaro.org>
 <87o7bz9wrn.fsf@draig.linaro.org>
 <349de033-c966-4b99-a852-78b93a41e555@linaro.org>
 <87h6hq5ju8.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h6hq5ju8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMy8xLzI0IDI6MjYgUE0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gT24g
Mi8yOS8yNCA2OjIxIFBNLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPg0KPj4+IEkgZGlkIG5vdGljZSB0aGVyZSBpcyBhIGRpc2NyZXBhbmN5IGJldHdl
ZW4gd2hhdCBsaWJpc25zIGFuZCBsaWJiDQo+Pj4gcmVwb3J0LiBUaGUgbGliYiBsb29rcyBs
aWtlIGFuIG92ZXJjb3VudCBzbyBJIHdvbmRlciBpZiB0aGVyZSBhcmUgc29tZQ0KPj4+IGlu
c3RydWN0aW9ucyB3ZSBhcmUgbm90IHBpY2tpbmcgdXAgYnV0IEkgY2FuJ3Qgc2VlIHdoZXJl
IHRoYXQgd291bGQgYmUuDQo+Pj4gICAgIOKenCAgLi9xZW11LWhwcGEgLXBsdWdpbiAuL3Rl
c3RzL3BsdWdpbi9saWJpbnNuLnNvIC1wbHVnaW4NCj4+PiAuL3Rlc3RzL3BsdWdpbi9saWJi
Yi5zbyxpbmxpbmU9dHJ1ZSAtZCBwbHVnaW4NCj4+PiAuL3Rlc3RzL3RjZy9ocHBhLWxpbnV4
LXVzZXIvc2hhNTEyDQo+Pj4gICAgIDEuLjEwDQo+Pj4gICAgIG9rIDEgLSBkb190ZXN0KCZ0
ZXN0c1tpXSkNCj4+PiAgICAgb2sgMiAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBv
ayAzIC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDQgLSBkb190ZXN0KCZ0ZXN0
c1tpXSkNCj4+PiAgICAgb2sgNSAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBvayA2
IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDcgLSBkb190ZXN0KCZ0ZXN0c1tp
XSkNCj4+PiAgICAgb2sgOCAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBvayA5IC0g
ZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDEwIC0gZG9fdGVzdCgmdGVzdHNbaV0p
DQo+Pj4gICAgIENQVTA6IGJiJ3M6IDU0MjgyLCBpbnNuczogNzc1Njk3DQo+Pj4gICAgIFRv
dGFsOiBiYidzOiA1NDI4MiwgaW5zbnM6IDc3NTY5Nw0KPj4+ICAgICBjcHUgMCBpbnNuczog
Nzc0ODI3DQo+Pj4gICAgIHRvdGFsIGluc25zOiA3NzQ4MjcNCj4+PiBBbHRob3VnaCB3ZWly
ZGx5IG1heWJlIG9ubHkgYW4gaHBwYSB0aGluZy4gUmljaGFyZD8NCj4+Pg0KPj4NCj4+IERv
IHlvdSBvYnNlcnZlIHRoZSBleGFjdCBzYW1lIG51bWJlciBpZiB5b3UgcnVuIG9ubHkgb25l
IG9mIHRoZSBwbHVnaW4/DQo+Pg0KPj4gYmIgY291bnQgbnVtYmVyIG9mIGluc3RydWN0aW9u
cyBpbiBhbiBleGVjdXRlZCBibG9jaywgd2hpbGUgaW5zbg0KPj4gZWZmZWN0aXZlbHkgY291
bnQgZXZlcnkgaW5zdHJ1Y3Rpb25zIHJhbi4NCj4+IE1heWJlIHRoZXJlIGlzIGhwcGEgc3Bl
Y2lmaXR5IHRoYXQgbWFrZXMgc29tZSB0YiBleGl0IGluIHRoZSBtaWRkbGUsDQo+PiB0aHVz
IGV4ZWN1dGluZyBsZXNzIGluc3RydWN0aW9ucyB0aGFuIGV4cGVjdGVkIGZyb20gYmIgY291
bnQuDQo+IA0KPiBBbG1vc3QgY2VydGFpbmx5IC0gSSBqdXN0IHdhc24ndCBzdXJlIHdoYXQg
d291bGQgZG8gdGhhdCBvbiBzdHJhaWdodA0KPiBsaW5lIGNvZGUuIFByb2JhYmx5IHNvbWUg
ZnVua3kgYXNwZWN0IG9mIEhQUEEgSSdtIG5vdCBhd2FyZSBvZmYgOy0pDQo+IA0KPj4NCj4+
IEkgZG9uJ3Qga25vdyBob3cgdG8gcmVwcm9kdWNlIHRoaXMgdGVzdC4gRGlkIHlvdSBydW4g
aXQgZnJvbSBhDQo+PiBzcGVjaWZpYyBkb2NrZXIgZW52Pw0KPiANCj4gSWYgeW91IGhhdmUg
ZG9ja2VyIGVuYWJsZWQgdGhlICJtYWtlIGNoZWNrLXRjZyIgd2lsbCBidWlsZCBhbmQgdXNl
IGENCj4gY29udGFpbmVyIHRvIGJ1aWxkIHRoZSB0ZXN0IGNhc2VzLiBJZiB5b3UgYXJlIG9u
IGRlYmlhbiB5b3UganVzdCBuZWVkOg0KPiANCj4gICAgICBhcHQgaW5zdGFsbCBnY2MtaHBw
YS1saW51eC1nbnUgbGliYzYtZGV2LWhwcGEtY3Jvc3MNCj4gDQo+IGFuZCByZS1ydW4gY29u
ZmlndXJlLg0KPiANCg0KVGhhbmtzLg0KDQpUaGUgZGlmZmVyZW5jZSBvYnNlcnZlZCBwcmVk
YXRlcyB0aGlzIHNlcmllcywgc28gdGhlcmUgc2hvdWxkIGRlZmluaXRlbHkgDQpiZSBzb21l
dGhpbmcgc3BlY2lmaWMgdG8gdGhpcyBhcmNoLg0KDQo+Pg0KPj4+ICAgICDinpwgIC4vcWVt
dS1hYXJjaDY0IC1wbHVnaW4gLi90ZXN0cy9wbHVnaW4vbGliaW5zbi5zbyAtcGx1Z2luIC4v
dGVzdHMvcGx1Z2luL2xpYmJiLnNvLGlubGluZT10cnVlIC1kIHBsdWdpbiAgLi90ZXN0cy90
Y2cvYWFyY2g2NC1saW51eC11c2VyL3NoYTUxMg0KPj4+ICAgICAxLi4xMA0KPj4+ICAgICBv
ayAxIC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDIgLSBkb190ZXN0KCZ0ZXN0
c1tpXSkNCj4+PiAgICAgb2sgMyAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBvayA0
IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDUgLSBkb190ZXN0KCZ0ZXN0c1tp
XSkNCj4+PiAgICAgb2sgNiAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBvayA3IC0g
ZG9fdGVzdCgmdGVzdHNbaV0pDQo+Pj4gICAgIG9rIDggLSBkb190ZXN0KCZ0ZXN0c1tpXSkN
Cj4+PiAgICAgb2sgOSAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBvayAxMCAtIGRv
X3Rlc3QoJnRlc3RzW2ldKQ0KPj4+ICAgICBDUFUwOiBiYidzOiA0MTUxMywgaW5zbnM6IDMw
MjY3MQ0KPj4+ICAgICBUb3RhbDogYmInczogNDE1MTMsIGluc25zOiAzMDI2NzENCj4+PiAg
ICAgY3B1IDAgaW5zbnM6IDMwMjY3MQ0KPj4+ICAgICB0b3RhbCBpbnNuczogMzAyNjcxDQo+
Pj4gQW55d2F5Og0KPj4+IFJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVl
QGxpbmFyby5vcmc+DQo+Pj4NCj4gDQo=


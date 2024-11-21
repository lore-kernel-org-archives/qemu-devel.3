Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550F3E64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECSd-0005g1-16; Thu, 21 Nov 2024 14:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tECSZ-0005ap-Vc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:03:24 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tECSW-00073q-Gw
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:03:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-211fcadd960so9313205ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732215799; x=1732820599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UqPpd+IbtJeT0VhlDpvCQ1AMf22aum6w29og4Ma29m8=;
 b=fo1WBHe1kYvTs7oALEELRudVC8Y1R1IcOnaIP6txQd9XAHWBceLKBYDtmCWIKVPCWZ
 I/+ByVpCHt6yGOnSdAai9uCN3BdUnmIrESXDxrbnZ4P3i41owhUpjO3cZwsHp6tVgWDo
 piRgU2QmeoIf81McQTG/2WIYvz5RjBI0kgBdkoG/xN2bX4HSrBt3+DZNOoboMM15cOXB
 DDZjRwNoOxHsiTWG+wrOXOawmiFctnZb6adPRcLFi3VyoW1CjwBnAnKz8LBi8t1VJ6Gc
 tBbMeYV9bZuD2lfZ5SSF6H/2pCUPvtS2w7RXEXiCpeWA4rv2rrQS0/d1m6V5cvNKv744
 fTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215799; x=1732820599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UqPpd+IbtJeT0VhlDpvCQ1AMf22aum6w29og4Ma29m8=;
 b=mNZ6mAP7LrgvAtmQau5Mnn+mz7awky1aRt/febTtjpqNXqe7NzNdwQuq0sAdlJMyxI
 h8PxK6PDET+WefZKG8QBHFWyq/2lT/o5AOuV03rvhYHnAxbWdW7AVrDrNjzjsDn/Zhjj
 uWc5AA/HqHmbYOtRyLUx9wPHSPPcv0NVqQbdtX7+I1/sWdeZawZdApfPx0Ame6JVw3Tk
 D2qCwhdd/3viE7NB6FXZ3Xb34B5EAZ3PhgHHS/8fwdzumjAejCSgumVQWWXX94Ogia5h
 e9G2Id2cVXNi5vGQSTw4KAycZXA3zf5qxxLDOeU5ShW0CyCi3tQbbfIzyYv45I5ZNvNf
 6nIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH3Cw8gJMTEcukCbkrX9+5znbnd1R7MB9pzBaYbyTiIGPqLO6BmXqNYQ0kjGYeiL6VVrKx7qVUpirf@nongnu.org
X-Gm-Message-State: AOJu0Yxvauq54ylAp+/bWeMXA87VWAe2t+5JifieDa2E0L9iYDnkFhxs
 DPE/vimsuxMFopufFCp2W5vCK/oH44X13CEtdGHxLobQs9J6bdkRSirz7yB6wJw=
X-Gm-Gg: ASbGncv836BqfIQu2BcTVa0G3BiB4GxMdRKyrgokWXqaPhE8xODDQKEIjna5lOeiYdc
 0yxdiP9ekFi9WAukLsSq1bJNt26y0JHMiYgRuOVXnp8wlNXd8KcxcL4aBhvNgeW3cqWztwEYyQV
 arz/34FGJeG4e/cJDtW7F4d9EvEGAaFELmZuS86UdZEkI/GZCgdzxZNqF3L1/LtQv0VMtOBKAIu
 eyyYYA4fxlNcveVtnCLBYvmNxESnUq0EU42iz7uiqSp78D8xMRjILjV7UPV4IVUudYxig1nG6zH
 ZJRZHPIO6mI4bffjlbHjig==
X-Google-Smtp-Source: AGHT+IG5LrBxRjfabe2uc5HXPKig457aqJLeFY/PLXRzw00SCDy1j/V6h80nAREjT8tPT+CfDbrc4g==
X-Received: by 2002:a17:902:d547:b0:212:26e:7117 with SMTP id
 d9443c01a7336-2129f24bb1cmr3326375ad.33.1732215798723; 
 Thu, 21 Nov 2024 11:03:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dbf9853sm1656155ad.165.2024.11.21.11.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:03:18 -0800 (PST)
Message-ID: <c4f6be27-c0d1-49ee-82ed-36144c38bad2@linaro.org>
Date: Thu, 21 Nov 2024 11:03:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/39] tests/functional: remove comments talking about
 avocado
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241121165806.476008-8-alex.bennee@linaro.org>
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

T24gMTEvMjEvMjQgMDg6NTcsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gRnJvbTogRGFuaWVs
IFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gDQo+IFRoZSBmaXJzdCBj
b21tZW50IGlzIHN0aWxsIHJlbGV2YW50IGJ1dCBzaG91bGQgdGFsayBhYm91dCBvdXIgb3du
IHRlc3QNCj4gaGFybmVzcyBpbnN0ZWFkLiBUaGUgc2Vjb25kIGNvbW1lbnQgYWRkcyBubyB2
YWx1ZSBvdmVyIHJlYWRpbmcgdGhlIGNvZGUNCj4gYW5kIGNhbiBiZSByZW1vdmVkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0
LmNvbT4NCj4gTWVzc2FnZS1JZDogPDIwMjQxMTIxMTU0MjE4LjE0MjMwMDUtOC1iZXJyYW5n
ZUByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVu
bmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hY3Bp
X2JpdHMucHkgfCAxMyArKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9m
dW5jdGlvbmFsL3Rlc3RfYWNwaV9iaXRzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2Fj
cGlfYml0cy5weQ0KPiBpbmRleCBlZTQwNjQ3ZDViLi40YzE5MmQ5NWNjIDEwMDc1NQ0KPiAt
LS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWNwaV9iaXRzLnB5DQo+ICsrKyBiL3Rlc3Rz
L2Z1bmN0aW9uYWwvdGVzdF9hY3BpX2JpdHMucHkNCj4gQEAgLTE5NiwxMSArMTk2LDEyIEBA
IGRlZiBjb3B5X3Rlc3Rfc2NyaXB0cyhzZWxmKToNCj4gICAgICAgICAgIGZvciBmaWxlbmFt
ZSBpbiBvcy5saXN0ZGlyKGJpdHNfdGVzdF9kaXIpOg0KPiAgICAgICAgICAgICAgIGlmIG9z
LnBhdGguaXNmaWxlKG9zLnBhdGguam9pbihiaXRzX3Rlc3RfZGlyLCBmaWxlbmFtZSkpIGFu
ZCBcDQo+ICAgICAgICAgICAgICAgICAgZmlsZW5hbWUuZW5kc3dpdGgoJy5weTInKToNCj4g
LSAgICAgICAgICAgICAgICAjIGFsbCB0ZXN0IHNjcmlwdHMgYXJlIG5hbWVkIHdpdGggZXh0
ZW5zaW9uIC5weTIgc28gdGhhdA0KPiAtICAgICAgICAgICAgICAgICMgYXZvY2FkbyBkb2Vz
IG5vdCB0cnkgdG8gbG9hZCB0aGVtLiBUaGVzZSBzY3JpcHRzIGFyZQ0KPiAtICAgICAgICAg
ICAgICAgICMgd3JpdHRlbiBmb3IgcHl0aG9uIDIuNyBub3QgcHl0aG9uIDMgYW5kIGhlbmNl
IGlmIGF2b2NhZG8NCj4gLSAgICAgICAgICAgICAgICAjIGxvYWRlZCB0aGVtLCBpdCB3b3Vs
ZCBjb21wbGFpbiBhYm91dCBweXRob24gMyBzcGVjaWZpYw0KPiAtICAgICAgICAgICAgICAg
ICMgc3ludGF4ZXMuDQo+ICsgICAgICAgICAgICAgICAgIyBBbGwgdGVzdCBzY3JpcHRzIGFy
ZSBuYW1lZCB3aXRoIGV4dGVuc2lvbiAucHkyIHNvIHRoYXQNCj4gKyAgICAgICAgICAgICAg
ICAjIHRoZXkgYXJlIG5vdCBydW4gYnkgYWNjaWRlbnQuDQo+ICsgICAgICAgICAgICAgICAg
Iw0KPiArICAgICAgICAgICAgICAgICMgVGhlc2Ugc2NyaXB0cyBhcmUgaW50ZW5kZWQgdG8g
cnVuIGluc2lkZSB0aGUgdGVzdCBWTQ0KPiArICAgICAgICAgICAgICAgICMgYW5kIGFyZSB3
cml0dGVuIGZvciBweXRob24gMi43IG5vdCBweXRob24gMywgaGVuY2UNCj4gKyAgICAgICAg
ICAgICAgICAjIHdvdWxkIGNhdXNlIHN5bnRheCBlcnJvcnMgaWYgbG9hZGVkIG91c2lkZSB0
aGUgVk0uDQo+ICAgICAgICAgICAgICAgICAgIG5ld2ZpbGVuYW1lID0gb3MucGF0aC5zcGxp
dGV4dChmaWxlbmFtZSlbMF0gKyAnLnB5Jw0KPiAgICAgICAgICAgICAgICAgICBzaHV0aWwu
Y29weTIob3MucGF0aC5qb2luKGJpdHNfdGVzdF9kaXIsIGZpbGVuYW1lKSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG9zLnBhdGguam9pbih0YXJnZXRfdGVzdF9kaXIs
IG5ld2ZpbGVuYW1lKSkNCj4gQEAgLTM5OSw4ICs0MDAsNiBAQCBkZWYgdGVzdF9hY3BpX3Nt
Ymlvc19iaXRzKHNlbGYpOg0KPiAgIA0KPiAgICAgICAgICAgIyBiaW9zYml0cyBoYXMgYmVl
biBjb25maWd1cmVkIHRvIHJ1biBhbGwgdGhlIHNwZWNpZmllZCB0ZXN0IHN1aXRlcw0KPiAg
ICAgICAgICAgIyBpbiBiYXRjaCBtb2RlIGFuZCB0aGVuIGF1dG9tYXRpY2FsbHkgaW5pdGlh
dGUgYSB2bSBzaHV0ZG93bi4NCj4gLSAgICAgICAgIyBTZXQgdGltZW91dCB0byBCSVRTX1RJ
TUVPVVQgZm9yIFNIVVRET1dOIGV2ZW50IGZyb20gYml0cyBWTSBhdCBwYXINCj4gLSAgICAg
ICAgIyB3aXRoIHRoZSBhdm9jYWRvIHRlc3QgdGltZW91dC4NCj4gICAgICAgICAgIHNlbGYu
X3ZtLmV2ZW50X3dhaXQoJ1NIVVRET1dOJywgdGltZW91dD1CSVRTX1RJTUVPVVQpDQo+ICAg
ICAgICAgICBzZWxmLl92bS53YWl0KHRpbWVvdXQ9Tm9uZSkNCj4gICAgICAgICAgIHNlbGYu
bG9nZ2VyLmRlYnVnKCJDaGVja2luZyBjb25zb2xlIG91dHB1dCAuLi4iKQ0KDQpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
DQo=


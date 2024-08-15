Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeSN-0000KW-CX; Thu, 15 Aug 2024 13:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeSI-0008V5-1h
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:40:11 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeSF-00025l-2L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:40:09 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3bd8784d3so843291a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723743605; x=1724348405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Y2Ln0kZV2HBQKweaQhdwm4ciGNMxg36loFhH2xklYY=;
 b=drW2duguwh/DKZlo9tcdXWNNsLdga7S1bI25bm9tk4swOaDUpAPR9epbD81rFbDxHM
 KTL0P65L0ny3x9K3Xo/iiJPz8aQzZKOVLKpjca9o97NkYCnqsQhBIDux3md33ltEsryn
 TusrMxHGnVUFVoMzoQWPfsxSPwSvd8WwWYsv/mR5ZhrFgoKdioIC/4Gmu5SiTlYtGh2E
 Xb4RKmL8KJcQnnCRC0y3wtsNVo9lLnK8pgUGiH6PrwnjbUprTYHxZ/22hCJ2I1Y055j9
 mfK7RUDGnZ5hJ4c+jZP/uH7zCMixrr8WwTJtwlB/YC8P/vCVRcKbfy43YKyCoE9IAUta
 QBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723743605; x=1724348405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Y2Ln0kZV2HBQKweaQhdwm4ciGNMxg36loFhH2xklYY=;
 b=jwV3UHyjxh7upiR7Y+eYDc2c8ZykJpl9q0yMIzM15Yx+jaUeKJe2UbXb3pj3FGH5IZ
 2UXGOGzK3ZMC8djCYY5/UGO69RIUtNFTLkpvvoGwqEeq4lZNw+hsUwwc+nuzIa8G8pFY
 IF8qBx1sgwFxnzYv1RE5jPtLEn+xoxwhqSpdk6yEInW07S/Sjt1Z+uGDfvaSvK/ySqJe
 aOv0UXguWwYbP3l5JxdKZea1yzRVX1hLNdWl0rOIvTytrtBAGV7MqqKNSYT7C+k/ktTm
 +QgRNjMNZVQRran3Ps/gSHNn20TpnYXIb0NoUsg226LBCHHEns4moaLybs0wkBaBpfSo
 F9Ag==
X-Gm-Message-State: AOJu0Yyak5IncXKrFg12Hy8WDM15IN5GP61CMxgOEgZhKs9/3FTWjDH/
 ObdpZy+dRTQj7oXtjQOyhf9goLuK1HPzKw0SQN7LEu2p0WoTUtu8cS+4afh3IRmKTrVRFs/rXER
 eJqI=
X-Google-Smtp-Source: AGHT+IFh0AR4Z0D7GuY9NBOPOJRdibTAO6wpnwl777oY+ytEL3Frb0xvPTk3XZi1Gsj9+uqebmHIlQ==
X-Received: by 2002:a17:90a:fa49:b0:2c9:63e9:845b with SMTP id
 98e67ed59e1d1-2d3dfc22c62mr432497a91.9.1723743605392; 
 Thu, 15 Aug 2024 10:40:05 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7f35a3sm3808304a91.25.2024.08.15.10.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:40:04 -0700 (PDT)
Message-ID: <62b8e9a8-67cf-48df-9b5c-9bfcfb10e9fd@linaro.org>
Date: Thu, 15 Aug 2024 10:40:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] contrib/plugins/hwprofile: fix warning when compiling
 on 32bits host
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-4-pierrick.bouvier@linaro.org>
 <353d0b10-8a7a-4660-a22c-f3dcb35df89e@redhat.com>
 <87plqa2dsm.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87plqa2dsm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

T24gOC8xNS8yNCAwNTowMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaG9tYXMgSHV0aCA8
dGh1dGhAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPiANCj4+IE9uIDE1LzA4LzIwMjQgMDEuMzYs
IFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gRm91bmQgb24gZGViaWFuIHN0YWJsZSAo
aTM4NikuDQo+Pj4gLi4vY29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jOiBJbiBmdW5jdGlv
biAnbmV3X2xvY2F0aW9uJzoNCj4+PiAuLi9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmM6
MTcyOjMyOiBlcnJvcjogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJl
bnQgc2l6ZSBbLVdlcnJvcj1pbnQtdG8tcG9pbnRlci1jYXN0XQ0KPj4+ICAgICAxNzIgfCAg
ICAgZ19oYXNoX3RhYmxlX2luc2VydCh0YWJsZSwgKGdwb2ludGVyKSBvZmZfb3JfcGMsIGxv
Yyk7DQo+Pj4gICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
Pj4gLi4vY29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jOiBJbiBmdW5jdGlvbiAndmNwdV9o
YWRkcic6DQo+Pj4gLi4vY29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jOjIyNzoxOTogZXJy
b3I6IGNhc3QgZnJvbSBwb2ludGVyIHRvIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1X
ZXJyb3I9cG9pbnRlci10by1pbnQtY2FzdF0NCj4+PiAgICAgMjI3IHwgICAgICAgICAgICAg
b2ZmID0gKHVpbnQ2NF90KSB1ZGF0YTsNCj4+PiAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgXg0KPj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9od3Byb2ZpbGUuYzoyMzI6NjI6IGVycm9y
OiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2Vy
cm9yPWludC10by1wb2ludGVyLWNhc3RdDQo+Pj4gICAgIDIzMiB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZ3BvaW50
ZXIpIG9mZik7DQo+Pj4gICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+Pj4gLi4vY29udHJpYi9wbHVn
aW5zL2h3cHJvZmlsZS5jOiBJbiBmdW5jdGlvbiAndmNwdV90Yl90cmFucyc6DQo+Pj4gLi4v
Y29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jOjI1MDoyNjogZXJyb3I6IGNhc3QgdG8gcG9p
bnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1XZXJyb3I9aW50LXRvLXBv
aW50ZXItY2FzdF0NCj4+PiAgICAgMjUwIHwgICAgICAgICBncG9pbnRlciB1ZGF0YSA9IChn
cG9pbnRlcikgKHNvdXJjZSA/IHFlbXVfcGx1Z2luX2luc25fdmFkZHIoaW5zbikgOiAwKTsN
Cj4+PiAgICAgICAgIHwNCj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gICAgY29udHJpYi9w
bHVnaW5zL2h3cHJvZmlsZS5jIHwgOSArKysrKy0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4+IGRpZmYgLS1naXQgYS9j
b250cmliL3BsdWdpbnMvaHdwcm9maWxlLmMNCj4+PiBiL2NvbnRyaWIvcGx1Z2lucy9od3By
b2ZpbGUuYw0KPj4+IGluZGV4IDczOWFjMGM2NmI1Li5lZTk0YTc0YWQ5NCAxMDA2NDQNCj4+
PiAtLS0gYS9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmMNCj4+PiArKysgYi9jb250cmli
L3BsdWdpbnMvaHdwcm9maWxlLmMNCj4+PiBAQCAtMTY1LDcgKzE2NSw3IEBAIHN0YXRpYyBE
ZXZpY2VDb3VudHMgKm5ld19jb3VudChjb25zdCBjaGFyICpuYW1lLCB1aW50NjRfdCBiYXNl
KQ0KPj4+ICAgICAgICByZXR1cm4gY291bnQ7DQo+Pj4gICAgfQ0KPj4+ICAgIC1zdGF0aWMg
SU9Mb2NhdGlvbkNvdW50cyAqbmV3X2xvY2F0aW9uKEdIYXNoVGFibGUgKnRhYmxlLCB1aW50
NjRfdA0KPj4+IG9mZl9vcl9wYykNCj4+PiArc3RhdGljIElPTG9jYXRpb25Db3VudHMgKm5l
d19sb2NhdGlvbihHSGFzaFRhYmxlICp0YWJsZSwgdWludHB0cl90IG9mZl9vcl9wYykNCj4+
PiAgICB7DQo+Pj4gICAgICAgIElPTG9jYXRpb25Db3VudHMgKmxvYyA9IGdfbmV3MChJT0xv
Y2F0aW9uQ291bnRzLCAxKTsNCj4+PiAgICAgICAgbG9jLT5vZmZfb3JfcGMgPSBvZmZfb3Jf
cGM7DQo+Pj4gQEAgLTIwMSw3ICsyMDEsNyBAQCBzdGF0aWMgdm9pZCB2Y3B1X2hhZGRyKHVu
c2lnbmVkIGludCBjcHVfaW5kZXgsIHFlbXVfcGx1Z2luX21lbWluZm9fdCBtZW1pbmZvLA0K
Pj4+ICAgICAgICAgICAgcmV0dXJuOw0KPj4+ICAgICAgICB9IGVsc2Ugew0KPj4+ICAgICAg
ICAgICAgY29uc3QgY2hhciAqbmFtZSA9IHFlbXVfcGx1Z2luX2h3YWRkcl9kZXZpY2VfbmFt
ZShod2FkZHIpOw0KPj4+IC0gICAgICAgIHVpbnQ2NF90IG9mZiA9IHFlbXVfcGx1Z2luX2h3
YWRkcl9waHlzX2FkZHIoaHdhZGRyKTsNCj4+PiArICAgICAgICB1aW50cHRyX3Qgb2ZmID0g
cWVtdV9wbHVnaW5faHdhZGRyX3BoeXNfYWRkcihod2FkZHIpOw0KPj4NCj4+IHFlbXVfcGx1
Z2luX2h3YWRkcl9waHlzX2FkZHIoKSByZXR1cm5zIGFuIHVpbnQ2NF90LCBzbyB0aGlzIGxv
b2tzDQo+PiB3cm9uZyB0byBtZS4NCj4gDQo+IEl0IGlzLiBIb3dldmVyIGl0IGp1c3QgZ29l
cyB0byBzaG93IHlvdSBzaG91bGQgYmUgZXhwZWN0aW5nIHRvDQo+IGluc3RydW1lbnQgNjQg
Yml0IGNvZGUgd2l0aCBhIDMyIGJpdCBob3N0IGJlY2F1c2UgeW91IGNhbid0IGRvIHBvaW50
ZXINCj4gc3R1ZmZpbmcgdHJpY2tzIGxpa2UgdGhpcy4NCj4gDQo+IE1heWJlIHdlIGNvdWxk
IGp1c3QgZGlzYWJsZSBwbHVnaW5zIG9uIDMyIGJpdCBob3N0cz8NCj4gDQoNCk9ubHkgdHdv
IHBsdWdpbnMgYXJlIGNvbmNlcm5lZCBieSB0aGlzIHByb2JsZW0sIGl0J3Mgd29ydGggZml4
aW5nIHRoZW0gDQpjb3JyZWN0bHkgKGkuZS4gbm90IHVzZSA2NCBiaXRzIGRhdGEgZGlyZWN0
bHkgYXMgYSBwb2ludGVyLCBidXQgYWxsb2NhdGUgDQptZW1vcnkgYW5kIHBhc3MgcG9pbnRl
ciBpbnN0ZWFkKS4NCg0KPj4NCj4+ICAgVGhvbWFzDQo+IA0K


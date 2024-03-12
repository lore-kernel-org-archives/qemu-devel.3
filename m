Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB07C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwhR-0006Fc-Ar; Tue, 12 Mar 2024 03:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwhP-0006FQ-6C
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:37:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjwhN-00014g-Ck
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:37:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4133847e47bso1690295e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710229039; x=1710833839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zn8xCfEUYb9RFH2pGBsSo1ftBEy41+u3Ql5+iz/Ca58=;
 b=rwC/uFWhk9+ZwSAJuLZEGGS4Xo0CiUEP7FcL93t5Y2qlwtiN0vKO0EV33m7AVed3nU
 HB8QlpWbdyaCdb6eDjTYIich42P3Km1MQZJQV92CQggfkzcx2wPFS6HP+2+OSu6mMusx
 EOiBlay2oQIHGeQNXBhFW4n6dJSL8DK4aWAAo29DPQ80Acs9Gjx704zEhtpcpQBfWUwp
 sYRZA9ETWJ+glBDkVASycUrg/RVfaHIcggYU5aE9L+4U+yaTsEz3ukeSWlOKbiC4VvVQ
 FxseIlYCKr9HSJZuIkwCZHJ8HcGE3j0wUN2PdvT23or5LEL0aXr7lDs6IGVknRhhAtDX
 F8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710229039; x=1710833839;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zn8xCfEUYb9RFH2pGBsSo1ftBEy41+u3Ql5+iz/Ca58=;
 b=ZyJGLo42xXr9g7+aVTpmyQdLkLRbudCElLxBOnJfxDskvTBkmDXB6k4ij4qUF5ed0P
 CLU3UN/eWUMQ3VADuleC2dMkAiZzTYPi8YABTGhO91Mlbkm6kNbZlA56sRY8fD3WKdm5
 FxLKgFTmBYdBgfRjkcFSeaOR5Ok93DiXC++sV80p5RgnQ7STXORk7sdw98lXz/ConZil
 sOkUj/+e9dBRzorAroo1CoDb/xgcSEPyJEx9//MXlhRSo5pcUbBJhfY1WVtEIIZHA/J0
 0yPxwdFcV7/zRq8kkWO2+VNZQduOV7brCAYMLN6KHZ4UOPAwvR64ZroI9cv1/zzvCvEs
 1cmg==
X-Gm-Message-State: AOJu0Yy07kCyBF8+M8B9sltqFFIVN6Lb5heuNBJA7AZHlQGu71L1pzjZ
 Yi/AreFQQ+SZPHkb5g4C09cppb9keg7M4GuBIv0jeX4xvDzNgEZy0VKOPN8kTqw=
X-Google-Smtp-Source: AGHT+IHfLBo2DfzzBX5Qe+aEtD+gbRtWKt+K7tdohO+E8SZrgqTpdKYe7tJCXZviqZDQ7n9K9PKa8w==
X-Received: by 2002:a05:600c:524d:b0:413:271d:8889 with SMTP id
 fc13-20020a05600c524d00b00413271d8889mr4219352wmb.11.1710229038804; 
 Tue, 12 Mar 2024 00:37:18 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 fa11-20020a05600c518b00b0041336a5eb6bsm1202252wmb.25.2024.03.12.00.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 00:37:18 -0700 (PDT)
Message-ID: <0698b4f7-e563-49f4-88cd-cf917a520551@linaro.org>
Date: Tue, 12 Mar 2024 11:37:14 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
 <87zfv4pydu.fsf@draig.linaro.org>
 <595d141e-67d7-46c0-8471-fc52f2d4af0f@linaro.org>
In-Reply-To: <595d141e-67d7-46c0-8471-fc52f2d4af0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x333.google.com
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

T24gMy8xMi8yNCAxMDowMywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMy8xMS8y
NCAxOTo0MywgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pg0KPj4+IEV4dGVuZCBwbHVn
aW5zIEFQSSB0byBzdXBwb3J0IGNhbGxiYWNrIGNhbGxlZCB3aXRoIGEgZ2l2ZW4gY3JpdGVy
aWENCj4+PiAoZXZhbHVhdGVkIGlubGluZSkuDQo+Pj4NCj4+PiBBZGRlZCBmdW5jdGlvbnM6
DQo+Pj4gLSBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNfY29uZF9jYg0KPj4+
IC0gcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9pbnNuX2V4ZWNfY29uZF9jYg0KPj4+DQo+
Pj4gVGhleSBleHBlY3QgYXMgcGFyYW1ldGVyIGEgY29uZGl0aW9uLCBhIHFlbXVfcGx1Z2lu
X3U2NF90IChvcDEpIGFuZCBhbg0KPj4+IGltbWVkaWF0ZSAob3AyKS4gQ2FsbGJhY2sgaXMg
Y2FsbGVkIGlmIG9wMSB8Y29uZHwgb3AyIGlzIHRydWUuDQo+Pj4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+
PiA8c25pcD4NCj4+PiAgICANCj4+PiArc3RhdGljIFRDR0NvbmQgcGx1Z2luX2NvbmRfdG9f
dGNnY29uZChlbnVtIHFlbXVfcGx1Z2luX2NvbmQgY29uZCkNCj4+PiArew0KPj4+ICsgICAg
c3dpdGNoIChjb25kKSB7DQo+Pj4gKyAgICBjYXNlIFFFTVVfUExVR0lOX0NPTkRfRVE6DQo+
Pj4gKyAgICAgICAgcmV0dXJuIFRDR19DT05EX0VROw0KPj4+ICsgICAgY2FzZSBRRU1VX1BM
VUdJTl9DT05EX05FOg0KPj4+ICsgICAgICAgIHJldHVybiBUQ0dfQ09ORF9ORTsNCj4+PiAr
ICAgIGNhc2UgUUVNVV9QTFVHSU5fQ09ORF9MVDoNCj4+PiArICAgICAgICByZXR1cm4gVENH
X0NPTkRfTFRVOw0KPj4+ICsgICAgY2FzZSBRRU1VX1BMVUdJTl9DT05EX0xFOg0KPj4+ICsg
ICAgICAgIHJldHVybiBUQ0dfQ09ORF9MRVU7DQo+Pj4gKyAgICBjYXNlIFFFTVVfUExVR0lO
X0NPTkRfR1Q6DQo+Pj4gKyAgICAgICAgcmV0dXJuIFRDR19DT05EX0dUVTsNCj4+PiArICAg
IGNhc2UgUUVNVV9QTFVHSU5fQ09ORF9HRToNCj4+PiArICAgICAgICByZXR1cm4gVENHX0NP
TkRfR0VVOw0KPj4+ICsgICAgZGVmYXVsdDoNCj4+PiArICAgICAgICAvKiBBTFdBWVMgYW5k
IE5FVkVSIGNvbmRpdGlvbnMgc2hvdWxkIG5ldmVyIHJlYWNoICovDQo+Pj4gKyAgICAgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4+PiArICAgIH0NCj4+PiArfQ0KPj4+ICsNCj4+
PiArc3RhdGljIFRDR09wICphcHBlbmRfY29uZF91ZGF0YV9jYihjb25zdCBzdHJ1Y3QgcWVt
dV9wbHVnaW5fZHluX2NiICpjYiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBUQ0dPcCAqYmVnaW5fb3AsIFRDR09wICpvcCwgaW50ICpjYl9pZHgpDQo+Pj4g
K3sNCj4+PiArICAgIGNoYXIgKnB0ciA9IGNiLT5jb25kX2NiLmVudHJ5LnNjb3JlLT5kYXRh
LT5kYXRhOw0KPj4+ICsgICAgc2l6ZV90IGVsZW1fc2l6ZSA9IGdfYXJyYXlfZ2V0X2VsZW1l
bnRfc2l6ZSgNCj4+PiArICAgICAgICBjYi0+Y29uZF9jYi5lbnRyeS5zY29yZS0+ZGF0YSk7
DQo+Pj4gKyAgICBzaXplX3Qgb2Zmc2V0ID0gY2ItPmNvbmRfY2IuZW50cnkub2Zmc2V0Ow0K
Pj4+ICsgICAgLyogQ29uZGl0aW9uIHNob3VsZCBiZSBuZWdhdGVkLCBhcyBjYWxsaW5nIHRo
ZSBjYiBpcyB0aGUgImVsc2UiIHBhdGggKi8NCj4+PiArICAgIFRDR0NvbmQgY29uZCA9IHRj
Z19pbnZlcnRfY29uZChwbHVnaW5fY29uZF90b190Y2djb25kKGNiLT5jb25kX2NiLmNvbmQp
KTsNCj4+PiArDQo+Pj4gKyAgICBvcCA9IGNvcHlfY29uc3RfcHRyKCZiZWdpbl9vcCwgb3As
IHB0cik7DQoNClRoaXMgbGluZSB3YXMgd3JvbmcsIGFuZCBjYi0+dXNlcnAgc2hvdWxkIGJl
IGNvcGllZCBpbnN0ZWFkLg0KSSdsbCBmaXggdGhpcywgYWRkIGEgdGVzdCBzcGVjaWZpY2Fs
bHkgY2hlY2tpbmcgdWRhdGEgZm9yIGNvbmRpdGlvbmFsIA0KY2FsbGJhY2sgYW5kIHJlc2Vu
ZCB0aGUgc2VyaWVzLg0KDQo+Pj4gKyAgICBvcCA9IGNvcHlfbGRfaTMyKCZiZWdpbl9vcCwg
b3ApOw0KPj4+ICsgICAgb3AgPSBjb3B5X211bF9pMzIoJmJlZ2luX29wLCBvcCwgZWxlbV9z
aXplKTsNCj4+PiArICAgIG9wID0gY29weV9leHRfaTMyX3B0cigmYmVnaW5fb3AsIG9wKTsN
Cj4+PiArICAgIG9wID0gY29weV9jb25zdF9wdHIoJmJlZ2luX29wLCBvcCwgcHRyICsgb2Zm
c2V0KTsNCj4+PiArICAgIG9wID0gY29weV9hZGRfcHRyKCZiZWdpbl9vcCwgb3ApOw0KPj4+
ICsgICAgb3AgPSBjb3B5X2xkX2k2NCgmYmVnaW5fb3AsIG9wKTsNCj4+PiArICAgIG9wID0g
Y29weV9icmNvbmRpX2k2NCgmYmVnaW5fb3AsIG9wLCBjb25kLCBjYi0+Y29uZF9jYi5pbW0p
Ow0KPj4+ICsgICAgb3AgPSBjb3B5X2NhbGwoJmJlZ2luX29wLCBvcCwgY2ItPmYudmNwdV91
ZGF0YSwgY2JfaWR4KTsNCj4+PiArICAgIG9wID0gY29weV9zZXRfbGFiZWwoJmJlZ2luX29w
LCBvcCk7DQo+Pj4gKyAgICByZXR1cm4gb3A7DQo+Pg0KPj4gSSB0aGluayB3ZSBhcmUgbWlz
c2luZyBzb21ldGhpbmcgaGVyZSB0byBlbnN1cmUgdGhhdCB1ZGF0YSBpcyBzZXQNCj4+IGNv
cnJlY3RseSBmb3IgdGhlIGNhbGxiYWNrLCBzZWUgbXkgUkZDOg0KPj4NCj4+ICAgICBTdWJq
ZWN0OiBbUkZDIFBBVENIXSBjb250cmliL3BsdWdpbnM6IGNvbnRyb2wgZmxvdyBwbHVnaW4g
KFdJUCEpDQo+PiAgICAgRGF0ZTogTW9uLCAxMSBNYXIgMjAyNCAxNTozNDozMiArMDAwMA0K
Pj4gICAgIE1lc3NhZ2UtSWQ6IDwyMDI0MDMxMTE1MzQzMi4xMzk1MTkwLTEtYWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4NCj4+DQo+PiB3aGljaCBpcyBzZWVpbmcgdGhlIHNhbWUgdmFsdWUg
ZXZlcnkgdGltZSBpbiB0aGUgY2FsbGJhY2suDQo+Pg0KPiANCj4gSSdtIHRyeWluZyB0byBy
ZXByb2R1Y2UgYW5kIHdpbGwgYW5zd2VyIG9uIHRoaXMgdGhyZWFkLg0K


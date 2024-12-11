Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059EE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLCWf-0001R1-D8; Tue, 10 Dec 2024 21:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLCWQ-0001QQ-T0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:32:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLCWP-0003fJ-5c
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:32:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21680814d42so8237425ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 18:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733884335; x=1734489135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GxZzVP+gaZrUVSyqjD///S+dVpZXpbJsc5Bv4a1zoQ=;
 b=ifgqTP8X4VGtUjMm5Jt6E40S8vUJyQ4MjOzJoJpv+aVE3cJl4qysxZcalouXFI3KfR
 90g7ChqxDQJepbQz5iyLWUKctqMd++hHonAQ2sV5YSlq3EDl6f+QmW9yCXAJATBosqV6
 uSdqeRS7UcXhOXz38TEPICSeNlqALYHaSCHUi0/+BwOMta0mIubaRNjVRyAw1FoNVHsh
 z1F5cmOAuMR+kurwIAXuJSGJaOJUt8h+kH/YmaPDsiB6w0BtAdiYdPPDvvk8GG+pSo2D
 +vpurS0BwIls63/PUOQ/RMz1wooDE8GJ5YSjqakSGdSfYw0Xkyj5Ujxnt9G7BSTZHa8d
 s6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733884335; x=1734489135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GxZzVP+gaZrUVSyqjD///S+dVpZXpbJsc5Bv4a1zoQ=;
 b=ZmKYKFjxJaef/YWtyaCbjeBO/caesUCLeeT97fjPn7fjTdBSyU6aFKDRJCi9HKybrl
 25J153/esbBNV594p6am42httjh/y4Jwsj2qNWDbkJuLvvidkIr37n5Iebf7q5suXNKd
 mazSOFZSfiIHhSZiIImORdeMkidG/aVy8MBePcSArKU6RC/iQy3DTQN/3SnEbNpheuCf
 8c8oF98xAwsf0DGf4wC/RNESm/FBQCvg2Fix3VSeQrV4EiCc4FLo2VjXC5WUWbX2Wf1z
 AzF6a5O1MnSgxGtlwpCgw9efxPkzpJ2zRodKV93DXMYjsJuXZpitn4Ut2LquH4IvduKp
 gIIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpezSHhMp4C6oguU0jjgINRwL9YflEtHRerHhQX7TMxZFgUqMTKgtlBHoLYaaW1f2OzLyrxHxd+++O@nongnu.org
X-Gm-Message-State: AOJu0YzBnYmZF/DHe1KCih15/mOo2+a6xHQpo9W62g7yTJZYGYxSfSTb
 dT14KYRClyGVKdlZM0CaAHF+7MN7m0PhYZZUgMJiMEnEZB5qsZGfglE+TWoeAlc=
X-Gm-Gg: ASbGncvgMsIjGTwET6kuBLBYhFz/oDwwkVKUhRDuUN5kZuTTxcz4Rr94dixLXVhOZgt
 4hcc9Z5CfNYcFqwM3Wa2F2uaSWCQVNU056JzTmW7D5rzT6STJp5CjOW4InSnb5E89NqZaB1fqg+
 KEAKZY/48Dl9DdZb7YcA1+pIXhoq/NG3Z2OK52L6nl3sH6RT8FzjSuCNUa4x8rrTTcV7ilo7QIJ
 aXycG5xSGizuVHVxh/afevFHh/loTptp//fRaTOgHoTud9FDMMPohAFJDeA+Yzf+hkl6FTLTEbe
 pGB09U5wPkZr2zfbV4U0WiyyjQ==
X-Google-Smtp-Source: AGHT+IEqFDIT6xfvEA+JPXYS92pAbRRKlq13sQTtP5VpGPnGLn+a6ZmmW2k1PnJRnVSduuzQBaC86A==
X-Received: by 2002:a17:903:94e:b0:216:325f:6f2b with SMTP id
 d9443c01a7336-217783b7c17mr22203945ad.21.1733884335323; 
 Tue, 10 Dec 2024 18:32:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216460ee31bsm47361945ad.63.2024.12.10.18.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 18:32:14 -0800 (PST)
Message-ID: <06bad7a0-0a9b-485a-8df8-b9d7c73d792d@linaro.org>
Date: Tue, 10 Dec 2024 18:32:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] tests/functional/aarch64: add tests for FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-16-alex.bennee@linaro.org>
 <5d3c9f41-a6cd-4129-a08c-fdd1181e299d@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5d3c9f41-a6cd-4129-a08c-fdd1181e299d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMTIvMTAvMjQgMTQ6MTUsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMi8x
MC8yNCAxNDo0MywgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gRnJvbTogUGllcnJpY2sgQm91
dmllcjxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pg0KPj4gVGhpcyBib290IGFu
IE9QLVRFRSBlbnZpcm9ubWVudCwgYW5kIGxhdW5jaCBhIG5lc3RlZCBndWVzdCBWTSBpbnNp
ZGUgaXQNCj4+IHVzaW5nIHRoZSBSZWFsbXMgZmVhdHVyZS4gV2UgZG8gaXQgZm9yIHZpcnQg
YW5kIHNic2EtcmVmIHBsYXRmb3Jtcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmlj
ayBCb3V2aWVyPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+DQo+PiAtLS0tLQ0K
Pj4NCj4+IHYyOg0KPj4gLSBtb3ZlIHRlc3QgdG8gaXRzIG93biBmaWxlDQo+PiAtIGFkZCBz
YnNhIHRlc3QNCj4+IC0gY2hlY2sgb3V0cHV0IG9mIGBjY2Etd29ya2xvYWQtYXR0ZXN0YXRp
b24gcmVwb3J0YA0KPj4NCj4+IHYzOg0KPj4gLSBidWlsZCBhbmQgcnVuIHRlc3Qgd2l0aCBj
Y2EtdjQgaW1hZ2VzDQo+PiAtIGZhY3Rvcml6ZSBuZXN0ZWQgZ3Vlc3QgdGVzdCBiZXR3ZWVu
IGJvdGggdGVzdHMNCj4+IC0gcmVtb3ZlIGFjY2VsIHRjZyBvcHRpb24gYXMgaXQgaXMgdGhl
IGRlZmF1bHQgd2hlbiBydW5uaW5nIHRlc3RzDQo+PiBOb3RlOiBJdCdzIGEgbG9uZyB0ZXN0
IGFuZCB0aGVyZSBpcyBhIHdvcmsgaW4gcHJvZ3Jlc3MgdG8gdW5kZXJzdGFuZCB3aHkNCj4+
IGRlYnVnIGJ1aWxkIGlzIHNvIHNsb3cgKHgxMiB2cyBvcHRpbWl6ZWQpLg0KPj4NCj4+IHY0
Og0KPj4gLSB1c2UgcGF1dGgtaW1wZGVmPW9uIHRvIHNwZWVkIHVwIGJ1aWxkIHRpbWUgZXhl
Y3V0aW9uICh4Mi41IGZhc3RlcikNCj4+IC0gaW5jcmVhc2UgdGltZW91dCB2YWx1ZQ0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXI8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPg0KPj4gTWVzc2FnZS1JZDo8MjAyNDEyMDMyMTM2MjkuMjQ4MjgwNi0xLXBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVu
bsOpZTxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgICB0ZXN0cy9mdW5j
dGlvbmFsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICAgNCArDQo+PiAgICB0ZXN0
cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9ybWVfc2JzYXJlZi5weSB8ICA3MCArKysrKysr
KysrKysrDQo+PiAgICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9ybWVfdmlydC5w
eSAgICB8IDEwMCArKysrKysrKysrKysrKysrKysrDQo+PiAgICAzIGZpbGVzIGNoYW5nZWQs
IDE3NCBpbnNlcnRpb25zKCspDQo+PiAgICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVu
Y3Rpb25hbC90ZXN0X2FhcmNoNjRfcm1lX3Nic2FyZWYucHkNCj4+ICAgIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9ybWVfdmlydC5weQ0KPiAN
Cj4gUGllcnJpY2sncyBjaGFuZ2Vsb2cgZGlkbid0IGdldCBjdXQgd2hpbGUgYXBwbHlpbmcu
DQo+IA0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc+DQo+IA0KPiByfg0KPiANCg0KSXMgaXQgYmVjYXVzZSB0aGUgc3Ry
aW5nIG1hcmtlciBzdHJpbmcgaXMgbG9uZ2VyIHRoYW4gIi0tLSI/DQpJJ2xsIHBheSBhdHRl
bnRpb24gdG8gdGhhdCBuZXh0IHRpbWUgaWYgaXQncyB0aGUgcmVhc29uLg0K


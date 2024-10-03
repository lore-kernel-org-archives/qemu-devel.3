Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A35CF34C8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTPj-0005l5-CN; Thu, 03 Oct 2024 17:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swTPf-0005kA-3Z
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:31:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swTPc-00065i-AH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:31:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b78ee6298so9121245ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991063; x=1728595863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4B361wxAFVRbvhVHWi1pgIVtEGILyIVUI91bqrA+uiU=;
 b=WcfkYl7v2DjVmXjW+HWpzGRGatwkEKKZMzG2xlALlzP44LBFLEpJRmfN0yyIMiC+uF
 dzkGZppbiowJQj1L9MAEHwIJTkCJcPph91Kgr97JdC10teZZYwUFsQzT3VowVXGmtvA0
 xA3YXFo6CgoAkgivCv18RH8jrJUamElHR+PaAx6TAAFseyyYGQdYA/VqspCCXANec9fB
 cGIz1Cq6HDy4nT3v9OOzG3hATQkHiH4Ao17cc48nUTRoxsBeUIvqZ6w2+zmH6W8FfqEv
 rJDWv4cJWwO98ooVpw4ls3pqQTu+XIKnfyWtguoxfnRrnBp4/fzF77F4kHd/GSq+s4a+
 T+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991063; x=1728595863;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4B361wxAFVRbvhVHWi1pgIVtEGILyIVUI91bqrA+uiU=;
 b=qs2gb06HfW3oht0BL/bPeqgU/c1JPDN886+TIHp1I+i6SbsUNS9fSreFtyKD9trfUS
 Al4dHn9jHX+6ZKIbmmbHEHqU/Hf8YwHW63k54hJyLKg9eTzISoEiouA9+E2eInkyUaSq
 P8fM8kqiMmd4Qq43ZDPkUo/kHzfp2aSkEAGbJmtPJmfo08xeR+L08N0RX08bwTvqGxLn
 idrgv7W0GlxgugOwGl2usNiOanMZs4DKe85F4KYYGnmTPkvrJSIH9g0+NKp2WaQP0E8j
 i4BLCLt5AYK1YDee0ckqU+E4HE91gcN0fIbc0fSyvIniX6eT/kLBff3b7CudIo7LuarQ
 7bDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkOo16Q70X+mzdhEUgrI21NXJnltbemY0mBN/sRAeDSExdG0DxugTf8aJDgiBsZM5F1Meop6bNOqIU@nongnu.org
X-Gm-Message-State: AOJu0YxYMnAa6PHxlEpOfbgcHPF0IL2VHCkkBNp76RsZ+nLnzsx2Vxcf
 702EtdgzF/oPkjmNNZCVEfjYT8PK4JgU5pve6fiybLmPwBXHTvBAM4B0CAIIKLE=
X-Google-Smtp-Source: AGHT+IFtzjsiaxuS6VNNzw2rUJTcOOE8bHrdlmfZiF2WsUw+IZmEqafl+i6EZBs4E1mhm91mmMeQ+A==
X-Received: by 2002:a17:902:e885:b0:205:2a59:a28c with SMTP id
 d9443c01a7336-20bfde555b8mr7047295ad.1.1727991062772; 
 Thu, 03 Oct 2024 14:31:02 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefafc65sm12994565ad.217.2024.10.03.14.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:31:02 -0700 (PDT)
Message-ID: <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
Date: Thu, 3 Oct 2024 14:31:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
 <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gMTAvMy8yNCAxMzo0OCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDMvMTAvMjQgMTg6MDQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAxMC8zLzI0
IDA5OjAyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAzMC85LzI0
IDE2OjMyLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+Pj4gT24gMzAvMDkvMjAyNCAwOS4zNCwg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+PiBSZXBsYWNlIGEgcGFpciBv
ZiBtZW1jcHkoKSArIHRzd2FwMzIoKSBieSBzdGxfZW5kaWFuX3AoKSwNCj4+Pj4+IHdoaWNo
IGFsc28gc3dhcCB0aGUgdmFsdWUgdXNpbmcgdGFyZ2V0IGVuZGlhbm5lc3MuDQo+Pj4+Pg0K
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgwqDCoCBody94dGVuc2EveHRmcGdhLmMg
fCA2ICsrLS0tLQ0KPj4+Pj4gIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcveHRlbnNh
L3h0ZnBnYS5jIGIvaHcveHRlbnNhL3h0ZnBnYS5jDQo+Pj4+PiBpbmRleCAyMjhmMDBiMDQ1
Li41MjFmZTg0YjAxIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcveHRlbnNhL3h0ZnBnYS5jDQo+
Pj4+PiArKysgYi9ody94dGVuc2EveHRmcGdhLmMNCj4+Pj4+IEBAIC00MzgsMTEgKzQzOCw5
IEBAIHN0YXRpYyB2b2lkIHh0ZnBnYV9pbml0KGNvbnN0IFh0ZnBnYUJvYXJkRGVzYw0KPj4+
Pj4gKmJvYXJkLCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+Pj4+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzaXplX3QgYm9vdF9zeiA9IFRBUkdFVF9CSUdfRU5E
SUFOID8NCj4+Pj4+IHNpemVvZihib290X2JlKQ0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoNCj4+Pj4+IHNpemVv
Zihib290X2xlKTsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ4
X3QgKmJvb3QgPSBUQVJHRVRfQklHX0VORElBTiA/IGJvb3RfYmUgOiBib290X2xlOw0KPj4+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgZW50cnlfcGMgPSB0c3dhcDMy
KGVudHJ5X3BvaW50KTsNCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90
IGVudHJ5X2EyID0gdHN3YXAzMih0YWdwdHIpOw0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWVtY3B5KGJvb3QgKyA0LCAmZW50cnlfcGMsIHNpemVvZihlbnRyeV9wYykpOw0K
Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGJvb3QgKyA4LCAmZW50cnlf
YTIsIHNpemVvZihlbnRyeV9hMikpOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RsX2VuZGlhbl9wKFRBUkdFVF9CSUdfRU5ESUFOLCBib290ICsgNCwgZW50cnlfcG9pbnQp
Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RsX2VuZGlhbl9wKFRBUkdFVF9C
SUdfRU5ESUFOLCBib290ICsgOCwgdGFncHRyKTsNCj4+Pj4NCj4+Pj4gV2h5IGRvbid0IHlv
dSBzaW1wbHkgdXNlIHN0bF9wKCkgaGVyZT8NCj4+Pg0KPj4+IFdlIHdhbnQgdG8gcmVtb3Zl
IHRoZSB0c3dhcDMyKCkgY2FsbHMuLi4NCj4+Pg0KPj4NCj4+IEkgdGhpbmsgaXMgcG9pbnQg
aXMgdGhhdCB5b3UgY291bGQgZGlyZWN0bHkgdXNlIHN0bF9iZV9wLCBpbnN0ZWFkIG9mDQo+
PiBzdGxfZW5kaWFuX3AoVEFSR0VUX0JJVF9FTkRJQU4sIC4uLikuDQo+IA0KPiBUQVJHRVRf
QklHX0VORElBTiBpcyBkZWZpbmVkIGFzIDAgb24gbGl0dGxlIGVuZGlhbiwgYW5kIDEgb24g
YmlnIG9uZS4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlIGlzbid0IHdvcnRoIGl0Og0K
PiANCj4gICAgIGlmIChUQVJHRVRfQklHX0VORElBTikgew0KPiAgICAgICBzdGxfYmVfcChi
b290ICsgOCwgdGFncHRyKTsNCj4gICAgIH0gZWxzZSB7DQo+ICAgICAgIHN0bF9sZV9wKGJv
b3QgKyA4LCB0YWdwdHIpOw0KPiAgICAgfQ0KPiANCj4gTWF5YmUgSSdtIG1pc3NpbmcgVGhv
bWFzIHBvaW50LCBhcyB0aGUgeHRmcGdhIG1hY2hpbmVzIGFyZSBhdmFpbGFibGUNCj4gZm9y
IGJvdGggeHRlbnNhLXNvZnRtbXUgKExFKSBhbmQgeHRlbnNhZWItc29mdG1tdSAoQkUpLg0K
PiANCj4+IEkgZG9uJ3Qga25vdyBpZiB5b3VyIGludGVudCBpcyB0byBtYWtlIGJlL2xlIHZh
cmlhbnQgInByaXZhdGUiIGFuZA0KPj4gcmVsaWVzIG9ubHkgb24gZW5kaWFuX3AgdGhvdWdo
Lg0KPiANCj4gTXkgaW50ZW50IGlzIHRvIGVuZm9yY2UgZW5kaWFuIGFnbm9zdGljIEFQSSB1
c2VzIHdoZW4gcG9zc2libGUsIGFuZA0KPiB1c2UgTEUvQkUgc3BlY2lmaWMgdmFyaWFudCB3
aGVuIGl0IGlzIGtub3duIGF0IGJ1aWxkIHRpbWUuDQoNCk9oIG9rLCBpdCdzIG1lIHdobyBt
aXNzZWQgeW91ciBwb2ludCB0aGVuLg0KRm9yIHNvbWUgcmVhc29uLCBJIHRob3VnaHQgd2Ug
d2VyZSBhbHdheXMgY2FsbGluZyBiaWcgZW5kaWFuIHZhcmlhbnQuDQoNClRodXMsIHlvdXIg
aW1wbGVtZW50YXRpb24gbWFrZXMgdG90YWxseSBzZW5zZS4NCg0KTGV0J3Mgc2VlIGlmIFRo
b21hcyBtZWFudCBzb21ldGhpbmcgZGlmZmVyZW50Lg0KRWxzZSwNClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=


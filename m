Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E740C369D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 04:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cwW-0000aE-QO; Fri, 18 Apr 2025 00:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cwU-0000Uz-1O
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:03:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cwS-0008QZ-4c
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 00:03:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376e311086so2003853b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 21:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744948982; x=1745553782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7jyYFnYi7OShrzLTybD2SWNOBYMy5F7tmG8v64n1ywY=;
 b=RMJ7vjburlAyNi1QcQPVnr10Y0jshENceHiKJN3+6Ep84jVUosjyTw9sCkTUm+PBJl
 R7zR69+4oaf4m073IX4xuHqI8/wzO5GyLHAPPFv/ZP+aipQ9uitfsCdWsl4TSY6f1fh9
 QoIykSq/jirKXLG83OewQdKSS55BAsGYUH7ymWYlQCFUalUoyAVQeIskKMMA8cv0wB4c
 uimyiipH96IfivzG/fSViA/guGIvpnTQwkO6YpPmh6379pmbNe3cNyGT3Pu3e19MkOnG
 vQ2v0akJ0A5R5J4j3YhKHKaJYGLq4mlgS4ztzFwO0YOUe40LAS7laGNybDGGLsd6gUdJ
 a4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744948982; x=1745553782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7jyYFnYi7OShrzLTybD2SWNOBYMy5F7tmG8v64n1ywY=;
 b=J/DTWbZp8oqzz0xfh2fcrrKh9XX8LkybU2hiS0+1HbPKRwd/HfWbQEGBnsjM0Tr7o+
 FnjuAirfvOP78wzi/PDIfQ+bbiWU2Sli/hlh8zZVFU3CUCl8bK/ygnK7DzF2f5EDy53I
 YA9UxN5FH9VSJYBX//yptjxNIdgxx9GgVnWB59FyqmOS8ABkxXEohFXBWLL4OORQt8w1
 FhCCtpSElEvGUVQlwDVMZbuxmukZHPtBy0Z4HrSjjwjp+Xp1DI24QwgKYA3AaKXvrQlv
 Dr7c4f8Q+OO0e9lE/q0B+1kN0C/IfWwCOyISLx7FLzIk36qMrtNratNCIWKuw2tq7UeW
 QYUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKwMVd83Spzog1PEEKr/cQQnEu1FhyF9YPdw9CoGcNsRvrk8iFw+S8edA7oJUCPWuPiHm77am85Rjk@nongnu.org
X-Gm-Message-State: AOJu0YzLWdTt0Q5Hb0tpuLYFCT63bDThYRTxR32gvpll0SZb372/eaav
 JsjOv08pjpPBB3zvG8S3KTDauSLsrndR/je3rHJu5IKyUN18VMHbP713wLQFyqQ=
X-Gm-Gg: ASbGncvaDRekU3fADFHoYDBLeQWkWmWk4X2HpDnEieN9oNXEiFcWU3ddhO6lIgniSZ9
 TkrJ1eP99s4ZIXY6mcU/TVKIeEY2vJLrdnqL2/yFJyd65RnbnFGS5a7E5RqublRpvVTbIRFwIRr
 LSkTGP8ZKLik3vn1oDdd6wMVGGvKJj+YpIOlVD0ICTIz7/FgmkQZF0120Kc9omg6z0aKKnImvWY
 Bkg0QBJpJurE6QURlN/1vjkFf/4rtPWasOLgWvdhAVBj+P52eSFGZl3XgHnVo8hDMJDeX15v2u8
 ZqKMoh27X1Hi4easrKcSAhZfgYGq/8q5OuMzlv2IGAt0GJfJvTMquA==
X-Google-Smtp-Source: AGHT+IEVyEqi+OhfH6hMi76MFFlL3UWwDg6qJka31SnVYsvsawZsSI32xU5+GDADzuNVX7MvInbfOA==
X-Received: by 2002:a17:90b:3a4e:b0:301:1bce:c258 with SMTP id
 98e67ed59e1d1-3087bbbddbcmr1843771a91.22.1744948982471; 
 Thu, 17 Apr 2025 21:03:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df26445sm287889a91.29.2025.04.17.21.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 21:03:02 -0700 (PDT)
Message-ID: <8caac953-82cc-424b-8966-99a0b32e3324@linaro.org>
Date: Thu, 17 Apr 2025 21:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/11] hw/arm/raspi: Build objects once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-12-philmd@linaro.org>
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE5v
dyB0aGFuIFJhc3BpIG1hY2hpbmVzIGNhbiBiZSBmaWx0ZXJlZCB3aGVuIHJ1bm5pbmcgYQ0K
PiBxZW11LXN5c3RlbS1hcm0gb3IgcWVtdS1zeXN0ZW0tYWFyY2g2NCBiaW5hcnksIHdlIGNh
bg0KPiByZW1vdmUgdGhlIFRBUkdFVF9BQVJDSDY0ICNpZmRlZidyeSBhbmQgY29tcGlsZSB0
aGUNCj4gYXNwZWVkLmMgZmlsZSBvbmNlLCBtb3ZpbmcgaXQgZnJvbSBhcm1fc3NbXSBzb3Vy
Y2Ugc2V0DQo+IHRvIGFybV9jb21tb25fc3NbXS4gTm90ZSwgd2UgZXhwb3NlIHRoZSBUWVBF
X0JDTTI4MzcNCj4gdHlwZSB0byBxZW11LXN5c3RlbS1hcm0sIGJ1dCBpdCBpcyBub3QgdXNl
ci1jcmVhdGFibGUsDQo+IHNvIG5vdCBhbiBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+
ICAgaHcvYXJtL2JjbTI4MzYuYyAgIHwgNCAtLS0tDQo+ICAgaHcvYXJtL3Jhc3BpLmMgICAg
IHwgNCAtLS0tDQo+ICAgaHcvYXJtL21lc29uLmJ1aWxkIHwgOCArKysrKystLQ0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9ody9hcm0vYmNtMjgzNi5jIGIvaHcvYXJtL2JjbTI4MzYuYw0KPiBp
bmRleCA5NWUxNjgwNmZhMS4uN2RkODFlOGUwZjkgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9i
Y20yODM2LmMNCj4gKysrIGIvaHcvYXJtL2JjbTI4MzYuYw0KPiBAQCAtMTk1LDcgKzE5NSw2
IEBAIHN0YXRpYyB2b2lkIGJjbTI4MzZfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZv
aWQgKmRhdGEpDQo+ICAgICAgIGRjLT5yZWFsaXplID0gYmNtMjgzNl9yZWFsaXplOw0KPiAg
IH07DQo+ICAgDQo+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4gICBzdGF0aWMgdm9pZCBi
Y20yODM3X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPiAgIHsN
Cj4gICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKG9jKTsNCj4gQEAgLTIw
OCw3ICsyMDcsNiBAQCBzdGF0aWMgdm9pZCBiY20yODM3X2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKm9jLCB2b2lkICpkYXRhKQ0KPiAgICAgICBiYy0+Y2x1c3RlcmlkID0gMHgwOw0KPiAg
ICAgICBkYy0+cmVhbGl6ZSA9IGJjbTI4MzZfcmVhbGl6ZTsNCj4gICB9Ow0KPiAtI2VuZGlm
DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGJjbTI4M3hfdHlwZXNbXSA9IHsN
Cj4gICAgICAgew0KPiBAQCAtMjE5LDEyICsyMTcsMTAgQEAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIGJjbTI4M3hfdHlwZXNbXSA9IHsNCj4gICAgICAgICAgIC5uYW1lICAgICAgICAgICA9
IFRZUEVfQkNNMjgzNiwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfQkNN
MjgzWCwNCj4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9IGJjbTI4MzZfY2xhc3NfaW5p
dCwNCj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAgICAgICB9LCB7DQo+ICAgICAgICAg
ICAubmFtZSAgICAgICAgICAgPSBUWVBFX0JDTTI4MzcsDQo+ICAgICAgICAgICAucGFyZW50
ICAgICAgICAgPSBUWVBFX0JDTTI4M1gsDQo+ICAgICAgICAgICAuY2xhc3NfaW5pdCAgICAg
PSBiY20yODM3X2NsYXNzX2luaXQsDQo+IC0jZW5kaWYNCj4gICAgICAgfSwgew0KPiAgICAg
ICAgICAgLm5hbWUgICAgICAgICAgID0gVFlQRV9CQ00yODNYLA0KPiAgICAgICAgICAgLnBh
cmVudCAgICAgICAgID0gVFlQRV9CQ00yODNYX0JBU0UsDQo+IGRpZmYgLS1naXQgYS9ody9h
cm0vcmFzcGkuYyBiL2h3L2FybS9yYXNwaS5jDQo+IGluZGV4IDhhMmRhNjUwMDg3Li45ODBl
NGExNDc5MyAxMDA2NDQNCj4gLS0tIGEvaHcvYXJtL3Jhc3BpLmMNCj4gKysrIGIvaHcvYXJt
L3Jhc3BpLmMNCj4gQEAgLTM2Nyw3ICszNjcsNiBAQCBzdGF0aWMgdm9pZCByYXNwaTJiX21h
Y2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgICAg
IHJhc3BpX21hY2hpbmVfY2xhc3NfaW5pdChtYywgcm1jLT5ib2FyZF9yZXYpOw0KPiAgIH07
DQo+ICAgDQo+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4gICBzdGF0aWMgdm9pZCByYXNw
aTNhcF9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0K
PiAgIHsNCj4gICAgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOw0K
PiBAQCAtMzg3LDcgKzM4Niw2IEBAIHN0YXRpYyB2b2lkIHJhc3BpM2JfbWFjaGluZV9jbGFz
c19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4gICAgICAgcm1jLT5ib2Fy
ZF9yZXYgPSAweGEwMjA4MjsNCj4gICAgICAgcmFzcGlfbWFjaGluZV9jbGFzc19pbml0KG1j
LCBybWMtPmJvYXJkX3Jldik7DQo+ICAgfTsNCj4gLSNlbmRpZiAvKiBUQVJHRVRfQUFSQ0g2
NCAqLw0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyByYXNwaV9tYWNoaW5lX3R5
cGVzW10gPSB7DQo+ICAgICAgIHsNCj4gQEAgLTQxNyw3ICs0MTUsNiBAQCBzdGF0aWMgY29u
c3QgVHlwZUluZm8gcmFzcGlfbWFjaGluZV90eXBlc1tdID0gew0KPiAgICAgICAgICAgICAg
IHsgVFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FIH0sDQo+ICAgICAgICAgICAgICAgeyB9
LA0KPiAgICAgICAgICAgfSwNCj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAgICAgICB9
LCB7DQo+ICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgi
cmFzcGkzYXAiKSwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfUkFTUElf
TUFDSElORSwNCj4gQEAgLTQzNCw3ICs0MzEsNiBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8g
cmFzcGlfbWFjaGluZV90eXBlc1tdID0gew0KPiAgICAgICAgICAgICAgIHsgVFlQRV9UQVJH
RVRfQUFSQ0g2NF9NQUNISU5FIH0sDQo+ICAgICAgICAgICAgICAgeyB9LA0KPiAgICAgICAg
ICAgfSwNCj4gLSNlbmRpZg0KPiAgICAgICB9LCB7DQo+ICAgICAgICAgICAubmFtZSAgICAg
ICAgICAgPSBUWVBFX1JBU1BJX01BQ0hJTkUsDQo+ICAgICAgICAgICAucGFyZW50ICAgICAg
ICAgPSBUWVBFX1JBU1BJX0JBU0VfTUFDSElORSwNCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9t
ZXNvbi5idWlsZCBiL2h3L2FybS9tZXNvbi5idWlsZA0KPiBpbmRleCBmNzZlN2ZiMjI5Zi4u
ZjUyMDM0ZmY2YTIgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9tZXNvbi5idWlsZA0KPiArKysg
Yi9ody9hcm0vbWVzb24uYnVpbGQNCj4gQEAgLTI3LDggKzI3LDEyIEBAIGFybV9jb21tb25f
c3MuYWRkKHdoZW46ICdDT05GSUdfT01BUCcsIGlmX3RydWU6IGZpbGVzKCdvbWFwMS5jJykp
DQo+ICAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19BTExXSU5ORVJfQTEwJywg
aWZfdHJ1ZTogZmlsZXMoJ2FsbHdpbm5lci1hMTAuYycsICdjdWJpZWJvYXJkLmMnKSkNCj4g
ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FMTFdJTk5FUl9IMycsIGlmX3Ry
dWU6IGZpbGVzKCdhbGx3aW5uZXItaDMuYycsICdvcmFuZ2VwaS5jJykpDQo+ICAgYXJtX2Nv
bW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19BTExXSU5ORVJfUjQwJywgaWZfdHJ1ZTogZmls
ZXMoJ2FsbHdpbm5lci1yNDAuYycsICdiYW5hbmFwaV9tMnUuYycpKQ0KPiAtYXJtX3NzLmFk
ZCh3aGVuOiAnQ09ORklHX1JBU1BJJywgaWZfdHJ1ZTogZmlsZXMoJ2JjbTI4MzYuYycsICdy
YXNwaS5jJykpDQo+IC1hcm1fY29tbW9uX3NzLmFkZCh3aGVuOiBbJ0NPTkZJR19SQVNQSScs
ICdUQVJHRVRfQUFSQ0g2NCddLCBpZl90cnVlOiBmaWxlcygnYmNtMjgzOC5jJywgJ3Jhc3Bp
NGIuYycpKQ0KPiArYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19SQVNQSScsIGlm
X3RydWU6IGZpbGVzKA0KPiArICAnYmNtMjgzNi5jJywNCj4gKyAgJ2JjbTI4MzguYycsDQo+
ICsgICdyYXNwaS5jJywNCj4gKyAgJ3Jhc3BpNGIuYycsDQo+ICspKQ0KPiAgIGFybV9jb21t
b25fc3MuYWRkKHdoZW46ICdDT05GSUdfU1RNMzJGMTAwX1NPQycsIGlmX3RydWU6IGZpbGVz
KCdzdG0zMmYxMDBfc29jLmMnKSkNCj4gICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09O
RklHX1NUTTMyRjIwNV9TT0MnLCBpZl90cnVlOiBmaWxlcygnc3RtMzJmMjA1X3NvYy5jJykp
DQo+ICAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19TVE0zMkY0MDVfU09DJywg
aWZfdHJ1ZTogZmlsZXMoJ3N0bTMyZjQwNV9zb2MuYycpKQ0KDQpHcmVhdCENClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoN
Cg==


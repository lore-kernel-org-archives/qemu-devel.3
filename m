Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E41C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSh7-0000vc-R8; Wed, 26 Mar 2025 11:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh4-0000tl-Pp
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh2-0005jB-Qv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224100e9a5cso141770765ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002963; x=1743607763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQDKWMm4VImUUK5cCGXCv1NqUlk6BtCsjsNH2dFg+SU=;
 b=PpPALPc+cJ+f9i5HArLFUFSrH6p0YQFHXy9atYoSHmXo6+/18V9yDCyB0JSTpU30+C
 Smz1qSIh7ZbhMEHNuyO/4sVjl+hhYr39pgYxyuL5gkPpLCs+LrIfkbwL6pGiCwpFSex3
 o0/AULdPvnQpOuNXK8eVmB8l9QCxcibfr9tFIiyGrur57CvHfC931Ykym/ONCTS2Iecx
 fuFW46kswJkOLpY7CELn+5GYD9St1S3fxb9UKV6p692ozrlEl6rPMyRK3/yR2BlI0ynx
 QVyqvsYCw3+iuXvjnZqb/oDVG3wiyLwMRI0TmGQR8pFUICfqLTt+2jllh0faPiPmrDVb
 5Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002963; x=1743607763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQDKWMm4VImUUK5cCGXCv1NqUlk6BtCsjsNH2dFg+SU=;
 b=JIRaQuQ0subAeptuRsOYW/MidcN0HG2FkOsdMBI+B+UGhFkTJ9GatIxVKwLXaKlP9G
 vd7//ui4s+aqoCuQpsnokyg8Ax2sfsEbSuXglHwmqp0T4u128Dw+Rv+ku99xdts/i4gq
 6IRMcuDEyZoQ7CcLeT2GpIF1Y7NkOSXjlc0KOxxTA6xH8gVL0m1xoefS1Bi6l17grt9I
 AVUMAPIxvqN994WBnxBLf0YrM9HvpmPKI4FYEVLyYDA2asevdh1vFKwF5gHVCjECDQeq
 hYycun2d35okIFM7KoeSVLAYPS8e5hiBLEA7kVBgcj3Hi5xyphsmXkVCvkpjRUF7DiAi
 X3oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMhvreVLrWWGUaWSBMGfLB2TRPiAq/LubAq3UcIDd98fQUQVdtYfkXmoGr7ktGezqBbLm18+9oRrCW@nongnu.org
X-Gm-Message-State: AOJu0Yynj03NQ4ZauoX4IynrLvYCRm2L34YekLAu/m3pr9i9a2QSvtCt
 pikCjW1CIratkXNYF9+U4Evb2srq4MSzyR9mPd50KwFsFbqp3xKbHwEq8eHSUCo=
X-Gm-Gg: ASbGncuWfvAWvrTCuS2zvbiO2aVDVVaX8OBQ7z3nsSyO/t/06TbDGMxWLpr/iY9qeww
 GZwOTYHpkXtcODofQSGDnReIuJptEZ0W9k22oxUfnRtAj/3cu5zQAPwuQMGGK+E1kRh7EvkSfCM
 TdqIXrUUE/wW2lx7zmQXY/NYaH62sdTTtflrqz2FwDUEdbkoxNlHJkT5YiFwSqofORbXRldhmS6
 KLtY26BCa95Mm1peXtfN6cfKZivi/oOic1KjRiSpGjcz05xNAUmQL5gz+aHFI+xvtezauMSkVki
 bIEa9WdhPmQg52Uz5io78arKNZhMmqPIutgKIrfN50A1NJ67XHGre22foA==
X-Google-Smtp-Source: AGHT+IGZ/Em8hQ20QdOvPO3tWDlm18DbT1Wj/6ERBaKlbV/qPld1qVaS+KOzuFvg1LA+LOtctV9sEQ==
X-Received: by 2002:a17:902:daca:b0:223:fabd:4f99 with SMTP id
 d9443c01a7336-2280482a885mr67105ad.5.1743002963172; 
 Wed, 26 Mar 2025 08:29:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:22 -0700 (PDT)
Message-ID: <ab93a8d6-03e1-4337-86e2-26cc23a25ba1@linaro.org>
Date: Wed, 26 Mar 2025 08:24:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/8] target/mips: Make MIPS_CPU common to new
 MIPS32_CPU / MIPS64_CPU types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ICJ0
YXJnZXQvZm9vL2NwdS1xb20uaCIgY2FuIG5vdCB1c2UgYW55IHRhcmdldCBzcGVjaWZpYyBk
ZWZpbml0aW9ucy4NCj4gDQo+IEN1cnJlbnRseSAidGFyZ2V0L21pcHMvY3B1LXFvbS5oIiBk
ZWZpbmVzIFRZUEVfTUlQU19DUFUgZGVwZW5kaW5nDQo+IG9uIHRoZSBtaXBzKDMyKS9taXBz
NjQgYnVpbGQgdHlwZS4gVGhpcyBkb2Vzbid0IHNjYWxlIGluIGENCj4gaGV0ZXJvZ2VuZW91
cyBjb250ZXh0IHdoZXJlIHdlIG5lZWQgdG8gYWNjZXNzIGJvdGggdHlwZXMgY29uY3VycmVu
dGx5Lg0KPiANCj4gSW4gb3JkZXIgdG8gZG8gdGhhdCwgaW50cm9kdWNlIHRoZSBuZXcgTUlQ
UzMyX0NQVSAvIE1JUFM2NF9DUFUgdHlwZXMsDQo+IGJvdGggaW5oZXJpdGluZyBhIGNvbW1v
biBUWVBFX01JUFNfQ1BVIGJhc2UgdHlwZS4NCj4gDQo+IEtlZXAgdGhlIGN1cnJlbnQgQ1BV
IHR5cGVzIHJlZ2lzdGVyZWQgaW4gbWlwc19yZWdpc3Rlcl9jcHVkZWZfdHlwZSgpDQo+IGFz
IDMyIG9yIDY0LWJpdCwgYnV0IGluc3RlYWQgb2YgZGVwZW5kaW5nIG9uIHRoZSBiaW5hcnkg
YnVpbHQgYmVpbmcNCj4gdGFyZ2V0aW5nIDMyLzY0LWJpdCwgY2hlY2sgd2hldGhlciB0aGUg
Q1BVIGlzIDY0LWJpdCBieSBsb29raW5nIGF0DQo+IHRoZSBDUFVfTUlQUzY0IGJpdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFyZ2V0L21pcHMvY3B1LXFvbS5oIHwgMTIgKysrKysr
LS0tLS0tDQo+ICAgdGFyZ2V0L21pcHMvY3B1LmMgICAgIHwgMTEgKysrKysrKysrKy0NCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pcHMvY3B1LXFvbS5oIGIvdGFyZ2V0L21pcHMv
Y3B1LXFvbS5oDQo+IGluZGV4IDBlZWEyYTI1OThlLi45YWNmNjQ3NDIwYyAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L21pcHMvY3B1LXFvbS5oDQo+ICsrKyBiL3RhcmdldC9taXBzL2NwdS1x
b20uaA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICAvKg0KPiAtICogUUVNVSBNSVBTIENQVQ0K
PiArICogUUVNVSBNSVBTIENQVSBRT00gaGVhZGVyICh0YXJnZXQgYWdub3N0aWMpDQo+ICAg
ICoNCj4gICAgKiBDb3B5cmlnaHQgKGMpIDIwMTIgU1VTRSBMSU5VWCBQcm9kdWN0cyBHbWJI
DQo+ICAgICoNCj4gQEAgLTIyLDEyICsyMiwxMiBAQA0KPiAgIA0KPiAgICNpbmNsdWRlICJo
dy9jb3JlL2NwdS5oIg0KPiAgIA0KPiAtI2lmZGVmIFRBUkdFVF9NSVBTNjQNCj4gLSNkZWZp
bmUgVFlQRV9NSVBTX0NQVSAibWlwczY0LWNwdSINCj4gLSNlbHNlDQo+IC0jZGVmaW5lIFRZ
UEVfTUlQU19DUFUgIm1pcHMtY3B1Ig0KPiAtI2VuZGlmDQo+ICsjZGVmaW5lIFRZUEVfTUlQ
UzMyX0NQVSAibWlwczMyLWNwdSINCj4gKyNkZWZpbmUgVFlQRV9NSVBTNjRfQ1BVICJtaXBz
NjQtY3B1Ig0KPiArI2RlZmluZSBUWVBFX01JUFNfQ1BVICAgIm1pcHMtY3B1Ig0KPiAgIA0K
PiArT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoTUlQUzMyQ1BVLCBNSVBTQ1BVQ2xhc3MsIE1J
UFMzMl9DUFUpDQo+ICtPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShNSVBTNjRDUFUsIE1JUFND
UFVDbGFzcywgTUlQUzY0X0NQVSkNCj4gICBPQkpFQ1RfREVDTEFSRV9DUFVfVFlQRShNSVBT
Q1BVLCBNSVBTQ1BVQ2xhc3MsIE1JUFNfQ1BVKQ0KPiAgIA0KPiAgICNkZWZpbmUgTUlQU19D
UFVfVFlQRV9TVUZGSVggIi0iIFRZUEVfTUlQU19DUFUNCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9taXBzL2NwdS5jIGIvdGFyZ2V0L21pcHMvY3B1LmMNCj4gaW5kZXggMDk3NTU0ZmQ4YWUu
LjVlZDZiMzQwMmQzIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvbWlwcy9jcHUuYw0KPiArKysg
Yi90YXJnZXQvbWlwcy9jcHUuYw0KPiBAQCAtNjA3LDYgKzYwNywxNCBAQCBzdGF0aWMgY29u
c3QgVHlwZUluZm8gbWlwc19jcHVfdHlwZXNbXSA9IHsNCj4gICAgICAgICAgIC5hYnN0cmFj
dCAgICAgICA9IHRydWUsDQo+ICAgICAgICAgICAuY2xhc3Nfc2l6ZSAgICAgPSBzaXplb2Yo
TUlQU0NQVUNsYXNzKSwNCj4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9IG1pcHNfY3B1
X2NsYXNzX2luaXQsDQo+ICsgICAgfSwgew0KPiArICAgICAgICAubmFtZSAgICAgICAgICAg
PSBUWVBFX01JUFMzMl9DUFUsDQo+ICsgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVf
TUlQU19DUFUsDQo+ICsgICAgICAgIC5hYnN0cmFjdCAgICAgICA9IHRydWUsDQo+ICsgICAg
fSwgew0KPiArICAgICAgICAubmFtZSAgICAgICAgICAgPSBUWVBFX01JUFM2NF9DUFUsDQo+
ICsgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfTUlQU19DUFUsDQo+ICsgICAgICAg
IC5hYnN0cmFjdCAgICAgICA9IHRydWUsDQo+ICAgICAgIH0NCj4gICB9Ow0KPiAgIA0KPiBA
QCAtNjIzLDcgKzYzMSw4IEBAIHN0YXRpYyB2b2lkIG1pcHNfcmVnaXN0ZXJfY3B1ZGVmX3R5
cGUoY29uc3Qgc3RydWN0IG1pcHNfZGVmX3QgKmRlZikNCj4gICAgICAgY2hhciAqdHlwZW5h
bWUgPSBtaXBzX2NwdV90eXBlX25hbWUoZGVmLT5uYW1lKTsNCj4gICAgICAgVHlwZUluZm8g
dGkgPSB7DQo+ICAgICAgICAgICAubmFtZSA9IHR5cGVuYW1lLA0KPiAtICAgICAgICAucGFy
ZW50ID0gVFlQRV9NSVBTX0NQVSwNCj4gKyAgICAgICAgLnBhcmVudCA9IGRlZi0+aW5zbl9m
bGFncyAmIENQVV9NSVBTNjQNCj4gKyAgICAgICAgICAgICAgICAgID8gVFlQRV9NSVBTNjRf
Q1BVIDogVFlQRV9NSVBTMzJfQ1BVLA0KPiAgICAgICAgICAgLmNsYXNzX2luaXQgPSBtaXBz
X2NwdV9jcHVkZWZfY2xhc3NfaW5pdCwNCj4gICAgICAgICAgIC5jbGFzc19kYXRhID0gKHZv
aWQgKilkZWYsDQo+ICAgICAgIH07DQoNCkknbSBub3Qgc3VyZSB3ZSBhYnNvbHV0ZWx5IG5l
ZWQgdG8gaW50cm9kdWNlIGEgbmV3IGNvbW1vbiB0eXBlIA0KVFlQRV9NSVBTX0NQVS4NCg0K
SWYgdHlwZXMgZG9uJ3Qgc2hhcmUgYW55IGNvbW1vbiBkYXRhLCBvciBoYXZlIHNwZWNpZmlj
IG1ldGhvZCBhcHBseWluZyANCnRvIHRoZW0sIEkgd291bGQganVzdCBkZWZpbmUgMzIvNjQg
dHlwZXMgd2l0aG91dCBhIGNvbW1vbiBhbmNlc3Rvci4NCg0KVGhhdCBzYWlkLCBpZiB5b3Ug
cHJlZmVyLCBvciBpZiBuZWVkZWQsIEknbSBvayB3aXRoIHRoZSBwYXRjaCBhcyBpdCBpczoN
Cg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCg0K


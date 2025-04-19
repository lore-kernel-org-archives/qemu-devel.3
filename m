Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AAEC369CA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5whu-0002sn-UQ; Fri, 18 Apr 2025 21:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5whr-0002qX-QE
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:09:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5whp-0002Ow-Ts
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:09:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224341bbc1dso24081635ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024956; x=1745629756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cyaMAzL0lGbx2cVgxSK0oTkOna9PsGEsegAjG6u1cGE=;
 b=xHCqStrfrghr7CzqHfSDjQRE5Sf76UoUi3z2xak8UlDe4Le0O+N38nn8dzq49aQqh2
 l3SyGe9mwyVCONf/429IdJmqUvm8ZI57kn19QS9rM8eETke1n77UAQ/AOqeomAiXkBxu
 M1nxFOC97axOnzqU7fdqAoC/RO5AA0mNcEMsI3rTFd9DBPsyGeQGEpDoYptgia2a38XO
 FxKte7Xl7oysA5udONMBJIAKoFZCQMASEJRFPhvxfgzhm5TXP4egk5qu6Dd+VHnGruik
 4Rfjd6K2QoNyYysD6hPu/sbzyhaC3+gMJNrTSxpQoO9HiDnxEDPkGOmZ8w1jNVrrJwgt
 z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024956; x=1745629756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cyaMAzL0lGbx2cVgxSK0oTkOna9PsGEsegAjG6u1cGE=;
 b=DN3nZ7nZSj4za7OWij1XvcsyAbGOeLgZHsyxWwMXgcaVZdPBvdU7wUCmG6BNbDVREl
 QzPngYdF38NuiVqlh2m8/3TXHRvsI3J2bOvFik+iKDKGEqiCVhWwy7LOelFL+T5AKRdu
 8QeZI1A8ZcynwgBFl00eGEdvArLmvy+aTdZ8EQIEWW+pGzxiVN0TwOsoCZpqKT1JPOb1
 SBDJ6x3YXUsuwWXLlfFDJp6+dt0BYaCzqwWpGYauLnGY07q27uf9J6NEUR2ND8rxbg0N
 NL5k/f59JHRE0jzkIwoKooeoegon/FjhTtQy0NjNAhs7SIMfZJKtf93C4Xjr0SVVcgll
 pf3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs35+YDn+MX0xr6yXc9boYLc/u/tjSIVh7gTI5JlD6Qo/hbJixjD4mtBFixVo/ALONQQeKwsxTe3D7@nongnu.org
X-Gm-Message-State: AOJu0YxmqZWB131/AzBDaKg9g7bQiT4wtO4ror+f//fpswMAdGZEg7YT
 sXHSXtR9uFK2ZQbwXTM++ixfraOKICEquD3pm/nSHD2lSDViS/jMA3ByLC8xWLs=
X-Gm-Gg: ASbGncslTVtYnyO2oj2RAj8AXJyY10uJ9h4+/wjoKsyOi/KIJl0kulyGnvhKSgxxA4r
 0TBQZMTQFyC7UnbTpcFbxEVIJD4b9FkSgz+k9Lw6pTHQbt+SmJl/AoSgi7Y8pPUyL8gh/j3mV3u
 cHJlLco0Tnkbl8re/FuBaozOQtzFqfrChrtyelQrPKRESifh/UAzlURkHpbS1SQWIPYnOZPjKc8
 SKdKr77DYiBC/30LcAGSK67me3plzhFpMIdZ/QgHZTgHb0Vf/hyQJuf11oWUoYPk/jNQ96XhT5/
 2U2fH4OZGsNBLpB1NzZQ4ilCgdfaf4V6lAmyMoUd4GoSdv+YT/EtGA==
X-Google-Smtp-Source: AGHT+IFfmwX/oMFrgRO8B3zbV0G7rYdKezPuuuEza4YI4ZihiMZpoQcxgVmL8dT5/d2FDcQRyW3vDQ==
X-Received: by 2002:a17:903:2f90:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22c53607d1emr55523505ad.39.1745024956354; 
 Fri, 18 Apr 2025 18:09:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4a5csm23038315ad.129.2025.04.18.18.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 18:09:15 -0700 (PDT)
Message-ID: <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
Date: Fri, 18 Apr 2025 18:09:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gNC8xOC8yNSAxMDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEFk
ZCBhIGhlbHBlciB0byBkaXN0aW5jdCB0aGUgYmluYXJ5IGlzIHRhcmdldHRpbmcNCj4gQWFy
Y2g2NCBvciBub3QuDQo+IA0KPiBTdGFydCB3aXRoIGEgZHVtcCBzdHJjbXAoKSBpbXBsZW1l
bnRhdGlvbiwgbGVhdmluZw0KPiByb29tIGZvciBmdXR1cmUgb3B0aW1pemF0aW9ucy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmggfCA3ICsr
KysrKysNCj4gICB0YXJnZXRfaW5mby5jICAgICAgICAgICAgICB8IDUgKysrKysNCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaCBiL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5o
DQo+IGluZGV4IGM2N2I5N2Q2NmYzLi45Yjc1NzVjZTYzMiAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9xZW11L3RhcmdldF9pbmZvLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9p
bmZvLmgNCj4gQEAgLTI0LDQgKzI0LDExIEBAIGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lKHZv
aWQpOw0KPiAgICAqLw0KPiAgIGNvbnN0IGNoYXIgKnRhcmdldF9tYWNoaW5lX3R5cGVuYW1l
KHZvaWQpOw0KPiAgIA0KPiArLyoqDQo+ICsgKiB0YXJnZXRfYWFyY2g2NDoNCj4gKyAqDQo+
ICsgKiBSZXR1cm5zIHdoZXRoZXIgdGhlIHRhcmdldCBhcmNoaXRlY3R1cmUgaXMgQWFyY2g2
NC4NCj4gKyAqLw0KPiArYm9vbCB0YXJnZXRfYWFyY2g2NCh2b2lkKTsNCj4gKw0KPiAgICNl
bmRpZg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0X2luZm8uYyBiL3RhcmdldF9pbmZvLmMNCj4g
aW5kZXggMWRlNDMzNGVjYzUuLjg3ZGQxZDUxNzc4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXRf
aW5mby5jDQo+ICsrKyBiL3RhcmdldF9pbmZvLmMNCj4gQEAgLTE5LDMgKzE5LDggQEAgY29u
c3QgY2hhciAqdGFyZ2V0X21hY2hpbmVfdHlwZW5hbWUodm9pZCkNCj4gICB7DQo+ICAgICAg
IHJldHVybiB0YXJnZXRfaW5mbygpLT5tYWNoaW5lX3R5cGVuYW1lOw0KPiAgIH0NCj4gKw0K
PiArYm9vbCB0YXJnZXRfYWFyY2g2NCh2b2lkKQ0KPiArew0KPiArICAgIHJldHVybiAhc3Ry
Y21wKHRhcmdldF9uYW1lKCksICJhYXJjaDY0Iik7DQoNCkkgZG9uJ3QgdGhpbmsgZG9pbmcg
c3RyY21wIGlzIGEgZ29vZCBtb3ZlIGhlcmUsIGV2ZW4gdGVtcG9yYXJpbHkuDQoNCkEgc2hv
cnQgdGVybSBzb2x1dGlvbiBpcyBtYWtpbmcgdGFyZ2V0X2luZm8uYyB0YXJnZXQgc3BlY2lm
aWMsIGFuZCB1c2U6DQpyZXR1cm4gVEFSR0VUX0FBUkNINjQ7DQoNClRoZSBsb25nIHRlcm0g
c29sdXRpb24sIGlzIHRvIGhhdmUgYSBjcmVhdGUgdGFyZ2V0X2N1cnJlbnQoKSB0aGF0IA0K
cmV0dXJucyBhbiBlbnVtLCBhbmQgdGFyZ2V0X2FhcmNoNjQoKSB3b3VsZCBiZWNvbWU6DQpy
ZXR1cm4gdGFyZ2V0X2N1cnJlbnQoKSA9PSB7RU5VTX1fQUFSQ0g2NC4gV2UganVzdCBuZWVk
IHRvIGZpbmQgYSBnb29kIA0KbmFtZSBmb3Ige2VudW19IHdoaWNoIGlzIG5vdCBUYXJnZXQs
IHNpbmNlIGl0J3MgYSBwb2lzb25lZCBpZGVudGlmaWVyLg0KDQpUaGlzIHdheSwgd2UgY2Fu
IGVhc2lseSBjb252ZXJ0IHRoZSBzaW1wbGUNCiNpZmRlZiBUQVJHRVRfQUFSQ0g2NCBieSBp
ZiB0YXJnZXRfYWFyY2g2NCgpLA0KYW5kIG1vcmUgY29tcGxpY2F0ZWQgY29tYmluYXRpb25z
IGJ5IGEgc3dpdGNoIG9uIHRhcmdldF9jdXJyZW50KCkuDQoNCkZvciBhIGZpcnN0IHZlcnNp
b24sIEkgdGhpbmsgdGhhdCB0aGUgZmlyc3Qgc29sdXRpb24gaXMgZW5vdWdoLg0K


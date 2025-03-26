Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D3C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSh6-0000uW-V9; Wed, 26 Mar 2025 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh2-0000sW-JL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh0-0005iq-Sj
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224100e9a5cso141770095ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002961; x=1743607761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uT6F6heBrk9Q/LX5QwBgt708tsSobJJmDHMZRlaCWGc=;
 b=AQ30qz+Q3Qpoz4CDfuj+S1SDicXJJdgp7cAgQW5uL8679PyRIZyp6MWxz1NC6cKtZA
 aAy+u2+jI65bJlm2K+V0uMevn/NGS3PHP9S1dacBYCiWmeq63kJi6qnKjpoiACOtdpXU
 wlN4scWBlw1VnyayNnrVo15E/4uoA3g2fXAW26SydGLJ4RNoJkuqJESjcFwBJ/Q4EXkx
 4fe/ks69bBD708EbDM4cZM/KaQpAq07MH1MrpRDhM8sPavu3R38DFEIGKgRpw4C91dhq
 PO2VYJ4Op8GAwqb76SzIHaFxdfQADLe17FoLTd88C+FgJHrRYmFlTmXxOc1oYahQC2N9
 a3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002961; x=1743607761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uT6F6heBrk9Q/LX5QwBgt708tsSobJJmDHMZRlaCWGc=;
 b=ZdXa4F2qYP05WN17LmOY1N/zVxpbOYCFenlXzCaRYXA8kQeINekDanR8p/Q/10XQVc
 0enUAXeondpgZkiH+Qvc9LH8RcoCWPqXM4uXV85yqH4qHRL/7aL/UMeoV4ygegwWHiaw
 hxkyGMrS/GHE1LpREZM6mUltrDFDwSgVTnTUTsWn3O4/hqs0B2R3qT8bB8Gp48KuRi+p
 Vk6lIITY0Pa5vNo+o/v/4kGxr7niiNH2hEAw156lJIpl0vMoFo3nF3tufChB0VNgE2FE
 ZWzIYAIvewibhJxE8l1Lg5z7LCjUYT8P10VdIsyNL1PLSA997CJGhN0veAqxzCN3i3F4
 mGxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5yMKwpOv/haAYNbuDatENq+yL50QLigXnIgp8sjsy/J4ES+Axx7DAtRKIyWRUknjtDwoOH0P/mrmd@nongnu.org
X-Gm-Message-State: AOJu0YxQm0haGDAzxKRrGVTPCom81Jua/9onkKO9JzEqI6jYXcV2FJG0
 fvCJe8P2E/89bAx7Wk4Ewh2WwkGXmT+2zBBCtAcgItiQ0WyOeMLltWlj07DCfjkpZtrLpHLPI/6
 h
X-Gm-Gg: ASbGncscLGoKYmf5rYl+q42yU6eGQwwuago02K70tCAPM+YQwyGp3JZMLGyEVKE3G4X
 3DM7A0pyj6qV0u1/OxMOxZwTA0r4VAJTrwzd+WvHwHE/SN5Q78xkyPxFiYRpVFad23Kga+IjdCo
 hWedn3X2YptEXVmcMV4kIDcRDLrSXVy0Kavv1uRUmZG+1pkXnnTauf2xBKmsG0Sx7hDt6F2awfw
 AuURqHsMWsvJ5BLqMua9UvlvCp+H5zR9kev6S15/2OhQOSsBVmJczPvXDZGs4OCxH8/9/A4qNIo
 9muousZPdyZkwL4Z4Z2YNRoQAgsTt6EWOGwr3YyRASa4AEb3SYbNS7r58L5kZcjCLShh
X-Google-Smtp-Source: AGHT+IHYc7oTPd/3PqXRLgCQOiqASNMbyI1jpNjL1YzBjfh7ZJKTolQLMW8nykTRQmK+67EC1Y1LaQ==
X-Received: by 2002:a17:903:2352:b0:224:3c9:19ae with SMTP id
 d9443c01a7336-22780e0b570mr344752465ad.34.1743002961428; 
 Wed, 26 Mar 2025 08:29:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:20 -0700 (PDT)
Message-ID: <188cf71f-e94b-40c0-81d4-0a3319e2b3ac@linaro.org>
Date: Wed, 26 Mar 2025 08:21:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/8] target/mips: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-3-philmd@linaro.org>
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdo
ZW4gbXVsdGlwbGUgUU9NIHR5cGVzIGFyZSByZWdpc3RlcmVkIGluIHRoZSBzYW1lIGZpbGUs
DQo+IGl0IGlzIHNpbXBsZXIgdG8gdXNlIHRoZSB0aGUgREVGSU5FX1RZUEVTKCkgbWFjcm8u
IEluDQo+IHBhcnRpY3VsYXIgYmVjYXVzZSB0eXBlIGFycmF5IGRlY2xhcmVkIHdpdGggc3Vj
aCBtYWNybw0KPiBhcmUgZWFzaWVyIHRvIHJldmlldy4NCj4gDQo+IEluIGZldyBjb21taXRz
IHdlIGFyZSBnb2luZyB0byBhZGQgbW9yZSB0eXBlcywgc28gcmVwbGFjZQ0KPiB0aGUgdHlw
ZV9yZWdpc3Rlcl9zdGF0aWMoKSB0byBlYXNlIGZ1cnRoZXIgcmV2aWV3cy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0YXJnZXQvbWlwcy9jcHUuYyB8IDIzICsrKysr
KysrKysrKystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9taXBzL2Nw
dS5jIGIvdGFyZ2V0L21pcHMvY3B1LmMNCj4gaW5kZXggYjIwNzEwNmRkNzkuLjA5NzU1NGZk
OGFlIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvbWlwcy9jcHUuYw0KPiArKysgYi90YXJnZXQv
bWlwcy9jcHUuYw0KPiBAQCAtNTk3LDE3ICs1OTcsMjEgQEAgc3RhdGljIHZvaWQgbWlwc19j
cHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgdm9pZCAqZGF0YSkNCj4gICAjZW5kaWYg
LyogQ09ORklHX1RDRyAqLw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBjb25zdCBUeXBlSW5m
byBtaXBzX2NwdV90eXBlX2luZm8gPSB7DQo+IC0gICAgLm5hbWUgPSBUWVBFX01JUFNfQ1BV
LA0KPiAtICAgIC5wYXJlbnQgPSBUWVBFX0NQVSwNCj4gLSAgICAuaW5zdGFuY2Vfc2l6ZSA9
IHNpemVvZihNSVBTQ1BVKSwNCj4gLSAgICAuaW5zdGFuY2VfYWxpZ24gPSBfX2FsaWdub2Yo
TUlQU0NQVSksDQo+IC0gICAgLmluc3RhbmNlX2luaXQgPSBtaXBzX2NwdV9pbml0Zm4sDQo+
IC0gICAgLmFic3RyYWN0ID0gdHJ1ZSwNCj4gLSAgICAuY2xhc3Nfc2l6ZSA9IHNpemVvZihN
SVBTQ1BVQ2xhc3MpLA0KPiAtICAgIC5jbGFzc19pbml0ID0gbWlwc19jcHVfY2xhc3NfaW5p
dCwNCj4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBtaXBzX2NwdV90eXBlc1tdID0gew0KPiAr
ICAgIHsNCj4gKyAgICAgICAgLm5hbWUgICAgICAgICAgID0gVFlQRV9NSVBTX0NQVSwNCj4g
KyAgICAgICAgLnBhcmVudCAgICAgICAgID0gVFlQRV9DUFUsDQo+ICsgICAgICAgIC5pbnN0
YW5jZV9zaXplICA9IHNpemVvZihNSVBTQ1BVKSwNCj4gKyAgICAgICAgLmluc3RhbmNlX2Fs
aWduID0gX19hbGlnbm9mKE1JUFNDUFUpLA0KPiArICAgICAgICAuaW5zdGFuY2VfaW5pdCAg
PSBtaXBzX2NwdV9pbml0Zm4sDQo+ICsgICAgICAgIC5hYnN0cmFjdCAgICAgICA9IHRydWUs
DQo+ICsgICAgICAgIC5jbGFzc19zaXplICAgICA9IHNpemVvZihNSVBTQ1BVQ2xhc3MpLA0K
PiArICAgICAgICAuY2xhc3NfaW5pdCAgICAgPSBtaXBzX2NwdV9jbGFzc19pbml0LA0KPiAr
ICAgIH0NCj4gICB9Ow0KPiAgIA0KPiArREVGSU5FX1RZUEVTKG1pcHNfY3B1X3R5cGVzKQ0K
PiArDQo+ICAgc3RhdGljIHZvaWQgbWlwc19jcHVfY3B1ZGVmX2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPiAgIHsNCj4gICAgICAgTUlQU0NQVUNsYXNzICpt
Y2MgPSBNSVBTX0NQVV9DTEFTUyhvYyk7DQo+IEBAIC02MzIsNyArNjM2LDYgQEAgc3RhdGlj
IHZvaWQgbWlwc19jcHVfcmVnaXN0ZXJfdHlwZXModm9pZCkNCj4gICB7DQo+ICAgICAgIGlu
dCBpOw0KPiAgIA0KPiAtICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZtaXBzX2NwdV90eXBl
X2luZm8pOw0KPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbWlwc19kZWZzX251bWJlcjsgaSsr
KSB7DQo+ICAgICAgICAgICBtaXBzX3JlZ2lzdGVyX2NwdWRlZl90eXBlKCZtaXBzX2RlZnNb
aV0pOw0KPiAgICAgICB9DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==


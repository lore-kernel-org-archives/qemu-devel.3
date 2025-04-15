Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF9C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4kCl-0007FD-RN; Tue, 15 Apr 2025 13:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4kCc-00078G-Ts
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:36:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4kCY-0001Fi-Os
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:36:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225df540edcso68448415ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744738560; x=1745343360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gjbmURJW9khc3Y3BJo9u5S/E6XesLx2zy5G24e0z8eQ=;
 b=IJ4vwSM1rRvLST3YqVN1BA98NdO7uZpm5e2csEdcFLgcXvTFW82qyNxibYBJFnWgVZ
 agzuROorS0MHCElkutU3+hGvTJ54thHaN2e2hXDWB6dAL2rece3GBDyWtqmXbJv3qxeT
 6iOxwXD48CKEpBUtjdmcmuG5NHMTNJo+Ho7ks3U1IxCHR1bqX2deEjoq02XbuwfjJ4L0
 h2vuhWar3QdrEzvV3o6xKp0omrfS3Sum09Bw1TG/+4EQAB2IVOrNRnxkn+AszGnhpLzD
 mw4MgCmv/ImrDqsLDrat4T8uQOIr710TPDIR7p4E6/BJxKe1iSPF+5ASsLMt7DWXiksd
 nmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744738560; x=1745343360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gjbmURJW9khc3Y3BJo9u5S/E6XesLx2zy5G24e0z8eQ=;
 b=RYpNZsEe54wB6ze+yVR6v1N3fM8FrdkCJA+SHEWbC4JzaP6ZtIahHU/t+z1avBbE9a
 vXYwaSV65Q6SgfUV4SFZKK1BgbsiLdMKrSOUqfgF+FTm1rq8GsYj+9vi5D4qMtGXIdNz
 pjBXOTDA38tAxCrhSqjNy9rlAUWflK99PfPnzt3UkyYLtWPs/0LDeZ1/HLvwD018e+t0
 8L5RcUKLakegvNX4tNCLx57Op3AsjukrdDq+WuvfiKSrck32gsgIaNFFZhRw8UemNjty
 OSOT+pZVps7sq/dpk3Hs4vQ+psx8Kw8UaKG9+KBRQt9eCuyHk1NAlptWYM7wAmr9Y5pU
 F56A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg9/Z/E7JuputqD1NKNPPnx7n8Q8ajbgjsZf7PL0nDnYFW2cgB2k9gheUvhPoSM1AeE1TTZvs4SPYq@nongnu.org
X-Gm-Message-State: AOJu0YzgM/DxLqOIsuHWNBFTXf9Rkq+3qhFcDwTvzfrPBR2Wv/h9CEMF
 ZVQxmGW3IXRabInphBIEwwI7UP9062kuDqwj1AiYk7sLlqBscFhyonPF1nSkdMM=
X-Gm-Gg: ASbGncvCrh/eXMMGWT9PxijSBGw8FyyRDtt6TNxgpHZV/GBWF+0r2sZGuymcPR1M7tM
 e+729qiZ+B17b0GsfwpdRyHMV3lZJoekc6+i340ojsKOlyJ//KHLhh4A6oUFhAf8nfsnbh3h6ta
 7klnsuqc92PmhN0Fo1bveZS6hMtufr+VMfyJFBSOezQlVAr/wEnVMAD2nbafpY4RxrLHYLSI79M
 5WU8wOtJgcpdPeZUwXigkMnnPUliNB0hI11FHKaCYVlA5ME66vQrLkyeseR80232GHzopXHhkIW
 DfeVKWP3qONDpnlfHZ067lNK7tDNvWw3dYinaYSLNbGPxo2QqhtThg==
X-Google-Smtp-Source: AGHT+IFwUnNGNMrwxA5YndPotTSrNDktj6/BsxRnHgnEYmpPIrrAHNARTy1ytTbRewB45L59XCSyeA==
X-Received: by 2002:a17:903:1b24:b0:215:44fe:163d with SMTP id
 d9443c01a7336-22c30d71eb9mr4077455ad.17.1744738560493; 
 Tue, 15 Apr 2025 10:36:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccb79esm120516105ad.243.2025.04.15.10.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 10:36:00 -0700 (PDT)
Message-ID: <13847b4c-2e70-4468-afb6-074054783d0c@linaro.org>
Date: Tue, 15 Apr 2025 10:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] target/arm: Replace target_ulong -> vaddr for
 CPUWatchpoint
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415172246.79470-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gNC8xNS8yNSAxMDoyMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IENQ
VVdhdGNocG9pbnQ6OnZhZGRyL2xlbiBhcmUgb2YgdHlwZSB2YWRkci4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4N
Cj4gLS0tDQo+ICAgdGFyZ2V0L2FybS9pbnRlcm5hbHMuaCAgIHwgOSArKysrKy0tLS0NCj4g
ICB0YXJnZXQvYXJtL2h5cF9nZGJzdHViLmMgfCA4ICsrKystLS0tDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2FybS9pbnRlcm5hbHMuaCBiL3RhcmdldC9hcm0vaW50ZXJuYWxzLmgN
Cj4gaW5kZXggMDVjZWI5YmNmNWQuLmExOWM4MDVhZjQ1IDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvYXJtL2ludGVybmFscy5oDQo+ICsrKyBiL3RhcmdldC9hcm0vaW50ZXJuYWxzLmgNCj4g
QEAgLTI2LDYgKzI2LDcgQEANCj4gICAjZGVmaW5lIFRBUkdFVF9BUk1fSU5URVJOQUxTX0gN
Cj4gICANCj4gICAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4gKyNpbmNsdWRlICJleGVj
L3ZhZGRyLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvYnJlYWtwb2ludC5oIg0KPiAgICNpbmNs
dWRlICJody9yZWdpc3RlcmZpZWxkcy5oIg0KPiAgICNpbmNsdWRlICJ0Y2cvdGNnLWd2ZWMt
ZGVzYy5oIg0KPiBAQCAtMTk0NiwxMCArMTk0NywxMCBAQCBib29sIGZpbmRfaHdfYnJlYWtw
b2ludChDUFVTdGF0ZSAqY3B1LCB1aW50NjRfdCBwYyk7DQo+ICAgaW50IGluc2VydF9od19i
cmVha3BvaW50KHVpbnQ2NF90IHBjKTsNCj4gICBpbnQgZGVsZXRlX2h3X2JyZWFrcG9pbnQo
dWludDY0X3QgcGMpOw0KPiAgIA0KPiAtYm9vbCBjaGVja193YXRjaHBvaW50X2luX3Jhbmdl
KGludCBpLCB0YXJnZXRfdWxvbmcgYWRkcik7DQo+IC1DUFVXYXRjaHBvaW50ICpmaW5kX2h3
X3dhdGNocG9pbnQoQ1BVU3RhdGUgKmNwdSwgdGFyZ2V0X3Vsb25nIGFkZHIpOw0KPiAtaW50
IGluc2VydF9od193YXRjaHBvaW50KHRhcmdldF91bG9uZyBhZGRyLCB0YXJnZXRfdWxvbmcg
bGVuLCBpbnQgdHlwZSk7DQo+IC1pbnQgZGVsZXRlX2h3X3dhdGNocG9pbnQodGFyZ2V0X3Vs
b25nIGFkZHIsIHRhcmdldF91bG9uZyBsZW4sIGludCB0eXBlKTsNCj4gK2Jvb2wgY2hlY2tf
d2F0Y2hwb2ludF9pbl9yYW5nZShpbnQgaSwgdmFkZHIgYWRkcik7DQo+ICtDUFVXYXRjaHBv
aW50ICpmaW5kX2h3X3dhdGNocG9pbnQoQ1BVU3RhdGUgKmNwdSwgdmFkZHIgYWRkcik7DQo+
ICtpbnQgaW5zZXJ0X2h3X3dhdGNocG9pbnQodmFkZHIgYWRkciwgdmFkZHIgbGVuLCBpbnQg
dHlwZSk7DQo+ICtpbnQgZGVsZXRlX2h3X3dhdGNocG9pbnQodmFkZHIgYWRkciwgdmFkZHIg
bGVuLCBpbnQgdHlwZSk7DQo+ICAgDQo+ICAgLyogUmV0dXJuIHRoZSBjdXJyZW50IHZhbHVl
IG9mIHRoZSBzeXN0ZW0gY291bnRlciBpbiB0aWNrcyAqLw0KPiAgIHVpbnQ2NF90IGd0X2dl
dF9jb3VudGVydmFsdWUoQ1BVQVJNU3RhdGUgKmVudik7DQo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvYXJtL2h5cF9nZGJzdHViLmMgYi90YXJnZXQvYXJtL2h5cF9nZGJzdHViLmMNCj4gaW5k
ZXggNGU1MmQzN2VkODAuLjRkOGZkOTMzODY4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJt
L2h5cF9nZGJzdHViLmMNCj4gKysrIGIvdGFyZ2V0L2FybS9oeXBfZ2Ric3R1Yi5jDQo+IEBA
IC0xMjUsNyArMTI1LDcgQEAgaW50IGRlbGV0ZV9od19icmVha3BvaW50KHVpbnQ2NF90IHBj
KQ0KPiAgICAqIG5lZWQgdG8gZW5zdXJlIHlvdSBtYXNrIHRoZSBhZGRyZXNzIGFzIHJlcXVp
cmVkIGFuZCBzZXQgQkFTPTB4ZmYNCj4gICAgKi8NCj4gICANCj4gLWludCBpbnNlcnRfaHdf
d2F0Y2hwb2ludCh0YXJnZXRfdWxvbmcgYWRkciwgdGFyZ2V0X3Vsb25nIGxlbiwgaW50IHR5
cGUpDQo+ICtpbnQgaW5zZXJ0X2h3X3dhdGNocG9pbnQodmFkZHIgYWRkciwgdmFkZHIgbGVu
LCBpbnQgdHlwZSkNCj4gICB7DQo+ICAgICAgIEhXV2F0Y2hwb2ludCB3cCA9IHsNCj4gICAg
ICAgICAgIC53Y3IgPSBSX0RCR1dDUl9FX01BU0ssIC8qIEU9MSwgZW5hYmxlICovDQo+IEBA
IC0xODIsNyArMTgyLDcgQEAgaW50IGluc2VydF9od193YXRjaHBvaW50KHRhcmdldF91bG9u
ZyBhZGRyLCB0YXJnZXRfdWxvbmcgbGVuLCBpbnQgdHlwZSkNCj4gICAgICAgcmV0dXJuIDA7
DQo+ICAgfQ0KPiAgIA0KPiAtYm9vbCBjaGVja193YXRjaHBvaW50X2luX3JhbmdlKGludCBp
LCB0YXJnZXRfdWxvbmcgYWRkcikNCj4gK2Jvb2wgY2hlY2tfd2F0Y2hwb2ludF9pbl9yYW5n
ZShpbnQgaSwgdmFkZHIgYWRkcikNCj4gICB7DQo+ICAgICAgIEhXV2F0Y2hwb2ludCAqd3Ag
PSBnZXRfaHdfd3AoaSk7DQo+ICAgICAgIHVpbnQ2NF90IGFkZHJfdG9wLCBhZGRyX2JvdHRv
bSA9IHdwLT53dnI7DQo+IEBAIC0yMTQsNyArMjE0LDcgQEAgYm9vbCBjaGVja193YXRjaHBv
aW50X2luX3JhbmdlKGludCBpLCB0YXJnZXRfdWxvbmcgYWRkcikNCj4gICAgKiBEZWxldGUg
YSBicmVha3BvaW50IGFuZCBzaHVmZmxlIGFueSBhYm92ZSBkb3duDQo+ICAgICovDQo+ICAg
DQo+IC1pbnQgZGVsZXRlX2h3X3dhdGNocG9pbnQodGFyZ2V0X3Vsb25nIGFkZHIsIHRhcmdl
dF91bG9uZyBsZW4sIGludCB0eXBlKQ0KPiAraW50IGRlbGV0ZV9od193YXRjaHBvaW50KHZh
ZGRyIGFkZHIsIHZhZGRyIGxlbiwgaW50IHR5cGUpDQo+ICAgew0KPiAgICAgICBpbnQgaTsN
Cj4gICAgICAgZm9yIChpID0gMDsgaSA8IGN1cl9od193cHM7IGkrKykgew0KPiBAQCAtMjM5
LDcgKzIzOSw3IEBAIGJvb2wgZmluZF9od19icmVha3BvaW50KENQVVN0YXRlICpjcHUsIHVp
bnQ2NF90IHBjKQ0KPiAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgfQ0KPiAgIA0KPiAtQ1BV
V2F0Y2hwb2ludCAqZmluZF9od193YXRjaHBvaW50KENQVVN0YXRlICpjcHUsIHRhcmdldF91
bG9uZyBhZGRyKQ0KPiArQ1BVV2F0Y2hwb2ludCAqZmluZF9od193YXRjaHBvaW50KENQVVN0
YXRlICpjcHUsIHZhZGRyIGFkZHIpDQo+ICAgew0KPiAgICAgICBpbnQgaTsNCj4gICANCg0K
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCg0K


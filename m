Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4kAt-0005W5-Ab; Tue, 15 Apr 2025 13:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4kAT-0005NA-KD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:33:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4kAR-0000rO-RJ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:33:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7687509b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744738429; x=1745343229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iw7U8LkCps6BV/SLXTPygAsXSQHAsbinizmQdDwiW8E=;
 b=P9s50cVYj2j4/ULvDsvwglCJK6QyCMm9ddTzpHv4yjI0mC2m+Pi7y+Ew4TEpY5aos4
 0USDxrkYbiD5PXhZwRzk2u66v/cikzI5XN1TYIvzHjXBOwJD14ryy2YexlzMGwPksGip
 9gCGZTRtzb8CA0ggzr94TEtE1z+Yjosw/qpmluO4BpBNp+yKXxYtgwzoMVQsdKrpB3CY
 ad9tVIEhtWDb256Z4lfh8WNN9mUqTWon/fQvh5++DfaY9XDIkWlx8vJUtunOxzeg9yTv
 YXUPO/Do0M01nQolQHKEBXhXWVwhnG86GKjnCEEfva7zlNlP5TIycsAMCewXJk6V4lvm
 i2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744738429; x=1745343229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iw7U8LkCps6BV/SLXTPygAsXSQHAsbinizmQdDwiW8E=;
 b=DO6bPhSL2UArTI4U+EFGxFWIHdWp8C/2FYgO0UZZmm0lGnLLoMpyhPcvzMCv4nqIEJ
 dQ2JnHYlUb0w/hXtA5uS3Pr0nXl4bfd1hPv7xCJfns3yvp+SLYRUhf5LLbISkD5UgJjf
 girHDuXXqj7JEpHVXMnfuv8PT8quegNVX5lOSLP1tiF1Xu2ADcRUB/aAdKVlx3Q55yN/
 GqHdfJHXsYeaicgRkLf/3JMmXSBAn6vPYrRUZRmYzU4Tn8F2bXOVaBg/mi3fUomPObUD
 SXhw8vhEeVe+EdITQZ6ZCmZC7E6eoGsllW4jDRFey10aYSEMJwTGdkQCKGb5Q/VOOjVp
 k9cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrUr1pfXBo/ccmJixD97KwwAiOLvLCa7gJ2ZHT/S1ZveEohJ6WzGOj8ZJTstYZ7zV/+OTvYdC5JMIL@nongnu.org
X-Gm-Message-State: AOJu0Yx7iVkkaBn/rZ5H4jdJ/SJAK0Purf5Fa0+snjUQ5gmG3sNULbvy
 VEI4Tjn4FeVETbTgci5GtaEwpgXO0fSRAmB/YahftqBR+/P6HDaAhWbIYs0+iQI=
X-Gm-Gg: ASbGncscc5q/RGQ9MwZ3uCVC3l/fMWYA7PfhkCWR6EyTcRdmYAIbg0gWdzuI58j8Cel
 +oyc1Ugx0uHO0QQAdm6IEMdy1mEbIbhQ5FF+PwWsDwvbsEQ9FnC0pnvJNcEnoaOxkC/55nuuEEs
 RMYcdxRiZbeUvSyxvJJA/89nc39E3qLDcPxMiokCB8L4S1IvjPZ3t8m5eMqCs+w8rbatQVS2cCJ
 /HQlUZwRUA8vXwcwBJ3V2N21/fegCrhp+K59vI66Y2gD5GH9oPlxJaJ+Az1sKUuiXLqGy94uFWH
 uq51m3OOb31wIv3AVzwPgbbwdlStJF3bvM1st1BMb5/mrUv5aqgF/A==
X-Google-Smtp-Source: AGHT+IGaxIaahu9UD9nksH5hnSVIF3qI0ezMZFhvvF38fdcl5F2Zzm/u0L0uim7h/cfhCWUjC4MDlA==
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:7e57:501c with SMTP id
 adf61e73a8af0-201799978damr22327197637.39.1744738428967; 
 Tue, 15 Apr 2025 10:33:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a0cf374asm11192444a12.26.2025.04.15.10.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 10:33:48 -0700 (PDT)
Message-ID: <cc88f38e-d08a-4d2f-925f-03061b44b516@linaro.org>
Date: Tue, 15 Apr 2025 10:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415172246.79470-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

T24gNC8xNS8yNSAxMDoyMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IENQ
VUFSTVN0YXRlOjpwYyBpcyBvZiB0eXBlIHVpbnQ2NF90Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gICB0YXJnZXQvYXJtL2ludGVybmFscy5oICAgfCA2ICsrKy0tLQ0KPiAgIHRhcmdldC9h
cm0vaHlwX2dkYnN0dWIuYyB8IDYgKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2FybS9pbnRlcm5hbHMuaCBiL3RhcmdldC9hcm0vaW50ZXJuYWxzLmgNCj4gaW5kZXggMTc1
ZmI3OTIzNzUuLjA1Y2ViOWJjZjVkIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2ludGVy
bmFscy5oDQo+ICsrKyBiL3RhcmdldC9hcm0vaW50ZXJuYWxzLmgNCj4gQEAgLTE5NDIsOSAr
MTk0Miw5IEBAIGV4dGVybiBHQXJyYXkgKmh3X2JyZWFrcG9pbnRzLCAqaHdfd2F0Y2hwb2lu
dHM7DQo+ICAgI2RlZmluZSBnZXRfaHdfYnAoaSkgICAgKCZnX2FycmF5X2luZGV4KGh3X2Jy
ZWFrcG9pbnRzLCBIV0JyZWFrcG9pbnQsIGkpKQ0KPiAgICNkZWZpbmUgZ2V0X2h3X3dwKGkp
ICAgICgmZ19hcnJheV9pbmRleChod193YXRjaHBvaW50cywgSFdXYXRjaHBvaW50LCBpKSkN
Cj4gICANCj4gLWJvb2wgZmluZF9od19icmVha3BvaW50KENQVVN0YXRlICpjcHUsIHRhcmdl
dF91bG9uZyBwYyk7DQo+IC1pbnQgaW5zZXJ0X2h3X2JyZWFrcG9pbnQodGFyZ2V0X3Vsb25n
IHBjKTsNCj4gLWludCBkZWxldGVfaHdfYnJlYWtwb2ludCh0YXJnZXRfdWxvbmcgcGMpOw0K
PiArYm9vbCBmaW5kX2h3X2JyZWFrcG9pbnQoQ1BVU3RhdGUgKmNwdSwgdWludDY0X3QgcGMp
Ow0KPiAraW50IGluc2VydF9od19icmVha3BvaW50KHVpbnQ2NF90IHBjKTsNCj4gK2ludCBk
ZWxldGVfaHdfYnJlYWtwb2ludCh1aW50NjRfdCBwYyk7DQo+ICAgDQo+ICAgYm9vbCBjaGVj
a193YXRjaHBvaW50X2luX3JhbmdlKGludCBpLCB0YXJnZXRfdWxvbmcgYWRkcik7DQo+ICAg
Q1BVV2F0Y2hwb2ludCAqZmluZF9od193YXRjaHBvaW50KENQVVN0YXRlICpjcHUsIHRhcmdl
dF91bG9uZyBhZGRyKTsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vaHlwX2dkYnN0dWIu
YyBiL3RhcmdldC9hcm0vaHlwX2dkYnN0dWIuYw0KPiBpbmRleCAxZTg2MTI2M2IzZC4uNGU1
MmQzN2VkODAgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vaHlwX2dkYnN0dWIuYw0KPiAr
KysgYi90YXJnZXQvYXJtL2h5cF9nZGJzdHViLmMNCj4gQEAgLTU0LDcgKzU0LDcgQEAgR0Fy
cmF5ICpod19icmVha3BvaW50cywgKmh3X3dhdGNocG9pbnRzOw0KPiAgICAqIGhlcmUgc28g
ZnV0dXJlIFBDIGNvbXBhcmlzb25zIHdpbGwgd29yayBwcm9wZXJseS4NCj4gICAgKi8NCj4g
ICANCj4gLWludCBpbnNlcnRfaHdfYnJlYWtwb2ludCh0YXJnZXRfdWxvbmcgYWRkcikNCj4g
K2ludCBpbnNlcnRfaHdfYnJlYWtwb2ludCh1aW50NjRfdCBhZGRyKQ0KPiAgIHsNCj4gICAg
ICAgSFdCcmVha3BvaW50IGJyayA9IHsNCj4gICAgICAgICAgIC5iY3IgPSAweDEsICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvKiBCQ1IgRT0xLCBlbmFibGUgKi8NCj4gQEAgLTgw
LDcgKzgwLDcgQEAgaW50IGluc2VydF9od19icmVha3BvaW50KHRhcmdldF91bG9uZyBhZGRy
KQ0KPiAgICAqIERlbGV0ZSBhIGJyZWFrcG9pbnQgYW5kIHNodWZmbGUgYW55IGFib3ZlIGRv
d24NCj4gICAgKi8NCj4gICANCj4gLWludCBkZWxldGVfaHdfYnJlYWtwb2ludCh0YXJnZXRf
dWxvbmcgcGMpDQo+ICtpbnQgZGVsZXRlX2h3X2JyZWFrcG9pbnQodWludDY0X3QgcGMpDQo+
ICAgew0KPiAgICAgICBpbnQgaTsNCj4gICAgICAgZm9yIChpID0gMDsgaSA8IGh3X2JyZWFr
cG9pbnRzLT5sZW47IGkrKykgew0KPiBAQCAtMjI2LDcgKzIyNiw3IEBAIGludCBkZWxldGVf
aHdfd2F0Y2hwb2ludCh0YXJnZXRfdWxvbmcgYWRkciwgdGFyZ2V0X3Vsb25nIGxlbiwgaW50
IHR5cGUpDQo+ICAgICAgIHJldHVybiAtRU5PRU5UOw0KPiAgIH0NCj4gICANCj4gLWJvb2wg
ZmluZF9od19icmVha3BvaW50KENQVVN0YXRlICpjcHUsIHRhcmdldF91bG9uZyBwYykNCj4g
K2Jvb2wgZmluZF9od19icmVha3BvaW50KENQVVN0YXRlICpjcHUsIHVpbnQ2NF90IHBjKQ0K
PiAgIHsNCj4gICAgICAgaW50IGk7DQo+ICAgDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==


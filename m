Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1572C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lan-0007z6-8q; Fri, 04 Apr 2025 14:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lak-0007yv-LR
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:16:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lad-0007HS-IZ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:16:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2240b4de12bso32754465ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743790583; x=1744395383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8GtbzYkLZARXf9nEKZuE9rlxGom89KF6nda/xZZhzJc=;
 b=LnG3qjeriXRG9O+n+Tt+pE7x+VO5e/1sCt7/NFLbomzSZAV5iMWrWxo2zZlIR9akBa
 IWwjRoPnj5ouiNnAbrwqys2DeAD3sOfXxalQU2eqbQjNyzr0lNQj7EzwKbFxWJD/UVSV
 nZ34wf0L+/rlScMUZlvRh4vijBcYVpUqgYZao+K/yNpVZE6Br2qzxoKxRtWyChlKQ1IR
 NF1natUlMMjAnOD9eM/MXaUWAtb/TAtIkOC7Bmmp3Y/OBopfHuhiNNHrGB4mOIaCG3eY
 xEZ8l8wYSeU8T4dfpmfqPACJJNWzdVBvo0OqC+V1UILdTuRDYd2hngZ745BMyi/vn+Td
 ma7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790583; x=1744395383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8GtbzYkLZARXf9nEKZuE9rlxGom89KF6nda/xZZhzJc=;
 b=GEH0CYovtmpTSK7EPp2sRfTgpQrAtGUid1kc3Wgd51uXX7cLzCqB80HQ5/DvjZkkGa
 HzkofH7BXUs4V6u7O77JQLO3BbgbXBrmE1kjDGVVA5INIcyPbn5rlcErnu4GeRngeF0f
 Mnu5rO+4k6mphNddsRX57sbdk3rHOkfrCGhCVeQmoPmSqKDAWVyfqIJXXM35tnJh9t9d
 himpfO4Jl9DyYx+ThAUuH4ZpL6MWId+APLCmPGBLB/dbLot6TNSvk/OFP3rV5GPQk5Mc
 yIMyoirsilQH743oXbkOMIW6tC7BPI8kWU0icRvxxdfhASFiSOwrXw0xnVnKUFUFUV+/
 YxFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgWp47NYvHlQvQtBqf4ur1hl+eOnJThgWsD0J0sCyibgX+hHUvh30Y9Bdt1OhoV0W2tBoYGS6yhidg@nongnu.org
X-Gm-Message-State: AOJu0YxUMx0nzPEZa4YQevpFTuzacr9KwK/KMd65jQwQH0RlOQwmSI31
 gdQvx3v12/HJ2Fb0+6WChR17l/QnKX7Pr8wgv8Jwu2p6bSrBakbf6+/Ct65ceGY=
X-Gm-Gg: ASbGncvhoVL14mUeV9W4HzzwODW1jpaXtrardCl+tr6R1TvQCjdKtMCHVieilCmzKZK
 TgRJ3ItHP7MPRakX9ubxBssCgyzhC9CQmYdsmuLXRXyxAiqrUk70gIiz7XdCUcKLQcah2J9ewWV
 nhsht8BhThZ6u0TzC8Em7CZgePwZRWE6qM0elM2EVa+FQjkto5sSPSS+OjAyBw79li5D9l6VIDG
 uivrp8Y79vgqHch2t8Ak2AvcfT8QHa8DlW7t4aR6DoSK/lMKUjhj3g76SnvLxAeW8F21dhG7PN+
 yE2vauRCY5ZPPiCMAu1bvVKcFS+yGBzKXugFwL0+t7ceghn3/kS7N7WGBA==
X-Google-Smtp-Source: AGHT+IHpCYLGtdubmvkDfOj0WzD4l3BkOnd7n35Y+rRWEsrv0YN9dhGFk4PSbRsVJNBmu+m11Cey3g==
X-Received: by 2002:a17:902:fc4e:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22a8a0a37c0mr63749365ad.35.1743790583725; 
 Fri, 04 Apr 2025 11:16:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e109sm35500715ad.147.2025.04.04.11.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:16:23 -0700 (PDT)
Message-ID: <755ac7f4-a9e1-4c80-85d5-c91d9f1a5608@linaro.org>
Date: Fri, 4 Apr 2025 11:16:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 01/39] target/arm: Implement per-binary
 TargetInfo structures
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-2-philmd@linaro.org>
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

T24gNC8zLzI1IDE2OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDEgKw0KPiAgIHRhcmdldC9hcm0vdGFyZ2V0X2luZm8tYWFyY2g2NC1zb2Z0bW11LmMg
fCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gICB0YXJnZXQvYXJtL3RhcmdldF9p
bmZvLWFybS1zb2Z0bW11LmMgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAgdGFyZ2V0L2FybS9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysr
DQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRhcmdldC9hcm0vdGFyZ2V0X2luZm8tYWFyY2g2NC1zb2Z0bW11LmMNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2FybS90YXJnZXRfaW5mby1hcm0tc29mdG1t
dS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KPiBp
bmRleCBiOTMyNTMxNjZjOC4uOWRmNjYyOTMyYTQgMTAwNjQ0DQo+IC0tLSBhL21lc29uLmJ1
aWxkDQo+ICsrKyBiL21lc29uLmJ1aWxkDQo+IEBAIC0zMjYzLDYgKzMyNjMsNyBAQCBob3N0
X2tjb25maWcgPSBcDQo+ICAgaWdub3JlZCA9IFsgJ1RBUkdFVF9YTUxfRklMRVMnLCAnVEFS
R0VUX0FCSV9ESVInLCAnVEFSR0VUX0FSQ0gnIF0NCj4gICANCj4gICB0YXJnZXRfaW5mbyA9
IFsNCj4gKyAgJ2FybS1zb2Z0bW11JywgJ2FhcmNoNjQtc29mdG1tdScsDQo+ICAgXQ0KPiAg
IA0KPiAgIGRlZmF1bHRfdGFyZ2V0cyA9ICdDT05GSUdfREVGQVVMVF9UQVJHRVRTJyBpbiBj
b25maWdfaG9zdA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90YXJnZXRfaW5mby1hYXJj
aDY0LXNvZnRtbXUuYyBiL3RhcmdldC9hcm0vdGFyZ2V0X2luZm8tYWFyY2g2NC1zb2Z0bW11
LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLjAwMmFh
YzY0MmY4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGFyZ2V0L2FybS90YXJnZXRfaW5m
by1hYXJjaDY0LXNvZnRtbXUuYw0KPiBAQCAtMCwwICsxLDI0IEBADQo+ICsvKg0KPiArICog
UUVNVSBsZWdhY3kgYmluYXJ5IGhlbHBlcnMNCj4gKyAqDQo+ICsgKiAgQ29weXJpZ2h0IChj
KSBMaW5hcm8NCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1pbXBsLmgiDQo+ICsjaW5jbHVkZSAiY3B1
LXFvbS5oIg0KPiArDQo+ICtzdGF0aWMgY29uc3QgQmluYXJ5VGFyZ2V0SW5mbyB0YXJnZXRf
aW5mb19hYXJjaDY0X3N5c3RlbSA9IHsNCj4gKyAgICAubmFtZSA9ICJhYXJjaDY0IiwNCj4g
KyAgICAuc3lzdGVtX2FyY2ggPSBTWVNfRU1VX1RBUkdFVF9BQVJDSDY0LA0KPiArICAgIC5l
bmRpYW5uZXNzID0gRU5ESUFOX01PREVfTElUVExFLA0KPiArICAgIC5sb25nX2JpdHMgPSA2
NCwNCj4gKyAgICAuY3B1X3Jlc29sdmluZ190eXBlID0gVFlQRV9BUk1fQ1BVLA0KPiArfTsN
Cj4gKw0KPiArY29uc3QgQmluYXJ5VGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkNCj4g
K3sNCj4gKyAgICByZXR1cm4gJnRhcmdldF9pbmZvX2FhcmNoNjRfc3lzdGVtOw0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90YXJnZXRfaW5mby1hcm0tc29mdG1tdS5jIGIv
dGFyZ2V0L2FybS90YXJnZXRfaW5mby1hcm0tc29mdG1tdS5jDQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi4yNGI2OGIxYWQ4Yg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL3RhcmdldC9hcm0vdGFyZ2V0X2luZm8tYXJtLXNvZnRtbXUuYw0KPiBA
QCAtMCwwICsxLDI0IEBADQo+ICsvKg0KPiArICogUUVNVSBsZWdhY3kgYmluYXJ5IGhlbHBl
cnMNCj4gKyAqDQo+ICsgKiAgQ29weXJpZ2h0IChjKSBMaW5hcm8NCj4gKyAqDQo+ICsgKiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsN
Cj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRf
aW5mby1pbXBsLmgiDQo+ICsjaW5jbHVkZSAiY3B1LXFvbS5oIg0KPiArDQo+ICtzdGF0aWMg
Y29uc3QgQmluYXJ5VGFyZ2V0SW5mbyB0YXJnZXRfaW5mb19hcm1fc3lzdGVtID0gew0KPiAr
ICAgIC5uYW1lID0gImFybSIsDQo+ICsgICAgLnN5c3RlbV9hcmNoID0gU1lTX0VNVV9UQVJH
RVRfQVJNLA0KPiArICAgIC5lbmRpYW5uZXNzID0gRU5ESUFOX01PREVfTElUVExFLA0KPiAr
ICAgIC5sb25nX2JpdHMgPSAzMiwNCj4gKyAgICAuY3B1X3Jlc29sdmluZ190eXBlID0gVFlQ
RV9BUk1fQ1BVLA0KPiArfTsNCj4gKw0KPiArY29uc3QgQmluYXJ5VGFyZ2V0SW5mbyAqdGFy
Z2V0X2luZm8odm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gJnRhcmdldF9pbmZvX2FybV9z
eXN0ZW07DQo+ICt9DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL21lc29uLmJ1aWxkIGIv
dGFyZ2V0L2FybS9tZXNvbi5idWlsZA0KPiBpbmRleCAzMDY1MDgxZDI0MS4uNzA2YzQ5YzFi
MmEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vbWVzb24uYnVpbGQNCj4gKysrIGIvdGFy
Z2V0L2FybS9tZXNvbi5idWlsZA0KPiBAQCAtMjUsNiArMjUsMTEgQEAgYXJtX3N5c3RlbV9z
cy5hZGQoZmlsZXMoDQo+ICAgICAnbWFjaGluZS5jJywNCj4gICAgICdwdHcuYycsDQo+ICAg
KSkNCj4gK2FybV9zeXN0ZW1fc3MuYWRkKHdoZW46ICdUQVJHRVRfQUFSQ0g2NCcsIGlmX3Ry
dWU6IGZpbGVzKA0KPiArICAndGFyZ2V0X2luZm8tYWFyY2g2NC1zb2Z0bW11LmMnLA0KPiAr
KSwgaWZfZmFsc2U6IGZpbGVzKA0KPiArICAndGFyZ2V0X2luZm8tYXJtLXNvZnRtbXUuYycs
DQo+ICspKQ0KPiAgIA0KDQpVc2luZyBhIGRpY3Rpb25hcnkgZm9yIGtlZXBpbmcgdGFyZ2V0
X2luZm8gc291cmNlIGZpbGVzLCB3ZSBhdm9pZCB0aGlzIA0KaWYsIGl0IHdpbGwgYmVjb21l
Og0KdGFyZ2V0X2luZm8gKz0geydhYXJjaDY0LXNvZnRtbXUnOiBbdGFyZ2V0X2luZm8tYWFy
Y2g2NC1zb2Z0bW11LmNdfQ0KdGFyZ2V0X2luZm8gKz0geydhcm0tc29mdG1tdSc6IFt0YXJn
ZXRfaW5mby1hcm0tc29mdG1tdS5jXX0NCg0KPiAgIGFybV91c2VyX3NzID0gc3Muc291cmNl
X3NldCgpDQo+ICAgDQoNCg==

